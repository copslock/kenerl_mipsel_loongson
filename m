Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g12DB2P03760
	for linux-mips-outgoing; Sat, 2 Feb 2002 05:11:02 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g12DAhd03748
	for <linux-mips@oss.sgi.com>; Sat, 2 Feb 2002 05:10:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA24037;
	Sat, 2 Feb 2002 13:09:48 +0100 (MET)
Date: Sat, 2 Feb 2002 13:09:47 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
cc: jgg@debian.org
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.GSO.3.96.1020201130541.26449E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1020202123717.22822D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 1 Feb 2002, Maciej W. Rozycki wrote:

>  Well, after looking at the Alpha Architecture Handbook I see "mb" and
> "wmb" are pure ordering barriers -- any transactions at the CPU bus (pins)
> may still be deferred or prefetched (architecturally -- can't comment on
> specific chips).  So after all, maybe all the macros should be purely
> "sync" for MIPS ("" for MIPS I, and mb() equal to wbflush() for R3220 and
> similar setups) and anything that wants to see all writes actually
> committed should use wbflush(), which would be defined as "mb();
> uncached_read();" (or in a system-specific way, for R3220, etc.)?
> 
>  The i386 implementation seems stronger than it should be, but that's
> probably because of the limited choice available. 
> 
>  Any thoughts?

 Well, I've seen no thoughts so far. :-(  Anyway here is a new patch,
which takes my considerations about a synchronization vs a write
commitment into account.  This implementation only assures the absolute
minimum specified in the operations. 

 I am also tempted to add "#define iob() wbflush()" to system.h and
attempt to define the macro for other architectures as well.  The intended
semantics is to assure all preceding transactions arrived at a system bus
and none of following ones were started yet.  The "system bus" here is
defined: "the bus that connects the bus controller of a CPU (whether
internal to the chip or not) to the rest of a system." 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020111-mb-wb-1
diff -up --recursive --new-file linux-mips-2.4.17-20020111.macro/arch/mips/config.in linux-mips-2.4.17-20020111/arch/mips/config.in
--- linux-mips-2.4.17-20020111.macro/arch/mips/config.in	Mon Jan  7 05:27:13 2002
+++ linux-mips-2.4.17-20020111/arch/mips/config.in	Sat Jan 26 02:35:35 2002
@@ -363,6 +363,12 @@ else
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
diff -up --recursive --new-file linux-mips-2.4.17-20020111.macro/include/asm-mips/system.h linux-mips-2.4.17-20020111/include/asm-mips/system.h
--- linux-mips-2.4.17-20020111.macro/include/asm-mips/system.h	Thu Dec 13 05:28:09 2001
+++ linux-mips-2.4.17-20020111/include/asm-mips/system.h	Sat Feb  2 00:05:19 2002
@@ -167,32 +167,31 @@ extern void __global_restore_flags(unsig
 #define local_irq_disable()	__cli();
 #define local_irq_enable()	__sti();
 
-/*
- * These are probably defined overly paranoid ...
- */
+#ifdef CONFIG_CPU_HAS_SYNC
+#define __sync()	__asm__ __volatile__("sync" : : : "memory")
+#else
+#define __sync()	do { } while(0)
+#endif
+
+#define fast_wmb()	__sync()
+#define fast_rmb()	__sync()
+#define fast_mb()	__sync()
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
+
+#else /* !CONFIG_CPU_HAS_WB */
+
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		fast_mb()
+
+#endif /* !CONFIG_CPU_HAS_WB */
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
diff -up --recursive --new-file linux-mips-2.4.17-20020111.macro/include/asm-mips/wbflush.h linux-mips-2.4.17-20020111/include/asm-mips/wbflush.h
--- linux-mips-2.4.17-20020111.macro/include/asm-mips/wbflush.h	Fri Sep  7 04:26:33 2001
+++ linux-mips-2.4.17-20020111/include/asm-mips/wbflush.h	Sat Feb  2 00:05:21 2002
@@ -6,28 +6,49 @@
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
+#include <asm/addrspace.h>
+#include <asm/system.h>
 
-#define wbflush() __wbflush()
+#define __fast_wbflush()		\
+	__asm__ __volatile__(		\
+		".set	push\n\t"	\
+		".set	noreorder\n\t"	\
+		"lw	$0,%0\n\t"	\
+		"nop\n\t"		\
+		".set	pop"		\
+		: /* no output */	\
+		: "m" (*(int *)KSEG1)	\
+		: "memory")
+
+#define fast_wbflush()			\
+	do {				\
+		fast_mb();		\
+		__fast_wbflush();	\
+	} while (0)
+
+
+#ifdef CONFIG_CPU_HAS_WB
+
+extern void (*__wbflush)(void);
+
+#define wbflush()			\
+	do {				\
+		fast_mb();		\
+		__wbflush();		\
+	} while (0)
 
-#else
-/*
- * we don't need no stinkin' wbflush
- */
+#else /* !CONFIG_CPU_HAS_WB */
 
-#define wbflush()  do { } while(0)
+#define wbflush() fast_wbflush()
 
-#endif
+#endif /* !CONFIG_CPU_HAS_WB */
 
 extern void wbflush_setup(void);
 
