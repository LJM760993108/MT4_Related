//+------------------------------------------------------------------+
//|                                                     New_Even.mqh |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict

#import  "Wininet.dll"
int InternetOpenW (string,int,string,string,int) ;//初始化结构体来操作WinInet库函数。在使用库中的其他函数前必须先激活此函数。
int InternetConnectW (int,string,int,string,string,int,int,int) ;//打开由HTTP URL或FTP地址确定的资源。返回打开的连接的描述符
int HttpOpenRequestW (int,string,string,int,string,int,string,int) ;//为建立连接的HTTP请求创建描述符
int InternetOpenUrlW (int,string,string,int,int,int) ;
int InternetReadFile (int,uchar &sBuffer[],int,int &OneInt[]) ;//当请求被处理后，读取从服务器返回的数据
int InternetCloseHandle (int) ;//释放已经传输完成的描述符
#import  

#define  every_page 12


int OnInit()
  {
//---
   New_Even_Strategy.Init();
   EventSetMillisecondTimer(100);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   member_center.Exit();
  
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

  
void OnTimer()
  {
//---

   member_center.Time_Count++;

   member_center.On_Timer(member_center.Time_Count,50);
   
//---
  }  
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{

   if(id==CHARTEVENT_OBJECT_CLICK)
   { 
   
      member_center.Link_Turn(sparam); 
      
   }

}
class New_Even
{
struct NewsStr
  {
    string strTime;
    string strNews;
    string strImportance;
  }newsstr[100];
  
public:

   New_Even()
   {
      NewsReadSwi = true;
      NewsLines = 1;
      cur_page = 1;
      page_num = 1;
      page_state = false; 
      obj_name = "New_Even";
      col_lab = C'255,255,255';
      clr_cur = C'42,183,254';
      obj_name = "New_Even";
      
   }
   
   void              Init();
   void              Exit();
   void              Edit(string sparam);
   //void              On_Timer();
   void              Spa(string sparam);
   string            obj_name;
   
   
private:
   bool   NewsReadSwi ;
   int    NewsLines ;
   int    cur_page ;
   int    page_num ;
   bool   page_state ;
   color  col_lab;
   color  clr_cur ;
   
   
private:

   void   Read_News(int x,int y);   
   void   NewsExecute(string news,int x,int y);
   string TimeFormat(datetime t);
   string RePlaceSpace(string StrInput);


}New_Even_Strategy;

void New_Even::Init()
{

   bool news_init=true;
    if(news_init)
   {
      Read_News(1,1);
      news_init=false;
   }

}
void New_Even::Exit(void)
{
   ObjectsDeleteAll(0,obj_name);
}

void New_Even::Edit(string sparam)
{

  if(sparam == obj_name+"edit_")
  {
      if(page_num>1)
     {      
    cur_page = (int)ObjectGetString(0, sparam,OBJPROP_TEXT,0);
    if(cur_page>page_num)cur_page = page_num;
    if(cur_page<1)cur_page = 1;
    ObjectSet(obj_name+"page_num"+(string)cur_page,OBJPROP_COLOR,clr_cur); 
    for(int i=0;i<page_num;i++)
     {
     if((i+1)!=cur_page)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab);          
     }
     page_state =true; 
     } 
  
  }



}
 void New_Even::NewsExecute(string news,int x,int y)
  {
    
    string strTime="";//时间
    string strNews="";//事件
    string strImportance="";  //重要性
     
    int    TimeLeftStrPosPre=0;
    int    TimeLeftStrPos=0;
    datetime StrTimePre=0;
    bool   clrChang=true;
    string t_="1971.12.31";
    color  clr_n=0;
    color  clr_r=C'5,36,61';
    int    cou=0;
    int    Lines=0;
    string str_1="";
    int    p_1=0,p_2=0;
    string n="";
    
    string TimeLeftStr= "<div class=\"visible-xs" ;
    
    while(cou<StringLen(news))
    {
      
      TimeLeftStrPos=StringFind(news,TimeLeftStr,cou);
      if(TimeLeftStrPos!=-1 && TimeLeftStrPosPre!=TimeLeftStrPos)
      {
        TimeLeftStrPosPre=TimeLeftStrPos;
        str_1="";
        p_1=StringFind(news,":",TimeLeftStrPos);
        if(p_1!=-1) 
        {  
        strTime=StringSubstr(news,p_1-2,5);
        }
        
        p_1=StringFind(news,"</div>",TimeLeftStrPos);
        p_2=StringFind(news,"</td>",p_1);
        if(p_1!=-1 && p_2!=-1) strNews=StringSubstr(news,p_1+10,p_2-p_1-10);
        
        p_1=StringFind(news,"<span class=\"label label-",TimeLeftStrPos);
        p_2=p_1+StringLen("<span class=\"label label-");
        if(p_1!=-1 && p_1-TimeLeftStrPos<800) str_1=StringSubstr(news,p_2,1);
        
        if(str_1=="L") { 
          strImportance="低"; 
   
        }
         else if(str_1=="M") {   
          strImportance="中"; 

        }
        else if(str_1=="H") { 
          strImportance="高"; 

        } 
        else {
          strImportance=""; 

        }
        //strTime是新闻整点时间 t_是加上日期了
        t_=StringSubstr((string)TimeLocal(),0,11)+strTime+":00";
      
        StrTimePre=StringToTime(t_);
        datetime now_time = StringToTime( StringSubstr((string)TimeLocal(),0,11) );

        if(StringToTime(t_)>= now_time  &&StringToTime(t_)< now_time + 86400)//每天更新一次
        {   
          newsstr[Lines].strTime=strTime;       
          if(StringSubstr(strTime,0,2) == "结果")
          {
            newsstr[Lines].strTime=newsstr[Lines-1].strTime;
          }
          newsstr[Lines].strNews=RePlaceSpace(strNews);
          newsstr[Lines].strImportance=strImportance;
          Lines++;
          if(Lines>59) break;
        }
      }
      cou++;
    }
    NewsLines=Lines;
    if(NewsLines%every_page != 0)
    {
    page_num = NewsLines/every_page+1;
    }
    else
    page_num = NewsLines/every_page;
    
  }
  
string New_Even::RePlaceSpace(string StrInput)//字符串处理 把 “ ”和"\n" 去除
  {
    string StrReturn="";
    for(int i=0;i<StringLen(StrInput);i++)
    {
      if(StringSubstr(StrInput,i,1)!=" " && StringSubstr(StrInput,i,1)!="\n"&& StringSubstr(StrInput,i,1)!="?")
       StrReturn+=StringSubstr(StrInput,i,1);
    }
    return(StrReturn);
  }

string New_Even::TimeFormat(datetime t)//转换时间格式
  {
    string year=IntegerToString(TimeYear(t));
    string month=IntegerToString(TimeMonth(t));
    string day=IntegerToString(TimeDay(t));
    int    week_=TimeDayOfWeek(t);
    string week;
    
    if(week_==0) week=", 星期日";
    else if(week_==1) week=", 星期一";
    else if(week_==2) week=", 星期二";
    else if(week_==3) week=", 星期三";
    else if(week_==4) week=", 星期四";
    else if(week_==5) week=", 星期五";
    else if(week_==6) week=", 星期六";
    
    if(StringLen(month)==1)month="0"+month;
    if(StringLen(day)==1)day="0"+day;
    
    return(year+"年"+month+"月"+day+"日"+week);
  }  
void New_Even::Read_News(int x,int y)//读取网页源码
{  
   string strURL="https://www.dailyfx.com.hk/calendar?ref=TopNav";
   int read[1];
   string NewsRead="";
   string strWebPage="";
   #define  size  1024
   uchar  buffer[size];
   bool   StartRead=false;
   string StartReadTime=TimeFormat(TimeLocal());
   string EndReadTime=TimeFormat(TimeLocal()+86400*2);//2天内的                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
   int    cou=0;
   
   int HttpOpen=InternetOpenW(" ",0," "," ",0);//初始化应用程序对WinINet函数的使用
   int HttpConnect = InternetConnectW(HttpOpen, "", 80, "", "", 3, 0, 1);//建立http链接
   int HttpRequest = InternetOpenUrlW(HttpOpen,strURL, NULL, 0, 0x04000000, 0);//url请求
   while(!IsStopped())
     {
      InternetReadFile(HttpRequest,buffer,size,read);//2指向接收数据的缓冲区的指针3要读取的字节数。
      if(read[0]>0)                         //指针指向接收所读字节数的变量。在进行任何工作或错误检查之前，InternetReadFile将此值设置为零
        {
        
         NewsRead=CharArrayToString(buffer,0,read[0],CP_UTF8);
         if(StringFind(NewsRead,StartReadTime,0)!=-1) StartRead=true;
         if(StringFind(NewsRead,EndReadTime,0)!=-1) StartRead=false;
         if(StartRead)strWebPage+=NewsRead;
        
        }
        
      else
         break;
     }
   ArrayFree(buffer);
   if(HttpRequest>0) InternetCloseHandle(HttpRequest);
   if(HttpConnect>0) InternetCloseHandle(HttpConnect);
   if(HttpOpen>0) InternetCloseHandle(HttpOpen);
       //Alert(strWebPage);
   NewsExecute(strWebPage,x,y);
  
}
void New_Even::Spa(string sparam)
{
   
   for(int i_=0; i_<page_num; i_++)
      {
         string num =(string)(i_+1);
         if(sparam == obj_name+"page_num"+num)
         {
         
            cur_page = i_+1;
            ObjectSet(obj_name+"page_num"+(string)cur_page,OBJPROP_COLOR,clr_cur); 
            for(int i=0;i<page_num;i++)
              {
              if((i+1)!=cur_page)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab); 
               
              }
            page_state =true; 
               
         }
       
       }
      if(sparam==obj_name+"next_page")
        { 
           
           if(cur_page<page_num)
           {
              cur_page++;
              ObjectSet(obj_name+"page_num"+(string)cur_page,OBJPROP_COLOR,clr_cur); 
              for(int i=0;i<page_num;i++)
              {
              
              if((i+1)!=cur_page)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab); 
               
              }   
              page_state =true; 
           }
        }
        if(sparam==obj_name+"before_page")
        { 
           if(cur_page>1)
           {
              cur_page = cur_page-1;
              ObjectSet(obj_name+"page_num"+(string)cur_page,OBJPROP_COLOR,clr_cur); 
              for(int i=0;i<page_num;i++)
              {
                 if((i+1)!=cur_page)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab); 
                  
              }
              page_state =true; 
           }   
        }   
          if(sparam==obj_name+"last_page")
        { 
           if(page_num>1)
           {
              cur_page =page_num;
              ObjectSet(obj_name+"page_num"+(string)page_num,OBJPROP_COLOR,clr_cur); 
               for(int i=0;i<page_num;i++)
               {
                 if((i+1)!=page_num)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab); 
                  
               }
               page_state =true; 
           }  
        }   
        
          if(sparam==obj_name+"first_page")
        { 
          if(page_num>1)
          {
              cur_page = 1;
              ObjectSet(obj_name+"page_num"+(string)1,OBJPROP_COLOR,clr_cur); 
              for(int i=0;i<page_num;i++)
              {
                 if((i+1)!=1)ObjectSet(obj_name+"page_num"+(string)(i+1),OBJPROP_COLOR,col_lab); 
                  
              }
              page_state =true; 
          }  
       }   
       
       
}

//文字显示函数-------------------------------------------------------------------------------------------|
bool Write(string LBL,int pos_x,int pos_y,string text,int fontsize,
           string fontname,color Tcolor,bool Select=true)
  {
    ResetLastError(); 
    if(ObjectFind(0,LBL)>=0)return true;
    if(!ObjectCreate(LBL,OBJ_LABEL,0,0,0)){
      Print(__FUNCTION__, 
            ": failed to create a label! Error code = ",GetLastError()); 
      return(false); 
    }
    ObjectSetText(LBL,text,fontsize,fontname,Tcolor);
    ObjectSet(LBL,OBJPROP_XDISTANCE,pos_x);
    ObjectSet(LBL,OBJPROP_YDISTANCE,pos_y);
    ObjectSetInteger(0,LBL,OBJPROP_SELECTABLE,Select); 
    ObjectSetInteger(0,LBL,OBJPROP_HIDDEN,true); 
    return(true);
  }

//设置背景色块函数---------------------------------------------------------------------------------------|
bool RectLabelCreate(const string           name="RectLabel",         // label name 
                     const int              x=0,                      // X coordinate 
                     const int              y=0,                      // Y coordinate 
                     const int              width=50,                 // width 
                     const int              height=18,                // height 
                     const color            back_clr=C'236,233,216',  // background color 
                     const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // border type 
                     const color            clr=clrRed,               // flat border color (Flat) 
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // flat border style 
                     const int              line_width=1,             // flat border width 
                     const bool             back=false,               // in the background 
                     const bool             selection=false,          // highlight to move 
                     const long             z_order=0)                // priority for mouse click 
  { 
   ResetLastError(); 
   if(!ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,0,0,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create a rectangle label! Error code = ",GetLastError()); 
      return(false); 
     } 
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x); 
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y); 
   ObjectSetInteger(0,name,OBJPROP_XSIZE,width); 
   ObjectSetInteger(0,name,OBJPROP_YSIZE,height); 
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,back_clr); 
   ObjectSetInteger(0,name,OBJPROP_BORDER_TYPE,border); 
   ObjectSetInteger(0,name,OBJPROP_COLOR,clr); 
   ObjectSetInteger(0,name,OBJPROP_STYLE,style); 
   ObjectSetInteger(0,name,OBJPROP_WIDTH,line_width); 
   ObjectSetInteger(0,name,OBJPROP_BACK,back); 
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(0,name,OBJPROP_SELECTED,selection); 
   ObjectSetInteger(0,name,OBJPROP_ZORDER,z_order);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);  
   return(true); 
  } 
   //图片显示函数-------------------------------------------------------------------------------------------|
bool CreateBitmap(string name,string file,int x,int y)
  {
    ResetLastError(); 
    if(!ObjectCreate(0,name,OBJ_BITMAP_LABEL,0,0,0)){
      Print(__FUNCTION__, 
            ": failed to create a Bitmap! Error code = ",GetLastError()); 
      return(false); 
    }
    ObjectSetString(0,name,OBJPROP_BMPFILE,file);
    ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x); 
    ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y); 
    ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
    ObjectSetInteger(0,name,OBJPROP_HIDDEN,true); 
    return(true);
  }
  
  
//显示输入框函数----------------------------------------------------------------------------------------------------------------//
bool EditCreate(const string           name="Edit",              // object name 
                const int              x=0,                      // X coordinate 
                const int              y=0,                      // Y coordinate 
                const int              width=50,                 // width 
                const int              height=18,                // height 
                const string           text="Text",              // text 
                const string           font="Arial",             // font 
                const int              font_size=10,             // font size 
                const bool             read_only=false,          // ability to edit 
                const color            clr=clrBlack,             // text color 
                const color            back_clr=clrWhite,        // background color 
                const color            border_clr=clrNONE,       // border color 
                const long             z_order=0)                // priority for mouse click 
  { 
   ResetLastError(); 
   if(!ObjectCreate(0,name,OBJ_EDIT,0,0,0)) 
     { 
      Print(__FUNCTION__, 
            ": failed to create \"Edit\" object! Error code = ",GetLastError()); 
      return(false); 
     } 
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x); 
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y); 
   ObjectSetInteger(0,name,OBJPROP_XSIZE,width); 
   ObjectSetInteger(0,name,OBJPROP_YSIZE,height); 
   ObjectSetString(0,name,OBJPROP_TEXT,text); 
   ObjectSetString(0,name,OBJPROP_FONT,font); 
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,font_size); 
   ObjectSetInteger(0,name,OBJPROP_READONLY,read_only); 
   ObjectSetInteger(0,name,OBJPROP_COLOR,clr); 
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,back_clr); 
   ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,border_clr); 
   ObjectSetInteger(0,name,OBJPROP_ZORDER,z_order); 
   
   ObjectSetInteger(0,name,OBJPROP_ALIGN,ALIGN_LEFT); 
   ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetInteger(0,name,OBJPROP_BACK,false); 
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false); 
   ObjectSetInteger(0,name,OBJPROP_SELECTED,false);  
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,false); 
   return(true); 
  } 