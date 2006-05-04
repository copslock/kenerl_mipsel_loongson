Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 23:56:53 +0100 (BST)
Received: from SBA.FLIR.com ([12.164.250.85]:52695 "EHLO coral.sba.flir.net")
	by ftp.linux-mips.org with ESMTP id S8133819AbWEDW4i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 May 2006 23:56:38 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=neXtPaRt_1146783397"
Subject: NPTL compatible versions of buildroot/gcc/uclibc ...
Date:	Thu, 4 May 2006 15:56:35 -0700
Message-ID: <D68CE2DA7B2E3C4B880DAFD4DE38EE16630B5A@coral.sba.flir.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: NPTL compatible versions of buildroot/gcc/uclibc ...
Thread-Index: AcZvn7hBKfhufCbBQGOYsBbuirdt7Q==
From:	"De Jong, Rienco" <Marinus.DeJong@flir.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Marinus.DeJong@flir.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marinus.DeJong@flir.com
Precedence: bulk
X-list: linux-mips


------=neXtPaRt_1146783397
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C66FCD.FE7A427C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C66FCD.FE7A427C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

=20

I am trying to get the NPTL running on my au1200.  I am running the
linux-alchemy-src-2.6.11-r000055.tar.gz and have successfully run using
linuxthreads on the target with the buildroot snapshot=20

buildroot-20060227.tar.bz2 and would now like to use the NPTL.  I am
using the uClibc library and saw on the web that the uClibc NPTL for
MIPS was completed around the middle of March by Steve Hill
(http://www.realitydiluted.com/nptl-uclibc).  In my trolling on the web
and mailing lists I couldn't find a diffinitive statement of a buildroot
and gcc version that were compatible so I thought I should be able to
get the latest version of buildroot and version 4.1.0 of gcc and be good
to go.  I took the buildroot-20060504 snapshot and started the build of
buildroot but got the following error:

=20

monetary_members.cc: In member function 'void std::moneypunct<_CharT,
_Intl>::_M_initialize_moneypunct(int*, const char*) [with _CharT =3D
wchar_t, bool _Intl =3D true]':

monetary_members.cc:409: error: '__global_locale' was not declared in
this scope

monetary_members.cc: In member function 'void std::moneypunct<_CharT,
_Intl>::_M_initialize_moneypunct(int*, const char*) [with _CharT =3D
wchar_t, bool _Intl =3D false]':

monetary_members.cc:564: error: '__global_locale' was not declared in
this scope

make[5]: *** [monetary_members.lo] Error 1

make[5]: Leaving directory
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-l
inux-uclibc/libstdc++-v3/src'

make[4]: *** [all-recursive] Error 1

make[4]: Leaving directory
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-l
inux-uclibc/libstdc++-v3'

make[3]: *** [all] Error 2

make[3]: Leaving directory
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-l
inux-uclibc/libstdc++-v3'

make[2]: *** [all-target-libstdc++-v3] Error 2

make[2]: Leaving directory
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final'

make[1]: *** [all] Error 2

make[1]: Leaving directory
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final'

make: ***
[/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/.compile
d] Error 2

=20

The uClibc is uClibc-0.9.28

The binutils is binutils-2.16.91.0.7

Is there an option I should have turned on?

=20

Does anyone know what the correct combination of buildroot/toolchain
that will give me the NPTL functionality?

=20

Thanks,

=20

Rienco


------_=_NextPart_001_01C66FCD.FE7A427C
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.emailstyle17
	{font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{font-family:Arial;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to get the NPTL running on my =
au1200.&nbsp; I am
running the linux-alchemy-src-2.6.11-r000055.tar.gz and have =
successfully run
using linuxthreads on the target with the buildroot snapshot =
</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>buildroot-20060227.tar.bz2 and would now like to use =
the
NPTL.&nbsp; I am using the uClibc library and saw on the web that the =
uClibc
NPTL for MIPS was completed around the middle of March by Steve Hill (<a
href=3D"http://www.realitydiluted.com/nptl-uclibc">http://www.realitydilu=
ted.com/nptl-uclibc</a>).&nbsp;
In my trolling on the web and mailing lists I couldn't find a =
diffinitive statement
of a buildroot and gcc version that were compatible so I thought I =
should be
able to get the latest version of buildroot and version 4.1.0 of gcc and =
be
good to go.&nbsp; I took the buildroot-20060504 snapshot and started the =
build
of buildroot but got the following error:</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>monetary_members.cc: In member function 'void
std::moneypunct&lt;_CharT, _Intl&gt;::_M_initialize_moneypunct(int*, =
const
char*) [with _CharT =3D wchar_t, bool _Intl =3D =
true]':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>monetary_members.cc:409: error: '__global_locale' was =
not
declared in this scope</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>monetary_members.cc: In member function 'void
std::moneypunct&lt;_CharT, _Intl&gt;::_M_initialize_moneypunct(int*, =
const
char*) [with _CharT =3D wchar_t, bool _Intl =3D =
false]':</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>monetary_members.cc:564: error: '__global_locale' was =
not
declared in this scope</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[5]: *** [monetary_members.lo] Error =
1</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[5]: Leaving directory =
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-li=
nux-uclibc/libstdc++-v3/src'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[4]: *** [all-recursive] Error =
1</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[4]: Leaving directory =
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-li=
nux-uclibc/libstdc++-v3'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[3]: *** [all] Error 2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[3]: Leaving directory =
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/mipsel-li=
nux-uclibc/libstdc++-v3'</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[2]: *** [all-target-libstdc++-v3] Error =
2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[2]: Leaving directory =
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final'</span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: *** [all] Error 2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make[1]: Leaving directory =
`/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final'</span></=
font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>make: *** =
[/home/rdejong/buildroot/toolchain_build_mipsel/gcc-4.1.0-final/.compiled=
]
Error 2</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The uClibc is uClibc-0.9.28</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The binutils is =
binutils-2.16.91.0.7</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is there an option I should have turned =
on?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Does anyone know what the correct combination of
buildroot/toolchain that will give me the NPTL =
functionality?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Rienco</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C66FCD.FE7A427C--

------=neXtPaRt_1146783397
Content-Type: text/plain;

**********************************************************************
Notice to recipient: This email is meant for only the intended recipient of the transmission, and may be a communication privileged by law, subject to export control restrictions or that otherwise contains proprietary information.  If you receive this email by mistake, please notify us immediately by replying to this message and then destroy it and do not review, disclose, copy or distribute it.  Thank you in advance for your cooperation.
**********************************************************************


------=neXtPaRt_1146783397--
