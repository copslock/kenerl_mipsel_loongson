Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KAVAN07935
	for linux-mips-outgoing; Wed, 20 Feb 2002 02:31:10 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KAV5907928
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 02:31:05 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id BB589884; Wed, 20 Feb 2002 10:30:40 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
	id DA7E51A23B; Wed, 20 Feb 2002 10:27:35 +0100 (CET)
Date: Wed, 20 Feb 2002 10:27:35 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Jun Sun <jsun@mvista.com>
Cc: Greg Lindahl <lindahl@conservativecomputer.com>, linux-mips@oss.sgi.com
Subject: Re: FPU emulator unsafe for SMP?
Message-ID: <20020220092735.GE11654@paradigm.rfc822.org>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
Content-Disposition: inline
In-Reply-To: <20020219202434.F25739@mvista.com>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2002 at 08:24:34PM -0800, Jun Sun wrote:
> On Tue, Feb 19, 2002 at 10:28:35PM -0500, Greg Lindahl wrote:
> > Alpha seems to always save the fpu state (the comments say that gcc
> > always generates code that uses it in every user process.)
>=20
> I think the comment might be an execuse. :-)  Never heard of gcc
> generating unnecessary floating point code.
>=20

Its not gcc its glibc's startup code i guess ...=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8c2wHUaz2rXW+gJcRAv0mAJ9NrdwpH2Njnrwlzg6tKsC9AJJwLgCfWuW6
GyuUi8w2+Xt/ld7S1fZuzjs=
=Cpki
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
