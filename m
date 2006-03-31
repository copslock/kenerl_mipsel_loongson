Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2006 15:56:27 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:640 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133571AbWCaO4Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2006 15:56:16 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 6B8C65DF4B
	for <linux-mips@linux-mips.org>; Fri, 31 Mar 2006 17:06:58 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09756-06 for <linux-mips@linux-mips.org>;
	Fri, 31 Mar 2006 17:06:58 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id E33A75DF49; Fri, 31 Mar 2006 17:06:57 +0200 (CEST)
Date:	Fri, 31 Mar 2006 17:06:57 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix potential bug in au1xxx_ddma_add_device()
Message-ID: <20060331150657.GH4781@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wJeYCwfJgfFvSPOo"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--wJeYCwfJgfFvSPOo
Content-Type: multipart/mixed; boundary="gVeFDRGtAQ0W7qcm"
Content-Disposition: inline


--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Can anybody with a AMD DBAu1200 or DBAu1550 board test this patch
out? Unfortunately I don't have one so I was not able to try it
out to see if I do not brake something else.

While trying to understand the MMC driver I found a potential
glitch in the design of au1xxx_ddma_add_device(). It uses
find_dbdev_id(0) to find an available empty device slot in
the array dbdev_tab. But id 0 is already taken by
DSCR_CMD0_UART0_TX, so this entry will always be overwritten the
first time au1xxx_ddma_add_device() is called. This can lead to
some surprising effects when one expects the data for
DSCR_CMD0_UART0_TX to be in that slot.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbdma.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.16-orig/include/asm-mips/mach-au1x00/au1xxx_dbdma.h	2006-03-2=
0 11:35:39.000000000 +0000
+++ linux-2.6.16/include/asm-mips/mach-au1x00/au1xxx_dbdma.h	2006-03-31 14:=
31:56.000000000 +0000
@@ -200,7 +200,10 @@
 #define DSCR_CMD0_ALWAYS	31
 #define DSCR_NDEV_IDS		32
 /* THis macro is used to find/create custom device types */
-#define DSCR_DEV2CUSTOM_ID(x,d)	(((((x)&0xFFFF)<<8)|0x32000000)|((d)&0xFF))
+#define DSCR_ID_BASE 0x32000000
+#define DSCR_ID_OFFSET 0x1000
+#define DSCR_ID_FREE DSCR_ID_BASE
+#define DSCR_DEV2CUSTOM_ID(x,d)	(((((x)&0xFFFF)<<8)|DSCR_ID_BASE)|((d)&0xF=
F))
 #define DSCR_CUSTOM2DEV_ID(x)	((x)&0xFF)
=20
=20
--- linux-2.6.16-orig/arch/mips/au1000/common/dbdma.c	2006-03-20 11:35:39.0=
00000000 +0000
+++ linux-2.6.16/arch/mips/au1000/common/dbdma.c	2006-03-31 14:31:58.000000=
000 +0000
@@ -162,22 +162,22 @@
 	{ DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE, 0, 0, 0x00000000, 0, 0 },
=20
 	/* Provide 16 user definable device types */
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
-	{ 0, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
+	{ DSCR_ID_FREE, 0, 0, 0, 0, 0, 0 },
 };
=20
 #define DBDEV_TAB_SIZE (sizeof(dbdev_tab) / sizeof(dbdev_tab_t))
@@ -208,9 +208,9 @@
 {
 	u32 ret =3D 0;
 	dbdev_tab_t *p=3DNULL;
-	static u16 new_id=3D0x1000;
+	static u16 new_id=3DDSCR_ID_OFFSET;
=20
-	p =3D find_dbdev_id(0);
+	p =3D find_dbdev_id(DSCR_ID_FREE);
 	if ( NULL !=3D p )
 	{
 		memcpy(p, dev, sizeof(dbdev_tab_t));

--gVeFDRGtAQ0W7qcm--

--wJeYCwfJgfFvSPOo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELUWRbxf9XXlB0eERAkMXAJ0bB0qI3pqq17p5FvgO/XQLp9cJKACfYZdc
6mRK+s4PhDlQOAXzGP+Vnik=
=nop+
-----END PGP SIGNATURE-----

--wJeYCwfJgfFvSPOo--
