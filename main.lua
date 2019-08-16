require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "layout"
--activity.setTitle('AndroLua+')
--activity.setTheme(android.R.style.Theme_Holo_Light)
import"http"
InputLayout={
  LinearLayout;
  orientation="vertical";
  Focusable=true,
  FocusableInTouchMode=true,
  {
    EditText;
    hint="点我";
    layout_marginTop="5dp";
    layout_width="80%w";
    layout_gravity="center",
    InputType="number";
    id="edit";
  };
};

AlertDialog.Builder(this)
.setTitle("输入UID")
.setView(loadlayout(InputLayout))
.setPositiveButton("确定",{onClick=function(v) lolol()end})
.setNegativeButton("取消",nil)
.show()


function lolol()
  a=http.get("https://api.bilibili.com/x/web-interface/card?mid="..edit.Text)
  lvl= a:match([["current_level":(.-),]])
  b= a:match([["mid":"(.-)"]])
  c= a:match([["name":"(.-)"]])
  ban= a:match([["spacesta":(.-),]])
  e= a:match([["face":"(.-)"]])
  vip= a:match([["vipType":(.-),]])

  if vip=="0" then
    qqq="未开通大会员"
   elseif vip=="1" then
    qqq="开通过大会员"
   elseif vip=="2" then
    qqq="开通过年度大会员"
  end

  if ban == "0" then
    g="未封禁"
   elseif ban == "-2" then
    g="已被封禁"
  end

  if b=="2919621" then
    d="已和谐"
   else
    d= a:match([["sign":"(.-)"]])
  end

  if e:find(".jpg") then
    file=".jpg"
   elseif e:find(".gif") then
    file=".gif"
   elseif e:find(".png") then
    file=".png"
  end

  layout={
    LinearLayout;
    orientation="vertical";
    layout_width="fill";
    layout_height="fill";
    id="card";
    background="#FFFFFF";
    {
      TextView;
      textColor="#FF000000";
      text=c;
      id="username";
      layout_margin="30dp";
      textSize="48dp";
      layout_marginBottom="0";
    };
    {
      TextView;
      textColor="#ffaaaaaa";
      text=b.." "..qqq.." Lv. "..lvl;
      textSize="18dp";
      layout_marginTop="0";
      layout_margin="30dp";
    };
    {
      TextView;
      layout_marginTop="0";
      layout_margin="30dp";
      text=d;
      textSize="18dp";
    };
    {
      TextView;
      layout_marginTop="0";
      layout_margin="30dp";
      textColor="#fa4694";
      text=g;
      textSize="15dp";
    };
    {
      ImageView;
      layout_marginTop="0";
      layout_margin="30dp";
      layout_height="fill";
      layout_width="fill";
      id="avatar";
    };
  };

  activity.setContentView(loadlayout(layout))
  avatar.setImageBitmap(loadbitmap(e))
  username.onLongClick=function()
    AlertDialog.Builder(this)
    .setTitle("输入UID")
    .setView(loadlayout(InputLayout))
    .setPositiveButton("确定",{onClick=function(v) lolol()end})
    .setNegativeButton("取消",nil)
    .show()
  end
  avatar.onLongClick=function()
    AlertDialog.Builder(this)
    .setTitle("下载头像？")
    .setPositiveButton("下载",{onClick=function(v)
        print"已保存至 myCard Downloads 目录下"
        import "android.content.Context"
        import "android.net.Uri"
        downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
        url=Uri.parse(e);
        request=DownloadManager.Request(url);
        request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
        request.setDestinationInExternalPublicDir("myCard Downloads","avatar_"..b..file);
        request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
        downloadManager.enqueue(request);
        end})
    .setNegativeButton("取消",nil)
    .show()
  end
end