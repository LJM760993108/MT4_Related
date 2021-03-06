//+------------------------------------------------------------------+
//|                                                    harvester.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#define MAGICMA  20170526

class Harvester
{
public:
   void Main_Trade(string sym);
   Harvester()
   {
   Lots = 0.01;
   step_space=70; 
   stop_loss =10000; 
   first_space=35; 
   buy_frequency=1;   
   sell_frequency=1;  
   buy_ticket_first=0;
   sell_ticket_first=0;
   layers_lots=0;
   buy_opens=0;
   sell_opens=0;   
   per_layer_counts=5;
   time_flag=0;
   comment="收割机";   
   
   }
private:
   void CheckForOpen(string symbol,double lots,double TP,int magic);
   void Order_Send_Buy(string symbol,double lots,double TP,int magic);
   void Order_Send_Sell(string symbol,double lots,double TP,int magic);
   void CheckForClose(string symbol,int magic);
   double CalculateProfit( string symbol, int ordertype);
   double hcount_trades( string symbol,int ordertype);
   double CalculateLots( string symbol,int ordertype);
   int count_trades( string symbol,int ordertype);
   int    CloseSelecteOrders(string symbol,int magic,int ordertype);
   double FindMaxOrderPrice(string symbol,int magic,int ordertype);
   double FindMinOrderPrice(string symbol,int magic,int ordertype);
   double ProfitOptimized(string symbol , int order_count);
   double LotsOptimized(int order_count);
   
   
   
private:

double   Lots ;
int      step_space; 
int      stop_loss ; 
int      first_space; 
int      buy_frequency;   
int      sell_frequency;  
double   buy_open_price_flag;
double   sell_open_price_flag;
double   buy_ticket_first;
double   sell_ticket_first;
double   layers_lots;
int      buy_opens;
int      sell_opens;
int      per_layer_counts;
datetime time_flag;
string   comment;
      


}harvseter_strategy;


void Harvester::Main_Trade(string sym)
{
   string symbol = sym;
   double lots = Lots;
   double TP = 75;
   CheckForOpen( symbol, lots, TP, MAGICMA );
   CheckForClose( symbol, MAGICMA);
}


//+------------------------------------------------------------------+
//|  开仓函数
//+------------------------------------------------------------------+
void Harvester::CheckForOpen(string symbol,double lots,double TP,int magic)
{
   double iopen = iOpen(symbol,PERIOD_H1,0);
   int buy_trades = count_trades( symbol, OP_BUY);
   int sell_trades = count_trades( symbol, OP_SELL);
   double atr = iATR(symbol,PERIOD_D1,14,1);
   double space = atr/MarketInfo(symbol,MODE_POINT)/10.0;
   
   double ask = MarketInfo(symbol,MODE_ASK);
   double bid = MarketInfo(symbol,MODE_BID);
   double point = MarketInfo(symbol,MODE_POINT);
   
   if(space<step_space)space = step_space;

   if( sell_ticket_first == 0 && sell_opens < sell_frequency && ask - iopen >= first_space*point && buy_trades < 2 )
      {
         lots = LotsOptimized(sell_trades);
         Order_Send_Sell( symbol, lots, TP, magic);
         sell_opens++;
         if(sell_opens == sell_frequency)
            {
               sell_open_price_flag = FindMaxOrderPrice( symbol, magic, OP_SELL);
               sell_ticket_first = 1;
               sell_opens = 0;
            }
         return;
      }
   if( sell_ticket_first == 1 && sell_opens < sell_frequency && ask - sell_open_price_flag >= space*point )
      {
         lots = LotsOptimized(sell_trades);
         Order_Send_Sell( symbol, lots, TP, magic);
         sell_opens++;
         if(sell_opens == sell_frequency)
            {
               sell_open_price_flag=FindMaxOrderPrice( symbol, magic, OP_SELL);
               sell_opens = 0;
            }
         return;
      }
   if( buy_ticket_first == 0 && buy_opens < buy_frequency && iopen - bid >= first_space*point && sell_trades < 2 )
      {
         lots = LotsOptimized(buy_trades);
         Order_Send_Buy( symbol, lots, TP, magic);
         buy_opens++;
         if(buy_opens == buy_frequency)
            {
               buy_open_price_flag=FindMinOrderPrice( symbol, magic, OP_BUY);
               buy_ticket_first = 1;
               buy_opens = 0;
            }
         return;
      }
   if( buy_ticket_first == 1 && buy_opens < buy_frequency && buy_open_price_flag - bid >= space*point )
      {
         lots = LotsOptimized(buy_trades);
         Order_Send_Buy( symbol, lots, TP, magic);
         buy_opens++;
         if(buy_opens == buy_frequency)
            {
               buy_open_price_flag=FindMinOrderPrice( symbol, magic, OP_BUY);
               buy_opens = 0;
            }
         return;
      }
   
}

//+------------------------------------------------------------------+
//|  开多单
//+------------------------------------------------------------------+
void Harvester::Order_Send_Buy(string symbol,double lots,double TP,int magic)
{
   double ask = MarketInfo(symbol,MODE_ASK);
   int ticket=OrderSend(symbol,OP_BUY,lots,ask,3,0,0,comment,magic,0,Blue);
   if(ticket>0)
     {
      if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
         Print(" BUY order opened : ",OrderOpenPrice());
     }
   else
      Print("Error opening  BUY order : ",GetLastError());
   return;
}
//+------------------------------------------------------------------+
//|  开空单
//+------------------------------------------------------------------+
void Harvester::Order_Send_Sell(string symbol,double lots,double TP,int magic)
{
   double bid = MarketInfo(symbol,MODE_BID);
   int ticket=OrderSend(symbol,OP_SELL,lots,bid,3,0,0,comment,magic,0,Red);
   if(ticket>0)
     {
      if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
         Print("SELL order opened : ",OrderOpenPrice());
     }
   else
      Print("Error opening SELL order : ",GetLastError());
   return;
}


//+------------------------------------------------------------------+
//|  平仓函数
//+------------------------------------------------------------------+
void Harvester::CheckForClose(string symbol,int magic)
{
   double buy_profit = CalculateProfit(symbol,OP_BUY);
   double buy_lots = CalculateLots(symbol,OP_BUY);
   double sell_profit = CalculateProfit(symbol,OP_SELL);
   double sell_lots = CalculateLots(symbol,OP_SELL);
   int buy_trades = count_trades( symbol, OP_BUY);
   int sell_trades = count_trades( symbol, OP_SELL);
   double buy_close = ProfitOptimized(symbol, buy_trades);//买单获利平仓价
   double sell_close = ProfitOptimized(symbol,sell_trades);//买单获利平仓价

   if(buy_trades >0 && buy_profit > buy_lots*buy_close)
      {
         CloseSelecteOrders( symbol, magic, OP_BUY);
      }
   if(sell_trades > 0 && sell_profit > sell_lots*sell_close)
      {
         CloseSelecteOrders( symbol, magic, OP_SELL);
      }
   if( buy_profit <= -stop_loss*Lots*100 )
      {
         CloseSelecteOrders( symbol, magic, OP_BUY);
      }
   if( sell_profit <= -stop_loss*Lots*100 )
      {
         CloseSelecteOrders( symbol, magic, OP_SELL);
      }
   if(buy_lots==0.0)
      {
         buy_ticket_first=0;
      }   
   if(sell_lots==0.0)
      {
         sell_ticket_first=0;
      }
}


//+------------------------------------------------------------------+
//|  计算单方法的收益
//+------------------------------------------------------------------+
double Harvester::CalculateProfit( string symbol, int ordertype) {
   double profit = 0;
   int i,r;
   for (i = OrdersTotal() - 1; i >= 0; i--) {
      r=OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == symbol && OrderType() == ordertype ) profit += OrderProfit();
   }
   return profit;
}


//+------------------------------------------------------------------+
//|  计算单量
//+------------------------------------------------------------------+
double Harvester::CalculateLots( string symbol,int ordertype) {
   double lots = 0;
   int i,r;
   for (i = OrdersTotal() - 1; i >= 0; i--) {
      r=OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == symbol && OrderType() == ordertype ) lots += OrderLots();
   }
   return lots;
}

//+------------------------------------------------------------------+
//|  计算单量
//+------------------------------------------------------------------+
double Harvester::hcount_trades( string symbol,int ordertype) {
   int count = 0;
   int i,r;
   for (i = OrdersTotal() - 1; i >= 0; i--) {
      r=OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == symbol && OrderType() == ordertype ) count++;
   }
   return count;
}
//+------------------------------------------------------------------+
//|  选择平仓
//+------------------------------------------------------------------+
int Harvester::CloseSelecteOrders(string symbol,int magic,int ordertype)
{
  int result,total=OrdersTotal();
  double ask = MarketInfo(symbol,MODE_ASK);
  double bid = MarketInfo(symbol,MODE_BID);

  for(int cnt=total-1;cnt>=0;cnt--)
  {
    result=OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES);
    if(OrderMagicNumber()==magic && OrderSymbol()==symbol)
    {
      if(OrderType()==ordertype)
      {
        result=OrderClose(OrderTicket(),OrderLots(),ask,3);
      }
     if(OrderType()==ordertype)
      {
        result=OrderClose(OrderTicket(),OrderLots(),bid,3);
      }
    }
  }
  return(0);
}
//+------------------------------------------------------------------+
//|  最大订单价
//+------------------------------------------------------------------+
double Harvester::FindMaxOrderPrice(string symbol,int magic,int ordertype)
{
  int total=OrdersTotal();
  double maxprice1=0,maxprice2;


  for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
       if(OrderMagicNumber()==magic && OrderType() == ordertype && OrderSymbol()==symbol)
          {
            if(maxprice1 < OrderOpenPrice())
               {
                  maxprice2 = maxprice1;
                  maxprice1 = OrderOpenPrice();
               }
          }
  }
  return maxprice1;
}
//+------------------------------------------------------------------+
//|  最小订单价
//+------------------------------------------------------------------+
double Harvester::FindMinOrderPrice(string symbol,int magic,int ordertype)
{
  int total=OrdersTotal();
  double minprice1=99999,minprice2;


  for(int cnt=total-1;cnt>=0;cnt--)
  {
    if(OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
       if(OrderMagicNumber()==magic && OrderType() == ordertype && OrderSymbol()==symbol)
          {
            if(minprice1 > OrderOpenPrice())
               {
                  minprice2 = minprice1;
                  minprice1 = OrderOpenPrice();
               }
          }
  }
  return minprice1;
}


//+------------------------------------------------------------------+
//|  单量优化
//+------------------------------------------------------------------+
double Harvester::LotsOptimized(int order_count)
  {

   int layers = (int)MathFloor(order_count/per_layer_counts);
   
   double lot = NormalizeDouble(MathCeil(MathPow(1.76,layers)*100*Lots)/100,2);
   
   return(lot);
  }



//+------------------------------------------------------------------+
//|  获利优化
//+------------------------------------------------------------------+
double Harvester::ProfitOptimized(string symbol , int order_count)
  {

   double atr = iATR(symbol,PERIOD_D1,14,1);
   double profit = atr/MarketInfo(symbol,MODE_POINT)/15.0;
   //Alert("profit:",profit);
   return(profit);
  }

//+-----------------------------------------------
int Harvester::count_trades( string symbol,int ordertype) {
   int count = 0;
   int i,r;
   for (i = OrdersTotal() - 1; i >= 0; i--) {
      r=OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
      if (OrderSymbol() == symbol && OrderType() == ordertype ) count++;
   }
   return count;
}