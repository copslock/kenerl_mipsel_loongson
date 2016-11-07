Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:18:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3529 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992096AbcKGLRGMIqOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:17:06 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id A22854365421D;
        Mon,  7 Nov 2016 11:16:57 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:16:59 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 10/10] MIPS: Export {copy,clear}_page functions alongside their definitions
Date:   Mon, 7 Nov 2016 11:14:16 +0000
Message-ID: <20161107111417.11486-11-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111417.11486-1-paul.burton@imgtec.com>
References: <20161107111417.11486-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Now that EXPORT_SYMBOL can be used from assembly source, move the
EXPORT_SYMBOL invocations for the copy_page & clear_page functions to be
alongside their definitions.

With this change there are no longer any symbols exported from
mips_ksyms.c so remove the file.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

 arch/mips/kernel/Makefile     |  2 +-
 arch/mips/kernel/mips_ksyms.c | 24 ------------------------
 arch/mips/mm/page-funcs.S     |  3 +++
 arch/mips/mm/page.c           |  2 ++
 4 files changed, 6 insertions(+), 25 deletions(-)
 delete mode 100644 arch/mips/kernel/mips_ksyms.c

diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 4a603a3..09fca54 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SYNC_R4K)		+= sync-r4k.o
 
 obj-$(CONFIG_DEBUG_FS)		+= segment.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
-obj-$(CONFIG_MODULES)		+= mips_ksyms.o module.o
+obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULES_USE_ELF_RELA) += module-rela.o
 
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
diff --git a/arch/mips/kernel/mips_ksyms.c b/arch/mips/kernel/mips_ksyms.c
deleted file mode 100644
index c641fd0..0000000
--- a/arch/mips/kernel/mips_ksyms.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Export MIPS-specific functions needed for loadable modules.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 97, 98, 99, 2000, 01, 03, 04, 05, 12 by Ralf Baechle
- * Copyright (C) 1999, 2000, 01 Silicon Graphics, Inc.
- */
-#include <linux/interrupt.h>
-#include <linux/export.h>
-#include <asm/checksum.h>
-#include <linux/mm.h>
-#include <asm/uaccess.h>
-#include <asm/ftrace.h>
-#include <asm/fpu.h>
-#include <asm/msa.h>
-
-/*
- * Functions that operate on entire pages.  Mostly used by memory management.
- */
-EXPORT_SYMBOL(clear_page);
-EXPORT_SYMBOL(copy_page);
diff --git a/arch/mips/mm/page-funcs.S b/arch/mips/mm/page-funcs.S
index 48a6b38..43181ac 100644
--- a/arch/mips/mm/page-funcs.S
+++ b/arch/mips/mm/page-funcs.S
@@ -9,6 +9,7 @@
  * Copyright (C) 2012  Ralf Baechle <ralf@linux-mips.org>
  */
 #include <asm/asm.h>
+#include <asm/export.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
@@ -29,6 +30,7 @@
  */
 EXPORT(__clear_page_start)
 LEAF(cpu_clear_page_function_name)
+EXPORT_SYMBOL(cpu_clear_page_function_name)
 1:	j	1b		/* Dummy, will be replaced. */
 	.space 288
 END(cpu_clear_page_function_name)
@@ -44,6 +46,7 @@ EXPORT(__clear_page_end)
  */
 EXPORT(__copy_page_start)
 LEAF(cpu_copy_page_function_name)
+EXPORT_SYMBOL(cpu_copy_page_function_name)
 1:	j	1b		/* Dummy, will be replaced. */
 	.space 1344
 END(cpu_copy_page_function_name)
diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index 6f804f5..d5d0299 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -661,6 +661,7 @@ void clear_page(void *page)
 		;
 	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
 }
+EXPORT_SYMBOL(clear_page);
 
 void copy_page(void *to, void *from)
 {
@@ -687,5 +688,6 @@ void copy_page(void *to, void *from)
 		;
 	__raw_readq(IOADDR(A_DM_REGISTER(cpu, R_DM_DSCR_BASE)));
 }
+EXPORT_SYMBOL(copy_page);
 
 #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
-- 
2.10.2
