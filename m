Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 21:39:49 +0100 (BST)
Received: from smtp-out.sigp.net ([63.237.78.44]:34480 "EHLO smtp-out.sigp.net")
	by ftp.linux-mips.org with ESMTP id S20038690AbWJZUjr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2006 21:39:47 +0100
Received: from gamd-ex-001.ss.drs.master (gamd-ex-001.ss.drs.master [172.22.132.94])
	by smtp-out.sigp.net (8.13.8/8.13.8) with ESMTP id k9QKdgT9023703
	for <linux-mips@linux-mips.org>; Thu, 26 Oct 2006 16:39:46 -0400 (EDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6F93E.DD87FC1D"
Subject: sanblaze driver -> LSFC929 FiberChannel
Date:	Thu, 26 Oct 2006 16:39:42 -0400
Message-ID: <DEB94D90ABFC8240851346CFD4ACFF14AD2ADD@gamd-ex-001.ss.drs.master>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: sanblaze driver -> LSFC929 FiberChannel
Thread-Index: Acb5Pt2EPPySneLrRnOmjArihRbxDw==
From:	"Azer, William" <Bill.Azer@drs-ss.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <Bill.Azer@drs-ss.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Bill.Azer@drs-ss.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6F93E.DD87FC1D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

=20

i am using the sanblaze card configured in the kernel for the
fiberchannel.  i enabled the mpt fusion fc and the ioctl driver, i also
enable scsi disk support, ...

=20

I get an error and it hangs.

=20

=20

Has any one used the sanblaze fc driver in the kernel (I am using kernel
version 2.6.17.7)

=20

=20

Thx,

=20

Bill Azer

=20

i tried loading the drivers and get this error :

=20

bash-2.05b# insmod drivers/message/fusion/mptbase.ko

Fusion MPT base driver 3.03.09

Copyright (c) 1999-2005 LSI Logic Corporation

bash-2.05b# insmod drivers/message/fusion/mptctl.ko

Fusion MPT misc device (ioctl) driver 3.03.09

mptctl: Registered with Fusion MPT base driver

mptctl: /dev/mptctl @ (major,minor=3D10,220)

bash-2.05b# insmod drivers/message/fusion/mptscsih.ko

bash-2.05b# insmod drivers/scsi/scsi_transport_fc.ko

bash-2.05b# insmod

/lib/modules/2.6.17.7/kernel/drivers/message/fusion/mptfc.ko

Fusion MPT FC Host driver 3.03.09

mptbase: Initiating ioc0 bringup

ioc0: FC929: Capabilities=3D{Initiator,Target,LAN}

=20

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (130)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

scsi0 : ioc0: LSIFC929, FwRev=3D02000a00h, Ports=3D1, MaxQ=3D1023, =
IRQ=3D10

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

mptbase: Initiating ioc0 recovery

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (0)!

mptbase: mpt_reply: WARNING - ioc0: Invalid cb_idx (65)!

=20

=20

=20

=20


------_=_NextPart_001_01C6F93E.DD87FC1D
Content-Type: text/html;
	charset="us-ascii"
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
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hi =
All,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>i am using the =
sanblaze card
configured in the kernel for the fiberchannel.&nbsp; i enabled the mpt =
fusion fc and
the ioctl driver, i also enable scsi disk support, =
...<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I get an error and =
it hangs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Has any one used =
the
sanblaze fc driver in the kernel (I am using kernel version =
2.6.17.7)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>Thx,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Bill =
Azer<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>i tried loading the =
drivers
and get this error :<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# insmod
drivers/message/fusion/mptbase.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Fusion MPT base =
driver
3.03.09<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Copyright (c) =
1999-2005 LSI
Logic Corporation<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# insmod
drivers/message/fusion/mptctl.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Fusion MPT misc =
device
(ioctl) driver 3.03.09<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptctl: Registered =
with
Fusion MPT base driver<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptctl: /dev/mptctl =
@
(major,minor=3D10,220)<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# insmod
drivers/message/fusion/mptscsih.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# insmod
drivers/scsi/scsi_transport_fc.ko<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>bash-2.05b# =
insmod<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'>/lib/modules/2.6.17.7/kernel/drivers/message/fusion/mptfc.ko<o:p></=
o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Fusion MPT FC Host =
driver
3.03.09<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: Initiating =
ioc0
bringup<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>ioc0: FC929:
Capabilities=3D{Initiator,Target,LAN}<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (0)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (0)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: Initiating =
ioc0
recovery<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (130)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (65)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: Initiating =
ioc0
recovery<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (0)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (65)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: Initiating =
ioc0
recovery<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (0)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>scsi0 : ioc0: =
LSIFC929,
FwRev=3D02000a00h, Ports=3D1, MaxQ=3D1023, =
IRQ=3D10<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (65)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: Initiating =
ioc0
recovery<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (0)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>mptbase: mpt_reply: =
WARNING
- ioc0: Invalid cb_idx (65)!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C6F93E.DD87FC1D--
