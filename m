Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 05:00:36 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:30689
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8224771AbVBUFAQ>; Mon, 21 Feb 2005 05:00:16 +0000
Received: from suzaku.infostations.net (suzaku.infostations.net [71.4.40.34])
	by mail-relay.infostations.net (Postfix) with ESMTP id 41B619F855
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 21:00:18 -0800 (PST)
Received: from host-69-19-145-86.rev.o1.com ([69.19.145.86])
	by suzaku.infostations.net with esmtp (Exim 4.41 #1)
	id 1D35g4-0006JZ-Vz
	for <linux-mips@linux-mips.org>; Sun, 20 Feb 2005 21:00:13 -0800
Subject: Fixes to MTD flash driver on AMD Alchemy db1100 board
From:	Josh Green <jgreen@users.sourceforge.net>
To:	linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZJuk6N3uUH2kBZsUDiL1"
Date:	Sun, 20 Feb 2005 21:01:45 -0800
Message-Id: <1108962105.6611.24.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-ZJuk6N3uUH2kBZsUDiL1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello, I found a couple compile problems with the
drivers/mtd/maps/db1x00-flash.c MTD driver.  I'm using linux-mips CVS
from a few weeks back, corresponding to 2.6.11rc2.  I noticed some
recent CVS traffic in regards to this driver, but I didn't see them in
cvsweb on the linux-mips site.  My apologies if this is something that
has already been reported.  Fixes in the patch below:

- Specify proper paths for #include of au1000.h and db1x00.h
- Cast return value of ioremap to (void __iomem *) to get rid of warning
concerning conversion of integer to pointer
- Setup DB1X00_BOTH_BANKS, DB1X00_BOOT_ONLY, and DB1X00_USER_ONLY
defines in db1x00.h (used pb1550.h as an example) since they seemed to
be missing which was causing the following to be triggered:

#error MTD_DB1X00 define combo error /* should never happen */

I can see the partitions in /dev/mtd now, but I have not thoroughly
tested it yet to see if there are any other problems.

Best regards,
	Josh Green


---------------


diff -ruN a/drivers/mtd/maps/db1x00-flash.c b/drivers/mtd/maps/db1x00-flash=
.c
--- a/drivers/mtd/maps/db1x00-flash.c	2005-02-20 20:29:30.268844944 -0800
+++ b/drivers/mtd/maps/db1x00-flash.c	2005-02-20 20:29:36.025969728 -0800
@@ -18,8 +18,8 @@
 #include <linux/mtd/partitions.h>
=20
 #include <asm/io.h>
-#include <asm/au1000.h>
-#include <asm/db1x00.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/db1x00.h>
=20
 #ifdef 	DEBUG_RW
 #define	DBG(x...)	printk(x)
@@ -192,7 +192,7 @@
 	 */
 	printk(KERN_NOTICE "Db1xxx flash: probing %d-bit flash bus\n",=20
 			db1xxx_mtd_map.bankwidth*8);
-	db1xxx_mtd_map.virt =3D (unsigned long)ioremap(window_addr, window_size);
+	db1xxx_mtd_map.virt =3D (void __iomem *)ioremap(window_addr, window_size)=
;
 	db1xxx_mtd =3D do_map_probe("cfi_probe", &db1xxx_mtd_map);
 	if (!db1xxx_mtd) return -ENXIO;
 	db1xxx_mtd->owner =3D THIS_MODULE;
diff -ruN a/include/asm-mips/mach-db1x00/db1x00.h b/include/asm-mips/mach-d=
b1x00/db1x00.h
--- a/include/asm-mips/mach-db1x00/db1x00.h	2005-02-20 20:30:51.710463936 -=
0800
+++ b/include/asm-mips/mach-db1x00/db1x00.h	2005-02-20 20:31:00.671101712 -=
0800
@@ -134,6 +134,14 @@
 #define SET_VCC_VPP(VCC, VPP, SLOT)\
 	((((VCC)<<2) | ((VPP)<<0)) << ((SLOT)*8))
=20
+#if defined(CONFIG_MTD_DB1X00_BOOT) && defined(CONFIG_MTD_DB1X00_USER)
+#define DB1X00_BOTH_BANKS
+#elif defined(CONFIG_MTD_DB1X00_BOOT) && !defined(CONFIG_MTD_DB1X00_USER)
+#define DB1X00_BOOT_ONLY
+#elif !defined(CONFIG_MTD_DB1X00_BOOT) && defined(CONFIG_MTD_DB1X00_USER)
+#define DB1X00_USER_ONLY
+#endif
+
 /* SD controller macros */
 /*
  * Detect card.



--=-ZJuk6N3uUH2kBZsUDiL1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCGWs5RoMuWKCcbgQRAqH7AKCslw5LfIxEI6qngt8X8Sq02kf9ygCgh8ZX
ESEzXwIqUy0QwewHPi2eFPI=
=wk1p
-----END PGP SIGNATURE-----

--=-ZJuk6N3uUH2kBZsUDiL1--
