#property copyright "Copyright 2016, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

class Versper
{
public :
   void Trade_Main(string sym);
    Versper();   
private:
  
   int order_send_buy(string sym,double lots,int magic);
   int order_send_sell(string sym,double lots,int magic);
   double buy_open_limit(string sym);
   double sell_open_limit(string sym);
   void CloseSelecteOrders(string sym,int magic,int ordertype);
   int CloseCalculateLots(string sym,int Type,int magic); 
   double sell_close_limit(string sym); 
   double buy_close_limit(string sym);
   int Counting(string sym); 
   double CalculateNetLots(string sym,int magic);
   
private:

   double Lot;
   int level;
   int K_num;
   int K_limit_open;
   int K_limit_close;
   double percentage_open;
   double percentage_close;
   int TrailingStop;
   int MinProfit;
   int RollBack;
   int local_magic;
   string comment;    

} Versper_Strategy ;


Versper :: Versper(void)
{
   Lot=1.0;
   level=10;
   K_num=216;
   K_limit_open=216;
   K_limit_close=216;
   percentage_open=0.01;
   percentage_close=0.6;
   TrailingStop=50;
   MinProfit=20;
   RollBack=30;
   local_magic=25;
   comment="Vesper";
}


void Versper:: Trade_Main(string sym)
{
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   string symbol=sym;  
   int result3,result4;
   double retRemote = Counting(sym);
   double retLocal = CalculateNetLots(sym,local_magic);
   double BalanceLots = retRemote - retLocal*level*(1/Lot);
   double buy_open_limit=buy_open_limit(sym);
   double sell_open_limit=sell_open_limit(sym);
   double buy_close_limit=buy_close_limit(sym);
   double sell_close_limit=sell_close_limit(sym);
   if(BalanceLots >= level && retLocal>=0 && ask>buy_open_limit)
   {
   order_send_buy(symbol,Lot,local_magic);           
   }
   if(BalanceLots >= level && retLocal<0)
   {
   CloseCalculateLots(symbol,OP_SELL,local_magic);
   }
   if(BalanceLots <=-level && retLocal>0)
   {
   CloseCalculateLots(symbol,OP_BUY,local_magic);
   }
   if(BalanceLots <=-level && retLocal<=0 && bid<sell_open_limit)
   {
   order_send_sell(symbol,Lot,local_magic);
   }
   if(retRemote == 0)
   {
   CloseSelecteOrders(symbol,local_magic,OP_BUY);
   CloseSelecteOrders(symbol,local_magic,OP_SELL);
   }  
   if(bid<buy_close_limit)
   {
   CloseSelecteOrders(symbol,local_magic,OP_BUY);
   }  
   if(ask>sell_close_limit)
   {
   CloseSelecteOrders(symbol,local_magic,OP_SELL);
   }
   for(int cnt=OrdersTotal();cnt>=0;cnt--)
   {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES)==True)
      {      
       if(OrderType()==OP_SELL && OrderMagicNumber()==local_magic && OrderSymbol() == sym ) 
         {                                        
          if((OrderOpenPrice()-MarketInfo(sym,MODE_ASK))>MarketInfo(sym,MODE_POINT)*10*TrailingStop)
            {
             if((OrderStopLoss()>MarketInfo(sym,MODE_ASK)+MarketInfo(sym, MODE_POINT)*10*RollBack) || OrderStopLoss()==0)
               {
                result3=OrderModify(OrderTicket(),OrderOpenPrice(),MarketInfo(sym, MODE_ASK)+MarketInfo(sym, MODE_POINT)*10*MinProfit,OrderTakeProfit(),0,Red);                                        
               }
            }
         }
       if(OrderType()==OP_BUY && OrderMagicNumber()==local_magic && OrderSymbol() == sym)
         {                
          if(MarketInfo(sym,MODE_BID)-OrderOpenPrice()>MarketInfo(sym,MODE_POINT)*10*TrailingStop)
            {
             if((OrderStopLoss()<MarketInfo(sym,MODE_BID)-MarketInfo(sym,MODE_POINT)*10*RollBack) || OrderStopLoss()==0)
               {
                result4=OrderModify(OrderTicket(),OrderOpenPrice(),MarketInfo(sym, MODE_BID)-MarketInfo(sym, MODE_POINT)*10*MinProfit,OrderTakeProfit(),0,Green);
               }
            }
         }
      }
   }

}   
//+------------------------------------------------------------------+
//|  开多单
//+------------------------------------------------------------------+
int Versper:: order_send_buy(string sym,double lots,int magic)
{
   double  ask = MarketInfo(sym,MODE_ASK);
   int ticket=OrderSend(sym,OP_BUY,lots,ask,3,0,0,comment,magic,0,Blue);
   if(ticket>0)
     {
      if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
         Print("BUY order opened : ",OrderOpenPrice());
     }
   else
      Print("Error opening  BUY order : ",GetLastError());
   return ticket;
}
//+------------------------------------------------------------------+
//|  开空单
//+------------------------------------------------------------------+
int Versper:: order_send_sell(string sym,double lots,int magic)
{
   double  bid = MarketInfo(sym,MODE_BID);   
   int ticket=OrderSend(sym,OP_SELL,lots,bid,3,0,0,comment,magic,0,Red);
   if(ticket>0)
     {
      if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
         Print("SELL order opened : ",OrderOpenPrice());
     }
   else
      Print("Error opening SELL order : ",GetLastError());
   return ticket;
}
//+------------------------------------------------------------------+
//|  统计多单开仓区间
//+------------------------------------------------------------------+  
double Versper:: buy_open_limit(string sym) 
{
   int a=iHighest(sym,15,MODE_HIGH,K_limit_open,0);
   int b=iLowest(sym,15,MODE_LOW,K_limit_open,0);
   double c=iHigh(sym,15,a);
   double d=iLow(sym,15,b);
   double e=c-(c-d)*percentage_open;
   return e;
}
//+------------------------------------------------------------------+
//|   统计空单开仓区间
//+------------------------------------------------------------------+  
double Versper:: sell_open_limit(string sym) 
{
   int a=iHighest(sym,15,MODE_HIGH,K_limit_open,0);
   int b=iLowest(sym,15,MODE_LOW,K_limit_open,0);
   double c=iHigh(sym,15,a);
   double d=iLow(sym,15,b);
   double e=d+(c-d)*percentage_open;
   return e;
}
//+------------------------------------------------------------------+
//|  统计多单平仓区间
//+------------------------------------------------------------------+  
double Versper:: buy_close_limit(string sym) 
{
   int a=iHighest(sym,15,MODE_HIGH,K_limit_close,0);
   int b=iLowest(sym,15,MODE_LOW,K_limit_close,0);
   double c=iHigh(sym,15,a);
   double d=iLow(sym,15,b);
   double e=c-(c-d)*percentage_close;
   return e;
}
//+------------------------------------------------------------------+
//|   统计空单平仓区间
//+------------------------------------------------------------------+  
double Versper:: sell_close_limit(string sym) 
{
   int a=iHighest(sym,15,MODE_HIGH,K_limit_close,0);
   int b=iLowest(sym,15,MODE_LOW,K_limit_close,0);
   double c=iHigh(sym,15,a);
   double d=iLow(sym,15,b);
   double e=d+(c-d)*percentage_close;
   return e;
}
//+------------------------------------------------------------------+
//|  统计K线阴阳个数
//+------------------------------------------------------------------+  
int Versper:: Counting(string sym) 
{
   int count=0;
   for(int i=K_num;i>0;i--) 
      {
       if(iOpen(sym,15,i)<iClose(sym,15,i))count=count+1;
       if(iOpen(sym,15,i)>iClose(sym,15,i))count=count-1;
      }
   return count;
}
double Versper:: CalculateNetLots(string sym,int magic)
    {
     double lots = 0;
     int i;
     for (i = OrdersTotal() - 1; i >= 0; i--)
         {
          if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
          {
            if (OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic) 
            {
             lots=lots+OrderLots();
            }
            if (OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic) 
            {
             lots=lots-OrderLots();
            }
          }
         }
      return lots;   
    }
int Versper:: CloseCalculateLots(string sym,int Type,int magic)
{  
   int result;
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   double  point = MarketInfo(sym,MODE_POINT);
   for (int i = 0; i < OrdersTotal(); i++)
       {
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES) == true)
          {
           if (OrderMagicNumber() == magic && OrderSymbol() == sym && OrderType() == Type )
              {
               if(Type == OP_BUY)
                 {
                   result=OrderClose(OrderTicket(),OrderLots(),bid ,3,Yellow);
                   break;
                 }
               if(Type == OP_SELL)
                 {
                  result=OrderClose(OrderTicket(),OrderLots(),ask,3,Yellow);
                  break;
                 }
              }
          }
       }
    return (0);
}
//+------------------------------------------------------------------+
//|  选择平仓
//+------------------------------------------------------------------+
void Versper:: CloseSelecteOrders(string sym,int magic,int ordertype)
{
   double  ask = MarketInfo(sym,MODE_ASK);
   double  bid = MarketInfo(sym,MODE_BID);
   double  point = MarketInfo(sym,MODE_POINT);
   
  int result,total=OrdersTotal();
  for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
       if(OrderMagicNumber()==magic && OrderSymbol()==sym && OrderType()==ordertype)
       {
         if(ordertype == OP_BUY)
         {
           result=OrderClose(OrderTicket(),OrderLots(),bid ,3,Yellow);
         }
        if(ordertype == OP_SELL)
         {
           result=OrderClose(OrderTicket(),OrderLots(),ask,3,Yellow);
         }
       }
  }
}