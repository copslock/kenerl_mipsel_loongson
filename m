Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 08:54:49 +0000 (GMT)
Received: from lug-owl.de ([195.71.106.12]:52368 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S8133862AbVLUIyb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Dec 2005 08:54:31 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id F1DE0F0046; Wed, 21 Dec 2005 09:55:39 +0100 (CET)
Date:	Wed, 21 Dec 2005 09:55:39 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	linux-mips@linux-mips.org
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Message-ID: <20051221085539.GS13985@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="geeFENrZXK6HHgAa"
Content-Disposition: inline
In-Reply-To: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--geeFENrZXK6HHgAa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-12-21 16:51:35 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> i want to compile a 2.6.14 kernel for mips 4kec, does someone compile
> the 2.6 kernel with self-build toolchain? how to select the gcc,
> gdb,glibc,linux head and binutils version?
> and where to get the guide doc?

After you've built your toolchain, it's either an additional native
one (gcc-4.1), or you've build some kind of cross-toolchain that got a
prefix (mips-linux-gcc).

In the former case, you'd be able to "make CC=3Dgcc-4.1" a kernel, in
the later case you call make like "make CROSS_COMPILE=3Dvax-linux-".

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--geeFENrZXK6HHgAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDqRiLHb1edYOZ4bsRArKbAKCH4JLwRjHur6/JQ8oufY7+N/4/QwCeJ5hI
wDSqqScrhupXQYHxdhzGtiA=
=yOYf
-----END PGP SIGNATURE-----

--geeFENrZXK6HHgAa--
