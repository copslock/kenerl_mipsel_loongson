Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OFhM616898
	for linux-mips-outgoing; Fri, 24 Aug 2001 08:43:22 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OFgod16886
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 08:42:50 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id RAA15682;
	Fri, 24 Aug 2001 17:44:09 +0200 (MET DST)
Date: Fri, 24 Aug 2001 17:44:08 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: __dbe_table iteration #2 
In-Reply-To: <17182.998608269@ocs3.ocs-net>
Message-ID: <Pine.GSO.3.96.1010824150106.11987B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 24 Aug 2001, Keith Owens wrote:

> You have to be root to call init_module() or run insmod, root can do a
> lot more damage than passing an invalid structure size.  This type of
> test is not to catch malicious code, it is to detect that the user is
> running an old modutils with a smaller archdata than the kernel can
> handle.

 I mean it as a test to catch buggy, not malicious code.  For malicious
code run by root there is not much to do.  Besides, the code is not any
longer nor slower.  Adding a case-specific small constant instead of fixed
one is achieved via the same processor's instructions -- only their
operands differ. 

> You are correct that modutils as released will never pass a smaller
> archdata struct for mips so strictly speaking this test is superfluous.
> However this type of code gets cut and pasted so I want size checking
> on all archdata, when it is copied the developer has to think about
> changing the test instead of forgetting to add a test.

 Sure, agreed.  For this reason the ia64 code need a bit of cleanup, too. 

> Your suggested code works just as well but is less readable.  Go with
> either.

 Ok, that's not much readable, indeed.  Thus I've invented a macro.  See
a following patch hiding implementation details.

> Leave it as module_arch_init, it tells us how the code was called.

 OK.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-dbe-13
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c	Fri Jun 15 04:27:07 2001
+++ linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c	Fri Aug 24 00:58:00 2001
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
@@ -25,6 +26,7 @@
 #include <asm/cachectl.h>
 #include <asm/inst.h>
 #include <asm/jazz.h>
+#include <asm/module.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/siginfo.h>
@@ -254,23 +256,68 @@ search_one_table(const struct exception_
 	return (first == last && first->insn == value) ? first->nextinsn : 0;
 }
 
-#define search_dbe_table(addr)	\
-	search_one_table(__start___dbe_table, __stop___dbe_table - 1, (addr))
+extern spinlock_t modlist_lock;
+
+static inline unsigned long
+search_dbe_table(unsigned long addr)
+{
+	unsigned long ret = 0;
+
+#ifndef CONFIG_MODULES
+	/* There is only the kernel to search.  */
+	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
+	return ret;
+#else
+	unsigned long flags;
+
+	/* The kernel is the last "module" -- no need to treat it special.  */
+	struct module *mp;
+	struct archdata *ap;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	for (mp = module_list; mp != NULL; mp = mp->next) {
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
+			continue;
+		ap = (struct archdata *)(mp->archdata_start);
+
+		if (ap->dbe_table_start == NULL ||
+		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+			continue;
+		ret = search_one_table(ap->dbe_table_start,
+				       ap->dbe_table_end - 1, addr);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return ret;
+#endif
+}
 
 static void default_be_board_handler(struct pt_regs *regs)
 {
 	unsigned long new_epc;
-	unsigned long fixup = search_dbe_table(regs->cp0_epc);
+	unsigned long fixup;
+	int data = regs->cp0_cause & 4;
 
-	if (fixup) {
-		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
-		regs->cp0_epc = new_epc;
-		return;
+	if (data && !user_mode(regs)) {
+		fixup = search_dbe_table(regs->cp0_epc);
+		if (fixup) {
+			new_epc = fixup_exception(dpf_reg, fixup,
+						  regs->cp0_epc);
+			regs->cp0_epc = new_epc;
+			return;
+		}
 	}
 
 	/*
 	 * Assume it would be too dangerous to continue ...
 	 */
+	printk(KERN_ALERT "%s bus error, epc == %08lx, ra == %08lx\n",
+	       data ? "Data" : "Instruction",
+	       regs->cp0_epc, regs->regs[31]);
+	die_if_kernel("Oops", regs);
 	force_sig(SIGBUS, current);
 }
 
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips64/sgi-ip22/ip22-berr.c linux-mips-2.4.5-20010704/arch/mips64/sgi-ip22/ip22-berr.c
--- linux-mips-2.4.5-20010704.macro/arch/mips64/sgi-ip22/ip22-berr.c	Thu Feb 24 05:26:11 2000
+++ linux-mips-2.4.5-20010704/arch/mips64/sgi-ip22/ip22-berr.c	Fri Aug 24 00:58:38 2001
@@ -9,6 +9,9 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/module.h>
 #include <asm/uaccess.h>
 #include <asm/paccess.h>
 #include <asm/addrspace.h>
@@ -41,16 +44,43 @@ search_one_table(const struct exception_
 	return 0;
 }
 
+extern spinlock_t modlist_lock;
+
 static inline unsigned long
 search_dbe_table(unsigned long addr)
 {
-	unsigned long ret;
+	unsigned long ret = 0;
 
+#ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
-	if (ret) return ret;
-
-	return 0;
+	return ret;
+#else
+	unsigned long flags;
+
+	/* The kernel is the last "module" -- no need to treat it special.  */
+	struct module *mp;
+	struct archdata *ap;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	for (mp = module_list; mp != NULL; mp = mp->next) {
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
+			continue;
+		ap = (struct archdata *)(mod->archdata_start);
+
+		if (ap->dbe_table_start == NULL ||
+		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+			continue;
+		ret = search_one_table(ap->dbe_table_start,
+				       ap->dbe_table_end - 1, addr);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return ret;
+#endif
 }
 
 void do_ibe(struct pt_regs *regs)
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips64/sgi-ip27/ip27-berr.c linux-mips-2.4.5-20010704/arch/mips64/sgi-ip27/ip27-berr.c
--- linux-mips-2.4.5-20010704.macro/arch/mips64/sgi-ip27/ip27-berr.c	Sat Feb 24 05:26:18 2001
+++ linux-mips-2.4.5-20010704/arch/mips64/sgi-ip27/ip27-berr.c	Fri Aug 24 00:58:47 2001
@@ -8,6 +8,9 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/module.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/sn0/hub.h>
@@ -43,16 +46,43 @@ search_one_table(const struct exception_
 	return 0;
 }
 
+extern spinlock_t modlist_lock;
+
 static inline unsigned long
 search_dbe_table(unsigned long addr)
 {
 	unsigned long ret;
 
+#ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___dbe_table, __stop___dbe_table-1, addr);
-	if (ret) return ret;
-
-	return 0;
+	return ret;
+#else
+	unsigned long flags;
+
+	/* The kernel is the last "module" -- no need to treat it special.  */
+	struct module *mp;
+	struct archdata *ap;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	for (mp = module_list; mp != NULL; mp = mp->next) {
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
+			continue;
+		ap = (struct archdata *)(mod->archdata_start);
+
+		if (ap->dbe_table_start == NULL ||
+		    !(mp->flags & (MOD_RUNNING | MOD_INITIALIZING)))
+			continue;
+		ret = search_one_table(ap->dbe_table_start,
+				       ap->dbe_table_end - 1, addr);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
+	return ret;
+#endif
 }
 
 void do_ibe(struct pt_regs *regs)
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-alpha/module.h linux-mips-2.4.5-20010704/include/asm-alpha/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-alpha/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-alpha/module.h	Fri Aug 24 00:59:47 2001
@@ -6,6 +6,23 @@
 
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
+#define module_arch_init(x)	alpha_module_init(x)
+#define arch_init_modules(x)	alpha_init_modules(x)
+
+static inline int
+alpha_module_init(struct module *mod)
+{
+        if (!mod_bound(mod->gp - 0x8000, 0, mod)) {
+                printk(KERN_ERR "module_arch_init: mod->gp out of bounds.\n");
+                return 1;
+        }
+	return 0;
+}
+
+static inline void
+alpha_init_modules(struct module *mod)
+{
+	__asm__("stq $29,%0" : "=m" (mod->gp));
+}
 
 #endif /* _ASM_ALPHA_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-arm/module.h linux-mips-2.4.5-20010704/include/asm-arm/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-arm/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-arm/module.h	Mon Aug 20 01:11:58 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_ARM_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-cris/module.h linux-mips-2.4.5-20010704/include/asm-cris/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-cris/module.h	Fri Mar  9 20:34:43 2001
+++ linux-mips-2.4.5-20010704/include/asm-cris/module.h	Mon Aug 20 01:12:04 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_CRIS_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-i386/module.h linux-mips-2.4.5-20010704/include/asm-i386/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-i386/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-i386/module.h	Mon Aug 20 01:12:08 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_I386_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-ia64/module.h linux-mips-2.4.5-20010704/include/asm-ia64/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-ia64/module.h	Thu Jun 14 04:28:30 2001
+++ linux-mips-2.4.5-20010704/include/asm-ia64/module.h	Fri Aug 24 01:03:17 2001
@@ -14,6 +14,7 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		ia64_module_unmap(x)
 #define module_arch_init(x)	ia64_module_init(x)
+#define ia64_module_inits(x)	do { } while (0)
 
 /*
  * This must match in size and layout the data created by
@@ -46,27 +47,27 @@ ia64_module_init(struct module *mod)
 
 	if (archdata->unw_table)
 	{
-		printk(KERN_ERR "arch_init_module: archdata->unw_table must be zero.\n");
+		printk(KERN_ERR "module_arch_init: archdata->unw_table must be zero.\n");
 		return 1;
 	}
 	if (!mod_bound(archdata->gp, 0, mod))
 	{
-		printk(KERN_ERR "arch_init_module: archdata->gp out of bounds.\n");
+		printk(KERN_ERR "module_arch_init: archdata->gp out of bounds.\n");
 		return 1;
 	}
 	if (!mod_bound(archdata->unw_start, 0, mod))
 	{
-		printk(KERN_ERR "arch_init_module: archdata->unw_start out of bounds.\n");
+		printk(KERN_ERR "module_arch_init: archdata->unw_start out of bounds.\n");
 		return 1;
 	}
 	if (!mod_bound(archdata->unw_end, 0, mod))
 	{
-		printk(KERN_ERR "arch_init_module: archdata->unw_end out of bounds.\n");
+		printk(KERN_ERR "module_arch_init: archdata->unw_end out of bounds.\n");
 		return 1;
 	}
 	if (!mod_bound(archdata->segment_base, 0, mod))
 	{
-		printk(KERN_ERR "arch_init_module: archdata->unw_table out of bounds.\n");
+		printk(KERN_ERR "module_arch_init: archdata->unw_table out of bounds.\n");
 		return 1;
 	}
 
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-m68k/module.h linux-mips-2.4.5-20010704/include/asm-m68k/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-m68k/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-m68k/module.h	Mon Aug 20 01:12:18 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_M68K_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-mips/module.h linux-mips-2.4.5-20010704/include/asm-mips/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-mips/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-mips/module.h	Fri Aug 24 00:54:50 2001
@@ -4,8 +4,64 @@
  * This file contains the mips architecture specific module code.
  */
 
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
+#define module_arch_init(x)	mips_module_init(x)
+#define arch_init_modules(x)	mips_init_modules(x)
+
+/*
+ * This must match in size and layout the data created by
+ * modutils/obj/obj-mips.c
+ */
+struct archdata {
+	const struct exception_table_entry *dbe_table_start;
+	const struct exception_table_entry *dbe_table_end;
+};
+
+static inline int
+mips_module_init(struct module *mod)
+{
+	struct archdata *archdata;
+
+	if (!mod_member_present(mod, archdata_end))
+		return 0;
+
+	archdata = (struct archdata *)(mod->archdata_start);
+	if (!mod_archdata_member_present(mod, struct archdata, dbe_table_end))
+		return 0;
+
+	if (archdata->dbe_table_start > archdata->dbe_table_end ||
+	    (archdata->dbe_table_start &&
+	     !((unsigned long)archdata->dbe_table_start >=
+	       ((unsigned long)mod + mod->size_of_struct) &&
+	       ((unsigned long)archdata->dbe_table_end <
+	        (unsigned long)mod + mod->size))) ||
+            (((unsigned long)archdata->dbe_table_start -
+	      (unsigned long)archdata->dbe_table_end) %
+	     sizeof(struct exception_table_entry))) {
+		printk(KERN_ERR
+			"module_arch_init: archdata->dbe_table_* invalid.\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline void
+mips_init_modules(struct module *mod)
+{
+	extern const struct exception_table_entry __start___dbe_table[];
+	extern const struct exception_table_entry __stop___dbe_table[];
+	static struct archdata archdata = {
+		dbe_table_start:	__start___dbe_table,
+		dbe_table_end:		__stop___dbe_table,
+	};
+
+	mod->archdata_start = (char *)&archdata;
+	mod->archdata_end = mod->archdata_start + sizeof(archdata);
+}
 
 #endif /* _ASM_MIPS_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-mips64/module.h linux-mips-2.4.5-20010704/include/asm-mips64/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-mips64/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-mips64/module.h	Fri Aug 24 00:55:00 2001
@@ -4,8 +4,64 @@
  * This file contains the mips64 architecture specific module code.
  */
 
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
-#define module_arch_init(x)	(0)
+#define module_arch_init(x)	mips64_module_init(x)
+#define arch_init_modules(x)	mips64_init_modules(x)
+
+/*
+ * This must match in size and layout the data created by
+ * modutils/obj/obj-mips64.c
+ */
+struct archdata {
+	const struct exception_table_entry *dbe_table_start;
+	const struct exception_table_entry *dbe_table_end;
+};
+
+static inline int
+mips64_module_init(struct module *mod)
+{
+	struct archdata *archdata;
+
+	if (!mod_member_present(mod, archdata_end))
+		return 0;
+
+	archdata = (struct archdata *)(mod->archdata_start);
+	if (!mod_archdata_member_present(mod, struct archdata, dbe_table_end))
+		return 0;
+
+	if (archdata->dbe_table_start > archdata->dbe_table_end ||
+	    (archdata->dbe_table_start &&
+	     !((unsigned long)archdata->dbe_table_start >=
+	       ((unsigned long)mod + mod->size_of_struct) &&
+	       ((unsigned long)archdata->dbe_table_end <
+	        (unsigned long)mod + mod->size))) ||
+            (((unsigned long)archdata->dbe_table_start -
+	      (unsigned long)archdata->dbe_table_end) %
+	     sizeof(struct exception_table_entry))) {
+		printk(KERN_ERR
+			"module_arch_init: archdata->dbe_table_* invalid.\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static inline void
+mips64_init_modules(struct module *mod)
+{
+	extern const struct exception_table_entry __start___dbe_table[];
+	extern const struct exception_table_entry __stop___dbe_table[];
+	static struct archdata archdata = {
+		dbe_table_start:	__start___dbe_table,
+		dbe_table_end:		__stop___dbe_table,
+	};
+
+	mod->archdata_start = (char *)&archdata;
+	mod->archdata_end = mod->archdata_start + sizeof(archdata);
+}
 
 #endif /* _ASM_MIPS64_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-ppc/module.h linux-mips-2.4.5-20010704/include/asm-ppc/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-ppc/module.h	Thu Jun 14 04:28:38 2001
+++ linux-mips-2.4.5-20010704/include/asm-ppc/module.h	Mon Aug 20 01:12:29 2001
@@ -10,5 +10,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_PPC_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-s390/module.h linux-mips-2.4.5-20010704/include/asm-s390/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-s390/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-s390/module.h	Mon Aug 20 01:12:37 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_S390_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-s390x/module.h linux-mips-2.4.5-20010704/include/asm-s390x/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-s390x/module.h	Fri Mar  9 20:34:52 2001
+++ linux-mips-2.4.5-20010704/include/asm-s390x/module.h	Mon Aug 20 01:12:53 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_S390_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-sh/module.h linux-mips-2.4.5-20010704/include/asm-sh/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-sh/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-sh/module.h	Mon Aug 20 01:12:58 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SH_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-sparc/module.h linux-mips-2.4.5-20010704/include/asm-sparc/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-sparc/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-sparc/module.h	Mon Aug 20 01:13:03 2001
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SPARC_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/asm-sparc64/module.h linux-mips-2.4.5-20010704/include/asm-sparc64/module.h
--- linux-mips-2.4.5-20010704.macro/include/asm-sparc64/module.h	Tue Nov 28 03:59:03 2000
+++ linux-mips-2.4.5-20010704/include/asm-sparc64/module.h	Mon Aug 20 01:13:19 2001
@@ -7,5 +7,6 @@
 extern void * module_map (unsigned long size);
 extern void module_unmap (void *addr);
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SPARC64_MODULE_H */
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/linux/module.h linux-mips-2.4.5-20010704/include/linux/module.h
--- linux-mips-2.4.5-20010704.macro/include/linux/module.h	Mon Jul 16 02:13:58 2001
+++ linux-mips-2.4.5-20010704/include/linux/module.h	Fri Aug 24 00:50:22 2001
@@ -130,6 +130,16 @@ struct module_info
 	((unsigned long)(&((struct module *)0L)->member + 1)		\
 	 <= (mod)->size_of_struct)
 
+/*
+ * Ditto for archdata.  Assumes mod->archdata_start and mod->archdata_end
+ * are validated elsewhere.
+ */
+#define mod_archdata_member_present(mod, type, member)			\
+	(((unsigned long)(&((type *)0L)->member) +			\
+	  sizeof(((type *)0L)->member)) <=				\
+	 ((mod)->archdata_end - (mod)->archdata_start))
+	 
+
 /* Check if an address p with number of entries n is within the body of module m */
 #define mod_bound(p, n, m) ((unsigned long)(p) >= ((unsigned long)(m) + ((m)->size_of_struct)) && \
 	         (unsigned long)((p)+(n)) <= (unsigned long)(m) + (m)->size)
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/kernel/module.c linux-mips-2.4.5-20010704/kernel/module.c
--- linux-mips-2.4.5-20010704.macro/kernel/module.c	Thu Jun 14 04:28:48 2001
+++ linux-mips-2.4.5-20010704/kernel/module.c	Sun Aug 19 20:10:35 2001
@@ -246,9 +246,7 @@ void __init init_modules(void)
 {
 	kernel_module.nsyms = __stop___ksymtab - __start___ksymtab;
 
-#ifdef __alpha__
-	__asm__("stq $29,%0" : "=m"(kernel_module.gp));
-#endif
+	arch_init_modules(&kernel_module);
 }
 
 /*
@@ -440,12 +438,6 @@ sys_init_module(const char *name_user, s
 		printk(KERN_ERR "init_module: mod->flags invalid.\n");
 		goto err2;
 	}
-#ifdef __alpha__
-	if (!mod_bound(mod->gp - 0x8000, 0, mod)) {
-		printk(KERN_ERR "init_module: mod->gp out of bounds.\n");
-		goto err2;
-	}
-#endif
 	if (mod_member_present(mod, can_unload)
 	    && mod->can_unload && !mod_bound(mod->can_unload, 0, mod)) {
 		printk(KERN_ERR "init_module: mod->can_unload out of bounds.\n");
