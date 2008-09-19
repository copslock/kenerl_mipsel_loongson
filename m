Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 04:30:50 +0100 (BST)
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:24241 "EHLO
	VA3EHSOBE005.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S28661601AbYISDao (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 04:30:44 +0100
Received: from mail177-va3-R.bigfish.com (10.7.14.249) by
 VA3EHSOBE005.bigfish.com (10.7.40.25) with Microsoft SMTP Server id
 8.1.291.1; Fri, 19 Sep 2008 03:30:35 +0000
Received: from mail177-va3 (localhost.localdomain [127.0.0.1])	by
 mail177-va3-R.bigfish.com (Postfix) with ESMTP id 716CF1C4030C;	Fri, 19 Sep
 2008 03:30:35 +0000 (UTC)
X-BigFish: VPS-13(zzfadRa0dJ4015M19c2k1127izzzzz2dh6bh61h)
X-FB-SS: 5,
Received: by mail177-va3 (MessageSwitch) id 1221795033724756_17860; Fri, 19
 Sep 2008 03:30:33 +0000 (UCT)
Received: from sggdcex1ns01.sony.com.sg (sggdcex1ns01.sony.com.sg
 [121.100.32.134])	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168
 bits))	(No client certificate requested)	by mail177-va3.bigfish.com (Postfix)
 with ESMTP id 252A63F005A;	Fri, 19 Sep 2008 03:30:32 +0000 (UTC)
Received: from sggdcwn1vs01.sony.com.sg (sggdcwn1vs01 [43.68.8.23])	by
 sggdcex1ns01.sony.com.sg (8.13.7+Sun/8.13.7) with SMTP id m8J3UUQu005300;
	Fri, 19 Sep 2008 11:30:30 +0800 (SGT)
Received: from (sgsesgdcid01.sony.com.sg [43.68.8.1]) by
 sggdcwn1vs01.sony.com.sg with smtp	 id
 4bf1_4f26a192_85fb_11dd_9d83_001372631f16;	Fri, 19 Sep 2008 11:30:30 +0800
Received: from sgapxbh05.ap.sony.com (sgapxbh05.ap.sony.com [43.68.17.37])	by
 sgsesgdcid01.sony.com.sg (8.13.7+Sun/8.13.7) with ESMTP id m8J3UT4m001099;
	Fri, 19 Sep 2008 11:30:30 +0800 (SGT)
Received: from insardxms01.ap.sony.com ([43.88.102.10]) by
 sgapxbh05.ap.sony.com with Microsoft SMTPSVC(6.0.3790.3959); Fri, 19 Sep 2008
 11:30:29 +0800
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4325
Content-Class: urn:content-classes:message
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C91A08.0F514503"
Subject: Re: execve errno setting on MIPS
Importance: normal
Priority: normal
Date:	Fri, 19 Sep 2008 09:00:27 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D56DA36@insardxms01.ap.sony.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: execve errno setting on MIPS
Thread-Index: AckaCA8v4R6D1uVXQOug9n4dgz7APw==
From:	"Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>
To:	<ralf@linux-mips.org>
CC:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 19 Sep 2008 03:30:29.0762 (UTC) FILETIME=[109DFE20:01C91A08]
Return-Path: <halesh.sadashiv@ap.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: halesh.sadashiv@ap.sony.com
Precedence: bulk
X-list: linux-mips

------_=_NextPart_001_01C91A08.0F514503
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
=20
>> The one is two dimensional array, the other an array of pointers to
char.
=20
Yes, Fixed the problem,=20
But on MIPS, ARG_MAX is not considered, I was able to get the E2BIG on
2*ARG_MAX.
=20
Check
http://www.linux-mips.org/archives/linux-mips/2008-09/msg00136.html =20
=20

Thanks,

Halesh



-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------

------_=_NextPart_001_01C91A08.0F514503
Content-Type: text/html; charset="us-ascii"
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
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
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

<div class=3DSection1><pre><font size=3D2 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
re><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
re><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>&gt;&gt; The one is two =
dimensional array, the other an array of pointers to =
char.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
re><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Yes, Fixed the problem, =
<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>But on MIPS, ARG_MAX is not =
considered, I was able to get the E2BIG on =
2*ARG_MAX.<o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
re><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'>Check<o:p></o:p></span></font></pr=
e><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><a
href=3D"http://www.linux-mips.org/archives/linux-mips/2008-09/msg00136.ht=
ml">http://www.linux-mips.org/archives/linux-mips/2008-09/msg00136.html</=
a>&nbsp; <o:p></o:p></span></font></pre><pre><font
size=3D2 color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:10.0pt;color:black'><o:p>&nbsp;</o:p></span></font></p=
re>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Halesh<o:p></o:p></span></font></p>

</div>

<p></p><hr><br>This email is confidential and intended only for the use =
of the individual or entity named above and may contain information that =
is privileged. If you are not the intended recipient, you are notified =
that any dissemination, distribution or copying of this email is =
strictly prohibited. If you have received this email in error, please =
notify us immediately by return email or telephone and destroy the =
original message. - This mail is sent via Sony Asia Pacific Mail =
Gateway.<hr></body>

</html>

------_=_NextPart_001_01C91A08.0F514503--
