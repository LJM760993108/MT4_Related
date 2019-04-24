
#property strict
#property copyright "ForexHacked 2.5"
#property link      "http://www.125808047.com"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ForexHacked
  {
public :
          ForexHacked();
   int    Trade_Main(string sym);
   int    Deinit();
   int    Init(string sym); 
private :

   double f0_1(int ai_0) ;
   int f0_0()  ;
   void f0_14(string sym) ;
   void f0_11(string sym) ;
   void f0_12(string sym) ;
   int f0_5(string sym)  ;  
   double f0_7(int ai_0,string sym) ;
   int f0_8( string sym, bool ai_0 = FALSE ) ;
   int f0_10(string sym, bool ai_0 = FALSE );
   int f0_9()  ;
   int f0_4(string sym) ;
   void f0_13(string as_0) ;
   double f0_2(double a_minlot_0, string sym) ;

private :
   string            _________;
   int               MagicNumber;
   double            Lots;
   double            TakeProfit;
   double            Booster;
   double            gd_120;
   int               PipStarter;
   double            gd_132;
   int               gi_unused_140;
   int               gi_144;
   int               MaxBuyOrders;
   int               MaxSellOrders;
   bool              AllowiStopLoss;
   int               iStopLoss;
   int               StartHour;
   int               StartMinute;
   int               StopHour;
   int               StopMinute;
   int               StartingTradeDay;
   int               EndingTradeDay;
   int               slippage;
   bool              allowTrending;
   int               trendTrigger;
   int               trendPips;
   int               trendStoploss;
   int               gi_208;
   int               gi_212;
   int               gi_216;
   double            StopLossPct;
   double            TakeProfitPct;
   bool              PauseNewTrades;
   int               StoppedOutPause;
   double            gd_244;
   bool              gi_260;
   int               g_period_264;
   int               gi_268;
   int               g_ma_method_272;
   int               g_applied_price_276;
   double            gd_280;
   double            gd_288;
   bool              SupportECN;
   bool              MassHedge;
   double            MassHedgeBooster;
   int               TradesDeep;
   string            EA_Name;
   int               g_datetime_324;
   double            g_point_328;
   int               gi_336;
   bool              gi_unused_340;
   string            gs_dummy_344;
   int               gi_352;
   int               gi_356;
   int               gi_360;
   int               gi_364;
   int               gi_unused_368;
   int               gi_372;
   string            gs_376;
   bool              gi_384;
   bool              gi_388;
   bool              gi_392;
   bool              gi_396;
   int               g_ticket_400;
   int               g_cmd_404;
   string            gs__hedged_408;
   int               g_file_416;
   bool              cg;
  }ForexHacked_Strategy;
  
  
ForexHacked :: ForexHacked()
{
   _________= "Magic Number Must be UNIQUE for each chart!";
   MagicNumber = 133714;
   Lots=0.01;
   TakeProfit = 45.0;
   Booster = 1.7;
   gd_120 = 0.0;
   PipStarter = 31;
   gd_132 = 0.0;
   gi_unused_140 = 0;
   gi_144 = 0;
   MaxBuyOrders = 9;
   MaxSellOrders = 9;
   AllowiStopLoss = FALSE;
   iStopLoss = 300;
   StartHour = 0;
   StartMinute = 0;
   StopHour = 23;
   StopMinute = 55;
   StartingTradeDay = 0;
   EndingTradeDay = 7;
   slippage = 3;
   allowTrending = FALSE;
   trendTrigger = 3;
   trendPips = 5;
   trendStoploss = 5;
   gi_208 = 5000;
   gi_212 = 0;
   gi_216 = 0;
   StopLossPct = 100.0;
   TakeProfitPct = 100.0;
   PauseNewTrades = FALSE;
   StoppedOutPause = 600;
   gd_244 = 0;
   gi_260 = 0;
   g_period_264 = 7;
   gi_268 = 0;
   g_ma_method_272 = MODE_LWMA;
   g_applied_price_276 = PRICE_WEIGHTED;
   gd_280 = 0.25;
   gd_288 = 0.2;
   SupportECN = TRUE;
   MassHedge = FALSE;
   MassHedgeBooster = 1.01;
   TradesDeep = 5;
   EA_Name = "ForexHacked 2.5";
   g_datetime_324 = 0;
   gi_336 = 0;
   gi_unused_340=FALSE;
   gs_dummy_344 = "";
   gi_352 = 0;
   gi_356 = 0;
   gi_360 = 0;
   gi_364 = 1;
   gi_unused_368 = 3;
   gi_372 = 250;
   gs_376 = "";
   gi_384 = 0;
   gi_388 = 0;
   gi_392 = 0;
   gi_396 = 0;
   g_ticket_400 = 0;
   g_cmd_404 = 0;
   gs__hedged_408 = " hedged";
   g_file_416 = 0;
   cg = false;
}
int ForexHacked :: Deinit() 
  {
   FileClose(g_file_416);
   Comment("www.125808047.com");
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: Init(string sym) 
  {
   int     digits = int(MarketInfo(sym,MODE_DIGITS));
   datetime   time_0 = iTime(sym,PERIOD_M15,0);
   double  point = MarketInfo(sym,MODE_POINT);
   if(digits==3) 
     {
      gd_132= 10.0 * TakeProfit;
      gi_unused_140=10*PipStarter;
      gi_144=10*iStopLoss;
      g_point_328=0.01;
        } else {
      if(digits==5) 
        {
         gd_132= 10.0 * TakeProfit;
         gi_unused_140=10*PipStarter;
         gi_144=10*iStopLoss;
         g_point_328=0.0001;
           } else {
         gd_132=TakeProfit;
         gi_unused_140=PipStarter;
         gi_144=iStopLoss;
         g_point_328=point;
        }
     }
   if(digits==3 || digits==5) 
     {
      trendTrigger=10*trendTrigger;
      trendPips=10*trendPips;
      trendStoploss=10*trendStoploss;
     }
   gi_336 = (int)MathRound((-MathLog(MarketInfo(sym, MODE_LOTSTEP))) / 2.302585093);
   gi_384 = FALSE;
   gi_388 = FALSE;
   gi_392 = FALSE;
   gi_396 = FALSE;
   g_ticket_400=-1;
   gi_260=FALSE;
   g_file_416= FileOpen(WindowExpertName()+"_"+(string)time_0+"_"+sym+"_"+(string)MagicNumber+".log",FILE_WRITE);
   g_cmd_404 = -1;

   return (0);
  }
  

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: Trade_Main(string sym)
  {
   double order_takeprofit_20;
   double price_28;
   double price_36;
    double  ask = MarketInfo(sym,MODE_ASK);
    double  bid = MarketInfo(sym,MODE_BID);
    double  point = MarketInfo(sym,MODE_POINT);
   if(allowTrending) 
     {
      for(int pos_0=0; pos_0<OrdersTotal(); pos_0++) 
        {
         if(OrderSelect(pos_0,SELECT_BY_POS)) 
           {
            if(MagicNumber==OrderMagicNumber() && OrderSymbol()==sym) 
              {
               if(OrderType()==OP_BUY)
                  if(OrderTakeProfit()-bid<=trendTrigger*point && bid<OrderTakeProfit()) cg=OrderModify(OrderTicket(),0,bid-trendStoploss*point,OrderTakeProfit()+trendPips*point,0,White);
               if(OrderType()==OP_SELL)
                  if(ask-OrderTakeProfit()<=trendTrigger*point && ask>OrderTakeProfit()) cg=OrderModify(OrderTicket(),0,ask+trendStoploss*point,OrderTakeProfit()-trendPips*point,0,White);
              }
           }
        }
     }
   int count_4 = 0;
   int count_8 = 0;
   for(int pos_12 = 0; pos_12 < OrdersTotal(); pos_12++) 
     {
      if(OrderSelect(pos_12,SELECT_BY_POS, MODE_TRADES)) 
        {
         if(OrderMagicNumber()==MagicNumber && OrderSymbol()==sym) 
           {
            if(StringFind(OrderComment(),gs__hedged_408)==-1) 
              {
               if(OrderType()==OP_BUY) 
                 {
                  count_4++;
                  continue;
                 }
               if(OrderType()==OP_SELL) count_8++;
              }
           }
        }
     }
   if(count_4>=TradesDeep) 
     {
      if(!gi_396) 
        {
         f0_13("Allow long hedge! trades="+(string)count_4+",TradesDeep="+(string)TradesDeep);
         gi_396=TRUE;
        }
     }
   if(count_8>=TradesDeep) 
     {
      if(!gi_392) 
        {
         f0_13("Allow short hedge! trades="+(string)count_8+",TradesDeep="+(string)TradesDeep);
         gi_392=TRUE;
        }
     }
   bool li_16=FALSE;
   if((100-StopLossPct)*AccountBalance()/100.0>=AccountEquity()) 
     {
      f0_13("AccountBalance="+(string)AccountBalance()+",AccountEquity="+(string)AccountEquity());
      gi_260= TRUE;
      li_16 = TRUE;
     }
   if((TakeProfitPct+100.0)*AccountBalance()/100.0<=AccountEquity()) gi_260=TRUE;
   if(gi_260) 
     {
      for(int pos_0=OrdersTotal()-1; pos_0>=0; pos_0--) 
        {
         if(OrderSelect(pos_0,SELECT_BY_POS)) 
           {
            if(OrderMagicNumber()==MagicNumber && OrderSymbol()==sym) 
              {
               f0_13("close #"+(string)OrderTicket());
               if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),(int)MarketInfo(sym,MODE_SPREAD),White)) 
                 {
                  f0_13("error");
                  return (0);
                 }
              }
           }
        }
      gi_260=FALSE;
      if(li_16) 
        {
         Sleep(1000*StoppedOutPause);
         li_16=FALSE;
        }
      gi_396 = FALSE;
      gi_392 = FALSE;
     }
   if(SupportECN) 
     {
      order_takeprofit_20=0;
      if(OrderSelect(g_ticket_400,SELECT_BY_TICKET)&& OrderSymbol()==sym) order_takeprofit_20=OrderTakeProfit();
      for(int pos_0=0; pos_0<OrdersTotal(); pos_0++) 
        {
         if(OrderSelect(pos_0,SELECT_BY_POS)) 
           {
            if(OrderMagicNumber()==MagicNumber) 
              {
               if(OrderTakeProfit()==0.0 && StringFind(OrderComment(),gs__hedged_408)==-1 && OrderSymbol()==sym) 
                 {
                  if(OrderType()==OP_BUY) 
                    {
                     cg=OrderModify(OrderTicket(),0,OrderStopLoss(),OrderOpenPrice()+gd_132*point,0,White);
                     continue;
                    }
                  if(OrderType()!=OP_SELL) continue;
                  cg=OrderModify(OrderTicket(),0,OrderStopLoss(),OrderOpenPrice()-gd_132*point,0,White);
                  continue;
                 }
               if(StringFind(OrderComment(),gs__hedged_408)!=-1 && g_cmd_404==OrderType()) 
                 {
                  price_28 = order_takeprofit_20 - MarketInfo(sym, MODE_SPREAD) * point;
                  price_36 = order_takeprofit_20 + MarketInfo(sym, MODE_SPREAD) * point;
                  if(OrderStopLoss()==0.0 || (OrderType()==OP_BUY && OrderStopLoss()!=price_28) || (OrderType()==OP_SELL && OrderStopLoss()!=price_36)) 
                    {
                     if(OrderType()==OP_BUY && OrderSymbol()==sym ) 
                       {
                        cg=OrderModify(OrderTicket(),0,price_28,OrderTakeProfit(),0,White);
                        continue;
                       }
                     if(OrderType()==OP_SELL && OrderSymbol()==sym ) cg=OrderModify(OrderTicket(),0,price_36,OrderTakeProfit(),0,White);
                    }
                 }
              }
           }
        }
     }
   if(f0_0()!=0) 
     {
      f0_12(sym);
      f0_11(sym);
      if((!PauseNewTrades) && f0_9()) 
        {
         if(gi_388)
            if(f0_8(sym,1)) gi_388=FALSE;
         if(gi_384)
            if(f0_10(sym,1)) gi_384=FALSE;
        }
      //f0_14(sym);
      return (0);
     }
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ForexHacked :: f0_13(string as_0) 
  {
   if(g_file_416>=0) FileWrite(g_file_416,TimeToStr(TimeCurrent(),TIME_DATE|TIME_SECONDS)+": "+as_0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_4(string sym) 
  {
   double ld_4=MarketInfo(sym,MODE_MINLOT);int count_0;
   for(count_0=0; ld_4<1.0; count_0++) ld_4=10.0*ld_4;
   return (count_0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ForexHacked :: f0_2(double a_minlot_0, string sym) 
  {
   double minlot_32;
   double ld_8=AccountEquity()-gi_208;
   double ld_16 = gi_212;
   double ld_24 = gi_216;
   if(gi_212==0 || gi_216==0) minlot_32=a_minlot_0;
   else 
     {
      ld_16=gi_208*ld_16/100.0;
      Print("tmp="+(string)ld_8+",AccountEquity()="+(string)AccountEquity()+",InitEquity="+(string)gi_208);
      ld_24/=100.0;
      if(ld_8>0.0) ld_8=MathPow(ld_24+1.0,ld_8/ld_16);
      else 
        {
         if(ld_8<0.0) ld_8=MathPow(1-ld_24,MathAbs(ld_8/ld_16));
         else ld_8=1;
        }
      minlot_32=NormalizeDouble(a_minlot_0*ld_8,f0_4(sym));
      if(minlot_32<MarketInfo(sym,MODE_MINLOT)) minlot_32=MarketInfo(sym,MODE_MINLOT);
     }
   if(minlot_32<0.0) Print("ERROR tmp="+(string)ld_8+",a="+(string)ld_16+",b="+(string)ld_24+",AccountEquity()="+(string)AccountEquity());
   f0_13("Equity="+(string)AccountEquity()+",lots="+(string)minlot_32);
   return (minlot_32);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_9() 
  {
   int li_8=0;
   if(DayOfWeek() < StartingTradeDay || DayOfWeek() > EndingTradeDay) return (0);
   int li_0 = 60 * TimeHour(TimeCurrent()) + TimeMinute(TimeCurrent());
   int li_4 = 60 * StartHour + StartMinute;
   li_8=60*StopHour+li_8;
   if(li_4 == li_8) return (1);
   if(li_4<li_8) 
     {
      if(!(li_0 >= li_4 && li_0 < li_8)) return (0);
      return (1);
     }
   if(li_4>li_8) 
     {
      if(li_0 >= li_4 || li_0 < li_8) return (1);
     }
   else return(0);
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ForexHacked :: f0_7(int ai_0, string sym) 
  {
   for(int pos_4=OrdersTotal()-1; pos_4>=0; pos_4--) 
     {
      if(OrderSelect(pos_4,SELECT_BY_POS)) 
        {
         if(OrderMagicNumber()==MagicNumber && OrderSymbol()==sym) 
           {
            if(StringFind(OrderComment(),gs__hedged_408)==-1) 
              {
               f0_13("GetLastLotSize "+(string)ai_0+",OrderLots()="+(string)OrderLots());
               return (OrderLots());
              }
           }
        }
     }
   f0_13("GetLastLotSize "+(string)ai_0+" wasnt found");
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_8(string sym,bool ai_0=FALSE )  
  {
    double  ask = MarketInfo(sym,MODE_ASK);
    double  bid = MarketInfo(sym,MODE_BID);
    double  point = MarketInfo(sym,MODE_POINT);
   int ticket_4;
   double lots_40;
   double price_8=0;
   double price_16=0;
   string ls_24="";
   bool li_ret_32=TRUE;
   if(TimeCurrent() - g_datetime_324 < 60) return (0);
   if(ai_0 && (!gi_392)) return (0);
   if(!GlobalVariableCheck("PERMISSION")) 
     {
      GlobalVariableSet("PERMISSION",TimeCurrent());
      if(!SupportECN) 
        {
         if(ai_0) 
           {
            if(OrderSelect(g_ticket_400,SELECT_BY_TICKET)&& OrderSymbol()==sym) price_16=OrderTakeProfit()-MarketInfo(sym,MODE_SPREAD)*point;
           }
         else price_8=ask+gd_132*point;
        }
      if(ai_0) ls_24=gs__hedged_408;
      if(AllowiStopLoss== TRUE) price_16 = ask-gi_144 * point;
      if(ai_0) lots_40 = NormalizeDouble(f0_7(1,sym) * MassHedgeBooster,2);
      else lots_40=f0_2(gd_244,sym);
      if(!SupportECN) ticket_4=OrderSend(sym,OP_BUY,lots_40,ask,slippage,price_16,price_8,EA_Name+ls_24,MagicNumber,0,Green);
      else 
        {
         ticket_4=OrderSend(sym,OP_BUY,lots_40,ask,slippage,0,0,EA_Name+ls_24,MagicNumber,0,Green);
         Sleep(1000);
         cg=OrderModify(ticket_4,OrderOpenPrice(),price_16,price_8,0,Black);
        }
      g_datetime_324=(int)TimeCurrent();
      if(ticket_4!=-1) 
        {
         if(!ai_0) 
           {
            g_ticket_400=ticket_4;
            f0_13("BUY hedgedTicket="+(string)g_ticket_400);
              } else {
            f0_13("BUY Hacked_ticket="+(string)ticket_4);
            g_cmd_404=0;
           }
           } else {
         f0_13("failed sell");
         li_ret_32=FALSE;
        }
     }
   GlobalVariableDel("PERMISSION");
   return (li_ret_32);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_10(string sym,bool ai_0=FALSE ) 
  {
    double  ask = MarketInfo(sym,MODE_ASK);
    double  bid = MarketInfo(sym,MODE_BID);
    double  point = MarketInfo(sym,MODE_POINT);
   int ticket_4;
   double lots_36;
   double price_8=0;
   double price_16=0;
   string ls_24="";
   bool li_ret_32=TRUE;
   if(TimeCurrent() - g_datetime_324 < 60) return (0);
   if(ai_0 && (!gi_396)) return (0);
   if(!GlobalVariableCheck("PERMISSION")) 
     {
      GlobalVariableSet("PERMISSION",TimeCurrent());
      if(!SupportECN) 
        {
         if(ai_0) 
           {
            if(OrderSelect(g_ticket_400,SELECT_BY_TICKET)&& OrderSymbol()==sym) price_16=OrderTakeProfit()+MarketInfo(sym,MODE_SPREAD)*point;
           }
         else price_8=bid-gd_132*point;
        }
      if(ai_0) ls_24=gs__hedged_408;
      if(AllowiStopLoss== TRUE) price_16 = bid+gi_144 * point;
      if(ai_0) lots_36 = NormalizeDouble(f0_7(0,sym) * MassHedgeBooster,2);
      else lots_36=f0_2(gd_244,sym);
      if(!SupportECN) ticket_4=OrderSend(sym,OP_SELL,lots_36,bid,slippage,price_16,price_8,EA_Name+ls_24,MagicNumber,0,Pink);
      else 
        {
         ticket_4=OrderSend(sym,OP_SELL,lots_36,bid,slippage,0,0,EA_Name+ls_24,MagicNumber,0,Pink);
         Sleep(1000);
         cg=OrderModify(ticket_4,OrderOpenPrice(),price_16,price_8,0,Black);
        }
      g_datetime_324=(int)TimeCurrent();
      if(ticket_4!=-1) 
        {
         if(!ai_0) 
           {
            g_ticket_400=ticket_4;
            f0_13("SELL hedgedTicket="+(string)g_ticket_400);
              } else {
            f0_13("SELL Hacked_ticket="+(string)ticket_4);
            g_cmd_404=1;
           }
           } else {
         f0_13("failed sell");
         li_ret_32=FALSE;
        }
     }
   GlobalVariableDel("PERMISSION");
   return (li_ret_32);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ForexHacked :: f0_12(string sym) 
  {
    double  ask = MarketInfo(sym,MODE_ASK);
   int datetime_0=0;
   double order_open_price_4=0;
   double order_lots_12=0;
   double order_takeprofit_20=0;
   int cmd_28=-1;
   int ticket_32=0;
   int pos_36=0;
   int count_40=0;
   for(pos_36=0; pos_36<OrdersTotal(); pos_36++) 
     {
      if(OrderSelect(pos_36,SELECT_BY_POS,MODE_TRADES)) 
        {
         if(OrderMagicNumber()==MagicNumber && OrderType()==OP_BUY && OrderSymbol()==sym) 
           {
            count_40++;
            if(OrderOpenTime()>datetime_0) 
              {
               datetime_0=(int)OrderOpenTime();
               order_open_price_4=OrderOpenPrice();
               cmd_28=OrderType();
               ticket_32=OrderTicket();
               order_takeprofit_20=OrderTakeProfit();
              }
            if(OrderLots()>order_lots_12) order_lots_12=OrderLots();
           }
        }
     }
   int li_44=(int)MathRound(MathLog(order_lots_12/Lots)/MathLog(Booster))+1;
   if(li_44<0) li_44=0;
   gd_244=NormalizeDouble(Lots*MathPow(Booster,li_44),gi_336);
   if(li_44==0 && f0_5(sym)==1 && f0_9()) 
     {
      if(f0_8(sym,false))
         if(MassHedge) gi_384=TRUE;
        } else {
      if(order_open_price_4-ask >PipStarter*g_point_328 && order_open_price_4>0.0 && count_40<MaxBuyOrders) 
        {
         if(!(f0_8(sym,false))) return;
         if(!(MassHedge)) return;
         gi_384=TRUE;
         return;
        }
     }
   for(pos_36=0; pos_36<OrdersTotal(); pos_36++) 
     {
      cg=OrderSelect(pos_36,SELECT_BY_POS,MODE_TRADES);
      if((OrderMagicNumber()!=MagicNumber || OrderType()!=OP_BUY || OrderTakeProfit()==order_takeprofit_20 || order_takeprofit_20==0.0 )&& OrderSymbol()==sym) continue;
      cg=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),order_takeprofit_20,0,Pink);
      Sleep(1000);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_5(string sym) 
  {
   double isar_0= iSAR(NULL,PERIOD_M15,gd_280,gd_288,0);
   double ima_8 = iMA(NULL,PERIOD_M15
,g_period_264,gi_268,g_ma_method_272,g_applied_price_276,0);
   if(isar_0 > ima_8) return (-1);
   if(isar_0 < ima_8) return (1);
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ForexHacked :: f0_11( string sym) 
  {
   double  bid = MarketInfo(sym,MODE_BID);
   
   int datetime_0=0;
   double order_open_price_4=0;
   double order_lots_12=0;
   double order_takeprofit_20=0;
   int cmd_28=-1;
   int ticket_32=0;
   int pos_36=0;
   int count_40=0;
   for(pos_36=0; pos_36<OrdersTotal(); pos_36++) 
     {
      if(OrderSelect(pos_36,SELECT_BY_POS,MODE_TRADES)) 
        {
         if(OrderMagicNumber()==MagicNumber && OrderType()==OP_SELL&& OrderSymbol()==sym) 
           {
            count_40++;
            if(OrderOpenTime()>datetime_0) 
              {
               datetime_0=(int)OrderOpenTime();
               order_open_price_4=OrderOpenPrice();
               cmd_28=OrderType();
               ticket_32=OrderTicket();
               order_takeprofit_20=OrderTakeProfit();
              }
            if(OrderLots()>order_lots_12) order_lots_12=OrderLots();
           }
        }
     }
   int li_44=(int)MathRound(MathLog(order_lots_12/Lots)/MathLog(Booster))+1;
   if(li_44<0) li_44=0;
   gd_244=NormalizeDouble(Lots*MathPow(Booster,li_44),gi_336);
   if(li_44==0 && f0_5(sym)==-1 && f0_9()) 
     {
      if(f0_10(sym,false))
         if(MassHedge) gi_388=TRUE;
        } else {
      if(bid-order_open_price_4>PipStarter*g_point_328 && order_open_price_4>0.0 && count_40<MaxSellOrders) 
        {
         if(!(f0_10(sym,false))) return;
         if(!(MassHedge)) return;
         gi_388=TRUE;
         return;
        }
     }
   for(pos_36=0; pos_36<OrdersTotal(); pos_36++) 
     {
      if(OrderSelect(pos_36,SELECT_BY_POS,MODE_TRADES)) 
        {
         if(OrderMagicNumber()==MagicNumber && OrderType()==OP_SELL && OrderSymbol()==sym) 
           {
            if(OrderTakeProfit()==order_takeprofit_20 || order_takeprofit_20==0.0) continue;
            cg=OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),order_takeprofit_20,0,Pink);
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ForexHacked :: f0_14(string sym) 
  {
   string dbl2str_0=DoubleToStr(f0_1(2),2);
   for(int pos_8=0; pos_8<OrdersHistoryTotal(); pos_8++)
      if(OrderSelect(pos_8,SELECT_BY_POS,MODE_HISTORY) && OrderMagicNumber()==MagicNumber && OrderSymbol()==sym && OrderType()<=OP_SELL) gd_120+=OrderProfit()+OrderCommission()+OrderSwap();
   Comment(" \nForexHacked V2.5 Loaded Successfully?",
           "\nAccount Leverage  :  "+"1 : "+(string)AccountLeverage(),
           "\nAccount Type  :  "+AccountServer(),
           "\nServer Time  :  "+TimeToStr(TimeCurrent(),TIME_SECONDS),
           "\nAccount Equity  = ",AccountEquity(),
           "\nFree Margin     = ",AccountFreeMargin(),
           "\nDrawdown  :  ",dbl2str_0," \n"+sym," Earnings  :  "+(string)gd_120);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ForexHacked :: f0_0() 
  {
   return (1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ForexHacked :: f0_1(int ai_0) 
  {
   double ld_ret_4;
   if(ai_0==2) 
     {
      ld_ret_4=(AccountEquity()/AccountBalance()-1.0)/(-0.01);
      if(ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
     }
   if(ai_0==1) 
     {
      ld_ret_4=100.0 *(AccountEquity()/AccountBalance()-1.0);
      if(ld_ret_4 <= 0.0) return (0);
      return (ld_ret_4);
     }
   return (0.0);
  }
//+------------------------------------------------------------------+

