Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DDkQ208384
	for linux-mips-outgoing; Mon, 13 Aug 2001 06:46:26 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DDkMj08377
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:46:22 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08565
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 06:44:49 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA21352;
	Mon, 13 Aug 2001 15:38:36 +0200 (MET DST)
Date: Mon, 13 Aug 2001 15:38:36 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>, Harald Koerfgen <hkoerfg@web.de>,
   Keith Owens <kaos@ocs.com.au>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: [patch] linux 2.4.5: Make __dbe_table available to modules
Message-ID: <Pine.GSO.3.96.1010813152644.18279G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

 Unlike most architectures which only handle memory faults/privilege
violations via __ex_table, the MIPS port allows to handle bus error
exceptions via __dbe_table. Unfortunately, the latter table is not
exported to modules, so if a modularized driver needs to probe the address
space for a device it's out of luck.

 The following patch implements the kernel part of __dbe_table support.  A
separate patch is needed for modutils.

 A side effect of the patch is a fix to unhandled bus error exceptions
which happen in the kernel mode.  Currently they cause the faulting code
to be reexecuted which results in a hang in an infinite loop.  With the
patch applied, the kernel's response is an "Oops" similar to the one
printed when a memory fault happens.

 I hope it's fine to apply.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010704-dbe-0
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c
--- linux-mips-2.4.5-20010704.macro/arch/mips/kernel/traps.c	Fri Jun 15 04:27:07 2001
+++ linux-mips-2.4.5-20010704/arch/mips/kernel/traps.c	Sun Aug 12 17:34:55 2001
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/smp_lock.h>
@@ -254,23 +255,59 @@ search_one_table(const struct exception_
 	return (first == last && first->insn == value) ? first->nextinsn : 0;
 }
 
-#define search_dbe_table(addr)	\
-	search_one_table(__start___dbe_table, __stop___dbe_table - 1, (addr))
+extern spinlock_t modlist_lock;
+
+static unsigned long
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
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	for (mp = module_list; mp != NULL; mp = mp->next) {
+		if (mp->dbe_table_start == NULL || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
+			continue;
+		ret = search_one_table(mp->dbe_table_start,
+				       mp->dbe_table_end - 1, addr);
+		if (ret)
+			break;
+	}
+        spin_unlock_irqrestore(&modlist_lock, flags);
+	return ret;
+#endif
+}
 
 static void default_be_board_handler(struct pt_regs *regs)
 {
 	unsigned long new_epc;
-	unsigned long fixup = search_dbe_table(regs->cp0_epc);
+	unsigned long fixup;
 
-	if (fixup) {
-		new_epc = fixup_exception(dpf_reg, fixup, regs->cp0_epc);
-		regs->cp0_epc = new_epc;
-		return;
+	if (!user_mode(regs)) {
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
+	       (regs->cp0_cause & 4) ? "Data" : "Instruction",
+	       regs->cp0_epc, regs->regs[31]);
+	die_if_kernel("Oops", regs);
 	force_sig(SIGBUS, current);
 }
 
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/include/linux/module.h linux-mips-2.4.5-20010704/include/linux/module.h
--- linux-mips-2.4.5-20010704.macro/include/linux/module.h	Mon Jul 16 02:13:58 2001
+++ linux-mips-2.4.5-20010704/include/linux/module.h	Sun Aug 12 11:22:09 2001
@@ -75,6 +75,10 @@ struct module
 	void (*cleanup)(void);
 	const struct exception_table_entry *ex_table_start;
 	const struct exception_table_entry *ex_table_end;
+#ifdef __mips__
+	const struct exception_table_entry *dbe_table_start;
+	const struct exception_table_entry *dbe_table_end;
+#endif
 #ifdef __alpha__
 	unsigned long gp;
 #endif
diff -up --recursive --new-file linux-mips-2.4.5-20010704.macro/kernel/module.c linux-mips-2.4.5-20010704/kernel/module.c
--- linux-mips-2.4.5-20010704.macro/kernel/module.c	Thu Jun 14 04:28:48 2001
+++ linux-mips-2.4.5-20010704/kernel/module.c	Sun Aug 12 11:24:53 2001
@@ -36,6 +36,11 @@ extern struct module_symbol __stop___ksy
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 
+#ifdef __mips__
+extern const struct exception_table_entry __start___dbe_table[];
+extern const struct exception_table_entry __stop___dbe_table[];
+#endif
+
 extern const char __start___kallsyms[] __attribute__ ((weak));
 extern const char __stop___kallsyms[] __attribute__ ((weak));
 
@@ -48,6 +53,10 @@ static struct module kernel_module =
 	syms:			__start___ksymtab,
 	ex_table_start:		__start___ex_table,
 	ex_table_end:		__stop___ex_table,
+#ifdef __mips__
+	dbe_table_start:	__start___dbe_table,
+	dbe_table_end:		__stop___dbe_table,
+#endif
 	kallsyms_start:		__start___kallsyms,
 	kallsyms_end:		__stop___kallsyms,
 };
@@ -436,6 +445,19 @@ sys_init_module(const char *name_user, s
 		printk(KERN_ERR "init_module: mod->ex_table_* invalid.\n");
 		goto err2;
 	}
+#ifdef __mips__
+	if (mod->dbe_table_start > mod->dbe_table_end
+	    || (mod->dbe_table_start &&
+		!((unsigned long)mod->dbe_table_start >= ((unsigned long)mod + mod->size_of_struct)
+		  && ((unsigned long)mod->dbe_table_end
+		      < (unsigned long)mod + mod->size)))
+	    || (((unsigned long)mod->dbe_table_start
+		 - (unsigned long)mod->dbe_table_end)
+		% sizeof(struct exception_table_entry))) {
+		printk(KERN_ERR "init_module: mod->dbe_table_* invalid.\n");
+		goto err2;
+	}
+#endif
 	if (mod->flags & ~MOD_AUTOCLEAN) {
 		printk(KERN_ERR "init_module: mod->flags invalid.\n");
 		goto err2;
