Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9UH3Yh30857
	for linux-mips-outgoing; Tue, 30 Oct 2001 09:03:34 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9UGx7030715
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 08:59:07 -0800
Received: from dea.linux-mips.net (a1as02-p234.stg.tli.de [195.252.185.234]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA00162
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 08:58:36 -0800 (PST)
	mail_from (ralf@linux-mips.net)
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9UEtXZ32020;
	Tue, 30 Oct 2001 15:55:33 +0100
Date: Tue, 30 Oct 2001 15:55:33 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Alice Hennessy <ahennessy@mvista.com>,
   Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, ajob4me@21cn.com,
   linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
Message-ID: <20011030155533.A28550@dea.linux-mips.net>
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp> <20011026.225806.63990588.nemoto@toshiba-tops.co.jp> <20011029.160225.59648095.nemoto@toshiba-tops.co.jp> <3BDD140E.432D795B@mips.com> <3BDDF193.B6405A7F@mvista.com> <3BDE62B4.BE7A1885@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDE62B4.BE7A1885@mips.com>; from carstenl@mips.com on Tue, Oct 30, 2001 at 09:20:04AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Oct 30, 2001 at 09:20:04AM +0100, Carsten Langgaard wrote:

> You are right, you don't need to set the CU1 bit for the emulator to kick-in
> (you just need a coprocessor unusable exception), sorry my mistake.
> So generally I think we should use the check against a FPU present
> (mips_cpu.options & MIPS_CPU_FPU), instead of the TX39XX specific fix.

So here is a preliminiary version of my patch.  Still untested and needs
to be applied to mips64 also.

  Ralf

Index: arch/mips/kernel/process.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/process.c,v
retrieving revision 1.31
diff -u -r1.31 process.c
--- arch/mips/kernel/process.c 2001/10/19 01:23:37 1.31  
+++ arch/mips/kernel/process.c 2001/10/30 14:46:30   
@@ -56,8 +56,8 @@
 void exit_thread(void)
 {
 	/* Forget lazy fpu state */
-	if (last_task_used_math == current) {
-		set_cp0_status(ST0_CU1);
+	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
+		__enable_fpu();
 		__asm__ __volatile__("cfc1\t$0,$31");
 		last_task_used_math = NULL;
 	}
@@ -66,8 +66,8 @@
 void flush_thread(void)
 {
 	/* Forget lazy fpu state */
-	if (last_task_used_math == current) {
-		set_cp0_status(ST0_CU1);
+	if (last_task_used_math == current && mips_cpu.options & MIPS_CPU_FPU) {
+		__enable_fpu();
 		__asm__ __volatile__("cfc1\t$0,$31");
 		last_task_used_math = NULL;
 	}
@@ -85,7 +85,7 @@
 
 	if (last_task_used_math == current)
 		if (mips_cpu.options & MIPS_CPU_FPU) {
-			set_cp0_status(ST0_CU1);
+			__enable_fpu();
 			save_fp(p);
 		}
 	/* set up new TSS. */
Index: arch/mips/kernel/ptrace.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/ptrace.c,v
retrieving revision 1.32
diff -u -r1.32 ptrace.c
--- arch/mips/kernel/ptrace.c 2001/10/19 01:23:37 1.32  
+++ arch/mips/kernel/ptrace.c 2001/10/30 14:46:30   
@@ -20,7 +20,6 @@
 #include <linux/smp_lock.h>
 #include <linux/user.h>
 
-#include <asm/fp.h>
 #include <asm/mipsregs.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -126,9 +125,9 @@
 						child->thread.fpu.soft.regs;
 				} else 
 					if (last_task_used_math == child) {
-						enable_cp1();
+						__enable_fpu();
 						save_fp(child);
-						disable_cp1();
+						__disable_fpu();
 						last_task_used_math = NULL;
 						regs->cp0_status &= ~ST0_CU1;
 					}
@@ -174,8 +173,13 @@
 		case FPC_EIR: {	/* implementation / version register */
 			unsigned int flags;
 
+			if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+				res = -EIO;
+				goto out;
+			}
+
 			__save_flags(flags);
-			enable_cp1();
+			__enable_fpu();
 			__asm__ __volatile__("cfc1\t%0,$0": "=r" (tmp));
 			__restore_flags(flags);
 			break;
@@ -217,9 +221,9 @@
 						fregs = (unsigned long long *)
 						child->thread.fpu.soft.regs;
 					} else {
-						enable_cp1();
+						__enable_fpu();
 						save_fp(child);
-						disable_cp1();
+						__disable_fpu();
 						last_task_used_math = NULL;
 						regs->cp0_status &= ~ST0_CU1;
 					}
Index: arch/mips/kernel/signal.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips/kernel/signal.c,v
retrieving revision 1.37
diff -u -r1.37 signal.c
--- arch/mips/kernel/signal.c 2001/10/19 01:23:37 1.37  
+++ arch/mips/kernel/signal.c 2001/10/30 14:46:30   
@@ -22,6 +22,7 @@
 
 #include <asm/asm.h>
 #include <asm/bitops.h>
+#include <asm/cpu.h>
 #include <asm/pgalloc.h>
 #include <asm/stackframe.h>
 #include <asm/uaccess.h>
@@ -355,7 +356,7 @@
 	err |= __put_user(owned_fp, &sc->sc_ownedfp);
 
 	if (current->used_math) {	/* fp is active.  */
-		set_cp0_status(ST0_CU1);
+		enable_fpu();
 		err |= save_fp_context(sc);
 		last_task_used_math = NULL;
 		regs->cp0_status &= ~ST0_CU1;
Index: arch/mips64/kernel/ptrace.c
===================================================================
RCS file: /home/pub/cvs/linux/arch/mips64/kernel/ptrace.c,v
retrieving revision 1.12
diff -u -r1.12 ptrace.c
--- arch/mips64/kernel/ptrace.c 2001/10/27 00:49:55 1.12  
+++ arch/mips64/kernel/ptrace.c 2001/10/30 14:46:33   
@@ -119,9 +119,9 @@
 
 #ifndef CONFIG_SMP
 				if (last_task_used_math == child) {
-					set_cp0_status(ST0_CU1);
+					__enable_fpu();
 					save_fp(child);
-					clear_cp0_status(ST0_CU1, 0);
+					__disable_fpu();
 					last_task_used_math = NULL;
 				}
 #endif
@@ -197,9 +197,9 @@
 			if (child->used_math) {
 #ifndef CONFIG_SMP
 				if (last_task_used_math == child) {
-					set_cp0_status(ST0_CU1);
+					__enable_fpu();
 					save_fp(child);
-					clear_cp0_status(ST0_CU1);
+					__disable_fpu(ST0_CU1);
 					last_task_used_math = NULL;
 					regs->cp0_status &= ~ST0_CU1;
 				}
Index: include/asm-mips/bootinfo.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/bootinfo.h,v
retrieving revision 1.37
diff -u -r1.37 bootinfo.h
--- include/asm-mips/bootinfo.h 2001/10/24 23:00:44 1.37  
+++ include/asm-mips/bootinfo.h 2001/10/30 14:46:46   
@@ -298,7 +298,6 @@
  * values in setup.c (or whereever suitable) so they are in
  * .data section
  */
-extern struct mips_cpu mips_cpu;
 extern unsigned long mips_machtype;
 extern unsigned long mips_machgroup;
 extern unsigned long mips_tlb_entries;
Index: include/asm-mips/cpu.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/cpu.h,v
retrieving revision 1.16
diff -u -r1.16 cpu.h
--- include/asm-mips/cpu.h 2001/10/26 21:28:47 1.16  
+++ include/asm-mips/cpu.h 2001/10/30 14:46:46   
@@ -111,6 +111,8 @@
 	struct cache_desc tcache;	/* Tertiary/split secondary cache */
 };
 
+extern struct mips_cpu mips_cpu;
+
 #endif
 
 /*
Index: include/asm-mips/fp.h
===================================================================
RCS file: fp.h
diff -N fp.h
--- include/asm-mips/fp.h Tue Oct 30 15:48:07 2001
+++ include/asm-mips/fp.h Tue May 5 22:32:27 1998
@@ -1,33 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998 by Ralf Baechle
- */
-
-/*
- * Activate and deactive the floatingpoint accelerator.
- */
-#define enable_cp1()							\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		".set\treorder\n\t"					\
-		"mfc0\t$1,$12\n\t"					\
-		"or\t$1,%0\n\t"						\
-		"mtc0\t$1,$12\n\t"					\
-		".set\tpop"						\
-		: : "r" (ST0_CU1));
-
-#define disable_cp1()							\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		".set\treorder\n\t"					\
-		"mfc0\t$1,$12\n\t"					\
-		"or\t$1,%0\n\t"						\
-		"xor\t$1,%0\n\t"					\
-		"mtc0\t$1,$12\n\t"					\
-		".set\tpop"						\
-		: : "r" (ST0_CU1));
Index: include/asm-mips/mipsregs.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/mipsregs.h,v
retrieving revision 1.26
diff -u -r1.26 mipsregs.h
--- include/asm-mips/mipsregs.h 2001/10/27 00:49:55 1.26  
+++ include/asm-mips/mipsregs.h 2001/10/30 14:46:46   
@@ -148,12 +148,15 @@
  */
 #include <linux/config.h>
 #ifdef CONFIG_CPU_VR41XX
+
 #define PM_1K   0x00000000
 #define PM_4K   0x00001800
 #define PM_16K  0x00007800
 #define PM_64K  0x0001f800
 #define PM_256K 0x0007f800
+
 #else
+
 #define PM_4K   0x00000000
 #define PM_16K  0x00006000
 #define PM_64K  0x0001e000
@@ -161,6 +164,7 @@
 #define PM_1M   0x001fe000
 #define PM_4M   0x007fe000
 #define PM_16M  0x01ffe000
+
 #endif
 
 /*
@@ -175,75 +179,6 @@
 #define PL_16M  24
 
 /*
- * Macros to access the system control coprocessor
- */
-#define read_32bit_cp0_register(source)                         \
-({ int __res;                                                   \
-        __asm__ __volatile__(                                   \
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-        "mfc0\t%0,"STR(source)"\n\t"                            \
-	".set\tpop"						\
-        : "=r" (__res));                                        \
-        __res;})
-
-#define read_32bit_cp0_set1_register(source)                    \
-({ int __res;                                                   \
-        __asm__ __volatile__(                                   \
-	".set\tpush\n\t"					\
-	".set\treorder\n\t"					\
-        "cfc0\t%0,"STR(source)"\n\t"                            \
-	".set\tpop"						\
-        : "=r" (__res));                                        \
-        __res;})
-
-/*
- * For now use this only with interrupts disabled!
- */
-#define read_64bit_cp0_register(source)                         \
-({ int __res;                                                   \
-        __asm__ __volatile__(                                   \
-        ".set\tmips3\n\t"                                       \
-        "dmfc0\t%0,"STR(source)"\n\t"                           \
-        ".set\tmips0"                                           \
-        : "=r" (__res));                                        \
-        __res;})
-
-#define write_32bit_cp0_register(register,value)                \
-        __asm__ __volatile__(                                   \
-        "mtc0\t%0,"STR(register)"\n\t"				\
-	"nop"							\
-        : : "r" (value));
-
-#define write_32bit_cp0_set1_register(register,value)           \
-        __asm__ __volatile__(                                   \
-        "ctc0\t%0,"STR(register)"\n\t"				\
-	"nop"							\
-        : : "r" (value));
-
-#define write_64bit_cp0_register(register,value)                \
-        __asm__ __volatile__(                                   \
-        ".set\tmips3\n\t"                                       \
-        "dmtc0\t%0,"STR(register)"\n\t"                         \
-        ".set\tmips0"                                           \
-        : : "r" (value))
-
-/* 
- * This should be changed when we get a compiler that support the MIPS32 ISA. 
- */
-#define read_mips32_cp0_config1()                               \
-({ int __res;                                                   \
-        __asm__ __volatile__(                                   \
-	".set\tnoreorder\n\t"                                   \
-	".set\tnoat\n\t"                                        \
-     	".word\t0x40018001\n\t"                                 \
-	"move\t%0,$1\n\t"                                       \
-	".set\tat\n\t"                                          \
-	".set\treorder"                                         \
-	:"=r" (__res));                                         \
-        __res;})
-
-/*
  * R4x00 interrupt enable / cause bits
  */
 #define IE_SW0          (1<< 8)
@@ -267,55 +202,6 @@
 #define C_IRQ4          (1<<14)
 #define C_IRQ5          (1<<15)
 
-#ifndef _LANGUAGE_ASSEMBLY
-/*
- * Manipulate the status register.
- * Mostly used to access the interrupt bits.
- */
-#define __BUILD_SET_CP0(name,register)				\
-extern inline unsigned int					\
-set_cp0_##name(unsigned int set)				\
-{								\
-	unsigned int res;					\
-								\
-	res = read_32bit_cp0_register(register);		\
-	res |= set;						\
-	write_32bit_cp0_register(register, res);		\
-								\
-	return res;						\
-}								\
-								\
-extern inline unsigned int					\
-clear_cp0_##name(unsigned int clear)				\
-{								\
-	unsigned int res;					\
-								\
-	res = read_32bit_cp0_register(register);		\
-	res &= ~clear;						\
-	write_32bit_cp0_register(register, res);		\
-								\
-	return res;						\
-}								\
-								\
-extern inline unsigned int					\
-change_cp0_##name(unsigned int change, unsigned int new)	\
-{								\
-	unsigned int res;					\
-								\
-	res = read_32bit_cp0_register(register);		\
-	res &= ~change;						\
-	res |= (new & change);					\
-	write_32bit_cp0_register(register, res);		\
-								\
-	return res;						\
-}
-
-__BUILD_SET_CP0(status,CP0_STATUS)
-__BUILD_SET_CP0(cause,CP0_CAUSE)
-__BUILD_SET_CP0(config,CP0_CONFIG)
-
-#endif /* defined (_LANGUAGE_ASSEMBLY) */
-
 /*
  * Bitfields in the R4xx0 cp0 status register
  */
@@ -547,5 +433,440 @@
 #define CEB_SUPERVISOR	4	/* Count events in supvervisor mode EXL = ERL = 0 */
 #define CEB_KERNEL	2	/* Count events in kernel mode EXL = ERL = 0 */
 #define CEB_EXL		1	/* Count events with EXL = 1, ERL = 0 */
+
+#ifndef _LANGUAGE_ASSEMBLY
+
+/*
+ * Macros to access the system control coprocessor
+ */
+#define read_32bit_cp0_register(source)                         \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+	".set\tpush\n\t"					\
+	".set\treorder\n\t"					\
+        "mfc0\t%0,"STR(source)"\n\t"                            \
+	".set\tpop"						\
+        : "=r" (__res));                                        \
+        __res;})
+
+#define read_32bit_cp0_set1_register(source)                    \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+	".set\tpush\n\t"					\
+	".set\treorder\n\t"					\
+        "cfc0\t%0,"STR(source)"\n\t"                            \
+	".set\tpop"						\
+        : "=r" (__res));                                        \
+        __res;})
+
+/*
+ * For now use this only with interrupts disabled!
+ */
+#define read_64bit_cp0_register(source)                         \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+        ".set\tmips3\n\t"                                       \
+        "dmfc0\t%0,"STR(source)"\n\t"                           \
+        ".set\tmips0"                                           \
+        : "=r" (__res));                                        \
+        __res;})
+
+#define write_32bit_cp0_register(register,value)                \
+        __asm__ __volatile__(                                   \
+        "mtc0\t%0,"STR(register)"\n\t"				\
+	"nop"							\
+        : : "r" (value));
+
+#define write_32bit_cp0_set1_register(register,value)           \
+        __asm__ __volatile__(                                   \
+        "ctc0\t%0,"STR(register)"\n\t"				\
+	"nop"							\
+        : : "r" (value));
+
+#define write_64bit_cp0_register(register,value)                \
+        __asm__ __volatile__(                                   \
+        ".set\tmips3\n\t"                                       \
+        "dmtc0\t%0,"STR(register)"\n\t"                         \
+        ".set\tmips0"                                           \
+        : : "r" (value))
+
+/* 
+ * This should be changed when we get a compiler that support the MIPS32 ISA. 
+ */
+#define read_mips32_cp0_config1()                               \
+({ int __res;                                                   \
+        __asm__ __volatile__(                                   \
+	".set\tnoreorder\n\t"                                   \
+	".set\tnoat\n\t"                                        \
+     	".word\t0x40018001\n\t"                                 \
+	"move\t%0,$1\n\t"                                       \
+	".set\tat\n\t"                                          \
+	".set\treorder"                                         \
+	:"=r" (__res));                                         \
+        __res;})
+
+/* TLB operations. */
+static inline void tlb_probe(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"tlbp\n\t"
+		".set pop");
+}
+
+static inline void tlb_read(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"tlbr\n\t"
+		".set pop");
+}
+
+static inline void tlb_write_indexed(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"tlbwi\n\t"
+		".set pop");
+}
+
+static inline void tlb_write_random(void)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"tlbwr\n\t"
+		".set pop");
+}
+
+/* Dealing with various CP0 mmu/cache related registers. */
+
+
+static inline unsigned long get_pagemask(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $5\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_pagemask(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $5\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_ENTRYLO0 and CP0_ENTRYLO1 registers */
+static inline unsigned long get_entrylo0(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(	
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $2\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_entrylo0(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $2\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+static inline unsigned long get_entrylo1(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $3\n\t"
+		".set pop" : "=r" (val));
+
+	return val;
+}
+
+static inline void set_entrylo1(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $3\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_ENTRYHI register */
+static inline unsigned long get_entryhi(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $10\n\t"
+		".set pop"
+		: "=r" (val));
+
+	return val;
+}
+
+static inline void set_entryhi(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $10\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_INDEX register */
+static inline unsigned long get_index(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $0\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_index(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $0\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_WIRED register */
+static inline unsigned long get_wired(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $6\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_wired(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $6\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_STATUS register */
+static inline unsigned int get_status(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $12\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_status(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $12\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+static inline unsigned long get_info(void)
+{
+	unsigned long val;
+
+	__asm__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $7\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+/* CP0_TAGLO and CP0_TAGHI registers */
+static inline unsigned long get_taglo(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $28\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_taglo(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $28\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+static inline unsigned long get_taghi(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $29\n\t"
+		".set pop"
+		: "=r" (val));
+	return val;
+}
+
+static inline void set_taghi(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $29\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/* CP0_CONTEXT register */
+static inline unsigned long get_context(void)
+{
+	unsigned long val;
+
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mfc0 %0, $4\n\t"
+		".set pop"
+		: "=r" (val));
+
+	return val;
+}
+
+static inline void set_context(unsigned long val)
+{
+	__asm__ __volatile__(
+		".set push\n\t"
+		".set reorder\n\t"
+		"mtc0 %z0, $4\n\t"
+		".set pop"
+		: : "Jr" (val));
+}
+
+/*
+ * Manipulate the status register.
+ * Mostly used to access the interrupt bits.
+ */
+#define __BUILD_SET_CP0(name,register)				\
+static inline unsigned int					\
+set_cp0_##name(unsigned int set)				\
+{								\
+	unsigned int res;					\
+								\
+	res = read_32bit_cp0_register(register);		\
+	res |= set;						\
+	write_32bit_cp0_register(register, res);		\
+								\
+	return res;						\
+}								\
+								\
+static inline unsigned int					\
+clear_cp0_##name(unsigned int clear)				\
+{								\
+	unsigned int res;					\
+								\
+	res = read_32bit_cp0_register(register);		\
+	res &= ~clear;						\
+	write_32bit_cp0_register(register, res);		\
+								\
+	return res;						\
+}								\
+								\
+static inline unsigned int					\
+change_cp0_##name(unsigned int change, unsigned int new)	\
+{								\
+	unsigned int res;					\
+								\
+	res = read_32bit_cp0_register(register);		\
+	res &= ~change;						\
+	res |= (new & change);					\
+	write_32bit_cp0_register(register, res);		\
+								\
+	return res;						\
+}
+
+__BUILD_SET_CP0(status,CP0_STATUS)
+__BUILD_SET_CP0(cause,CP0_CAUSE)
+__BUILD_SET_CP0(config,CP0_CONFIG)
+
+#define __enable_fpu()							\
+do {									\
+	set_cp0_status(ST0_CU1);					\
+	asm("nop;nop;nop;nop");		/* max. hazard */		\
+} while (0)
+
+#define __disable_fpu()							\
+do {									\
+	clear_cp0_status(ST0_CU1);					\
+	/* We don't care about the cp0 hazard here  */			\
+} while (0)
+
+#define enable_fpu()							\
+do {									\
+	if (mips_cpu.options & MIPS_CPU_FPU)				\
+		__enable_fpu();						\
+} while (0)
+
+#define disable_fpu()							\
+do {									\
+	if (mips_cpu.options & MIPS_CPU_FPU)				\
+		__disable_fpu();					\
+} while (0)
+
+#endif /* !defined (_LANGUAGE_ASSEMBLY) */
 
 #endif /* _ASM_MIPSREGS_H */
Index: include/asm-mips/pgtable.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/pgtable.h,v
retrieving revision 1.60
diff -u -r1.60 pgtable.h
--- include/asm-mips/pgtable.h 2001/10/24 23:00:44 1.60  
+++ include/asm-mips/pgtable.h 2001/10/30 14:46:46   
@@ -507,274 +507,6 @@
 #define PageSkip(page)		(0)
 #define kern_addr_valid(addr)	(1)
 
-/* TLB operations. */
-extern inline void tlb_probe(void)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"tlbp\n\t"
-		".set pop");
-}
-
-extern inline void tlb_read(void)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"tlbr\n\t"
-		".set pop");
-}
-
-extern inline void tlb_write_indexed(void)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"tlbwi\n\t"
-		".set pop");
-}
-
-extern inline void tlb_write_random(void)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"tlbwr\n\t"
-		".set pop");
-}
-
-/* Dealing with various CP0 mmu/cache related registers. */
-
-/* CP0_PAGEMASK register */
-extern inline unsigned long get_pagemask(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $5\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_pagemask(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $5\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-/* CP0_ENTRYLO0 and CP0_ENTRYLO1 registers */
-extern inline unsigned long get_entrylo0(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(	
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $2\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_entrylo0(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $2\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-extern inline unsigned long get_entrylo1(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $3\n\t"
-		".set pop" : "=r" (val));
-
-	return val;
-}
-
-extern inline void set_entrylo1(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $3\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-/* CP0_ENTRYHI register */
-extern inline unsigned long get_entryhi(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $10\n\t"
-		".set pop"
-		: "=r" (val));
-
-	return val;
-}
-
-extern inline void set_entryhi(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $10\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-/* CP0_INDEX register */
-extern inline unsigned long get_index(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $0\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_index(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $0\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-/* CP0_WIRED register */
-extern inline unsigned long get_wired(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $6\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_wired(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $6\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-extern inline unsigned long get_info(void)
-{
-	unsigned long val;
-
-	__asm__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $7\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-/* CP0_TAGLO and CP0_TAGHI registers */
-extern inline unsigned long get_taglo(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $28\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_taglo(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $28\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-extern inline unsigned long get_taghi(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $29\n\t"
-		".set pop"
-		: "=r" (val));
-	return val;
-}
-
-extern inline void set_taghi(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $29\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
-/* CP0_CONTEXT register */
-extern inline unsigned long get_context(void)
-{
-	unsigned long val;
-
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mfc0 %0, $4\n\t"
-		".set pop"
-		: "=r" (val));
-
-	return val;
-}
-
-extern inline void set_context(unsigned long val)
-{
-	__asm__ __volatile__(
-		".set push\n\t"
-		".set reorder\n\t"
-		"mtc0 %z0, $4\n\t"
-		".set pop"
-		: : "Jr" (val));
-}
-
 #include <asm-generic/pgtable.h>
 
 #endif /* !defined (_LANGUAGE_ASSEMBLY) */
