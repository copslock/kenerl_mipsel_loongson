Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g14DBCP08384
	for linux-mips-outgoing; Mon, 4 Feb 2002 05:11:12 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g14DAgA08143
	for <linux-mips@oss.sgi.com>; Mon, 4 Feb 2002 05:10:42 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA11331;
	Mon, 4 Feb 2002 13:10:25 +0100 (MET)
Date: Mon, 4 Feb 2002 13:10:25 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: [patch] linux 2.4.17: The second mb() rework
Message-ID: <Pine.GSO.3.96.1020204130305.5750D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 Here is the second version of the mb() approach again.  It adds iob() as
the strongest barrier, implying committing all writes to the CPU bus.  I
consider this version final.

 Any objections (barring "sync" workarounds we may consider later)? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020129-mb-wb-5
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/arch/mips/config.in linux-mips-2.4.17-20020129/arch/mips/config.in
--- linux-mips-2.4.17-20020129.macro/arch/mips/config.in	Fri Jan 25 05:26:34 2002
+++ linux-mips-2.4.17-20020129/arch/mips/config.in	Mon Feb  4 00:07:13 2002
@@ -384,6 +384,12 @@ else
       fi
    fi
 fi
+if [ "$CONFIG_CPU_R3000" = "y" -o \
+     "$CONFIG_CPU_TX39XX" = "y" ]; then
+   define_bool CONFIG_CPU_HAS_SYNC n
+else
+   define_bool CONFIG_CPU_HAS_SYNC y
+fi
 endmenu
 
 mainmenu_option next_comment
diff -up --recursive --new-file linux-mips-2.4.17-20020129.macro/include/asm-mips/system.h linux-mips-2.4.17-20020129/include/asm-mips/system.h
--- linux-mips-2.4.17-20020129.macro/include/asm-mips/system.h	Sun Jan 27 05:27:59 2002
+++ linux-mips-2.4.17-20020129/include/asm-mips/system.h	Mon Feb  4 02:10:33 2002
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
@@ -166,32 +169,57 @@ extern void __global_restore_flags(unsig
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
