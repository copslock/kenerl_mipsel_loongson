Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Dec 2005 09:21:17 +0000 (GMT)
Received: from lug-owl.de ([195.71.106.12]:14995 "EHLO lug-owl.de")
	by ftp.linux-mips.org with ESMTP id S3458548AbVLUJU7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Dec 2005 09:20:59 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 14EE8F0041; Wed, 21 Dec 2005 10:22:08 +0100 (CET)
Date:	Wed, 21 Dec 2005 10:22:08 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
Message-ID: <20051221092207.GU13985@lug-owl.de>
Mail-Followup-To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com> <1135155432.9009.18.camel@localhost.localdomain> <50c9a2250512210106h7bca5c7fu5714ea3aa16cde8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WXBLDYRe6ft2Yf8u"
Content-Disposition: inline
In-Reply-To: <50c9a2250512210106h7bca5c7fu5714ea3aa16cde8a@mail.gmail.com>
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
X-archive-position: 9706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--WXBLDYRe6ft2Yf8u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-12-21 17:06:36 +0800, zhuzhenhua <zzh.hust@gmail.com> wrote:
> i am not sure which toolchain can work for the 2.6 kernel
> can you suggest one?

That's a hard question... 2.95.x compilers used to work and were quite
fast, but newer GCC's features are incorporated into the kernel
sources so it probably will no longer work. Some 3.x based GCC should
probably work.

I am using GCC and binutils right from CVS/SVN in their HEAD
revisions, but not for MIPS. Works for me.

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

--WXBLDYRe6ft2Yf8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDqR6/Hb1edYOZ4bsRAmhVAJ0ZnQ20VRQYnkQWPZj8ci6SADKf+gCfX0dW
2iUVYcQPxubgpErmerMfSVg=
=jJl4
-----END PGP SIGNATURE-----

--WXBLDYRe6ft2Yf8u--
