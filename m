Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 07:35:21 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:61920 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8224934AbVAaHfF>;
	Mon, 31 Jan 2005 07:35:05 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id 591B719024B; Mon, 31 Jan 2005 08:35:03 +0100 (CET)
Date:	Mon, 31 Jan 2005 08:35:03 +0100
From:	Jan-Benedict Glaw <jbglaw@lug-owl.de>
To:	Rishabh@soc-soft.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Problem with HIGHMEM implementation for 32 bit mips-el port
Message-ID: <20050131073503.GB14398@lug-owl.de>
Mail-Followup-To: Rishabh@soc-soft.com, linux-mips@linux-mips.org
References: <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-31 12:49:53 +0530, Rishabh@soc-soft.com <Rishabh@soc-soft.c=
om>
wrote in message <4BF47D56A0DD2346A1B8D622C5C5902C472FE1@soc-mail.soc-soft.=
com>:
>=20
> Hi all,
> =0D

Please reconfigure your email client, it sends malformed emails.

> I am working on MIPS32 port of linux (kernel version 2.4.18) for R4000
> processor. While compilation was fine but the kernel boot up panics in
> "init".

2.4.18? You opened some old sepulchre, didn't you? Please forward-port
your patches at least to a recent 2.4.x kernel, if not 2.6.x.

> The information contained in this e-mail message and in any annexure is
> confidential to the  recipient and may contain privileged information. If=
 you are not

Am I the recipient? Does it contain privileged information?

> the intended recipient, please notify the sender and delete the message a=
long with
> any annexure. You should not disclose, copy or otherwise use the informat=
ion contained

I hereby inform you that I'm possibly not the intended recipient. Please
keep an eye on not sending me information that's not ment to be sent to
me...

> in the message or any annexure. Any views expressed in this e-mail are th=
ose of the
> individual sender except where the sender specifically states them to be =
the views of
> SoCrates Software India Pvt Ltd., Bangalore.

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

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB/d+nHb1edYOZ4bsRAvmvAJ9qkXQnpVyHHK/9Ca3tqI4ZT7kVGgCeOU7K
psNNz/AF12B7fXzfr8Xwg9A=
=eMAa
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
