Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 14:20:37 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:8861 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225322AbUBMOUg>; Fri, 13 Feb 2004 14:20:36 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 51D214C3C1; Fri, 13 Feb 2004 15:20:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 3C0BE4AD2E; Fri, 13 Feb 2004 15:20:27 +0100 (CET)
Date: Fri, 13 Feb 2004 15:20:27 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

Hello,

 Here's another set of changes needed for the kernel to work when built 
with gcc 3.4.  The compiler is pretty serious about removing code and data 
it considers dead.  While earlier versions would only warn about such dead 
bits, the current one actually throws them away.

 Here's my proposed fix for the problem:

1. It changes the "unused"  attribute to the "used" one for compiler
versions that support it, to actually mark the bits as needed, instead of
masking warnings.

2. It changes inline-assembly function prologues to be embedded within the
functions, which makes them a bit safer as they can now explicitly refer
to the "regs" struct and assures the code won't be removed or reordered.

 It was successfully tested with gcc 3.4 and 2.95.4, including inspecting
the generated code.  I'd like to apply the MIPS-specific part, i.e. for
bits under arch/mips* and include/asm-mips* to our tree (both 2.4 and the
trunk).  OK?

 The rest is to be accepted by Marcelo -- although functionally
consistent, the changes do not depend on each other, but I decided to 
publish them here for people's convenience (this part went to the LKML 
yesterday).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.24-pre2-20040116-gcc3-6
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/signal.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/signal.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/signal.c	2003-07-25 02:56:34.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/signal.c	2004-02-13 05:43:50.000000000 +0000
@@ -75,10 +75,10 @@ int copy_siginfo_to_user(siginfo_t *to, 
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-save_static_function(sys_sigsuspend);
-static_unused int _sys_sigsuspend(struct pt_regs regs)
+int sys_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *uset, saveset, newset;
+	save_static(&regs);
 
 	uset = (sigset_t *) regs.regs[4];
 	if (copy_from_user(&newset, uset, sizeof(sigset_t)))
@@ -101,11 +101,11 @@ static_unused int _sys_sigsuspend(struct
 	}
 }
 
-save_static_function(sys_rt_sigsuspend);
-static_unused int _sys_rt_sigsuspend(struct pt_regs regs)
+int sys_rt_sigsuspend(struct pt_regs regs)
 {
 	sigset_t *unewset, saveset, newset;
         size_t sigsetsize;
+	save_static(&regs);
 
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/syscall.c linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/syscall.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips/kernel/syscall.c	2003-04-01 02:56:50.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips/kernel/syscall.c	2004-02-13 05:44:04.000000000 +0000
@@ -157,22 +157,22 @@ sys_mmap2(unsigned long addr, unsigned l
 	return do_mmap2(addr, len, prot, flags, fd, pgoff);
 }
 
-save_static_function(sys_fork);
-static_unused int _sys_fork(struct pt_regs regs)
+int sys_fork(struct pt_regs regs)
 {
 	int res;
+	save_static(&regs);
 
 	res = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
 	return res;
 }
 
 
-save_static_function(sys_clone);
-static_unused int _sys_clone(struct pt_regs regs)
+int sys_clone(struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
 	int res;
+	save_static(&regs);
 
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/signal.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/signal.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/signal.c	2004-01-04 03:56:41.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/signal.c	2004-02-13 05:44:14.000000000 +0000
@@ -74,11 +74,11 @@ int copy_siginfo_to_user(siginfo_t *to, 
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-save_static_function(sys_rt_sigsuspend);
-static_unused int _sys_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+int sys_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset_t *unewset, saveset, newset;
         size_t sigsetsize;
+	save_static(&regs);
 
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/signal32.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/signal32.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/signal32.c	2004-01-04 03:56:41.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/signal32.c	2004-02-13 05:44:26.000000000 +0000
@@ -126,11 +126,11 @@ static inline int get_sigset(sigset_t *k
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-save_static_function(sys32_sigsuspend);
-static_unused int _sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+int sys32_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset32_t *uset;
 	sigset_t newset, saveset;
+	save_static(&regs);
 
 	uset = (sigset32_t *) regs.regs[4];
 	if (get_sigset(&newset, uset))
@@ -153,12 +153,12 @@ static_unused int _sys32_sigsuspend(abi6
 	}
 }
 
-save_static_function(sys32_rt_sigsuspend);
-static_unused int _sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
+int sys32_rt_sigsuspend(abi64_no_regargs, struct pt_regs regs)
 {
 	sigset32_t *uset;
 	sigset_t newset, saveset;
         size_t sigsetsize;
+	save_static(&regs);
 
 	/* XXX Don't preclude handling different sized sigset_t's.  */
 	sigsetsize = regs.regs[5];
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/syscall.c linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/syscall.c
--- linux-mips-2.4.24-pre2-20040116.macro/arch/mips64/kernel/syscall.c	2004-01-04 03:56:41.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/arch/mips64/kernel/syscall.c	2004-02-13 05:44:36.000000000 +0000
@@ -147,21 +147,21 @@ out:
 	return error;
 }
 
-save_static_function(sys_fork);
-static_unused int _sys_fork(abi64_no_regargs, struct pt_regs regs)
+int sys_fork(abi64_no_regargs, struct pt_regs regs)
 {
 	int res;
+	save_static(&regs);
 
 	res = do_fork(SIGCHLD, regs.regs[29], &regs, 0);
 	return res;
 }
 
-save_static_function(sys_clone);
-static_unused int _sys_clone(abi64_no_regargs, struct pt_regs regs)
+int sys_clone(abi64_no_regargs, struct pt_regs regs)
 {
 	unsigned long clone_flags;
 	unsigned long newsp;
 	int res;
+	save_static(&regs);
 
 	clone_flags = regs.regs[4];
 	newsp = regs.regs[5];
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/ptrace.h linux-mips-2.4.24-pre2-20040116/include/asm-mips/ptrace.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips/ptrace.h	2004-02-09 04:30:14.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips/ptrace.h	2004-02-13 06:19:23.000000000 +0000
@@ -44,31 +44,26 @@ struct pt_regs {
 	unsigned long cp0_epc;
 };
 
-#define __str2(x) #x
-#define __str(x) __str2(x)
-
-#define save_static_function(symbol)                                    \
-__asm__ (                                                               \
-        ".globl\t" #symbol "\n\t"                                       \
-        ".align\t2\n\t"                                                 \
-        ".type\t" #symbol ", @function\n\t"                             \
-        ".ent\t" #symbol ", 0\n"                                        \
-        #symbol":\n\t"                                                  \
-        ".frame\t$29, 0, $31\n\t"                                       \
-        "sw\t$16,"__str(PT_R16)"($29)\t\t\t# save_static_function\n\t"  \
-        "sw\t$17,"__str(PT_R17)"($29)\n\t"                              \
-        "sw\t$18,"__str(PT_R18)"($29)\n\t"                              \
-        "sw\t$19,"__str(PT_R19)"($29)\n\t"                              \
-        "sw\t$20,"__str(PT_R20)"($29)\n\t"                              \
-        "sw\t$21,"__str(PT_R21)"($29)\n\t"                              \
-        "sw\t$22,"__str(PT_R22)"($29)\n\t"                              \
-        "sw\t$23,"__str(PT_R23)"($29)\n\t"                              \
-        "sw\t$30,"__str(PT_R30)"($29)\n\t"                              \
-        ".end\t" #symbol "\n\t"                                         \
-        ".size\t" #symbol",. - " #symbol)
-
-/* Used in declaration of save_static functions.  */
-#define static_unused static __attribute__((unused))
+#define save_static(r)							\
+__asm__ __volatile__(							\
+	"sw	$16,%0			# save_static\n\t"		\
+	"sw	$17,%1\n\t"						\
+	"sw	$18,%2\n\t"						\
+	"sw	$19,%3\n\t"						\
+	"sw	$20,%4\n\t"						\
+	"sw	$21,%5\n\t"						\
+	"sw	$22,%6\n\t"						\
+	"sw	$23,%7\n\t"						\
+	"sw	$30,%8"							\
+	: "=m" ((r)->regs[16]),						\
+	  "=m" ((r)->regs[17]),						\
+	  "=m" ((r)->regs[18]),						\
+	  "=m" ((r)->regs[19]),						\
+	  "=m" ((r)->regs[20]),						\
+	  "=m" ((r)->regs[21]),						\
+	  "=m" ((r)->regs[22]),						\
+	  "=m" ((r)->regs[23]),						\
+	  "=m" ((r)->regs[30]))
 
 #endif /* !__ASSEMBLY__ */
 
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/ptrace.h linux-mips-2.4.24-pre2-20040116/include/asm-mips64/ptrace.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/asm-mips64/ptrace.h	2004-01-26 03:35:56.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/asm-mips64/ptrace.h	2004-02-13 06:19:42.000000000 +0000
@@ -41,31 +41,26 @@ struct pt_regs {
 	unsigned long cp0_epc;
 };
 
-#define __str2(x) #x
-#define __str(x) __str2(x)
-
-#define save_static_function(symbol)                                    \
-__asm__ (                                                               \
-        ".globl\t" #symbol "\n\t"                                       \
-        ".align\t2\n\t"                                                 \
-        ".type\t" #symbol ", @function\n\t"                             \
-        ".ent\t" #symbol ", 0\n"                                        \
-        #symbol":\n\t"                                                  \
-        ".frame\t$29, 0, $31\n\t"                                       \
-        "sd\t$16,"__str(PT_R16)"($29)\t\t\t# save_static_function\n\t"  \
-        "sd\t$17,"__str(PT_R17)"($29)\n\t"                              \
-        "sd\t$18,"__str(PT_R18)"($29)\n\t"                              \
-        "sd\t$19,"__str(PT_R19)"($29)\n\t"                              \
-        "sd\t$20,"__str(PT_R20)"($29)\n\t"                              \
-        "sd\t$21,"__str(PT_R21)"($29)\n\t"                              \
-        "sd\t$22,"__str(PT_R22)"($29)\n\t"                              \
-        "sd\t$23,"__str(PT_R23)"($29)\n\t"                              \
-        "sd\t$30,"__str(PT_R30)"($29)\n\t"                              \
-        ".end\t" #symbol "\n\t"                                         \
-        ".size\t" #symbol",. - " #symbol)
-
-/* Used in declaration of save_static functions.  */
-#define static_unused static __attribute__((unused))
+#define save_static(r)							\
+__asm__ __volatile__(							\
+	"sd	$16,%0			# save_static\n\t"		\
+	"sd	$17,%1\n\t"						\
+	"sd	$18,%2\n\t"						\
+	"sd	$19,%3\n\t"						\
+	"sd	$20,%4\n\t"						\
+	"sd	$21,%5\n\t"						\
+	"sd	$22,%6\n\t"						\
+	"sd	$23,%7\n\t"						\
+	"sd	$30,%8"							\
+	: "=m" ((r)->regs[16]),						\
+	  "=m" ((r)->regs[17]),						\
+	  "=m" ((r)->regs[18]),						\
+	  "=m" ((r)->regs[19]),						\
+	  "=m" ((r)->regs[20]),						\
+	  "=m" ((r)->regs[21]),						\
+	  "=m" ((r)->regs[22]),						\
+	  "=m" ((r)->regs[23]),						\
+	  "=m" ((r)->regs[30]))
 
 #define abi64_no_regargs						\
 	unsigned long __dummy0,						\
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/linux/compiler.h linux-mips-2.4.24-pre2-20040116/include/linux/compiler.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/linux/compiler.h	2001-10-19 01:25:03.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/linux/compiler.h	2004-02-12 19:54:39.000000000 +0000
@@ -13,4 +13,10 @@
 #define likely(x)	__builtin_expect((x),1)
 #define unlikely(x)	__builtin_expect((x),0)
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ >= 3)
+#define __attribute_used__	__attribute__((__used__))
+#else
+#define __attribute_used__	__attribute__((__unused__))
+#endif
+
 #endif /* __LINUX_COMPILER_H */
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/linux/init.h linux-mips-2.4.24-pre2-20040116/include/linux/init.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/linux/init.h	2004-02-09 04:30:16.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/linux/init.h	2004-02-12 19:54:39.000000000 +0000
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -67,7 +68,7 @@ extern struct kernel_param __setup_start
 
 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
-	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
+	static struct kernel_param __setup_##fn __attribute_used__ __initsetup = { __setup_str_##fn, fn }
 
 #endif /* __ASSEMBLY__ */
 
@@ -76,12 +77,12 @@ extern struct kernel_param __setup_start
  * or exit time.
  */
 #define __init		__attribute__ ((__section__ (".text.init")))
-#define __exit		__attribute__ ((unused, __section__(".text.exit")))
+#define __exit		__attribute_used__ __attribute__ ((__section__ (".text.exit")))
 #define __initdata	__attribute__ ((__section__ (".data.init")))
-#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
-#define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
-#define __init_call	__attribute__ ((unused,__section__ (".initcall.init")))
-#define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
+#define __exitdata	__attribute_used__ __attribute__ ((__section__ (".data.exit")))
+#define __initsetup	__attribute_used__ __attribute__ ((__section__ (".setup.init")))
+#define __init_call	__attribute_used__ __attribute__ ((__section__ (".initcall.init")))
+#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
 /* For assembly routines */
 #define __INIT		.section	".text.init","ax"
diff -up --recursive --new-file linux-mips-2.4.24-pre2-20040116.macro/include/linux/module.h linux-mips-2.4.24-pre2-20040116/include/linux/module.h
--- linux-mips-2.4.24-pre2-20040116.macro/include/linux/module.h	2004-02-11 23:56:32.000000000 +0000
+++ linux-mips-2.4.24-pre2-20040116/include/linux/module.h	2004-02-12 19:54:39.000000000 +0000
@@ -8,6 +8,7 @@
 #define _LINUX_MODULE_H
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
@@ -202,19 +203,22 @@ extern int try_inc_mod_count(struct modu
 
 /* For documentation purposes only.  */
 
-#define MODULE_AUTHOR(name)						   \
-const char __module_author[] __attribute__((section(".modinfo"))) = 	   \
-"author=" name
-
-#define MODULE_DESCRIPTION(desc)					   \
-const char __module_description[] __attribute__((section(".modinfo"))) =   \
-"description=" desc
+#define MODULE_AUTHOR(name)						\
+const char __module_author[]						\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) = "author=" name
+
+#define MODULE_DESCRIPTION(desc)					\
+const char __module_description[]					\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) = "description=" desc
 
 /* Could potentially be used by kmod...  */
 
-#define MODULE_SUPPORTED_DEVICE(dev)					   \
-const char __module_device[] __attribute__((section(".modinfo"))) = 	   \
-"device=" dev
+#define MODULE_SUPPORTED_DEVICE(dev)					\
+const char __module_device[]						\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) = "device=" dev
 
 /* Used to verify parameters given to the module.  The TYPE arg should
    be a string in the following format:
@@ -229,15 +233,17 @@ const char __module_device[] __attribute
 	s	string
 */
 
-#define MODULE_PARM(var,type)			\
-const char __module_parm_##var[]		\
-__attribute__((section(".modinfo"))) =		\
-"parm_" __MODULE_STRING(var) "=" type
-
-#define MODULE_PARM_DESC(var,desc)		\
-const char __module_parm_desc_##var[]		\
-__attribute__((section(".modinfo"))) =		\
-"parm_desc_" __MODULE_STRING(var) "=" desc
+#define MODULE_PARM(var,type)						\
+const char __module_parm_##var[]					\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) =				\
+  "parm_" __MODULE_STRING(var) "=" type
+
+#define MODULE_PARM_DESC(var,desc)					\
+const char __module_parm_desc_##var[]					\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) =				\
+  "parm_desc_" __MODULE_STRING(var) "=" desc
 
 /*
  * MODULE_DEVICE_TABLE exports information about devices
@@ -283,9 +289,10 @@ static const struct gtype##_id * __modul
  * 3.	So vendors can do likewise based on their own policies
  */
  
-#define MODULE_LICENSE(license) 	\
-static const char __module_license[] __attribute__((section(".modinfo"))) =   \
-"license=" license
+#define MODULE_LICENSE(license) 					\
+static const char __module_license[]					\
+  __attribute_used__							\
+  __attribute__((section(".modinfo"))) = "license=" license
 
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;
@@ -296,11 +303,11 @@ extern struct module __this_module;
 #define MOD_IN_USE		__MOD_IN_USE(THIS_MODULE)
 
 #include <linux/version.h>
-static const char __module_kernel_version[] __attribute__((section(".modinfo"))) =
-"kernel_version=" UTS_RELEASE;
+static const char __module_kernel_version[] __attribute_used__
+	__attribute__((section(".modinfo"))) = "kernel_version=" UTS_RELEASE;
 #ifdef MODVERSIONS
-static const char __module_using_checksums[] __attribute__((section(".modinfo"))) =
-"using_checksums=1";
+static const char __module_using_checksums[] __attribute_used__
+	__attribute__((section(".modinfo"))) = "using_checksums=1";
 #endif
 
 #else /* MODULE */
