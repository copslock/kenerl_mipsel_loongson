Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 11:31:42 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:15586
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224925AbULULbh>; Tue, 21 Dec 2004 11:31:37 +0000
Received: from suzaku.infostations.net (suzaku.infostations.net [71.4.40.34])
	by mail-relay.infostations.net (Postfix) with ESMTP id C6B64F81AC
	for <linux-mips@linux-mips.org>; Tue, 21 Dec 2004 11:30:51 +0000 (Local time zone must be set--see zic manual page)
Received: from host-69-19-168-8.rev.o1.com ([69.19.168.8])
	by suzaku.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1CgiEd-0000rr-C2
	for <linux-mips@linux-mips.org>; Tue, 21 Dec 2004 03:31:24 -0800
Subject: Problems with PCMCIA on AMD dbau1100
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NylfyEJFMqIMzwn8U/kg"
Date: Tue, 21 Dec 2004 03:31:05 -0800
Message-Id: <1103628665.22113.16.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-NylfyEJFMqIMzwn8U/kg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm having trouble getting PCMCIA to work properly on my dbau1100 MIPS
board with latest CVS (2.6.10rc3).  Any help would be very appreciated.
Here is lsmod output:

# lsmod
Module                  Size  Used by    Not tainted
au1x00_ss 12160 0 - Live 0xc0005000
pcmcia_core 60848 1 au1x00_ss, Live 0xc0015000


I get this output when modprobing au1x00_ss:

Linux Kernel Card Services
  options:  none


At this point 'pcmcia' is not listed in /proc/devices though, so I'm
assuming another module needs to be inserted?  On my x86 laptop I see
there is a ds module.  This appears to have been compiled into an object
for my MIPS build, but there is no stand alone ds module.  If I insert
the 'pcmcia' module I get pcmcia support (I'm assuming this is the 16
bit PCMCIA module, it doesn't appear dependent on au1x00_ss), but no
cards are detected:

# cardctl ident
Socket 0:
  no product info available
Socket 1:
  no product info available

# cardctl status
Socket 0:
  no card
Socket 1:
  no card


One thing to note is that I get a few warnings during the PCMCIA build:

  CC [M]  drivers/pcmcia/au1000_generic.o
drivers/pcmcia/au1000_generic.c: In function
`au1x00_pcmcia_socket_probe':
drivers/pcmcia/au1000_generic.c:425: warning: integer constant is too
large for "long" type
drivers/pcmcia/au1000_generic.c:433: warning: integer constant is too
large for "long" type

The first warning is related to the following code (second is similar
but for socket 1):

	skt->virt_io =3D (void *)
		((u32)ioremap((ioaddr_t)AU1X_SOCK0_IO, 0x1000) -
		(u32)mips_io_port_base);


AU1X_SOCK0_IO is defined as 0xF00000000 which is a 36 bit number, not
sure if that will cause a problem or not (since ioremap is using phys_t
which is 32 bit).  Perhaps this truncation is intentional though.

Thanks in advance for any helpful pointers. Best regards,
	Josh Green


--=-NylfyEJFMqIMzwn8U/kg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBByAl4RoMuWKCcbgQRAuW2AJ0afdt4P0ZDcVmEVRVbCzPqKikH6QCeK9/a
p+B18REMNUWWyNt2zg6StP0=
=hJoV
-----END PGP SIGNATURE-----

--=-NylfyEJFMqIMzwn8U/kg--
