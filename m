Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jul 2006 15:30:47 +0100 (BST)
Received: from lvs00-fl-n02.ftl.affinity.com ([216.219.253.98]:16306 "EHLO
	lvs00-fl-n02.ftl.affinity.com") by ftp.linux-mips.org with ESMTP
	id S8133847AbWGTOag (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Jul 2006 15:30:36 +0100
Received: from [24.106.202.234] ([24.106.202.234]:13062 "EHLO 3PiGAS")
	by ams002.ftl.affinity.com with ESMTP id S362485AbWGTOaa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Jul 2006 10:30:30 -0400
From:	"Gary Smith" <gary.smith@3phoenix.com>
To:	<linux-mips@linux-mips.org>
Subject: IDE on Swarm
Date:	Thu, 20 Jul 2006 10:30:28 -0400
Organization: 3 Phoenix, Inc.
Message-ID: <000601c6ac09$0c262f30$6dacaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C6ABE7.85148F30"
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AcasCQvZcIj85GkSRXKQ3ZPigI/XLA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Return-Path: <gary.smith@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gary.smith@3phoenix.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C6ABE7.85148F30
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello All,

 

I'd like to ask a question regarding a post I noticed on a message board.
The post I read is as follows.

 

http://mail.bitmover.com/pipermail/sibyte-users/2004-November/000029.html

 

I am using a BCM91250A evaluation board with a compactflash device connected
to the onboard IDE controller.  When booting with a Linux 2.4.20 kernel, the
IDE interface is recognized and the compactflash device is hda.  When
booting with a Linux 2.6.16.25 kernel, the IDE interface is recognized, but
no device information is echoed to the console.  I've included output below.
The message post above mentions that there were problems with the IDE driver
in Linux 2.6 during the late 2004 time-frame.  I'd like to inquire about the
current availability of the IDE driver in the kernel.

 

 

Linux 2.4.20 Output:

 

Uniform Multi-Platform E-IDE driver Revision: 6.31

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx

SiByte onboard IDE configured as device 0

hda: SanDisk SDCFB-1024, ATA DISK drive

ide0 at 0xffffffffb00b3e01-0xffffffffb00b3e08,0xffffffffb00b7ec1 on irq 36

hda: 2001888 sectors (1025 MB) w/1KiB Cache, CHS=1986/16/63

Partition check:

 /dev/ide/host0/bus0/target0/lun0: p1

 

 

 

Linux 2.6.16.25 Output:

 

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx

ide-floppy driver 0.99.newide

SWARM IDE driver

ide-swarm: IDE interface at GenBus slot 4

NET: Registered protocol family 2

 

 

Thank you for your time.

 

Gary

--

Gary A. Smith, ABD PhD
Systems Engineer, 3Phoenix, Inc.


------=_NextPart_000_0007_01C6ABE7.85148F30
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"City"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
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

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Hello =
All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>I&#8217;d like
to ask a question regarding a post I noticed on a message board.&nbsp; =
The post
I read is as follows.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>http://mail.bitmover.com/pipermail/sibyte-users/2004-No=
vember/000029.html<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>I am =
using a
BCM91250A evaluation board with a compactflash device connected to the =
onboard
IDE controller.&nbsp; When booting with a Linux 2.4.20 kernel, the IDE
interface is recognized and the compactflash device is hda.&nbsp; When =
booting
with a Linux 2.6.16.25 kernel, the IDE interface is recognized, but no =
device
information is echoed to the console.&nbsp; I&#8217;ve included output
below.&nbsp; The message post above mentions that there were problems =
with the
IDE driver in Linux 2.6 during the late 2004 time-frame.&nbsp; I&#8217;d =
like
to inquire about the current availability of the IDE driver in the =
kernel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Linux =
2.4.20
Output:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Uniform
Multi-Platform E-IDE driver Revision: 6.31<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>ide: =
Assuming
50MHz system bus speed for PIO modes; override with =
idebus=3Dxx<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>SiByte =
onboard
IDE configured as device 0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>hda: =
SanDisk
SDCFB-1024, ATA DISK drive<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>ide0 at =
0xffffffffb00b3e01-0xffffffffb00b3e08,0xffffffffb00b7ec1
on irq 36<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>hda: =
2001888
sectors (1025 MB) w/1KiB Cache, =
CHS=3D1986/16/63<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>Partition check:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>&nbsp;/dev/ide/host0/bus0/target0/lun0:
p1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Linux =
2.6.16.25
Output:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Uniform =
Multi-Platform
E-IDE driver Revision: 7.00alpha2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>ide: =
Assuming
50MHz system bus speed for PIO modes; override with =
idebus=3Dxx<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>ide-floppy
driver 0.99.newide<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>SWARM =
IDE driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'>ide-swarm: IDE
interface at GenBus slot 4<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>NET: =
Registered
protocol family 2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier New";color:black'>Thank =
you for
your time.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 color=3Dblack face=3D"Courier =
New"><span
style=3D'font-size:12.0pt;font-family:"Courier =
New";color:black'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><st1:City w:st=3D"on"><font =
size=3D3
  color=3Dblack face=3D"Courier New"><span =
style=3D'font-size:12.0pt;font-family:
  "Courier =
New";color:black'>Gary</span></font></st1:City></st1:place><font
color=3Dblack face=3D"Courier New"><span style=3D'font-family:"Courier =
New";
color:black'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span =
style=3D'font-size:12.0pt;
font-family:"Courier New"'>--</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Courier New"><span =
style=3D'font-size:12.0pt;
font-family:"Courier New"'>Gary A. Smith, ABD PhD<br>
Systems Engineer, 3Phoenix, Inc.</span></font><o:p></o:p></p>

</div>

</body>

</html>

------=_NextPart_000_0007_01C6ABE7.85148F30--
