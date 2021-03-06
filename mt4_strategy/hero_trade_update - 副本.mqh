
//+------------------------------------------------------------------+
//| trade_update_7     用来更新 信号源和跟单端的 订单流水                          |
//+------------------------------------------------------------------+
#include </Hero_Doc/hero_global.mqh>
#include </Hero_Doc/hero_mysql.mqh>

#define  UPDATE_COUNT 50

class Trade_Update
  {
private:
   Account_Info   acc_info;
   CMysql         CCmysql;
   
   int   his_cou; //历史订单数
   int   his_sql_num;
   int   write_max_record; //一次写入数据库的最大订单数
   long  order_number_add;
   long  pos_ticke[];
   long  ticke[];
   string   cmd_initv;//命令的初始 字符
   int   init_ticke;
   
   string   tab_name;//表名
   datetime pos_last_time;
   
public:
   Trade_Update()
         {
          write_max_record    =50;
          cmd_initv           =" ";
          switch(acc_info.run_mode)
          {
          
             case  ACCOUNT_MODE:tab_name = acc_info.tab_name;break;
             case  SIGNAL_MODE:tab_name = acc_info.tab_name;break;
             default:
             break;
             
          }
 //Alert(8);          
         }
private:
   void     his_write_in(void);//把历史订单写入数据库 最多一次写 50个 不然字符串太长了
   string   trade_up(int begin,int count);//所有订单的命令  
   string   trade_to_string(int   mode);  //把交易信息 写入到表格
   string   insert_to_string(void);//更新插入字段的命令
    
   //---订单改变时 修改 表中的 内容 operation_type
//   string   pos_trade_to_string(long tik);
   int      search_ticke(long tik);   
   void     pos_order_number_add(string &cmd_trade[]);
   void     pos_write_in(void);
   
   
   void     his_trade_update(void);
   void     his_trade_to_string(void);//把历史交易订单写入表格的命令
   void     his_trade_update_init(void);//历史交易订单的更新 初始化
   void     his_trade_change(void);//历史订单变了 就在 his_write_in 和  his_trade_update_init
         
public:
   void  Initialization_software();
   void  Initialization_Modular(void);
   void  ontime_1s();
   void  ondeinit();

  };
  
  
void  Trade_Update::Initialization_software()
{
  Print(tab_name+":"+"hero_trade_update 初始化更新");
   his_write_in();
   his_trade_update_init();
}

void  Trade_Update::Initialization_Modular(void)
{

}


void  Trade_Update::ontime_1s()
{

   his_trade_change();
   pos_write_in();
   his_trade_update();
   
}

void  Trade_Update::ondeinit()
{


}

void  Trade_Update::his_trade_change(void)  //最近一笔历史订单发生改变时 在进行历史订单的写入
{
   if(OrderSelect(0,SELECT_BY_POS,MODE_HISTORY) == TRUE)
     {
      if(init_ticke!=OrderTicket())
        {
         init_ticke=OrderTicket();
         his_sql_num=OrdersHistoryTotal();
         his_write_in();
         his_trade_update_init();
        }
     }

}

void  Trade_Update::his_trade_update_init(void)//历史交易订单的更新 初始化
{
   string   cmd=cmd_initv;
   int      re;
   int      his_ticke[];
   int      total;
   
   cmd   =  "SELECT"
          + "  "  +  Acc_trade_tab[TRADE_NUM].tab
          + "  "  +  "FROM"
          + "  "  +  tab_name
          + "  "  +  "WHERE"
          + "  "  +  Acc_trade_tab[OPERATION_TYPE].tab
          + "  "  +  "="
          + "  "  +  IntegerToString(TRADES)
          + "  "  +  ";";
    re = CCmysql.MySqlCursorOpen(Sql_info[TEST_BASE].DB, cmd);
    //Alert();
      if(re>=0)
      {
         int   i=0;
         while(CCmysql.MySqlCursorFetchRow(re))
           {
            ArrayResize(his_ticke,i+1,1000);
            his_ticke[i]            =  CCmysql.MySqlGetFieldAsInt(re,0);
            i++;
           }
         CCmysql.MySqlCursorClose(re);
      }          

   total=ArrayRange(his_ticke,0);
   for(int ii = 0;ii < total; ii++)
     {
      if(OrderSelect(his_ticke[ii],SELECT_BY_TICKET,MODE_HISTORY)==TRUE)
        {
         if(OrderCloseTime()!=0)//已经平仓了
            {
              his_trade_to_string();
            }
        }
     }

}

//---
void  Trade_Update::his_trade_update(void)
{
   int   total=OrdersHistoryTotal();
   for(int i=0;his_sql_num<total;his_sql_num++)
     {
      if(OrderSelect(his_sql_num,SELECT_BY_POS,MODE_HISTORY)==TRUE)
        {
         his_trade_to_string();
        }
     }
}

void  Trade_Update::his_trade_to_string() //把历史交易订单写入表格
{
   string   cmd;
   int      digits;

   digits   =  (int)SymbolInfoInteger(OrderSymbol(),SYMBOL_DIGITS);
   cmd   =  "UPDATE"
          + "  "  +  tab_name
          + "  "  +  "SET"
          + "  "  +  Acc_trade_tab[OPERATION_TYPE].tab   +"="+IntegerToString(HISTORY)+","
          + "  "  +  Acc_trade_tab[SL].tab               +"="+DoubleToString(OrderStopLoss(),digits)+","
          + "  "  +  Acc_trade_tab[TP].tab               +"="+DoubleToString(OrderTakeProfit(),digits)+","
          + "  "  +  Acc_trade_tab[ST_TIME].tab          +"="+IntegerToString(OrderCloseTime())+","
          + "  "  +  Acc_trade_tab[ORDERSWAP].tab        +"="+DoubleToString(OrderSwap(),2)+","
          + "  "  +  Acc_trade_tab[TRADE_PROFIT].tab     +"="+DoubleToString(OrderProfit(),2)+","
          + "  "  +  Acc_trade_tab[ACC_PROFIT].tab       +"="+DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)+","//余额
          + "  "  +  Acc_trade_tab[NET_WORTH].tab       +"="+DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)+"," //净值
          + "  "  +  Acc_trade_tab[UP_TIME].tab          +"="+IntegerToString(TimeCurrent())
          + "  "  +  "WHERE"
          + "  "  +  Acc_trade_tab[TRADE_NUM].tab
          + "  "  +  "="
          + "  "  +  IntegerToString(OrderTicket())
          + "  "  +  "AND"
          + "  "  +  Acc_trade_tab[LOGIN].tab
          + "  "  +  "="
          + "  "  +  IntegerToString(acc_info.login)
          + "  "  +  "AND"
          + "  "  +  Acc_trade_tab[SERVER].tab
          + "  "  +  "="
          + "  "  +  "'"+acc_info.server+"'"
          + "  "  +  ";";
   if(Sql_info[TEST_BASE].DB!=-1)
     {
      CCmysql.MySqlExecute(Sql_info[TEST_BASE].DB,cmd);
//Alert(cmd);      
     }

}
//---
void    Trade_Update::pos_write_in(void)
{
   string   cmd_order[];
   
   string   cmd = insert_to_string();
   
   string   t_cmd=cmd_initv;
   int      re;
   
   int   total = OrdersTotal();
   
   ArrayResize(cmd_order,total/UPDATE_COUNT+1, 100);

   pos_order_number_add(cmd_order);
   //Alert(cmd_order[0]);
   if(total > 0)
   {
       //Alert(total/UPDATE_COUNT);
       for(int i = 0 ;i < total/UPDATE_COUNT + 1; i++)
       {
          
           t_cmd  = cmd_order[i];
           
           if(t_cmd!=cmd_initv)
             {
              cmd+=t_cmd;
             // Alert(cmd);
              re=CCmysql.MySqlExecute(Sql_info[TEST_BASE].DB,cmd);
              //Print("pos_write_in!");
             }
              cmd = insert_to_string();
              
       }
    }   
   
}

void  Trade_Update::pos_order_number_add(string &cmd[])//扫描所有持仓单  有信息才会更新
{

   //string   cmd = cmd_initv;
   
   datetime time = 0;
   int   total = OrdersTotal();
   int  cmd_total = ArrayRange(cmd, 0);
   
   for(int i_=0;i_ < cmd_total;i_++)
     {
      cmd[i_]=cmd_initv;
     }
     
   for(int j = 0 ;j < cmd_total;j++)
     {
      
       for(int i = j*UPDATE_COUNT; i < (j+1)*UPDATE_COUNT && i < total; i++)
         {
         
          if(OrderSelect(i,SELECT_BY_POS)==true)
            {
            
             if(OrderType()<2)
               {
               
                if(pos_last_time<OrderOpenTime())
                  {
                  
                   if(time<OrderOpenTime())
                     {
                         time=OrderOpenTime();
                     }
                     
                    if(cmd[j] != cmd_initv)
                     {
                     
                          cmd[j] +=","; 
                          cmd[j] += trade_to_string(TRADES);
                     }
                     if(cmd[j] == cmd_initv)
                     
                     {
                        
                        cmd[j] = trade_to_string(TRADES);
                
                     }
                        
                  }
                
               }
               
            }
            
         }   
      
      }
   pos_last_time=time;     

//return cmd;
}



void    Trade_Update::his_write_in(void)//把历史订单写入数据库 最多一次写 50个 不然字符串太长了
{
   string   cmd;
   int      re;
   int   his_total=OrdersHistoryTotal();
   if(his_sql_num!=his_total)
     {
      int count=0;
      do
        {
         count=his_total-his_sql_num;
         
         if(count > write_max_record)
           {
           
                count = write_max_record;
            
           }
         if(count > 0&&Sql_info[TEST_BASE].DB!=-1)
           {
           
                cmd=trade_up(his_sql_num, count);
                re=CCmysql.MySqlExecute(Sql_info[TEST_BASE].DB,cmd);
               
                if(re>=0)
                {
                  
                   his_sql_num+=count;
    
                }
           }
        }
      while(his_total>his_sql_num);
      Print("his_sql_num:",his_sql_num," OrdersHistoryTotal:",his_total);
     }
}
//--- 下面三个函数一起 把 订单信息 插入到表中
string  Trade_Update::trade_up(int begin,int count)
{
   string   cmd=insert_to_string();
   //string   t_cmd;
   for(int i=0;i<count;i++)
     {
     
      if(i!=0)cmd+=",";
      
      if(OrderSelect(begin+i,SELECT_BY_POS,MODE_HISTORY)==true)
         {
         
          cmd   +=trade_to_string(HISTORY);
          
         }    
           
     }
return   cmd;           

}

string   Trade_Update::insert_to_string(void)
{
   string   cmd   =  "INSERT IGNORE INTO "
                     +  "  "  +  tab_name
                     +  "  "  +  "(";
                     
            cmd  +=     "  "  +   Acc_trade_tab[SERVER_AND_TICKE].tab
                     +  ",  "  +  Acc_trade_tab[LOGIN].tab
                     +  ",  "  +  Acc_trade_tab[SERVER].tab
                     +  ",  "  +  Acc_trade_tab[TRADE_NUM].tab
                     +  ",  "  +  Acc_trade_tab[OPERATION_TYPE].tab
                     +  ",  "  +  Acc_trade_tab[OP_TIME].tab
                     +  ",  "  +  Acc_trade_tab[OP_TYPE].tab
                     +  ",  "  +  Acc_trade_tab[LOT].tab
                     +  ",  "  +  Acc_trade_tab[SYMBOL].tab
                     +  ",  "  +  Acc_trade_tab[CONTRACT_SIZE].tab
                     +  ",  "  +  Acc_trade_tab[OP_PRICE].tab
                     +  ",  "  +  Acc_trade_tab[SL].tab
                     +  ",  "  +  Acc_trade_tab[TP].tab
                     +  ",  "  +  Acc_trade_tab[ST_TIME].tab
                     +  ",  "  +  Acc_trade_tab[CL_PRICE].tab
                     +  ",  "  +  Acc_trade_tab[ORDERSWAP].tab
                     +  ",  "  +  Acc_trade_tab[ORDERCOMM].tab
                     +  ",  "  +  Acc_trade_tab[TRADE_PROFIT].tab
                     +  ",  "  +  Acc_trade_tab[MAGIC].tab
                     +  ",  "  +  Acc_trade_tab[ACC_PROFIT].tab
                     +  ",  "  +  Acc_trade_tab[NET_WORTH].tab                   
                     +  ",  "  +  Acc_trade_tab[UP_TIME].tab;
            cmd+=       "   "  +  ")";
            cmd+=       "   "  +  " VALUES ";
return   cmd;
}
string   Trade_Update::trade_to_string(int mode) //把交易信息 写入到表格里的 cmd
{
   string   cmd=cmd_initv;
   int      digits;
     {
         digits   =  (int)SymbolInfoInteger(OrderSymbol(),SYMBOL_DIGITS);
         cmd   = "  "+"("
                  +  "  "  +"'"+acc_info.server+IntegerToString(OrderTicket())+"'"
                  +  ",  "  +IntegerToString(acc_info.login)
                  +  ",  "  +"'"+acc_info.server+"'"
                  +  ",  "  +IntegerToString(OrderTicket())
                  +  ",  "  +IntegerToString(mode)
                  +  ",  "  +IntegerToString(OrderOpenTime())
                  +  ",  "  +IntegerToString(OrderType())
                  +  ",  "  +DoubleToString(OrderLots(),2)
                  +  ",  "  +"'"+StringSubstr(OrderSymbol(),0,StringLen(OrderSymbol())-acc_info.suffx_len)+"'"
                  +  ",  "  +DoubleToString(SymbolInfoDouble(OrderSymbol(),SYMBOL_TRADE_CONTRACT_SIZE))
                  +  ",  "  +DoubleToString(OrderOpenPrice(),digits)
                  +  ",  "  +DoubleToString(OrderStopLoss(),digits)
                  +  ",  "  +DoubleToString(OrderTakeProfit(),digits)
                  +  ",  "  +IntegerToString(OrderCloseTime())
                  +  ",  "  +DoubleToString(OrderClosePrice(),digits)
                  +  ",  "  +DoubleToString(OrderSwap(),2)
                  +  ",  "  +DoubleToString(OrderCommission(),2)
                  +  ",  "  +DoubleToString(OrderProfit(),2)
                  +  ",  "  +IntegerToString(OrderMagicNumber())
                  +  ",  "  +DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE),2)
                  
                  +  ",  "  +DoubleToString(AccountInfoDouble(ACCOUNT_EQUITY),2)                
                  +  ",  "  +IntegerToString(TimeCurrent())
                  
                  +  "  "  +")";
     }

return   cmd;
}