Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2003 12:23:29 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:42174 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225363AbTIKCNi>;
	Thu, 11 Sep 2003 03:13:38 +0100
Received: (qmail 17527 invoked from network); 11 Sep 2003 02:00:42 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 11 Sep 2003 02:00:42 -0000
From: "=?GB2312?Q?=B9=E3=D0=C7?=" <guangxing@ict.ac.cn>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
CC: angela <jhyang@ict.ac.cn>,
	=?GB2312?Q?=D0=BB=B2=A9=CA=BF?= <xie@ict.ac.cn>
Subject: Some  Question about the kernel module on MIPS64
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: multipart/related;
      boundary="=====001_Dragon736316147414_=====";
      type="multipart/alternative"
Date: Thu, 11 Sep 2003 10:13:58 +0800
Message-Id: <20030911021338Z8225363-1272+5279@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3162
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--=====001_Dragon736316147414_=====
Content-Type: multipart/alternative;
      boundary="=====002_Dragon736316147414_====="


--=====002_Dragon736316147414_=====
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable


 
   Hi, everyone!
   I am a newbie on doing some development on MIPS(of course it=
 is the linux make me can touch it without any  hesitation).There=
 are two questions  as follow hoping your enthusiastic answers.
   1) I want to know if the linux for mips64 support the=
 customer's kernel module .if yes, is there any modutils i can=
 use?And how can i get it.
   2) I have written a simplest simplest kernel module for linux=
 for mips64 (only the init()and cleanup() we can see,and we do=
 nothing.) and with the crossing compiling tool it is ok.One=
 thing confused me is that it can be "insmod" in the linux for=
 mips32, but when we try to "insmod" in the linux for mips64, we=
 get the following error:
[root@(none) root]# insmod try.o
init_module: Invalid module header size.
A new version of the modutils is likely needed.
try.o: init_module: Invalid argument
Hint: insmod errors can be caused by incorrect module parameters,=
 including invalid IO or IRQ parameters
Of course we do the above works in the same hardware platform .
Is there any thing I should pay attention to when I compile the=
 Kernel Module or the linux for mips64? Eagering your help!!
Thank you  you in advance!
    

=A1=A1=A1=A1
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D7=A3
  =BF=AA=D0=C4!
     Far and away the best prize that life offers is the chance=
 to work hard at work worth doing. =B9=E3=D0=C7
guangxing@ict.ac.cn
2003-09-11
           \\\|///
          \\ - - //
           ( @ @ )
--------oOOo-(_)-oOOo---------

       =B9=E3=D0=C7=D7=A3=C4=FA=D3=E4=BF=EC=BD=A1=BF=B5
               0ooo
-------- oooO--(   )----------
        (   )   ) /
         \ (   (_/
          \_)
=A1=A1



 

--=====002_Dragon736316147414_=====
Content-Type: text/html;
      charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>=B5=AD=D1=C5=D6=AE=C2=CC</TITLE>
<META content=3D"text/html; charset=3Dgb2312"=
 http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3806.1700" name=3DGENERATOR>
<STYLE type=3Dtext/css>
<!--
td {  font-family: "=CB=CE=CC=E5"; font-size: 14px; color: #000000;=
 font-weight: normal}
-->
</STYLE>
</HEAD>
<BODY bgColor=3D#79bb87 leftMargin=3D0 text=3D#000000 topMargin=3D0>
<DIV align=3Dcenter>
<TABLE background=3Dcid:__0@Foxmail.net border=3D0 cellPadding=3D0=
 cellSpacing=3D0 
height=3D90 width=3D640>
  <TBODY>
  <TR>
    <TD>
      <TABLE align=3Dcenter border=3D0 cellPadding=3D0 cellSpacing=3D0=
 width=3D"90%">
        <TBODY>
        <TR>
          <TD>
            <DIV>&nbsp;</DIV>
            <DIV></DIV></TD></TR>
        <TR>
          <TD>&nbsp;</TD></TR>
        <TR>
          <TD>
            <P><FONT size=3D2>&nbsp;&nbsp; Hi,=
 everyone!</FONT></P>
            <P><FONT size=3D2>&nbsp;&nbsp; I am a newbie&nbsp;on=
 doing some 
            development on MIPS(of course&nbsp;it is the linux 
            make&nbsp;me&nbsp;can touch it without any=
 &nbsp;hesitation).There 
            are two questions&nbsp; as follow hoping your=
 enthusiastic 
            answers.</FONT></P>
            <P><FONT size=3D2>&nbsp;&nbsp; 1) I want to know if the=
 linux&nbsp;for 
            mips64 support the customer's&nbsp;kernel=
 module&nbsp;.</FONT><FONT 
            size=3D2>if yes,&nbsp;is there any modutils i can=
 use?And how can i 
            get it.</FONT></P>
            <P><FONT size=3D2>&nbsp;&nbsp; </FONT>2) I have written=
 a simplest 
            simplest&nbsp;kernel module for linux for mips64=
 (only the init()and 
            cleanup() we can see,and we do nothing.) and with the=
 crossing 
            compiling tool it is ok.One thing confused me is that=
 it can be 
            "insmod" in the linux for mips32, but when we try to=
 "insmod" in the 
            linux for mips64, we get the following error:</P>
            <P><STRONG>[root@(none) root]# insmod=
 try.o<BR>init_module: Invalid 
            module header size.<BR>A new version of the modutils=
 is likely 
            needed.<BR>try.o: init_module: Invalid=
 argument<BR>Hint: insmod 
            errors can be caused by incorrect module parameters,=
 including 
            invalid IO or IRQ parameters</STRONG></P>
            <P>Of course we do the above works in the=
 same&nbsp;hardware 
            platform .</P>
            <P>Is there any thing I should pay attention to when=
 I compile the 
            Kernel Module or the linux for mips64? Eagering your=
 help!!</P>
            <P>Thank you  you in advance!</P>
            <P><STRONG>&nbsp;&nbsp;&nbsp; 
 =
 </STRONG></P></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE=
>
<TABLE background=3Dcid:__1@Foxmail.net border=3D0 cellPadding=3D0=
 cellSpacing=3D0 
width=3D640>
  <TBODY>
  <TR>
    <TD>
      <TABLE align=3Dcenter border=3D0 cellPadding=3D0 cellSpacing=3D0=
 width=3D"90%">
        <TBODY>
        <TR>
          <TD>
            <DIV><FONT size=3D2>=A1=A1=A1=A1</FONT></DIV>
            <DIV>
            <DIV>
            <DIV></DIV>
            <DIV>
            <DIV><FONT size=3D2>=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=D7=A3<BR>&nbsp;=
 =BF=AA=D0=C4!</FONT></DIV></DIV></DIV>
            <DIV></DIV></DIV>
            <DIV></DIV>
            <TABLE align=3Dcenter border=3D0 cellPadding=3D0=
 cellSpacing=3D0 height=3D86 
            width=3D"80%">
              <TBODY>
              <TR>
                <TD rowSpan=3D3 width=3D"50%">
                  <DIV><FONT=
 size=3D3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Far and away 
                  the best prize that life offers is the chance=
 to work hard at 
                  work worth doing. </FONT></DIV></TD>
                <TD>
                  <DIV><FONT size=3D2>=B9=E3=D0=C7</FONT></DIV></TD></TR>
              <TR>
                <TD>
                  <P><FONT size=3D2><A 
                 =
 href=3D"mailto:guangxing@ict.ac.cn">guangxing@ict.ac.cn</A></FONT>=
</P>
                  <P>2003-09-11</P></TD></TR>
              <TR>
                <TD>
                 =
 <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 
                 =
 \\\|///<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; 
                  \\ - - 
                 =
 //<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 
                  ( @ @ 
                 =
 )<BR>--------oOOo-(_)-oOOo---------<BR><BR>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 
                  &nbsp;<A 
                 =
 href=3D"http://www.foxmail.com.cn/">=B9=E3=D0=C7=D7=A3=C4=FA=D3=E4=BF=EC=BD=A1=BF=B5</A><BR>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 
                  0ooo<BR>-------- oooO--(&nbsp;&nbsp; 
                 =
 )----------<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  (&nbsp;&nbsp; )&nbsp;&nbsp; ) 
                 =
 /<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \ 
                  (&nbsp;&nbsp; 
                 =
 (_/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  \_)<BR>=A1=A1</P>
                  <P 
     =
 align=3Dleft>&nbsp;</P></TD></TR></TBODY></TABLE></TD></TR></TBODY=
></TABLE></TD></TR></TBODY></TABLE>
<TABLE background=3Dcid:__2@Foxmail.net border=3D0 cellPadding=3D0=
 cellSpacing=3D0 
height=3D40 width=3D640>
  <TBODY>
  <TR>
    <TD>&nbsp;</TD></TR></TBODY></TABLE></DIV></BODY></HTML>

--=====002_Dragon736316147414_=====--

--=====001_Dragon736316147414_=====
Content-Type: image/gif;
      name="greenmail01.gif"
Content-Transfer-Encoding: base64
Content-ID: <__0@Foxmail.net>

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

--=====001_Dragon736316147414_=====
Content-Type: image/gif;
      name="greenmail02.gif"
Content-Transfer-Encoding: base64
Content-ID: <__1@Foxmail.net>

R0lGODlhgAIUAKIAAMveuarVoXm7h2ymeFF9WgAAAAAAAAAAACH5BAAAAAAALAAAAACAAhQAAAP/
KLrcOyTISau9OOvNu/9gKI5kaZ5oqq5s675wLFfE4Nx47kAB4P/AILAnLAaJxiQyWVwyj0+jM+qb
Uq1R7FPL5CqpQq8UDCX/xE3zWV1lA9BhN7ysng/leLZ9za7p/oAPEXl1hGZ7bXqGZIhvi2CNkY9X
k1mVW5ddmV+KnYWeh5tGfoGlODyiaaCMqXGrkK10oa+UtJa2mLiaupyfvrO/rLxjw0WkpsiCksWu
wbDMssLOtdO31bnXu9m9wN3S3s/bxOKq5M1mx8nIqNB37Xzm0eHg1PTW9tj42vrc3/7z/+oFvDcw
X8F9B5OkU1eKXTx3D+HxGzexXMVzCSlmtLgR/yPAjwJBEhRpkCRCk/1QagSzkCEghxflhZw5kmZJ
mydxptS5kidHlT99ehQqs6bRm0dzJt25dJQNl6ZgdiyKtKpSq0yx9mwalOtQr1Svis06dqvWrme/
pg1Ltq1ZJi2h5pAKVG1ZtHftusW7V+/bvmz/CuY72C/hw4YTB0a8WDHEmI/JxJV7gy7RyHUba8Z8
WeJUzmBBrxWdd7PnzKQBpy5sOlFE15BPd/YxmXIDy6Fl54b9Wfdo36VXMxbuGLhq46yJt3b0jjdq
5MOhF3c+G0Bt28piKd8uffmy18zBf49NfXd48ud7l/+9Pnh37u2Px0/+4zp2AbjZp38+P3r/6bz7
VTeeegGaNyB/Bep3oIDavefgf965YR92+bkHIXwJWpihfBvSd+GDHfoXIoALGtjghyiOGGFzKmLY
yIS2VchhiQqe2CKINGqY44w27ujhjSn6KKKQJNoII2Uy/kjkiuL16CSLS7r4ZJNQTolelDhK+NR9
pwxS5ZdUhnmllQRiGSSZCJoJ5Jpqtqkll3N5KWaZaDII5ph30plnmnWauKed4B0pV5JD9lnjn37O
ySeihyoKKJ6OJoqeoAskAAA7

--=====001_Dragon736316147414_=====
Content-Type: image/gif;
      name="greenmail03.gif"
Content-Transfer-Encoding: base64
Content-ID: <__2@Foxmail.net>

R0lGODlhgAIoALMAAHm7h2eTblF9WmumeFmKY5SujHSzgnCtfW2pelSCXmmidcveuarVobfMqMHV
sajDnSH5BAAAAAAALAAAAACAAigAAAT/EMhJ6zyB6c27/2AojmRpnmiqrmzrvnAsz3Rt33iud8Fh
/cCgBZFgLI7IpDJpXDqVzac0KnVSq1Ds86o9crtfbRg7rpan3eV5m862kWvrGz731hdx9T3vnvOZ
e4F1f3R1CQhCiYoTAwKEdoOCfpJvj3iUbZaamGmbkZ+ToJWcYKRipmSoZqpodQIDi7FBjZ6htqOi
maxsuZ27cr2lwafDqcWrx623usm8y77NTq+y1BW0v3rR2c/C3MTexuDI4sq45M7m6cznwOzb6tDu
ffBd09X319rz6/Tf/eH/xgUsx69gvIHoDHZD2I7hO4X+IAKUKJCiFHv3qOWTB0hfR46F/0BCEnnJ
Y0iH+w5aTKiy5cKVDWE+dBmR5kSbVTBmjLUR5UefJ2WmfImTYFGWRJPWVHqTacWjMaHOdGqUKtKl
WJtq0blTEQJH2IZmfWo1atmpY6umvaq1Ldm1ZuGidauWLtu3duPmnYtXioNDXWUReRD2p1DDUsXu
Vdy3buO7jiNDnqz3cWXJlynzxbxZM2POn500ABx40QECBQoHTYz4bOjMsDvHfi27Nu3breXiXu06
92Lflm0DBz3cM5IHBHyUVnQageqRQKEf5q27+Gzrwqn/1h58t3TW3ImHNz7+evns33ufT1Ig+XJF
BgIEeF6SZK3o9fHfn56++nrs3uXHn/+A4PW3nYHdAajgfwwi+IR8BryniAIC0LdfgQSq5yB5G5rX
IXoZ+vdhgBdqGOKBJybYYIrijbigi0ckoICEXhHQgEkw5sgihzt62COIJYr4I4kWFonjkC8iuWKQ
KDL5RAMEIEKjEPHNZ5+RVx7pZItK6rglj1/6GCaQWOpX5nQQTpkIAqhl6aaZWp6J4ZhExmnnmwPS
maSeS77RnpRqBmGAAgmklqecJvLpJaJCKtrlo45GymiTk6o4YgEyRhgolQoQEMCNiVbKpaR3wonn
nKKCmaqYq5IZTQMBEKCApptSiUCsAgRQwAMNOKBqqYcCi6qwoRLbaKt1nlqssks50MD/AwUEkICn
CNBaayIGIKBArAQkkIAA4IYr7rjklmvuueimq+667Lbr7rvwxivvvPTWa++9+Oar77789uvvv+16
S4CnClR77T0GHHAAAggM4PDDEEcs8cQUV2zxxRhnrPHGHHfs8ccghyzyyCSXbPLJKKes8sost7wx
wwpbe/DMNNds880456zzzjz37PPPQAct9NBEF2300UgnrfTSTDft9NNQRy311FRXbfXVWGet9dZc
d+3112CHLfbYZJdt9tlop6322my37fbbcMct99x012333XjnrffefPft99+ABy744IQXbvjhiCeu
+OKMN+7445BHLvnklFdu+eWYZ675GOacd+7556CHLvropJdu+umop6766rFEAAA7

--=====001_Dragon736316147414_=====--
