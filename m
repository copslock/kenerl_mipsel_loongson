Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g38H6e8d031043
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Apr 2002 10:06:40 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g38H6ewB031042
	for linux-mips-outgoing; Mon, 8 Apr 2002 10:06:40 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g38H6B8d031036
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:06:11 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02773
	for <linux-mips@oss.sgi.com>; Mon, 8 Apr 2002 10:06:45 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA08007;
	Mon, 8 Apr 2002 18:37:30 +0200 (MET DST)
Date: Mon, 8 Apr 2002 18:37:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux: A correct implementation of barriers
Message-ID: <Pine.GSO.3.96.1020408182445.26107G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is the barrier patch again.  It was discussed quite extensively a
few weeks ago.  It makes rmb(), wmb() and mb() use sync as needed (Tx39xx
included) and take writeback buffers into account (no Tx39xx code here --
someone interested in such a system should add it).  It also adds iob() 
for code that needs to assure not only the order of the preceding and the
following operations but also the completion of the preceding ones as well
(from the CPU's point of view). 

 Please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020129-mb-wb-6
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/arch/mips/config.in linux-mips-2.4.17-20020129/arch/mips/config.in
--- linux-mips-2.4.17-20020129.macro/arch/mips/config.in	Fri Jan 25 05:26:34 2002
+++ linux-mips-2.4.17-20020129/arch/mips/config.in	Thu Feb 21 21:31:42 2002
@@ -384,6 +384,11 @@ else
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
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/include/asm-mips/system.h linux-mips-2.4.17-20020129/include/asm-mips/system.h
--- linux-mips-2.4.17-20020129.macro/include/asm-mips/system.h	Sun Jan 27 05:27:59 2002
+++ linux-mips-2.4.17-20020129/include/asm-mips/system.h	Thu Feb 21 21:33:54 2002
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
 #define local_irq_disable()	__cli();
 #define local_irq_enable()	__sti();
 
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
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/include/asm-mips/wbflush.h linux-mips-2.4.17-20020129/include/asm-mips/wbflush.h
--- linux-mips-2.4.17-20020129.macro/include/asm-mips/wbflush.h	Fri Sep  7 04:26:33 2001
+++ linux-mips-2.4.17-20020129/include/asm-mips/wbflush.h	Mon Feb  4 02:52:11 2002
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
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/include/asm-mips64/system.h linux-mips-2.4.17-20020129/include/asm-mips64/system.h
--- linux-mips-2.4.17-20020129.macro/include/asm-mips64/system.h	Sun Jan 27 05:27:59 2002
+++ linux-mips-2.4.17-20020129/include/asm-mips64/system.h	Mon Feb  4 02:12:27 2002
@@ -11,12 +11,13 @@
 #define _ASM_SYSTEM_H
 
 #include <linux/config.h>
-
 #include <asm/sgidefs.h>
-#include <asm/ptrace.h>
 
 #include <linux/kernel.h>
 
+#include <asm/addrspace.h>
+#include <asm/ptrace.h>
+
 __asm__ (
 	".macro\t__sti\n\t"
 	".set\tpush\n\t"
@@ -163,20 +164,32 @@ extern void __global_restore_flags(unsig
 #define local_irq_disable()	__cli();
 #define local_irq_enable()	__sti();
 
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
+#define wmb()		__sync()
+#define rmb()		__sync()
+#define mb()		__sync()
+#define iob()					\
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
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
