Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2004 00:14:06 +0100 (BST)
Received: from hydra.gt.owl.de ([IPv6:::ffff:195.71.99.218]:61887 "EHLO
	hydra.gt.owl.de") by linux-mips.org with ESMTP id <S8225003AbUIVXOB>;
	Thu, 23 Sep 2004 00:14:01 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id DD469199498; Thu, 23 Sep 2004 01:13:58 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 94A6E138065; Thu, 23 Sep 2004 01:09:38 +0200 (CEST)
Date: Thu, 23 Sep 2004 01:09:38 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: cvs head ip22/64 spaces.h
Message-ID: <20040922230938.GB17250@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
it seems cvs head needs something like this. if not provided kernel
crashes early in free_bootmem_core on the last BUG

Flo

--- linux-20040922-2.6-mips64-ip22/include/asm-mips/mach-ip22/spaces.h	2004=
-09-21 12:59:52.000000000 +0200
+++ linux-20040922-2.6-mips64-ip22/include/asm-mips/mach-ip22/spaces.h	2004=
-09-22 19:22:40.000000000 +0200
@@ -0,0 +1,55 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ */
+#ifndef _ASM_MACH_SPACES_H
+#define _ASM_MACH_SPACES_H
+
+#include <linux/config.h>
+
+#ifdef CONFIG_MIPS32
+
+#define CAC_BASE		0x80000000
+#define IO_BASE			0xa0000000
+#define UNCAC_BASE		0xa0000000
+#define MAP_BASE		0xc0000000
+
+/*
+ * This handles the memory map.
+ * We handle pages at KSEG0 for kernels with 32 bit address space.
+ */
+#define PAGE_OFFSET		0x80000000UL
+
+/*
+ * Memory above this physical address will be considered highmem.
+ */
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		0x20000000UL
+#endif
+
+#endif /* CONFIG_MIPS32 */
+
+#ifdef CONFIG_MIPS64
+#define PAGE_OFFSET	0xffffffff80000000UL
+
+#ifndef HIGHMEM_START
+#define HIGHMEM_START		(1UL << 59UL)
+#endif
+
+#define CAC_BASE		0xffffffff80000000
+#define IO_BASE			0xffffffffa0000000
+#define UNCAC_BASE		0xffffffffa0000000
+#define MAP_BASE		0xffffffffc0000000
+
+#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
+#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+
+#endif /* CONFIG_MIPS64 */
+
+#endif /* __ASM_MACH_GENERIC_SPACES_H */
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUgYyUaz2rXW+gJcRAq1SAJ9C6k+RL9QqdisuouIKzj1Luj4IQACg4LC1
fP3Wxesq4nGWKkWK915Ytsg=
=//nZ
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
