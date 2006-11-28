Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 08:30:10 +0000 (GMT)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:21439 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S20038748AbWK1IaG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Nov 2006 08:30:06 +0000
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 4220520611
	for <linux-mips@linux-mips.org>; Tue, 28 Nov 2006 13:53:55 +0530 (IST)
Received: from blr-ec-bh01.wipro.com (blr-ec-bh01.wipro.com [10.201.50.91])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 2B360205D9
	for <linux-mips@linux-mips.org>; Tue, 28 Nov 2006 13:53:55 +0530 (IST)
Received: from blr-m2-msg.wipro.com ([10.116.50.99]) by blr-ec-bh01.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 28 Nov 2006 14:00:18 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C712C7.701BA5A8"
Subject: RE: USB keyboard not getting handled???????
Date:	Tue, 28 Nov 2006 13:58:55 +0530
Message-ID: <2156B1E923F1A147AABDF4D9FDEAB4CB28A7A2@blr-m2-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: USB keyboard not getting handled???????
Thread-Index: AccSveU+J6QaaCpBQduvmsOzvJmKBgAAFnDA
From:	<hemanth.venkatesh@wipro.com>
To:	<chandu.nitw@gmail.com>, <linux-mips@linux-mips.org>,
	<puneet.goel@samsung.com>
X-OriginalArrivalTime: 28 Nov 2006 08:30:18.0521 (UTC) FILETIME=[6FB40890:01C712C7]
Return-Path: <hemanth.venkatesh@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13264
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanth.venkatesh@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C712C7.701BA5A8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We faced a similar problem on 2.6.14 kernel (on AU1100 board) where the
keyboard is detected, but the keystrokes don't appear on the serial
console. Our thinking was that additional support/application is
required to interface with the HID driver, to re-direct keystrokes onto
console. =20

=20

Hemanth

=20

________________________________

From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of chandrashekar
mogilicherla
Sent: Tuesday, November 28, 2006 12:41 PM
To: linux-mips@linux-mips.org; Puneet
Subject: USB keyboard not getting handled???????

=20


Iam using a device with linux 2.6.11 kernel running on mips arch.
I have got a problem trying to enable usb keyboard  on my device.
When i enable following options in kernel config
         USB_CONFIG
           ohci, ehci
          hid or boot hid
          keyboard in input devices

USB keyboard is detected . It is shown in /proc/bus/usb/devices ,
drivers are loaded. But keyboard is not working.=20

Following is the mesg log i get when i enabled usb feaures in kernel,
------------------------------------------------------------------------
------------------------
In ehci_hcd_au1xxx_drv_probe
drivers/usb/host/ehci-au1xxx.c: starting Au1xxx EHCI USB Controller
drivers/usb/host/ehci-au1xxx.c: Clock to USB host has been enabled
au1xxx-ehci au1xxx-ehci0: reset hcs_params 0x1212 dbg=3D0 cc=3D1 pcc=3D2
ordered ports=3D2
au1xxx-ehci au1xxx-ehci0: reset hcc_params 0012 thresh 1 uframes
256/512/1024
ehci_hcd (Au1xxx) at 0xb4020200, irq 29
au1xxx-ehci au1xxx-ehci0: new USB bus registered, assigned bus number 1
au1xxx-ehci au1xxx-ehci0: reset command 080002 (park)=3D0 ithresh=3D8
period=3D1024 Reset HALT
au1xxx-ehci au1xxx-ehci0: init command 010009 (park)=3D0 ithresh=3D1
period=3D256 RUN
au1xxx-ehci au1xxx-ehci0: USB 0.0 initialized, EHCI 1.00, driver 10 Dec
2004
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: default language 0x0409
usb usb1: Product: Au1xxx EHCI
usb usb1: Manufacturer: Linux 2.6.11 ehci_hcd
usb usb1: SerialNumber: au1xxx
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: individual port power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (Au1xxx)
block sizes: ed 64 td 64
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 001403 POWER sig=3Dk
CSC CONNECT
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
In ohci_hcd_au1xxx_drv_probe
drivers/usb/host/ohci-au1xxx.c: starting Au1xxx OHCI USB Controller
drivers/usb/host/ohci-au1xxx.c: Clock to USB host has been enabled
ohci_hcd (Au1xxx) at 0xb4020100, irq 29
au1xxx-ohci au1xxx-ohci0: new USB bus registered, assigned bus number 2
au1xxx-ohci au1xxx-ohci0: ohci_au1xxx_start, ohci:86e9fcf0
au1xxx-ohci au1xxx-ohci0: resetting from state 'reset', control =3D 0x0
au1xxx-ohci au1xxx-ohci0: OHCI controller state
au1xxx-ohci au1xxx-ohci0: OHCI 1.0, with legacy support registers
au1xxx-ohci au1xxx-ohci0: control 0x083 HCFS=3Doperational CBSR=3D3
au1xxx-ohci au1xxx-ohci0: cmdstatus 0x00000 SOC=3D0
au1xxx-ohci au1xxx-ohci0: intrstatus 0x00000044 RHSC SF
au1xxx-ohci au1xxx-ohci0: intrenable 0x8000001a MIE UE RD WDH
au1xxx-ohci au1xxx-ohci0: hcca frame #0021
au1xxx-ohci au1xxx-ohci0: roothub.a 10000202 POTPGT=3D16 NPS NDP=3D2
au1xxx-ohci au1xxx-ohci0: roothub.b 00000000 PPCM=3D0000 DR=3D0000
au1xxx-ohci au1xxx-ohci0: roothub.status 00008000 DRWE
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [0] 0x00000100 PPS
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [1] 0x00000100 PPS
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: default language 0x0409
usb usb2: Product: Au1xxx OHCI
usb usb2: Manufacturer: Linux 2.6.11 ohci_hcd
usb usb2: SerialNumber: au1xxx
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 32ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501
au1xxx-ehci au1xxx-ehci0: port 1 low speed --> companion
au1xxx-ohci au1xxx-ohci0: created debug files
Initializing USB Mass Storage driver...
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 003002 POWER OWNER
sig=3Dse0  CSC
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00010301
CSC LSDA PPS CCS
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00100303
PRSC LSDA PPS PES CCS
usb 2-1: new low speed USB device using au1xxx-ohci and address 2
ghzhang: USB inserted
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00100303
PRSC LSDA PPS PES CCS
usb 2-1: skipped 1 descriptor after interface
usb 2-1: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 2-1: default language 0x0409
usb 2-1: Product: HP Basic USB Keyboard
usb 2-1: Manufacturer: CHICONY
usb 2-1: hotplug
usb 2-1: adding 2-1:1.0 (config #1, interface 0)
usb 2-1:1.0: hotplug
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0002
usbhid 2-1:1.0: usb_probe_interface
usbhid 2-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Keyboard [CHICONY HP Basic USB Keyboard] on
usb-au1xxx-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2
(2004/08/27)
usbcore: registered new driver rtl8150
usbcore: registered new driver usblcd
drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT
Services http://www.usblcd.de
drivers/usb/misc/usblcd.c: USBLCD support registered.
usbcore: registered new driver usbled
usbcore: registered new driver usbtest

------------------------------------------------------------------------
-----------------------------
cat /proc/bus/input/devices

I: Bus=3D0003 Vendor=3D03f0 Product=3D0024 Version=3D0300
N: Name=3D"CHICONY HP Basic USB Keyboard"
P: Phys=3Dusb-au1xxx-1/input0
H: Handlers=3Devent0
B: EV=3D120013
B: KEY=3D10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: MSC=3D10
B: LED=3D7
------------------------------------------------------------------------
----

CAN ANYBODY HELP ME IN THIS REGARD,

Is there anything to do with "keybdev" and "/sbin/hotplug"?????

Both of these are not present on my system

Thanking you in advance,
M.Chandrashekar


------_=_NextPart_001_01C712C7.701BA5A8
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
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"MS Mincho";
	panose-1:2 2 6 9 4 2 5 8 3 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
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
	{color:blue;
	text-decoration:underline;}
span.EmailStyle18
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

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>We faced a similar problem on =
2.6.14
kernel (on AU1100 board) where the keyboard is detected, but the =
keystrokes
don&#8217;t appear on the serial console. Our thinking was that =
additional
support/application is required to interface with the HID driver, to =
re-direct
keystrokes onto console. &nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hemanth<o:p></o:p></span></font></p>=


<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><font =
size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>

<hr size=3D2 width=3D"100%" align=3Dcenter tabindex=3D-1>

</span></font></div>

<p class=3DMsoNormal><b><font size=3D2 face=3DTahoma><span =
style=3D'font-size:10.0pt;
font-family:Tahoma;font-weight:bold'>From:</span></font></b><font =
size=3D2
face=3DTahoma><span style=3D'font-size:10.0pt;font-family:Tahoma'> =
linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] <b><span =
style=3D'font-weight:bold'>On
Behalf Of </span></b>chandrashekar mogilicherla<br>
<b><span style=3D'font-weight:bold'>Sent:</span></b> Tuesday, November =
28, 2006
12:41 PM<br>
<b><span style=3D'font-weight:bold'>To:</span></b> =
linux-mips@linux-mips.org;
Puneet<br>
<b><span style=3D'font-weight:bold'>Subject:</span></b> USB keyboard not =
getting
handled???????</span></font><o:p></o:p></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><br>
Iam using a device with linux 2.6.11 kernel running on mips arch.<br>
I have got a problem trying to enable usb keyboard&nbsp; on my =
device.<br>
When i enable following options in kernel config<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB_CONFIG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ohci, =
ehci<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hid or boot =
hid<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; keyboard in input
devices<br>
<br>
USB keyboard is detected . It is shown in /proc/bus/usb/devices , =
drivers are
loaded. But keyboard is not working. <br>
<br>
Following is the mesg log i get when i enabled usb feaures in =
kernel,<br>
-------------------------------------------------------------------------=
-----------------------<br>
In ehci_hcd_au1xxx_drv_probe<br>
drivers/usb/host/ehci-au1xxx.c: starting Au1xxx EHCI USB Controller<br>
drivers/usb/host/ehci-au1xxx.c: Clock to USB host has been enabled<br>
au1xxx-ehci au1xxx-ehci0: reset hcs_params 0x1212 dbg=3D0 cc=3D1 pcc=3D2 =
ordered
ports=3D2<br>
au1xxx-ehci au1xxx-ehci0: reset hcc_params 0012 thresh 1 uframes =
256/512/1024<br>
ehci_hcd (Au1xxx) at 0xb4020200, irq 29<br>
au1xxx-ehci au1xxx-ehci0: new USB bus registered, assigned bus number =
1<br>
au1xxx-ehci au1xxx-ehci0: reset command 080002 (park)=3D0 ithresh=3D8 =
period=3D1024
Reset HALT<br>
au1xxx-ehci au1xxx-ehci0: init command 010009 (park)=3D0 ithresh=3D1 =
period=3D256 RUN<br>
au1xxx-ehci au1xxx-ehci0: USB 0.0 initialized, EHCI 1.00, driver 10 Dec =
2004<br>
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<br>
usb usb1: default language 0x0409<br>
usb usb1: Product: Au1xxx EHCI<br>
usb usb1: Manufacturer: Linux 2.6.11 ehci_hcd<br>
usb usb1: SerialNumber: au1xxx<br>
usb usb1: hotplug<br>
usb usb1: adding 1-0:1.0 (config #1, interface 0)<br>
usb 1-0:1.0: hotplug<br>
hub 1-0:1.0: usb_probe_interface<br>
hub 1-0:1.0: usb_probe_interface - got id<br>
hub 1-0:1.0: USB hub found<br>
hub 1-0:1.0: 2 ports detected<br>
hub 1-0:1.0: standalone hub<br>
hub 1-0:1.0: individual port power switching<br>
hub 1-0:1.0: individual port over-current protection<br>
hub 1-0:1.0: Single TT<br>
hub 1-0:1.0: TT requires at most 8 FS bit times<br>
hub 1-0:1.0: power on to power good time: 20ms<br>
hub 1-0:1.0: local power source is good<br>
hub 1-0:1.0: enabling power on all ports<br>
2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (Au1xxx)<br>
block sizes: ed 64 td 64<br>
hub 1-0:1.0: state 5 ports 2 chg 0006 evt 0007<br>
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 001403 POWER =
sig=3Dk&nbsp; CSC
CONNECT<br>
hub 1-0:1.0: port 1, status 0501, change 0001, 480 Mb/s<br>
In ohci_hcd_au1xxx_drv_probe<br>
drivers/usb/host/ohci-au1xxx.c: starting Au1xxx OHCI USB Controller<br>
drivers/usb/host/ohci-au1xxx.c: Clock to USB host has been enabled<br>
ohci_hcd (Au1xxx) at 0xb4020100, irq 29<br>
au1xxx-ohci au1xxx-ohci0: new USB bus registered, assigned bus number =
2<br>
au1xxx-ohci au1xxx-ohci0: ohci_au1xxx_start, ohci:86e9fcf0<br>
au1xxx-ohci au1xxx-ohci0: resetting from state 'reset', control =3D =
0x0<br>
au1xxx-ohci au1xxx-ohci0: OHCI controller state<br>
au1xxx-ohci au1xxx-ohci0: OHCI 1.0, with legacy support registers<br>
au1xxx-ohci au1xxx-ohci0: control 0x083 HCFS=3Doperational CBSR=3D3<br>
au1xxx-ohci au1xxx-ohci0: cmdstatus 0x00000 SOC=3D0<br>
au1xxx-ohci au1xxx-ohci0: intrstatus 0x00000044 RHSC SF<br>
au1xxx-ohci au1xxx-ohci0: intrenable 0x8000001a MIE UE RD WDH<br>
au1xxx-ohci au1xxx-ohci0: hcca frame #0021<br>
au1xxx-ohci au1xxx-ohci0: roothub.a 10000202 POTPGT=3D16 NPS NDP=3D2<br>
au1xxx-ohci au1xxx-ohci0: roothub.b 00000000 PPCM=3D0000 DR=3D0000<br>
au1xxx-ohci au1xxx-ohci0: roothub.status 00008000 DRWE<br>
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [0] 0x00000100 PPS<br>
au1xxx-ohci au1xxx-ohci0: roothub.portstatus [1] 0x00000100 PPS<br>
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1<br>
usb usb2: default language 0x0409<br>
usb usb2: Product: Au1xxx OHCI<br>
usb usb2: Manufacturer: Linux 2.6.11 ohci_hcd<br>
usb usb2: SerialNumber: au1xxx<br>
usb usb2: hotplug<br>
usb usb2: adding 2-0:1.0 (config #1, interface 0)<br>
usb 2-0:1.0: hotplug<br>
hub 2-0:1.0: usb_probe_interface<br>
hub 2-0:1.0: usb_probe_interface - got id<br>
hub 2-0:1.0: USB hub found<br>
hub 2-0:1.0: 2 ports detected<br>
hub 2-0:1.0: standalone hub<br>
hub 2-0:1.0: no power switching (usb 1.0)<br>
hub 2-0:1.0: global over-current protection<br>
hub 2-0:1.0: power on to power good time: 32ms<br>
hub 2-0:1.0: local power source is good<br>
hub 2-0:1.0: no over-current condition exists<br>
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x501<br>
au1xxx-ehci au1xxx-ehci0: port 1 low speed --&gt; companion<br>
au1xxx-ohci au1xxx-ohci0: created debug files<br>
Initializing USB Mass Storage driver...<br>
au1xxx-ehci au1xxx-ehci0: GetStatus port 1 status 003002 POWER OWNER
sig=3Dse0&nbsp; CSC<br>
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s<br>
hub 2-0:1.0: state 5 ports 2 chg 0006 evt 0007<br>
usbcore: registered new driver usb-storage<br>
USB Mass Storage support registered.<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00010301 CSC
LSDA PPS CCS<br>
hub 2-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s<br>
hub 2-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00100303 PRSC
LSDA PPS PES CCS<br>
usb 2-1: new low speed USB device using au1xxx-ohci and address 2<br>
ghzhang: USB inserted<br>
au1xxx-ohci au1xxx-ohci0: GetStatus roothub.portstatus [0] =3D =
0x00100303 PRSC
LSDA PPS PES CCS<br>
usb 2-1: skipped 1 descriptor after interface<br>
usb 2-1: new device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0<br>
usb 2-1: default language 0x0409<br>
usb 2-1: Product: HP Basic USB Keyboard<br>
usb 2-1: Manufacturer: CHICONY<br>
usb 2-1: hotplug<br>
usb 2-1: adding 2-1:1.0 (config #1, interface 0)<br>
usb 2-1:1.0: hotplug<br>
hub 2-0:1.0: port 2, status 0100, change 0000, 12 Mb/s<br>
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0002<br>
usbhid 2-1:1.0: usb_probe_interface<br>
usbhid 2-1:1.0: usb_probe_interface - got id<br>
input: USB HID v1.10 Keyboard [CHICONY HP Basic USB Keyboard] on =
usb-au1xxx-1<br>
usbcore: registered new driver usbhid<br>
drivers/usb/input/hid-core.c: v2.0:USB HID core driver<br>
drivers/usb/net/rtl8150.c: rtl8150 based usb-ethernet driver v0.6.2
(2004/08/27)<br>
usbcore: registered new driver rtl8150<br>
usbcore: registered new driver usblcd<br>
drivers/usb/misc/usblcd.c: USBLCD Driver Version 1.04 (C) Adams IT =
Services <a
href=3D"http://www.usblcd.de" =
target=3D"_blank">http://www.usblcd.de</a><br>
drivers/usb/misc/usblcd.c: USBLCD support registered.<br>
usbcore: registered new driver usbled<br>
usbcore: registered new driver usbtest<br>
<br>
-------------------------------------------------------------------------=
----------------------------<br>
cat /proc/bus/input/devices<br>
<br>
I: Bus=3D0003 Vendor=3D03f0 Product=3D0024 Version=3D0300<br>
N: Name=3D&quot;CHICONY HP Basic USB Keyboard&quot;<br>
P: Phys=3Dusb-au1xxx-1/input0<br>
H: Handlers=3Devent0<br>
B: EV=3D120013<br>
B: KEY=3D10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff =
fffffffe<br>
B: MSC=3D10<br>
B: LED=3D7<br>
-------------------------------------------------------------------------=
---<br>
<br>
CAN ANYBODY HELP ME IN THIS REGARD,<br>
<br>
Is there anything to do with &quot;keybdev&quot; and =
&quot;/sbin/hotplug&quot;?????<br>
<br>
Both of these are not present on my system<br>
<br>
Thanking you in advance,<br>
M.Chandrashekar<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C712C7.701BA5A8--
