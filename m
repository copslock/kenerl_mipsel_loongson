Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2004 07:56:52 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:14795 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224901AbUGUG4r>; Wed, 21 Jul 2004 07:56:47 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id F3C834B7EF; Wed, 21 Jul 2004 08:56:44 +0200 (CEST)
Date: Wed, 21 Jul 2004 08:56:44 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: simple assembler program
Message-ID: <20040721065644.GI4690@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <002701c46ee1$feeb7fc0$cc20bdd3@roman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Content-Disposition: inline
In-Reply-To: <002701c46ee1$feeb7fc0$cc20bdd3@roman>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-07-21 14:17:14 +0900, Roman Mashak <mrv@tusur.ru>
wrote in message <002701c46ee1$feeb7fc0$cc20bdd3@roman>:

> #define a 1
> #define b 2
>=20
> .ent main
> .global main
> main:
>         li $3, a
>         li $2, b
>         addu $4, $2, $3
> .end main
>=20
> I use SDE-lite kit version 5.03.06 and compile with sde-as:
> #sde-as test.S -o testtest.S: Assembler messages:
> test.S:9: Error: absolute expression required `li'
> test.S:10: Error: absolute expression required `li'
>=20
> When I eliminate #define and use just 'li $3, 1' and so on - everything is
> compiled correctly. Where is my problem?

Assembler sources aren't commonly fed through a preprocessor, so your
assembler just ignores the comments (your defines) and uses "a" and "b"
as-is.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/hOsHb1edYOZ4bsRAv1EAJ9bilGac8VUbjPwwhCayhxHzA+y0wCfZzp0
qDtQgdyvCskRs1K6SiniQEU=
=Babe
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--
