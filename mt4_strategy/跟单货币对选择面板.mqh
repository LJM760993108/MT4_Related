//+------------------------------------------------------------------+
//|                                                    跟单货币对选择面板.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#define  SYMBOL_NUM 24
#define  X_DIS 137
#define  Y_DIS 37

class Symbol_Panel
{
public:
   string allow_symbol[SYMBOL_NUM];   
   string allow_ratio[SYMBOL_NUM];
public:
   void Panel_Info(int x, int y);   
   

}panel_info;
