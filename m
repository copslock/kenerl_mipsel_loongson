Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Jan 2005 16:04:15 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:3493 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225196AbVAVQEK>;
	Sat, 22 Jan 2005 16:04:10 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 347E3190275; Sat, 22 Jan 2005 17:04:07 +0100 (CET)
Date:	Sat, 22 Jan 2005 17:04:07 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	James Simmons <jsimmons@www.infradead.org>
Cc:	linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TurboChannel Bsus sysfs port.
Message-ID: <20050122160407.GT28037@lug-owl.de>
Mail-Followup-To: James Simmons <jsimmons@www.infradead.org>,
	linux-mips@linux-mips.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WiG3HOh2BFypK78Q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--WiG3HOh2BFypK78Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-01-22 00:25:28 +0000, James Simmons <jsimmons@www.infradead.or=
g>
wrote in message <Pine.LNX.4.56.0501220021540.1021@pentafluge.infradead.org=
>:
>=20
> Experimenting with sysfs to figure out how it works. So I'm attempting to=
=20
> port the TurboChannel bus code to sysfs. Its a test of concept and a=20
> learning experience. Comments welcomed.
[...]

I haven't tested the code, but basically, it's a good step into the
right direction. The DECstations aren't yet really in the 2.6.x world,
but that doesn't degrade your good work :-)  Also, it now seems easier
to me to integrate a different TC bus driver: this will be needed for
Linux' port to VAX computers, which may have TC busses, too.

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

--WiG3HOh2BFypK78Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8nl3Hb1edYOZ4bsRAsG8AJwN+hUOCQiMVocwDK956cs0B3A/ggCfR56M
os1QkWFTDVejtmoWksCtmVw=
=dd7E
-----END PGP SIGNATURE-----

--WiG3HOh2BFypK78Q--
