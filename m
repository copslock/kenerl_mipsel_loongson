Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5TISxnC006787
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 29 Jun 2002 11:28:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5TISxW3006786
	for linux-mips-outgoing; Sat, 29 Jun 2002 11:28:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5TISgnC006776;
	Sat, 29 Jun 2002 11:28:43 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D388612FF9; Sat, 29 Jun 2002 20:32:23 +0200 (CEST)
Date: Sat, 29 Jun 2002 20:32:23 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] Kill warning in indydog.c
Message-ID: <20020629183223.GV17216@lug-owl.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D2rVImvqWGvKULsk"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--D2rVImvqWGvKULsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please apply this patch. It fixes a warning that function declaration
isn't a valid prototype. This applies to linux_2_4 and to HEAD.

MfG, JBG



Index: drivers/char/indydog.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/char/indydog.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 indydog.c
--- drivers/char/indydog.c	2002/06/25 19:07:34	1.1.2.2
+++ drivers/char/indydog.c	2002/06/29 18:09:24
@@ -26,7 +26,7 @@
=20
 static int indydog_alive;
=20
-static void indydog_ping()
+static void indydog_ping(void)
 {
 	mcmisc_regs->watchdogt =3D 0;
 }


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--D2rVImvqWGvKULsk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Hf02Hb1edYOZ4bsRAplkAJ9jMAyLyzqDIWT2qRYX5ZXVlpyy9gCgivtC
NJxnLE6O/XJdmEif7uDWB7w=
=ibcx
-----END PGP SIGNATURE-----

--D2rVImvqWGvKULsk--
