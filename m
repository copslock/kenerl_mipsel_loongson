Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Jan 2004 12:51:45 +0000 (GMT)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:5267 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225207AbUAQMvo>; Sat, 17 Jan 2004 12:51:44 +0000
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 0D3F04B4C4; Sat, 17 Jan 2004 13:51:43 +0100 (CET)
Date: Sat, 17 Jan 2004 13:51:42 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: VR4131 - MQ1132 - UPD63335
Message-ID: <20040117125142.GX14285@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <40079391.7080301@mistralsoftware.com> <20040117122022.GD5288@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uRsQmhdkrfa52i5R"
Content-Disposition: inline
In-Reply-To: <20040117122022.GD5288@linux-mips.org>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--uRsQmhdkrfa52i5R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-17 13:20:22 +0100, Ralf Baechle <ralf@linux-mips.org>
wrote in message <20040117122022.GD5288@linux-mips.org>:
> #define FOO_BASE	0x12340000UL		/* physical address */
                        ^^^^^^^^^^
> #define FOO_SIZE	0x00001000UL
>=20
> 	base =3D ioremap(0x1234, FOO_SIZE);
                       ^^^^^^
Not FOO_BASE?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--uRsQmhdkrfa52i5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFACS/eHb1edYOZ4bsRAtUNAJ9SuDW/acDt/nxtzGM0SzFJEx+GXwCdHHQ3
DSE4gTXcXqKvafd9FIBx+Xo=
=ZqUZ
-----END PGP SIGNATURE-----

--uRsQmhdkrfa52i5R--
