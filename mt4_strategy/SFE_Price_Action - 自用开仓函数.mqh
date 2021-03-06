
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#include <main_1/trade_.mqh>
Trade tra_ord;//开平仓 类对象

class SFE_Price_Action
  {
  
public  :
   void              Trade_Main(string sym);
                     SFE_Price_Action();
private :
                     
   int               Judge_ATR(string sym);
   int               BuyCount(int Magic,string sym);
   int               SellCount(int Magic,string sym);
   int               Judge_Atr(string sym);
   double            Find_Low(int num,string sym);
   double            Find_High(int num,string sym);

private :

   double            lot;
   double            ratio;
   double            sec_ratio;
   double            highest_price;
   double            lowest_price;
   double            buy_half_judge,sell_half_judge;
   
   int               sl;
   int               A_first_trailing_sl;
   int               tp;
   int               distance;
   int               ATR_lookback_num;
   int               ATR_period;
   int               sl_level_K_num;
   int               fastMA_period;
   int               slowMA_period;
   int               K_num_to_delete_pending;
   int               magic_A;
   int               magic_B;
   int               last_K_trend;
   int               A_first_trailing;
   int               A_sec_trailing;
   int               A_half_trailing;
   int               A_half_tp;
   int               RollBack;
   int               trend;
   int               last_num;
   int               breakeven;
   int               tp_judge;
   int               day_flag;
   
   bool              A_sell_half_close;
   bool              A_buy_half_close;
   bool              B_sell_close_flag;
   bool              B_buy_close_flag;
   
   string            comment;

  } ;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SFE_Price_Action :: SFE_Price_Action(void)
{
   lot = 2.0;
   ratio = 0.34;
   sec_ratio = 0.382;
   sl = 40;
   A_first_trailing_sl = 20;
   tp = 180;
   distance = 5;
   ATR_lookback_num = 7;
   ATR_period = 1;
   sl_level_K_num = 7;
   fastMA_period = 20;
   slowMA_period = 100;
   K_num_to_delete_pending = 7;
   magic_A = 123;
   magic_B = 321;
   last_K_trend = 40;
   A_first_trailing = 20;
   A_sec_trailing = 40;
   A_half_trailing = 60;
   A_half_tp = 160;
   RollBack = 30;
   trend = 60;
   last_num = 7;
   breakeven = 40;
   tp_judge = 100;
   comment = "SFE";
   day_flag = 0;
   highest_price = 0;
   lowest_price = 99999;
   buy_half_judge = 0;
   sell_half_judge =0;
   A_sell_half_close = False;
   A_buy_half_close = False;
   B_sell_close_flag = False;
   B_buy_close_flag = False;
   
}
//+------------------------------------------------------------------+
//| 交易主函数                                                                 |
//+------------------------------------------------------------------+
void SFE_Price_Action :: Trade_Main(string sym)
  {
    double  ask = MarketInfo(sym,MODE_ASK);
    double  bid = MarketInfo(sym,MODE_BID);
    double  point = MarketInfo(sym,MODE_POINT);
    double  open_1 = iOpen(sym,0,1); 
    double  close_1 = iClose(sym,0,1);
    int     digits = int(MarketInfo(sym,MODE_DIGITS));
    datetime   time_0 = iTime(sym,0,0);
     
   int result_1,result_2,result_3,result_4,result_5,result_6,result_8,result_9,result_11,result_12;
   int atr=Judge_Atr(sym);
   for(int i=2;i<=last_num+1;i++)
     {
      if(Day()!=day_flag && iHigh(sym,0,i)>iHigh(sym,0,i-1) && iHigh(sym,0,i)>iHigh(sym,0,i+1) && iHigh(sym,0,i)-close_1>=trend*10*point && bid<iMA(sym,0,slowMA_period,0,MODE_SMA,PRICE_CLOSE,0) && bid<iMA(sym,0,fastMA_period,0,MODE_SMA,PRICE_CLOSE,0) && SellCount(magic_A,sym)==0 && open_1-close_1>last_K_trend*10*point && atr==1 && close_1-iLow(sym,0,1)<(iHigh(sym,0,1)-iLow(sym,0,1))*ratio)
        {
         double buy_stop_price=NormalizeDouble(iHigh(sym,0,i)-(iHigh(sym,0,i)-close_1)/2,digits);
         double buystop_sl=Find_Low(sl_level_K_num,sym);
         sell_half_judge=Find_High(last_num,sym);
         result_1=OrderSend(sym,OP_SELL,lot,bid,30,bid+sl*10*point,bid-tp*10*point,comment,magic_A,0,Red);
         day_flag=Day();
         result_2=OrderSend(sym,OP_BUYSTOP,lot,buy_stop_price,3000,buystop_sl,0,comment,magic_B,time_0+3600*K_num_to_delete_pending,Green);
      
        }
      if(Day()!=day_flag && iLow(sym,0,i)<iLow(sym,0,i-1) &&iLow(sym,0,i)<iLow(sym,0,i+1) && close_1-iLow(sym,0,i)>=trend*10*point && ask>iMA(sym,0,slowMA_period,0,MODE_SMA,PRICE_CLOSE,0) && ask>iMA(sym,0,fastMA_period,0,MODE_SMA,PRICE_CLOSE,0) && BuyCount(magic_A,sym)==0 && close_1-open_1>last_K_trend*10*point && atr==1 && iHigh(sym,0,1)-close_1<(iHigh(sym,0,1)-iLow(sym,0,i))*ratio)
        {
         double sell_stop_price=NormalizeDouble(iLow(sym,0,i)+(close_1-iLow(sym,0,i))/2,digits);
         double sellstop_sl=Find_High(sl_level_K_num,sym);
         buy_half_judge=Find_Low(last_num,sym);
         result_3=OrderSend(sym,OP_BUY,lot,ask,30,ask-sl*10*point,ask+tp*10*point,comment,magic_A,0,Blue);
         day_flag=Day();
         result_4=OrderSend(sym,OP_SELLSTOP,lot,sell_stop_price,3000,sellstop_sl,0,comment,magic_B,time_0+3600*K_num_to_delete_pending,Yellow);
        }
     }
   for(int h=OrdersTotal();h>=0;h--)
     {
      if(OrderSelect(h,SELECT_BY_POS,MODE_TRADES)==True)
        {
         if(OrderType()==OP_SELL && OrderMagicNumber()==magic_B && OrderLots()==lot)
           {
            if(OrderOpenPrice()-ask>breakeven*10*point && OrderStopLoss()>OrderOpenPrice())
              {
               result_5=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Green);
              }
            if(OrderOpenPrice()-ask>tp_judge*10*point)
              {
               B_sell_close_flag=True;
              }
           }
         if(OrderType()==OP_SELL && OrderMagicNumber()==magic_A && OrderLots()==lot)
           {
            if(OrderOpenPrice()-ask>A_first_trailing*10*point && OrderStopLoss()>OrderOpenPrice()+A_first_trailing_sl*10*point)
              {
               result_6=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+A_first_trailing_sl*10*point,OrderTakeProfit(),0,Green);
              }
            if(OrderOpenPrice()-ask>A_sec_trailing*10*point)
              {
               CloseSelecteOrders(sym,magic_A,OP_SELL,lot/2);
              }
           }
         if(OrderType()==OP_BUY && OrderMagicNumber()==magic_B && OrderLots()==lot)
           {
            if(bid-OrderOpenPrice()>breakeven*10*point && OrderStopLoss()<OrderOpenPrice())
              {
               result_8=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,Green);
              }
            if(bid-OrderOpenPrice()>tp_judge*10*point)
              {
               B_buy_close_flag=True;
              }
           }
         if(OrderType()==OP_BUY && OrderMagicNumber()==magic_A && OrderLots()==lot)
           {
            if(bid-OrderOpenPrice()>A_first_trailing*10*point && OrderStopLoss()<OrderOpenPrice()-A_first_trailing_sl*10*point)
              {
               result_9=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-A_first_trailing_sl*10*point,OrderTakeProfit(),0,Green);
              }
            if(bid-OrderOpenPrice()>A_sec_trailing*10*point)
              {
               CloseSelecteOrders(sym,magic_A,OP_BUY,lot/2);
              }
           }
         if(OrderType()==OP_BUY && OrderMagicNumber()==magic_A && OrderLots()==lot/2)
           {
            if(bid-OrderOpenPrice()>A_half_trailing*10*point && OrderStopLoss()<OrderOpenPrice())
              {
               result_11=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderOpenPrice()+A_half_tp*10*point,0,Green);
               A_buy_half_close=True;
              }
            if(A_buy_half_close==True && close_1<highest_price-(highest_price-buy_half_judge)*sec_ratio)CloseSelecteOrders(sym,magic_A,OP_BUY,lot/2);
           }
         if(OrderType()==OP_SELL && OrderMagicNumber()==magic_A && OrderLots()==lot/2)
           {
            if(OrderOpenPrice()-ask>A_half_trailing*10*point && OrderStopLoss()>OrderOpenPrice())
              {
               result_12=OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderOpenPrice()-A_half_tp*10*point,0,Green);
               A_sell_half_close=True;
              }
            if(A_sell_half_close==True && close_1>lowest_price+(sell_half_judge-lowest_price)*sec_ratio)CloseSelecteOrders(sym,magic_A,OP_SELL,lot/2);
           }
        }
     }
   if(B_sell_close_flag==True && close_1>iMA(sym,0,slowMA_period,0,MODE_SMA,PRICE_CLOSE,1))CloseSelecteOrders(sym,magic_B,OP_SELL,lot);
   if(B_buy_close_flag==True && close_1<iMA(sym,0,slowMA_period,0,MODE_SMA,PRICE_CLOSE,1))CloseSelecteOrders(sym,magic_B,OP_BUY,lot);
   if(BuyCount(magic_A,sym)>0 && bid>highest_price)highest_price=bid;
   if(SellCount(magic_A,sym)>0 && ask<lowest_price)lowest_price=ask;
   if(BuyCount(magic_B,sym)==0)B_buy_close_flag=False;
   if(SellCount(magic_B,sym)==0)B_sell_close_flag=False;
   if(BuyCount(magic_A,sym)==0)
     {
      A_buy_half_close=False;
      highest_price=0;
     }
   if(SellCount(magic_A,sym)==0)
     {
      A_sell_half_close=False;
      lowest_price=99999;
     }
  }
//+------------------------------------------------------------------+
//|  计算多单单数
//+------------------------------------------------------------------+
int SFE_Price_Action :: BuyCount(int Magic,string sym)
  {
   int a=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         if(OrderSymbol()==sym && OrderType()==OP_BUY && OrderMagicNumber()==Magic)
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
int SFE_Price_Action :: SellCount(int Magic,string sym)
  {
   int a=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         if(OrderSymbol()==sym && OrderType()==OP_SELL && OrderMagicNumber()==Magic)
           {
            a++;
           }
        }
     }
   return(a);
  }
//+------------------------------------------------------------------+
//|  计算近7根K线低点
//+------------------------------------------------------------------+
double SFE_Price_Action :: Find_Low(int num,string sym)
  {
   double a=99999.0;
   for(int i=1;i<=num;i++)
     {
      if(iLow(sym,0,i)<a)
        {
         a=iLow(sym,0,i);
        }
     }
   return a;
  }
//+------------------------------------------------------------------+
//|  计算近7根K线高点
//+------------------------------------------------------------------+
double SFE_Price_Action :: Find_High(int num,string sym)
  {
   double a=0;
   for(int i=1;i<=num;i++)
     {
      if(iHigh(sym,0,i)>a)
        {
         a=iHigh(sym,0,i);
        }
     }
   return a;
  }
//+------------------------------------------------------------------+
//|  选择平仓
//+------------------------------------------------------------------+
void CloseSelecteOrders(string symbol,int magic,int ordertype,double orderlot)
  {
   int result,total=OrdersTotal();
   for(int cnt=total-1;cnt>=0;cnt--)
     {
      if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         if(OrderMagicNumber()==magic && OrderSymbol()==Symbol() && OrderType()==ordertype)
           {
            if(ordertype==OP_BUY)
              {
               result=OrderClose(OrderTicket(),orderlot,Bid,3);
              }
            if(ordertype==OP_SELL)
              {
               result=OrderClose(OrderTicket(),orderlot,Ask,3);
              }
           }
     }
  }
//+------------------------------------------------------------------+
//|  判断ATR是否满足条件
//+------------------------------------------------------------------+
int SFE_Price_Action :: Judge_Atr(string sym)
  {
   int a=1;
   for(int i=2;i<=ATR_lookback_num+1;i++)
     {
      if(iATR(sym,0,ATR_period,1)<iATR(sym,0,1,i)*2)
        {
         a=0;
         break;
        }
     }
   return a;
  }
//+------------------------------------------------------------------+
