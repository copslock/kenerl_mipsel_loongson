Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR12lI30990
	for linux-mips-outgoing; Mon, 26 Nov 2001 17:02:47 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR12fo30984
	for <linux-mips@oss.sgi.com>; Mon, 26 Nov 2001 17:02:41 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2E385853; Tue, 27 Nov 2001 01:02:36 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id B399C3F45; Tue, 27 Nov 2001 01:02:14 +0100 (CET)
Date: Tue, 27 Nov 2001 01:02:14 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Subject: [PATCH] const mips_io_port_base !?
Message-ID: <20011127010214.B21296@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



For the reason of compilability one should build a consensus ...



diff -u -r1.29 io.h
--- include/asm-mips/io.h	2001/11/26 11:14:37	1.29
+++ include/asm-mips/io.h	2001/11/27 01:00:07
@@ -60,7 +60,7 @@
  * instruction, so the lower 16 bits must be zero.  Should be true on
  * on any sane architecture; generic code does not use this assumption.
  */
-extern const unsigned long mips_io_port_base;
+extern unsigned long mips_io_port_base;
=20
 #define set_io_port_base(base)	\
 	do { * (unsigned long *) &mips_io_port_base =3D (base); } while (0)


Or the other way round ...

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8AtgGUaz2rXW+gJcRAhI1AKCNArDW/o66KzcT6+Br1tmzrvL3UQCgsjqf
6cZ7+gE8sH0DyIPEXnqyegA=
=/qVC
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
