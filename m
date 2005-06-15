Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Jun 2005 14:58:02 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:41230 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225950AbVFON5q>;
	Wed, 15 Jun 2005 14:57:46 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Wed, 15 Jun 2005 15:57:33 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	Thomas Sattler <tsattler@gmx.de>
Subject: Re: no power on USB on linux 2.6?
Date:	Wed, 15 Jun 2005 15:57:12 +0200
User-Agent: KMail/1.7.2
References: <20050615134607.GA19510@nancy.sattler.local>
In-Reply-To: <20050615134607.GA19510@nancy.sattler.local>
Organization: 4G Systems
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2399852.cK5e4SeS4U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200506151557.17731.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart2399852.cK5e4SeS4U
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi thomas!

i think the problem is that in arch/mips/au1000/mtx-1/board_setup.c the pow=
er=20
switch for USB is turned on if CONFIG_USB_OHCI is defined. this seems to ha=
ve=20
changed to CONFIG_USB_OHCI_HCD.

bruno


On Wednesday 15 June 2005 15:46, you wrote:
> Hi there ...
>
> My name is Thomas I'm trying to use an USB-headset on a meshcube, a MIPS
> based embedded device (http://meshcube.org/meshwiki/). If I plug in the
> headset while running 2.4.27 a led on the headset turns on. If I do the
> same with 2.6.12-rc6 (latest MIPS CVS) nothing happens. I also tried an
> optical USB-mouse with the same result. All these tests are done with
> Debian GNU/Linux Sarge 3.1 on NFS-root.
>
> My kernelconfig is:
>   $ sed '/^#/d;/USB/!d' .config
>   CONFIG_SND_USB_AUDIO=3Dm
>   CONFIG_USB=3Dy
>   CONFIG_USB_DEBUG=3Dy
>   CONFIG_USB_DEVICEFS=3Dy
>   CONFIG_USB_ARCH_HAS_HCD=3Dy
>   CONFIG_USB_ARCH_HAS_OHCI=3Dy
>   CONFIG_USB_EHCI_HCD=3Dm
>   CONFIG_USB_OHCI_HCD=3Dy
>   CONFIG_USB_HID=3Dy
>   CONFIG_USB_HIDINPUT=3Dy
>
> kernel boot messages are:
>   usbcore: registered new driver usbfs
>   usbcore: registered new driver hub
>     [...]
>   au1xxx-ohci au1xxx-ohci.0: Au1xxx OHCI
>   au1xxx-ohci au1xxx-ohci.0: new USB bus registered, assigned bus number 1
>   au1xxx-ohci au1xxx-ohci.0: irq 26, io mem 0x10100000
>   usb usb1: Product: Au1xxx OHCI
>   usb usb1: Manufacturer: Linux 2.6.12-rc6 ohci_hcd
>   usb usb1: SerialNumber: Au1xxx
>   hub 1-0:1.0: USB hub found
>   hub 1-0:1.0: 2 ports detected
>   USB Universal Host Controller Interface driver v2.2
>   sl811: driver sl811-hcd, 19 May 2005
>
> FYI 2.4.27 messages:
>   usb.c: registered new driver usbdevfs
>   usb.c: registered new driver hub
>   host/usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
>   host/usb-ohci.c: usb-builtin, non-PCI OHCI
>   usb.c: new USB bus registered, assigned bus number 1
>   hub.c: USB hub found
>   hub.c: 2 ports detected
>
> hotplug (initscripts) report:
>   Starting hotplug subsystem:
>      pci
>      pci      [success]
>      usb
>      usb      [success]
>      isapnp
>      isapnp   [success]
>      ide
>      ide      [success]
>      input
>      input    [success]
>      scsi
>      scsi     [success]
>   done.
>
> the proc-filesystem tells:
>   $ cat /proc/bus/usb/devices
>   T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12 =
 MxCh=3D 2
>   B:  Alloc=3D  0/900 us ( 0%), #Int=3D  0, #Iso=3D  0
>   D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
>   P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 2.06
>   S:  Manufacturer=3DLinux 2.6.11 ohci_hcd
>   S:  Product=3DAu1xxx OHCI
>   S:  SerialNumber=3Dau1xxx
>   C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D  0mA
>   I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driv=
er=3Dhub
>   E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
>
> As far as I can see USB drivers are working correctly, hardware is
> detected but the USB is not working. Any hints?
>
> TIA
> Thomas

--nextPart2399852.cK5e4SeS4U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCsDO9fg2jtUL97G4RAqoiAKCNy0KQ/7hjMy35y2uFoqESJTCs1ACgkbvL
tohY3jOb9jPGgc/KaMghHqo=
=hk95
-----END PGP SIGNATURE-----

--nextPart2399852.cK5e4SeS4U--
