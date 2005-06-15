Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2005 14:46:48 +0100 (BST)
Received: from imap.gmx.net ([IPv6:::ffff:213.165.64.20]:10957 "HELO
	mail.gmx.net") by linux-mips.org with SMTP id <S8225950AbVFONqb>;
	Wed, 15 Jun 2005 14:46:31 +0100
Received: (qmail invoked by alias); 15 Jun 2005 13:46:22 -0000
Received: from p54B09D19.dip0.t-ipconnect.de (EHLO nancy.sattler.local) [84.176.157.25]
  by mail.gmx.net (mp028) with SMTP; 15 Jun 2005 15:46:22 +0200
X-Authenticated: #1474915
Received: from localhost (localhost [127.0.0.1])
	by nancy.sattler.local (Postfix) with ESMTP
	id D7EA327518; Wed, 15 Jun 2005 15:46:22 +0200 (CEST)
Received: from nancy.sattler.local ([127.0.0.1])
	by localhost (nancy [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07475-01; Wed, 15 Jun 2005 15:46:10 +0200 (CEST)
Received: by nancy.sattler.local (Postfix, from userid 9682)
	id 19C6B2751B; Wed, 15 Jun 2005 15:46:07 +0200 (CEST)
Date:	Wed, 15 Jun 2005 15:46:07 +0200
From:	Thomas Sattler <tsattler@gmx.de>
To:	linux-mips@linux-mips.org
Subject: no power on USB on linux 2.6?
Message-ID: <20050615134607.GA19510@nancy.sattler.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at sattler.local
X-Y-GMX-Trusted: 0
Return-Path: <tsattler@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsattler@gmx.de
Precedence: bulk
X-list: linux-mips

Hi there ...

My name is Thomas I'm trying to use an USB-headset on a meshcube, a MIPS
based embedded device (http://meshcube.org/meshwiki/). If I plug in the
headset while running 2.4.27 a led on the headset turns on. If I do the
same with 2.6.12-rc6 (latest MIPS CVS) nothing happens. I also tried an
optical USB-mouse with the same result. All these tests are done with
Debian GNU/Linux Sarge 3.1 on NFS-root.

My kernelconfig is:
  $ sed '/^#/d;/USB/!d' .config
  CONFIG_SND_USB_AUDIO=m
  CONFIG_USB=y
  CONFIG_USB_DEBUG=y
  CONFIG_USB_DEVICEFS=y
  CONFIG_USB_ARCH_HAS_HCD=y
  CONFIG_USB_ARCH_HAS_OHCI=y
  CONFIG_USB_EHCI_HCD=m
  CONFIG_USB_OHCI_HCD=y
  CONFIG_USB_HID=y
  CONFIG_USB_HIDINPUT=y

kernel boot messages are:
  usbcore: registered new driver usbfs
  usbcore: registered new driver hub
    [...]
  au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
  au1xxx-ohci au1xxx-ohci.0: new USB bus registered, assigned bus number 1
  au1xxx-ohci au1xxx-ohci.0: irq 26, io mem 0x10100000
  usb usb1: Product: Au1xxx OHCI
  usb usb1: Manufacturer: Linux 2.6.12-rc6 ohci_hcd
  usb usb1: SerialNumber: Au1xxx
  hub 1-0:1.0: USB hub found
  hub 1-0:1.0: 2 ports detected
  USB Universal Host Controller Interface driver v2.2
  sl811: driver sl811-hcd, 19 May 2005

FYI 2.4.27 messages:
  usb.c: registered new driver usbdevfs
  usb.c: registered new driver hub
  host/usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
  host/usb-ohci.c: usb-builtin, non-PCI OHCI
  usb.c: new USB bus registered, assigned bus number 1
  hub.c: USB hub found
  hub.c: 2 ports detected

hotplug (initscripts) report:
  Starting hotplug subsystem:
     pci     
     pci      [success]
     usb     
     usb      [success]
     isapnp  
     isapnp   [success]
     ide     
     ide      [success]
     input   
     input    [success]
     scsi    
     scsi     [success]
  done.

the proc-filesystem tells:
  $ cat /proc/bus/usb/devices
  T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
  B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
  D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
  P:  Vendor=0000 ProdID=0000 Rev= 2.06
  S:  Manufacturer=Linux 2.6.11 ohci_hcd
  S:  Product=Au1xxx OHCI
  S:  SerialNumber=au1xxx
  C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
  I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
  E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

As far as I can see USB drivers are working correctly, hardware is
detected but the USB is not working. Any hints?

TIA
Thomas

-- 
Please keep mailinglists in english as they are meant to be
read in the whole world. -- Feel free to send PM in german.
