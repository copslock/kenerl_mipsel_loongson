Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 19:15:40 +0000 (GMT)
Received: from lug-owl.de ([IPv6:::ffff:195.71.106.12]:63456 "EHLO lug-owl.de")
	by linux-mips.org with ESMTP id <S8225200AbUJaTPf>;
	Sun, 31 Oct 2004 19:15:35 +0000
Received: by lug-owl.de (Postfix, from userid 1001)
	id E0A8E4ABE2; Sun, 31 Oct 2004 20:15:31 +0100 (CET)
Date: Sun, 31 Oct 2004 20:15:31 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Dennis Grevenstein <dennis@pcde.inka.de>
Cc: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031191531.GF2094@lug-owl.de>
Mail-Followup-To: Dennis Grevenstein <dennis@pcde.inka.de>,
	linux-mips@linux-mips.org
References: <20041031184233.GA11120@aton.pcde.inka.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <20041031184233.GA11120@aton.pcde.inka.de>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <jbglaw@lug-owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-31 19:42:33 +0100, Dennis Grevenstein <dennis@pcde.inka.de>
wrote in message <20041031184233.GA11120@aton.pcde.inka.de>:
> I want to get the current cvs kernel running on
> an R5000PC Challenge S. It does compile, but the
> kernel does not boot. I get this error repeatedly
> printed all over the console until I pull the plug:
>=20
> <1>CPU 0 Unable to handle kernel paging request at\
>  virtual address 00000000, epc =3D=3D 8810da1c, ra =3D=3D 8810e22c

Look into your System.map what's at 0x8810da1c and 0x8810e22c

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

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBhTnTHb1edYOZ4bsRAjtiAJ9RgXHeSqVB2ZS71n2yiT7hyKMMCACfWMcu
09f61PuQYyPhJrA5rhvA5/0=
=VvHk
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
