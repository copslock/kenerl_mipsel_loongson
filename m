Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53GianC001954
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 09:44:36 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53Giaas001953
	for linux-mips-outgoing; Mon, 3 Jun 2002 09:44:36 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53Gi2nC001949
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 09:44:03 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA19600;
	Mon, 3 Jun 2002 18:45:51 +0200 (MET DST)
Date: Mon, 3 Jun 2002 18:45:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: mb() and friends again
Message-ID: <Pine.GSO.3.96.1020603182621.14451E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 There was a discussion some time ago upon my proposal of a clean-up of
mb() and related macros.  The conclusion was a rewrite is desireable, but
the patch wasn't accepted and no alternative was proposed.

 The need for the update is more and more crucial for me as I have more
and more code to apply to the tree that needs the macros be set somehow. 
If there is a design flaw, I'd like to know of it, if there is an
implementation problem, I'm willing to fix it.  I'm aware about peripheral
bus-specific coherency problems -- the patch is orthogonal to them and
only addresses the host bus.

 Here is an updated version I'm using currently.  It's fixed to apply
against the current tree and adds <asm-mips64/wbflush.h> for source code
compatibility.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.18-20020530-mb-wb-8
diff -up --recursive --new-file linux-mips-2.4.18-20020530.macro/arch/mips/config.in linux-mips-2.4.18-20020530/arch/mips/config.in
--- linux-mips-2.4.18-20020530.macro/arch/mips/config.in	2002-05-30 02:57:35.000000000 +0000
+++ linux-mips-2.4.18-20020530/arch/mips/config.in	2002-06-02 15:51:03.000000000 +0000
@@ -393,6 +393,11 @@ else
       fi
    fi
 fi
+if [ "$CONFIG_CPU_R3000" = "y" ]; then
+   define_bool CONFIG_CPU_HAS_SYNC n
+else
+   define_bool CONFIG_CPU_HAS_SYNC y
+fi
 endmenu
 
 mainmenu_option next_comment
diff -up --recursive --new-file linux-mips-2.4.18-20020530.macro/include/asm-mips/system.h linux-mips-2.4.18-20020530/include/asm-mips/system.h
--- linux-mips-2.4.18-20020530.macro/include/asm-mips/system.h	2002-05-28 10:13:21.000000000 +0000
+++ linux-mips-2.4.18-20020530/include/asm-mips/system.h	2002-06-02 15:51:03.000000000 +0000
@@ -18,9 +18,12 @@
 
 #include <linux/config.h>
 #include <asm/sgidefs.h>
-#include <asm/ptrace.h>
+
 #include <linux/kernel.h>
 
+#include <asm/addrspace.h>
+#include <asm/ptrace.h>
+
 __asm__ (
 	".macro\t__sti\n\t"
 	".set\tpush\n\t"
@@ -166,32 +169,58 @@ extern void __global_restore_flags(unsig
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
 
-/*
- * These are probably defined overly paranoid ...
- */
+#ifdef CONFIG_CPU_HAS_SYNC
+#define __sync()				\
+	__asm__ __volatile__(			\
+		".set	push\n\t"		\
+		".set	noreorder\n\t"		\
+		".set	mips2\n\t"		\
+		"sync\n\t"			\
+		".set	pop"			\
+		: /* no output */		\
+		: /* no input */		\
+		: "memory")
+#else
+#define __sync()	do { } while(0)
+#endif
+
+#define __fast_iob()				\
+	__asm__ __volatile__(			\
+		".set	push\n\t"		\
+		".set	noreorder\n\t"		\
+		"lw	$0,%0\n\t"		\
+		"nop\n\t"			\
+		".set	pop"			\
+		: /* no output */		\
+		: "m" (*(int *)KSEG1)		\
+		: "memory")
+
+#define fast_wmb()	__sync()
+#define fast_rmb()	__sync()
+#define fast_mb()	__sync()
+#define fast_iob()				\
+	do {					\
+		__sync();			\
+		__fast_iob();			\
+	} while (0)
+
 #ifdef CONFIG_CPU_HAS_WB
 
 #include <asm/wbflush.h>
-#define rmb()	do { } while(0)
-#define wmb()	wbflush()
-#define mb()	wbflush()
-
-#else /* CONFIG_CPU_HAS_WB  */
-
-#define mb()						\
-__asm__ __volatile__(					\
-	"# prevent instructions being moved around\n\t"	\
-	".set\tnoreorder\n\t"				\
-	"# 8 nops to fool the R4400 pipeline\n\t"	\
-	"nop;nop;nop;nop;nop;nop;nop;nop\n\t"		\
-	".set\treorder"					\
-	: /* no output */				\
-	: /* no input */				\
-	: "memory")
-#define rmb() mb()
-#define wmb() mb()
 
-#endif /* CONFIG_CPU_HAS_WB  */
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		wbflush();
+#define iob()		wbflush();
+
+#else /* !CONFIG_CPU_HAS_WB */
+
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		fast_mb()
+#define iob()		fast_iob()
+
+#endif /* !CONFIG_CPU_HAS_WB */
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
diff -up --recursive --new-file linux-mips-2.4.18-20020530.macro/include/asm-mips/wbflush.h linux-mips-2.4.18-20020530/include/asm-mips/wbflush.h
--- linux-mips-2.4.18-20020530.macro/include/asm-mips/wbflush.h	2001-09-07 04:26:33.000000000 +0000
+++ linux-mips-2.4.18-20020530/include/asm-mips/wbflush.h	2002-02-04 02:52:11.000000000 +0000
@@ -6,29 +6,30 @@
  * for more details.
  *
  * Copyright (c) 1998 Harald Koerfgen
+ * Copyright (C) 2002 Maciej W. Rozycki
  */
 #ifndef __ASM_MIPS_WBFLUSH_H
 #define __ASM_MIPS_WBFLUSH_H
 
 #include <linux/config.h>
 
-#if defined(CONFIG_CPU_HAS_WB)
-/*
- * R2000 or R3000
- */
-extern void (*__wbflush) (void);
+#ifdef CONFIG_CPU_HAS_WB
 
-#define wbflush() __wbflush()
+extern void (*__wbflush)(void);
+extern void wbflush_setup(void);
 
-#else
-/*
- * we don't need no stinkin' wbflush
- */
+#define wbflush()			\
+	do {				\
+		__sync();		\
+		__wbflush();		\
+	} while (0)
 
-#define wbflush()  do { } while(0)
+#else /* !CONFIG_CPU_HAS_WB */
 
-#endif
+#define wbflush_setup() do { } while (0)
 
-extern void wbflush_setup(void);
+#define wbflush() fast_iob()
+
+#endif /* !CONFIG_CPU_HAS_WB */
 
 #endif /* __ASM_MIPS_WBFLUSH_H */
diff -up --recursive --new-file linux-mips-2.4.18-20020530.macro/include/asm-mips64/system.h linux-mips-2.4.18-20020530/include/asm-mips64/system.h
--- linux-mips-2.4.18-20020530.macro/include/asm-mips64/system.h	2002-05-28 10:13:22.000000000 +0000
+++ linux-mips-2.4.18-20020530/include/asm-mips64/system.h	2002-06-02 15:55:32.000000000 +0000
@@ -12,9 +12,12 @@
 
 #include <linux/config.h>
 #include <asm/sgidefs.h>
-#include <asm/ptrace.h>
+
 #include <linux/kernel.h>
 
+#include <asm/addrspace.h>
+#include <asm/ptrace.h>
+
 __asm__ (
 	".macro\t__sti\n\t"
 	".set\tpush\n\t"
@@ -161,20 +164,37 @@ extern void __global_restore_flags(unsig
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()
 
-/*
- * These are probably defined overly paranoid ...
- */
-#define mb()						\
-__asm__ __volatile__(					\
-	"# prevent instructions being moved around\n\t"	\
-	".set\tnoreorder\n\t"				\
-	"sync\n\t"					\
-	".set\treorder"					\
-	: /* no output */				\
-	: /* no input */				\
-	: "memory")
-#define rmb() mb()
-#define wmb() mb()
+#define __sync()				\
+	__asm__ __volatile__(			\
+		".set	push\n\t"		\
+		".set	noreorder\n\t"		\
+		"sync\n\t"			\
+		".set	pop"			\
+		: /* no output */		\
+		: /* no input */		\
+		: "memory")
+
+#define fast_wmb()	__sync()
+#define fast_rmb()	__sync()
+#define fast_mb()	__sync()
+#define fast_iob()				\
+	do {					\
+		__sync();			\
+		__asm__ __volatile__(		\
+			".set	push\n\t"	\
+			".set	noreorder\n\t"	\
+			"lw	$0,%0\n\t"	\
+			"nop\n\t"		\
+			".set	pop"		\
+			: /* no output */	\
+			: "m" (*(int *)KSEG1)	\
+			: "memory");		\
+	} while (0)
+
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		fast_mb()
+#define iob()		fast_iob()
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
diff -up --recursive --new-file linux-mips-2.4.18-20020530.macro/include/asm-mips64/wbflush.h linux-mips-2.4.18-20020530/include/asm-mips64/wbflush.h
--- linux-mips-2.4.18-20020530.macro/include/asm-mips64/wbflush.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-mips-2.4.18-20020530/include/asm-mips64/wbflush.h	2002-05-31 11:43:50.000000000 +0000
@@ -0,0 +1,18 @@
+/*
+ * Header file for using the wbflush routine
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (c) 1998 Harald Koerfgen
+ * Copyright (C) 2002 Maciej W. Rozycki
+ */
+#ifndef __ASM_MIPS64_WBFLUSH_H
+#define __ASM_MIPS64_WBFLUSH_H
+
+#define wbflush_setup() do { } while (0)
+
+#define wbflush() fast_iob()
+
+#endif /* __ASM_MIPS64_WBFLUSH_H */
