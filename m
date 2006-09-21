Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Sep 2006 15:28:24 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:15589 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20038429AbWIUO2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Sep 2006 15:28:19 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DD8A.285F36F0"
Subject: RE: Differing results from cross and native compilers
Date:	Thu, 21 Sep 2006 07:26:29 -0700
Message-ID: <2E96546B3C2C8B4CA739323C6058204A01635493@hq-ex-mb01.razamicroelectronics.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Differing results from cross and native compilers
Thread-Index: AcbcQxypWCQgkRBYSXWUIjUa8tCK9QBRtEP/
From:	"Eric DeVolder" <edevolder@razamicroelectronics.com>
To:	"Jim Wilson" <wilson@specifix.com>
Cc:	"Thiemo Seufer" <ths@networkno.de>, <linux-mips@linux-mips.org>
Return-Path: <edevolder@razamicroelectronics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edevolder@razamicroelectronics.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DD8A.285F36F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Jim, you hit the nail on the head!
=20
gcc/config.log:target_cpu_default=3D'(MASK_GAS)|MASK_EXPLICIT_RELOCS'
gcc/config.status:s,@target_cpu_default@,(MASK_GAS)|MASK_EXPLICIT_RELOCS,=
;t t
gcc/Makefile:target_cpu_default=3D(MASK_GAS)|MASK_EXPLICIT_RELOCS

So yes, something went awry and the configure stage didn't think gas was =
in use...
=20
Eric=20

________________________________

From: Jim Wilson [mailto:wilson@specifix.com]
Sent: Tue 9/19/2006 6:22 PM
To: Eric DeVolder
Cc: Thiemo Seufer; linux-mips@linux-mips.org
Subject: RE: Differing results from cross and native compilers



On Tue, 2006-09-19 at 09:57 -0700, Eric DeVolder wrote:

> -       lw      $4,%got($LC0)($28)
> +       la      $4,$LC0

The difference here is -mexplicit-relocs, which is the default for the
first one (cross) but not the second one (native).

The explicit-reloc support is enabled by a run-time configure test,
which tries to run the assembler to see if you have a new enough version
of GNU as that supports the necessary assembler reloc syntax.
Apparently this is going wrong with the native build.  Perhaps you have
a different binutils version, or perhaps there is a problem with your
PATH, or perhaps binutils and gcc weren't configured with the same
prefix, etc.

If you have the build trees, you can look at the gcc/config.h files and
note that one has HAVE_AS_EXPLICIT_RELOCS defined and the other doesn't.

--
Jim Wilson, GNU Tools Support, http://www.specifix.com







------_=_NextPart_001_01C6DD8A.285F36F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>RE: Differing results from cross and native compilers</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr id=3DidOWAReplyText63109>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=3D2>Thanks =
Jim,&nbsp;you hit the =0A=
nail on the head!</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial =0A=
size=3D2>gcc/config.log:target_cpu_default=3D'(MASK_GAS)|MASK_EXPLICIT_RE=
LOCS'<BR>gcc/config.status:s,@target_cpu_default@,(MASK_GAS)|MASK_EXPLICI=
T_RELOCS,;t =0A=
t<BR>gcc/Makefile:target_cpu_default=3D(MASK_GAS)|MASK_EXPLICIT_RELOCS<BR=
></FONT></DIV>=0A=
<DIV dir=3Dltr>So yes, something went awry and the configure stage =
didn't think =0A=
gas was in use...</DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Eric&nbsp;</DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Jim Wilson =0A=
[mailto:wilson@specifix.com]<BR><B>Sent:</B> Tue 9/19/2006 6:22 =
PM<BR><B>To:</B> =0A=
Eric DeVolder<BR><B>Cc:</B> Thiemo Seufer; =0A=
linux-mips@linux-mips.org<BR><B>Subject:</B> RE: Differing results from =
cross =0A=
and native compilers<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>On Tue, 2006-09-19 at 09:57 -0700, Eric DeVolder =0A=
wrote:<BR><BR>&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
lw&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $4,%got($LC0)($28)<BR>&gt; =0A=
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; la&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =0A=
$4,$LC0<BR><BR>The difference here is -mexplicit-relocs, which is the =
default =0A=
for the<BR>first one (cross) but not the second one (native).<BR><BR>The =0A=
explicit-reloc support is enabled by a run-time configure test,<BR>which =
tries =0A=
to run the assembler to see if you have a new enough version<BR>of GNU =
as that =0A=
supports the necessary assembler reloc syntax.<BR>Apparently this is =
going wrong =0A=
with the native build.&nbsp; Perhaps you have<BR>a different binutils =
version, =0A=
or perhaps there is a problem with your<BR>PATH, or perhaps binutils and =
gcc =0A=
weren't configured with the same<BR>prefix, etc.<BR><BR>If you have the =
build =0A=
trees, you can look at the gcc/config.h files and<BR>note that one has =0A=
HAVE_AS_EXPLICIT_RELOCS defined and the other doesn't.<BR><BR>--<BR>Jim =
Wilson, =0A=
GNU Tools Support, <A =0A=
href=3D"http://www.specifix.com">http://www.specifix.com</A><BR><BR><BR><=
BR><BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C6DD8A.285F36F0--
