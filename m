Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 18:08:09 +0000 (GMT)
Received: from [IPv6:::ffff:209.172.108.133] ([IPv6:::ffff:209.172.108.133]:63864
	"HELO [209.172.108.133]") by linux-mips.org with SMTP
	id <S8225348AbUAUSIJ>; Wed, 21 Jan 2004 18:08:09 +0000
Received: from essmail.esstech.com by [209.172.108.133]
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; Wed, 21 Jan 2004 10:08:08 -0800
Received: from wliupc ([172.18.13.106]) by ess2kmail.essnet.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Wed, 21 Jan 2004 10:08:00 -0800
Message-ID: <000e01c3e04a$52f38a80$6a0d12ac@ess>
From: "wei liu" <wei.liu@esstech.com>
To: <linux-mips@linux-mips.org>
Subject: is there any cache problem with 4kc core?
Date: Wed, 21 Jan 2004 10:13:51 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C3E007.44A717A0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 21 Jan 2004 18:08:00.0471 (UTC) FILETIME=[81665E70:01C3E049]
Return-Path: <Wei.Liu@esstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wei.liu@esstech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C3E007.44A717A0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

I met a crash problem when trying linux2.4.18 on 4kc board. When the =
kernel starts thread to run function init, it will crash, showing =
Unhandled kernel unaligned access in =
unaligned.c:emulate_load_store_insn, line 3
51:
while it is ok for me to run linux2.4.3

Following is chip detail.
CPU revision is: 00018004
Primary instruction cache 8kb, linesize 16 bytes (2 ways)
Primary data cache 8kb, linesize 16 bytes (2 ways)
Linux version 2.4.18-MIPS-01.01 (gcc version 3.0)=20


------=_NextPart_000_000B_01C3E007.44A717A0
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
<DIV><FONT size=3D2>I met a crash problem when trying linux2.4.18 on 4kc =
board.=20
When the kernel starts thread to run function init, it will crash, =
showing=20
Unhandled kernel unaligned access in =
unaligned.c:emulate_load_store_insn, line=20
3<BR>51:</FONT></DIV>
<DIV><FONT size=3D2>while it is ok for me to run linux2.4.3</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Following is chip detail.</FONT></DIV>
<DIV><FONT size=3D2>CPU revision is: 00018004<BR>Primary instruction =
cache 8kb,=20
linesize 16 bytes (2 ways)<BR>Primary data cache 8kb, linesize 16 bytes =
(2=20
ways)<BR>Linux version 2.4.18-MIPS-01.01 (gcc version 3.0)=20
<BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_000B_01C3E007.44A717A0--
