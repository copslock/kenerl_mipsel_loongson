Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 18:57:25 +0100 (BST)
Received: from mx1.razamicroelectronics.com ([63.111.213.197]:27944 "EHLO
	hq-ex-mb01.razamicroelectronics.com") by ftp.linux-mips.org with ESMTP
	id S20038655AbWISR5X (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Sep 2006 18:57:23 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DC15.09BBAAFA"
Subject: RE: Differing results from cross and native compilers
Date:	Tue, 19 Sep 2006 10:56:09 -0700
Message-ID: <2E96546B3C2C8B4CA739323C6058204A0163548E@hq-ex-mb01.razamicroelectronics.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Differing results from cross and native compilers
Thread-Index: AcbcD1jW+mUAhYzgTf6LbmJrWZigVwABYogm
From:	"Eric DeVolder" <edevolder@razamicroelectronics.com>
To:	"Thiemo Seufer" <ths@networkno.de>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <edevolder@razamicroelectronics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: edevolder@razamicroelectronics.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6DC15.09BBAAFA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thiemo, could you share what the native 3.4 compiler reports as its =
configuration? (e.g. the "Configured with: " statement)?
=20
Thanks,
Eric

________________________________

From: Thiemo Seufer [mailto:ths@networkno.de]
Sent: Tue 9/19/2006 12:16 PM
To: Eric DeVolder
Cc: linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers



Eric DeVolder wrote:
> Yes, it appears to me that the compiler (cc1) and assembler (as)
> invocations are the same. I've included the "-v" output of each
> below for reference. Furthermore, the -save-temps output .i files
> are effectively the same (differences due to cross vs. native paths,
> but that is it). Nonetheless, the output assembly source still
> contains differences!
>=20
> I'm curious if anybody examined the output of a cross and native
> toolchain of the same (recent) version?

I get the same (properly optimised) result from both compilers:

  gcc (GCC) 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)
  mips-linux-gnu-gcc (GCC) 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)


I haven't tried a 3.4 crosscompiler, but the native one also behaves
as expected:

  gcc-3.4 (GCC) 3.4.6 (Debian 3.4.6-4)


Thiemo



------_=_NextPart_001_01C6DC15.09BBAAFA
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
<TITLE>Re: Differing results from cross and native compilers</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV dir=3Dltr id=3DidOWAReplyText25336>=0A=
<DIV dir=3Dltr><FONT color=3D#000000 face=3DArial size=3D2>Thiemo, could =
you share what =0A=
the native 3.4 compiler&nbsp;reports as its configuration?&nbsp;(e.g. =
the =0A=
"Configured with: " statement)?</FONT></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Eric</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr><BR>=0A=
<HR tabIndex=3D-1>=0A=
<FONT face=3DTahoma size=3D2><B>From:</B> Thiemo Seufer =0A=
[mailto:ths@networkno.de]<BR><B>Sent:</B> Tue 9/19/2006 12:16 =
PM<BR><B>To:</B> =0A=
Eric DeVolder<BR><B>Cc:</B> linux-mips@linux-mips.org<BR><B>Subject:</B> =
Re: =0A=
Differing results from cross and native compilers<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Eric DeVolder wrote:<BR>&gt; Yes, it appears to me =
that the =0A=
compiler (cc1) and assembler (as)<BR>&gt; invocations are the same. I've =0A=
included the "-v" output of each<BR>&gt; below for reference. =
Furthermore, the =0A=
-save-temps output .i files<BR>&gt; are effectively the same =
(differences due to =0A=
cross vs. native paths,<BR>&gt; but that is it). Nonetheless, the output =0A=
assembly source still<BR>&gt; contains =
differences!<BR>&gt;&nbsp;<BR>&gt; I'm =0A=
curious if anybody examined the output of a cross and native<BR>&gt; =
toolchain =0A=
of the same (recent) version?<BR><BR>I get the same (properly optimised) =
result =0A=
from both compilers:<BR><BR>&nbsp; gcc (GCC) 4.1.2 20060901 (prerelease) =
(Debian =0A=
4.1.1-13)<BR>&nbsp; mips-linux-gnu-gcc (GCC) 4.1.2 20060901 (prerelease) =
(Debian =0A=
4.1.1-13)<BR><BR><BR>I haven't tried a 3.4 crosscompiler, but the native =
one =0A=
also behaves<BR>as expected:<BR><BR>&nbsp; gcc-3.4 (GCC) 3.4.6 (Debian =0A=
3.4.6-4)<BR><BR><BR>Thiemo<BR></FONT></P></DIV>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C6DC15.09BBAAFA--
