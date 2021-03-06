//+------------------------------------------------------------------+
//|                                                     市场部-要求策略.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <main_1/trade_.mqh>
Trade tra_ord;// 开平仓 类对象

class Market_Strategy
{
public :
   void Trade_Main(string sym); 
   Market_Strategy();
   
private :
   
   double LastOrderOpenPrice(int orderType, string sym, int magic);
   double LastOrderOpenLot(int orderType, string sym, int magic);
   double Highest_Profit_Total(string sym, int magic);
   double Profit_Total(string sym, int magic);
   int Sell_Count (string sym, int magic);
   int Buy_Count (string sym, int magic);
   void Close_All(string sym, int magic);
   double H_L_Price(string sym, int type);
   
   
                  
private : 
   int  Magic_1 ;//策略一magic
   int  Start_Time ;  
   int  End_Time ;
   double  Start_Lot ;
   int Gap_Point ;
   double Martin_Rate ;
   double Trail_Start ;//盈利5美金开始  
   double Trail_stop ; //离最高点 回撤2 美金 出场  
   double Trail_Rate ;
   double Highest_Profit;// 存储 最高的盈利金额
   
   int  Magic_2 ;//策略二magic
   int  Start_Time_2 ;  
   int  End_Time_2 ;
   double  Start_Lot_2 ;
   int Gap_Point_2 ;
   double Martin_Rate_2 ;
   int Time_Range ;
   double Trail_Start_2 ;//盈利5美金开始  
   double Trail_stop_2 ; //离最高点 回撤2 美金 出场    
   double Trail_Rate_2 ; 
   double Highest_Profit_2;// 存储 最高的盈利金额  
   
       

}  M_Strategy ;
Market_Strategy :: Market_Strategy()
{ 
   Magic_1 = 100000;
   Start_Time = 7;  
   End_Time = 15;
   Start_Lot = 0.01;
   Gap_Point = 50;
   Martin_Rate = 2;
   Trail_Start = 5;//盈利5美金开始  
   Trail_stop = 2; //离最高点 回撤2 美金 出场   
   Trail_Rate =2 ;//
   Highest_Profit = 0;
   
   Magic_2 = 2000000;
   Start_Time_2 = 15;  
   End_Time_2 = 2;
   Start_Lot_2 = 0.01 ;
   Gap_Point_2 = 35 ;
   Martin_Rate_2 = 3;
   Time_Range = 12;
   Trail_Start_2 = 5;//盈利5美金开始  
   Trail_stop_2 = 2 ; //离最高点 回撤2 美金 出场  
   Trail_Rate_2 = 2 ;   
   Highest_Profit_2 = 0;
}

void Market_Strategy :: Trade_Main(string sym)
{  
   bool trail_start = false ;
   double Trail_Start_Buy = 0;
   double Trail_Start_Sell = 0;
   double  ask = MarketInfo(sym, MODE_ASK); 
   double  bid = MarketInfo(sym ,MODE_BID); // 平台现价基本都是卖价
   double  point = MarketInfo(sym, MODE_POINT);
   int time_hour_ = TimeHour( TimeLocal() );
  // int time_minute_ = TimeMinute( TimeLocal() );

   //---策略一  进场   
   if( time_hour_ >= Start_Time && time_hour_ <End_Time )// 北京时间早7点到下午15点。15点后不再开仓
   {                                                                                // 7点开始同时开0.01的多和0.01的空单
   //---第一单进场 
     if( Buy_Count(sym,Magic_1) == 0  )
     {
      tra_ord.MN_OpenTrade(sym, OP_BUY, Start_Lot, ask, 0, 0,NULL, Magic_1, true, 1);
      tra_ord.MN_OpenTrade(sym, OP_SELL, Start_Lot, bid, 0, 0,NULL, Magic_1, true, 1);
     }  
  
   //--- 第一次 加仓
   if(Buy_Count(sym,Magic_1) + Sell_Count(sym, Magic_1) == 2 )
   {
     if( LastOrderOpenPrice(OP_SELL, sym, Magic_1) -bid >= Gap_Point * point )   //第一次加仓，向下35点加2倍多单
       {
       
       tra_ord.MN_OpenTrade(sym, OP_BUY, Start_Lot*Martin_Rate, ask, 0, 0, NULL, Magic_1, true, 1);
       
       }
     if( bid - LastOrderOpenPrice(OP_SELL, sym, Magic_1) >= Gap_Point * point )   //第一次加仓，向上35点加2倍空单
       {
       
       tra_ord.MN_OpenTrade(sym, OP_SELL, Start_Lot*Martin_Rate, bid, 0, 0, NULL, Magic_1, true, 1);
       
       }  
   }
   //---第二次及以上 多单加仓
   if( Buy_Count(sym, Magic_1) >=2  )
   {
   //--- 加仓
     if( LastOrderOpenPrice(OP_BUY, sym, Magic_1) -bid  >= Gap_Point*point &&  trail_start == false )   
       {
       
       tra_ord.MN_OpenTrade(sym, OP_BUY, LastOrderOpenLot(OP_BUY,sym,Magic_1)*Martin_Rate, ask, 0, 0, NULL, Magic_1, true, 1);
       
       }
   //--- 移动止损出场
    if(Buy_Count(sym, Magic_1) == 2 ) Trail_Start_Buy = Trail_Start; // 每加仓一次，移动止损的数值也是2倍倍增 
    if(Buy_Count(sym, Magic_1) > 2 )  Trail_Start_Buy=( Buy_Count(sym, Magic_1)- 2 ) * Trail_Rate * Trail_Start;
    
     if(  Profit_Total(sym, Magic_1) >= Trail_Start_Buy )//单子总计盈利5美金 启动移动止损 
       {
        trail_start = true;
        
        if( Highest_Profit_Total(sym, Magic_1) - Profit_Total(sym, Magic_1) >= Trail_stop )//离最高价 回撤2美金
       
          {       
            Close_All(sym, Magic_1);
            trail_start = false ;
          }
       
       } 
       
    }
    //---第二次及以上 空单加仓
   if( Sell_Count(sym, Magic_1) >=2  )
   {
     if( bid - LastOrderOpenPrice(OP_SELL, sym,Magic_1) >= Gap_Point*point && trail_start == false )   
       {
       
       tra_ord.MN_OpenTrade(sym, OP_SELL, LastOrderOpenLot(OP_SELL,sym,Magic_1)*Martin_Rate, bid, 0, 0, NULL, Magic_1, true, 1);
       
       }
     if(Sell_Count(sym, Magic_1) == 2 ) Trail_Start_Sell = Trail_Start; // 每加仓一次，移动止损的数值也是2倍倍增 
     if(Sell_Count(sym, Magic_1) > 2 )  Trail_Start_Sell=( Sell_Count(sym, Magic_1)- 2 ) * Trail_Rate * Trail_Start; 
     
     if(Profit_Total(sym, Magic_1) >= Trail_Start_Sell )//单子总计盈利5美金 启动移动止损 回撤2美金
       {  
                                                                                  
        trail_start = true;
        if( Highest_Profit_Total(sym, Magic_1) - Profit_Total(sym, Magic_1) >= Trail_stop )
       
          {       
            Highest_Profit = 0;
            Close_All(sym, Magic_1);
            trail_start = false ;
          }
       
       }    
         
    }
   }
    //---策略二 进场 
   bool trail_start_2 = false ;
   double Trail_Start_Buy_2 = 0;
   double Trail_Start_Sell_2 = 0;
   
   if( time_hour_ >= Start_Time_2 && time_hour_ < End_Time_2  )// 北京时间早7点到下午15点。15点后不再开仓
   { 
   //---第一单进场
    if(bid >= H_L_Price(sym, 0) && Sell_Count(sym,Magic_2) == 0 )
    {
      
     tra_ord.MN_OpenTrade(sym, OP_SELL, Start_Lot, bid, 0, 0,NULL, Magic_2, true, 1);
  
    }
     if(bid <= H_L_Price(sym, 1) && Buy_Count(sym,Magic_2) == 0 )
    {
    
    tra_ord.MN_OpenTrade(sym, OP_BUY, Start_Lot_2, ask, 0, 0,NULL, Magic_2, true, 1);      
      
    }   
   //---加仓进场
         if( LastOrderOpenPrice(OP_SELL, sym, Magic_2) -bid >= Gap_Point_2 * point && trail_start_2 == false)   //第一次加仓，向下35点加2倍多单
       {
       
       tra_ord.MN_OpenTrade(sym, OP_BUY, LastOrderOpenLot(OP_BUY,sym,Magic_2)*Martin_Rate_2, ask, 0, 0, NULL, Magic_2, true, 1);
       
       }
     if( bid - LastOrderOpenPrice(OP_SELL, sym, Magic_2) >= Gap_Point_2 * point && trail_start_2 == false)   //第一次加仓，向上35点加2倍空单
       {
       
       tra_ord.MN_OpenTrade(sym, OP_SELL, LastOrderOpenLot(OP_SELL,sym,Magic_2)*Martin_Rate_2, bid, 0, 0, NULL, Magic_2, true, 1);
       
       }  
   //---移动止损出场       
    
     if(Sell_Count(sym, Magic_2) == 2 ) Trail_Start_Sell_2 = Trail_Start_2; // 每加仓一次，移动止损的数值也是2倍倍增 
     if(Sell_Count(sym, Magic_2) > 2 )  Trail_Start_Sell_2=( Sell_Count(sym, Magic_2)- 2 ) * Trail_Rate_2 * Trail_Start_2; 
     
     if(Profit_Total(sym, Magic_2) >= Trail_Start_Sell_2 )//单子总计盈利5美金 启动移动止损 回撤2美金
       {  
                                                                                  
        trail_start_2 = true;
        
        if( Highest_Profit_Total(sym, Magic_2) - Profit_Total(sym, Magic_2) >= Trail_stop_2 )
       
          {       
            Highest_Profit_2 = 0;
            Close_All(sym, Magic_2);
            trail_start_2 = false ;
          }
       
       }    
   }
   
   
   
} 
//+------------------------------------------------------------------+
//|  N个小时内的 新高 新低
//+------------------------------------------------------------------+
double  Market_Strategy :: H_L_Price(string sym, int type )
{
   double price_ = 0;
   
   if(type == 0)
   { 
   int i_num = iHighest(sym, PERIOD_H1, MODE_HIGH, Time_Range, 1);
   price_ = iHigh(sym,PERIOD_H1,Time_Range);  
   }
   if(type == 1)
   { 
   int i_num = iLowest(sym, PERIOD_H1, MODE_LOW, Time_Range, 1);
   price_ = iLow(sym, PERIOD_H1, Time_Range);  
   }

   return( price_ );

}
//+------------------------------------------------------------------+
//|  平所有订单
//+------------------------------------------------------------------+
void Market_Strategy :: Close_All(string sym, int magic)
{
   int result;
   int t=OrdersTotal();
   for( int i=t-1; i>=0; i-- )
     {
     
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {

         if(OrderSymbol()==sym && OrderType()==OP_SELL && OrderMagicNumber()==magic)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),300,Green);
           }

         if(OrderSymbol()==sym && OrderType()==OP_BUY && OrderMagicNumber()==magic)
           {
            result=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),300,Red);
           }

        }
        
     }
}
//+------------------------------------------------------------------+
//|  最后一个订单的开仓价 
//+------------------------------------------------------------------+
double Market_Strategy :: LastOrderOpenPrice(int orderType, string sym, int magic)
{
   datetime orderOpenTime = 0;
   double orderPrice = 0;
   for(int cnt=0; cnt < OrdersTotal(); cnt++)
     {
      if(!OrderSelect( cnt, SELECT_BY_POS ) ) continue;

      if(OrderType() == orderType && OrderMagicNumber() == magic && OrderSymbol() == sym)
        {
        
         if(orderOpenTime < OrderOpenTime())
           {
            orderOpenTime = OrderOpenTime();
            orderPrice = OrderOpenPrice();
           }
           
        }
        
      }
   return(orderPrice);
}

//+------------------------------------------------------------------+
//|  最后一个订单的开仓手数 
//+------------------------------------------------------------------+
double Market_Strategy :: LastOrderOpenLot(int orderType, string sym, int magic)
{
   datetime orderOpenTime = 0;
   double orderlot = 0;
   for(int cnt=0; cnt < OrdersTotal(); cnt++)
     {
      if(!OrderSelect( cnt, SELECT_BY_POS ) ) continue;

      if(OrderType() == orderType && OrderMagicNumber() == magic && OrderSymbol() == sym)
        {
        
         if(orderOpenTime < OrderOpenTime())
           {
            orderOpenTime = OrderOpenTime();
            orderlot = OrderLots();
           }
           
        }
        
      }
   return(orderlot);                                                           
}
//+------------------------------------------------------------------+
// 返回订单最大的最大盈利值（金额）
//+------------------------------------------------------------------+
double Market_Strategy :: Highest_Profit_Total(string sym, int magic)
  {
 
  if( Profit_Total(sym, magic) > Highest_Profit)
     {
         Highest_Profit = Profit_Total(sym, magic);
     } 
     
   return(Highest_Profit);

  } 
//+------------------------------------------------------------------+
// 返回当前订单盈利金融（以金额表示）
//+------------------------------------------------------------------+
double Market_Strategy :: Profit_Total(string sym, int magic)
  {
   double ProfitSum = 0;
   
   for( int i = 0; i < OrdersTotal(); i++ )
     {
     
      if( OrderSelect( i, SELECT_BY_POS, MODE_TRADES ) == true )
        {
         if( OrderSymbol() == sym && OrderMagicNumber() == magic )
           {
            ProfitSum += OrderProfit();
           }

        }
        
     }
   return(ProfitSum);

  }  
//+------------------------------------------------------------------+
//|  计算多单单数
//+------------------------------------------------------------------+
int Market_Strategy :: Buy_Count(string sym, int magic)
  {
   int a=0;
   
   for(int i=0;i<OrdersTotal();i++)
     {
     
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
        
         if(OrderSymbol() == sym && OrderType( )== OP_BUY && OrderMagicNumber() == magic)
           {
            a++;
           }
           
        }
        
     }
   return(a);
  }
//+------------------------------------------------------------------+
//|  计算空单单数
//+------------------------------------------------------------------+
int Market_Strategy :: Sell_Count (string sym, int magic)
  {
   int a=0;
   
   for(int i=0;i<OrdersTotal();i++)
     {
     
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
        
         if(OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic)
           {
            a++;
           }
           
        }
        
     }
   return(a);
  }  