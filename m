Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2005 23:16:23 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:10677
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225397AbVAHXQR>; Sat, 8 Jan 2005 23:16:17 +0000
Received: (qmail 18044 invoked from network); 8 Jan 2005 06:00:27 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 8 Jan 2005 06:00:27 -0800
Message-ID: <41E069BF.8040500@total-knowledge.com>
Date: Sat, 08 Jan 2005 15:16:15 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, gentoo-mips@lists.gentoo.org
Subject: IP32 memory patch
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Hi all,

Here is patch to allow IP32 to access full 1G of memory.
I was able to boot an O2 with 576M of ram using NFS-root.

Two notes:
1. This patch will only work with latest linux-mips.org CVS tree
2.  Seems that PCI support is messed up by this patch, so SCSI doesn't work.

If someone can see something obvious regarding #2, I'll be glad to hear it.

    Ilya.

Index: arch/mips/sgi-ip32/Makefile
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- arch/mips/sgi-ip32/Makefile 26 Feb 2004 09:09:09 -0000      1.9
+++ arch/mips/sgi-ip32/Makefile 8 Jan 2005 23:04:07 -0000
@@ -4,6 +4,6 @@
 #

 obj-y  += ip32-berr.o ip32-irq.o ip32-irq-glue.o ip32-setup.o 
ip32-reset.o \
-          crime.o
+          crime.o ip32-memory.o

 EXTRA_AFLAGS := $(CFLAGS)
Index: arch/mips/sgi-ip32/crime.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/crime.c,v
retrieving revision 1.6
diff -u -r1.6 crime.c
--- arch/mips/sgi-ip32/crime.c  31 Aug 2004 16:49:32 -0000      1.6
+++ arch/mips/sgi-ip32/crime.c  8 Jan 2005 23:04:07 -0000
@@ -24,7 +24,8 @@
 {
        unsigned int id, rev;
        const int field = 2 * sizeof(unsigned long);
-
+
+       set_io_port_base((unsigned long) ioremap(MACEPCI_LOW_IO, 
0x2000000));
        crime = ioremap(CRIME_BASE, sizeof(struct sgi_crime));
        mace = ioremap(MACE_BASE, sizeof(struct sgi_mace));

Index: arch/mips/sgi-ip32/ip32-setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/sgi-ip32/ip32-setup.c,v
retrieving revision 1.22
diff -u -r1.22 ip32-setup.c
--- arch/mips/sgi-ip32/ip32-setup.c     31 Aug 2004 16:49:32 -0000      1.22
+++ arch/mips/sgi-ip32/ip32-setup.c     8 Jan 2005 23:04:07 -0000
@@ -94,10 +94,6 @@

 static int __init ip32_setup(void)
 {
-       set_io_port_base((unsigned long) ioremap(MACEPCI_LOW_IO, 
0x2000000));
-
-       crime_init();
-
        board_be_init = ip32_be_init;

        rtc_get_time = mc146818_get_cmos_time;
Index: include/asm-mips/mach-ip32/spaces.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips/mach-ip32/spaces.h,v
retrieving revision 1.1
diff -u -r1.1 spaces.h
--- include/asm-mips/mach-ip32/spaces.h 15 Oct 2004 02:09:12 -0000      1.1
+++ include/asm-mips/mach-ip32/spaces.h 8 Jan 2005 23:04:25 -0000
@@ -12,10 +12,6 @@

 #include <linux/config.h>

-/*
- * This handles the memory map.
- */
-#define PAGE_OFFSET            0xffffffff80000000

 /*
  * Memory above this physical address will be considered highmem.
@@ -39,4 +35,9 @@
 #define TO_CAC(x)              (CAC_BASE   | ((x) & TO_PHYS_MASK))
 #define TO_UNCAC(x)            (UNCAC_BASE | ((x) & TO_PHYS_MASK))

+/*
+ * This handles the memory map.
+ */
+#define PAGE_OFFSET            CAC_BASE
+
 #endif /* __ASM_MACH_IP32_SPACES_H */
--- /dev/null   1969-12-31 16:00:00 -0800
+++ arch/mips/sgi-ip32/ip32-memory.c    2005-01-08 14:15:20 -0800
@@ -0,0 +1,55 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General 
Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Keith M Wesolowski
+ */
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/ip32/crime.h>
+#include <asm/bootinfo.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+
+extern void crime_init(void);
+
+
+void __init prom_meminit (void)
+{
+       u64 base, size;
+       int bank;
+
+       crime_init();
+
+       for (bank=0; bank < CRIME_MAXBANKS; bank++) {
+               u64 bankctl = crime->bank_ctrl[bank];
+               base = (bankctl & CRIME_MEM_BANK_CONTROL_ADDR) << 25;
+               if (bank != 0 && base == 0)
+                       continue;
+               size = (bankctl & CRIME_MEM_BANK_CONTROL_SDRAM_SIZE) ? 
128 : 32;
+               size <<= 20;
+               if (base + size > (256 << 20)) {
+#if !defined(CONFIG_HIGHMEM) && PAGE_OFFSET!=CAC_BASE
+                   continue;
+#else
+                   base+=0x40000000;
+#endif
+               }
+               printk("CRIME MC: bank %u base 0x%016lx size %luMB\n",
+                       bank, base, size);
+               add_memory_region (base, size, BOOT_MEM_RAM);
+       }
+}
+
+
+unsigned long __init prom_free_prom_memory (void)
+{
+       return 0;
+}
+
+
--- /dev/null   1969-12-31 16:00:00 -0800
+++ include/asm/mach-ip32/cpu-feature-overrides.h       2005-01-08 
10:44:46 -0800
@@ -0,0 +1,15 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General 
Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Ralf Baechle
+ */
+#ifndef __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H
+
+#if defined(CONFIG_CPU_R5000) && defined(CONFIG_MIPS64)
+#define cpu_has_llsc   0
+#endif
+
+#endif /* __ASM_MACH_GENERIC_CPU_FEATURE_OVERRIDES_H */
