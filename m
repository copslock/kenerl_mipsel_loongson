Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARBxaA14712
	for linux-mips-outgoing; Tue, 27 Nov 2001 03:59:36 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARBxVo14709
	for <linux-mips@oss.sgi.com>; Tue, 27 Nov 2001 03:59:31 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 777977FB; Tue, 27 Nov 2001 11:59:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A3AB43F47; Tue, 27 Nov 2001 11:59:03 +0100 (CET)
Date: Tue, 27 Nov 2001 11:59:03 +0100
From: Florian Lohoff <flo@rfc822.org>
To: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>
Cc: linux-mips@oss.sgi.com, karel@sparta.research.kpn.com, algernon@debian.org
Subject: Re: Decstation /150 kernel (cvs) problems
Message-ID: <20011127115903.E27987@paradigm.rfc822.org>
References: <20011127025622.D28037@paradigm.rfc822.org> <200111270753.IAA24915@sparta.research.kpn.com> <20011127114849.D27987@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20011127114849.D27987@paradigm.rfc822.org>
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2001 at 11:48:49AM +0100, Florian Lohoff wrote:
> *Urgs* I'am just having a look at it... It looks the elf segments have
> changed moved and its either overwriting itself or the prom.
>=20

Ok - this fixes the problem by not only ignoring "length 0" sections but
also sections with address 0=20

--- delo-0.7/loader/copyelf.c	Sat Oct 14 19:29:00 2000
+++ delo-0.7-flo/loader/copyelf.c	Tue Nov 27 11:51:29 2001
@@ -42,7 +42,7 @@
 			shdr->sh_offset, shdr->sh_size);
 #endif
=20
-		if (shdr->sh_size <=3D 0)=20
+		if (shdr->sh_size <=3D 0 || shdr->sh_addr =3D=3D 0)=20
 			continue;
=20
 		if (shdr->sh_type =3D=3D SHT_PROGBITS) {

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8A3H3Uaz2rXW+gJcRAqkBAJ4hca+lEKqiQM8djRYlLuCVGo+EFwCfSu2N
A5tGF9HmfwjnzdxpEW0P6gc=
=+RW9
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
