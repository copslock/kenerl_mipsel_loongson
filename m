Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Feb 2005 09:57:41 +0000 (GMT)
Received: from host51-186.pool80204.interbusiness.it ([IPv6:::ffff:80.204.186.51]:52100
	"EHLO gate.exadron.com") by linux-mips.org with ESMTP
	id <S8225204AbVBDJ50>; Fri, 4 Feb 2005 09:57:26 +0000
Received: from 10.0.10.57 ([10.0.10.57])
	by gate.exadron.com (8.12.7/8.12.7) with ESMTP id j14AMEmm013726
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Fri, 4 Feb 2005 11:22:14 +0100
Subject: Re: [PATCH] au1100fb.c ported from 2.4 to 2.6
From:	Christian <c.pellegrin@exadron.com>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200502021005.18589.eckhardt@satorlaser.com>
References: <1105523407.5654.18.camel@absolute.ascensit.com>
	 <200502021005.18589.eckhardt@satorlaser.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bwYZ8fSlFY6LK1RLT1Ji"
Date:	Fri, 04 Feb 2005 10:56:43 +0100
Message-Id: <1107511003.5266.11.camel@absolute.ascensit.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <c.pellegrin@exadron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.pellegrin@exadron.com
Precedence: bulk
X-list: linux-mips


--=-bwYZ8fSlFY6LK1RLT1Ji
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 10:05 +0100, Ulrich Eckhardt wrote:

> I have a system that has a 4bpp monochrome display and the driver doesn't=
=20
> work. After initializing, it turns on the display[1] but I fail to get an=
y=20
> content onto it. I extended the array with the display characteristics=20
> according to an existing driver, but to no avail.
>=20
> I'm pretty lost there, since I have zero prior experience with framebuffe=
rs or=20
> video drivers, so I'd appreciate any hint that might get me towards debug=
ging=20
> this.

Hi,

you actually have to do the following modification modifications.=20

First you have to modify the function au1100fb_setcolreg, add the switch
case for 4bpp. Look in the Alchemy manual for the format of the palette
in the 4 bpp case. Then look for my comment "TODO: 8bbp", put a switch
and for pseudocolor like visual ... I think this is not even necessary.
More important is that you change the monitor type. If you want I can
send you privately a patch this weekend, but I just cannot assure it
works, you have to test it and eventually contribute.

--=20
Christian <c.pellegrin@exadron.com>

--=-bwYZ8fSlFY6LK1RLT1Ji
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCA0baq26xP1xKlLcRAhzgAJ9HYXQalxEHvp4GAAPX3N7pYw3iJQCeI+dA
42U2qo++vtiNk9Q5/VNI4f4=
=Z/An
-----END PGP SIGNATURE-----

--=-bwYZ8fSlFY6LK1RLT1Ji--
