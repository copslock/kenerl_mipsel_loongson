Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 06:39:23 +0100 (BST)
Received: from [IPv6:::ffff:203.199.202.17] ([IPv6:::ffff:203.199.202.17]:776
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225299AbTJIFjU>; Thu, 9 Oct 2003 06:39:20 +0100
Received: from DURAI ([192.168.0.107])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id h995YGY03928
	for <linux-mips@linux-mips.org>; Thu, 9 Oct 2003 11:04:16 +0530
Message-ID: <007801c38e27$a1c81920$6b00a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: "mips" <linux-mips@linux-mips.org>
Subject: how to include mips assembly in c code?
Date: Thu, 9 Oct 2003 11:08:56 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0075_01C38E55.BB76DF40"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-MailScanner: Found to be clean
Return-Path: <durai@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: durai@isofttech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0075_01C38E55.BB76DF40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hello,
I am having the following assembly code and i wanted to call this =
function from a c code.
can anybody tell me how to include this code in a c program?

/************************************************************************=
******
*
* sysWbFlush - flush the write buffer
*
* This routine flushes the write buffers, making certain all
* subsequent memory writes have occurred.  It is used during critical =
periods
* only, e.g., after memory-mapped I/O register access.
*
* RETURNS: N/A

* sysWbFlush (void)

*/
        .ent    sysWbFlush
sysWbFlush:
        li      t0, K1BASE              /* load uncached address        =
*/
        lw      t0, 0(t0)               /* read in order to flush       =
*/
        j       ra                      /* return to caller             =
*/
        .end    sysWbFlush


regards
durai
------=_NextPart_000_0075_01C38E55.BB76DF40
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
<DIV><FONT face=3DArial size=3D2>hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am having the following assembly code =
and i=20
wanted to call this function from a c code.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>can anybody tell me how to include this =
code in a c=20
program?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>/***************************************************************=
***************<BR>*<BR>*=20
sysWbFlush - flush the write buffer<BR>*<BR>* This routine flushes the =
write=20
buffers, making certain all<BR>* subsequent memory writes have =
occurred.&nbsp;=20
It is used during critical periods<BR>* only, e.g., after memory-mapped =
I/O=20
register access.<BR>*<BR>* RETURNS: N/A</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>* sysWbFlush (void)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
.ent&nbsp;&nbsp;&nbsp;=20
sysWbFlush<BR>sysWbFlush:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
li&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t0,=20
K1BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;=20
/* load uncached address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t0,=20
0(t0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;=20
/* read in order to flush&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
j&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
ra&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
/* return to=20
caller&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end&nbsp;&nbsp;&nbsp;=20
sysWbFlush</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>durai</FONT></DIV></BODY></HTML>

------=_NextPart_000_0075_01C38E55.BB76DF40--
