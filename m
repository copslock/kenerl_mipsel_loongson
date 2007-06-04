Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2007 16:03:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:44747 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022410AbXFDPDc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 Jun 2007 16:03:32 +0100
Received: from localhost (p3180-ipad201funabasi.chiba.ocn.ne.jp [222.146.66.180])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C17B2A64F; Tue,  5 Jun 2007 00:02:09 +0900 (JST)
Date:	Tue, 05 Jun 2007 00:02:39 +0900 (JST)
Message-Id: <20070605.000239.31638706.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Unify watch.S and remove arch/mips/lib-{32,64}
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 15233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Unify lib-{32,64}/watch.S into lib/watch.S and remove lib-{32,64}
completely.

The old 64-bit __watch_set() expected an physical address and the old
32-bit __watch_set() expected a KSEG0 virtual address.  The new
unified __watch_set() is based on the 64-bit one.  Since there is no
real user of the __watch_set(), this incompatibility would not cause
any problem.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch can be applied after "[PATCH] Unify dump_tlb".

 arch/mips/Makefile                |    2 -
 arch/mips/lib-32/Makefile         |    5 ---
 arch/mips/lib-32/watch.S          |   60 -------------------------------------
 arch/mips/lib-64/Makefile         |    5 ---
 arch/mips/lib/Makefile            |    2 +-
 arch/mips/{lib-64 => lib}/watch.S |   16 +++++-----
 6 files changed, 9 insertions(+), 81 deletions(-)

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
diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index b27a326..ccf0f2e 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -3,7 +3,7 @@
 #
 
 lib-y	+= csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o uncached.o
+	   strncpy_user.o strnlen_user.o uncached.o watch.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
diff --git a/arch/mips/lib/watch.S b/arch/mips/lib/watch.S
new file mode 100644
index 0000000..591a73f
--- /dev/null
+++ b/arch/mips/lib/watch.S
@@ -0,0 +1,57 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Kernel debug stuff to use the Watch registers.
+ * Useful to find stack overflows, dangling pointers etc.
+ *
+ * Copyright (C) 1995, 1996, 1999, 2001 by Ralf Baechle
+ */
+#include <asm/asm.h>
+#include <asm/mipsregs.h>
+#include <asm/regdef.h>
+
+		.set	noreorder
+/*
+ * Parameter: a0 - physical address to watch
+ *            a1 - set bit #1 to trap on load references
+ *                     bit #0 to trap on store references
+ * Results  : none
+ */
+		LEAF(__watch_set)
+		ori	a0, 7
+		xori	a0, 7
+		or	a0, a1
+		MTC0	a0, CP0_WATCHLO
+		LONG_S	a0, watch_savelo
+
+		jr	ra
+		 mtc0	zero, CP0_WATCHHI
+		END(__watch_set)
+
+/*
+ * Parameter: none
+ * Results  : none
+ */
+		LEAF(__watch_clear)
+		jr	ra
+		 MTC0	zero, CP0_WATCHLO
+		END(__watch_clear)
+
+/*
+ * Parameter: none
+ * Results  : none
+ */
+		LEAF(__watch_reenable)
+		LONG_L	t0, watch_savelo
+		jr	ra
+		 MTC0	t0, CP0_WATCHLO
+		END(__watch_reenable)
+
+/*
+ * Saved value of the c0_watchlo register for watch_reenable()
+ */
+		.data
+watch_savelo:	LONG	0
+		.text
