Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2005 11:52:03 +0000 (GMT)
Received: from host51-186.pool80204.interbusiness.it ([IPv6:::ffff:80.204.186.51]:33711
	"EHLO gate.exadron.com") by linux-mips.org with ESMTP
	id <S8225323AbVAXLv5>; Mon, 24 Jan 2005 11:51:57 +0000
Received: from 10.0.10.57 ([10.0.10.57])
	by gate.exadron.com (8.12.7/8.12.7) with ESMTP id j0OCDPMM030685
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 24 Jan 2005 13:13:30 +0100
Subject: Re: CONFIG_PM depends on CONFIG_MACH_AU1X00?
From:	Christian <c.pellegrin@exadron.com>
To:	Dan Malek <dan@embeddededge.com>
Cc:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <DF642A6E-6BE2-11D9-B764-003065F9B7DC@embeddededge.com>
References: <ecb4efd10501210949db48ce1@mail.gmail.com>
	 <ecb4efd1050121112268e163ba@mail.gmail.com>
	 <DF642A6E-6BE2-11D9-B764-003065F9B7DC@embeddededge.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/aRb+FBva/LlBM51JDzu"
Date:	Mon, 24 Jan 2005 12:45:56 +0100
Message-Id: <1106567159.5282.102.camel@absolute.ascensit.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <c.pellegrin@exadron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.pellegrin@exadron.com
Precedence: bulk
X-list: linux-mips


--=-/aRb+FBva/LlBM51JDzu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-21 at 11:30 -0800, Dan Malek wrote:
> On Jan 21, 2005, at 11:22 AM, Clem Taylor wrote:
>=20
> > I guess I should recompile after making a change to a Kconfig file. It
> > turns out that the arch/mips/au1000/common/irq.c code doesn't compile
> > for the Au1550 with CONFIG_PM defined.
>=20
> Ooops.  I guess I haven't done this for 2.6.  I'll add it to my list of
> things to look into.
>=20

Hi, I sent a couple of days ago a patch to the list that fixes this (and
the fb driver) for 2.6. I'm going to do some more work on 2.6.x on
au1xxx, so drop me a line if there is some other problems around that I
could work on.

--=20
Christian <c.pellegrin@exadron.com>

--=-/aRb+FBva/LlBM51JDzu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD4DBQBB9N/zq26xP1xKlLcRAiWPAJY020QQuZebSexSL4pcr6QEpk4qAJ9a9bXU
Oti884yMnYdxtGf+NBjTAg==
=CbMb
-----END PGP SIGNATURE-----

--=-/aRb+FBva/LlBM51JDzu--
