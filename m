Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 01:07:43 +0000 (GMT)
Received: from [IPv6:::ffff:209.172.108.133] ([IPv6:::ffff:209.172.108.133]:52884
	"HELO [209.172.108.133]") by linux-mips.org with SMTP
	id <S8225474AbUATBHn>; Tue, 20 Jan 2004 01:07:43 +0000
Received: from essmail.esstech.com by [209.172.108.133]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; Mon, 19 Jan 2004 17:07:42 -0800
Received: from wliupc ([172.18.13.106]) by ess2kmail.essnet.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Mon, 19 Jan 2004 17:07:34 -0800
Message-ID: <002d01c3def2$cbc76480$6a0d12ac@ess>
From: "wei liu" <wei.liu@esstech.com>
To: <linux-mips@linux-mips.org>
Subject: unaligned problem in linux2.4.18?
Date: Mon, 19 Jan 2004 17:14:47 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002A_01C3DEAF.BD71C9E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 20 Jan 2004 01:07:34.0455 (UTC) FILETIME=[C96FFC70:01C3DEF1]
Return-Path: <Wei.Liu@esstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wei.liu@esstech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_002A_01C3DEAF.BD71C9E0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

I'm using mips-4kc core and try to port linux2.4.18. When kernel starts, =
it display the following OOP
Unhandled kernel unaligned access in =
unaligned.c:emulate_load_store_insn, line 3
51:
$0 : 00000000 801d0000 ffd82b0b 00000001 fff60ac0 0000000b 80237ef8 =
00000001
$8 : 1000fc00 1000001f 0000001d 12e09bff 00ffffff a0e00010 000000ff =
00000018
$16: 801d64e4 00000000 80002adc 00000004 bfd5a450 00000005 00000004 =
b3ff0000
$24: a0000000 800a1e4c                   80236000 80237eb0 bfc00598 =
80009aa4
Hi : 00000005
Lo : 80010fb8
epc  : 8000993c    Not tainted
Status: 1000fc02
Cause : 10800010
Process=FFg=FF=FF4=FF=FF=FF=FF[9=FF=FF5=FF=FF=FF=FF=FF (pid: -143232658, =
stackpage=3D80234000)
Stack: 5a24a5ab 2e29b637 30313233 34353637 80009aa4 63646566 30313233 =
34353637
       38396162 63646566 10801000 80092d54 000088c9 0000003e 80010b98 =
00353637
       80092960 34353637 000008c5 ffffffff 000088c9 80010c58 1000fc01 =
ffffc000
       00000000 1000fc01 00000000 00000001 00000000 00000000 00000000 =
00000000
       12e01e6c 801d2d59 00000001 12e09bff 00ffffff a0e00010 00000005 =
00000004 b
3ff0000
$24: a0000000 80231a26                   80230000 80231a50 bfc00598 =
80009aa4
Hi : 00000005
Lo : 80010fb8
epc  : 8000993c    Not tainted
Status: 1000fc02
Status: 1000fc02
It is ok with linux2.4.3, any suggestion?

------=_NextPart_000_002A_01C3DEAF.BD71C9E0
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2600.0" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>I'm using mips-4kc core and try to port linux2.4.18. =
When=20
kernel starts, it display the following OOP</FONT></DIV>
<DIV><FONT size=3D2>Unhandled kernel unaligned access in=20
unaligned.c:emulate_load_store_insn, line 3<BR>51:<BR>$0 : 00000000 =
801d0000=20
ffd82b0b 00000001 fff60ac0 0000000b 80237ef8 00000001<BR>$8 : 1000fc00 =
1000001f=20
0000001d 12e09bff 00ffffff a0e00010 000000ff 00000018<BR>$16: 801d64e4 =
00000000=20
80002adc 00000004 bfd5a450 00000005 00000004 b3ff0000<BR>$24: a0000000=20
800a1e4c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
80236000 80237eb0 bfc00598 80009aa4<BR>Hi : 00000005<BR>Lo :=20
80010fb8<BR>epc&nbsp; : 8000993c&nbsp;&nbsp;&nbsp; Not =
tainted<BR>Status:=20
1000fc02<BR>Cause : =
10800010<BR>Process=FFg=FF=FF4=FF=FF=FF=FF[9=FF=FF5=FF=FF=FF=FF=FF (pid: =
-143232658,=20
stackpage=3D80234000)<BR>Stack: 5a24a5ab 2e29b637 30313233 34353637 =
80009aa4=20
63646566 30313233 34353637<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
38396162=20
63646566 10801000 80092d54 000088c9 0000003e 80010b98=20
00353637<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80092960 34353637 =
000008c5=20
ffffffff 000088c9 80010c58 1000fc01=20
ffffc000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00000000 1000fc01 =
00000000=20
00000001 00000000 00000000 00000000=20
00000000<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12e01e6c 801d2d59 =
00000001=20
12e09bff 00ffffff a0e00010 00000005 00000004 b<BR>3ff0000<BR>$24: =
a0000000=20
80231a26&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
80230000 80231a50 bfc00598 80009aa4<BR>Hi : 00000005<BR>Lo :=20
80010fb8<BR>epc&nbsp; : 8000993c&nbsp;&nbsp;&nbsp; Not =
tainted<BR>Status:=20
1000fc02<BR>Status: 1000fc02<BR>It is ok with linux2.4.3, any=20
suggestion?</FONT></DIV></BODY></HTML>

------=_NextPart_000_002A_01C3DEAF.BD71C9E0--
