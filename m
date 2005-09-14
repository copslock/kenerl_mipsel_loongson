Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 17:30:05 +0100 (BST)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:15624 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225337AbVINQ3q>;
	Wed, 14 Sep 2005 17:29:46 +0100
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Wed, 14 Sep 2005 18:29:40 +0200
From:	Bruno Randolf <bruno.randolf@4g-systems.biz>
To:	linux-mips@linux-mips.org, ppopov@embeddedalley.com
Subject: [patch] little zImage.flash fixes
Date:	Wed, 14 Sep 2005 18:25:29 +0200
User-Agent: KMail/1.8.1
Organization: 4G Systems
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1279673.Wg4iRfG56D";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509141825.34038.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart1279673.Wg4iRfG56D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

fyi - i had to make the following changes after applying your=20
zImage_2_6_10.patch to use "make zImage.flash" on the recent 2.6.13=20
linux-mips kernel.  also "make zImage" wouldn't compile through without the=
=20
"-I $(TOPDIR)/include" changes.

greetings,
bruno

=2D--

diff --exclude CVS -Nurb linux/arch/mips/Makefile=20
linux-2.6.13/arch/mips/Makefile
=2D-- linux/arch/mips/Makefile=A0=A0=A0=A02005-09-14 16:44:32.000000000 +02=
00
+++ linux-2.6.13/arch/mips/Makefile=A0=A0=A0=A0=A02005-09-14 16:32:28.00000=
0000 +0200
@@ -798,6 +798,9 @@
=A0zImage: vmlinux
=A0=A0=A0=A0=A0=A0=A0=A0+@$(call makeboot,$@)
=A0
+zImage.flash: vmlinux
+=A0=A0=A0=A0=A0=A0=A0+@$(call makeboot,$@)
+
=A0CLEAN_FILES +=3D vmlinux.ecoff \
=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 vmlinux.srec \
=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 vmlinux.rm200.tmp \
diff --exclude CVS -Nurb linux/arch/mips/boot/Makefile=20
linux-2.6.13/arch/mips/boot/Makefile
=2D-- linux/arch/mips/boot/Makefile=A0=A0=A0=A0=A0=A0=A02005-09-14 16:44:32=
=2E000000000 +0200
+++ linux-2.6.13/arch/mips/boot/Makefile=A0=A0=A0=A0=A0=A0=A0=A02005-09-14 =
16:35:14.000000000=20
+0200
@@ -26,7 +26,7 @@
=A0
=A0VMLINUX =3D vmlinux
=A0
=2DZBOOT_TARGETS=A0=A0=3D zImage
+ZBOOT_TARGETS=A0=A0=3D zImage zImage.flash
=A0bootdir-y=A0=A0=A0=A0=A0=A0:=3D compressed
=A0
=A0all: vmlinux.ecoff vmlinux.srec addinitrd zImage
diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/Makefile=20
linux-2.6.13/arch/mips/boot/compressed/Makefile
=2D-- linux/arch/mips/boot/compressed/Makefile=A0=A0=A0=A02005-09-14 16:44:=
32.000000000=20
+0200
+++ linux-2.6.13/arch/mips/boot/compressed/Makefile=A0=A0=A0=A0=A02005-09-1=
4=20
16:31:53.000000000 +0200
@@ -18,7 +18,7 @@
=A0
=A0CFLAGS=A0 =A0=A0=A0=A0=A0=A0=A0+=3D -fno-builtin -D__BOOTER__ -I$(compre=
ssed)/include
=A0
=2DBOOT_TARGETS=A0=A0=A0=3D zImage=20
+BOOT_TARGETS=A0=A0=A0=3D zImage zImage.flash
=A0
=A0bootdir-$(CONFIG_SOC_AU1X00)=A0=A0=A0:=3D au1xxx
=A0subdir-y=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0:=3D common lib images
diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/au1xxx/Makefile=20
linux-2.6.13/arch/mips/boot/compressed/au1xxx/Makefile
=2D-- linux/arch/mips/boot/compressed/au1xxx/Makefile=A0=A0=A0=A0=A02005-09=
=2D14=20
16:44:32.000000000 +0200
+++ linux-2.6.13/arch/mips/boot/compressed/au1xxx/Makefile=A0=A0=A0=A0=A0=
=A02005-09-14=20
16:38:34.000000000 +0200
@@ -73,12 +73,12 @@
=A0endif
=A0
=A0$(obj)/head.o: $(obj)/head.S $(TOPDIR)/vmlinux
=2D=A0=A0=A0=A0=A0=A0=A0$(CC) $(AFLAGS) \
+=A0=A0=A0=A0=A0=A0=A0$(CC) -I $(TOPDIR)/include $(AFLAGS) \
=A0=A0=A0=A0=A0=A0=A0=A0-DKERNEL_ENTRY=3D$(shell sh $(ENTRY) $(NM) $(TOPDIR=
)/vmlinux ) \
=A0=A0=A0=A0=A0=A0=A0=A0-c -o $*.o $<
=A0
=A0$(common)/misc-simple.o:
=2D=A0=A0=A0=A0=A0=A0=A0$(CC) $(CFLAGS) -DINITRD_OFFSET=3D0 -DINITRD_SIZE=
=3D0 -DZIMAGE_OFFSET=3D0 \
+=A0=A0=A0=A0=A0=A0=A0$(CC) -I $(TOPDIR)/include $(CFLAGS) -DINITRD_OFFSET=
=3D0 -DINITRD_SIZE=3D0=20
=2DDZIMAGE_OFFSET=3D0 \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-DAVAIL_RAM_START=3D$(AVAIL=
_RAM_START) \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-DAVAIL_RAM_END=3D$(AVAIL_R=
AM_END) \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0-DLOADADDR=3D$(LOADADDR) \
diff --exclude CVS -Nurb linux/arch/mips/boot/compressed/common/misc-simple=
=2Ec=20
linux-2.6.13/arch/mips/boot/compressed/common/misc-simple.c
=2D-- linux/arch/mips/boot/compressed/common/misc-simple.c=A0=A0=A0=A0=A0=
=A0=A0=A02005-09-14=20
16:44:32.000000000 +0200
+++ linux-2.6.13/arch/mips/boot/compressed/common/misc-simple.c=A02005-09-1=
4=20
16:31:07.000000000 +0200
@@ -24,7 +24,7 @@
=A0
=A0#include <asm/page.h>
=A0
=2D#include "zlib.h"
+#include "linux/zlib.h"
=A0
=A0extern struct NS16550 *com_port;

--nextPart1279673.Wg4iRfG56D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDKE7+fg2jtUL97G4RAq14AJ9q4sf4Ba0FNL68pGYBadz9omHEzwCfYsXB
TQxrpJxNlUx25CkkeOGCSb0=
=4Oqb
-----END PGP SIGNATURE-----

--nextPart1279673.Wg4iRfG56D--
