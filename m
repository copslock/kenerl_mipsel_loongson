Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5TIUenC006856
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 29 Jun 2002 11:30:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5TIUeVo006855
	for linux-mips-outgoing; Sat, 29 Jun 2002 11:30:40 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5TIUTnC006840;
	Sat, 29 Jun 2002 11:30:30 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id C9F3112FF9; Sat, 29 Jun 2002 20:34:11 +0200 (CEST)
Date: Sat, 29 Jun 2002 20:34:11 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: [PATCH] We don't need the Indy watchdog twice
Message-ID: <20020629183411.GW17216@lug-owl.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UTjKcilERHWBCdCp"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--UTjKcilERHWBCdCp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please apply this patch. It removes a doubled entry from the list of
supported watchdog drivers. This applies to linux_2_4 __only__.

MfG, JBG



Index: drivers/char/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/char/Config.in,v
retrieving revision 1.72.2.6
diff -u -r1.72.2.6 Config.in
--- drivers/char/Config.in	2002/06/26 22:35:32	1.72.2.6
+++ drivers/char/Config.in	2002/06/29 18:09:01
@@ -244,7 +244,6 @@
       fi
    fi
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
-   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_I=
P22
 fi
 endmenu
=20



--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--UTjKcilERHWBCdCp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Hf2iHb1edYOZ4bsRAlJTAKCNOu3BolNQxxlnbi8KEjKtzaORtACfdVH9
OlIzS/d382Ez8xN1gUKRh1s=
=gZY8
-----END PGP SIGNATURE-----

--UTjKcilERHWBCdCp--
