Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Sep 2004 06:06:44 +0100 (BST)
Received: from [IPv6:::ffff:218.108.42.27] ([IPv6:::ffff:218.108.42.27]:51943
	"EHLO hzvscan2.utstar.com.cn") by linux-mips.org with ESMTP
	id <S8224793AbUIDFGk>; Sat, 4 Sep 2004 06:06:40 +0100
Received: from cnmail01.cn.utstarcom.com (localhost [127.0.0.1])
	by hzvscan2.utstar.com.cn (8.11.6/8.11.6) with SMTP id i8452Mj21518
	for <linux-mips@linux-mips.org>; Sat, 4 Sep 2004 13:02:28 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4923C.F6E5C2D0"
Subject: Why the program complied by mips-linux-g++  cann't run on the target machine
Date: Sat, 4 Sep 2004 13:06:39 +0800
Message-ID: <BA3B937FD9473E41998E125463A3914301C68183@cnmail01.cn.utstarcom.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Why the program complied by mips-linux-g++  cann't run on the target machine
Thread-Index: AcSSPPYnv/+Wr/hoSVWlrfJDHvGxVg==
From: "Li Shishan" <lishishan@utstar.com>
To: <linux-mips@linux-mips.org>
Return-Path: <lishishan@utstar.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lishishan@utstar.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4923C.F6E5C2D0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable


    Hi, all:

               I  use the   mips-linux-g++  complie a program.  and I =
excuted it on the target machine , but cann't, what's wrong?
    =20
              For example:

               For PC, I use g++  -c -o ccgame.o ccgame.cpp
		                    g++  -o ccgame ./ccgame.o
		execute it will give: Hello, world!

		For the target board, I use mips-linux-g++  -c -o ccgame.o ccgame.cpp=20
		                             mips-linux-g++  -o ccgame ./ccgame.o
		excute it will give " /bin/sh: ./ccgame: not found".=20

		Is there something wrong?=20

		the mips-linux-gcc work is well!!!

		looking forward for anybody send me the question answer,very thanks!!!

		your sincerely liss

		2004.09.04  13:06


        =20
            =20

------_=_NextPart_001_01C4923C.F6E5C2D0
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.6980.72">
<TITLE>Why the program complied by mips-linux-g++  cann't run on the =
target machine</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->
<BR>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp; Hi, all:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; I&nbsp; use the&nbsp;&nbsp; =
mips-linux-g++&nbsp; complie a program.&nbsp; and I excuted it on the =
target machine , but cann't, what's wrong?</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; For example:</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;</FONT></SPAN><SPAN =
LANG=3D"zh-cn"></SPAN><SPAN LANG=3D"zh-cn"></SPAN><SPAN LANG=3D"zh-cn"> =
<FONT SIZE=3D2 FACE=3D"Simsun">For PC, I use<B> g++</B></FONT><B><FONT =
SIZE=3D2 FACE=3D"Courier New"></FONT>&nbsp;<FONT SIZE=3D2 =
FACE=3D"Simsun"> -c -o ccgame.o ccgame.cpp</FONT></B></SPAN></P>
<UL DIR=3DLTR><UL DIR=3DLTR>
<P DIR=3DLTR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;</FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"></FONT> =
<FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;</FONT>&nbsp;<FONT =
SIZE=3D2 FACE=3D"Simsun"></FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;</FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"></FONT> =
<FONT SIZE=3D2 FACE=3D"Courier New">&nbsp;&nbsp;</FONT>&nbsp;<FONT =
SIZE=3D2 FACE=3D"Simsun"></FONT> <FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;</FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"></FONT><B> =
<FONT SIZE=3D2 FACE=3D"Simsun">g++</FONT><FONT SIZE=3D2 FACE=3D"Courier =
New"></FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"> -o</FONT><FONT =
SIZE=3D2 FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 =
FACE=3D"Simsun">ccgame ./ccgame.o</FONT></B></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Simsun">execute =
it will give: Hello, world!</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Simsun">For =
the</FONT></SPAN><SPAN LANG=3D"en-us"></SPAN><SPAN LANG=3D"en-us"> <FONT =
SIZE=3D2 FACE=3D"Courier New">target</FONT></SPAN><SPAN =
LANG=3D"zh-cn"></SPAN><SPAN LANG=3D"zh-cn"> <FONT SIZE=3D2 =
FACE=3D"Simsun">board, I use</FONT></SPAN><SPAN LANG=3D"zh-cn"><B> <FONT =
SIZE=3D2 FACE=3D"Simsun">mips-linux-g++</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"> -c -o =
ccgame.o ccgame.cpp</FONT></B><FONT SIZE=3D2 FACE=3D"Simsun"></FONT> =
</SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT><B> <FONT SIZE=3D2 =
FACE=3D"Courier =
New">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</FONT> <FONT =
SIZE=3D2 FACE=3D"Simsun">mips-linux-g++</FONT><FONT SIZE=3D2 =
FACE=3D"Courier New"></FONT>&nbsp;<FONT SIZE=3D2 FACE=3D"Simsun"> =
-o</FONT><FONT SIZE=3D2 FACE=3D"Courier New"></FONT> <FONT SIZE=3D2 =
FACE=3D"Simsun">ccgame ./ccgame.o</FONT></B></SPAN></P>

<P DIR=3DLTR><B><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Courier =
New">excute it</FONT></SPAN><SPAN LANG=3D"zh-cn"></SPAN></B><SPAN =
LANG=3D"zh-cn"></SPAN><SPAN LANG=3D"zh-cn"> <FONT SIZE=3D2 =
FACE=3D"Simsun">will give</FONT><B> <FONT SIZE=3D2 =
FACE=3D"Simsun">&quot; /bin/sh: ./ccgame: not =
found&quot;</FONT></B><FONT SIZE=3D2 FACE=3D"Simsun">.</FONT><FONT =
FACE=3D"Simsun"> </FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"zh-cn"><FONT SIZE=3D2 FACE=3D"Simsun">Is =
there something wrong?</FONT> </SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Simsun">the =
mips-linux-gcc work is well!!!</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Simsun">looking forward =
for anybody send me the question answer,very thanks!!!</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Simsun">your sincerely =
liss</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT FACE=3D"Simsun">2004.09.04&nbsp; =
13:06</FONT></SPAN><SPAN LANG=3D"zh-cn"></SPAN><SPAN =
LANG=3D"zh-cn"></SPAN></P>
<BR>
</UL></UL>
<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</FONT></SPAN></P>

<P DIR=3DLTR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;</FONT></SPAN><SPAN LANG=3D"zh-cn"></SPAN><SPAN =
LANG=3D"zh-cn"> </SPAN></P>

</BODY>
</HTML>
------_=_NextPart_001_01C4923C.F6E5C2D0--
