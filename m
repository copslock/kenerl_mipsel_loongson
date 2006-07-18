Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2006 06:25:03 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:63211 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8126482AbWGRFYy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Jul 2006 06:24:54 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 86737205ED
	for <linux-mips@linux-mips.org>; Tue, 18 Jul 2006 10:51:52 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 56286205EC
	for <linux-mips@linux-mips.org>; Tue, 18 Jul 2006 10:51:51 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 18 Jul 2006 10:54:42 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AA29.6F544430"
Subject: RE: Mounting rootfs from Alchemy Flash fails
Date:	Tue, 18 Jul 2006 10:47:16 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D11E@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Mounting rootfs from Alchemy Flash fails
Thread-Index: AcaprqiZwSqm6qT8QY2NecCyN8MlvgAeXs+QAAAbMpA=
From:	<hemanth.venkatesh@wipro.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Jul 2006 05:24:42.0129 (UTC) FILETIME=[78F4B810:01C6AA2A]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AA29.6F544430
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

=20

   We are trying to boot Linux MIPS 2.6.14 kernel on an AU1100 based
board, mounting  root file system from Flash (S29GLxxxN MirrorBitTM
Family, AMD Spansion) fails.  We have updated Alchamy-flash.c  to
specify  flash size 32 MB and physical address as 0X1E000000.  We found
that probe function is failing and vendor command set is not found, log
attached below. Any inputs for resolving the problem are appreciated.

=20

=20

Kernel command line arguments:   root=3D/dev/mtdblock0,

=20

SUI Flash: probing 32-bit flash bus

SUI Flash: Found 2 x16 devices at 0x0 in 32-bit bank

 Amd/Fujitsu Extended Query Table at 0x0040

SUI Flash: CFI does not contain boot bank location. Assuming top.

number of CFI chips: 1

Sum of regions (0) !=3D total size of set of interleaved chips (2000000)

gen_probe: No supported Vendor Command Set found

=20

=20

Thanks in advance

Hemanth

=20


------_=_NextPart_001_01C6AA29.6F544430
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
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
span.EmailStyle17
	{mso-style-type:personal;
	font-family:Arial;
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:Arial;
	color:navy;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
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
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp; We are trying to boot Linux MIPS 2.6.14 =
kernel
on an AU1100 based board, mounting &nbsp;root file system from Flash =
(S29GLxxxN
MirrorBitTM Family, AMD Spansion) fails.&nbsp; We have updated =
Alchamy-flash.c
&nbsp;to specify &nbsp;flash size 32 MB and physical address as =
0X1E000000.
&nbsp;We found that probe function is failing and vendor command set is =
not
found, log attached below. Any inputs for resolving the problem are
appreciated.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Kernel command line arguments:&nbsp;&nbsp;
root=3D/dev/mtdblock0,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SUI Flash: probing 32-bit flash =
bus<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SUI Flash: Found 2 x16 devices at 0x0 in 32-bit =
bank<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;Amd/Fujitsu Extended Query Table at =
0x0040<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>SUI Flash: CFI does not contain boot bank location. =
Assuming
top.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>number of CFI chips: 1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Sum of regions (0) !=3D total size of set of =
interleaved chips
(2000000)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>gen_probe: No supported Vendor Command Set =
found<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks in advance<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hemanth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6AA29.6F544430--
