Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 01:07:11 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:40641 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133513AbWAWBGq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 01:06:46 +0000
Received: (qmail 9585 invoked from network); 23 Jan 2006 11:10:45 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 23 Jan 2006 11:10:45 +1000
Message-ID: <43D42D23.8010908@gentoo.org>
Date:	Mon, 23 Jan 2006 11:10:59 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	Peter Horton <pdh@colonel-panic.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: Cobalt IDE fix
References: <20060122235038.GA3501@colonel-panic.org> <1137976937.24808.2.camel@localhost.localdomain>
In-Reply-To: <1137976937.24808.2.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12B51E68A31C91BC857D0711"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12B51E68A31C91BC857D0711
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> On Sul, 2006-01-22 at 23:50 +0000, Peter Horton wrote:
> 
>>Fix long IDE detection delay by not scanning non-existent channels.
> 
> 
> That just changes the number of interfaces that can be registered. The
> right fix is to change the list of non-PCI addresses scanned for the
> system in question and not blindly copy x86 I suspect.

Actually... could a configure option in Kconfig be added to disable
probing particular IDE busses?

Or at least, it should probe once then stop when it finds nothing.  At
the moment, both my Qube2 and my x86 desktop hangs momentarily while
via82cxxx loads:

> Linux video capture interface: v1.00
> bttv: driver version 0.9.16 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for capture
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:04.1
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
>     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
> Probing IDE interface ide0...
> hda: IRQ probe failed (0xfff0f5fc)
> hda: IRQ probe failed (0xfff0f5fc)
> hda: no response (status = 0x0a), resetting drive
> hda: IRQ probe failed (0xfff0f5fc)
> hda: no response (status = 0x0a)
> hdb: IRQ probe failed (0xfff0f5fc)
> hdb: IRQ probe failed (0xfff0f5fc)
> hdb: no response (status = 0x0a), resetting drive
> hdb: IRQ probe failed (0xfff0f5fc)
> hdb: no response (status = 0x0a)
> Probing IDE interface ide1...
> hdc: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A

Yep... you guessed it... nothing is plugged into the primary interface
... my HDDs are SCSI.  It would be nice to be able to turn off probing
ide0, either at compile time, or better still, on the kernel commandline.

I think this would be a better fix... as the problem doesn't just exist
on Cobalt, it's any machine with only one IDE bus in use.
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enig12B51E68A31C91BC857D0711
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD1C0muarJ1mMmSrkRApL+AJ43qTxAjyMmJBTVdyYb0iW3lDApbACgjCXh
NgZYL5Y16mua2jc4+t+xbU0=
=XwyF
-----END PGP SIGNATURE-----

--------------enig12B51E68A31C91BC857D0711--
