Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7T0vbR08044
	for linux-mips-outgoing; Tue, 28 Aug 2001 17:57:37 -0700
Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7T0vJd08038
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 17:57:19 -0700
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via SMTP id RAA01879
	for <linux-mips@oss.sgi.com>; Tue, 28 Aug 2001 17:55:34 -0700 (PDT)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com (kao2.melbourne.sgi.com [134.14.55.180]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA01447; Wed, 29 Aug 2001 11:55:53 +1100
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: [patch] 2.4.9-ac3 module archdata code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Aug 2001 10:55:53 +1000
Message-ID: <20171.999046553@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You already have part of this work in 2.4.9-ac3, from an older version
of the patch via the mips group.  The real work was done by Maciej W.
Rozycki, I just merged up to 2.4.9-ac3.

Move arch specific module initialisation code into arch_init_modules().
More rigorous error checking on module archdata for mips.

Index: 9.13/kernel/module.c
--- 9.13/kernel/module.c Mon, 13 Aug 2001 14:14:10 +1000 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1 644)
+++ 9.13(w)/kernel/module.c Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/j/45_module.c 1.1.2.1.3.1.3.1 644)
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
Index: 9.13/include/asm-s390/module.h
--- 9.13/include/asm-s390/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/m/1_module.h 1.1 644)
+++ 9.13(w)/include/asm-s390/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/m/1_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_S390_MODULE_H */
Index: 9.13/include/asm-mips64/module.h
--- 9.13/include/asm-mips64/module.h Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/n/42_module.h 1.2 644)
+++ 9.13(w)/include/asm-mips64/module.h Wed, 29 Aug 2001 10:31:21 +1000 kaos (linux-2.4/n/42_module.h 1.2 644)
@@ -26,9 +26,12 @@ mips64_module_init(struct module *mod)
 {
 	struct archdata *archdata;
 
-	if (!mod_member_present(mod, archdata_start) || !mod->archdata_start)
+	if (!mod_member_present(mod, archdata_end))
 		return 0;
+
 	archdata = (struct archdata *)(mod->archdata_start);
+	if (!mod_archdata_member_present(mod, struct archdata, dbe_table_end))
+		return 0;
 
 	if (archdata->dbe_table_start > archdata->dbe_table_end ||
 	    (archdata->dbe_table_start &&
@@ -40,7 +43,7 @@ mips64_module_init(struct module *mod)
 	      (unsigned long)archdata->dbe_table_end) %
 	     sizeof(struct exception_table_entry))) {
 		printk(KERN_ERR
-			"arch_init_module: archdata->dbe_table_* invalid.\n");
+			"module_arch_init: archdata->dbe_table_* invalid.\n");
 		return 1;
 	}
 
Index: 9.13/include/asm-ia64/module.h
--- 9.13/include/asm-ia64/module.h Wed, 18 Apr 2001 11:00:10 +1000 kaos (linux-2.4/s/14_module.h 1.1.1.2 644)
+++ 9.13(w)/include/asm-ia64/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/s/14_module.h 1.1.1.2 644)
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
 
Index: 9.13/include/asm-sh/module.h
--- 9.13/include/asm-sh/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/u/27_module.h 1.1 644)
+++ 9.13(w)/include/asm-sh/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/u/27_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SH_MODULE_H */
Index: 9.13/include/asm-arm/module.h
--- 9.13/include/asm-arm/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/y/5_module.h 1.1 644)
+++ 9.13(w)/include/asm-arm/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/y/5_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_ARM_MODULE_H */
Index: 9.13/include/asm-sparc64/module.h
--- 9.13/include/asm-sparc64/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/C/9_module.h 1.1 644)
+++ 9.13(w)/include/asm-sparc64/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/C/9_module.h 1.1 644)
@@ -7,5 +7,6 @@
 extern void * module_map (unsigned long size);
 extern void module_unmap (void *addr);
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SPARC64_MODULE_H */
Index: 9.13/include/asm-ppc/module.h
--- 9.13/include/asm-ppc/module.h Wed, 23 May 2001 11:55:33 +1000 kaos (linux-2.4/E/30_module.h 1.2 644)
+++ 9.13(w)/include/asm-ppc/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/E/30_module.h 1.2 644)
@@ -10,5 +10,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_PPC_MODULE_H */
Index: 9.13/include/asm-sparc/module.h
--- 9.13/include/asm-sparc/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/J/0_module.h 1.1 644)
+++ 9.13(w)/include/asm-sparc/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/J/0_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_SPARC_MODULE_H */
Index: 9.13/include/asm-m68k/module.h
--- 9.13/include/asm-m68k/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/L/50_module.h 1.1 644)
+++ 9.13(w)/include/asm-m68k/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/L/50_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_M68K_MODULE_H */
Index: 9.13/include/asm-alpha/module.h
--- 9.13/include/asm-alpha/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/O/27_module.h 1.1 644)
+++ 9.13(w)/include/asm-alpha/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/O/27_module.h 1.1 644)
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
Index: 9.13/include/asm-mips/module.h
--- 9.13/include/asm-mips/module.h Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/Q/30_module.h 1.2 644)
+++ 9.13(w)/include/asm-mips/module.h Wed, 29 Aug 2001 10:31:50 +1000 kaos (linux-2.4/Q/30_module.h 1.2 644)
@@ -26,9 +26,12 @@ mips_module_init(struct module *mod)
 {
 	struct archdata *archdata;
 
-	if (!mod_member_present(mod, archdata_start) || !mod->archdata_start)
+	if (!mod_member_present(mod, archdata_end))
 		return 0;
+
 	archdata = (struct archdata *)(mod->archdata_start);
+	if (!mod_archdata_member_present(mod, struct archdata, dbe_table_end))
+		return 0;
 
 	if (archdata->dbe_table_start > archdata->dbe_table_end ||
 	    (archdata->dbe_table_start &&
@@ -40,7 +43,7 @@ mips_module_init(struct module *mod)
 	      (unsigned long)archdata->dbe_table_end) %
 	     sizeof(struct exception_table_entry))) {
 		printk(KERN_ERR
-			"arch_init_module: archdata->dbe_table_* invalid.\n");
+			"module_arch_init: archdata->dbe_table_* invalid.\n");
 		return 1;
 	}
 
Index: 9.13/include/asm-i386/module.h
--- 9.13/include/asm-i386/module.h Fri, 05 Jan 2001 13:42:29 +1100 kaos (linux-2.4/T/10_module.h 1.1 644)
+++ 9.13(w)/include/asm-i386/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/T/10_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_I386_MODULE_H */
Index: 9.13/include/linux/module.h
--- 9.13/include/linux/module.h Sun, 04 Feb 2001 17:53:11 +1100 kaos (linux-2.4/c/b/46_module.h 1.1.1.1 644)
+++ 9.13(w)/include/linux/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/c/b/46_module.h 1.1.1.1 644)
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
Index: 9.13/arch/mips64/sgi-ip27/ip27-berr.c
--- 9.13/arch/mips64/sgi-ip27/ip27-berr.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/o/c/10_ip27-berr. 1.2 644)
+++ 9.13(w)/arch/mips64/sgi-ip27/ip27-berr.c Wed, 29 Aug 2001 10:32:56 +1000 kaos (linux-2.4/o/c/10_ip27-berr. 1.2 644)
@@ -66,8 +66,9 @@ search_dbe_table(unsigned long addr)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (!mod_member_present(mp, archdata_start) ||
-		    !mp->archdata_start)
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mod->archdata_start);
 
Index: 9.13/arch/mips64/sgi-ip22/ip22-berr.c
--- 9.13/arch/mips64/sgi-ip22/ip22-berr.c Mon, 27 Aug 2001 09:52:57 +1000 kaos (linux-2.4/o/c/24_ip22-berr. 1.2 644)
+++ 9.13(w)/arch/mips64/sgi-ip22/ip22-berr.c Wed, 29 Aug 2001 10:33:33 +1000 kaos (linux-2.4/o/c/24_ip22-berr. 1.2 644)
@@ -63,8 +63,9 @@ search_dbe_table(unsigned long addr)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (!mod_member_present(mp, archdata_start) ||
-		    !mp->archdata_start)
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mod->archdata_start);
 
Index: 9.13/arch/mips/kernel/traps.c
--- 9.13/arch/mips/kernel/traps.c Tue, 28 Aug 2001 12:42:15 +1000 kaos (linux-2.4/M/c/26_traps.c 1.1.2.1.1.2 644)
+++ 9.13(w)/arch/mips/kernel/traps.c Wed, 29 Aug 2001 10:35:46 +1000 kaos (linux-2.4/M/c/26_traps.c 1.1.2.1.1.2 644)
@@ -267,8 +267,9 @@ search_dbe_table(unsigned long addr)
 
 	spin_lock_irqsave(&modlist_lock, flags);
 	for (mp = module_list; mp != NULL; mp = mp->next) {
-		if (!mod_member_present(mp, archdata_start) ||
-		    !mp->archdata_start)
+		if (!mod_member_present(mp, archdata_end) ||
+        	    !mod_archdata_member_present(mp, struct archdata,
+						 dbe_table_end))
 			continue;
 		ap = (struct archdata *)(mp->archdata_start);
 
Index: 9.13/include/asm-cris/module.h
--- 9.13/include/asm-cris/module.h Fri, 09 Feb 2001 12:54:37 +1100 kaos (linux-2.4/o/d/11_module.h 1.1 644)
+++ 9.13(w)/include/asm-cris/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/o/d/11_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_CRIS_MODULE_H */
Index: 9.13/include/asm-s390x/module.h
--- 9.13/include/asm-s390x/module.h Sat, 17 Feb 2001 11:35:44 +1100 kaos (linux-2.4/r/d/47_module.h 1.1 644)
+++ 9.13(w)/include/asm-s390x/module.h Wed, 29 Aug 2001 10:11:37 +1000 kaos (linux-2.4/r/d/47_module.h 1.1 644)
@@ -7,5 +7,6 @@
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
 #define module_arch_init(x)	(0)
+#define arch_init_modules(x)	do { } while (0)
 
 #endif /* _ASM_S390_MODULE_H */
