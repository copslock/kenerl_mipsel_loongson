Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2008 08:33:47 +0000 (GMT)
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:13324 "EHLO
	smtp-vbr16.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S28575484AbYBUIdp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 Feb 2008 08:33:45 +0000
Received: from dealogic.nl (a62-251-87-113.adsl.xs4all.nl [62.251.87.113])
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1L8Xdgi042054
	for <linux-mips@linux-mips.org>; Thu, 21 Feb 2008 09:33:45 +0100 (CET)
	(envelope-from ncoesel@DEALogic.nl)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Gettting USB host to work on AU1100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Thu, 21 Feb 2008 09:33:39 +0100
Message-ID: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF5A6@dealogicserver.DEALogic.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Gettting USB host to work on AU1100
thread-index: Achz9cdT/N6ckVbpQyy9qyJKKRm6FwAahOgg
From:	"Nico Coesel" <ncoesel@DEALogic.nl>
To:	<linux-mips@linux-mips.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <ncoesel@DEALogic.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ncoesel@DEALogic.nl
Precedence: bulk
X-list: linux-mips

Hello all,
I have some troubles getting the USB host to work on an AU1100 soc. The
board is much like the PB1100 / Syrah board. Perhaps there is someone on
this list that can shine a light on it. 

I have been using kernel 2.6.21-rc4 and I recently upgraded to kernel
2.6.24. Both kernels have exactly the same problems with USB. My system
is running in big endian mode. In the kernel configuration the following
'USB host controller drivers' options are set: 
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_LITTLE_ENDIAN=y

Furthermore I switched on support for USB HID and USB storage.

When I attach a keyboard to the USB port I see some messages appearing
saying a low speed device is detected when I run dmesg (see below for
dmesg output) but the keyboard doesn't work. The cpu is also getting
floaded by interrupts from the OHCI controller. I've added some
debugging messages to the HCD IRQ handler and it appears the SF
interrupt (Start frame) is not satisfied. I think this is an issue which
has to do with big endian which. 

I'm quite sure I have the clock routing right (stuff like UART, LCD
controller, etc are working correctly). Swapping the signal wires on the
USB interface doesn't help either.

This is the output from dmesg (with USB debugging enabled):
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
In ohci_hcd_au1xxx_drv_probe<7>drivers/usb/host/ohci-au1xxx.c: starting
Au1xxx O
HCI USB Controller
drivers/usb/host/ohci-au1xxx.c: Clock to USB host has been enabled
au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
au1xxx-ohci au1xxx-ohci.0: new USB bus registered, assigned bus number 1
au1xxx-ohci au1xxx-ohci.0: irq 34, io mem 0x10100000
au1xxx-ohci au1xxx-ohci.0: ohci_au1xxx_start,
ohci:83e03cc0<7>au1xxx-ohci au1xxx
-ohci.0: created debug files
au1xxx-ohci au1xxx-ohci.0: OHCI controller state
au1xxx-ohci au1xxx-ohci.0: OHCI 1.0, NO legacy support registers
au1xxx-ohci au1xxx-ohci.0: control 0x083 HCFS=operational CBSR=3
au1xxx-ohci au1xxx-ohci.0: cmdstatus 0x00000 SOC=0
au1xxx-ohci au1xxx-ohci.0: intrstatus 0x00000004 SF
au1xxx-ohci au1xxx-ohci.0: intrenable 0x8000005a MIE RHSC UE RD WDH
au1xxx-ohci au1xxx-ohci.0: hcca frame #0000
au1xxx-ohci au1xxx-ohci.0: roothub.a 02001202 POTPGT=2 NOCP NPS NDP=2(2)
au1xxx-ohci au1xxx-ohci.0: roothub.b 00000000 PPCM=0000 DR=0000
au1xxx-ohci au1xxx-ohci.0: roothub.status 00008000 DRWE
au1xxx-ohci au1xxx-ohci.0: roothub.portstatus [0] 0x00000100 PPS
au1xxx-ohci au1xxx-ohci.0: roothub.portstatus [1] 0x00000100 PPS
usb usb1: default language 0x0409
usb usb1: uevent
usb usb1: usb_probe_device
usb usb1: configuration #1 chosen from 1 choice
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: uevent
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: no over-current protection
hub 1-0:1.0: power on to power good time: 4ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: trying to enable port power on non-switchable hub
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Au1xxx OHCI
usb usb1: Manufacturer: Linux 2.6.24 ohci_hcd
usb usb1: SerialNumber: au1xxx
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver libusual
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20
19:16:42 200
7 UTC).
ALSA AC97: Driver Initialized
ALSA device list:
  #0: AMD Au1000--AC97 ALSA Driver
TCP cubic registered
NET: Registered protocol family 1
VFS: Mounted root (jffs2 filesystem).
Freeing unused kernel memory: 116k freed
Algorithmics/MIPS FPU Emulator v1.5
eth0: link up (100/Full)
wm97xx: version 0.64 liam.girdwood@wolfsonmicro.com
wm97xx: detected a wm9712 codec
input: wm97xx touchscreen as /devices/virtual/input/input0
hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0004
au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus [1] = 0x00010301
CSC LSD
A PPS CCS
hub 1-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus [1] = 0x00100303
PRSC LS
DA PPS PES CCS
usb 1-2: new low speed USB device using au1xxx-ohci and address 2

Nico Coesel
