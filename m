Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2003 14:59:43 +0100 (BST)
Received: from [IPv6:::ffff:203.199.202.17] ([IPv6:::ffff:203.199.202.17]:22535
	"EHLO pub.isofttechindia.com") by linux-mips.org with ESMTP
	id <S8225398AbTJJN7i>; Fri, 10 Oct 2003 14:59:38 +0100
Received: from DURAI ([192.168.0.107])
	by pub.isofttechindia.com (8.11.0/8.11.0) with SMTP id h9ADsbj06936
	for <linux-mips@linux-mips.org>; Fri, 10 Oct 2003 19:24:37 +0530
Message-ID: <02d001c38f36$ba4a8e00$6b00a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: "mips" <linux-mips@linux-mips.org>
Subject: unresolved symbol litodp,dptoli,dpmul - floating point operations in kernel
Date: Fri, 10 Oct 2003 19:29:30 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02CD_01C38F64.D399F610"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <durai@isofttech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: durai@isofttech.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_02CD_01C38F64.D399F610
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

hello,
I am using a mips cross compiler (mips-linux-gcc, version 2.95.3) to =
build my driver
I am using some floating point operations in a wireless lan driver for a =
mips platform in ucLinux, When i load the driver I am getting unresolved =
symbols

>=20
> insmod: unresolved symbol dptoli
> insmod: unresolved symbol dpmul
> insmod: unresolved symbol litodp

And somebody told me that we cannot use floating point operations in =
kernel code, but i desperately need to use floating point operations.=20
please tell me how to use floating point operations in kernel code.

thanks & regards
durai
------=_NextPart_000_02CD_01C38F64.D399F610
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
<DIV><FONT face=3DArial size=3D2>I am using a mips cross compiler=20
(mips-linux-gcc,&nbsp;version 2.95.3) to build my driver</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I am using&nbsp;some floating point =
operations in a=20
wireless lan driver for a mips platform in ucLinux, When i load the =
driver I am=20
getting unresolved symbols</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&gt;<I> </I><BR>&gt;<I> insmod: unresolved symbol =
dptoli</I><BR>&gt;<I>=20
insmod: unresolved symbol dpmul</I><BR>&gt;<I> insmod: unresolved symbol =

litodp</I><BR></DIV>
<DIV><FONT face=3DArial size=3D2>And somebody told me that we cannot use =
floating=20
point operations in kernel code, but i desperately need to use floating =
point=20
operations. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>please tell me how to use floating =
point operations=20
in kernel code.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>thanks &amp; regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>durai</FONT></DIV></BODY></HTML>

------=_NextPart_000_02CD_01C38F64.D399F610--
