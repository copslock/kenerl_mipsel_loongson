Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5TIc0nC007033
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 29 Jun 2002 11:38:00 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5TIc0nM007030
	for linux-mips-outgoing; Sat, 29 Jun 2002 11:38:00 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5TIblnC007021;
	Sat, 29 Jun 2002 11:37:48 -0700
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 1FA4312FF9; Sat, 29 Jun 2002 20:41:29 +0200 (CEST)
Date: Sat, 29 Jun 2002 20:41:29 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: [RFC][PATCH]
Message-ID: <20020629184128.GX17216@lug-owl.de>
Mail-Followup-To: Ralf Baechle <ralf@oss.sgi.com>,
	linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OtXN0xDA1zr/oUEL"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-Spam-Status: No, hits=-3.1 required=5.0 tests=UNIFIED_PATCH,SUBJ_ALL_CAPS version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--OtXN0xDA1zr/oUEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Please give me a comment on this patch. I'm currently tryin' to make the
HAL2 driver work (yes, I've got my Indy out of the edge again and I'm
going to use it as my desktop machine).

It fixes a compilation problem on dmabuf.c. There, DMA_AUTOINIT isn't
defined. As ./include/asm-mips/dma.h looks like the asm-i386 file in
general, I've copied the #define from the i386 port (and reformated the
passus...).

If you think it'o okay, please apply it (and drop me a note:-p)

MfG, JBG



Index: include/asm-mips/dma.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/include/asm-mips/dma.h,v
retrieving revision 1.8
diff -u -r1.8 dma.h
--- include/asm-mips/dma.h	2001/09/06 13:12:02	1.8
+++ include/asm-mips/dma.h	2002/06/29 18:23:37
@@ -138,10 +138,11 @@
 #define DMA_PAGE_6              0x89
 #define DMA_PAGE_7              0x8A
=20
-#define DMA_MODE_READ	0x44	/* I/O to memory, no autoinit, increment, singl=
e mode */
-#define DMA_MODE_WRITE	0x48	/* memory to I/O, no autoinit, increment, sing=
le mode */
-#define DMA_MODE_CASCADE 0xC0   /* pass thru DREQ->HRQ, DACK<-HLDA only */
+#define DMA_MODE_READ		0x44	/* I/O to memory, no autoinit, increment, sing=
le mode */
+#define DMA_MODE_WRITE		0x48	/* memory to I/O, no autoinit, increment, sin=
gle mode */
+#define DMA_MODE_CASCADE	0xC0	/* pass thru DREQ->HRQ, DACK<-HLDA only */
=20
+#define DMA_AUTOINIT		0x10
=20
 extern spinlock_t  dma_spin_lock;
=20


--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--OtXN0xDA1zr/oUEL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Hf9YHb1edYOZ4bsRAuNjAJ92vjGnIV0rpsfKJtO0loA1Ssab/gCdGIar
ctxg3GLNLkomRxQD0toAQJY=
=l4lE
-----END PGP SIGNATURE-----

--OtXN0xDA1zr/oUEL--
