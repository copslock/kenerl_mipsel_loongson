Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 23:23:33 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:28347
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224932AbULUXX1>; Tue, 21 Dec 2004 23:23:27 +0000
Received: from gren.infostations.net (gren.infostations.net [71.4.40.32])
	by mail-relay.infostations.net (Postfix) with ESMTP id 09E9DF7B59;
	Tue, 21 Dec 2004 23:22:44 +0000 (Local time zone must be set--see zic manual page)
Received: from host-69-19-171-140.rev.o1.com ([69.19.171.140])
	by gren.infostations.net with esmtp (Exim 4.42 #1 (Gentoo))
	id 1CgtNH-0006tp-GD; Tue, 21 Dec 2004 15:25:05 -0800
Subject: Re: Problems with PCMCIA on AMD dbau1100
From: Josh Green <jgreen@users.sourceforge.net>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <41C8536E.5060507@embeddedalley.com>
References: <1103628665.22113.16.camel@SillyPuddy.localdomain>
	 <41C8536E.5060507@embeddedalley.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oJqPpFKp113nVerD2HD+"
Date: Tue, 21 Dec 2004 15:22:50 -0800
Message-Id: <1103671370.30276.8.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-oJqPpFKp113nVerD2HD+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Some additional info..

On Tue, 2004-12-21 at 08:46 -0800, Pete Popov wrote:
> If all the config files are setup properly, you should start pcmcia=20
> with /etc/rc.d/init.d/pcmcia start. That will also run the cardmgr.=20
> Without the cardmgr, nothing will happen. If you're loading the=20
> modules manuall, modprobe au1x00_ss, then ds.o, the execute cardmgr=20
> and at that point the card should be detected.
>=20

Looks like pcmcia.ko is probably what should be used instead of ds.o,
although I'm not sure why this policy is different than from before.
Here is the output after loading these 3 modules and running the pcmcia
init script:

# insmod pcmcia_core.ko
# insmod au1x00_ss.ko
# insmod pcmcia.ko

# /etc/init.d/pcmcia start
Starting PCMCIA services: cardmgr[836]: watching 2 sockets
done.

# lsmod
Module                  Size  Used by    Not tainted
pcmcia 24208 4 - Live 0xc0025000
au1x00_ss 12192 0 - Live 0xc0005000
pcmcia_core 60912 2 pcmcia,au1x00_ss, Live 0xc0015000

# cardctl status
Socket 0:
  no card
Socket 1:
  no card


There is a card in the second slot (Netgear 32 bit CardBus WG511
wireless card which uses prism54 driver).  I don't have the driver
compiled for it but I was expecting it to at least be identified.

>=20
> > One thing to note is that I get a few warnings during the PCMCIA build:
> >=20
> >   CC [M]  drivers/pcmcia/au1000_generic.o
> > drivers/pcmcia/au1000_generic.c: In function
> > `au1x00_pcmcia_socket_probe':
> > drivers/pcmcia/au1000_generic.c:425: warning: integer constant is too
> > large for "long" type
> > drivers/pcmcia/au1000_generic.c:433: warning: integer constant is too
> > large for "long" type
> >=20
> > The first warning is related to the following code (second is similar
> > but for socket 1):
> >=20
> > 	skt->virt_io =3D (void *)
> > 		((u32)ioremap((ioaddr_t)AU1X_SOCK0_IO, 0x1000) -
> > 		(u32)mips_io_port_base);
> >=20
> >=20
> > AU1X_SOCK0_IO is defined as 0xF00000000 which is a 36 bit number, not
> > sure if that will cause a problem or not (since ioremap is using phys_t
> > which is 32 bit).=20
>=20
> phys_t is 64 bit if 64BIT is enabled. Make sure you have the 36bit=20
> I/O support enabled. CONFIG_64BIT_PHYS_ADDR has to be defined.
>=20

I discovered that those warnings are generated due to the constants
themselves being truncated (they should be followed by LL, like
0xF00000000LL).  Still no luck though with detecting my card.  Cheers.
	Josh Green


--=-oJqPpFKp113nVerD2HD+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBByLBJRoMuWKCcbgQRAqp0AKCUm+ellnrWakBAVTYsMQwNXarTgQCdHRd9
0pBsa5kDfcfyNnLEf9TAMU4=
=DIZW
-----END PGP SIGNATURE-----

--=-oJqPpFKp113nVerD2HD+--
