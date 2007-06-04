Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 17:27:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:52717 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022521AbXFDQ1m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2007 17:27:42 +0100
Received: from localhost (p3180-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.180])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0AF0F97CB; Tue,  5 Jun 2007 01:27:38 +0900 (JST)
Date:	Tue, 05 Jun 2007 01:28:07 +0900 (JST)
Message-Id: <20070605.012807.112854731.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070604151048.GA30128@linux-mips.org>
References: <20070605.000239.31638706.anemo@mba.ocn.ne.jp>
	<20070604151048.GA30128@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 4 Jun 2007 16:10:48 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> I think we can simply drop the entire watchpoint support.  This was
> only ever working on R4000/R4400 and even there only somewhat useful
> for kernel debugging.  So if we ever use watchpoint support I think
> something needs to be developed from scratch.

OK, then this is an alternative patch to drop them.


Subject: [PATCH] Remove unused watchpoint support and arch/mips/lib-{32,64}

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied after "[PATCH] Unify dump_tlb".

 arch/mips/Makefile        |    2 -
 arch/mips/kernel/proc.c   |    1 -
 arch/mips/kernel/traps.c  |    1 -
 arch/mips/lib-32/Makefile |    5 ---
 arch/mips/lib-32/watch.S  |   60 ---------------------------------------------
 arch/mips/lib-64/Makefile |    5 ---
 arch/mips/lib-64/watch.S  |   57 ------------------------------------------
 include/asm-mips/watch.h  |   35 --------------------------
 8 files changed, 0 insertions(+), 166 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2b19605..fdade85 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -633,8 +633,6 @@ CPPFLAGS_vmlinux.lds := \
 head-y := arch/mips/kernel/head.o arch/mips/kernel/init_task.o
 
 libs-y			+= arch/mips/lib/
-libs-$(CONFIG_32BIT)	+= arch/mips/lib-32/
-libs-$(CONFIG_64BIT)	+= arch/mips/lib-64/
 
 core-y			+= arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/
 
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 5ddc2e9..eb7730d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -14,7 +14,6 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
-#include <asm/watch.h>
 
 unsigned int vced_count, vcei_count;
 
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index a7a17eb..5de0734 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -39,7 +39,6 @@
 #include <asm/traps.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
-#include <asm/watch.h>
 #include <asm/types.h>
 #include <asm/stacktrace.h>
 
diff --git a/arch/mips/lib-32/Makefile b/arch/mips/lib-32/Makefile
deleted file mode 100644
index 7bae849..0000000
--- a/arch/mips/lib-32/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for MIPS-specific library files..
-#
-
-lib-y	+= watch.o
diff --git a/arch/mips/lib-32/watch.S b/arch/mips/lib-32/watch.S
deleted file mode 100644
index 808b3af..0000000
--- a/arch/mips/lib-32/watch.S
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Kernel debug stuff to use the Watch registers.
- * Useful to find stack overflows, dangling pointers etc.
- *
- * Copyright (C) 1995, 1996, 1999 by Ralf Baechle
- */
-#include <asm/asm.h>
-#include <asm/mipsregs.h>
-#include <asm/regdef.h>
-
-		.set	noreorder
-/*
- * Parameter: a0 - logic address to watch
- *                 Currently only KSEG0 addresses are allowed!
- *            a1 - set bit #1 to trap on load references
- *                     bit #0 to trap on store references
- * Results  : none
- */
-		LEAF(__watch_set)
-		li	t0, 0x80000000
-		subu	a0, t0
-		ori	a0, 7
-		xori	a0, 7
-		or	a0, a1
-		mtc0	a0, CP0_WATCHLO
-		sw	a0, watch_savelo
-
-		jr	ra
-		 mtc0	zero, CP0_WATCHHI
-		END(__watch_set)
-
-/*
- * Parameter: none
- * Results  : none
- */
-		LEAF(__watch_clear)
-		jr	ra
-		 mtc0	zero, CP0_WATCHLO
-		END(__watch_clear)
-
-/*
- * Parameter: none
- * Results  : none
- */
-		LEAF(__watch_reenable)
-		lw	t0, watch_savelo
-		jr	ra
-		 mtc0	t0, CP0_WATCHLO
-		END(__watch_reenable)
-
-/*
- * Saved value of the c0_watchlo register for watch_reenable()
- */
-		.data
-watch_savelo:	.word	0
-		.text
diff --git a/arch/mips/lib-64/Makefile b/arch/mips/lib-64/Makefile
deleted file mode 100644
index 7bae849..0000000
--- a/arch/mips/lib-64/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for MIPS-specific library files..
-#
-
-lib-y	+= watch.o
diff --git a/arch/mips/lib-64/watch.S b/arch/mips/lib-64/watch.S
deleted file mode 100644
index f914340..0000000
--- a/arch/mips/lib-64/watch.S
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Kernel debug stuff to use the Watch registers.
- * Useful to find stack overflows, dangling pointers etc.
- *
- * Copyright (C) 1995, 1996, 1999, 2001 by Ralf Baechle
- */
-#include <asm/asm.h>
-#include <asm/mipsregs.h>
-#include <asm/regdef.h>
-
-		.set	noreorder
-/*
- * Parameter: a0 - physical address to watch
- *            a1 - set bit #1 to trap on load references
- *                     bit #0 to trap on store references
- * Results  : none
- */
-		LEAF(__watch_set)
-		ori	a0, 7
-		xori	a0, 7
-		or	a0, a1
-		mtc0	a0, CP0_WATCHLO
-		sd	a0, watch_savelo
-		dsrl32	a0, a0, 0
-
-		jr	ra
-		 mtc0	zero, CP0_WATCHHI
-		END(__watch_set)
-
-/*
- * Parameter: none
- * Results  : none
- */
-		LEAF(__watch_clear)
-		jr	ra
-		 mtc0	zero, CP0_WATCHLO
-		END(__watch_clear)
-
-/*
- * Parameter: none
- * Results  : none
- */
-		LEAF(__watch_reenable)
-		ld	t0, watch_savelo
-		jr	ra
-		 mtc0	t0, CP0_WATCHLO
-		END(__watch_reenable)
-
-/*
- * Saved value of the c0_watchlo register for watch_reenable()
- */
-		.local	watch_savelo
-		.comm	watch_savelo, 8, 8
diff --git a/include/asm-mips/watch.h b/include/asm-mips/watch.h
deleted file mode 100644
index 6aa90ca..0000000
--- a/include/asm-mips/watch.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1996, 1997, 1998, 2000, 2001 by Ralf Baechle
- */
-#ifndef _ASM_WATCH_H
-#define _ASM_WATCH_H
-
-#include <linux/linkage.h>
-
-/*
- * Types of reference for watch_set()
- */
-enum wref_type {
-	wr_save = 1,
-	wr_load = 2
-};
-
-extern asmlinkage void __watch_set(unsigned long addr, enum wref_type ref);
-extern asmlinkage void __watch_clear(void);
-extern asmlinkage void __watch_reenable(void);
-
-#define watch_set(addr, ref)					\
-	if (cpu_has_watch)					\
-		__watch_set(addr, ref)
-#define watch_clear()						\
-	if (cpu_has_watch)					\
-		__watch_clear()
-#define watch_reenable()					\
-	if (cpu_has_watch)					\
-		__watch_reenable()
-
-#endif /* _ASM_WATCH_H */
