Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 18:12:08 +0000 (GMT)
Received: from mxout.mainstreet.net ([199.245.73.25]:20120 "EHLO
	mxout.mainstreet.net") by ftp.linux-mips.org with ESMTP
	id S8133952AbWCJSLs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Mar 2006 18:11:48 +0000
Received: from mail.idt.com (mail.idt.com [157.165.5.20])
	by mxout.mainstreet.net (8.13.4/8.13.4) with ESMTP id k2AIKSlS013271;
	Fri, 10 Mar 2006 10:20:31 -0800 (PST)
Received: from corpml1.corp.idt.com (corpml1.corp.idt.com [157.165.140.20])
	by mail.idt.com (8.13.4/8.13.4) with ESMTP id k2AIKPII012302;
	Fri, 10 Mar 2006 10:20:25 -0800 (PST)
Received: from CORPBRIDGE.corp.idt.com (localhost [127.0.0.1])
	by corpml1.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id k2AIKOQ05017;
	Fri, 10 Mar 2006 10:20:24 -0800 (PST)
Received: by corpbridge.corp.idt.com with Internet Mail Service (5.5.2658.3)
	id <1X0B044Y>; Fri, 10 Mar 2006 10:20:23 -0800
Message-ID: <73943A6B3BEAA1468EE1A4A090129F4316B15A76@corpbridge.corp.idt.com>
From:	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
To:	"'Robin H. Johnson'" <robbat2@orbis-terrarum.net>,
	linux-mips@linux-mips.org
Subject: RE: [PATCH] IDT Interprise Processor Support for Linux  2.6.x
Date:	Fri, 10 Mar 2006 10:20:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.3)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6446F.47A114CC"
X-Scanned-By: MIMEDefang 2.43
Return-Path: <Rakesh.Tiwari@idt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Rakesh.Tiwari@idt.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C6446F.47A114CC
Content-Type: text/plain

Hi Robin,

Thanks for reviewing the patch. 

I like your idea of having a single kernel which can boot on any board
and also agree with you that code duplication is not a good thing.

However, based on our customer's feedback so far, we prefer to keep it
separate
for each board, so that code doesn't get to messy or people don't have to
look at unwanted code. 

Also since IDT's processors are SoC's and do undergo various rev's for the
chips,
in which certain feature (hardware) are fixed/removed/added. In this case
having
a separate directory (at the cost of code duplication) is easier to
maintain.


Regards
Rakesh



-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Robin H. Johnson
Sent: Thursday, March 09, 2006 9:15 PM
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] IDT Interprise Processor Support for Linux 2.6.x


On Thu, Mar 09, 2006 at 05:08:49PM -0800, Tiwari, Rakesh wrote:
> The attached patch adds support for the IDT Interprise series of 
> processor
> based on the MIPS 4KC and Cronus (RC32300) core.
I'm not Ralf, but I gave your patch a quick once-over anyway for the hell of
it.

I see a lot of duplicated code, esp in arch/mips/idt-boards and the network
drivers.

Is it possible to have a kernel capable of booting on all IDT boards? Could
such a kernel detect what board it's actually running on - or enough
elements of the board configuration to provide more generic drivers?

-- 
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=people.robbat2
ICQ#       : 30269588 or 41961639
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

------_=_NextPart_001_01C6446F.47A114CC
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: [PATCH] IDT Interprise Processor Support for Linux  =
2.6.x</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi Robin,</FONT>
</P>

<P><FONT SIZE=3D2>Thanks for reviewing the patch. </FONT>
</P>

<P><FONT SIZE=3D2>I like your idea of having a single kernel which can =
boot on any board</FONT>
<BR><FONT SIZE=3D2>and also agree with you that code duplication is not =
a good thing.</FONT>
</P>

<P><FONT SIZE=3D2>However, based on our customer's feedback so far, we =
prefer to keep it separate</FONT>
<BR><FONT SIZE=3D2>for each board, so that code doesn't get to messy or =
people don't have to</FONT>
<BR><FONT SIZE=3D2>look at unwanted code. </FONT>
</P>

<P><FONT SIZE=3D2>Also since IDT's processors are SoC's and do undergo =
various rev's for the chips,</FONT>
<BR><FONT SIZE=3D2>in which certain feature (hardware) are =
fixed/removed/added. In this case having</FONT>
<BR><FONT SIZE=3D2>a separate directory (at the cost of code =
duplication) is easier to maintain.</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>Regards</FONT>
<BR><FONT SIZE=3D2>Rakesh</FONT>
</P>
<BR>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: linux-mips-bounce@linux-mips.org [<A =
HREF=3D"mailto:linux-mips-bounce@linux-mips.org">mailto:linux-mips-bounc=
e@linux-mips.org</A>] On Behalf Of Robin H. Johnson</FONT>
<BR><FONT SIZE=3D2>Sent: Thursday, March 09, 2006 9:15 PM</FONT>
<BR><FONT SIZE=3D2>To: linux-mips@linux-mips.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [PATCH] IDT Interprise Processor =
Support for Linux 2.6.x</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Thu, Mar 09, 2006 at 05:08:49PM -0800, Tiwari, =
Rakesh wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; The attached patch adds support for the IDT =
Interprise series of </FONT>
<BR><FONT SIZE=3D2>&gt; processor</FONT>
<BR><FONT SIZE=3D2>&gt; based on the MIPS 4KC and Cronus (RC32300) =
core.</FONT>
<BR><FONT SIZE=3D2>I'm not Ralf, but I gave your patch a quick =
once-over anyway for the hell of it.</FONT>
</P>

<P><FONT SIZE=3D2>I see a lot of duplicated code, esp in =
arch/mips/idt-boards and the network drivers.</FONT>
</P>

<P><FONT SIZE=3D2>Is it possible to have a kernel capable of booting on =
all IDT boards? Could such a kernel detect what board it's actually =
running on - or enough elements of the board configuration to provide =
more generic drivers?</FONT></P>

<P><FONT SIZE=3D2>-- </FONT>
<BR><FONT SIZE=3D2>Robin Hugh Johnson</FONT>
<BR><FONT SIZE=3D2>E-Mail&nbsp;&nbsp;&nbsp;&nbsp; : =
robbat2@orbis-terrarum.net</FONT>
<BR><FONT SIZE=3D2>Home Page&nbsp; : <A =
HREF=3D"http://www.orbis-terrarum.net/?l=3Dpeople.robbat2" =
TARGET=3D"_blank">http://www.orbis-terrarum.net/?l=3Dpeople.robbat2</A><=
/FONT>
<BR><FONT SIZE=3D2>ICQ#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 30269588 =
or 41961639</FONT>
<BR><FONT SIZE=3D2>GnuPG FP&nbsp;&nbsp; : 11AC BA4F 4778 E3F6 =
E4ED&nbsp; F38E B27B 944E 3488 4E85</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C6446F.47A114CC--
