Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 11:56:33 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:44804 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225989AbVF2K4N>; Wed, 29 Jun 2005 11:56:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 96DE0E1CA8; Wed, 29 Jun 2005 12:55:47 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00327-03; Wed, 29 Jun 2005 12:55:47 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5A159E1CA3; Wed, 29 Jun 2005 12:55:47 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j5TAtolV003599;
	Wed, 29 Jun 2005 12:55:50 +0200
Date:	Wed, 29 Jun 2005 11:55:55 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] Inline ioremap() magic for 32-bit constant addresses
Message-ID: <Pine.LNX.4.61L.0506281713050.13758@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/960/Wed Jun 29 06:31:06 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Ralf,

 I'd like to get rid of CKSEG1ADDR() wherever possible from code I am 
looking after as the macro is unportable and has already proven to cause 
maintenance hassle.  I don't want to get rid of its advantages though, so 
here's an update for ioremap() that makes it be expanded inline when 
constant arguments are used and the resulting mapping fits in KSEG1.  
Likewise for iounmap().

 Apparently the generic version is used for all platforms but the Au1000.  
I have only implemented the bare minimum required for the platform to keep 
working.  The platform seems to be maintained though, so I'm leaving the 
decision as to whether to inline the platform-specific variation or not up 
to the maintainer.

 OK to apply?

  Maciej

patch-mips-2.6.12-rc4-20050526-ioremap-constant-1
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/arch/mips/au1000/common/setup.c linux-mips-2.6.12-rc4-20050526/arch/mips/au1000/common/setup.c
--- linux-mips-2.6.12-rc4-20050526.macro/arch/mips/au1000/common/setup.c	2005-04-04 04:56:03.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/arch/mips/au1000/common/setup.c	2005-06-25 23:45:43.000000000 +0000
@@ -159,7 +159,7 @@ early_initcall(au1x00_setup);
 
 #if defined(CONFIG_64BIT_PHYS_ADDR)
 /* This routine should be valid for all Au1x based boards */
-phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
 {
 	u32 start, end;
 
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/arch/mips/mm/ioremap.c linux-mips-2.6.12-rc4-20050526/arch/mips/mm/ioremap.c
--- linux-mips-2.6.12-rc4-20050526.macro/arch/mips/mm/ioremap.c	2005-02-11 05:56:05.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/arch/mips/mm/ioremap.c	2005-06-26 00:00:51.000000000 +0000
@@ -102,15 +102,6 @@ static int remap_area_pages(unsigned lon
 }
 
 /*
- * Allow physical addresses to be fixed up to help 36 bit peripherals.
- */
-phys_t __attribute__ ((weak))
-fixup_bigphys_addr(phys_t phys_addr, phys_t size)
-{
-	return phys_addr;
-}
-
-/*
  * Generic mapping function (not visible outside):
  */
 
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/io.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/io.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/io.h	2005-04-19 04:57:17.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/io.h	2005-06-26 00:27:00.000000000 +0000
@@ -26,6 +26,7 @@
 #include <asm/pgtable-bits.h>
 #include <asm/processor.h>
 
+#include <ioremap.h>
 #include <mangle-port.h>
 
 /*
@@ -208,6 +209,8 @@ extern void __iounmap(volatile void __io
 static inline void * __ioremap_mode(phys_t offset, unsigned long size,
 	unsigned long flags)
 {
+#define __IS_LOW512(addr) (!((phys_t)(addr) & (phys_t) ~0x1fffffffULL))
+
 	if (cpu_has_64bit_addresses) {
 		u64 base = UNCAC_BASE;
 
@@ -218,9 +221,30 @@ static inline void * __ioremap_mode(phys
 		if (flags == _CACHE_UNCACHED)
 			base = (u64) IO_BASE;
 		return (void *) (unsigned long) (base + offset);
+	} else if (__builtin_constant_p(offset) &&
+		   __builtin_constant_p(size) && __builtin_constant_p(flags)) {
+		phys_t phys_addr, last_addr;
+
+		phys_addr = fixup_bigphys_addr(offset, size);
+
+		/* Don't allow wraparound or zero size. */
+		last_addr = phys_addr + size - 1;
+		if (!size || last_addr < phys_addr)
+			return NULL;
+
+		/*
+		 * Map uncached objects in the low 512MB of address
+		 * space using KSEG1.
+		 */
+		if (__IS_LOW512(phys_addr) && __IS_LOW512(last_addr) &&
+		    flags == _CACHE_UNCACHED)
+			return (void *)CKSEG1ADDR(phys_addr);
+
 	}
 
 	return __ioremap(offset, size, flags);
+
+#undef __IS_LOW512
 }
 
 /*
@@ -272,12 +296,16 @@ static inline void * __ioremap_mode(phys
 
 static inline void iounmap(volatile void __iomem *addr)
 {
-	if (cpu_has_64bit_addresses)
+#define __IS_KSEG1(addr) (((unsigned long)(addr) & ~0x1fffffffUL) == CKSEG1)
+
+	if (cpu_has_64bit_addresses ||
+	    (__builtin_constant_p(addr) && __IS_KSEG1(addr)))
 		return;
 
 	__iounmap(addr);
-}
 
+#undef __IS_KSEG1
+}
 
 #define __BUILD_MEMORY_SINGLE(pfx, bwlq, type, irq)			\
 									\
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/mach-au1x00/ioremap.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/mach-au1x00/ioremap.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/mach-au1x00/ioremap.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/mach-au1x00/ioremap.h	2005-06-26 00:16:26.000000000 +0000
@@ -0,0 +1,29 @@
+/*
+ *	include/asm-mips/mach-au1x00/ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_AU1X00_IOREMAP_H
+#define __ASM_MACH_AU1X00_IOREMAP_H
+
+#include <linux/types.h>
+
+#ifndef CONFIG_64BIT_PHYS_ADDR
+static inline phys_t __fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+#endif
+
+/*
+ * Allow physical addresses to be fixed up to help 36-bit peripherals.
+ */
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return __fixup_bigphys_addr(phys_addr, size);
+}
+
+#endif /* __ASM_MACH_AU1X00_IOREMAP_H */
diff -up --recursive --new-file linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/mach-generic/ioremap.h linux-mips-2.6.12-rc4-20050526/include/asm-mips/mach-generic/ioremap.h
--- linux-mips-2.6.12-rc4-20050526.macro/include/asm-mips/mach-generic/ioremap.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.6.12-rc4-20050526/include/asm-mips/mach-generic/ioremap.h	2005-06-26 00:05:42.000000000 +0000
@@ -0,0 +1,23 @@
+/*
+ *	include/asm-mips/mach-generic/ioremap.h
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License
+ *	as published by the Free Software Foundation; either version
+ *	2 of the License, or (at your option) any later version.
+ */
+#ifndef __ASM_MACH_GENERIC_IOREMAP_H
+#define __ASM_MACH_GENERIC_IOREMAP_H
+
+#include <linux/types.h>
+
+/*
+ * Allow physical addresses to be fixed up to help peripherals located
+ * outside the low 32-bit range -- generic pass-through version.
+ */
+static inline phys_t fixup_bigphys_addr(phys_t phys_addr, phys_t size)
+{
+	return phys_addr;
+}
+
+#endif /* __ASM_MACH_GENERIC_IOREMAP_H */
