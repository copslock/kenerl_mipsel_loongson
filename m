Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2003 20:31:59 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:45700
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225204AbTFATb5>; Sun, 1 Jun 2003 20:31:57 +0100
Received: (qmail 25496 invoked by uid 502); 1 Jun 2003 19:31:55 -0000
Date: Sun, 1 Jun 2003 12:31:55 -0700
From: ilya@theIlya.com
To: linux-mips@linux-mips.org
Subject: Another small compile fix
Message-ID: <20030601193154.GC3035@gateway.total-knowledge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I wonder if they ever compile FB drivers with arches where BITS_PER_LONG !=
=3D32...

Index: include/linux/fb.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/include/linux/fb.h,v
retrieving revision 1.30
diff -u -r1.30 fb.h
--- include/linux/fb.h  1 Jun 2003 12:07:45 -0000       1.30
+++ include/linux/fb.h  1 Jun 2003 19:28:32 -0000
@@ -432,9 +432,11 @@
 #define fb_readb(addr) (*(volatile u8 *) (addr))
 #define fb_readw(addr) (*(volatile u16 *) (addr))
 #define fb_readl(addr) (*(volatile u32 *) (addr))
+#define fb_readq(addr) (*(volatile u64 *) (addr))
 #define fb_writeb(b,addr) (*(volatile u8 *) (addr) =3D (b))
 #define fb_writew(b,addr) (*(volatile u16 *) (addr) =3D (b))
 #define fb_writel(b,addr) (*(volatile u32 *) (addr) =3D (b))
+#define fb_writeq(b,addr) (*(volatile u64 *) (addr) =3D (b))
 #define fb_memset memset
=20
 #endif

Index: drivers/video/cfbcopyarea.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/drivers/video/cfbcopyarea.c,v
retrieving revision 1.4
diff -u -r1.4 cfbcopyarea.c
--- drivers/video/cfbcopyarea.c 1 Jun 2003 12:07:43 -0000       1.4
+++ drivers/video/cfbcopyarea.c 1 Jun 2003 19:30:55 -0000
@@ -38,7 +38,7 @@
 #define BYTES_PER_LONG 4
 #else
 #define FB_WRITEL fb_writeq
-#define FB_READL  fb_readq(x)
+#define FB_READL  fb_readq
 #define SHIFT_PER_LONG 6
 #define BYTES_PER_LONG 8
 #endif


--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+2lSq7sVBmHZT8w8RAmvfAJ0bWHm6qSprVxLR7Qn8yxQrnjpq4QCgtfj1
tIY+lTUbzgayosd+FVtDqcE=
=zeW1
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
