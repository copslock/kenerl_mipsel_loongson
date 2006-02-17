Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2006 14:47:32 +0000 (GMT)
Received: from tool.snarl.nl ([213.84.251.124]:32164 "EHLO tool.snarl.nl")
	by ftp.linux-mips.org with ESMTP id S8133657AbWBQOrV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2006 14:47:21 +0000
Received: from localhost (tool.local.snarl.nl [127.0.0.1])
	by tool.snarl.nl (Postfix) with ESMTP id 754EC5DF5B
	for <linux-mips@linux-mips.org>; Fri, 17 Feb 2006 15:53:53 +0100 (CET)
Received: from tool.snarl.nl ([127.0.0.1])
	by localhost (tool.local.snarl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29617-03 for <linux-mips@linux-mips.org>;
	Fri, 17 Feb 2006 15:53:53 +0100 (CET)
Received: by tool.snarl.nl (Postfix, from userid 1000)
	id 00E8A5DF4D; Fri, 17 Feb 2006 15:53:52 +0100 (CET)
Date:	Fri, 17 Feb 2006 15:53:52 +0100
From:	Freddy Spierenburg <freddy@dusktilldawn.nl>
To:	linux-mips@linux-mips.org
Subject: [PATCH] replaced io_remap_page_range() with io_remap_pfn_range()
Message-ID: <20060217145352.GD14066@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
X-User-Agent-Feature: All mail clients suck. This one just sucks less.
X-GPG-Key: http://snarl.nl/~freddy/keys/freddyPublicKey.gpg
User-Agent: Mutt/1.5.11
Return-Path: <freddy@dusktilldawn.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: freddy@dusktilldawn.nl
Precedence: bulk
X-list: linux-mips


--fwqqG+mf3f7vyBCB
Content-Type: multipart/mixed; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Replaced the no longer existing io_remap_page_range() routine
with the io_remap_pfn_range() routine. Did not have a chance yet
to test the functionality of the driver, but at least the kernel
compiles cleanly again.

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl> http://snarl.nl/~freddy/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fb.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naur master.orig/drivers/video/au1100fb.c master.good/drivers/video/a=
u1100fb.c
--- master.orig/drivers/video/au1100fb.c	2006-02-17 10:57:28.000000000 +0000
+++ master.good/drivers/video/au1100fb.c	2006-02-17 14:05:58.000000000 +0000
@@ -50,6 +50,7 @@
 #include <linux/interrupt.h>
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
=20
 #include <asm/mach-au1x00/au1000.h>
=20
@@ -407,7 +408,7 @@
=20
 	vma->vm_flags |=3D VM_IO;
    =20
-	if (io_remap_page_range(vma, vma->vm_start, off,
+	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;

--cYtjc4pxslFTELvY--

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD9eOAbxf9XXlB0eERAmF9AJ9dnQoSo2U/yMwXcG3QdnCZcoPxngCgtMw+
pMzQ+TnIhLoy8anKjYBfBm4=
=c6pg
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
