Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4UCaFn27509
	for linux-mips-outgoing; Wed, 30 May 2001 05:36:15 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4UCZXh27479
	for <linux-mips@oss.sgi.com>; Wed, 30 May 2001 05:35:33 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id WAA151484
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 22:58:17 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 154U5d-00082y-00
	for <linux-mips@oss.sgi.com>; Mon, 28 May 2001 22:58:13 +0200
Date: Mon, 28 May 2001 22:58:13 +0200
To: linux-mips@oss.sgi.com
Subject: [PATCH] More (mostly minor) fixes mostly for mips64
Message-ID: <20010528225813.A14867@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello All,

This patch does for both mips and mips64:

- save return address in process:kernel_thread (How did this ever work?)
- code cosmetics and removal of unused code

and for mips64 only:

- introduce CPU_R12000
- correct use of CONFIG_BOARD_CACHE
- fix undefined expression evaluation in lib/dump_tlb.c
- fix possible counter overflow in sgi-ip22/ip22-timer.c:dosample
- some minor fixes due to bitrot
- more code cosmetics, removal of unused code, typo fixes, etc.


Thiemo


diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips/kernel/entry.S linux/arch/mips/kernel/entry.S
--- linux-orig/arch/mips/kernel/entry.S	Thu Mar 29 17:11:05 2001
+++ linux/arch/mips/kernel/entry.S	Sat May 26 01:24:21 2001
@@ -27,7 +27,7 @@
 #include <asm/isadep.h>
 
 		.text
-		.align 4
+		.align	5
 		.set	push
 		.set	reorder
 EXPORT(ret_from_fork)
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux-orig/arch/mips/kernel/process.c	Thu Mar 29 17:11:05 2001
+++ linux/arch/mips/kernel/process.c	Sat May 26 01:24:21 2001
@@ -186,7 +186,7 @@
 		  * at, result, argument or temporary registers ...
 		  */
 		:"$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8",
-		 "$9","$10","$11","$12","$13","$14","$15","$24","$25");
+		 "$9","$10","$11","$12","$13","$14","$15","$24","$25", "$31");
 
 	return retval;
 }
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips/tools/Makefile linux/arch/mips/tools/Makefile
--- linux-orig/arch/mips/tools/Makefile	Sat May 27 13:53:31 2000
+++ linux/arch/mips/tools/Makefile	Sat May 26 01:24:21 2001
@@ -23,8 +23,7 @@
 clean:
 	rm -f offset.[hs] $(TARGET).new
 	
-mrproper:	
-	rm -f offset.[hs] $(TARGET).new
+mrproper: clean:
 	rm -f $(TARGET)
 
 include $(TOPDIR)/Rules.make
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips/arc/init.c linux/arch/mips/arc/init.c
--- linux-orig/arch/mips/arc/init.c	Fri Feb  9 19:38:49 2001
+++ linux/arch/mips/arc/init.c	Sat May 26 01:24:21 2001
@@ -16,10 +16,8 @@
 
 /* Master romvec interface. */
 struct linux_romvec *romvec;
-struct linux_promblock *sgi_pblock;
 int prom_argc;
 char **prom_argv, **prom_envp;
-unsigned short prom_vers, prom_rev;
 
 extern void prom_testtree(void);
 
@@ -28,9 +26,10 @@
 void __init prom_init(int argc, char **argv, char **envp, int *prom_vec)
 {
 	struct linux_promblock *pb;
+	unsigned short prom_vers, prom_rev;
 
 	romvec = ROMVECTOR;
-	pb = sgi_pblock = PROMBLOCK;
+	pb = PROMBLOCK;
 	prom_argc = argc;
 	prom_argv = argv;
 	prom_envp = envp;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/arc/identify.c linux/arch/mips64/arc/identify.c
--- linux-orig/arch/mips64/arc/identify.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/arc/identify.c	Sat May 26 01:24:23 2001
@@ -63,9 +64,11 @@
 	p = ArcGetChild(PROM_NULL_COMPONENT);
 	if (p == NULL) {
 #ifdef CONFIG_SGI_IP27
-		/* IP27 PROM bisbehaves, seems to not implement ARC
+		/* IP27 PROM misbehaves, seems to not implement ARC
 		   GetChild().  So we just assume it's an IP27.  */
 		iname = "SGI-IP27";
+#else
+		iname = "Unknown";
 #endif
 	} else
 		iname = (char *) (long) p->iname;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/arc/init.c linux/arch/mips64/arc/init.c
--- linux-orig/arch/mips64/arc/init.c	Tue Mar  7 16:45:28 2000
+++ linux/arch/mips64/arc/init.c	Sat May 26 01:24:23 2001
@@ -17,43 +17,35 @@
 
 /* Master romvec interface. */
 struct linux_romvec *romvec;
-PSYSTEM_PARAMETER_BLOCK sgi_pblock;
 int prom_argc;
 LONG *_prom_argv, *_prom_envp;
-unsigned short prom_vers, prom_rev;
-
-extern void prom_testtree(void);
 
 int __init
 prom_init(int argc, char **argv, char **envp)
 {
-	PSYSTEM_PARAMETER_BLOCK pb;
-
+	PSYSTEM_PARAMETER_BLOCK pb = PROMBLOCK;
 	romvec = ROMVECTOR;
-	pb = sgi_pblock = PROMBLOCK;
 	prom_argc = argc;
 	_prom_argv = (LONG *) argv;
 	_prom_envp = (LONG *) envp;
 
-	if(pb->magic != 0x53435241) {
-		prom_printf("Aieee, bad prom vector magic %08lx\n", pb->magic);
+  	if(pb->magic != 0x53435241) {
+		prom_printf("Aieee, bad prom vector magic %08lx\n",
+			    pb->magic);
 		while(1)
 			;
 	}
 
 	prom_init_cmdline();
-
-	prom_vers = pb->ver;
-	prom_rev = pb->rev;
 	prom_identify_arch();
 	printk("PROMLIB: ARC firmware Version %d Revision %d\n",
-		    prom_vers, prom_rev);
+	       pb->ver, pb->rev);
 	prom_meminit();
 
 #ifdef DEBUG_PROM_INIT
 	{
 		prom_printf("Press a key to reboot\n");
-		(void) prom_getchar();
+		prom_getchar();
 		ArcEnterInteractiveMode();
 	}
 #endif
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/arc/memory.c linux/arch/mips64/arc/memory.c
--- linux-orig/arch/mips64/arc/memory.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/arc/memory.c	Sat May 26 01:24:23 2001
@@ -141,7 +141,6 @@
 void __init
 prom_free_prom_memory (void)
 {
-	struct prom_pmemblock *p;
 	unsigned long freed = 0;
 	unsigned long addr;
 	int i;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/linux32.c linux/arch/mips64/kernel/linux32.c
--- linux-orig/arch/mips64/kernel/linux32.c	Thu Apr  5 20:25:43 2001
+++ linux/arch/mips64/kernel/linux32.c	Sat May 26 01:24:23 2001
@@ -406,10 +406,10 @@
 		/* egcs is stupid */
 		if (!access_ok(VERIFY_READ, arg, sizeof (unsigned int)))
 			return -EFAULT;
-		if (IS_ERR(ret = __get_user((long)ptr,(int *)A(arg))))
+		if ((ret = __get_user((long)ptr, (int *)A(arg))))
 			return ret;
 		if (ap)		/* no access_ok needed, we allocated */
-			if (IS_ERR(ret = __put_user(ptr, ap++)))
+			if ((ret = __put_user(ptr, ap++)))
 				return ret;
 		arg += sizeof(unsigned int);
 		n++;
@@ -429,10 +429,10 @@
 	char * filename;
 
 	na = nargs(argv, NULL);
-	if (IS_ERR(na))
+	if (na)
 		return(na);
 	ne = nargs(envp, NULL);
-	if (IS_ERR(ne))
+	if (ne)
 		return(ne);
 	len = (na + ne + 2) * sizeof(*av);
 	/*
@@ -441,7 +441,7 @@
 	 *  on a kernel address (simplifies `get_user').  Instead we
 	 *  do an mmap to get a user address.  Note that since a successful
 	 *  `execve' frees all current memory we only have to do an
-	 *  `munmap' if the `execve' failes.
+	 *  `munmap' if the `execve' fails.
 	 */
 	down_write(&current->mm->mmap_sem);
 	av = (char **) do_mmap_pgoff(0, 0, len, PROT_READ | PROT_WRITE,
@@ -451,13 +451,13 @@
 	if (IS_ERR(av))
 		return (long) av;
 	ae = av + na + 1;
-	if (IS_ERR(r = __put_user(0, (av + na))))
+	if ((r = __put_user(0, (av + na))))
 		goto out;
-	if (IS_ERR(r = __put_user(0, (ae + ne))))
+	if ((r = __put_user(0, (ae + ne))))
 		goto out;
-	if (IS_ERR(r = nargs(argv, av)))
+	if ((r = nargs(argv, av)))
 		goto out;
-	if (IS_ERR(r = nargs(envp, ae)))
+	if ((r = nargs(envp, ae)))
 		goto out;
 	filename = getname((char *) (long)regs.regs[4]);
 	r = PTR_ERR(filename);
@@ -466,7 +466,7 @@
 
 	r = do_execve(filename, av, ae, &regs);
 	putname(filename);
-	if (IS_ERR(r))
+	if (r)
 out:
 		sys_munmap((unsigned long)av, len);
 	return(r);
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/process.c linux/arch/mips64/kernel/process.c
--- linux-orig/arch/mips64/kernel/process.c	Wed Mar 14 17:11:47 2001
+++ linux/arch/mips64/kernel/process.c	Sat May 26 01:24:24 2001
@@ -173,7 +173,7 @@
 		 /* The called subroutine might have destroyed any of the
 		  * at, result, argument or temporary registers ...  */
 		:"$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8",
-		 "$9","$10","$11","$12","$13","$14","$15","$24","$25");
+		 "$9","$10","$11","$12","$13","$14","$15","$24","$25", "$31");
 
 	return retval;
 }
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/setup.c linux/arch/mips64/kernel/setup.c
--- linux-orig/arch/mips64/kernel/setup.c	Sat May 26 00:25:39 2001
+++ linux/arch/mips64/kernel/setup.c	Sat May 26 01:24:25 2001
@@ -99,6 +99,8 @@
 extern void ip22_setup(void);
 extern void ip27_setup(void);
 
+extern void bootmem_init(void);
+
 static inline void cpu_probe(void)
 {
 	unsigned int prid = read_32bit_cp0_register(CP0_PRID);
@@ -126,9 +128,11 @@
 		mips_cputype = CPU_R8000;
 		break;
 	case PRID_IMP_R10000:
-	case PRID_IMP_R12000:
 		mips_cputype = CPU_R10000;
 		break;
+	case PRID_IMP_R12000:
+		mips_cputype = CPU_R12000;
+		break;
 	default:
 		mips_cputype = CPU_UNKNOWN;
 	}
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/signal.c linux/arch/mips64/kernel/signal.c
--- linux-orig/arch/mips64/kernel/signal.c	Fri Feb  9 19:38:53 2001
+++ linux/arch/mips64/kernel/signal.c	Sat May 26 01:24:25 2001
@@ -601,11 +601,6 @@
 	}
 #endif
 
-#ifdef CONFIG_BINFMT_IRIX
-	if (current->personality != PER_LINUX)
-		return do_irix_signal(oldset, regs);
-#endif
-
 	if (!oldset)
 		oldset = &current->blocked;
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/softfp.S linux/arch/mips64/kernel/softfp.S
--- linux-orig/arch/mips64/kernel/softfp.S	Mon Jul 10 01:59:56 2000
+++ linux/arch/mips64/kernel/softfp.S	Sat May 26 02:42:41 2001
@@ -46,7 +46,7 @@
 #define ft_shift	16
 
 /*
- * NaNs as use by the MIPS architecture
+ * NaNs as used by the MIPS architecture
  */
 #define S_QNaN		0x7fbfffff
 #define D_QNaN		0x7ff7ffffffffffff
@@ -70,7 +70,7 @@
 	and	reg, res
 
 /*
- * Some constants that define the properties of single precission numbers.
+ * Some constants that define the properties of single precision numbers.
  */
 #define S_M_prec	24
 #define S_E_max		127
@@ -103,7 +103,7 @@
 
 
 /*
- * Some constants that define the properties of double precission numbers.
+ * Some constants that define the properties of double precision numbers.
  */
 #define D_M_prec	53
 #define D_E_max		1023
@@ -366,7 +366,7 @@
 	/* XXX Ok, it's a normal number.  We don't handle that case yet.
 	   If we have fp hardware this case is only reached if the value
 	   of the source register exceeds the range which is representable
-	   in a single precission register.  For now we kludge by returning
+	   in a single precision register.  For now we kludge by returning
 	   +/- maxint and don't signal overflow. */
 
 	srl	ta1, ta1, 31		# Extract sign bit
@@ -407,7 +407,7 @@
 	BITCH(c.le)
 	BITCH(c.ngt)
 
-/* Get the single precission register which's number is in ta1.  */
+/* Get the single precision register which's number is in ta1.  */
 s_get_fpreg:
 	.set	noat
 	sll	ta1, 3
@@ -482,7 +482,7 @@
 	jr	ra
 
 /*
- * Put the value in ta2 into the single precission register which's number
+ * Put the value in ta2 into the single precision register which's number
  * is in ta1.
  */
 s_put_fpreg:
@@ -558,7 +558,7 @@
 	mtc1	ta2, $31
 	jr	ra
 
-/* Get the double precission register which's number is in ta1 into ta1/ta2.  */
+/* Get the double precision register which's number is in ta1 into ta1/ta2.  */
 d_get_fpreg:
 	.set	noat
 	sll	AT, ta1, 1
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/traps.c linux/arch/mips64/kernel/traps.c
--- linux-orig/arch/mips64/kernel/traps.c	Mon Mar  5 00:56:10 2001
+++ linux/arch/mips64/kernel/traps.c	Sat May 26 02:28:13 2001
@@ -382,6 +382,7 @@
 static inline void watch_init(unsigned long cputype)
 {
 	switch(cputype) {
+	case CPU_R12000:
 	case CPU_R10000:
 	case CPU_R4000MC:
 	case CPU_R4400MC:
@@ -440,6 +441,7 @@
 	case CPU_NEVADA:
 	case CPU_R8000:
 	case CPU_R10000:
+	case CPU_R12000:
 		mips4_available = 1;
 		set_cp0_status(ST0_XX, ST0_XX);
 	}
@@ -489,13 +487,13 @@
 	 * Handling the following exceptions depends mostly of the cpu type
 	 */
 	switch(mips_cputype) {
+	case CPU_R12000:
 	case CPU_R10000:
 		/*
 		 * The R10000 is in most aspects similar to the R4400.  It
 		 * should get some special optimizations.
 		 */
 		write_32bit_cp0_register(CP0_FRAMEMASK, 0);
-		set_cp0_status(ST0_XX, ST0_XX);
 		goto r4k;
 
 	case CPU_R4000MC:
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/kernel/unaligned.c linux/arch/mips64/kernel/unaligned.c
--- linux-orig/arch/mips64/kernel/unaligned.c	Wed Mar 14 17:11:47 2001
+++ linux/arch/mips64/kernel/unaligned.c	Sat May 26 01:24:25 2001
@@ -87,6 +87,9 @@
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
 
+extern void
+die_if_kernel(const char * str, struct pt_regs * regs, unsigned long err);
+
 /*
  * User code may only access USEG; kernel code may access the
  * entire address space.
@@ -365,15 +368,15 @@
 		return;
 	}
 
-	die_if_kernel ("Unhandled kernel unaligned access", regs);
+	die_if_kernel ("Unhandled kernel unaligned access", regs, SIGSEGV);
 	send_sig(SIGSEGV, current, 1);
 	return;
 sigbus:
-	die_if_kernel ("Unhandled kernel unaligned access", regs);
+	die_if_kernel ("Unhandled kernel unaligned access", regs, SIGBUS);
 	send_sig(SIGBUS, current, 1);
 	return;
 sigill:
-	die_if_kernel ("Unhandled kernel unaligned access or invalid instruction", regs);
+	die_if_kernel ("Unhandled kernel unaligned access or invalid instruction", regs, SIGILL);
 	send_sig(SIGILL, current, 1);
 	return;
 }
@@ -404,6 +407,6 @@
 	return;
 
 sigbus:
-	die_if_kernel ("Kernel unaligned instruction access", regs);
+	die_if_kernel ("Kernel unaligned instruction access", regs, SIGBUS);
 	force_sig(SIGBUS, current);
 }
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/lib/dump_tlb.c linux/arch/mips64/lib/dump_tlb.c
--- linux-orig/arch/mips64/lib/dump_tlb.c	Sat Jul  8 02:53:02 2000
+++ linux/arch/mips64/lib/dump_tlb.c	Sat May 26 01:24:25 2001
@@ -200,8 +200,10 @@
 	for(i=0;i<8;i++)
 	{
 		printk("*%08lx == %08lx, ",
-		       (unsigned long)p, (unsigned long)*p++);
+		       (unsigned long)p, (unsigned long)*p);
+		p++;
 		printk("*%08lx == %08lx\n",
-		       (unsigned long)p, (unsigned long)*p++);
+		       (unsigned long)p, (unsigned long)*p);
+		p++;
 	}
 }
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/init.c linux/arch/mips64/mm/init.c
--- linux-orig/arch/mips64/mm/init.c	Sat May 26 00:25:39 2001
+++ linux/arch/mips64/mm/init.c	Sat May 26 02:29:36 2001
@@ -177,6 +177,7 @@
         boot_mem_map.nr_map++;
 }
 
+#ifdef DEBUG
 static void __init print_memory_map(void)
 {
         int i;
@@ -200,6 +201,7 @@
                 }
         }
 }
+#endif /* DEBUG */
 
 void bootmem_init(void) {
 #ifdef CONFIG_BLK_DEV_INITRD
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/mm/umap.c linux/arch/mips64/mm/umap.c
--- linux-orig/arch/mips64/mm/umap.c	Thu Apr  5 20:25:43 2001
+++ linux/arch/mips64/mm/umap.c	Sat May 26 01:24:28 2001
@@ -178,7 +178,7 @@
 		end = PGDIR_SIZE;
 	vaddr -= address;
 	do {
-		pte_t * pte = pte_alloc(pmd, address);
+		pte_t * pte = pte_alloc(current->mm, pmd, address);
 		if (!pte)
 			return -ENOMEM;
 		vmap_pte_range(pte, address, end - address, address + vaddr);
@@ -200,7 +200,7 @@
 	dir = pgd_offset(current->mm, from);
 	flush_cache_range(current->mm, beg, end);
 	while (from < end) {
-		pmd_t *pmd = pmd_alloc(dir, from);
+		pmd_t *pmd = pmd_alloc(current->mm, dir, from);
 		error = -ENOMEM;
 		if (!pmd)
 			break;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/Makefile linux/arch/mips64/sgi-ip22/Makefile
--- linux-orig/arch/mips64/sgi-ip22/Makefile	Fri Feb  9 19:38:53 2001
+++ linux/arch/mips64/sgi-ip22/Makefile	Sat May 26 01:24:28 2001
@@ -10,7 +10,9 @@
 
 L_TARGET = ip22.a
 
-obj-y	+= ip22-berr.o ip22-mc.o ip22-sc.o ip22-hpc.o ip22-int.o ip22-rtc.o \
+obj-y	+= ip22-berr.o ip22-mc.o ip22-hpc.o ip22-int.o ip22-rtc.o \
 	   ip22-setup.o system.o ip22-timer.o ip22-irq.o ip22-reset.o time.o
+
+obj-$(CONFIG_BOARD_SCACHE)	+= ip22-sc.o
 
 include $(TOPDIR)/Rules.make
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-berr.c linux/arch/mips64/sgi-ip22/ip22-berr.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-berr.c	Thu Feb 24 01:12:41 2000
+++ linux/arch/mips64/sgi-ip22/ip22-berr.c	Sat May 26 01:24:28 2001
@@ -14,6 +14,9 @@
 #include <asm/addrspace.h>
 #include <asm/ptrace.h>
 
+extern void dump_tlb_addr(unsigned long addr);
+extern void dump_tlb_all(void);
+
 extern asmlinkage void handle_ibe(void);
 extern asmlinkage void handle_dbe(void);
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-irq.S linux/arch/mips64/sgi-ip22/ip22-irq.S
--- linux-orig/arch/mips64/sgi-ip22/ip22-irq.S	Sat Dec  4 04:59:01 1999
+++ linux/arch/mips64/sgi-ip22/ip22-irq.S	Sat May 26 02:48:46 2001
@@ -56,8 +56,8 @@
 	.text
 	.set	noreorder
 	.set	noat
-	.align	5
 	NESTED(indyIRQ, PT_SIZE, sp)
+	.align	5
 	SAVE_ALL
 	CLI
 	.set	at
@@ -69,9 +69,8 @@
 	 andi	a0, s0, CAUSEF_IP2	# delay slot, check local level zero
 
 	/* Wheee, a timer interrupt. */
-	move	a0, sp
 	jal	indy_timer_interrupt
-	 nop				# delay slot
+	 move	a0, sp			# delay slot
 
 	j	ret_from_irq
 	 nop				# delay slot
@@ -92,38 +91,35 @@
 	 andi	a0, s0, CAUSEF_IP6	# delay slot, check bus error
 
 	/* Wheee, local level one interrupt. */
-	move	a0, sp
 	jal	indy_local1_irqdispatch
-	 nop
+	 move	a0, sp			# delay slot
 
 	j	ret_from_irq
-	 nop
+	 nop				# delay slot
 
 1:
 	beq	a0, zero, 1f
-	 nop
+	 andi	a0, s0, (CAUSEF_IP4 | CAUSEF_IP5) # delay slot, check timer
 
 	/* Wheee, an asynchronous bus error... */
-	move	a0, sp
 	jal	indy_buserror_irq
-	 nop
+	 move	a0, sp			# delay slot
 
 	j	ret_from_irq
-	 nop
+	 nop				# delay slot
 
 1:
 	/* Here by mistake?  This is possible, what can happen
 	 * is that by the time we take the exception the IRQ
 	 * pin goes low, so just leave if this is the case.
 	 */
-	andi	a0, s0, (CAUSEF_IP4 | CAUSEF_IP5)
 	beq	a0, zero, 1f
+	 move	a0, sp			# delay slot
 
 	/* Must be one of the 8254 timers... */
-	move	a0, sp
 	jal	indy_8254timer_irq
 	 nop
 1:
 	j	ret_from_irq
-	 nop
+	 nop				# delay slot
 	END(indyIRQ)
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-mc.c linux/arch/mips64/sgi-ip22/ip22-mc.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-mc.c	Sat May 26 00:25:39 2001
+++ linux/arch/mips64/sgi-ip22/ip22-mc.c	Sat May 26 01:24:28 2001
@@ -16,6 +16,10 @@
 
 /* #define DEBUG_SGIMC */
 
+#ifdef DEBUG_SGIMC
+extern void prom_printf(char *fmt, ...);
+#endif
+
 struct sgimc_misc_ctrl *mcmisc_regs;
 u32 *rpsscounter;
 struct sgimc_dma_ctrl *dmactrlregs;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-setup.c linux/arch/mips64/sgi-ip22/ip22-setup.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-setup.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/sgi-ip22/ip22-setup.c	Sat May 26 01:24:28 2001
@@ -33,11 +33,14 @@
 #include <asm/sgi/sgihpc.h>
 #include <asm/sgi/sgint23.h>
 
+extern int console_setup(char *str);
+
+extern struct hpc3_miscregs *hpc3mregs;
 extern struct rtc_ops indy_rtc_ops;
 extern void ip22_reboot_setup(void);
 extern void ip22_volume_set(unsigned char);
 
-#define sgi_kh ((struct hpc_keyb *) (KSEG1 + 0x1fbd9800 + 64))
+#define sgi_kh ((struct hpc_keyb *) &(hpc3mregs->kbdmouse0))
 
 #define KBD_STAT_IBF		0x02	/* Keyboard input buffer full */
 
@@ -137,8 +140,10 @@
 	/* Init INDY memory controller. */
 	sgimc_init();
 
+#ifdef CONFIG_BOARD_SCACHE
 	/* Now enable boardcaches, if any. */
 	indy_sc_init();
+#endif
 
 #ifdef CONFIG_SERIAL_CONSOLE
 	/* ARCS console environment variable is set to "g?" for
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/ip22-timer.c linux/arch/mips64/sgi-ip22/ip22-timer.c
--- linux-orig/arch/mips64/sgi-ip22/ip22-timer.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/sgi-ip22/ip22-timer.c	Sat May 26 01:24:28 2001
@@ -34,6 +34,11 @@
 
 extern rwlock_t xtime_lock;
 
+static inline int abs(int i)
+{
+	return (i < 0) ? -i : i;
+}
+
 static inline void ack_r4ktimer(unsigned long newval)
 {
 	write_32bit_cp0_register(CP0_COMPARE, newval);
@@ -122,32 +127,30 @@
 static unsigned long dosample(volatile unsigned char *tcwp,
                               volatile unsigned char *tc2p)
 {
-	unsigned long ct0, ct1;
-	unsigned char msb, lsb;
+	unsigned int ct = 0;
+	volatile unsigned char msb, lsb;
 
 	/* Start the counter. */
-	*tcwp = (SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MRGEN);
-	*tc2p = (SGINT_TCSAMP_COUNTER & 0xff);
-	*tc2p = (SGINT_TCSAMP_COUNTER >> 8);
+	*tcwp = SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MRGEN;
+	*tc2p = SGINT_TCSAMP_COUNTER & 0xff;
+	*tc2p = (SGINT_TCSAMP_COUNTER >> 8) & 0xff;
 
-	/* Get initial counter invariant */
-	ct0 = read_32bit_cp0_register(CP0_COUNT);
+	/* Set initial counter invariant to zero to avoid overflow hassle. */
+	write_32bit_cp0_register(CP0_COUNT, ct);
 
 	/* Latch and spin until top byte of counter2 is zero */
 	do {
-		*tcwp = (SGINT_TCWORD_CNT2 | SGINT_TCWORD_CLAT);
+		*tcwp = SGINT_TCWORD_CNT2 | SGINT_TCWORD_CLAT;
 		lsb = *tc2p;
 		msb = *tc2p;
-		ct1 = read_32bit_cp0_register(CP0_COUNT);
+		ct = read_32bit_cp0_register(CP0_COUNT);
 	} while(msb);
 
 	/* Stop the counter. */
-	*tcwp = (SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MSWST);
+	*tcwp = SGINT_TCWORD_CNT2 | SGINT_TCWORD_CALL | SGINT_TCWORD_MSWST;
 
-	/* Return the difference, this is how far the r4k counter increments
-	 * for every one HZ.
-	 */
-	return ct1 - ct0;
+	/* Return how far the r4k counter increments for every one HZ. */
+	return ct;
 }
 
 static unsigned long __init get_indy_time(void)
@@ -219,7 +222,7 @@
 
 	printk("%08lx(%d)\n", r4k_offset, (int) r4k_offset);
 
-	r4k_cur = (read_32bit_cp0_register(CP0_COUNT) + r4k_offset);
+	r4k_cur = read_32bit_cp0_register(CP0_COUNT) + r4k_offset;
 	write_32bit_cp0_register(CP0_COMPARE, r4k_cur);
 	set_cp0_status(ST0_IM, ALLINTS);
 	sti();
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/sgi-ip22/system.c linux/arch/mips64/sgi-ip22/system.c
--- linux-orig/arch/mips64/sgi-ip22/system.c	Tue Mar 20 00:02:37 2001
+++ linux/arch/mips64/sgi-ip22/system.c	Sat May 26 01:24:28 2001
@@ -33,10 +33,12 @@
 	{ "MIPS-R4600", CPU_R4600 },
 	{ "MIPS-R8000", CPU_R8000 },
 	{ "MIPS-R5000", CPU_R5000 },
-	{ "MIPS-R5000A", CPU_R5000A }
+	{ "MIPS-R5000A", CPU_R5000A },
+	{ "MIPS-R10000", CPU_R10000 },
+	{ "MIPS-R12000", CPU_R12000 }
 };
 
-#define NUM_CPUS 9 /* for now */
+static const int NUM_CPUS = sizeof(sgi_cputable) / sizeof(struct smatch);
 
 static int __init string_to_cpu(char *s)
 {
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/arch/mips64/tools/Makefile linux/arch/mips64/tools/Makefile
--- linux-orig/arch/mips64/tools/Makefile	Fri Feb  9 19:38:54 2001
+++ linux/arch/mips64/tools/Makefile	Sat May 26 01:24:28 2001
@@ -23,8 +23,7 @@
 clean:
 	rm -f offset.[hs] $(TARGET).new
 	
-mrproper:	
-	rm -f offset.[hs] $(TARGET).new
+mrproper: clean
 	rm -f $(TARGET)
 
 include $(TOPDIR)/Rules.make
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/drivers/char/tty_io.c linux/drivers/char/tty_io.c
--- linux-orig/drivers/char/tty_io.c	Sun May  6 17:28:52 2001
+++ linux/drivers/char/tty_io.c	Sat May 26 01:24:28 2001
@@ -156,6 +156,7 @@
 extern void sci_console_init(void);
 extern void tx3912_console_init(void);
 extern void tx3912_rs_init(void);
+extern void arc_console_init(void);
 
 #ifndef MIN
 #define MIN(a,b)	((a) < (b) ? (a) : (b))
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/drivers/sgi/char/sgiserial.c linux/drivers/sgi/char/sgiserial.c
--- linux-orig/drivers/sgi/char/sgiserial.c	Tue Mar 20 00:03:16 2001
+++ linux/drivers/sgi/char/sgiserial.c	Sat May 26 01:24:29 2001
@@ -137,7 +137,7 @@
  * buffer across all the serial ports, since it significantly saves
  * memory if large numbers of serial ports are open.
  */
-static unsigned char tmp_buf[4096]; /* This is cheating */
+static unsigned char tmp_buf[PAGE_SIZE]; /* This is cheating */
 static DECLARE_MUTEX(tmp_buf_sem);
 
 static inline int serial_paranoia_check(struct sgi_serial *info,
@@ -785,8 +785,8 @@
  */
 static void change_speed(struct sgi_serial *info)
 {
-	unsigned short port;
-	unsigned cflag;
+	unsigned int port;
+	unsigned int cflag;
 	int	i;
 	int	brg;
 
@@ -1982,7 +1982,8 @@
 	for(info=zs_chain, i=0; info; info = info->zs_next, i++)
 	{
 		info->magic = SERIAL_MAGIC;
-		info->port = (int) info->zs_channel;
+		/* This hopefully lives always in 32bit space. */
+		info->port = (unsigned int) (unsigned long) info->zs_channel;
 		info->line = i;
 		info->tty = 0;
 		info->irq = zilog_irq;
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/drivers/sgi/char/sgiserial.h linux/drivers/sgi/char/sgiserial.h
--- linux-orig/drivers/sgi/char/sgiserial.h	Sun Oct 15 14:57:35 2000
+++ linux/drivers/sgi/char/sgiserial.h	Sat May 26 01:24:29 2001
@@ -33,7 +33,7 @@
 struct serial_struct {
 	int	type;
 	int	line;
-	int	port;
+	unsigned int	port;
 	int	irq;
 	int	flags;
 	int	xmit_fifo_size;
@@ -129,7 +129,7 @@
 
 	int			magic;
 	int			baud_base;
-	int			port;
+	unsigned int		port;
 	int			irq;
 	int			flags; 		/* defined in tty.h */
 	int			type; 		/* UART type */
@@ -166,9 +166,9 @@
 #define SERIAL_MAGIC 0x5301
 
 /*
- * The size of the serial xmit buffer is 1 page, or 4096 bytes
+ * The size of the serial xmit buffer is 1 page
  */
-#define SERIAL_XMIT_SIZE 4096
+#define SERIAL_XMIT_SIZE PAGE_SIZE
 
 /*
  * Events are used to schedule things to happen at timer-interrupt
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/bootinfo.h linux/include/asm-mips64/bootinfo.h
--- linux-orig/include/asm-mips64/bootinfo.h	Sat May 26 00:25:54 2001
+++ linux/include/asm-mips64/bootinfo.h	Sat May 26 01:35:01 2001
@@ -134,13 +134,14 @@
 #define CPU_R5000A		25
 #define CPU_R4640		26
 #define CPU_NEVADA		27	/* RM5230, RM5260 */
-#define CPU_LAST		27
+#define CPU_R12000		28
+#define CPU_LAST		28
 
 #define CPU_NAMES { "unknown", "R2000", "R3000", "R3000A", "R3041", "R3051", \
         "R3052", "R3081", "R3081E", "R4000PC", "R4000SC", "R4000MC",         \
         "R4200", "R4400PC", "R4400SC", "R4400MC", "R4600", "R6000",          \
         "R6000A", "R8000", "R10000", "R4300", "R4650", "R4700", "R5000",     \
-        "R5000A", "R4640", "Nevada" }
+        "R5000A", "R4640", "Nevada", "R12000" }
 
 #define CL_SIZE      (80)
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/pgtable.h linux/include/asm-mips64/pgtable.h
--- linux-orig/include/asm-mips64/pgtable.h	Wed May 23 21:12:25 2001
+++ linux/include/asm-mips64/pgtable.h	Sat May 26 02:16:29 2001
@@ -69,7 +69,8 @@
 #define flush_icache_page(vma, page)					\
 do {									\
 	if ((vma)->vm_flags & VM_EXEC)					\
-		andes_flush_icache_page(page_address(page));		\
+		andes_flush_icache_page(				\
+			(unsigned long)page_address(page));		\
 } while (0)
 #endif /* !CONFIG_CPU_R10000 */
 
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgi/sgihpc.h linux/include/asm-mips64/sgi/sgihpc.h
--- linux-orig/include/asm-mips64/sgi/sgihpc.h	Sat Dec  4 04:59:13 1999
+++ linux/include/asm-mips64/sgi/sgihpc.h	Sat May 26 02:17:25 2001
@@ -334,8 +334,6 @@
 /* We need software copies of these because they are write only. */
 extern unsigned int sgi_hpc_write1, sgi_hpc_write2;
 
-#define SGI_KEYBOARD_IRQ 20
-
 struct hpc_keyb {
 #ifdef __MIPSEB__
 	unsigned char _unused0[3];
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgi/sgint23.h linux/include/asm-mips64/sgi/sgint23.h
--- linux-orig/include/asm-mips64/sgi/sgint23.h	Sat May 26 00:25:54 2001
+++ linux/include/asm-mips64/sgi/sgint23.h	Sat May 26 01:35:44 2001
@@ -199,7 +199,6 @@
 extern struct sgi_ioc_timers *ioc_timers;
 extern volatile unsigned char *ioc_tclear;
 
-extern void sgint_init(void);
 extern void indy_timer_init(void);
 
 #endif /* _ASM_SGI_SGINT23_H */
diff -BurPX /bigdisk/dl/src/dontdiff linux-orig/include/asm-mips64/sgialib.h linux/include/asm-mips64/sgialib.h
--- linux-orig/include/asm-mips64/sgialib.h	Sat May 26 00:25:54 2001
+++ linux/include/asm-mips64/sgialib.h	Sat May 26 02:16:52 2001
@@ -13,7 +13,6 @@
 
 #include <asm/sgiarcs.h>
 
-extern PSYSTEM_PARAMETER_BLOCK sgi_pblock;
 extern struct linux_romvec *romvec;
 extern int prom_argc;
 
