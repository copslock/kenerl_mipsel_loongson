Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86C7mE15088
	for linux-mips-outgoing; Thu, 6 Sep 2001 05:07:48 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86C6Xd15032;
	Thu, 6 Sep 2001 05:06:34 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA28664;
	Thu, 6 Sep 2001 14:08:43 +0200 (MET DST)
Date: Thu, 6 Sep 2001 14:08:43 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.8: __dbe_table resync
In-Reply-To: <Pine.GSO.3.96.1010828145209.20137C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.GSO.3.96.1010906134003.27614F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

 This is an update to the current implementation of __dbe_table handling. 
The code matches one in 2.4.9-ac9 with an exception of a small fix that
goes to Alan independently and is already taken into account here.  Please
apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.8-20010903-dbe-14
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/arch/mips/kernel/traps.c linux-mips-2.4.8-20010903/arch/mips/kernel/traps.c
--- linux-mips-2.4.8-20010903.macro/arch/mips/kernel/traps.c	Sat Aug 25 04:27:08 2001
+++ linux-mips-2.4.8-20010903/arch/mips/kernel/traps.c	Wed Sep  5 22:49:24 2001
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/arch/mips64/sgi-ip22/ip22-berr.c linux-mips-2.4.8-20010903/arch/mips64/sgi-ip22/ip22-berr.c
--- linux-mips-2.4.8-20010903.macro/arch/mips64/sgi-ip22/ip22-berr.c	Wed Aug 22 04:26:17 2001
+++ linux-mips-2.4.8-20010903/arch/mips64/sgi-ip22/ip22-berr.c	Wed Sep  5 22:49:24 2001
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/arch/mips64/sgi-ip27/ip27-berr.c linux-mips-2.4.8-20010903/arch/mips64/sgi-ip27/ip27-berr.c
--- linux-mips-2.4.8-20010903.macro/arch/mips64/sgi-ip27/ip27-berr.c	Wed Aug 22 04:26:17 2001
+++ linux-mips-2.4.8-20010903/arch/mips64/sgi-ip27/ip27-berr.c	Wed Sep  5 22:49:24 2001
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/include/asm-alpha/module.h linux-mips-2.4.8-20010903/include/asm-alpha/module.h
--- linux-mips-2.4.8-20010903.macro/include/asm-alpha/module.h	Wed Aug 22 04:27:42 2001
+++ linux-mips-2.4.8-20010903/include/asm-alpha/module.h	Wed Sep  5 22:49:24 2001
@@ -13,7 +13,7 @@ static inline int
 alpha_module_init(struct module *mod)
 {
         if (!mod_bound(mod->gp - 0x8000, 0, mod)) {
-                printk(KERN_ERR "arch_init_module: mod->gp out of bounds.\n");
+                printk(KERN_ERR "module_arch_init: mod->gp out of bounds.\n");
                 return 1;
         }
 	return 0;
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/include/asm-ia64/module.h linux-mips-2.4.8-20010903/include/asm-ia64/module.h
--- linux-mips-2.4.8-20010903.macro/include/asm-ia64/module.h	Wed Aug 22 04:27:44 2001
+++ linux-mips-2.4.8-20010903/include/asm-ia64/module.h	Wed Sep  5 22:58:19 2001
@@ -47,27 +47,27 @@ ia64_module_init(struct module *mod)
 
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/include/asm-mips/module.h linux-mips-2.4.8-20010903/include/asm-mips/module.h
--- linux-mips-2.4.8-20010903.macro/include/asm-mips/module.h	Wed Aug 22 04:27:47 2001
+++ linux-mips-2.4.8-20010903/include/asm-mips/module.h	Wed Sep  5 22:49:24 2001
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/include/asm-mips64/module.h linux-mips-2.4.8-20010903/include/asm-mips64/module.h
--- linux-mips-2.4.8-20010903.macro/include/asm-mips64/module.h	Wed Aug 22 04:27:48 2001
+++ linux-mips-2.4.8-20010903/include/asm-mips64/module.h	Wed Sep  5 22:49:24 2001
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
 
diff -up --recursive --new-file linux-mips-2.4.8-20010903.macro/include/linux/module.h linux-mips-2.4.8-20010903/include/linux/module.h
--- linux-mips-2.4.8-20010903.macro/include/linux/module.h	Mon Jul 16 02:13:58 2001
+++ linux-mips-2.4.8-20010903/include/linux/module.h	Fri Aug 24 00:50:22 2001
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
