Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 19:39:32 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:41346
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224932AbULUTj0>; Tue, 21 Dec 2004 19:39:26 +0000
Received: from kei.infostations.net (kei.infostations.net [71.4.40.33])
	by mail-relay.infostations.net (Postfix) with ESMTP id 8B2FBF7D1E;
	Tue, 21 Dec 2004 19:38:42 +0000 (Local time zone must be set--see zic manual page)
Received: from host-69-19-171-25.rev.o1.com ([69.19.171.25])
	by kei.infostations.net with esmtp (Exim 4.42 #1 (Gentoo))
	id 1CgprA-00025A-0Q; Tue, 21 Dec 2004 11:39:41 -0800
Subject: Re: Problems with PCMCIA on AMD dbau1100
From: Josh Green <jgreen@users.sourceforge.net>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <41C8536E.5060507@embeddedalley.com>
References: <1103628665.22113.16.camel@SillyPuddy.localdomain>
	 <41C8536E.5060507@embeddedalley.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qPk91WBxOCDOPIJcnU7a"
Date: Tue, 21 Dec 2004 11:38:52 -0800
Message-Id: <1103657932.12558.7.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-qPk91WBxOCDOPIJcnU7a
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-12-21 at 08:46 -0800, Pete Popov wrote:
> If all the config files are setup properly, you should start pcmcia=20
> with /etc/rc.d/init.d/pcmcia start. That will also run the cardmgr.=20
> Without the cardmgr, nothing will happen. If you're loading the=20
> modules manuall, modprobe au1x00_ss, then ds.o, the execute cardmgr=20
> and at that point the card should be detected.
>=20

Ok, so there should be a ds.ko compiled then, which I'm not getting
(there is a ds.o in the build tree, but it doesn't get installed as a
module).  I'm still trying to figure out why this is.

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

I made sure that was enabled (it isn't very evident that it has to be, I
found that out from the code), but still got the same warnings.  I don't
suppose there is the possibility that 'unsigned long long' isn't 64 bit
on MIPS?  I changed the #ifdef CONFIG_64BIT_PHYS_ADDR to '#if 1' in
include/asm/types.h (for the typedef phys_t) just to make sure, and got
the same result (those warnings).

> > Perhaps this truncation is intentional though.
> >=20
> > Thanks in advance for any helpful pointers. Best regards,
> > 	Josh Green
>=20
> I tested pcmcia a couple of months ago when I updated the driver.=20
> I'll retest it in the next few days and send you additional=20
> instructions.
>=20
> Pete
>=20

Thank you very much for the info, it gives me a better idea of what I
should be seeing.  I'll keep probing to see if I can figure out whats
going on.  Best regards,
	Josh Green


--=-qPk91WBxOCDOPIJcnU7a
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBByHvMRoMuWKCcbgQRAmV5AJ43GvLiWHqDCHAX5ZrfTLKpt/0srgCePRPQ
ziNvPZiWKbXLDJCR+Hs/nUU=
=VTwo
-----END PGP SIGNATURE-----

--=-qPk91WBxOCDOPIJcnU7a--
