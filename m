Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 18:33:18 +0000 (GMT)
Received: from mx.mips.com ([63.167.95.198]:39131 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S28576518AbXJaSdJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2007 18:33:09 +0000
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id l9VIWWUY028447;
	Wed, 31 Oct 2007 10:32:33 -0800 (PST)
Received: from exchange.MIPS.COM (exchange [192.168.20.29])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id l9VIWxOE010313;
	Wed, 31 Oct 2007 11:32:59 -0700 (PDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81BEC.65559B00"
Subject: RE: implementation of software suspend on MIPS. (system log)
Date:	Wed, 31 Oct 2007 11:32:22 -0700
Message-ID: <692AB3595F5D76428B34B9BEFE20BC1FDD0276@Exchange.mips.com>
In-Reply-To: <dd7dc2bc0710311115x51dfab0bt97cdd810d21d120c@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: implementation of software suspend on MIPS. (system log)
Thread-Index: Acgb6giUsNThZbAaTc+MFN9yvVp/7QAAYj/Q
References: <dd7dc2bc0710301215m1a5b8d7at85c9afc7976dc21d@mail.gmail.com> <20071031132553.GF14187@linux-mips.org> <dd7dc2bc0710311115x51dfab0bt97cdd810d21d120c@mail.gmail.com>
From:	"Uhler, Mike" <uhler@mips.com>
To:	"Hyon Lim" <alex@alexlab.net>, "Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81BEC.65559B00
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

There are various sources of information available on MIPS assembly =
language programming.  The easiest way to get what you want is to write =
the code in C, then push it through the compiler to see what =
instructions it generates.  You can then hack that code to work in your =
context.
=20
Beyond that, Ralf mentioned the book "See MIPS Run Linux", by Dominic =
Sweetman.  There is also the GNU gas manual and the MIPS SDE =
Programmer's Guide (see =
http://www.mips.com/products/resource-library/product-materials/software)=
 or other references on MIPS assembly language programming.
=20

/gmu
---
Michael Uhler, VP Architecture, Software and Platform Engineering
MIPS Technologies, Inc.   Email: uhler AT mips.com
1225 Charleston Road      Voice:  (650)567-5025=20
Mountain View, CA 94043
 =20

 =20

=20


________________________________

	From: linux-mips-bounce@linux-mips.org =
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Hyon Lim
	Sent: Wednesday, October 31, 2007 11:15 AM
	To: Ralf Baechle
	Cc: linux-mips@linux-mips.org
	Subject: Re: implementation of software suspend on MIPS. (system log)
=09
=09
	The problem is resume process.
	Some page copy and other remaining process wasn't implemented.
	The code of resume process should be implemented on =
arch/xxx/power/swsusp.S
	So it should be implemented by assembly.
	That's the problem...
	I've no idea about complex assembly programming. :-)
	Could you recommend any pdf or website?
	=20
	On 10/31/07, Ralf Baechle <ralf@linux-mips.org> wrote:=20

		On Wed, Oct 31, 2007 at 04:15:57AM +0900, Hyon Lim wrote:
	=09
		> [DEBUG] Swsusp_write() @ kernel/power/swsusp.c,874=20
		> [DEBUG] write_suspend_image(), kernel/power/swsusp.c,407
		> [DEBUG] init_header(), kernel/power/swsusp.c,337
		> [DEBUG] dump_info(), kernel/power/swsusp.c,321
		>  swsusp: Version: 132618
		>  swsusp: Num Pages: 8192=20
		>  swsusp: UTS Sys: Linux
		>  swsusp: UTS Node: (none)
		>  swsusp: UTS Release: 2.6.10_SELP_MIPS
		>  swsusp: UTS Version: #95 Wed Oct 30 03:46:35 KST 2007
		>  swsusp: UTS Machine: mips
		>  swsusp: UTS Domain: (none)=20
		>  swsusp: CPUs: 1
		>  swsusp: Image: 1896 Pages
		>  swsusp: Pagedir: 0 Pages
		> [DEBUG] data_write(), kernel/power/swsusp.c,303
		> Writing data to swap (1896 pages)... done
		> Writing pagedir (8 pages)=20
		> S|
		> Powering off system
		> Cold reset
		>
		> This is system log of my implementation.
	=09
		Excellent, this is looking promising.
	=09
		Do you still need any help?
	=09
		Ralf
	=09




	--=20
	Hyon Lim (=C0=D3=C7=F6)
	Mobile. 010-8212-1240 (Intl' Call : +82-10-8212-1240)
	Fax. 032-232-0578 (Intl' Available)
	Homepage : http://www.alexlab.net=20
	Blog : http://www.alexlab.net/blog=20


------_=_NextPart_001_01C81BEC.65559B00
Content-Type: text/html;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dks_c_5601-1987">
<META content=3D"MSHTML 6.00.6000.16544" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D618352618-31102007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>There are various sources of information =
available on MIPS=20
assembly language programming.&nbsp; The easiest way to get what you =
want is to=20
write the code in C, then push it through the compiler to see what =
instructions=20
it generates.&nbsp; You can then hack that code to work in your=20
context.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D618352618-31102007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D618352618-31102007><FONT =
face=3DArial=20
color=3D#0000ff size=3D2>Beyond that, Ralf mentioned the book "See MIPS =
Run Linux",=20
by Dominic Sweetman.&nbsp; There is also the GNU gas manual and the MIPS =
SDE=20
Programmer's Guide (see <A=20
href=3D"http://www.mips.com/products/resource-library/product-materials/s=
oftware">http://www.mips.com/products/resource-library/product-materials/=
software</A>)=20
or other references on MIPS assembly language =
programming.</FONT></SPAN></DIV>
<DIV>&nbsp;</DIV><!-- Converted from text/plain format -->
<P><FONT size=3D2><!-- Converted from text/plain format --></P>
<P><FONT size=3D2>/gmu<BR>---<BR>Michael Uhler, VP Architecture, =
Software and=20
Platform Engineering<BR>MIPS Technologies, Inc.&nbsp;&nbsp; Email: uhler =
AT=20
mips.com<BR>1225 Charleston Road&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Voice:&nbsp;=20
(650)567-5025&nbsp;<BR>Mountain View, CA 94043<BR>&nbsp;</FONT> </P>
<P>&nbsp;</FONT> </P>
<DIV>&nbsp;</DIV><BR>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
  <HR tabIndex=3D-1>
  <FONT face=3DTahoma size=3D2><B>From:</B> =
linux-mips-bounce@linux-mips.org=20
  [mailto:linux-mips-bounce@linux-mips.org] <B>On Behalf Of </B>Hyon=20
  Lim<BR><B>Sent:</B> Wednesday, October 31, 2007 11:15 AM<BR><B>To:</B> =
Ralf=20
  Baechle<BR><B>Cc:</B> linux-mips@linux-mips.org<BR><B>Subject:</B> Re: =

  implementation of software suspend on MIPS. (system =
log)<BR></FONT><BR></DIV>
  <DIV></DIV>
  <DIV>The problem is resume process.</DIV>
  <DIV>Some page copy and other remaining process wasn't =
implemented.</DIV>
  <DIV>The code of resume process should be implemented on=20
  arch/xxx/power/swsusp.S</DIV>
  <DIV>So it should be implemented by assembly.</DIV>
  <DIV>That's the problem...</DIV>
  <DIV>I've no idea about complex assembly programming. :-)</DIV>
  <DIV>Could you recommend any pdf or website?<BR>&nbsp;</DIV>
  <DIV><SPAN class=3Dgmail_quote>On 10/31/07, <B =
class=3Dgmail_sendername>Ralf=20
  Baechle</B> &lt;<A=20
  href=3D"mailto:ralf@linux-mips.org">ralf@linux-mips.org</A>&gt; =
wrote:</SPAN>=20
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">On=20
    Wed, Oct 31, 2007 at 04:15:57AM +0900, Hyon Lim wrote:<BR><BR>&gt; =
[DEBUG]=20
    Swsusp_write() @ kernel/power/swsusp.c,874 <BR>&gt; [DEBUG]=20
    write_suspend_image(), kernel/power/swsusp.c,407<BR>&gt; [DEBUG]=20
    init_header(), kernel/power/swsusp.c,337<BR>&gt; [DEBUG] =
dump_info(),=20
    kernel/power/swsusp.c,321<BR>&gt;&nbsp;&nbsp;swsusp: Version:=20
    132618<BR>&gt;&nbsp;&nbsp;swsusp: Num Pages: 8192=20
    <BR>&gt;&nbsp;&nbsp;swsusp: UTS Sys: =
Linux<BR>&gt;&nbsp;&nbsp;swsusp: UTS=20
    Node: (none)<BR>&gt;&nbsp;&nbsp;swsusp: UTS Release:=20
    2.6.10_SELP_MIPS<BR>&gt;&nbsp;&nbsp;swsusp: UTS Version: #95 Wed Oct =
30=20
    03:46:35 KST 2007<BR>&gt;&nbsp;&nbsp;swsusp: UTS Machine:=20
    mips<BR>&gt;&nbsp;&nbsp;swsusp: UTS Domain: (none)=20
    <BR>&gt;&nbsp;&nbsp;swsusp: CPUs: 1<BR>&gt;&nbsp;&nbsp;swsusp: =
Image: 1896=20
    Pages<BR>&gt;&nbsp;&nbsp;swsusp: Pagedir: 0 Pages<BR>&gt; [DEBUG]=20
    data_write(), kernel/power/swsusp.c,303<BR>&gt; Writing data to swap =
(1896=20
    pages)... done<BR>&gt; Writing pagedir (8 pages) <BR>&gt; S|<BR>&gt; =

    Powering off system<BR>&gt; Cold reset<BR>&gt;<BR>&gt; This is =
system log of=20
    my implementation.<BR><BR>Excellent, this is looking =
promising.<BR><BR>Do=20
    you still need any help?<BR><BR>Ralf<BR></BLOCKQUOTE></DIV><BR><BR=20
  clear=3Dall><BR>-- <BR>Hyon Lim (=C0=D3=C7=F6)<BR>Mobile. =
010-8212-1240 (Intl' Call :=20
  +82-10-8212-1240)<BR>Fax. 032-232-0578 (Intl' Available)<BR>Homepage : =
<A=20
  href=3D"http://www.alexlab.net">http://www.alexlab.net </A><BR>Blog : =
<A=20
  href=3D"http://www.alexlab.net/blog">http://www.alexlab.net/blog</A>=20
</BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C81BEC.65559B00--
