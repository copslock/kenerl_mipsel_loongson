Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18Del131478
	for linux-mips-outgoing; Fri, 8 Feb 2002 05:40:47 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18DeZA31470;
	Fri, 8 Feb 2002 05:40:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 12B39853; Fri,  8 Feb 2002 14:40:13 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 3773D3FB4; Fri,  8 Feb 2002 14:39:38 +0100 (CET)
Date: Fri, 8 Feb 2002 14:39:38 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: [PATCH] endianess in /proc/cpuinfo
Message-ID: <20020208133938.GA29298@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


As Ralf also suffers the LTPDS* this is a resend of the needed patch.

Index: arch/mips/arc/identify.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/arc/identify.c,v
retrieving revision 1.5.2.1
diff -u -r1.5.2.1 identify.c
--- arch/mips/arc/identify.c	2001/12/12 13:45:57	1.5.2.1
+++ arch/mips/arc/identify.c	2001/12/13 18:00:04
@@ -26,7 +26,7 @@
=20
 static struct smatch mach_table[] =3D {
 	{	"SGI-IP22",
-		"SGI Indy",
+		"SGI ",
 		MACH_GROUP_SGI,
 		MACH_SGI_INDY,
 		PROM_FLAG_ARCS

Flo
* Linux Thorvalds Patch Drop Syndrom
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Y9UaUaz2rXW+gJcRAmMBAJ9mWVmrl8uyrff4loZs33FTRjrDjQCfWkbV
WxyKx27gVAhaMdMMpaGSAAI=
=8E/3
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
