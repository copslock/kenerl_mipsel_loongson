Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 20:04:08 +0000 (GMT)
Received: from dns0.mips.com ([63.167.95.198]:22485 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28575265AbXJ3UEA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2007 20:04:00 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l9UJtrPa026006;
	Tue, 30 Oct 2007 11:55:54 -0800 (PST)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l9UJuJbQ010416;
	Tue, 30 Oct 2007 12:56:20 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81B2E.DEB3E9FC"
Subject: RE: implementation of software suspend on MIPS.
Date:	Tue, 30 Oct 2007 12:55:42 -0700
Message-ID: <692AB3595F5D76428B34B9BEFE20BC1FDD0219@Exchange.mips.com>
In-Reply-To: <dd7dc2bc0710301212s7b364392n39a149764a4117cf@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: implementation of software suspend on MIPS.
Thread-Index: AcgbKOiSjXA7DQJBSe+Vt70kzq/RnwABcTDQ
References: <dd7dc2bc0710301212s7b364392n39a149764a4117cf@mail.gmail.com>
From:	"Uhler, Mike" <uhler@mips.com>
To:	"Hyon Lim" <alex@alexlab.net>, <linux-mips@linux-mips.org>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81B2E.DEB3E9FC
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

I've asked our software team to follow up with you on your questions.
=20
/gmu
---
Michael Uhler, VP Architecture, Software and Platform Engineering
MIPS Technologies, Inc.   Email: uhler AT mips.com
1225 Charleston Road      Voice:  (650)567-5025
Mountain View, CA 94043
 =20


________________________________

	From: linux-mips-bounce@linux-mips.org =
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Hyon Lim
	Sent: Tuesday, October 30, 2007 12:13 PM
	To: linux-mips@linux-mips.org
	Subject:  implementation of software suspend on MIPS.
	Importance: Low
=09
=09
	Hello.  I need a help for my implementation work on MIPS software =
suspend.
	From 3month ago, I've been coding software suspend(swsusp) on MIPS =
arch.
	I'm developing with MIPS32 4KEc embedded processor for digital =
appliance.
	=20
	Swsusp has two procedure. the one is suspending procedure and other one =
is resume procedure.
	Yesterday, I confirmed suspending procedure working.
	This is a porting guide of swsusp =
(http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes)
	I refered this article.
	=20
	The problem I faced is assembly language for MIPS.
	Of course, there are many manuals for this work but, I need a help from =
MIPS expert.
	=20
	This pseudo code should be implemented by MIPS asm.
	=20
	        for (j =3D nr_copy_pages; j>0; j--) {=20
	            src =3D pagedir_nosave[j].src;=20
	            dst =3D pagedir_nosave[j].dst;=20
	            for (i=3D0;i<1024;i++) {=20
	                *dst++ =3D *src++;=20
	            }=20
	        }=20
	=20
	nr_copy_pages is unsigned long variable.
	and pagedir_nosave is a suspend_pagedir_t =
<http://lxr.linux.no/source/kernel/power/ident?v=3D2.6.10;i=3Dsuspend_pag=
edir_t>  type structure array(pointer). (you can refer following url. =
Line 101. : http://lxr.linux.no/source/kernel/power/swsusp.c?v=3D2.6.10)
	code skeleton or useful material will be welcomed. (whatever you have.)
	=20
	The second problem is
	" which register should be prevented? "
	=20
	I saved $v0-v1. $a0-$a3. $t0-t7. $s0-s7. $t8-t9. $gp,sp,fp,ra.

	--=20
	Hyon Lim (=C0=D3=C7=F6)
	Mobile. 010-8212-1240 (Intl' Call : +82-10-8212-1240)
	Fax. 032-232-0578 (Intl' Available)
	Homepage : http://www.alexlab.net
	Blog : http://www.alexlab.net/blog=20


------_=_NextPart_001_01C81B2E.DEB3E9FC
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dks_c_5601-1987">
<META content=3D"MSHTML 6.00.6000.16544" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial color=3D#0000ff =
size=3D2><SPAN=20
class=3D037285419-30102007>I've asked our software team to follow up =
with you on=20
your questions.</SPAN></FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><!-- Converted from text/plain format -->
<P><FONT size=3D2>/gmu<BR>---<BR>Michael Uhler, VP Architecture, =
Software and=20
Platform Engineering<BR>MIPS Technologies, Inc.&nbsp;&nbsp; Email: uhler =
AT=20
mips.com<BR>1225 Charleston Road&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Voice:&nbsp;=20
(650)567-5025<BR>Mountain View, CA=20
94043<BR>&nbsp;</FONT>&nbsp;</FONT><BR></P></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> =
linux-mips-bounce@linux-mips.org=20
  [mailto:linux-mips-bounce@linux-mips.org] <B>On Behalf Of </B>Hyon=20
  Lim<BR><B>Sent:</B> Tuesday, October 30, 2007 12:13 PM<BR><B>To:</B>=20
  linux-mips@linux-mips.org<BR><B>Subject:</B>&nbsp; implementation of =
software=20
  suspend on MIPS.<BR><B>Importance:</B> Low<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>Hello.&nbsp; I need a help for my implementation work on MIPS =
software=20
  suspend.</DIV>
  <DIV>From 3month ago, I've been coding software suspend(swsusp) on =
MIPS=20
  arch.</DIV>
  <DIV>I'm developing with MIPS32 4KEc embedded processor for digital=20
  appliance.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Swsusp has two procedure. the one is suspending procedure and =
other one=20
  is resume procedure.</DIV>
  <DIV>Yesterday, I confirmed suspending procedure working.</DIV>
  <DIV>This is a porting guide of swsusp (<A=20
  =
href=3D"http://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes">h=
ttp://tree.celinuxforum.org/CelfPubWiki/SwSuspendPortingNotes</A>)</DIV>
  <DIV>I refered this article.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>The problem I faced is assembly language for MIPS.</DIV>
  <DIV>Of course, there are many manuals for this work but, I need a =
help from=20
  MIPS expert.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>This pseudo code should be implemented by MIPS asm.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (j =3D =
nr_copy_pages;=20
  j&gt;0; j--) {=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
src =3D=20
  pagedir_nosave[j].src;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dst =3D=20
  pagedir_nosave[j].dst;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
for=20
  (i=3D0;i&lt;1024;i++) {=20
  =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=20
  *dst++ =3D *src++;=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}=20
  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } <BR>&nbsp;</DIV>
  <DIV>nr_copy_pages is unsigned long variable.</DIV>
  <DIV>and pagedir_nosave is a <A=20
  =
href=3D"http://lxr.linux.no/source/kernel/power/ident?v=3D2.6.10;i=3Dsusp=
end_pagedir_t">suspend_pagedir_t</A>=20
  type structure array(pointer). (you can refer following url. Line =
101.&nbsp;:=20
  <A=20
  =
href=3D"http://lxr.linux.no/source/kernel/power/swsusp.c?v=3D2.6.10">http=
://lxr.linux.no/source/kernel/power/swsusp.c?v=3D2.6.10</A>)</DIV>
  <DIV>code skeleton or useful material will be welcomed. (whatever you=20
  have.)</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>The second problem is</DIV>
  <DIV>" which register should be prevented? "</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>I saved $v0-v1. $a0-$a3. $t0-t7. $s0-s7. $t8-t9. =
$gp,sp,fp,ra.</DIV>
  <DIV><BR>-- <BR>Hyon Lim (=C0=D3=C7=F6)<BR>Mobile. 010-8212-1240 =
(Intl' Call :=20
  +82-10-8212-1240)<BR>Fax. 032-232-0578 (Intl' Available)<BR>Homepage : =
<A=20
  href=3D"http://www.alexlab.net">http://www.alexlab.net</A><BR>Blog : =
<A=20
  href=3D"http://www.alexlab.net/blog">http://www.alexlab.net/blog</A>=20
</DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C81B2E.DEB3E9FC--
