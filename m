Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jun 2003 18:43:17 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:4073 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225299AbTFZRnN> convert rfc822-to-8bit; Thu, 26 Jun 2003 18:43:13 +0100
Received: from [212.227.126.205] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 19Vam7-00056I-00
	for linux-mips@linux-mips.org; Thu, 26 Jun 2003 19:43:11 +0200
Received: from [62.109.119.233] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 19Vam6-00078r-00
	for linux-mips@linux-mips.org; Thu, 26 Jun 2003 19:43:11 +0200
From: Bruno Randolf <bruno.randolf@4g-systems.de>
Organization: 4G Mobile Systeme
Subject: au1500 usb device
Date: Thu, 26 Jun 2003 19:43:10 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
To: linux-mips@linux-mips.org
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200306261943.10057.bruno.randolf@4g-systems.de>
Return-Path: <bruno.randolf@4g-systems.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.de
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hello!

i have an au1500 based board named "mtx-1" and i want to test the usb device 
functionality. i have enabled "Au1x00 USB TTY Device support", set 
SYS_PINFUNC to USB device in my setup.c, enabled VDEBUG in 
au1000/common/usbdevice.c and followed the instructions from steve's previous 
mail.

when i attach the USB cable, i get the following output

usbdev.c: receive_packet_complete: ep0, NAK pkt=811dd520, size=8
usbdev.c: SU bit is set in setup stage
usbdev.c: received NAK SETUP
usbdev.c: do_setup: req 0 GET_STATUS
usbdev.c: endpoint_stall
usbdev.c: receive_packet_complete: ep0, NAK pkt=811b44e0, size=0
usbdev.c: SU bit is set in setup stage
usbdev.c: process_ep0_receive: wrong size SETUP received
usbdev.c: receive_packet_complete: ep0, NAK pkt=811dd520, size=0
usbdev.c: SU bit is set in setup stage
usbdev.c: process_ep0_receive: wrong size SETUP received
usbdev.c: receive_packet_complete: ep0, NAK pkt=811b44e0, size=0
usbdev.c: SU bit is set in setup stage
usbdev.c: process_ep0_receive: wrong size SETUP received
usbdev.c: receive_packet_complete: ep0, NAK pkt=811dd520, size=0
usbdev.c: SU bit is set in setup stage
usbdev.c: process_ep0_receive: wrong size SETUP received

it seems like the device does not react to the GET_STATUS request from the 
host (the code to do so is missing) and then stalls. has anyone got this to 
work with another board? anything that i might be doing wrong?

thanks,
bruno



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++zCufg2jtUL97G4RAkK0AKCfHwdRiCCZsRadsaz9vJlKhljZ3wCfd7ZG
Jd7l3n5+vc59vdwHWy0sXKs=
=Fl4x
-----END PGP SIGNATURE-----
