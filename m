Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2004 18:19:56 +0100 (BST)
Received: from mail.stellartec.com ([IPv6:::ffff:65.107.16.99]:24589 "EHLO
	gateway.stellartec.com") by linux-mips.org with ESMTP
	id <S8226044AbUEFRTz>; Thu, 6 May 2004 18:19:55 +0100
Received: from Exchange.stellartec.com ([192.168.1.7]) by gateway.stellartec.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 6 May 2004 10:19:44 -0700
X-MIMEOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4338E.53011F38"
Subject: Strange Behavior - help
Date: Thu, 6 May 2004 10:19:43 -0700
Message-ID: <7F5F67B895426C40AC75B8290421C23915CE57@Exchange.stellartec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange Behavior - help
Thread-Index: AcQzjlK5D+RXyiEsR4KMtsdJR31r+g==
From: "Yashwant Shitoot" <yshitoot@stellartec.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 06 May 2004 17:19:44.0455 (UTC) FILETIME=[5306E570:01C4338E]
Return-Path: <yshitoot@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yshitoot@stellartec.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4338E.53011F38
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello Friends,

=20

My root file system and linux is in rom (flash). The linux itself runs
out of ram. When I reprogram the rom, I erase and write a new image of
the rom from a compact flash card. After the new image is programmed in
the function fclose() hangs up, implying that fclose() is rom resident
and loaded as needed. Does this make sense ? Remember even after erasing
the rom fopen() works fine.

=20

Thanks=20

=20

Yash


------_=_NextPart_001_01C4338E.53011F38
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
	margin:1.0in 1.0in 192.25pt 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello Friends,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>My root file system and linux is in rom (flash). The =
linux
itself runs out of ram. When I reprogram the rom, I erase and write a =
new image
of the rom from a compact flash card. After the new image is programmed =
in the
function fclose() hangs up, implying that fclose() is rom resident and =
loaded
as needed. Does this make sense ? Remember even after erasing the rom =
fopen()
works fine.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks <o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Yash<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C4338E.53011F38--
