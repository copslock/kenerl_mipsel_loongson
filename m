Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7B0vmRw009673
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 10 Aug 2002 17:57:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7B0vmYA009672
	for linux-mips-outgoing; Sat, 10 Aug 2002 17:57:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7B0vbRw009662
	for <linux-mips@oss.sgi.com>; Sat, 10 Aug 2002 17:57:38 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D98681359C; Sun, 11 Aug 2002 02:59:53 +0200 (CEST)
Date: Sun, 11 Aug 2002 02:59:53 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips <linux-mips@oss.sgi.com>
Subject: [PATCH] dec_esp.c compile fix
Message-ID: <20020811005953.GB19435@lug-owl.de>
Mail-Followup-To: linux-mips <linux-mips@oss.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-4.4 required=5.0 tests=TO_LOCALPART_EQ_REAL,UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Karsten Merker and I just made dec_esp.c compileable again. Please
apply, but beware: it's untested because we currently don't have HDDs
here...

MfG, JBG


Index: dec_esp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/drivers/scsi/dec_esp.c,v
retrieving revision 1.10.2.2
diff -u -r1.10.2.2 dec_esp.c
--- dec_esp.c	2002/07/24 17:55:47	1.10.2.2
+++ dec_esp.c	2002/08/11 00:25:15
@@ -447,15 +447,15 @@
     struct mmu_sglist *sg =3D (struct mmu_sglist *) sp->SCp.buffer;
=20
     while (sz >=3D 0) {
-		sg[sz].dvma_addr =3D PHYSADDR(sg[sz].addr);
+		sg[sz].dvma_address =3D PHYSADDR(sg[sz].addr);
 	sz--;
     }
-	sp->SCp.ptr =3D (char *) ((unsigned long) sp->SCp.buffer->dvma_address);
+	sp->SCp.ptr =3D (char *) ((unsigned long) sp->SCp.buffer->dma_address);
 }
=20
 static void dma_advance_sg(Scsi_Cmnd * sp)
 {
-	sp->SCp.ptr =3D (char *) ((unsigned long) sp->SCp.buffer->dvma_address);
+	sp->SCp.ptr =3D (char *) ((unsigned long) sp->SCp.buffer->dma_address);
 }
=20
 static void pmaz_dma_drain(struct NCR_ESP *esp)


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9VbcJHb1edYOZ4bsRAl2VAJ9/Uoy9F5FzaaxlRSF97XqFOiFgnQCfRdlO
4cChYX9e7LgD9xL1MLGoahQ=
=kdXa
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
