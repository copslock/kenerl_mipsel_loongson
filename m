Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0B1GkZ03767
	for linux-mips-outgoing; Thu, 10 Jan 2002 17:16:46 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0B1Gfg03764
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 17:16:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id ACC07842; Fri, 11 Jan 2002 01:16:28 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5328B3F3F; Fri, 11 Jan 2002 01:16:28 +0100 (CET)
Date: Fri, 11 Jan 2002 01:16:28 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: Re: LTP tests / Crash :)
Message-ID: <20020111001628.GD10021@paradigm.rfc822.org>
References: <20020110234903.GA10021@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20020110234903.GA10021@paradigm.rfc822.org>
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2002 at 12:49:03AM +0100, Florian Lohoff wrote:
> On 2 different machines - Running both 2.4.16 Debian/Sid and
> Debian/Woody - I will try to gather the oops - But it seems we should
> take the LTP for regular regression tests :)
>=20
> Crashes are:
>=20
> Kernel unaligned instruction access in unaligned.c:do_ade, line 397
>=20
> and
>=20
> Unhandled kernel unaligned access in unaligned.c:emulate_load_store_isns,=
 line 342

It seems those are fixed in the current 2.4 cvs with the unaligned.c
fixes which went in lately ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Pi7cUaz2rXW+gJcRAizeAKC0x9hwzuGYSBAA1CgUp1yHNUJ6IgCff0HH
DQwygpp8SsuN4VLjQfwwgxE=
=dImj
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
