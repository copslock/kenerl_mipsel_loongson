Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7KDuO719688
	for linux-mips-outgoing; Mon, 20 Aug 2001 06:56:24 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7KDtuj19678
	for <linux-mips@oss.sgi.com>; Mon, 20 Aug 2001 06:55:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA11015;
	Mon, 20 Aug 2001 15:57:21 +0200 (MET DST)
Date: Mon, 20 Aug 2001 15:57:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Keith Owens <kaos@ocs.com.au>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.5: __dbe_table iteration #2
In-Reply-To: <Pine.GSO.3.96.1010813152644.18279G-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1010820150047.3562D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 After a bit of work, I have implemented all the suggestions.  The
following changes have been made to the previous version: 

- default_be_board_handler() in traps.c (mips) only searches __dbe_table
for DBE faults and not IBE ones,

- search_dbe_table() in ip2[27]-berr.c (mips64) is modified to work
similarly to the traps.c (mips) one,

- init_modules() now calls platform-specific arch_init_modules(),

- module_arch_init() and arch_init_modules() are implemented for alpha
(moving the conditional stuff from module.c), mips and mips64.

The patch follows.  It has been rougly tested on mips and has proved to be
harmless on i386 as well.  The alpha and mips64 changes have not been
tested.  I haven't modified DBE handlers for mips64 to make them work like
the mips version since they don't return at all anyway.

 If we agree on the patch I'm going to submit it to mainline since it's
not MIPS-specific anymore.  The patch applies cleanly to 2.4.9. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-dbe-11
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c	Fri Jun 15 04:27:07 2001
+++ linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c	Mon Aug 20 13:38:05 2001
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
@@ -254,23 +256,67 @@ search_one_table(const struct exception_
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
+		if (!mod_member_present(mp, archdata_start) ||
+		    !mp->archdata_start)
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
+++ linux-mips-2.4.5-20010704/arch/mips64/sgi-ip22/ip22-berr.c	Mon Aug 20 00:25:46 2001
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
@@ -41,16 +44,42 @@ search_one_table(const struct exception_
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
+		if (!mod_member_present(mp, archdata_start) ||
+		    !mp->archdata_start)
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
+++ linux-mips-2.4.5-20010704/arch/mips64/sgi-ip27/ip27-berr.c	Mon Aug 20 13:39:45 2001
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
@@ -43,16 +46,42 @@ search_one_table(const struct exception_
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
+		if (!mod_member_present(mp, archdata_start) ||
+		    !mp->archdata_start)
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
+++ linux-mips-2.4.5-20010704/include/asm-alpha/module.h	Sun Aug 19 20:07:45 2001
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
+                printk(KERN_ERR "arch_init_module: mod->gp out of bounds.\n");
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
+++ linux-mips-2.4.5-20010704/include/asm-ia64/module.h	Mon Aug 20 01:12:14 2001
@@ -14,6 +14,7 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		ia64_module_unmap(x)
 #define module_arch_init(x)	ia64_module_init(x)
+#define arch_init_modules(x)	do { } while (0)
 
 /*
  * This must match in size and layout the data created by
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
+++ linux-mips-2.4.5-20010704/include/asm-mips/module.h	Mon Aug 20 00:18:19 2001
@@ -4,8 +4,61 @@
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
+	if (!mod_member_present(mod, archdata_start) || !mod->archdata_start)
+		return 0;
+	archdata = (struct archdata *)(mod->archdata_start);
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
+			"arch_init_module: archdata->dbe_table_* invalid.\n");
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
+++ linux-mips-2.4.5-20010704/include/asm-mips64/module.h	Mon Aug 20 00:18:32 2001
@@ -4,8 +4,61 @@
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
+	if (!mod_member_present(mod, archdata_start) || !mod->archdata_start)
+		return 0;
+	archdata = (struct archdata *)(mod->archdata_start);
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
+			"arch_init_module: archdata->dbe_table_* invalid.\n");
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
