Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBG02wI28511
	for linux-mips-outgoing; Sat, 15 Dec 2001 16:02:58 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBG02ro28508
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 16:02:53 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 825E1842; Sun, 16 Dec 2001 00:02:42 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 615544242; Sun, 16 Dec 2001 00:02:08 +0100 (CET)
Date: Sun, 16 Dec 2001 00:02:08 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Ian Chilton <ian@ichilton.co.uk>
Cc: Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: I2 wont boot current kernel, Indy will.
Message-ID: <20011215230208.GB3056@paradigm.rfc822.org>
References: <20011215113050.GA13030@bogon.ms20.nix> <20011215225316.B1879@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20011215225316.B1879@woody.ichilton.co.uk>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2001 at 10:53:16PM +0000, Ian Chilton wrote:
> Hi Guido,
>=20
> I tried with a fresh current cvs tree and applied your
> newport_vs_i2.diff straight from the e-mail, but
> still get the same on the I2:
>=20
> >> bootp():/vmlinux                                =20
> Setting $netaddr to 192.168.0.13 (from server )
> Obtaining /vmlinux from server                =20
>   |                        =20
>=20
> [stops]

It definitly works - I have tried myself - I am using gcc 3 too - That
cant be the fault.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G9ZwUaz2rXW+gJcRAo36AJ4hTd1DEWWbSf235xSM8kDFT77ovwCfeVt6
Y3sTBefxNfvVdY+YyrJ636M=
=aVfY
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
