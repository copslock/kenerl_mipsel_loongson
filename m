Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 21:07:53 +0200 (CEST)
Received: from ausxipps301.us.dell.com ([143.166.148.223]:53803 "EHLO
        ausxipps301.us.dell.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491981Ab0HCTHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 21:07:45 +0200
X-Loopcount0: from 10.166.72.158
From:   <Ryan_D_Phillips@Dell.com>
To:     <linux-mips@linux-mips.org>
Date:   Tue, 3 Aug 2010 14:07:30 -0500
Subject: mips, eglibc, and toolchain compilation error
Thread-Topic: mips, eglibc, and toolchain compilation error
Thread-Index: AcszPx7DpCEQ+lTOTRSdAzgzAaP7/w==
Message-ID: <017987BD9AB15445B9968338EC889BB107D3ECEC72@AUSX7MCPS301.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: multipart/alternative;
        boundary="_000_017987BD9AB15445B9968338EC889BB107D3ECEC72AUSX7MCPS301A_"
MIME-Version: 1.0
X-OriginalArrivalTime: 03 Aug 2010 19:07:31.0972 (UTC) FILETIME=[1FCDAC40:01CB333F]
Return-Path: <Ryan_D_Phillips@Dell.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ryan_D_Phillips@Dell.com
Precedence: bulk
X-list: linux-mips

--_000_017987BD9AB15445B9968338EC889BB107D3ECEC72AUSX7MCPS301A_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

I'm trying to get openembedded to build me a 32bit MIPS toolchain using EGL=
IBC. GCC 4.4.4 seems to compile ok, but when I get to eglibc 2.10 and 2.11 =
the compiler spits this error:

| /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/=
eglibc-2.11-r11.6/build-mips-angstrom-linux/libc_pic.os: In function `_mcou=
nt':
| (.debug_macinfo+0x5d7a7a8): relocation truncated to fit: R_MIPS_HI16 agai=
nst `_gp_disp'
| collect2: ld returned 1 exit status
| make[1]: *** [/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-a=
ngstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc.so] Error 1
| make[1]: Leaving directory `/home/rphillips/sdk/build-dell-tor-angstrom/t=
mp/work/mips-angstrom-linux/eglibc-2.11-r11.6/eglibc-2_11/libc'
| make: *** [all] Error 2
| FATAL: oe_runmake failed
NOTE: Task failed: /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mip=
s-angstrom-linux/eglibc-2.11-r11.6/temp/log.do_compile.10164
ERROR: TaskFailed event exception, aborting
ERROR: Build of /home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/e=
glibc_2.11.bb do_compile failed
ERROR: Task 9 (/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eg=
libc_2.11.bb, do_compile) failed
NOTE: Tasks Summary: Attempted 475 tasks of which 159 didn't need to be rer=
un and 1 failed.
ERROR: '/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.=
11.bb' failed

It appears the Debian MIPS stack uses EGLIBC and GCC 4 successfully. Does a=
nyone know what the problem is, and how I can fix it?

Google has been of limited use for this error.

Regards,
Ryan Phillips


--_000_017987BD9AB15445B9968338EC889BB107D3ECEC72AUSX7MCPS301A_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal>Hi All,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>I&#8217;m trying to get openembedded to build me a 32b=
it
MIPS toolchain using EGLIBC. GCC 4.4.4 seems to compile ok, but when I get =
to
eglibc 2.10 and 2.11 the compiler spits this error:<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>| /home/rphillips/sdk/build-dell-tor-angstrom/tmp/work=
/mips-angstrom-linux/eglibc-2.11-r11.6/build-mips-angstrom-linux/libc_pic.o=
s:
In function `_mcount':<o:p></o:p></p>

<p class=3DMsoNormal>| (.debug_macinfo+0x5d7a7a8): relocation truncated to =
fit:
R_MIPS_HI16 against `_gp_disp'<o:p></o:p></p>

<p class=3DMsoNormal>| collect2: ld returned 1 exit status<o:p></o:p></p>

<p class=3DMsoNormal>| make[1]: ***
[/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/e=
glibc-2.11-r11.6/build-mips-angstrom-linux/libc.so]
Error 1<o:p></o:p></p>

<p class=3DMsoNormal>| make[1]: Leaving directory
`/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/e=
glibc-2.11-r11.6/eglibc-2_11/libc'<o:p></o:p></p>

<p class=3DMsoNormal>| make: *** [all] Error 2<o:p></o:p></p>

<p class=3DMsoNormal>| FATAL: oe_runmake failed<o:p></o:p></p>

<p class=3DMsoNormal>NOTE: Task failed:
/home/rphillips/sdk/build-dell-tor-angstrom/tmp/work/mips-angstrom-linux/eg=
libc-2.11-r11.6/temp/log.do_compile.10164<o:p></o:p></p>

<p class=3DMsoNormal>ERROR: TaskFailed event exception, aborting<o:p></o:p>=
</p>

<p class=3DMsoNormal>ERROR: Build of
/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb
do_compile failed<o:p></o:p></p>

<p class=3DMsoNormal>ERROR: Task 9
(/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb,
do_compile) failed<o:p></o:p></p>

<p class=3DMsoNormal>NOTE: Tasks Summary: Attempted 475 tasks of which 159 =
didn't
need to be rerun and 1 failed.<o:p></o:p></p>

<p class=3DMsoNormal>ERROR:
'/home/rphillips/work/mips/sdk/openembedded/recipes/eglibc/eglibc_2.11.bb'
failed<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>It appears the Debian MIPS stack uses EGLIBC and GCC 4
successfully. Does anyone know what the problem is, and how I can fix it? <=
o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Google has been of limited use for this error.<o:p></o=
:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Regards,<o:p></o:p></p>

<p class=3DMsoNormal>Ryan Phillips<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

--_000_017987BD9AB15445B9968338EC889BB107D3ECEC72AUSX7MCPS301A_--
