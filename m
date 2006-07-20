Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 17:02:47 +0100 (BST)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:3017 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133863AbWGTQCi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 17:02:38 +0100
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 5FF4520611
	for <linux-mips@linux-mips.org>; Thu, 20 Jul 2006 21:29:33 +0530 (IST)
Received: from blr-ec-bh02.wipro.com (blr-ec-bh02.wipro.com [10.201.50.92])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 45B38205F9
	for <linux-mips@linux-mips.org>; Thu, 20 Jul 2006 21:29:33 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh02.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Jul 2006 21:32:28 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6AC15.E5D92044"
Subject: Bit operations work differently on MIPS and IA32
Date:	Thu, 20 Jul 2006 21:32:27 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB09D3D8@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bit operations work differently on MIPS and IA32
Thread-Index: AcasFQ/xrmCPYNwVQ4+tr2B2UuBJFg==
From:	<hemanth.venkatesh@wipro.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 20 Jul 2006 16:02:28.0051 (UTC) FILETIME=[E60C8A30:01C6AC15]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AC15.E5D92044
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

=20

I ran the below program on an IA32 and AU1100 machine, both being little
endian machines and got different results. Does anyone know what could
be the cause of this behaviour. This problem is blocking us from booting
the cramfs rootfs.

=20

#include <stdio.h>

typedef unsigned int u32;

main()

{

struct tmp{

u32 namelen:6,offset:26;

}tmp1;

=20

(*(int *)(&tmp1))=3D0x4c0;

=20

printf("%d %d\n",tmp1.namelen,tmp1.offset);

=20

}

=20

Results on IA32 : 0 19

=20

Results on AU1100 (MIPS):  0 1216

=20

Thanks

hemanth


------_=_NextPart_001_01C6AC15.E5D92044
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
font-family:Arial'>Hi All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I ran the below program on an IA32 and AU1100 =
machine, both
being little endian machines and got different results. Does anyone know =
what
could be the cause of this behaviour. This problem is blocking us from =
booting
the cramfs rootfs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>#include &lt;stdio.h&gt;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>typedef unsigned int =
u32;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>main()<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>struct tmp{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>u32 namelen:6,offset:26;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>}tmp1;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(*(int =
*)(&amp;tmp1))=3D0x4c0;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>printf(&quot;%d =
%d\n&quot;,tmp1.namelen,tmp1.offset);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>Results on IA32 : 0 19<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>Results on AU1100 (MIPS):&nbsp; 0 =
1216<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>Thanks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:11.0pt;
font-family:Arial'>hemanth<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6AC15.E5D92044--
