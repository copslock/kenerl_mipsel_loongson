Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Dec 2004 10:45:13 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:40129 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8224920AbULVKpI>;
	Wed, 22 Dec 2004 10:45:08 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 5F40B1901FB; Wed, 22 Dec 2004 11:44:57 +0100 (CET)
Date: Wed, 22 Dec 2004 11:44:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Problem registering interrupt
Message-ID: <20041222104457.GR2460@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <41C947CC.20709@innova-card.com> <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline
In-Reply-To: <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-12-22 11:19:06 +0100, moreau francis <francis_moreau2000@yahoo=
=2Efr>
wrote in message <20041222101906.27137.qmail@web25109.mail.ukl.yahoo.com>:
>=20
> > CPU 0 Unable to handle kernel paging request at
> > virtual address 00000004, epc =3D4
>=20
> Well it suggests me that your driver is trying to=20
> access a really nasty pointer: 0x00000004...
> How did you get this address ? From user space ?

Accesses to nearly NULL are normally structure accesses where a pointer
to a given struct was supplied as a NULL pointer.

So an access to 0x00000004 is most probably an access to the second
element of a struct, given/expected that all fields are usually 4-byte
aligned.

>From looking at ./kernel/irq/manage.c:setup_irq(), I guess that you
supply NULL as the "struct irqaction *", which is the 2nd argument of
setup_irq(). It's 2nd structure element is "flags" then... This is the
first thing accessed by the "new" pointer in setup_irq().

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFByVApHb1edYOZ4bsRAnPQAJkBqac21e+DHjv+ubDV2Lt2CDl65QCcDL0j
qZgPbkeXlXZw5n05nOSnbpU=
=rVaL
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--
