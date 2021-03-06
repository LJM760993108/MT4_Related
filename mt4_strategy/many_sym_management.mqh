//+------------------------------------------------------------------+
//|                                          many_sym_management.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
#define  sym_num 9
#define  rsi_timeframe  PERIOD_M1

string Sym[sym_num]=
{
"EURUSD"
,"GBPUSD"
,"USDJPY"
,"EURJPY"
,"USDCHF"
,"USDCAD"
,"NZDUSD"
,"AUDUSD"
,"EURGBP"
};//不加后缀。
class many_sym_manage
{
public:
   string Sym_Name[];
   bool Sym_Switch[];
   bool Sym_R_Management[];
   double open_order[];
public:
   void init_(string symbol);
   void deinit_();
   void Trade_Main(string symbol);
   
   //void spa(string sparam);
   many_sym_manage()
      {
   系数=1.0;
   前几单=3;
   锁单=8;
   距倍=4;
   止损=5000;
   动态止盈1=310;
   动态止盈2 = 230;
   动态止盈3 = 90;
   动态止盈4 = 70;
   动态止盈5 = 340;
   动态止盈6 = 140;
   动态止盈7 = 90;
   动态止盈8 = 140;
   动态止盈9 = 490;
   动态止盈10 = 140;
   动态止盈11 = 550;
   动态止盈12 = 340;
   动态止盈13 = 60;
   动态止盈14 = 25;
   动态止盈15 = 20;
   动态止盈16 = 15;
   动态止盈17 = 10;
   动态止盈18 = 5;
   动态止盈19 = 30;
   动态止盈20 = 25;
   动态止盈21 = 20;
   动态止盈22 = 15;
   动态止盈23 = 10;
   动态止盈24 = 10;
   动态止盈25 = 10;
   总加仓次数 = 25;
   系数1=1.0;
   Prosadka=830;
   Prosadka1=520;
   间隔加码点数=100;
   间隔加码点数1=300;
   多间距 =100;
   空间距 =100;
   Povtor=1;
   g_timeframe_140 = PERIOD_M1;
   g_timeframe_144 = PERIOD_M1;
   gi_148=FALSE;
   g_timeframe_152=PERIOD_M15;
   gi_156=FALSE;
   真实 = TRUE;
   虚假 = FALSE;
   单位仓位手数= 0.01;
   最大单笔手数=0.8;
   倍率=1.24;
   倍率1=0.685;
   顺势间隔点数=120;
   顺势间距点=520;
   显示信息图表=TRUE;
   MagicNumber=123456;
   g_datetime_228=0;
   g_datetime_232=0;
   gi_236=0;
   PIXELS=0;
   stop_trend=false;
   Sym_Count=0;
   SymAllowd_Count=36;
   Sym_Risk_management=false;

   }
private:
   void CloseAll_symbol();
   void CloseAll(string symbol);
   void CloseOrder();
   int symbol_Balance();
   double Balance_symbol(string B_0,string B_1,string sym_0);
   double  极点信号(string as_0,string sym_0);
   bool 趋势(string MA_0,string sym_0);
   double  强弱区间(string as_0,string sym_0);
   double AveragePrice(string as_0,string sym_0) ;
   double Balance(string as_0,string as_8,string sym_0) ;
   double LotDecimal(string sym_0) ;
   int NextOrder(string as_0,string sym_0) ;
   double FindLastOrder(string as_0,string as_8,string sym_0) ;
   int CountTrades(string as_0,string sym_0) ;
   double NextLot(string as_0,string sym_0);
   double LotExponent(string sym_0);
   double LotExponent1(string sym_0);
   void  start_trade(string sym_0);
   void 止盈计算(string as_0,string sym_0);
   double NewLot(string as_0,string sym_0);
private:
   
   double 系数;
   int 前几单;
   int 锁单;
   int 距倍;
   double 止损;
   double 动态止盈1;
   double  动态止盈2 ;
   double  动态止盈3 ;
   double  动态止盈4 ;
   double 动态止盈5 ;
   double 动态止盈6 ;
   double 动态止盈7 ;
   double 动态止盈8 ;
   double 动态止盈9 ;
   double 动态止盈10 ;
   double 动态止盈11 ;
   double 动态止盈12 ;
   double 动态止盈13 ;
   double 动态止盈14 ;
   double 动态止盈15 ;
   double 动态止盈16 ;
   double 动态止盈17 ;
   double 动态止盈18 ;
   double 动态止盈19 ;
   double 动态止盈20 ;
   double 动态止盈21 ;
   double 动态止盈22 ;
   double 动态止盈23 ;
   double 动态止盈24 ;
   double 动态止盈25 ;
   double 总加仓次数 ;
   double 系数1;
   int Prosadka;
   int Prosadka1;
   int 间隔加码点数;
   int 间隔加码点数1;
   double 多间距 ;
   double 空间距 ;
   
   int Povtor;
   int g_timeframe_140 ;
   int g_timeframe_144 ;
   bool gi_148;
   int g_timeframe_152;
   bool gi_156;
   bool 真实 ;
   bool 虚假 ;
   double 单位仓位手数;
   double 最大单笔手数;
   double 倍率;
   double 倍率1;
   double 顺势间隔点数;
   double 顺势间距点;
   bool 显示信息图表;
   int MagicNumber;
   int g_datetime_228;
   datetime g_datetime_232;
   double gi_236;
   int g_ticket_240;
   int gi_244;
   bool gi_248;
   bool gi_252;
   double g_lots_256;
   double g_lots_264;
   double g_lots_272;
   double g_lots_280;
   string g_comment_288;
   string gs_296;
   int PIXELS;
   bool   stop_trend;
   int Sym_Count;
   int SymAllowd_Count;

   bool Sym_Risk_management;
   
   string Sym[100];
   double max_all_lots;//风控起动仓位（手）  
   double R_Management_Profit;//风控盈利金额（元）
   double max_loss;//止损（元）
}   Many_Sym_Ganage;

void many_sym_manage::init_(string symbol)
{
  if(true)
     {
      stop_trend=true;
     }
   else
     {
      Alert("QQ：201682397。");
     }
   if(IsTesting()==true)
     {
      stop_trend=true;
      for(int i=1;i<99;i++)
        {
         Sym[i]=NULL;
        }
      Sym[0]=symbol;
     }
   else
     {
      int   strlen=StringLen(Symbol());
      int   strlen1=StringLen(Sym[0]);

      if(strlen>strlen1)
        {
         string   strsubstr=StringSubstr(Symbol(),strlen1,strlen);
         for(int i=0;i<100;i++)
           {
            if(Sym[i]!=NULL)
              {
               Sym[i]=Sym[i]+strsubstr;
              }
            else
              {
               i=100;
              }
           }
        }
     }
   for(int i=0;i<5000;i++)
     {
      if(Sym[i]==NULL)
        {
         Sym_Count=i;
         i=5000;
        }
     }
   ArrayResize(Sym_Name,Sym_Count);
   ArrayResize(Sym_Switch,Sym_Count);
   ArrayResize(open_order,Sym_Count);
   ArrayResize(Sym_R_Management,Sym_Count);
   for(int i=0;i<=Sym_Count-1;i++)
     {
      Sym_Name[i]=Sym[i];
      Sym_Switch[i]=false;
     }
     
}    

void many_sym_manage::deinit_(void)
{

   ObjectsDeleteAll();

} 

void many_sym_manage::Trade_Main(string symbol)
{
     for(int i=0;i<Sym_Count;i++)
     {
      if(Sym_Switch[i]==false)
        {
         open_order[i]=MathMod(MathRand(),1000);
        }
      else
        {
         open_order[i]=1000;
        }
     }
   for(int i=0;i<=Sym_Count-1;i++)
     {
      string num=IntegerToString(i);
      int   i_1=ArrayMinimum(open_order,Sym_Count,0);
      if(Sym_Switch[i_1]==false)
        {
         int   total=ObjectsTotal();
         for(int i1=0;i1<total;i1++)
           {
            if(OrderSelect(i,SELECT_BY_POS)==true)
              {
               if(OrderSymbol()==Sym_Name[i_1])
                 {
                  start_trade(Sym_Name[i_1]);
                  open_order[i_1]=1000;
                 }
              }
           }
         if(symbol_Balance()<SymAllowd_Count)
           {
            start_trade(Sym_Name[i_1]);
            open_order[i_1]=1000;
           }
        }
      if(Sym_Switch[i]==true)
        {

         ObjectSetInteger(0,"Sym_Switch"+num,OBJPROP_BGCOLOR,clrRed);
         ObjectSetString(0,"Sym_Switch"+num,OBJPROP_TEXT,"关");
        }
      //-------------------------------------------------------------------        

      if(Sym_Risk_management==true)
        {
         Sym_Risk_management=true;
         ObjectSetInteger(0,"Sym_Risk_management",OBJPROP_BGCOLOR,clrRed);
         ObjectSetString(0,"Sym_Risk_management",OBJPROP_TEXT,"风控关");
        }
      //-------------------------------------------------------------------    
      if(Sym_R_Management[i]==true)
        {
         ObjectSetInteger(0,"Sym_R_Management"+num,OBJPROP_BGCOLOR,clrRed);
         ObjectSetString(0,"Sym_R_Management"+num,OBJPROP_TEXT,"关");

        }
     }

//金额风控平仓
   for(int i=0;i<Sym_Count;i++)
     {
      if(Sym_R_Management[i]==false)
        {
         if(Balance_symbol("all","all_lots",Sym_Name[i])>max_all_lots)
           {
            string num=IntegerToString(i);
            ObjectSetInteger(0,"Sym_R_Management"+num,OBJPROP_BGCOLOR,clrRed);
            if(Balance_symbol("all","all_profit",Sym_Name[i])>R_Management_Profit)
              {
               //CloseAll(Sym_Name[i]);
              }
           }
         else
           {
            string num=IntegerToString(i);
            ObjectSetInteger(0,"Sym_R_Management"+num,OBJPROP_BGCOLOR,clrLightGray);
           }
        }
      if(Balance_symbol("all","all_profit",Sym_Name[i])<-max_loss)
        {
         //CloseAll(Sym_Name[i]);
        }
     }
 

}


int many_sym_manage::symbol_Balance()
  {
   bool symbol_Balance_symbol=false;
   int   total=OrdersTotal();
   int   symbol_1=0;
   string   symbol_array[1000];
   for(int i=total-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS)==true)
        {
         if(OrderMagicNumber()==MagicNumber)
           {
            for(int i1=0;i1<1000;i1++)
              {
               if(symbol_array[i1]==NULL)
                 {
                  symbol_array[i1]=OrderSymbol();
                  i1=1000;
                 }
               else
                 {
                  if(symbol_array[i1]==OrderSymbol())
                    {
                     i1=1000;
                    }
                 }
              }
           }
        }
     }
   for(int i=0;i<1000;i++)
     {
      if(symbol_array[i]!=NULL)
        {
         symbol_1++;
        }
      else
        {
         i=1000;
        }
      symbol_Balance_symbol=true;
     }
   return(symbol_1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::Balance_symbol(string B_0,string B_1,string sym_0)
  {
   int   order_quantity=0;
   double   last_price=0;
   double   last_lots=0;
   double   profit_price=0,profit_price_1=0,profit_price_2=0;
   double   start_price=0;
   double   start_lots=0;
   double   all_profit=0;
   double   all_lots=0;
   datetime order_time=0;
   datetime   last_time=0;
   int   total=OrdersTotal();
   for(int i=total-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS)==true)
        {
         if(OrderSymbol()==sym_0 || sym_0=="all_symbol")
           {
            if(OrderMagicNumber()==MagicNumber)
              {
               if(B_0=="buy" && OrderType()==OP_BUY)
                 {
                  if(B_1=="order_quantity"){order_quantity++;}
                  if(B_1=="last_price" && order_time<=OrderOpenTime()){last_price=OrderOpenPrice();order_time=OrderOpenTime();}//else{if(order_time==0){last_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="last_lots" && order_time<=OrderOpenTime()){last_lots=OrderLots();order_time=OrderOpenTime();}//else{if(order_time<100){last_lots=OrderLots();order_time=OrderOpenTime();Print("++++++++++++");}}
                  if(B_1=="start_price"&&order_time>=OrderOpenTime()){start_price=OrderOpenPrice();order_time=OrderOpenTime();}else{if(order_time<100){start_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="start_lots" && order_time>=OrderOpenTime()){start_lots=OrderLots();order_time=OrderOpenTime();}else{if(order_time<100){start_lots=OrderLots();order_time=OrderOpenTime();}}
                  if(B_1=="profit_price"){profit_price_1+=OrderOpenPrice()*OrderLots();profit_price_2+=OrderLots();}
                  if(B_1=="all_profit"){all_profit+=OrderProfit()+OrderSwap();}
                  if(B_1=="all_lots"){all_lots+=OrderLots();}
                 }
               if(B_0=="sell" && OrderType()==OP_SELL)
                 {
                  if(B_1=="order_quantity"){order_quantity++;}
                  if(B_1=="last_price" && order_time<=OrderOpenTime()){last_price=OrderOpenPrice();order_time=OrderOpenTime();}//else{if(order_time==0){last_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="last_lots" && order_time<=OrderOpenTime()){last_lots=OrderLots();order_time=OrderOpenTime();}//else{if(order_time<100){last_lots=OrderLots();order_time=OrderOpenTime();Print("++++++++++++");}}
                  if(B_1=="start_price"&&order_time>=OrderOpenTime()){start_price=OrderOpenPrice();order_time=OrderOpenTime();}else{if(order_time<100){start_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="start_lots" && order_time>=OrderOpenTime()){start_lots=OrderLots();order_time=OrderOpenTime();}else{if(order_time<100){start_lots=OrderLots();order_time=OrderOpenTime();}}
                  if(B_1=="profit_price"){profit_price_1+=OrderOpenPrice()*OrderLots();profit_price_2+=OrderLots();}
                  if(B_1=="all_profit"){all_profit+=OrderProfit()+OrderSwap();}
                  if(B_1=="all_lots"){all_lots+=OrderLots();}
                 }
               if(B_0=="all")
                 {
                  if(B_1=="order_quantity"){order_quantity++;}
                  if(B_1=="last_price" && order_time<=OrderOpenTime()){last_price=OrderOpenPrice();order_time=OrderOpenTime();}//else{if(order_time==0){last_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="last_lots" && order_time<=OrderOpenTime()){last_lots=OrderOpenPrice();order_time=OrderOpenTime();}//else{if(order_time==0){last_lots=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="start_price"&&order_time>=OrderOpenTime()){start_price=OrderOpenPrice();order_time=OrderOpenTime();}else{if(order_time<100){start_price=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="start_lots" && order_time>=OrderOpenTime()){start_lots=OrderOpenPrice();order_time=OrderOpenTime();}else{if(order_time<100){start_lots=OrderOpenPrice();order_time=OrderOpenTime();}}
                  if(B_1=="profit_price"){profit_price_1+=OrderOpenPrice()*OrderLots();profit_price_2+=OrderLots();}
                  if(B_1=="all_profit"){all_profit+=OrderProfit()+OrderSwap();}
                  if(B_1=="all_lots"){all_lots+=OrderLots();}
                 }
              }
           }
        }
     }
   if(B_1=="order_quantity"){return(order_quantity);}
   if(B_1=="last_price"){return(last_price);}
   if(B_1=="last_lots"){return(last_lots);}
   if(B_1=="start_price"){return(start_price);}
   if(B_1=="start_lots"){return(start_lots);}
   if(B_1=="profit_price"){if(profit_price_2!=0){return(profit_price_1/profit_price_2);}}
   if(B_1=="all_profit"){return(all_profit);}
   if(B_1=="all_lots"){return(all_lots);}
   return(0.0);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void many_sym_manage::CloseAll_symbol()
  {
   bool close_symbol=true;
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         CloseOrder();close_symbol=false;
        }
     }
   if(close_symbol==false)CloseAll_symbol();

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void many_sym_manage::CloseAll(string symbol)
  {
   bool close_symbol=true;
   for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true)
        {
         if(OrderSymbol()==symbol){CloseOrder();close_symbol=false;}
        }
     }
   if(close_symbol==false)CloseAll(symbol);

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void many_sym_manage::CloseOrder()
  {
   int l_error_0;
   int l_count_4=0;
   int CloseTic;
   while(true)
     {
      CloseTic=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),5,White);
      l_error_0=GetLastError();
      if(l_error_0==0)
        {
         Print("平仓成功！");
         return;
        }
      Print("平仓失败，",StringSubstr(Symbol(),0,6)," 错误代码：",GetLastError());
      Sleep(500);
      RefreshRates();
      l_count_4++;
      if(l_count_4<=25) continue;
      break;
     }
   Alert("平仓失败，请查看交易日志。");
  }
  
  void  many_sym_manage::start_trade(string sym_0)
  {

   double   A=iMA(sym_0,PERIOD_M1,5,0,MODE_SMA,PRICE_CLOSE,1);
   double   B=iMA(sym_0,PERIOD_M1,3600,0,MODE_SMA,PRICE_CLOSE,1);
   if(gi_236==0) gi_236=LotDecimal(sym_0);
   if(真实!=虚假)
     {
      gi_248 = TRUE;
      gi_252 = TRUE;
     }
     {
      g_ticket_240=0;
      gi_244=CountTrades("buy",sym_0);

      if(A-B>多间距*SymbolInfoDouble(sym_0,SYMBOL_POINT) || B-A>距倍*空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT))
        {

         if(gi_244==0 && gi_248==TRUE && 极点信号("buy",sym_0)==true)
           {
            g_comment_288= "趋势型 "+sym_0+" - 多单 "+((DoubleToStr(gi_244+1,0)));
            g_lots_272 = NewLot("buy",sym_0);
              {
               g_ticket_240=OrderSend(sym_0,OP_BUY,g_lots_272,SymbolInfoDouble(sym_0,SYMBOL_ASK),3,0,0,g_comment_288,MagicNumber,0,Blue);
               if(g_ticket_240<1)
                 {
                  Sleep(1000 *(60*Povtor));
                 }
               else 止盈计算("buy",sym_0);
               RefreshRates();
              }
           }
        }
      gi_244=CountTrades("sell",sym_0);
      if(B-A>空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT) || A-B>距倍*空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT))
        {
         if(gi_244==0 && gi_252==TRUE && 极点信号("sell",sym_0)==true) 
           {

            g_comment_288="趋势型 "+sym_0+" - 空单 "+((DoubleToStr(gi_244+1,0)));
            g_lots_280=NewLot("sell",sym_0);
              {
               g_ticket_240=OrderSend(sym_0,OP_SELL,g_lots_280,SymbolInfoDouble(sym_0,SYMBOL_BID),3,0,0,g_comment_288,MagicNumber,0,Red);
               if(g_ticket_240<1) 
                 {
                  Sleep(1000 *(60*Povtor));
                 }
               else 止盈计算("sell",sym_0);
               RefreshRates();
              }
           }
        }
     }
   if(g_datetime_232!=iTime(sym_0,g_timeframe_144,0))
     {
      g_ticket_240=0;
      gi_244=CountTrades("buy",sym_0);
      g_lots_264=NextLot("sell",sym_0);
      g_lots_256=NextLot("buy",sym_0);
      if(A-B>空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT) || B-A>距倍*空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT))
        {
         if(gi_244>0 && NextLot("buy",sym_0)<=最大单笔手数 && (
            极点信号("buy",sym_0)==true || 
            CountTrades("buy",sym_0)<6 || 强弱区间("buy",sym_0)==true) && 趋势("buy",sym_0)==true
            && g_lots_256!=0
            )
           {
            g_comment_288="极点型 "+sym_0+" - 多单 "+((DoubleToStr(gi_244+1,0)));
              {
               g_ticket_240=OrderSend(sym_0,OP_BUY,g_lots_256,SymbolInfoDouble(sym_0,SYMBOL_ASK),3,0,0,g_comment_288,MagicNumber,0,Blue);
               if(g_ticket_240<1) 
                 {
                  Sleep(1000 *(60*Povtor));
                 }
               else 止盈计算("buy",sym_0);
               RefreshRates();
              }
           }
        }
      gi_244=CountTrades("sell",sym_0);
      if(B-A>空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT) || A-B>距倍*空间距*SymbolInfoDouble(sym_0,SYMBOL_POINT))
        {
         if(gi_244>0 && NextLot("sell",sym_0)<=最大单笔手数 && (
            极点信号("sell",sym_0)==true || 
            CountTrades("sell",sym_0)<6 || 强弱区间("sell",sym_0)==true) && 趋势("sell",sym_0)==true
           && g_lots_264!=0
            ) 
           {
            g_comment_288="极点型 "+sym_0+" - 空单 "+((DoubleToStr(gi_244+1,0)));
              {
               g_ticket_240=OrderSend(sym_0,OP_SELL,g_lots_264,SymbolInfoDouble(sym_0,SYMBOL_BID),3,0,0,g_comment_288,MagicNumber,0,Red);
               if(g_ticket_240<1) 
                 {
                  Sleep(1000 *(60*Povtor));
                 }
               else 止盈计算("sell",sym_0);
               RefreshRates();
              }
           }
        }
      g_datetime_232=iTime(sym_0,g_timeframe_144,0);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void many_sym_manage::止盈计算(string as_0,string sym_0)
  {
   double l_price_8=0;
   double l_price_88=0;
   double l_price_16= AveragePrice(as_0,sym_0);
   int   lots_number=CountTrades(as_0,sym_0);
   double   Profit_1=0.0;
   switch(lots_number)
     {
      case  1:Profit_1=动态止盈1;break;
      case  2:Profit_1=动态止盈2;break;
      case  3:Profit_1=动态止盈3;break;
      case  4:Profit_1=动态止盈4;break;
      case  5:Profit_1=动态止盈5;break;
      case  6:Profit_1=动态止盈6;break;
      case  7:Profit_1=动态止盈7;break;
      case  8:Profit_1=动态止盈8;break;
      case  9:Profit_1=动态止盈9;break;
      case  10:Profit_1=动态止盈10;break;
      case  11:Profit_1=动态止盈11;break;
      case  12:Profit_1=动态止盈12;break;
      case  13:Profit_1=动态止盈13;break;
      case  14:Profit_1=动态止盈14;break;
      case  15:Profit_1=动态止盈15;break;
      case  16:Profit_1=动态止盈16;break;
      case  17:Profit_1=动态止盈17;break;
      case  18:Profit_1=动态止盈18;break;
      case  19:Profit_1=动态止盈19;break;
      case  20:Profit_1=动态止盈20;break;
      case  21:Profit_1=动态止盈21;break;
      case  22:Profit_1=动态止盈22;break;
      case  23:Profit_1=动态止盈23;break;
      case  24:Profit_1=动态止盈24;break;
      case  25:Profit_1=动态止盈25;break;
     }
   for(int l_pos_24=OrdersTotal()-1; l_pos_24>=0; l_pos_24--)
     {
      if(OrderSelect(l_pos_24,SELECT_BY_POS,MODE_TRADES)==true)
         if(OrderSymbol()!=sym_0 || OrderMagicNumber()!=MagicNumber) continue;
      if(OrderSymbol()==sym_0 && OrderMagicNumber()==MagicNumber)
        {
         if(as_0=="buy") 
           {
            if(OrderType()==OP_BUY) 
              {
               l_price_8=l_price_16+Profit_1*SymbolInfoDouble(sym_0,SYMBOL_POINT);
               //   l_price_88 = l_price_16 - 止损 * SymbolInfoDouble(sym_0,SYMBOL_POINT);
               if(OrderTakeProfit()!=l_price_8) 
                 {

                  bool a=OrderModify(OrderTicket(),l_price_16,l_price_88,l_price_8,0,Yellow);
                  //  bool b=OrderModify(OrderTicket(), l_price_16, OrderStopLoss(), l_price_8, 0, Yellow); 
                 }
              }
           }
         if(as_0=="sell") 
           {
            if(OrderType()==OP_SELL) 
              {
               l_price_8=l_price_16-Profit_1*SymbolInfoDouble(sym_0,SYMBOL_POINT);
               //   l_price_88 = l_price_16 + 止损 * SymbolInfoDouble(sym_0,SYMBOL_POINT);
               if(OrderTakeProfit()!=l_price_8) 
                 {
                  bool a=OrderModify(OrderTicket(),l_price_16,l_price_88,l_price_8,0,Yellow);
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::NewLot(string as_0,string sym_0) 
  {
   double ld_ret_8=0;
   double l_minlot_16=MarketInfo(sym_0,MODE_MINLOT);//最小允许标准手数。
   if(as_0=="buy") 
     {
      if(gi_156) ld_ret_8=单位仓位手数;
      else ld_ret_8=单位仓位手数;
     }
   if(as_0=="sell") 
     {
      if(gi_156) ld_ret_8=单位仓位手数;
      else ld_ret_8=单位仓位手数;
     }
   if(ld_ret_8<l_minlot_16) ld_ret_8=l_minlot_16;
   return (ld_ret_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::NextLot(string as_0,string sym_0)
  {
   double ld_ret_88=SymbolInfoDouble(sym_0,SYMBOL_ASK)-FindLastOrder(as_0,"Price",sym_0)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT);
   double ld_ret_89=FindLastOrder(as_0,"Price",sym_0)-SymbolInfoDouble(sym_0,SYMBOL_ASK)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT);
   double ld_ret_888=SymbolInfoDouble(sym_0,SYMBOL_BID)-FindLastOrder(as_0,"Price",sym_0)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT);
   double ld_ret_889=FindLastOrder(as_0,"Price",sym_0)-SymbolInfoDouble(sym_0,SYMBOL_BID)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT);

   double ld_ret_8=0.0;
   if(虚假)
   倍率 = LotExponent(sym_0);
   倍率1= LotExponent1(sym_0);
//   if (as_0 == "buy") ld_ret_8 = NormalizeDouble(FindLastOrder(as_0, "Lots") * 倍率, gi_236);
//   if (as_0 == "sell") ld_ret_8 = NormalizeDouble(FindLastOrder(as_0, "Lots") * 倍率, gi_236);

////原倍率可运行--------------------------
   if(as_0=="buy")
     {

      if(CountTrades("buy",sym_0)<前几单 && (ld_ret_88 || ld_ret_89))
        {
         ld_ret_8=单位仓位手数;
        }
      if(CountTrades("buy",sym_0)==(前几单+1))
        {
         ld_ret_8=单位仓位手数+单位仓位手数;
        }
      if((前几单+1)<CountTrades("buy",sym_0)<总加仓次数)
        {
         if(ld_ret_88)
           {
            ld_ret_8=NormalizeDouble((FindLastOrder(as_0,"Lots",sym_0))*倍率1,2);
           }

         if(ld_ret_89)
           {
            if(CountTrades("sell",sym_0)>锁单)
              {
               ld_ret_8=NormalizeDouble((FindLastOrder(as_0="sell","Lots",sym_0))*倍率1,2);
              }
            ld_ret_8=NormalizeDouble((FindLastOrder(as_0,"Lots",sym_0))*倍率,2);
            //}
           }
        }
     }
   if(as_0=="sell")
     {
      if(CountTrades("sell",sym_0)<前几单 && (ld_ret_888 || ld_ret_889))
        {
         ld_ret_8=单位仓位手数;
        }
      if(CountTrades("sell",sym_0)==(前几单+1))
        {
         ld_ret_8=单位仓位手数+单位仓位手数;
        }
      if((SymbolInfoDouble(sym_0,SYMBOL_BID)-FindLastOrder(as_0,"Price",sym_0)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT)) && (前几单+1)<CountTrades("sell",sym_0)<总加仓次数)
        {
         ld_ret_8=NormalizeDouble((FindLastOrder(as_0,"Lots",sym_0))*倍率,2);
        }
      if((FindLastOrder(as_0,"Price",sym_0)-SymbolInfoDouble(sym_0,SYMBOL_BID)>=顺势间隔点数*SymbolInfoDouble(sym_0,SYMBOL_POINT)) && (前几单+1)<CountTrades("sell",sym_0)<总加仓次数)
        {
         if(CountTrades("buy",sym_0)>锁单)
           {
            ld_ret_8=NormalizeDouble((FindLastOrder(as_0="buy","Lots",sym_0))*倍率1,2);

           }

         ld_ret_8=NormalizeDouble((FindLastOrder(as_0,"Lots",sym_0))*倍率1,2);
        }

     }
   return (ld_ret_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::LotExponent(string sym_0)
  {
   double ld_0=0;
   double ld_ret_8=0.8;
   while(ld_0<AccountBalance()) 
     {
      ld_ret_8=(100.0*ld_ret_8+1.0)/100.0;
      ld_0=0;
      for(int li_16 = 0; li_16 <= 5; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - 间隔加码点数 * li_16));
      for(int li_16 = 6; li_16 <= 9; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - Prosadka / 10));
      for(int li_16 = 10; li_16 <= 11; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - Prosadka / 6));
      ld_0+=10.0 *(单位仓位手数*MathPow(ld_ret_8,12) *(Prosadka-Prosadka/4));
     }
  Print("倍率1 "+DoubleToStr(ld_ret_8,2));
   return (ld_ret_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::LotExponent1(string sym_0)
  {
   double ld_0=0;
   double ld_ret_8=1;
   while(ld_0<AccountBalance()) 
     {
      ld_ret_8=(100.0*ld_ret_8+1.0)/100.0;
      ld_0=0;
      for(int li_16 = 0; li_16 <= 5; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - 间隔加码点数 * li_16)/10);
      for(int li_16 = 6; li_16 <= 9; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - Prosadka / 10));
      for(int li_16 = 10; li_16 <= 11; li_16++) ld_0 += 20.0 * (单位仓位手数 * MathPow(ld_ret_8, li_16) * (Prosadka - Prosadka / 6));
      ld_0+=10.0 *(单位仓位手数*MathPow(ld_ret_8,12) *(Prosadka-Prosadka/4));
     }
   Print("倍率 "+DoubleToStr(ld_ret_8,2));
   return (ld_ret_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int many_sym_manage::NextOrder(string as_0,string sym_0) 
  {
   double li_8;
   double li_81;
   double li_82;
   bool li_ret_12=FALSE;
   double l_iclose_16= iClose(sym_0,g_timeframe_152,1);
   double l_iopen_24 = iOpen(sym_0,g_timeframe_152,1);
   if(as_0=="buy") 
     {
      li_8= NormalizeDouble(间隔加码点数 * MathPow(系数, CountTrades(as_0,sym_0)), 0);
      li_8=间隔加码点数*MathPow(系数,CountTrades(as_0,sym_0));
      if(CountTrades(as_0,sym_0) == 4)  li_8 = Prosadka / 30;
      if(CountTrades(as_0,sym_0) == 5)  li_8 = Prosadka / 25;
      if(CountTrades(as_0,sym_0) == 6)  li_8 = Prosadka / 20;
      if(CountTrades(as_0,sym_0) == 7)  li_8 = Prosadka / 25;
      if(CountTrades(as_0,sym_0) == 8)  li_8 = Prosadka / 28;
      if(CountTrades(as_0,sym_0) == 9)  li_8 = Prosadka / 15;
      if(CountTrades(as_0,sym_0) == 10) li_8 = Prosadka / 20;
      if(CountTrades(as_0,sym_0) == 11) li_8 = Prosadka / 10;
      if(CountTrades(as_0,sym_0) == 12) li_8 = Prosadka / 10;
      if(CountTrades(as_0,sym_0) == 13) li_8 = Prosadka / 10;
      if(CountTrades(as_0,sym_0) == 14) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 15) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 16) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 17) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 18) li_8 = Prosadka / 3;
      if(CountTrades(as_0,sym_0) == 19) li_8 = Prosadka /3;
      if(CountTrades(as_0,sym_0) == 20) li_8 = Prosadka / 3;
      li_81=NormalizeDouble(间隔加码点数1*MathPow(系数,CountTrades(as_0,sym_0)),0);
      li_81=间隔加码点数1*MathPow(系数,CountTrades(as_0,sym_0));
      if(CountTrades(as_0,sym_0) == 4)  li_81 = Prosadka1 / 15;
      if(CountTrades(as_0,sym_0) == 5)  li_81 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 6)  li_81 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 7)  li_81 = Prosadka1 / 8;
      if(CountTrades(as_0,sym_0) == 8)  li_81 = Prosadka1 / 8;
      if(CountTrades(as_0,sym_0) == 9)  li_81 = Prosadka1 / 8;
      if(CountTrades(as_0,sym_0) == 10) li_81 = Prosadka1 / 8;
      if(CountTrades(as_0,sym_0) == 11) li_81 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 12) li_81 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 13) li_81 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 14) li_81 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 15) li_81 = Prosadka1 / 3;
      if(CountTrades(as_0,sym_0) == 16) li_81 = Prosadka1 / 3;
      if(CountTrades(as_0,sym_0) == 17) li_81 = Prosadka1 / 2;
      if(CountTrades(as_0,sym_0) == 18) li_81 = Prosadka1 / 2;
      if(CountTrades(as_0,sym_0) == 19) li_81 = Prosadka1 / 1;
      if(CountTrades(as_0,sym_0) == 20) li_81 = Prosadka1 / 1;

      if(((FindLastOrder(as_0,"Price",sym_0)-SymbolInfoDouble(sym_0,SYMBOL_ASK))>=li_8*SymbolInfoDouble(sym_0,SYMBOL_POINT)
         || (SymbolInfoDouble(sym_0,SYMBOL_ASK)-FindLastOrder(as_0,"Price",sym_0))>=li_81*SymbolInfoDouble(sym_0,SYMBOL_POINT))
         && CountTrades(as_0,sym_0)<总加仓次数)
        {
         if(gi_148) 
           {
            if(l_iopen_24 <= l_iclose_16) li_ret_12 = TRUE;
            else li_ret_12 = FALSE;
           }
         else li_ret_12=TRUE;
        }
     }
   if(as_0=="sell") 
     {
      li_8= NormalizeDouble(间隔加码点数 * MathPow(系数1, CountTrades(as_0,sym_0)), 2);
      if(CountTrades(as_0,sym_0) == 4)  li_8 = Prosadka / 30;
      if(CountTrades(as_0,sym_0) == 5)  li_8 = Prosadka / 20;
      if(CountTrades(as_0,sym_0) == 6)  li_8 = Prosadka / 20;
      if(CountTrades(as_0,sym_0) == 7)  li_8 = Prosadka / 25;
      if(CountTrades(as_0,sym_0) == 8)  li_8 = Prosadka / 30;
      if(CountTrades(as_0,sym_0) == 9)  li_8 = Prosadka / 20;
      if(CountTrades(as_0,sym_0) == 10) li_8 = Prosadka / 15;
      if(CountTrades(as_0,sym_0) == 11) li_8 = Prosadka / 15;
      if(CountTrades(as_0,sym_0) == 12) li_8 = Prosadka / 15;
      if(CountTrades(as_0,sym_0) == 13) li_8 = Prosadka / 15;
      if(CountTrades(as_0,sym_0) == 14) li_8 = Prosadka / 10;
      if(CountTrades(as_0,sym_0) == 15) li_8 = Prosadka / 10;
      if(CountTrades(as_0,sym_0) == 16) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 17) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 18) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 19) li_8 = Prosadka / 5;
      if(CountTrades(as_0,sym_0) == 20) li_8 = Prosadka / 5;
      li_81=NormalizeDouble(间隔加码点数1*MathPow(系数1,CountTrades(as_0,sym_0)),2);
      if(CountTrades(as_0,sym_0) == 4)  li_82 = Prosadka1 / 20;
      if(CountTrades(as_0,sym_0) == 5)  li_82 = Prosadka1 / 20;
      if(CountTrades(as_0,sym_0) == 6)  li_82 = Prosadka1 / 15;
      if(CountTrades(as_0,sym_0) == 7)  li_82 = Prosadka1 / 15;
      if(CountTrades(as_0,sym_0) == 8)  li_82 = Prosadka1 / 15;
      if(CountTrades(as_0,sym_0) == 9)  li_82 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 10) li_82 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 11) li_82 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 12) li_82 = Prosadka1 / 10;
      if(CountTrades(as_0,sym_0) == 13) li_82 = Prosadka1 / 9;
      if(CountTrades(as_0,sym_0) == 14) li_82 = Prosadka1 / 8;
      if(CountTrades(as_0,sym_0) == 15) li_82 = Prosadka1 / 7;
      if(CountTrades(as_0,sym_0) == 16) li_82 = Prosadka1 / 6;
      if(CountTrades(as_0,sym_0) == 17) li_82 = Prosadka1 / 4;
      if(CountTrades(as_0,sym_0) == 18) li_82 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 19) li_82 = Prosadka1 / 5;
      if(CountTrades(as_0,sym_0) == 20) li_82 = Prosadka1 / 5;
      if(((SymbolInfoDouble(sym_0,SYMBOL_BID)-FindLastOrder(as_0,"Price",sym_0)>=li_81*SymbolInfoDouble(sym_0,SYMBOL_POINT))
         || (FindLastOrder(as_0,"Price",sym_0)-SymbolInfoDouble(sym_0,SYMBOL_BID))>=li_81*SymbolInfoDouble(sym_0,SYMBOL_POINT))
         && CountTrades(as_0,sym_0)<总加仓次数)
        {
         if(gi_148) 
           {
            if(l_iopen_24 >= l_iclose_16) li_ret_12 = TRUE;
            else li_ret_12 = FALSE;
           }
         else li_ret_12=TRUE;
        }
     }
   return (li_ret_12);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::FindLastOrder(string as_0,string as_8,string sym_0) 
  {
   double l_ord_open_price_16=0;
   double l_ord_lots_24=0;
   int l_ticket_32=0;
   int   lots_number=0;
   for(int l_pos_36=OrdersTotal()-1; l_pos_36>=0; l_pos_36--) 
     {
      if(OrderSelect(l_pos_36,SELECT_BY_POS,MODE_TRADES)==true)
         if(OrderSymbol()!=sym_0 || OrderMagicNumber()!=MagicNumber) continue;
      if(OrderSymbol()==sym_0 && OrderMagicNumber()==MagicNumber) 
        {
         if(as_0=="buy") 
           {
            if(OrderType()==OP_BUY) 
              {
               if(OrderTicket()>l_ticket_32) 
                 {
                  l_ord_open_price_16=OrderOpenPrice();
                  l_ord_lots_24=OrderLots();
                  l_ticket_32=OrderTicket();
                 }
              }
           }
         if(as_0=="sell") 
           {
            if(OrderType()==OP_SELL) 
              {
               if(OrderTicket()>l_ticket_32) 
                 {
                  l_ord_open_price_16=OrderOpenPrice();
                  l_ord_lots_24=OrderLots();
                  l_ticket_32=OrderTicket();
                 }
              }
           }
        }
     }
   if(as_8 == "Price") return (l_ord_open_price_16);
   if(as_8 == "Lots") return (l_ord_lots_24);
   return (0.0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int many_sym_manage::CountTrades(string as_0,string sym_0) 
  {
   int l_count_8=0;
   for(int l_pos_12=OrdersTotal()-1; l_pos_12>=0; l_pos_12--) 
     {
      if(OrderSelect(l_pos_12,SELECT_BY_POS,MODE_TRADES)==true)
         if(OrderSymbol()!=sym_0 || OrderMagicNumber()!=MagicNumber) continue;
      if(OrderSymbol()==sym_0 && OrderMagicNumber()==MagicNumber) 
        {
         if(as_0=="buy")
            if(OrderType()==OP_BUY) l_count_8++;
         if(as_0=="sell")
            if(OrderType()==OP_SELL) l_count_8++;
        }
     }
   return (l_count_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::AveragePrice(string as_0,string sym_0) 
  {
   double ld_8=0;
   double ld_16=0;
   for(int l_pos_24=OrdersTotal()-1; l_pos_24>=0; l_pos_24--) 
     {
      if(OrderSelect(l_pos_24,SELECT_BY_POS,MODE_TRADES)==true)
         if(OrderSymbol()!=sym_0 || OrderMagicNumber()!=MagicNumber) continue;
      if(OrderSymbol()==sym_0 && OrderMagicNumber()==MagicNumber) 
        {
         if(as_0=="buy") 
           {
            if(OrderType()==OP_BUY) 
              {
               ld_8+=OrderOpenPrice()*OrderLots();
               ld_16+=OrderLots();
              }
           }
         if(as_0=="sell") 
           {
            if(OrderType()==OP_SELL) 
              {
               ld_8+=OrderOpenPrice()*OrderLots();
               ld_16+=OrderLots();
              }
           }
        }
     }
   if(ld_16!=0)
     {
      ld_8=ld_8/ld_16;
     }
   return (ld_8);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::Balance(string as_0,string as_8,string sym_0) 
  {
   double ld_ret_16 =0;
   for(int l_pos_24=OrdersTotal()-1; l_pos_24>=0; l_pos_24--) 
     {
      if(OrderSelect(l_pos_24,SELECT_BY_POS,MODE_TRADES)==true)
         if(OrderSymbol()!=sym_0 || OrderMagicNumber()!=MagicNumber) continue;
      if(OrderSymbol()==sym_0 && OrderMagicNumber()==MagicNumber) 
        {
         if(as_0=="buy") 
           {
            if(OrderType()==OP_BUY) 
              {
               if(as_8 == "Balance") ld_ret_16 = ld_ret_16 + OrderProfit() - OrderSwap() - OrderCommission();
               if(as_8 == "Lot") ld_ret_16 += OrderLots();
              }
           }
         if(as_0=="sell") 
           {
            if(OrderType()==OP_SELL) 
              {
               if(as_8 == "Balance") ld_ret_16 = ld_ret_16 + OrderProfit() - OrderSwap() - OrderCommission();
               if(as_8 == "Lot") ld_ret_16 += OrderLots();
              }
           }
        }
     }
   return (ld_ret_16);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double many_sym_manage::LotDecimal(string sym_0) 
  {
   double l_lotstep_0=MarketInfo(sym_0,MODE_LOTSTEP);
   double li_ret_8=MathCeil(MathAbs(MathLog(l_lotstep_0)/MathLog(10)));
   return (li_ret_8);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  many_sym_manage::极点信号(string as_0,string sym_0)
{
   double   A = iMA(sym_0,rsi_timeframe,5,0,MODE_SMA,PRICE_CLOSE,1);
   double   D = iMA(sym_0,rsi_timeframe,3600,0,MODE_SMA,PRICE_CLOSE,1);
//double  J=iCustom(sym_0,rsi_timeframe,"纵横极点指标",0,1);

   bool  rsi_symbol=false;
   HideTestIndicators(TRUE);

   if(as_0=="buy")
     {
      if(iCustom(sym_0,rsi_timeframe,"纵横极点指标",0,1)<-150)
        {
         rsi_symbol=true;
        }
     }
   if(as_0=="sell")
     {
      //if( D-A>10*SymbolInfoDouble(sym_0,SYMBOL_POINT))
      //{
      if(iCustom(sym_0,rsi_timeframe,"纵横极点指标",0,1)>100)
        {
         //if(iCustom(sym_0,rsi_timeframe,"强弱区间",0,1)<20)
         //{
         rsi_symbol=true;
        }
     }
   HideTestIndicators(false);
   return(rsi_symbol);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool many_sym_manage::趋势(string MA_0,string sym_0)
  {
   int     MA5_number=50;
   int    MA5_step=600;
   bool  ma_symbol=false;
   if(MA_0=="buy")
     {
      for(int i=1;i<MA5_number;i++)
        {
         if(iMA(sym_0,rsi_timeframe,MA5_step,0,MODE_SMA,PRICE_CLOSE,1)-iMA(sym_0,rsi_timeframe,(MA5_number+1),0,MODE_SMA,PRICE_CLOSE,1)<顺势间距点*SymbolInfoDouble(sym_0,SYMBOL_POINT))
           {
            ma_symbol=true;
            i=MA5_number+1;
           }
         else
           {
            ma_symbol=false;
           }

        }
     }
   if(MA_0=="sell")
     {
      for(int i=1;i<MA5_number;i++)
        {
         if(iMA(sym_0,rsi_timeframe,MA5_number,0,MODE_SMA,PRICE_CLOSE,1)-iMA(sym_0,rsi_timeframe,(MA5_step+1),0,MODE_SMA,PRICE_CLOSE,1)<顺势间距点*SymbolInfoDouble(sym_0,SYMBOL_POINT))
           {
            ma_symbol=true;
            i=MA5_number+1;
           }
         else
           {
            ma_symbol=false;
           }
        }
     }
   return(ma_symbol);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double  many_sym_manage::强弱区间(string as_0,string sym_0)
  {
   bool  rsi_symbol=false;
   bool  rsi_symbol_1=false;
   bool  rsi_symbol_2=false;
   bool  rsi_symbol_3=false;
   double   rsi_1=0;
   double   rsi_2=0;
   HideTestIndicators(TRUE);
   if(as_0=="buy")
     {
      if(iCustom(sym_0,rsi_timeframe,"强弱区间",0,1)<5)
        {
         rsi_symbol=true;
        }
     }
   if(as_0=="sell")
     {

      if(iCustom(sym_0,rsi_timeframe,"强弱区间",0,1)>23)
        {
         rsi_symbol=true;
        }
     }
   HideTestIndicators(false);
   return(rsi_symbol);
  }

//}      
