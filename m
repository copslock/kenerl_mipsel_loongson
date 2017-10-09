Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:46:21 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51755 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992641AbdJIMpJsBK0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:45:09 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQe-0004uu-NI; Mon, 09 Oct 2017 13:45:05 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQc-0002PT-8q; Mon, 09 Oct 2017 13:45:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Steven J. Hill" <sjhill@mips.com>,
        "David Daney" <david.daney@cavium.com>
Date:   Mon, 09 Oct 2017 13:30:34 +0100
Message-ID: <lsq.1507552234.105575594@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 68/74] MIPS: Refactor 'clear_page' and 'copy_page'
 functions.
In-Reply-To: <lsq.1507552233.547064726@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

3.2.94-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven J. Hill" <sjhill@mips.com>

commit c022630633624a75b3b58f43dd3c6cc896a56cff upstream.

Remove usage of the '__attribute__((alias("...")))' hack that aliased
to integer arrays containing micro-assembled instructions. This hack
breaks when building a microMIPS kernel. It also makes the code much
easier to understand.

[ralf@linux-mips.org: Added back export of the clear_page and copy_page
symbols so certain modules will work again.  Also fixed build with
CONFIG_SIBYTE_DMA_PAGEOPS enabled.]

Signed-off-by: Steven J. Hill <sjhill@mips.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/3866/
Acked-by: David Daney <david.daney@cavium.com>
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.2: adjust context]
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/mips_ksyms.c |  8 +++++-
 arch/mips/mm/Makefile         |  4 +--
 arch/mips/mm/page-funcs.S     | 50 ++++++++++++++++++++++++++++++++
 arch/mips/mm/page.c           | 67 ++++++++++++-------------------------------
 4 files changed, 77 insertions(+), 52 deletions(-)
 create mode 100644 arch/mips/mm/page-funcs.S

--- a/arch/mips/kernel/mips_ksyms.c
+++ b/arch/mips/kernel/mips_ksyms.c
@@ -5,7 +5,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1996, 97, 98, 99, 2000, 01, 03, 04, 05 by Ralf Baechle
+ * Copyright (C) 1996, 97, 98, 99, 2000, 01, 03, 04, 05, 12 by Ralf Baechle
  * Copyright (C) 1999, 2000, 01 Silicon Graphics, Inc.
  */
 #include <linux/interrupt.h>
@@ -35,6 +35,12 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(kernel_thread);
 
 /*
+ * Functions that operate on entire pages.  Mostly used by memory management.
+ */
+EXPORT_SYMBOL(clear_page);
+EXPORT_SYMBOL(copy_page);
+
+/*
  * Userspace access stuff.
  */
 EXPORT_SYMBOL(__copy_user);
--- a/arch/mips/mm/Makefile
+++ b/arch/mips/mm/Makefile
@@ -3,8 +3,8 @@
 #
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
-				   init.o mmap.o tlbex.o tlbex-fault.o uasm.o \
-				   page.o
+				   init.o mmap.o page.o page-funcs.o \
+				   tlbex.o tlbex-fault.o uasm.o
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
--- /dev/null
+++ b/arch/mips/mm/page-funcs.S
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Micro-assembler generated clear_page/copy_page functions.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.
+ * Copyright (C) 2012  Ralf Baechle <ralf@linux-mips.org>
+ */
+#include <asm/asm.h>
+#include <asm/regdef.h>
+
+#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+#define cpu_clear_page_function_name	clear_page_cpu
+#define cpu_copy_page_function_name	copy_page_cpu
+#else
+#define cpu_clear_page_function_name	clear_page
+#define cpu_copy_page_function_name	copy_page
+#endif
+
+/*
+ * Maximum sizes:
+ *
+ * R4000 128 bytes S-cache:		0x058 bytes
+ * R4600 v1.7:				0x05c bytes
+ * R4600 v2.0:				0x060 bytes
+ * With prefetching, 16 word strides	0x120 bytes
+ */
+EXPORT(__clear_page_start)
+LEAF(cpu_clear_page_function_name)
+1:	j	1b		/* Dummy, will be replaced. */
+	.space 288
+END(cpu_clear_page_function_name)
+EXPORT(__clear_page_end)
+
+/*
+ * Maximum sizes:
+ *
+ * R4000 128 bytes S-cache:		0x11c bytes
+ * R4600 v1.7:				0x080 bytes
+ * R4600 v2.0:				0x07c bytes
+ * With prefetching, 16 word strides	0x540 bytes
+ */
+EXPORT(__copy_page_start)
+LEAF(cpu_copy_page_function_name)
+1:	j	1b		/* Dummy, will be replaced. */
+	.space 1344
+END(cpu_copy_page_function_name)
+EXPORT(__copy_page_end)
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2003, 04, 05 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2007  Maciej W. Rozycki
  * Copyright (C) 2008  Thiemo Seufer
+ * Copyright (C) 2012  MIPS Technologies, Inc.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -72,45 +73,6 @@ static struct uasm_reloc __cpuinitdata r
 #define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
 #define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
 
-/*
- * Maximum sizes:
- *
- * R4000 128 bytes S-cache:		0x058 bytes
- * R4600 v1.7:				0x05c bytes
- * R4600 v2.0:				0x060 bytes
- * With prefetching, 16 word strides	0x120 bytes
- */
-
-static u32 clear_page_array[0x120 / 4];
-
-#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
-void clear_page_cpu(void *page) __attribute__((alias("clear_page_array")));
-#else
-void clear_page(void *page) __attribute__((alias("clear_page_array")));
-#endif
-
-EXPORT_SYMBOL(clear_page);
-
-/*
- * Maximum sizes:
- *
- * R4000 128 bytes S-cache:		0x11c bytes
- * R4600 v1.7:				0x080 bytes
- * R4600 v2.0:				0x07c bytes
- * With prefetching, 16 word strides	0x540 bytes
- */
-static u32 copy_page_array[0x540 / 4];
-
-#ifdef CONFIG_SIBYTE_DMA_PAGEOPS
-void
-copy_page_cpu(void *to, void *from) __attribute__((alias("copy_page_array")));
-#else
-void copy_page(void *to, void *from) __attribute__((alias("copy_page_array")));
-#endif
-
-EXPORT_SYMBOL(copy_page);
-
-
 static int pref_bias_clear_store __cpuinitdata;
 static int pref_bias_copy_load __cpuinitdata;
 static int pref_bias_copy_store __cpuinitdata;
@@ -283,10 +245,15 @@ static inline void __cpuinit build_clear
 		}
 }
 
+extern u32 __clear_page_start;
+extern u32 __clear_page_end;
+extern u32 __copy_page_start;
+extern u32 __copy_page_end;
+
 void __cpuinit build_clear_page(void)
 {
 	int off;
-	u32 *buf = (u32 *)&clear_page_array;
+	u32 *buf = &__clear_page_start;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	int i;
@@ -357,17 +324,17 @@ void __cpuinit build_clear_page(void)
 	uasm_i_jr(&buf, RA);
 	uasm_i_nop(&buf);
 
-	BUG_ON(buf > clear_page_array + ARRAY_SIZE(clear_page_array));
+	BUG_ON(buf > &__clear_page_end);
 
 	uasm_resolve_relocs(relocs, labels);
 
 	pr_debug("Synthesized clear page handler (%u instructions).\n",
-		 (u32)(buf - clear_page_array));
+		 (u32)(buf - &__clear_page_start));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (buf - clear_page_array); i++)
-		pr_debug("\t.word 0x%08x\n", clear_page_array[i]);
+	for (i = 0; i < (buf - &__clear_page_start); i++)
+		pr_debug("\t.word 0x%08x\n", (&__clear_page_start)[i]);
 	pr_debug("\t.set pop\n");
 }
 
@@ -428,7 +395,7 @@ static inline void build_copy_store_pref
 void __cpuinit build_copy_page(void)
 {
 	int off;
-	u32 *buf = (u32 *)&copy_page_array;
+	u32 *buf = &__copy_page_start;
 	struct uasm_label *l = labels;
 	struct uasm_reloc *r = relocs;
 	int i;
@@ -596,21 +563,23 @@ void __cpuinit build_copy_page(void)
 	uasm_i_jr(&buf, RA);
 	uasm_i_nop(&buf);
 
-	BUG_ON(buf > copy_page_array + ARRAY_SIZE(copy_page_array));
+	BUG_ON(buf > &__copy_page_end);
 
 	uasm_resolve_relocs(relocs, labels);
 
 	pr_debug("Synthesized copy page handler (%u instructions).\n",
-		 (u32)(buf - copy_page_array));
+		 (u32)(buf - &__copy_page_start));
 
 	pr_debug("\t.set push\n");
 	pr_debug("\t.set noreorder\n");
-	for (i = 0; i < (buf - copy_page_array); i++)
-		pr_debug("\t.word 0x%08x\n", copy_page_array[i]);
+	for (i = 0; i < (buf - &__copy_page_start); i++)
+		pr_debug("\t.word 0x%08x\n", (&__copy_page_start)[i]);
 	pr_debug("\t.set pop\n");
 }
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
+extern void clear_page_cpu(void *page);
+extern void copy_page_cpu(void *to, void *from);
 
 /*
  * Pad descriptors to cacheline, since each is exclusively owned by a
