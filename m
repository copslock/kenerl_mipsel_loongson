Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2007 03:38:02 +0000 (GMT)
Received: from mail.gnss.com ([209.47.22.10]:38916 "EHLO tormf01.gmi.domain")
	by ftp.linux-mips.org with ESMTP id S20035727AbXLMDhx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2007 03:37:53 +0000
Received: from tormf01.gmi.domain (127.0.0.1) by tormf01.gmi.domain (MlfMTA v3.2r9) id hc2kh20171s3 for <linux-mips@linux-mips.org>; Wed, 12 Dec 2007 22:37:22 -0500 (envelope-from <Nilanjan.Roychowdhury@gnss.com>)
Received: from INDEXCH2003.gmi.domain ([10.41.1.181])
	by tormf01.gmi.domain (SonicWALL 6.0.1.9157)
	with ESMTP; Wed, 12 Dec 2007 22:37:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C83D39.7724DEF1"
Subject: Inter processor synchronization
Date:	Thu, 13 Dec 2007 09:07:20 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D690106A282@INDEXCH2003.gmi.domain>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Inter processor synchronization
Thread-Index: Acg9OXc4eZ2or01CQpavhNXQtClAVQ==
From:	"Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@gnss.com>
To:	<linux-mips@linux-mips.org>
X-Mlf-Version: 6.0.1.9157
X-Mlf-UniqueId:	o200712130337200048605
Return-Path: <Nilanjan.Roychowdhury@gnss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Nilanjan.Roychowdhury@gnss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83D39.7724DEF1
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a scenario where two images of the same Linux kernel are running
on two MIPS cores. One is 24K and another is 4KEC. What is the best way
to achieve inter processor synchronization between them?

I guess the locks for LL/SC are local to a particular core and can not
be extended across a multi core system.=20

=20

Will it be easier for me if both of them becomes same core ( like both
24k) and I run the SMP version of Linux.

Please throw some light.

=20

Thanks,

Nilanjan

=20

=20


------_=_NextPart_001_01C83D39.7724DEF1
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:"\@MS Mincho";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
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
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a scenario where two images of the same Linux =
kernel
are running on two MIPS cores. One is 24K and another is 4KEC. What is =
the best
way to achieve inter processor synchronization between =
them?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I guess the locks for LL/SC are local to a particular =
core
and can not be extended across a multi core system. =
<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Will it be easier for me if both of them becomes same =
core (
like both 24k) and I run the SMP version of =
Linux.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Please throw some light.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Nilanjan<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C83D39.7724DEF1--
