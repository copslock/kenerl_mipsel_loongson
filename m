Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Mar 2003 13:20:50 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:20495 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225192AbTCaMUu>; Mon, 31 Mar 2003 13:20:50 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 1AD524AB75; Mon, 31 Mar 2003 14:20:48 +0200 (CEST)
Date: Mon, 31 Mar 2003 14:20:48 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: [Patch-2.5] Small compile fix
Message-ID: <20030331122047.GJ26678@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9faIjRurCDpBc7U"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--+9faIjRurCDpBc7U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've tried to compile 2.5.x with nearly the default config. This patch
is needed (the file does exist neither exist one nor two times...).

MfG, JBG


diff -u -r1.2 i8042-ip22io.h
--- drivers/input/serio/i8042-ip22io.h	19 Mar 2003 04:23:47 -0000	1.2
+++ drivers/input/serio/i8042-ip22io.h	31 Mar 2003 12:08:20 -0000
@@ -3,8 +3,6 @@
=20
 #include <asm/sgi/ioc.h>
 #include <asm/sgi/ip22.h>
-#include <asm/sgi/sgint23.h>
-#include <asm/sgi/sgint23.h>
=20
 /*
  * This program is free software; you can redistribute it and/or modify it

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--+9faIjRurCDpBc7U
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+iDKfHb1edYOZ4bsRAoBqAJ94YghyyNJ0eptLec/NGSoSCZhNRwCdE6NW
O5Gb5B/J8g1w22dDw8dxJSw=
=zFpN
-----END PGP SIGNATURE-----

--+9faIjRurCDpBc7U--
