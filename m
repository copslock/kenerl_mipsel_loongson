Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g263Zi303709
	for linux-mips-outgoing; Tue, 5 Mar 2002 19:35:44 -0800
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g263Za903703
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 19:35:37 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 20609845; Wed,  6 Mar 2002 03:35:35 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A2BA9370C3; Wed,  6 Mar 2002 00:25:21 +0100 (CET)
Date: Wed, 6 Mar 2002 00:25:21 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrea Venturi <a.venturi@cineca.it>
Cc: linux-mips@oss.sgi.com
Subject: Re: boot different kernels on the indy ?!
Message-ID: <20020305232521.GA31908@paradigm.rfc822.org>
References: <3C84D2BF.6030100@cineca.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <3C84D2BF.6030100@cineca.it>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2002 at 03:14:23PM +0100, Andrea Venturi wrote:
> i would like to compile and install a kernel from the cvs.sgi.com tree.
>=20
> i would like not to loose my previous one (the one i get from the woody=
=20
> install) as a failsafe option..
>=20
> i don't understand well i can have multiple kernel booting on the indy..
>=20
> i believe i should change, in PROM mode, some environment variables.. am=
=20
> i wrong?
>=20
> could someone point me to the right doc?

There is no doc yet - We have been working on a bootloader which makes
this easier=20

Currently you have to put the ecoff kernel image into the volume header.
If you have a large enough volume header just compile your kernel
and put the new one into the volume header under a different name.
The tool to use is "dvhtool"

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8hVPhUaz2rXW+gJcRAteIAJ9C/afXK1VW76y89M3BWNK5h5HqAwCfZl8G
wetSyzLR04Kbvq2HaaPOWTg=
=pKxF
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
