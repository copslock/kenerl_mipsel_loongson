Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2003 08:31:28 +0100 (BST)
Received: from no-dns-yet.demon.co.uk ([IPv6:::ffff:193.195.124.4]:31986 "EHLO
	exterity-serv1.exterity.co.uk") by linux-mips.org with ESMTP
	id <S8225406AbTIXHbZ>; Wed, 24 Sep 2003 08:31:25 +0100
Received: from gillpc ([194.168.0.67]) by exterity-serv1.exterity.co.uk with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 24 Sep 2003 08:31:33 +0100
From: "Gill" <gill.robles@exterity.co.uk>
To: <linux-mips@linux-mips.org>
Subject: Page fault question
Date: Wed, 24 Sep 2003 08:36:38 +0100
Organization: Exterity
Message-ID: <000901c3826e$9703adc0$4300a8c2@gillpc>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000A_01C38276.F8C815C0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-OriginalArrivalTime: 24 Sep 2003 07:31:33.0718 (UTC) FILETIME=[E12A0760:01C3826D]
Return-Path: <gill.robles@exterity.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gill.robles@exterity.co.uk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_000A_01C38276.F8C815C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello -

=20

I'm currently porting vmlinux from NEC's EMMA2L platform to EMMA2.  The
problem I'm having is that linux hangs when it attempts to do its first =
page
fault: the page fault handler is successfully called, the call to
handle_mm_fault returns 2 (major fault).but then code execution appears =
to
just stop.  Linux is not completely dead, however - it still responds to =
a
timer interrupt.

=20

As the code for handling page faults is standard code, and TLB hardware
should be the same on EMMA2 as on EMMA2L (where it works!), I don't
understand what's gone wrong!  Does anyone have any ideas?

=20

Thanks for your help,

=20

=20

Gill


------=_NextPart_000_000A_01C38276.F8C815C0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello &#8211;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I&#8217;m currently porting vmlinux from NEC&#8217;s =
EMMA2L
platform to EMMA2.&nbsp; The problem I&#8217;m having is that linux =
hangs when
it attempts to do its first page fault: the page fault handler is =
successfully
called, the call to handle_mm_fault returns 2 (major fault)&#8230;but =
then code
execution appears to just stop.&nbsp; Linux is not completely dead, =
however &#8211;
it still responds to a timer interrupt.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>As the code for handling page faults is standard =
code, and
TLB hardware should be the same on EMMA2 as on EMMA2L (where it works!), =
I don&#8217;t
understand what&#8217;s gone wrong!&nbsp; Does anyone have any =
ideas?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks for your help,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Gill</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000A_01C38276.F8C815C0--
