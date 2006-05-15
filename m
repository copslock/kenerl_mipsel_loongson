Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 18:36:58 +0200 (CEST)
Received: from gateway.stellartec.com ([65.107.16.99]:43021 "EHLO
	gateway.stellartec.com") by ftp.linux-mips.org with ESMTP
	id S8133569AbWEOQgu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 18:36:50 +0200
Received: from Exchange.stellartec.com ([10.1.1.7]) by gateway.stellartec.com with Microsoft SMTPSVC(6.0.3790.1830); Mon, 15 May 2006 09:32:50 -0700
Content-Class: urn:content-classes:message
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6783D.34D4EE96"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Importance: normal
Priority: normal
Subject: Need help burning flash using osprey vr41xx
Date:	Mon, 15 May 2006 09:32:52 -0700
Message-ID: <7F5F67B895426C40AC75B8290421C239D1ED02@Exchange.stellartec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Need help burning flash using osprey vr41xx
thread-index: AcZ4PTY+uPxSRx/bR++VWyHo1wyvPg==
From:	"Yashwant Shitoot" <yshitoot@stellartec.com>
To:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 15 May 2006 16:32:50.0239 (UTC) FILETIME=[34E4DCF0:01C6783D]
Return-Path: <yshitoot@stellartec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yshitoot@stellartec.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6783D.34D4EE96
X-EC0D2A8E-5CB7-4969-9C36-46D859D137BE-PartID: E8350D8F-73BE-426E-B8F0-E99E7CB1977F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

=20

I do have a working system with vrboot, vmlinux and romdisk. Now I would
like to use about 10 bytes in the unused portion of flash (at addr
0xbfc01fc0) and put in a serial number. I have tried bin2rom
serialNum.inf 0xbfc01fc0 0xbfc01fff (and some variations) however
ethload hangs up at "sending jump addr".

=20

Any suggestions ?

=20

Thanks

=20

Yash

=20


------_=_NextPart_001_01C6783D.34D4EE96
X-EC0D2A8E-5CB7-4969-9C36-46D859D137BE-PartID: 6FC3009E-4F04-46E2-B509-239A0C4033E7
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META http-equiv=3D"Content-Type" content=3D"text/html; =
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

<body link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I do have a working system with vrboot, vmlinux and =
romdisk.
Now I would like to use about 10 bytes in the unused portion of flash =
(at addr
0xbfc01fc0) and put in a serial number. I have tried bin2rom =
serialNum.inf
0xbfc01fc0 0xbfc01fff (and some variations) however ethload hangs up at
&#8220;sending jump addr&#8221;.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any suggestions ?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Yash</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6783D.34D4EE96--
