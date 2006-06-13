Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2006 11:36:03 +0100 (BST)
Received: from tool.snarl.nl ([213.84.251.124]:27545 "HELO tool.snarl.nl")
	by ftp.linux-mips.org with SMTP id S8133412AbWFMKfw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2006 11:35:52 +0100
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 83DC35DF5C;
	Tue, 13 Jun 2006 12:35:36 +0200 (CEST)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xuyrl4+DvAKL; Tue, 13 Jun 2006 12:35:34 +0200 (CEST)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id B1D095DF45; Tue, 13 Jun 2006 12:35:34 +0200 (CEST)
Date:	Tue, 13 Jun 2006 12:35:34 +0200
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix potential bug in au1xxx_ddma_add_device()
Message-ID: <20060613103534.GB5374@dusktilldawn.nl>
References: <20060413131117.GP11097@dusktilldawn.nl> <20060414060640.GE29489@domen.ultra.si> <20060418092052.GZ11097@dusktilldawn.nl> <20060419062238.GF29489@domen.ultra.si> <20060419072549.GJ11097@dusktilldawn.nl> <20060613081641.GH5568@domen.ultra.si>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20060613081641.GH5568@domen.ultra.si>
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--uXxzq0nDebZQVNAZ
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Domen,

On Tue, Jun 13, 2006 at 10:16:42AM +0200, Domen Puncer wrote:
> First a note, that your patch [dbdma.patch] doesn't make any
> difference for me.  Well... at least not an obvious one.

That's exactly what it should do, since it's a bug that I do not
yet expect to happen. So no difference is good for now.

Including the patch, so hopefully Ralf sees it again. :-)


> OK. I have an IDE drive connected now. It's a bit weird, with
> CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA I can't enable dma with
> hdparm, but if works on about 6 MB/sec.
> With CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA, I can enable DMA,
> but it works slow, like 1.7 MB/sec.
>=20
> Seems odd to me.

Hmmmm, strange. You should at least expect the other way around.
Transferring you to the mailing list, hopefully somebody over
there has got a clue.


--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--24zk1gE8NUlDmwG9
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

--24zk1gE8NUlDmwG9--

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEjpT2bxf9XXlB0eERAnphAKDXXubclMn+9FpMlT+zseREFXNx3wCg6bP5
GiOhw3AAK6qXMXTDOQz7JlY=
=gaQK
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
