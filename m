Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UFvDY28440
	for linux-mips-outgoing; Wed, 30 Jan 2002 07:57:13 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UFuhd28434
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 07:56:43 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA08257;
	Wed, 30 Jan 2002 15:56:15 +0100 (MET)
Date: Wed, 30 Jan 2002 15:56:14 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.17: An mb() rework
Message-ID: <Pine.GSO.3.96.1020130151155.2880D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

 The current implementation of mb() and friends is broken.  It depends on
a model-specific behaviour of the R4000/R4400 CPU and does not guarantee
preserving the desired semantics over the whole MIPS family.  What's
worse, recently I've identified a case it doesn't work at all on an
R4400SC CPU -- values written to an i/o memory resource were not committed
to the device even after executing over 40 subsequent instructions. 

 Here is a patch that implements mb() in an "architecturally defined" way. 
Since "sync" acts as a reordering barrier and an uncached load cannot be
prefetched or postponed, this implementation assures a correct
serialization on every MIPS processor, regardless of its implementation
details. 

 For MIPS I CPUs, which do not support the "sync" instruction, a lone
uncached load is defined to provide a serialization itself, thus the
implementation is correct for these CPUs as well. 

 The patch looks more complicated than it should, but it's a part of a
wbflush() clean-up and a few of these helper submacros are really needed
(and others are defined for consistency).

 Tested successfully on an R3400 and an R4400SC CPU on DECstation systems. 

 If anyone has any comments, then please speak up.  Otherwise, Ralf,
please apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.17-20020111-mb-4
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
+++ linux-mips-2.4.17-20020111/include/asm-mips/system.h	Wed Jan 30 02:17:18 2002
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
@@ -170,27 +173,57 @@ extern void __global_restore_flags(unsig
 /*
  * These are probably defined overly paranoid ...
  */
+#ifdef CONFIG_CPU_HAS_SYNC
+#define __sync()	__asm__ __volatile__("sync" : : : "memory")
+#else
+#define __sync()	do { } while(0)
+#endif
+
+#define __fast_wmb()	do { } while(0)
+#define __fast_rmb()			\
+	__asm__ __volatile__(		\
+		".set	push\n\t"	\
+		".set	noreorder\n\t"	\
+		"lw	$0,%0\n\t"	\
+		"nop\n\t"		\
+		".set	pop"		\
+		: /* no output */	\
+		: "m" (*(int *)KSEG1)	\
+		: "memory")
+#define __fast_mb()	__fast_rmb()
+
+#define fast_wmb()			\
+	do {				\
+		__sync();		\
+		__fast_wmb();		\
+	} while (0)
+#define fast_rmb()			\
+	do {				\
+		__sync();		\
+		__fast_rmb();		\
+	} while (0)
+#define fast_mb()			\
+	do {				\
+		__sync();		\
+		__fast_mb();		\
+	} while (0)
+
 #ifdef CONFIG_CPU_HAS_WB
 
 #include <asm/wbflush.h>
-#define rmb()	do { } while(0)
-#define wmb()	wbflush()
-#define mb()	wbflush()
+#define wmb()		fast_wmb()
+#define rmb()				\
+	do {				\
+		__sync();		\
+		wbflush();		\
+	} while (0)
+#define mb()		rmb()
 
 #else /* CONFIG_CPU_HAS_WB  */
 
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
+#define wmb()		fast_wmb()
+#define rmb()		fast_rmb()
+#define mb()		fast_mb()
 
 #endif /* CONFIG_CPU_HAS_WB  */
 
