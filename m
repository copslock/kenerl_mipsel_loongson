Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Sep 2004 13:13:39 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:60103 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224926AbUIHMNf>; Wed, 8 Sep 2004 13:13:35 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 2496F4B35D; Wed,  8 Sep 2004 14:13:33 +0200 (CEST)
Date: Wed, 8 Sep 2004 14:13:33 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: SGI O2 Prom modification
Message-ID: <20040908121333.GA6985@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <413E84E2.4060401@optusnet.com.au> <413E9931.8060605@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hVUY+LYn0LT07sdA"
Content-Disposition: inline
In-Reply-To: <413E9931.8060605@gentoo.org>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--hVUY+LYn0LT07sdA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-08 01:31:29 -0400, Kumba <kumba@gentoo.org>
wrote in message <413E9931.8060605@gentoo.org>:
> Glenn Barry wrote:
> >My question is about the possibility of someone helping out with=20
> >modifying the O2's PROM to recognise the RM7900 CPU from PMC-Sierra.
>=20
> Modifying the binary is most assuredly way more difficult than gaining=20
> access to ip32PROM source and modifying it directly (and solving license=
=20
> issues). The level of change to the binary needed to make the ip32PROM=20

I'd not bet my a** on that. Modifying the binary firmware has got a=20
long, but rare, history. I remeber hacked PROM images for VAXen to
support larger SCSI disks. As long as you don't require a detailled CPU
detection, that should be possible. Hardcoding some values isn't all
thaaat hard. Making it correctly (preserving the formerly running
detection code for other CPUs) is a bit harder, of course :-)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--hVUY+LYn0LT07sdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBPvdsHb1edYOZ4bsRAiNFAJ0c0gaaXpLQNRDexg96xJGfCHzxLACbByRK
jaLTn+870/irCBtBg2c2aaU=
=lDqL
-----END PGP SIGNATURE-----

--hVUY+LYn0LT07sdA--
