Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 11:16:22 +0100 (BST)
Received: from [IPv6:::ffff:202.96.215.33] ([IPv6:::ffff:202.96.215.33]:61455
	"EHLO tmtms.trident.com.cn") by linux-mips.org with ESMTP
	id <S8225421AbTIRKQU>; Thu, 18 Sep 2003 11:16:20 +0100
Received: by TMTMS with Internet Mail Service (5.5.2653.19)
	id <SK19GYC6>; Thu, 18 Sep 2003 18:12:09 +0800
Message-ID: <15F9E1AE3207D6119CEA00D0B7DD5F68019BF848@TMTMS>
From: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
To: prabhakark@contechsoftware.com,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: RE: How disable CONFIG_PCI 
Date: Thu, 18 Sep 2003 18:12:01 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C37DCD.4D886D20"
Return-Path: <alanliu@trident.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alanliu@trident.com.cn
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C37DCD.4D886D20
Content-Type: text/plain;
	charset="ISO-8859-1"

Hi,

In arch/mips/config.in, find the specific line relating to your CSB250(what
is it???):

 define_bool CONFIG_PCI y

just delete it.

Alan

-----Original Message-----
From: Prabhakar Kalasani [mailto:prabhakark@contechsoftware.com]
Sent: Thursday, September 18, 2003 11:47 PM
To: 'linux-mips@linux-mips.org'
Subject: How disable CONFIG_PCI 


Hi all,
I'm compiling Linux-2.4.21 kernel for CSB250 board downloaded from
mips-linux,
I've configured CONFIG_PCI n , but when i go for xconfig, the value to
CONFIG_PCI y
where it's getting over write ? 
Because of CONFIG_PCI y, I'm unable to get my Framebuffer device active
How to solve this problem...

Thanks in advence
Prabhakar Kalasani


------_=_NextPart_001_01C37DCD.4D886D20
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2653.12">
<TITLE>RE: How disable CONFIG_PCI </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi,</FONT>
</P>

<P><FONT SIZE=3D2>In arch/mips/config.in, find the specific line =
relating to your CSB250(what is it???):</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;define_bool CONFIG_PCI y</FONT>
</P>

<P><FONT SIZE=3D2>just delete it.</FONT>
</P>

<P><FONT SIZE=3D2>Alan</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Prabhakar Kalasani [<A =
HREF=3D"mailto:prabhakark@contechsoftware.com">mailto:prabhakark@contech=
software.com</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Thursday, September 18, 2003 11:47 PM</FONT>
<BR><FONT SIZE=3D2>To: 'linux-mips@linux-mips.org'</FONT>
<BR><FONT SIZE=3D2>Subject: How disable CONFIG_PCI </FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Hi all,</FONT>
<BR><FONT SIZE=3D2>I'm compiling Linux-2.4.21 kernel for CSB250 board =
downloaded from mips-linux,</FONT>
<BR><FONT SIZE=3D2>I've configured CONFIG_PCI n , but when i go for =
xconfig, the value to CONFIG_PCI y</FONT>
<BR><FONT SIZE=3D2>where it's getting over write ? </FONT>
<BR><FONT SIZE=3D2>Because of CONFIG_PCI y, I'm unable to get my =
Framebuffer device active</FONT>
<BR><FONT SIZE=3D2>How to solve this problem...</FONT>
</P>

<P><FONT SIZE=3D2>Thanks in advence</FONT>
<BR><FONT SIZE=3D2>Prabhakar Kalasani</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C37DCD.4D886D20--
