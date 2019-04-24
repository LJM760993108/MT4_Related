//+------------------------------------------------------------------+
//|                                                     Scalp_Ea.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#define  sym_num 7
string all_sym[sym_num] = { "EURUSD","GBPUSD","AUDUSD","USDJPY","USDCHF","XAUUSD","USDCAD",
                            //"EURGBP","EURJPY","EURCAD","EURCHF","EURNZD","EURAUD",
                           //"GBPJPY","GBPCHF","GBPAUD",
                           //"NZDJPY","NZDCHF","NZDCAD","NZDUSD",
                           //"AUDJPY","AUDCAD","AUDNZD","AUDCHF",
                           //"CADCHF","CHFJPY"            

                          };
                          
class Scalp()
{
public:
   Trade_Main(string sym);
private:
   Scalp(void);
   
public:
   int   




} 