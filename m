Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Dec 2003 14:58:32 +0000 (GMT)
Received: from [IPv6:::ffff:203.199.202.17] ([IPv6:::ffff:203.199.202.17]:28936
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225208AbTLKO6a>; Thu, 11 Dec 2003 14:58:30 +0000
Received: from DURAI ([192.168.0.107])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id hBBEujF29651;
	Thu, 11 Dec 2003 20:26:49 +0530
Message-ID: <008f01c3bff7$252e3b40$0a05a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: "uclinux-dev" <uclinux-dev@uclinux.org>
Cc: "mips" <linux-mips@linux-mips.org>
Subject: Network problem in mips
Date: Thu, 11 Dec 2003 20:27:46 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_008C_01C3C025.3CC481A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <durai@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: durai@isofttech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_008C_01C3C025.3CC481A0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
I am working on a wireless lan driver in mips platform. When i =
transmit/receive the data at 11mbps, it is working smoothly. when i =
change the tx speed to 54mbps, the system crashes at schedule() =
function. I am not able to trace from where the crash occurs. where =
could be the problem?=20


Kernel unaligned instruction access in unaligned.c:do_ade, line 428:
$0 : 00000000 a0000000 00097fff ffffffff 80fa228c ba000000 a0f40000 =
00000000
$8 : 00000045 00000001 00ff0000 00ff0000 80fa228c 80f90738 00003b00 =
80fdd812
$16: 80fa2000 80fe8221 80fe6010 00008da9 ff000000 00ff0000 80fa2000 =
a0f40000
$24: 00000001 80494970                   8043a000 8043a118 80fa228c =
80f930c1
epc  : 80f930c1
Status: 3000fc00
Cause : 00000010
Process   (pid: -2142680720, stackpage=3D8043a000)
Stack: 00000000 00000000 00000000 00000000 ff000000 80fa2000 00ff0000 =
00000000
       00000000 00000000 00000003 8043a1b8 80fa228c 80f9119c 00000000 =
00000000
       00000000 00000000 803b3b80 00010000 00000010 80390d74 00000004 =
00000001
       802a83fc 00000000 00000000 00000000 00000000 00000000 80fa2010 =
ba000000
       80fe9810 00008da5 00000000 00ff0000 80fa2000 a0f40000 8020b570 =
00000000
       00000000 ...
Call Trace: [<802a83fc>] [<8020b570>] [<8020ae08>] [<80206000>] =
[<802d64e4>] [<802a83fc>] [<8020b570>] [<8020ae08>] [<8
02d64e4>] [<802d64e4>] [<802a83fc>] [<8020b570>] [<8020ae08>] =
[<802d64e4>] [<802d64e4>] [<802a83fc>] [<8020b570>] [<802
0ae08>] [<802d64e4>] [<802d64e4>] [<802a83fc>] [<8020b570>] [<8020ae08>] =
[<802d64e4>] [<802d64e4>] [<802a83fc>] [<802a8
3b4>] [<8020b570>] [<8021f148>] [<8020ae08>] [<802d64e4>] [<802d64e4>] =
[<8021eb24>] [<8021eb24>] [<802a83fc>] [<802a83b
4>] [<802a8ad4>]
Code:Unaligned memory access at 8020b780, address 80f930b5, PID =
-2142680720 ( )
Kernel unaligned instruction access in unaligned.c:do_ade, line 428:
$0 : 00000000 3000fc00 00000001 3000fc00 80392130 00000001 00000001 =
0000168d
$8 : 00000000 00000000 80439ef0 00000000 00000000 803aa52b fffffffe =
80439ea7
$16: 80f930b5 fffffffd 00000020 00008da9 ff000000 00ff0000 80fa2000 =
a0f40000
$24: ffffffff 00000010                   8043a000 80439fe8 80fa228c =
8020b748
epc  : 8020b784
Status: 3000fc00
Cause : 0000e010
Process   (pid: -2142680720, stackpage=3D8043a000)
Stack: 80343bec 00000001 00000001 0000167c 8043a068 80344be4
Call Trace: [<80343bec>] [<80344be4>]
Code: 10400008  00000000  8e060000 <00001021> 1040fff2  2405003c  =
3c048034  0c08534c  24843bf4
Kernel panic: Aiee, killing interrupt handler

In interrupt handler - not syncing



regards
durai
------=_NextPart_000_008C_01C3C025.3CC481A0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am working on a wireless lan driver =
in mips=20
platform. When&nbsp;i transmit/receive the data at 11mbps, it is working =

smoothly. when i change the tx speed to 54mbps, the system crashes at =
schedule()=20
function. I am not able to trace from where the crash occurs. where =
could be the=20
problem? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Kernel unaligned instruction access in=20
unaligned.c:do_ade, line 428:<BR>$0 : 00000000 a0000000 00097fff =
ffffffff=20
80fa228c ba000000 a0f40000 00000000<BR>$8 : 00000045 00000001 00ff0000 =
00ff0000=20
80fa228c 80f90738 00003b00 80fdd812<BR>$16: 80fa2000 80fe8221 80fe6010 =
00008da9=20
ff000000 00ff0000 80fa2000 a0f40000<BR>$24: 00000001=20
80494970&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
8043a000 8043a118 80fa228c 80f930c1<BR>epc&nbsp; : 80f930c1<BR>Status:=20
3000fc00<BR>Cause : 00000010<BR>Process &nbsp; (pid: -2142680720,=20
stackpage=3D8043a000)<BR>Stack: 00000000 00000000 00000000 00000000 =
ff000000=20
80fa2000 00ff0000 00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
00000000=20
00000000 00000003 8043a1b8 80fa228c 80f9119c 00000000=20
00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 00000000 =
803b3b80=20
00010000 00000010 80390d74 00000004=20
00000001<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 802a83fc 00000000 =
00000000=20
00000000 00000000 00000000 80fa2010=20
ba000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80fe9810 00008da5 =
00000000=20
00ff0000 80fa2000 a0f40000 8020b570=20
00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 ...<BR>Call =
Trace:=20
[&lt;802a83fc&gt;] [&lt;8020b570&gt;] [&lt;8020ae08&gt;] =
[&lt;80206000&gt;]=20
[&lt;802d64e4&gt;] [&lt;802a83fc&gt;] [&lt;8020b570&gt;] =
[&lt;8020ae08&gt;]=20
[&lt;8<BR>02d64e4&gt;] [&lt;802d64e4&gt;] [&lt;802a83fc&gt;] =
[&lt;8020b570&gt;]=20
[&lt;8020ae08&gt;] [&lt;802d64e4&gt;] [&lt;802d64e4&gt;] =
[&lt;802a83fc&gt;]=20
[&lt;8020b570&gt;] [&lt;802<BR>0ae08&gt;] [&lt;802d64e4&gt;] =
[&lt;802d64e4&gt;]=20
[&lt;802a83fc&gt;] [&lt;8020b570&gt;] [&lt;8020ae08&gt;] =
[&lt;802d64e4&gt;]=20
[&lt;802d64e4&gt;] [&lt;802a83fc&gt;] [&lt;802a8<BR>3b4&gt;] =
[&lt;8020b570&gt;]=20
[&lt;8021f148&gt;] [&lt;8020ae08&gt;] [&lt;802d64e4&gt;] =
[&lt;802d64e4&gt;]=20
[&lt;8021eb24&gt;] [&lt;8021eb24&gt;] [&lt;802a83fc&gt;] =
[&lt;802a83b<BR>4&gt;]=20
[&lt;802a8ad4&gt;]<BR>Code:Unaligned memory access at 8020b780, address=20
80f930b5, PID -2142680720 (&nbsp;)<BR>Kernel unaligned instruction =
access in=20
unaligned.c:do_ade, line 428:<BR>$0 : 00000000 3000fc00 00000001 =
3000fc00=20
80392130 00000001 00000001 0000168d<BR>$8 : 00000000 00000000 80439ef0 =
00000000=20
00000000 803aa52b fffffffe 80439ea7<BR>$16: 80f930b5 fffffffd 00000020 =
00008da9=20
ff000000 00ff0000 80fa2000 a0f40000<BR>$24: ffffffff=20
00000010&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
8043a000 80439fe8 80fa228c 8020b748<BR>epc&nbsp; : 8020b784<BR>Status:=20
3000fc00<BR>Cause : 0000e010<BR>Process &nbsp; (pid: -2142680720,=20
stackpage=3D8043a000)<BR>Stack: 80343bec 00000001 00000001 0000167c =
8043a068=20
80344be4<BR>Call Trace: [&lt;80343bec&gt;] [&lt;80344be4&gt;]<BR>Code:=20
10400008&nbsp; 00000000&nbsp; 8e060000 &lt;00001021&gt; 1040fff2&nbsp;=20
2405003c&nbsp; 3c048034&nbsp; 0c08534c&nbsp; 24843bf4<BR>Kernel panic: =
Aiee,=20
killing interrupt handler</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>In interrupt handler - not =
syncing</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>durai</FONT></DIV></BODY></HTML>

------=_NextPart_000_008C_01C3C025.3CC481A0--
