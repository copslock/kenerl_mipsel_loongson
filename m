Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Oct 2005 19:04:03 +0100 (BST)
Received: from natfrord.rzone.de ([81.169.145.161]:33987 "EHLO
	natfrord.rzone.de") by ftp.linux-mips.org with ESMTP
	id S8133554AbVJPSDb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Oct 2005 19:03:31 +0100
Received: from excalibur.cologne.de (cable-84-44-248-18.netcologne.de [84.44.248.18])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j9GI3S7C002632
	for <linux-mips@linux-mips.org>; Sun, 16 Oct 2005 20:03:28 +0200 (MEST)
Received: from karsten by excalibur.cologne.de with local (Exim 3.36 #1 (Debian))
	id 1ERCqv-0002bh-00
	for <linux-mips@linux-mips.org>; Sun, 16 Oct 2005 20:03:21 +0200
Date:	Sun, 16 Oct 2005 20:03:21 +0200
From:	Karsten Merker <karsten@excalibur.cologne.de>
To:	linux-mips@linux-mips.org
Subject: I2-R10k patchset - help needed
Message-ID: <20051016180321.GA9993@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-No-Archive: yes
User-Agent: Mutt/1.5.9i
Return-Path: <karsten@excalibur.cologne.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: karsten@excalibur.cologne.de
Precedence: bulk
X-list: linux-mips


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hallo everybody,

I am trying to get the current git tree running on an I2 R10k, so
I applied Peter Fürsts patches from

http://home.alphastar.de/fuerst/download.html 

to it. As these are against 2.6.12-rc2, I got a bunch of rejects,
which I have resolved manually, but I am stuck with the patch for
include/asm-mips/stackframe.h.

I would be very grateful if somebody could take a look into this
and provide an updated patch against the current kernel sources.
Attached to this mail is both my version of Peter Fürsts
"collected.diff" (applies cleanly against current git but without
the stackframe.h-patch) as well as the original stackframe.h
patch.

Regards,
Karsten
-- 
#include <standard_disclaimer>
Nach Paragraph 28 Abs. 3 Bundesdatenschutzgesetz widerspreche ich der Nutzung
oder Uebermittlung meiner Daten fuer Werbezwecke oder fuer die Markt- oder
Meinungsforschung.

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="R10k-changes-without-stackframe.h.diff"
Content-Transfer-Encoding: 8bit

diff -Nur linux-git/arch/mips/Kconfig linux-git-mit-R10k-patches/arch/mips/Kconfig
--- linux-git/arch/mips/Kconfig	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -527,6 +527,25 @@
 	  workstations.  To compile a Linux kernel that runs on these, say Y
 	  here.
 
+config SGI_IP28
+	bool "Support for SGI IP28 (Indigo2 R10k) (EXPERIMENTAL)"
+	depends EXPERIMENTAL
+	select ARC
+	select ARC64
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select SWAP_IO_SPACE
+	select HW_HAS_EISA
+	select CPU_R10000
+	select XKPHYS_KERNEL
+	select BUILD_ELF64
+	select BOOT_ELF64
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+      help
+        This is the SGI Indigo2 with R10000 processor.  To compile a Linux
+        kernel that runs on these, say Y here.
+
 config SGI_IP32
 	bool "Support for SGI IP32 (O2) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
@@ -942,7 +961,7 @@
 
 config ARC_CONSOLE
 	bool "ARC console support"
-	depends on SGI_IP22 || SNI_RM200_PCI
+	depends on SGI_IP22 || SNI_RM200_PCI || SGI_IP28
 
 config ARC_MEMORY
 	bool
@@ -951,7 +970,7 @@
 
 config ARC_PROMLIB
 	bool
-	depends on MACH_JAZZ || SNI_RM200_PCI || SGI_IP22 || SGI_IP32
+	depends on MACH_JAZZ || SNI_RM200_PCI || SGI_IP22 || SGI_IP28 || SGI_IP32
 	default y
 
 config ARC64
@@ -1319,6 +1338,14 @@
 	bool "Support for 64-bit physical address space"
 	depends on (CPU_R4X00 || CPU_R5000 || CPU_RM7000 || CPU_RM9000 || CPU_R10000 || CPU_SB1 || CPU_MIPS32_R1 || CPU_MIPS64_R1) && 32BIT
 
+config XKPHYS_KERNEL
+	bool "Allow kernel to run from 64-bit segments"
+	depends on MIPS64
+	help
+	  This option allows to locate the kernel in 64-bit unmapped memory
+	  space (xkphys). This is required for Octane (IP30) or Indigo2 R10k
+	  (IP28) machines.
+
 config CPU_ADVANCED
 	bool "Override CPU Options"
 	depends on 32BIT
@@ -1643,6 +1670,9 @@
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
+# Revision 1.145, Tue Apr 19 00:00:45 2005
+# Jun/Dec 2004	- IP28
+
 	  If unsure, say Y. Only embedded should say N here.
 
 config PM
diff -Nur linux-git/arch/mips/kernel/gdb-low.S linux-git-mit-R10k-patches/arch/mips/kernel/gdb-low.S
--- linux-git/arch/mips/kernel/gdb-low.S	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/kernel/gdb-low.S	2005-10-16 13:21:56.000000000 +0200
@@ -52,7 +52,11 @@
 		/*
 		 * Called from user mode, go somewhere else.
 		 */
+#ifdef CONFIG_XKPHYS_KERNEL
+		dla	k1, saved_vectors
+#else
 		lui	k1, %hi(saved_vectors)
+#endif
 		mfc0	k0, CP0_CAUSE
 		andi	k0, k0, 0x7c
 		add	k1, k1, k0
@@ -61,7 +65,11 @@
 		nop
 1:
 		move	k0, sp
+#ifdef CONFIG_MIPS64
+		dsubu	sp, k1, GDB_FR_SIZE*2	# see comment above
+#else
 		subu	sp, k1, GDB_FR_SIZE*2	# see comment above
+#endif
 		LONG_S	k0, GDB_FR_REG29(sp)
 		LONG_S	$2, GDB_FR_REG2(sp)
 
@@ -368,3 +376,7 @@
 kgdbfault:	li	v0, -EFAULT
 		jr	ra
 		.end	kgdbfault
+/*
+ * Revision 1.17, Mon Nov 17 17:19:39 2003
+ * Wed May 12 21:21:49 2004	xkphys kernel addresses
+ */
diff -Nur linux-git/arch/mips/kernel/setup.c linux-git-mit-R10k-patches/arch/mips/kernel/setup.c
--- linux-git/arch/mips/kernel/setup.c	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/kernel/setup.c	2005-10-16 13:25:04.000000000 +0200
@@ -302,7 +302,7 @@
 	 * Partially used pages are not usable - thus
 	 * we are rounding upwards.
 	 */
-	start_pfn = PFN_UP(CPHYSADDR(reserved_end));
+	start_pfn = PFN_UP(kernel_physaddr(reserved_end));
 
 #ifndef CONFIG_SGI_IP27
 	/* Find the highest page frame number we have available.  */
@@ -426,11 +426,11 @@
 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
 		       (void *)initrd_start, initrd_size);
 
-		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		if (kernel_physaddr(initrd_end) > PFN_PHYS(max_low_pfn)) {
 			printk("initrd extends beyond end of memory "
 			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
 			       sizeof(long) * 2,
-			       (unsigned long long)CPHYSADDR(initrd_end),
+			       (unsigned long long)kernel_physaddr(initrd_end),
 			       sizeof(long) * 2,
 			       (unsigned long long)PFN_PHYS(max_low_pfn));
 			initrd_start = initrd_end = 0;
@@ -438,7 +438,7 @@
 		}
 
 		if (initrd_reserve_bootmem)
-			reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
+			reserve_bootmem(kernel_physaddr(initrd_start), initrd_size);
 	}
 #endif /* CONFIG_BLK_DEV_INITRD  */
 }
@@ -452,10 +452,10 @@
 	 * The 64bit code in 32bit object format trick can't represent
 	 * 64bit wide relocations for linker script symbols.
 	 */
-	code_resource.start = CPHYSADDR(&_text);
-	code_resource.end = CPHYSADDR(&_etext) - 1;
-	data_resource.start = CPHYSADDR(&_etext);
-	data_resource.end = CPHYSADDR(&_edata) - 1;
+	code_resource.start = kernel_physaddr(&_text);
+	code_resource.end = kernel_physaddr(&_etext) - 1;
+	data_resource.start = kernel_physaddr(&_etext);
+	data_resource.end = kernel_physaddr(&_edata) - 1;
 #else
 	code_resource.start = virt_to_phys(&_text);
 	code_resource.end = virt_to_phys(&_etext) - 1;
@@ -559,3 +559,9 @@
 }
 
 __setup("nodsp", dsp_disable);
+
+/*
+ * Revision 1.179, Tue Apr 19 00:06:09 2005
+ * Apr 2004/2005 pf   - xkphys kernel addresses
+ */
+
diff -Nur linux-git/arch/mips/lib/memcpy.S linux-git-mit-R10k-patches/arch/mips/lib/memcpy.S
--- linux-git/arch/mips/lib/memcpy.S	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/lib/memcpy.S	2005-10-16 13:21:56.000000000 +0200
@@ -17,6 +17,14 @@
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 
+#ifdef CONFIG_SGI_IP28
+/* Inhibit speculative stores to volatile (e.g.DMA) or invalid addresses. */
+# include <asm/cacheops.h>
+# define R10KCBARRIER(addr)  cache   Cache_Barrier, addr;
+#else
+# define R10KCBARRIER(addr)
+#endif
+
 #define dst a0
 #define src a1
 #define len a2
@@ -180,6 +188,7 @@
 	 */
 #define rem t8
 
+	R10KCBARRIER(0(ra)) /* hopefully inhibits speculative store prefetch */
 	/*
 	 * The "issue break"s below are very approximate.
 	 * Issue delays for dcache fills will perturb the schedule, as will
@@ -212,6 +221,7 @@
 	PREF(	1, 3*32(dst) )
 	.align	4
 1:
+	R10KCBARRIER(0(ra)) /* ra must be valid anyway */
 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
 EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
@@ -253,6 +263,7 @@
 EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
 	SUB	len, len, 4*NBYTES
 	ADD	src, src, 4*NBYTES
+	R10KCBARRIER(0(ra))
 EXC(	STORE	t0, UNIT(0)(dst),	s_exc_p4u)
 EXC(	STORE	t1, UNIT(1)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(2)(dst),	s_exc_p2u)
@@ -266,6 +277,7 @@
 	beq	rem, len, copy_bytes
 	 nop
 1:
+	R10KCBARRIER(0(ra))
 EXC(	LOAD	t0, 0(src),		l_exc)
 	ADD	src, src, NBYTES
 	SUB	len, len, NBYTES
@@ -311,6 +323,7 @@
 EXC(	LDREST	t3, REST(0)(src),	l_exc_copy)
 	SUB	t2, t2, t1	# t2 = number of bytes copied
 	xor	match, t0, t1
+	R10KCBARRIER(0(ra))
 EXC(	STFIRST t3, FIRST(0)(dst),	s_exc)
 	beq	len, t2, done
 	 SUB	len, len, t2
@@ -331,6 +344,7 @@
  * It's OK to load FIRST(N+1) before REST(N) because the two addresses
  * are to the same unit (unless src is aligned, but it's not).
  */
+	R10KCBARRIER(0(ra))
 EXC(	LDFIRST	t0, FIRST(0)(src),	l_exc)
 EXC(	LDFIRST	t1, FIRST(1)(src),	l_exc_copy)
 	SUB     len, len, 4*NBYTES
@@ -359,6 +373,7 @@
 	beq	rem, len, copy_bytes
 	 nop
 1:
+	R10KCBARRIER(0(ra))
 EXC(	LDFIRST t0, FIRST(0)(src),	l_exc)
 EXC(	LDREST	t0, REST(0)(src),	l_exc_copy)
 	ADD	src, src, NBYTES
@@ -372,6 +387,7 @@
 	 nop
 copy_bytes:
 	/* 0 < len < NBYTES  */
+	R10KCBARRIER(0(ra))
 #define COPY_BYTE(N)			\
 EXC(	lb	t0, N(src), l_exc);	\
 	SUB	len, len, 1;		\
@@ -484,6 +500,7 @@
 	ADD	a1, a2				# src = src + len
 
 r_end_bytes:
+	R10KCBARRIER(0(ra))
 	lb	t0, -1(a1)
 	SUB	a2, a2, 0x1
 	sb	t0, -1(a0)
@@ -496,6 +513,7 @@
 	 move	a2, zero
 
 r_end_bytes_up:
+	R10KCBARRIER(0(ra))
 	lb	t0, (a1)
 	SUB	a2, a2, 0x1
 	sb	t0, (a0)
@@ -506,3 +524,7 @@
 	jr	ra
 	 move	a2, zero
 	END(__rmemcpy)
+/*
+ * Revision 1.18, Sat Jul 26 12:00:12 2003
+ * Sat Aug  7 01:11:52 2004	pf	- r10k cache barrier
+ */
diff -Nur linux-git/arch/mips/lib/strncpy_user.S linux-git-mit-R10k-patches/arch/mips/lib/strncpy_user.S
--- linux-git/arch/mips/lib/strncpy_user.S	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/lib/strncpy_user.S	2005-10-16 13:30:49.000000000 +0200
@@ -5,11 +5,20 @@
  *
  * Copyright (c) 1996, 1999 by Ralf Baechle
  */
+#include <linux/config.h>
 #include <linux/errno.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 
+#ifdef CONFIG_SGI_IP28
+/* Inhibit speculative stores to volatile (e.g.DMA) or invalid addresses. */
+# include <asm/cacheops.h>
+# define R10KCBARRIER(addr)  cache   Cache_Barrier, addr;
+#else
+# define R10KCBARRIER(addr)
+#endif
+
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a";			\
@@ -38,6 +47,7 @@
 	.set		noreorder
 1:	EX(lbu, t0, (v1), fault)
 	PTR_ADDIU	v1, 1
+	R10KCBARRIER(0(ra))
 	beqz		t0, 2f
 	 sb		t0, (a0)
 	PTR_ADDIU	v0, 1
@@ -56,3 +66,7 @@
 	.section	__ex_table,"a"
 	PTR		1b, fault
 	.previous
+/*
+ * Revision 1.9, Wed Nov 19 14:03:13 2003
+ * Wed Aug 11 02:21:01 2004	pf	- r10k cache barrier
+ */
diff -Nur linux-git/arch/mips/lib-64/memset.S linux-git-mit-R10k-patches/arch/mips/lib-64/memset.S
--- linux-git/arch/mips/lib-64/memset.S	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/lib-64/memset.S	2005-10-16 13:29:04.000000000 +0200
@@ -6,10 +6,19 @@
  * Copyright (C) 1998, 1999, 2000 by Ralf Baechle
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+#include <linux/config.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 
+#ifdef CONFIG_SGI_IP28
+/* Inhibit speculative stores to volatile (e.g.DMA) or invalid addresses. */
+# include <asm/cacheops.h>
+# define R10KCBARRIER(addr)  cache   Cache_Barrier, addr;
+#else
+# define R10KCBARRIER(addr)
+#endif
+
 #define EX(insn,reg,addr,handler)			\
 9:	insn	reg, addr;				\
 	.section __ex_table,"a"; 			\
@@ -57,6 +66,7 @@
 	beqz		t0, 1f
 	 PTR_SUBU	t0, LONGSIZE		/* alignment in bytes */
 
+	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(sdl, a1, (a0), first_fixup)		/* make dword aligned */
 #endif
@@ -74,11 +84,13 @@
 	PTR_ADDU	t1, a0			/* end address */
 	.set		reorder
 1:	PTR_ADDIU	a0, 64
+	R10KCBARRIER(0(ra))
 	f_fill64 a0, -64, a1, fwd_fixup
 	bne		t1, a0, 1b
 	.set		noreorder
 
 memset_partial:
+	R10KCBARRIER(0(ra))
 	PTR_LA		t1, 2f			/* where to start */
 	.set		noat
 	dsrl		AT, t0, 1
@@ -96,6 +108,7 @@
 
 	beqz		a2, 1f
 	 PTR_ADDU	a0, a2			/* What's left */
+	R10KCBARRIER(0(ra))
 #ifdef __MIPSEB__
 	EX(sdr, a1, -1(a0), last_fixup)
 #endif
@@ -110,6 +123,7 @@
 	 PTR_ADDU	t1, a0, a2
 
 1:	PTR_ADDIU	a0, 1			/* fill bytewise */
+	R10KCBARRIER(0(ra))
 	bne		t1, a0, 1b
 	 sb		a1, -1(a0)
 
@@ -140,3 +154,7 @@
 last_fixup:
 	jr		ra
 	 andi		v1, a2, LONGMASK
+/*
+ * Revision 1.1, Mon Jul 21 00:11:39 2003
+ * Wed Aug 11 01:52:59 2004	pf	- r10k cache barrier
+ */
diff -Nur linux-git/arch/mips/Makefile linux-git-mit-R10k-patches/arch/mips/Makefile
--- linux-git/arch/mips/Makefile	2005-10-15 16:01:06.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/Makefile	2005-10-16 13:21:56.000000000 +0200
@@ -628,6 +628,19 @@
 endif
 
 #
+# SGI IP28 (Indigo2 R10k)
+#
+# Set the load address to >= 0xa800000020080000 if you want to leave space for
+# symmon, 0xa800000020004000 for production kernels ?  Note that the value must
+# be 16kb aligned or the handling of the current variable will break.
+# Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
+#
+#core-$(CONFIG_SGI_IP28)		+= arch/mips/sgi-ip22/ arch/mips/arc/arc_con.o
+core-$(CONFIG_SGI_IP28)		+= arch/mips/sgi-ip22/
+cflags-$(CONFIG_SGI_IP28)	+= -mip28-cache-barrier -Iinclude/asm-mips/mach-ip28
+load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
+
+#
 # SGI-IP32 (O2)
 #
 # Set the load address to >= 80069000 if you want to leave space for symmon,
@@ -814,3 +827,6 @@
 CLEAN_FILES += vmlinux.32 \
 	       vmlinux.64 \
 	       vmlinux.ecoff
+
+# Revision 1.193, Tue Apr 19 00:00:49 2005
+# Jun/Dec 2004	- IP28
diff -Nur linux-git/arch/mips/mm/c-r4k.c linux-git-mit-R10k-patches/arch/mips/mm/c-r4k.c
--- linux-git/arch/mips/mm/c-r4k.c	2005-10-15 16:01:07.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/mm/c-r4k.c	2005-10-16 13:21:56.000000000 +0200
@@ -712,6 +712,27 @@
 
 	bc_inv(addr, size);
 }
+
+#ifdef CONFIG_CPU_R10000
+static void r10k_dma_cache_inv(unsigned long addr, unsigned long size)
+{
+	unsigned long sc_lsize = current_cpu_data.scache.linesz;
+	unsigned long end, a;
+
+	/* Catch bad driver code */
+	BUG_ON(size == 0);
+	//BUG_ON(!cpu_has_subset_pcaches);
+
+	a = addr & ~(sc_lsize - 1);
+	end = (addr + size - 1) & ~(sc_lsize - 1);
+	while (1) {
+		invalidate_scache_line(a);	/* Hit_Invalidate_SD/S */
+		if (a == end)
+			break;
+		a += sc_lsize;
+	}
+}
+#endif /* CONFIG_CPU_R10000 */
 #endif /* CONFIG_DMA_NONCOHERENT */
 
 /*
@@ -1269,7 +1290,16 @@
 #ifdef CONFIG_DMA_NONCOHERENT
 	_dma_cache_wback_inv	= r4k_dma_cache_wback_inv;
 	_dma_cache_wback	= r4k_dma_cache_wback_inv;
-	_dma_cache_inv		= r4k_dma_cache_inv;
+	switch (current_cpu_data.cputype) {
+#ifdef CONFIG_CPU_R10000
+	case CPU_R10000:
+	case CPU_R12000:
+		_dma_cache_inv	= r10k_dma_cache_inv;
+		break;
+#endif
+	default:
+		_dma_cache_inv	= r4k_dma_cache_inv;
+	}
 #endif
 
 	build_clear_page();
@@ -1277,3 +1307,7 @@
 	local_r4k___flush_cache_all(NULL);
 	coherency_setup();
 }
+/*
+ * Revision 1.107, Tue Apr 19 00:06:40 2005
+ * Sat Apr  9 00:06:16 2005	pf - r10k_dma_cache_inv (really dma invalidate)
+ */
diff -Nur linux-git/arch/mips/mm/init.c linux-git-mit-R10k-patches/arch/mips/mm/init.c
--- linux-git/arch/mips/mm/init.c	2005-10-15 16:01:07.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/mm/init.c	2005-10-16 13:33:09.000000000 +0200
@@ -225,6 +225,7 @@
 			if (PageReserved(mem_map+tmp))
 				reservedpages++;
 		}
+	num_physpages = ram;
 
 #ifdef CONFIG_HIGHMEM
 	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
@@ -241,6 +242,7 @@
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
+		++num_physpages;
 	}
 	totalram_pages += totalhigh_pages;
 #endif
@@ -266,8 +268,8 @@
 {
 #ifdef CONFIG_64BIT
 	/* Switch from KSEG0 to XKPHYS addresses */
-	start = (unsigned long)phys_to_virt(CPHYSADDR(start));
-	end = (unsigned long)phys_to_virt(CPHYSADDR(end));
+	start = (unsigned long)phys_to_virt(kernel_physaddr(start));
+	end = (unsigned long)phys_to_virt(kernel_physaddr(end));
 #endif
 	if (start < end)
 		printk(KERN_INFO "Freeing initrd memory: %ldk freed\n",
@@ -293,7 +295,7 @@
 	addr = (unsigned long) &__init_begin;
 	while (addr < (unsigned long) &__init_end) {
 #ifdef CONFIG_64BIT
-		page = PAGE_OFFSET | CPHYSADDR(addr);
+		page = PAGE_OFFSET | kernel_physaddr(addr);
 #else
 		page = addr;
 #endif
@@ -307,3 +309,7 @@
 	printk(KERN_INFO "Freeing unused kernel memory: %ldk freed\n",
 	       freed >> 10);
 }
+/*
+ * Revision 1.75, Tue Apr 19 00:06:47 2005
+ * Jun 2004 pf	- XKPHYS
+ */
diff -Nur linux-git/arch/mips/sgi-ip22/ip22-mc.c linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip22-mc.c
--- linux-git/arch/mips/sgi-ip22/ip22-mc.c	2005-10-15 16:01:07.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip22-mc.c	2005-10-16 13:21:56.000000000 +0200
@@ -4,6 +4,7 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) - Indigo2 changes
  * Copyright (C) 2003 Ladislav Michl  (ladis@linux-mips.org)
+ * Copyright (C) 2004 Peter Fuerst    (pf@net.alphadv.de) - IP28
  */
 
 #include <linux/init.h>
@@ -16,6 +17,8 @@
 #include <asm/sgi/mc.h>
 #include <asm/sgi/hpc3.h>
 #include <asm/sgi/ip22.h>
+#include <asm/system.h>
+#include <asm/mipsregs.h>
 
 struct sgimc_regs *sgimc;
 
@@ -112,6 +115,10 @@
 	sgimc = (struct sgimc_regs *)
 		ioremap(SGIMC_BASE, sizeof(struct sgimc_regs));
 
+#ifdef CONFIG_SGI_IP28
+	printk(KERN_INFO "Silicon Graphics Indigo2 R10k (IP28)"
+	       " support: (c) 2004 peter fuerst.\n");
+#endif
 	printk(KERN_INFO "MC: SGI memory controller Revision %d\n",
 	       (int) sgimc->systemid & SGIMC_SYSID_MASKREV);
 
@@ -138,8 +145,21 @@
 	 *         zero.
 	 */
 	tmp = sgimc->cpuctrl0;
-	tmp |= (SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM |
-		SGIMC_CCTRL0_R4KNOCHKPARR);
+	tmp |= SGIMC_CCTRL0_R4KNOCHKPARR;
+#ifdef CONFIG_SGI_IP28
+	/* IP28 prom left us cpuctrl0 set to 3d802412:
+	 *	SGIMC_CCTRL0_GIOBTOB, SGIMC_CCTRL0_R4KNOCHKPARR,
+	 *	SGIMC_CCTRL0_GFXRESET, SGIMC_CCTRL0_EREFRESH, 31800002
+	 * FIXME:
+	 * We do not attempt to override IP28-prom's parity checking,
+	 * since SGIMC_CCTRL0_EPERRGIO will trigger a CPU parity error
+	 * (IP[6]) on reading sgioc->sysid below, while ..EPERRMEM will
+	 * trigger the same somewhere in prom-code (ffffffff9fc431cc)
+	 * when ArcGetEnvironmentVariable() is called  :-(
+	 */
+#else
+	tmp |= (SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM);
+#endif
 	sgimc->cpuctrl0 = tmp;
 
 	/* Step 3: Setup the MC write buffer depth, this is controlled
@@ -147,7 +167,14 @@
 	 */
 	tmp = sgimc->cpuctrl1;
 	tmp &= ~0xf;
+#ifdef CONFIG_SGI_IP28
+	/* IP28 prom left us cpuctrl1 set to 00000016:
+	 *	SGIMC_CCTRL1_EGIOTIMEO | 00000006
+	 */
+	tmp |= 0xd; /* ? 0x6:0xd */
+#else
 	tmp |= 0xd;
+#endif
 	sgimc->cpuctrl1 = tmp;
 
 	/* Step 4: Initialize the RPSS divider register to run as fast
@@ -164,7 +191,12 @@
 	 *         registers value increases at each 'tick'. Thus,
 	 *         for IP22 we get INCREMENT=1, DIVIDER=1 == 0x101
 	 */
+#ifdef CONFIG_SGI_IP28
+	/* IP28 prom left us divider set to 00000104 */
+	sgimc->divider = 0x101; /* ? 0x104:0x101 */
+#else
 	sgimc->divider = 0x101;
+#endif
 
 	/* Step 5: Initialize GIO64 arbitrator configuration register.
 	 *
@@ -177,6 +209,20 @@
 	tmp = SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
 	tmp |= SGIMC_GIOPAR_ONEBUS;	/* Only one physical GIO bus exists */
 
+#ifdef CONFIG_SGI_IP28
+	/* IP28 prom left us giopar set to 0000ce23:
+	 *	SGIMC_GIOPAR_PLINEEXP0, SGIMC_GIOPAR_PLINEEXP1,
+	 *	SGIMC_GIOPAR_MASTERGFX, SGIMC_GIOPAR_MASTEREISA,
+	 *	SGIMC_GIOPAR_ONEBUS, SGIMC_GIOPAR_GFX64,
+	 *	SGIMC_GIOPAR_HPC264, SGIMC_GIOPAR_HPC64
+	 */
+	tmp |= SGIMC_GIOPAR_HPC264;	/* 2nd HPC at 64bits */
+	tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp0 pipelines */
+	tmp |= SGIMC_GIOPAR_PLINEEXP1;	/* exp1 pipelines */
+	tmp |= SGIMC_GIOPAR_MASTERGFX;	/* GFX can act as a bus master */
+	tmp |= SGIMC_GIOPAR_MASTEREISA;	/* EISA bus can act as bus master */
+	tmp |= SGIMC_GIOPAR_GFX64;	/* GFX talks to GIO using 64-bits */
+#else
 	if (ip22_is_fullhouse()) {
 		/* Fullhouse specific settings. */
 		if (SGIOC_SYSID_BOARDREV(sgioc->sysid) < 2) {
@@ -196,9 +242,14 @@
 		tmp |= SGIMC_GIOPAR_EISA64;	/* MC talks to EISA at 64bits */
 		tmp |= SGIMC_GIOPAR_MASTEREISA;	/* EISA bus can act as master */
 	}
+#endif
 	sgimc->giopar = tmp;	/* poof */
 
+	printk(KERN_INFO "MC: Boardrev. %d, Chiprev. %d\n",
+	       SGIOC_SYSID_BOARDREV(sgioc->sysid),
+	       SGIOC_SYSID_CHIPREV(sgioc->sysid));
 	probe_memory();
+	ip2628_return_ucmem(0); /* see below. */
 }
 
 void __init prom_meminit(void) {}
@@ -206,3 +257,99 @@
 {
 	return 0;
 }
+
+#if defined(CONFIG_SGI_IP28) || defined(CONFIG_SGI_IP26)
+/*
+ * Handling uncached writes on IP26/IP28, see IRIX man-page ip26_ucmem(D3)
+ * and Device Driver Programmer's Guide (007-0911-210), Chapter I.1.
+ */
+
+static inline int _r10k_real_sync ( volatile struct sgimc_regs *sgimc )
+{
+	/* See MIPS R10000 User's Manual (SGI 007-2490-001), Chapter 4.5 */
+	int dummy = sgimc->cstat;
+	__asm__ __volatile__ ("sync");
+	return dummy;
+}
+
+static unsigned long
+ip28_set_ucmem ( volatile struct sgimc_regs *sgimc, unsigned short enable )
+{	/*
+	 * Reading `modereg' only provides random values, so we start with
+	 * guessing (from WR_COL), which state the machine is initially in
+	 * and do our own bookkeeping from then on.
+	 */
+	const unsigned long modereg = PHYS_TO_XKSEG_UNCACHED(0x60000000);
+	static unsigned oldstate = -1;
+	unsigned long flags;
+	unsigned tmp;
+	spinlock_t lock;
+	u32 mconfig1, cmacc, oldcmacc;
+
+	if (enable == oldstate)
+		return (long)enable;
+
+	/* This has to be done as early as possible ! */
+	spin_lock_irqsave(&lock, flags);
+
+	oldcmacc = sgimc->cmacc;
+	cmacc = (enable ? 6:4) | (oldcmacc & ~0xf);
+
+	/* increase WR_COL before (if at all) */
+	sgimc->cmacc = cmacc | 7;
+
+	/* enable memory bank 3 at 0x60000000 */
+	mconfig1 = sgimc->mconfig1;
+	sgimc->mconfig1 = mconfig1 & 0xffff0000 | 0x2060;
+	_r10k_real_sync(sgimc);
+
+	/* set mode to "slow" or "normal" */
+	*(volatile unsigned long*)modereg = enable ? 0x10000:0;
+	_r10k_real_sync(sgimc);
+
+	/* restore memory bank configuration */
+	sgimc->mconfig1 = mconfig1;
+
+	/* decrease WR_COL only after */
+	sgimc->cmacc = cmacc;
+	_r10k_real_sync(sgimc);
+
+	if (-1 == oldstate)
+		oldstate = (oldcmacc & 0xf) > 4;
+
+	tmp = oldstate;
+	oldstate = enable;
+	_r10k_real_sync(sgimc);
+
+	spin_unlock_irqrestore(&lock, flags);
+	return tmp;
+}
+#endif
+
+unsigned long ip2628_enable_ucmem (void)
+{
+#if defined(CONFIG_SGI_IP28) || defined(CONFIG_SGI_IP26)
+	if (!sgimc)
+		sgimc = (struct sgimc_regs *)
+				ioremap(SGIMC_BASE, sizeof(struct sgimc_regs));
+	return ip28_set_ucmem(sgimc,1);
+#else
+	return 0;
+#endif
+}
+
+void ip2628_return_ucmem ( unsigned long oldstate )
+{
+#if defined(CONFIG_SGI_IP28) || defined(CONFIG_SGI_IP26)
+	if (!sgimc)
+		sgimc = (struct sgimc_regs *)
+				ioremap(SGIMC_BASE, sizeof(struct sgimc_regs));
+	ip28_set_ucmem(sgimc,!!oldstate);
+#else
+	(void)oldstate;
+#endif
+}
+/*
+ * Revision 1.12, Tue Nov 18 05:15:20 2003
+ * Jun 2004/2005 pf	- IP28
+ */
diff -Nur linux-git/arch/mips/sgi-ip22/ip22-setup.c linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip22-setup.c
--- linux-git/arch/mips/sgi-ip22/ip22-setup.c	2005-10-15 16:01:07.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip22-setup.c	2005-10-16 13:21:56.000000000 +0200
@@ -119,6 +119,34 @@
 	}
 	}
 #endif
+#if defined(CONFIG_FB_IMPACT) || defined(CONFIG_SGI_IP28)
+	{
+		/* Get graphics info before it is overwritten...
+		 * E.g. @ 9000000020f02f78: ffffffff9fc6d770,900000001f000000
+		 */
+		ULONG* (*__vec)(void) = (typeof(__vec))
+#ifdef CONFIG_ARC64
+			((ULONG*)PROMBLOCK->pvector)[8];
+#else
+			(long) ((int*)PROMBLOCK->pvector)[8];
+#endif
+		ULONG *gfxinfo = (*__vec)();
+		ULONG a = gfxinfo[1];
+
+		if ((a & 0xffffffff80000000L) == 0xffffffff80000000L)
+			sgi_gfxaddr = a & (6L<<28) ? 0:CPHYSADDR(a); /* CKSEG[01] */
+		else if ((a & (1L<<63)) && (a & 0xb80000001fffffffL) == a)
+			sgi_gfxaddr = XPHYSADDR(a); /* lower 512MB of XKPHYS */
+		else /* rubbish... */
+			sgi_gfxaddr = 0;
+		if (sgi_gfxaddr < 0x1f000000)
+			sgi_gfxaddr = 0;
+
+		printk(KERN_DEBUG "ARCS gfx info @ %08lx: %08lx,%08lx\n",
+				gfxinfo, gfxinfo[0], gfxinfo[1]);
+		printk(KERN_INFO "SGI graphics system @ 0x%08lx\n", sgi_gfxaddr);
+	}
+#endif
 
 #if defined(CONFIG_VT) && defined(CONFIG_SGI_NEWPORT_CONSOLE)
 	{
diff -Nur linux-git/arch/mips/sgi-ip22/ip28-berr.c linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip28-berr.c
--- linux-git/arch/mips/sgi-ip22/ip28-berr.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/arch/mips/sgi-ip22/ip28-berr.c	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,600 @@
+/*
+ * ip28-berr.c: Bus error handling.
+ *
+ * Copyright (C) 2002, 2003 Ladislav Michl (ladis@linux-mips.org)
+ * Copyright (C) 2005 Peter Fuerst (pf@net.alphadv.de) - IP28
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+
+#include <asm/addrspace.h>
+#include <asm/system.h>
+#include <asm/traps.h>
+#include <asm/branch.h>
+#include <asm/sgi/mc.h>
+#include <asm/sgi/hpc3.h>
+#include <asm/sgi/ioc.h>
+#include <asm/sgi/ip22.h>
+#include <asm/r4kcache.h>
+#include <asm/uaccess.h>
+
+static unsigned int cpu_err_stat;	/* Status reg for CPU */
+static unsigned int gio_err_stat;	/* Status reg for GIO */
+static unsigned int cpu_err_addr;	/* Error address reg for CPU */
+static unsigned int gio_err_addr;	/* Error address reg for GIO */
+static unsigned int extio_stat;
+static unsigned int hpc3_berr_stat;	/* Bus error interrupt status */
+
+struct hpc3_stat {
+	unsigned int addr;
+	unsigned int ctrl;
+	unsigned int cbp;
+	unsigned int ndptr;
+};
+
+static struct {
+	struct hpc3_stat pbdma[8];
+	struct hpc3_stat scsi[2];
+	struct hpc3_stat ethrx, ethtx;
+} hpc3;
+
+static struct {
+	unsigned long err_addr;
+	struct { unsigned lo; unsigned hi; } /* Cache tag High/Low */
+		tags[1][2], tagd[4][2], tagi[4][2]; /* Way 0/1 */
+} cache_tags;
+
+static inline void save_cache_tags(unsigned busaddr)
+{
+	unsigned long addr = CAC_BASE | busaddr;
+	unsigned i;
+	cache_tags.err_addr = addr;
+
+	/*
+	 * Starting with a bus-address, save secondary cache (indexed by
+	 * PA[23..18:7..6]) tags first.
+	 */
+	addr &= ~1L;
+	#define tag cache_tags.tags[0]
+	cache_op(Index_Load_Tag_S, addr);
+	tag[0].lo = read_c0_taglo();	/* PA[35:18], VA[13:12] */
+	tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+	cache_op(Index_Load_Tag_S, addr | 1L);
+	tag[1].lo = read_c0_taglo();	/* PA[35:18], VA[13:12] */
+	tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+	#undef tag
+
+	/*
+	 * Save all primary data cache (indexed by VA[13:5]) tags which
+	 * might fit to this bus-address, knowing that VA[11:0] == PA[11:0].
+	 * Saving all tags and evaluating them later is easier and safer
+	 * than relying on VA[13:12] from the secondary cache tags to pick
+	 * matching primary tags here already.
+	 */
+	addr &= (0xffL << 56) | ((1 << 12) - 1);
+	#define tag cache_tags.tagd[i]
+	for (i = 0; i < 4; ++i, addr += (1 << 12))
+	{	cache_op(Index_Load_Tag_D, addr);
+		tag[0].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+		cache_op(Index_Load_Tag_D, addr | 1L);
+		tag[1].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+	}
+	#undef tag
+
+	/*
+	 * Save primary instruction cache (indexed by VA[13:6]) tags
+	 * the same way.
+	 */
+	addr &= (0xffL << 56) | ((1 << 12) - 1);
+	#define tag cache_tags.tagi[i]
+	for (i = 0; i < 4; ++i, addr += (1 << 12))
+	{	cache_op(Index_Load_Tag_I, addr);
+		tag[0].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+		cache_op(Index_Load_Tag_I, addr | 1L);
+		tag[1].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+	}
+	#undef tag
+}
+
+#define GIO_ERRMASK	0xff00
+#define CPU_ERRMASK	0x3f00
+
+static void save_and_clear_buserr(void)
+{
+	unsigned i;
+
+	/* save status registers */
+	cpu_err_addr = sgimc->cerr;
+	cpu_err_stat = sgimc->cstat;
+	gio_err_addr = sgimc->gerr;
+	gio_err_stat = sgimc->gstat;
+	//BUG_ON(!ip22_is_fullhouse());
+	extio_stat = sgioc->extio;
+	hpc3_berr_stat = hpc3c0->bestat;
+
+	hpc3.scsi[0].addr  = &hpc3c0->scsi_chan0;
+	hpc3.scsi[0].ctrl  = hpc3c0->scsi_chan0.ctrl; /* HPC3_SCTRL_ACTIVE ? */
+	hpc3.scsi[0].cbp   = hpc3c0->scsi_chan0.cbptr;
+	hpc3.scsi[0].ndptr = hpc3c0->scsi_chan0.ndptr;
+
+	hpc3.scsi[1].addr  = &hpc3c0->scsi_chan1;
+	hpc3.scsi[1].ctrl  = hpc3c0->scsi_chan1.ctrl; /* HPC3_SCTRL_ACTIVE ? */
+	hpc3.scsi[1].cbp   = hpc3c0->scsi_chan1.cbptr;
+	hpc3.scsi[1].ndptr = hpc3c0->scsi_chan1.ndptr;
+
+	hpc3.ethrx.addr  = &hpc3c0->ethregs.rx_cbptr;
+	hpc3.ethrx.ctrl  = hpc3c0->ethregs.rx_ctrl; /* HPC3_ERXCTRL_ACTIVE ? */
+	hpc3.ethrx.cbp   = hpc3c0->ethregs.rx_cbptr;
+	hpc3.ethrx.ndptr = hpc3c0->ethregs.rx_ndptr;
+
+	hpc3.ethtx.addr  = &hpc3c0->ethregs.tx_cbptr;
+	hpc3.ethtx.ctrl  = hpc3c0->ethregs.tx_ctrl; /* HPC3_ETXCTRL_ACTIVE ? */
+	hpc3.ethtx.cbp   = hpc3c0->ethregs.tx_cbptr;
+	hpc3.ethtx.ndptr = hpc3c0->ethregs.tx_ndptr;
+
+	for (i = 0; i < 8; ++i) {
+		/* HPC3_PDMACTRL_ISACT ? */
+		hpc3.pbdma[i].addr  = &hpc3c0->pbdma[i];
+		hpc3.pbdma[i].ctrl  = hpc3c0->pbdma[i].pbdma_ctrl;
+		hpc3.pbdma[i].cbp   = hpc3c0->pbdma[i].pbdma_bptr;
+		hpc3.pbdma[i].ndptr = hpc3c0->pbdma[i].pbdma_dptr;
+	}
+	i = 0;
+	if (gio_err_stat & CPU_ERRMASK)
+		i = gio_err_addr;
+	if (cpu_err_stat & CPU_ERRMASK)
+		i = cpu_err_addr;
+	save_cache_tags(i);
+
+	sgimc->cstat = sgimc->gstat = 0;
+}
+
+static void print_cache_tags(void)
+{
+	unsigned i, scb, scw;
+
+	printk(KERN_ERR "Cache tags @ %08x:\n", (unsigned)cache_tags.err_addr);
+
+	/* PA[31:12] shifted to PTag0 (PA[35:12]) format */
+	scw = (cache_tags.err_addr >> 4) & 0x0fffff00;
+
+	scb = cache_tags.err_addr & ((1 << 12) - 1) & ~((1 << 5) - 1);
+	for (i = 0; i < 4; ++i) { /* for each possible VA[13:12] value */
+		if ((cache_tags.tagd[i][0].lo & 0x0fffff00) != scw &&
+		    (cache_tags.tagd[i][1].lo & 0x0fffff00) != scw)
+		    continue;
+		printk(KERN_ERR "D: 0: %08x %08x, 1: %08x %08x  (VA[13:5]  %04x)\n",
+			cache_tags.tagd[i][0].hi, cache_tags.tagd[i][0].lo,
+			cache_tags.tagd[i][1].hi, cache_tags.tagd[i][1].lo,
+			scb | (1 << 12)*i);
+	}
+	scb = cache_tags.err_addr & ((1 << 12) - 1) & ~((1 << 6) - 1);
+	for (i = 0; i < 4; ++i) { /* for each possible VA[13:12] value */
+		if ((cache_tags.tagi[i][0].lo & 0x0fffff00) != scw &&
+		    (cache_tags.tagi[i][1].lo & 0x0fffff00) != scw)
+		    continue;
+		printk(KERN_ERR "I: 0: %08x %08x, 1: %08x %08x  (VA[13:6]  %04x)\n",
+			cache_tags.tagi[i][0].hi, cache_tags.tagi[i][0].lo,
+			cache_tags.tagi[i][1].hi, cache_tags.tagi[i][1].lo,
+			scb | (1 << 12)*i);
+	}
+	i = read_c0_config();
+	scb = i & (1 << 13) ? 7:6;      /* scblksize = 2^[7..6] */
+	scw = ((i >> 16) & 7) + 19 - 1; /* scwaysize = 2^[24..19] / 2 */
+
+	i = ((1 << scw) - 1) & ~((1 << scb) - 1);
+	printk(KERN_ERR "S: 0: %08x %08x, 1: %08x %08x  (PA[%u:%u] %05x)\n",
+		cache_tags.tags[0][0].hi, cache_tags.tags[0][0].lo,
+		cache_tags.tags[0][1].hi, cache_tags.tags[0][1].lo,
+		scw-1, scb, i & (unsigned)cache_tags.err_addr);
+}
+
+static void print_buserr(void)
+{
+	int error = 0;
+
+	if (extio_stat & EXTIO_MC_BUSERR) {
+		printk(KERN_ERR "MC Bus Error\n");
+		error |= 1;
+	}
+	if (extio_stat & EXTIO_HPC3_BUSERR) {
+		printk(KERN_ERR "HPC3 Bus Error 0x%x:<id=0x%x,%s,lane=0x%x>\n",
+			hpc3_berr_stat,
+			(hpc3_berr_stat & HPC3_BESTAT_PIDMASK) >>
+					  HPC3_BESTAT_PIDSHIFT,
+			(hpc3_berr_stat & HPC3_BESTAT_CTYPE) ? "PIO" : "DMA",
+			hpc3_berr_stat & HPC3_BESTAT_BLMASK);
+		error |= 2;
+	}
+	if (extio_stat & EXTIO_EISA_BUSERR) {
+		printk(KERN_ERR "EISA Bus Error\n");
+		error |= 4;
+	}
+	if (cpu_err_stat & CPU_ERRMASK) {
+		printk(KERN_ERR "CPU error 0x%x<%s%s%s%s%s%s> @ 0x%08x\n",
+			cpu_err_stat,
+			cpu_err_stat & SGIMC_CSTAT_RD ? "RD " : "",
+			cpu_err_stat & SGIMC_CSTAT_PAR ? "PAR " : "",
+			cpu_err_stat & SGIMC_CSTAT_ADDR ? "ADDR " : "",
+			cpu_err_stat & SGIMC_CSTAT_SYSAD_PAR ? "SYSAD " : "",
+			cpu_err_stat & SGIMC_CSTAT_SYSCMD_PAR ? "SYSCMD " : "",
+			cpu_err_stat & SGIMC_CSTAT_BAD_DATA ? "BAD_DATA " : "",
+			cpu_err_addr);
+		error |= 8;
+	}
+	if (gio_err_stat & GIO_ERRMASK) {
+		printk(KERN_ERR "GIO error 0x%x:<%s%s%s%s%s%s%s%s> @ 0x%08x\n",
+			gio_err_stat,
+			gio_err_stat & SGIMC_GSTAT_RD ? "RD " : "",
+			gio_err_stat & SGIMC_GSTAT_WR ? "WR " : "",
+			gio_err_stat & SGIMC_GSTAT_TIME ? "TIME " : "",
+			gio_err_stat & SGIMC_GSTAT_PROM ? "PROM " : "",
+			gio_err_stat & SGIMC_GSTAT_ADDR ? "ADDR " : "",
+			gio_err_stat & SGIMC_GSTAT_BC ? "BC " : "",
+			gio_err_stat & SGIMC_GSTAT_PIO_RD ? "PIO_RD " : "",
+			gio_err_stat & SGIMC_GSTAT_PIO_WR ? "PIO_WR " : "",
+			gio_err_addr);
+		error |= 16;
+	}
+	if (!error)
+		printk(KERN_ERR "MC: Hmm, didn't find any error condition.\n");
+	else {
+		printk(KERN_ERR "CP0: config %08x,  "
+			"MC: cpuctrl0/1: %08x/%05x, giopar: %04x\n"
+			"MC: cpu/gio_memacc: %08x/%05x, memcfg0/1: %08x/%08x\n",
+			read_c0_config(),
+			sgimc->cpuctrl0, sgimc->cpuctrl0, sgimc->giopar,
+			sgimc->cmacc, sgimc->gmacc,
+			sgimc->mconfig0, sgimc->mconfig1);
+		print_cache_tags();
+	}
+}
+
+/*
+ * Try to find out, whether the bus error is caused by the instruction
+ * at EPC, otherwise we have an asynchronous error.
+ *
+ * Doc1: "MIPS IV Instruction Set", Rev 3.2 (SGI 007-2597-001)
+ * Doc2: "MIPS R10000 Microporcessor User's Manual", Ver 2.0 (SGI 007-2490-001)
+ * Doc3: "MIPS R4000 Microporcessor User's Manual", 2nd Ed. (SGI 007-2489-001)
+ */
+
+#define JMP_INDEX26_OP 1
+#define JMP_REGISTER_OP 2
+#define JMP_PCREL16_OP 3
+#define BASE_OFFSET_OP 4
+#define BASE_IDXREG_OP 5
+
+/* Match virtual address in an insn with physical error address */
+
+static int match_addr(unsigned paddr, unsigned long vaddr)
+{
+	unsigned uaddr;
+
+	if ((vaddr & 0xffffffff80000000L) == 0xffffffff80000000L)
+		uaddr = (unsigned) CPHYSADDR(vaddr);
+	else if ((vaddr >> 62) == 2)
+		uaddr = (unsigned) XPHYSADDR(vaddr);
+	else
+	{	unsigned long eh = vaddr & ~0x1fffL;
+		eh |= read_c0_entryhi() & 0xff;
+		write_c0_entryhi(eh);
+		tlb_probe();
+		if (read_c0_index() & 0x80000000)
+			return 0;
+		tlb_read();
+		if (vaddr & (1L << PAGE_SHIFT))
+			uaddr = (unsigned) read_c0_entrylo1();
+		else
+			uaddr = (unsigned) read_c0_entrylo0();
+		uaddr <<= 6;
+		uaddr &= ~PAGE_MASK;
+		uaddr |= vaddr & PAGE_MASK;
+	}
+	return ((uaddr & ~0x7f) == (paddr & ~0x7f));
+}
+
+/* Check, which kind of memory reference is triggered by `insn' */
+
+static int check_special(unsigned insn)
+{
+	/* See Doc1, page A-180 */
+	unsigned func = insn & 0x3f;
+
+	if (8 == func || 8+1 == func) /* JR, JALR */
+		return JMP_REGISTER_OP;
+
+	return 0;
+}
+
+static int check_regimm(unsigned insn)
+{
+	/* See Doc1, page A-180 */
+	unsigned rt = (insn >> 19) & 3; /* bits 20..19[..16] */
+
+	/* BLTZ, BGEZ, BLTZL, BBGEZL || BLTZAL, BGEZAL, BLTZALL, BBGEZALL */
+	if (!rt || 2 == rt)
+		return JMP_PCREL16_OP;
+
+	return 0;
+}
+
+static int check_cop0(unsigned insn)
+{
+	/* See Doc2, pages 287 ff., 187 ff. */
+	if ((insn >> 26) == 5*8+7) /* CACHE */
+		switch ((insn >> 16) & 0x1f) {
+			case Index_Writeback_Inv_D:
+			case Hit_Writeback_Inv_D:
+			case Index_Writeback_Inv_S:
+			case Hit_Writeback_Inv_S:
+				return BASE_OFFSET_OP;
+		}
+	return 0;
+}
+
+static int check_cop1(unsigned insn)
+{
+	/* See Doc1, pages B-108 ff. */
+	unsigned fmt = (insn >> 21) & 0x1f; /* bits 25..21 */
+
+	if (8 == fmt) /* BC1* */
+		return JMP_PCREL16_OP;
+
+	return 0;
+}
+
+static int check_cop1x(unsigned insn)
+{
+	/* See Doc1, pages B-108 ff. */
+	switch (insn & 0x3f) {
+		case 0:   /* LWXC1 */
+		case 1:   /* LDXC1 */
+		case 8:   /* SWXC1 */
+		case 8+1: /* SDXC1 */
+			return BASE_IDXREG_OP;
+	}
+	return 0;
+}
+
+static int check_plain(unsigned insn)
+{
+	/* See Doc1, page A-180 */
+	unsigned opcode = insn >> 26;
+
+	if (2 == opcode || 3 == opcode) /* J, JAL */
+		return JMP_INDEX26_OP;
+
+	if (4     <= opcode && opcode <= 7 ||   /* BEQ, BNE, BLEZ, BGTZ */
+	    4+2*8 <= opcode && opcode <= 7+2*8) /* BEQL, BNEL, BLEZL, BGTZL */
+		return JMP_PCREL16_OP;
+
+	if (6*8+3 == opcode) /* PREF */
+		return 0;
+
+	if (3*8+2 == opcode || 3*8+3 == opcode || /* LDL, LDR */
+	    4*8 <= opcode) /* misc. LOAD, STORE */
+		return BASE_OFFSET_OP;
+
+	return 0;
+}
+
+/* Check, whether the insn at EPC causes a memory access at `paddr' */
+
+static int check_addr_in_insn(unsigned paddr, struct pt_regs *regs)
+{
+	unsigned long epc;
+	unsigned insn;
+	int typ;
+
+	epc = regs->cp0_cause & CAUSEF_BD ? regs->cp0_epc:regs->cp0_epc+4;
+
+	/* show_code() from kernel/traps.c */
+	if (__get_user(insn, (unsigned*) epc))
+		return 1;
+
+	/* See Doc1, pages A-180, B-108 ff. */
+	switch (insn >> 26)
+	{	case 0:
+			typ = check_special(insn);
+			break;
+		case 1:
+			typ = check_regimm(insn);
+			break;
+		case 2*8:   /* COP0 */
+		case 5*8+7: /* CACHE */
+			typ = check_cop0(insn);
+			break;
+		case 2*8+1:
+			typ = check_cop1(insn);
+			break;
+		case 2*8+3:
+			typ = check_cop1x(insn);
+			break;
+		default:
+			typ = check_plain(insn);
+	}
+	switch (typ)
+	{	unsigned long a;
+		case JMP_INDEX26_OP:
+			a = (regs->cp0_epc + 4) & ~0xfffffff;
+			a |= (insn & 0x3ffffff) << 2;
+			return match_addr(paddr, a);
+		case JMP_REGISTER_OP:
+			a = regs->regs[(insn >> 21) & 0x1f];
+			return match_addr(paddr, a);
+		case JMP_PCREL16_OP:
+			a = regs->cp0_epc + 4 + ((insn & 0xffff) << 2);
+			return match_addr(paddr, a);
+		case BASE_OFFSET_OP:
+			a = regs->regs[(insn >> 21) & 0x1f] + (insn & 0xffff);
+			return match_addr(paddr, a);
+		case BASE_IDXREG_OP:
+			a = regs->regs[(insn >> 21) & 0x1f];
+			a += regs->regs[(insn >> 16) & 0x1f];
+			return match_addr(paddr, a);
+		case 0:
+			return 0;
+	}
+	/* Assume it would be too dangerous to continue ... */
+	return 1;
+}
+
+/* Check, whether MC's (virtual) DMA address caused the bus error. */
+
+static int check_vdma_memaddr (void)
+{
+	/* Deferred until needed. */
+	return 0;
+}
+
+static int check_vdma_gioaddr (void)
+{
+	/* Deferred until needed. */
+	return 0;
+}
+
+static inline const char *cause_excode_text(int cause)
+{
+	static const char *txt[32] =
+	{	"Interrupt",
+		"TLB modification",
+		"TLB (load or instruction fetch)",
+		"TLB (store)",
+		"Address error (load or instruction fetch)",
+		"Address error (store)",
+		"Bus error (instruction fetch)",
+		"Bus error (data: load or store)",
+		"Syscall",
+		"Breakpoint",
+		"Reserved instruction",
+		"Coprocessor unusable",
+		"Arithmetic Overflow",
+		"Trap",
+		"14",
+		"Floating-Point",
+		"16", "17", "18", "19", "20", "21", "22",
+		"Watch Hi/Lo",
+		"24", "25", "26", "27", "28", "29", "30", "31",
+	};
+	return txt[(cause & 0x7c) >> 2];
+}
+
+/*
+ * MC sends an interrupt whenever bus or parity errors occur. In addition,
+ * if the error happened during a CPU read, it also asserts the bus error
+ * pin on the R4K. Code in bus error handler save the MC bus error registers
+ * and then clear the interrupt when this happens.
+ */
+
+static int ip28_be_interrupt(struct pt_regs *regs)
+{
+	const int field = 2 * sizeof(unsigned long);
+	unsigned i;
+
+	save_and_clear_buserr();
+	print_buserr();
+	printk(KERN_ALERT "%s, epc == %0*lx, ra == %0*lx\n",
+	       cause_excode_text(regs->cp0_cause),
+	       field, regs->cp0_epc, field, regs->regs[31]);
+	/*
+	 * Try to find out, whether we got here by a mispredicted speculative
+	 * load/store operation.  If so, it's not fatal, we can go on.
+	 */
+	/* Any cause other than "Interrupt" (ExcCode 0) is fatal. */
+	if (regs->cp0_cause & CAUSEF_EXCCODE)
+		return MIPS_BE_FATAL;
+
+	/* Any cause other than "Bus error interrupt" (IP6) is weird. */
+	if ((regs->cp0_cause & CAUSEF_IP6) != CAUSEF_IP6)
+		return MIPS_BE_FATAL;
+
+	if (extio_stat & (EXTIO_HPC3_BUSERR | EXTIO_EISA_BUSERR))
+		return MIPS_BE_FATAL;
+
+	/* Any state other than "Memory bus error" is fatal. */
+	if (cpu_err_stat & CPU_ERRMASK & ~SGIMC_CSTAT_ADDR)
+			return MIPS_BE_FATAL;
+
+	/* Any state other than "GIO transaction bus timed out" is fatal. */
+	if (gio_err_stat & GIO_ERRMASK & ~SGIMC_GSTAT_TIME)
+		return MIPS_BE_FATAL;
+
+	/* Finding `cpu_err_addr' in the insn at EPC is fatal. */
+	if ((cpu_err_stat & CPU_ERRMASK) && check_addr_in_insn(cpu_err_addr,regs))
+			return MIPS_BE_FATAL;
+
+	/* Finding `gio_err_addr' in the insn at EPC is fatal. */
+	if ((gio_err_stat & GIO_ERRMASK) && check_addr_in_insn(gio_err_addr,regs))
+		return MIPS_BE_FATAL;
+	/*
+	 * Now we have an asynchronous bus error, speculatively or DMA caused.
+	 * Need to search all DMA descriptors for the error address.
+	 */
+	for (i = 0; i < sizeof(hpc3)/sizeof(struct hpc3_stat); ++i) {
+		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
+		if ((cpu_err_stat & CPU_ERRMASK) &&
+		    (cpu_err_addr == hp->ndptr || cpu_err_addr == hp->cbp))
+			break;
+		if ((gio_err_stat & GIO_ERRMASK) &&
+		    (gio_err_addr == hp->ndptr || gio_err_addr == hp->cbp))
+			break;
+	}
+	if (i < sizeof(hpc3)/sizeof(struct hpc3_stat)) {
+		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
+		printk(KERN_ERR "at DMA addresses: HPC3 @ %08lx:"
+		       " ctl %08x, ndp %08x, cbp %08x\n",
+		       CPHYSADDR(hp->addr), hp->ctrl, hp->ndptr, hp->cbp);
+		return MIPS_BE_FATAL;
+	}
+	/* Check MC's virtual DMA stuff. */
+	if ( check_vdma_memaddr() ) {
+		printk(KERN_ERR "at GIO DMA: mem address 0x%08x.\n",
+			sgimc->maddronly);
+		return MIPS_BE_FATAL;
+	}
+	if ( check_vdma_gioaddr() ) {
+		printk(KERN_ERR "at GIO DMA: gio address 0x%08x.\n",
+			sgimc->gmaddronly);
+		return MIPS_BE_FATAL;
+	}
+	/* A speculative bus error... */
+	printk(KERN_ERR "discarded!\n");
+	return MIPS_BE_DISCARD;
+}
+
+void ip22_be_interrupt(int irq, struct pt_regs *regs)
+{
+	if (ip28_be_interrupt(regs) != MIPS_BE_DISCARD) {
+		/* Assume it would be too dangerous to continue ... */
+		die_if_kernel("Oops", regs);
+		force_sig(SIGBUS, current);
+	} else {
+		show_regs(regs);
+		show_code((unsigned int *) regs->cp0_epc);
+	}
+}
+
+static int ip28_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	/*
+	 * We arrive here only in the unusual case of do_be() invocation,
+	 * i.e. by a bus error exception without a bus error interrupt.
+	 */
+	if (is_fixup) {
+		save_and_clear_buserr();
+		return MIPS_BE_FIXUP;
+	}
+	return ip28_be_interrupt(regs);
+}
+
+void __init ip22_be_init(void)
+{
+	board_be_handler = ip28_be_handler;
+}
diff -Nur linux-git/arch/mips/sgi-ip22/Makefile linux-git-mit-R10k-patches/arch/mips/sgi-ip22/Makefile
--- linux-git/arch/mips/sgi-ip22/Makefile	2005-10-15 16:01:07.000000000 +0200
+++ linux-git-mit-R10k-patches/arch/mips/sgi-ip22/Makefile	2005-10-16 13:21:56.000000000 +0200
@@ -3,9 +3,13 @@
 # under Linux.
 #
 
-obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-irq.o ip22-berr.o \
+obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-irq.o \
 	   ip22-time.o ip22-nvram.o ip22-reset.o ip22-setup.o
 
+obj-$(CONFIG_SGI_IP28)	+= ip28-berr.o
+obj-$(CONFIG_SGI_IP22)	+= ip22-berr.o
 obj-$(CONFIG_EISA)	+= ip22-eisa.o
 
 EXTRA_AFLAGS := $(CFLAGS)
+
+# Revision 1.19, Tue Nov 18 05:15:20 2003
diff -Nur linux-git/drivers/char/Kconfig linux-git-mit-R10k-patches/drivers/char/Kconfig
--- linux-git/drivers/char/Kconfig	2005-10-15 16:01:11.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/char/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -762,7 +762,7 @@
 
 config SGI_DS1286
 	tristate "SGI DS1286 RTC support"
-	depends on SGI_IP22
+	depends on (SGI_IP22 || SGI_IP28)
 	help
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
diff -Nur linux-git/drivers/char/tty_io.c linux-git-mit-R10k-patches/drivers/char/tty_io.c
--- linux-git/drivers/char/tty_io.c	2005-10-15 16:01:12.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/char/tty_io.c	2005-10-16 13:21:56.000000000 +0200
@@ -744,6 +744,7 @@
  
 void tty_wakeup(struct tty_struct *tty)
 {
+	if (tty) {
 	struct tty_ldisc *ld;
 	
 	if (test_bit(TTY_DO_WRITE_WAKEUP, &tty->flags)) {
@@ -755,6 +756,7 @@
 		}
 	}
 	wake_up_interruptible(&tty->write_wait);
+	}
 }
 
 EXPORT_SYMBOL_GPL(tty_wakeup);
@@ -3014,3 +3016,7 @@
 	return 0;
 }
 module_init(tty_init);
+/*
+ * Revision 1.133, Tue Apr 19 00:39:02 2005
+ * Wed Jan  5 02:16:41 2005
+ */
diff -Nur linux-git/drivers/char/watchdog/Kconfig linux-git-mit-R10k-patches/drivers/char/watchdog/Kconfig
--- linux-git/drivers/char/watchdog/Kconfig	2005-10-15 16:01:12.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/char/watchdog/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -427,7 +427,7 @@
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on WATCHDOG && SGI_IP22
+	depends on WATCHDOG && (SGI_IP22 || SGI_IP28)
 	help
 	  Hardwaredriver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
diff -Nur linux-git/drivers/input/serio/i8042.c linux-git-mit-R10k-patches/drivers/input/serio/i8042.c
--- linux-git/drivers/input/serio/i8042.c	2005-10-15 16:01:13.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/input/serio/i8042.c	2005-10-16 13:21:56.000000000 +0200
@@ -656,7 +656,13 @@
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (param & I8042_CTR_AUXDIS))
+#ifdef CONFIG_SGI_IP28
+		/* Seems we need to invert the CTR_AUXDIS-test on this machine:
+		 * CMD_AUX_DISABLE -> rctr 0xcf, CMD_AUX_ENABLE -> rctr 0xef */
+		printk(KERN_WARNING "Failed to enable AUX port, but continuing anyway... ;)\n");
+#else
 		return -1;
+#endif
 
 /*
  * Disable the interface.
diff -Nur linux-git/drivers/input/serio/i8042.h linux-git-mit-R10k-patches/drivers/input/serio/i8042.h
--- linux-git/drivers/input/serio/i8042.h	2005-10-15 16:01:13.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/input/serio/i8042.h	2005-10-16 13:21:56.000000000 +0200
@@ -17,7 +17,7 @@
 
 #if defined(CONFIG_MACH_JAZZ)
 #include "i8042-jazzio.h"
-#elif defined(CONFIG_SGI_IP22)
+#elif defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP28)
 #include "i8042-ip22io.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
@@ -131,3 +131,7 @@
 #endif
 
 #endif /* _I8042_H */
+/*
+ * Revision 1.10, Tue Apr 19 00:50:01 2005
+ * Tue Dec  7 19:43:43 2004	- IP28
+ */
diff -Nur linux-git/drivers/net/Kconfig linux-git-mit-R10k-patches/drivers/net/Kconfig
--- linux-git/drivers/net/Kconfig	2005-10-15 16:01:16.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/net/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -1728,7 +1728,7 @@
 
 config SGISEEQ
 	tristate "SGI Seeq ethernet controller support"
-	depends on NET_ETHERNET && SGI_IP22
+	depends on NET_ETHERNET && (SGI_IP22 || SGI_IP26 || SGI_IP28)
 	help
 	  Say Y here if you have an Seeq based Ethernet network card. This is
 	  used in many Silicon Graphics machines.
diff -Nur linux-git/drivers/scsi/Kconfig linux-git-mit-R10k-patches/drivers/scsi/Kconfig
--- linux-git/drivers/scsi/Kconfig	2005-10-15 16:01:20.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/scsi/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -249,7 +249,7 @@
 
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
-	depends on SGI_IP22 && SCSI
+	depends on (SGI_IP22 || SGI_IP26 || SGI_IP28) && SCSI
   	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
diff -Nur linux-git/drivers/scsi/wd33c93.c linux-git-mit-R10k-patches/drivers/scsi/wd33c93.c
--- linux-git/drivers/scsi/wd33c93.c	2005-10-15 16:01:23.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/scsi/wd33c93.c	2005-10-16 13:21:56.000000000 +0200
@@ -1460,7 +1460,7 @@
 	const wd33c93_regs regs = hostdata->regs;
 	uchar sr;
 
-#ifdef CONFIG_SGI_IP22
+#if defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP28)
 	{
 		int busycount = 0;
 		extern void sgiwd93_reset(unsigned long);
diff -Nur linux-git/drivers/serial/ip22zilog.c linux-git-mit-R10k-patches/drivers/serial/ip22zilog.c
--- linux-git/drivers/serial/ip22zilog.c	2005-10-15 16:01:24.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/serial/ip22zilog.c	2005-10-16 13:44:41.000000000 +0200
@@ -1015,9 +1015,9 @@
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	for (i = 0; i < count; i++, s++) {
-		ip22zilog_put_char(channel, *s);
 		if (*s == 10)
 			ip22zilog_put_char(channel, 13);
+		ip22zilog_put_char(channel, *s);
 	}
 	udelay(2);
 	spin_unlock_irqrestore(&up->port.lock, flags);
diff -Nur linux-git/drivers/serial/Kconfig linux-git-mit-R10k-patches/drivers/serial/Kconfig
--- linux-git/drivers/serial/Kconfig	2005-10-15 16:01:24.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/serial/Kconfig	2005-10-16 13:21:56.000000000 +0200
@@ -555,16 +555,18 @@
 
 config SERIAL_IP22_ZILOG
 	tristate "IP22 Zilog8530 serial support"
-	depends on SGI_IP22
+	depends on (SGI_IP22 || SGI_IP28)
 	select SERIAL_CORE
+	default y if SGI_IP28
 	help
-	  This driver supports the Zilog8530 serial ports found on SGI IP22
+	This driver supports the Zilog8530 serial ports found on SGI IP22-IP28
 	  systems.  Say Y or M if you want to be able to these serial ports.
 
 config SERIAL_IP22_ZILOG_CONSOLE
-	bool "Console on IP22 Zilog8530 serial port"
+	bool "Console on IP22/28 Zilog8530 serial port"
 	depends on SERIAL_IP22_ZILOG=y
 	select SERIAL_CORE_CONSOLE
+	default y if SGI_IP28
 
 config V850E_UART
 	bool "NEC V850E on-chip UART support"
diff -Nur linux-git/drivers/video/impact.c linux-git-mit-R10k-patches/drivers/video/impact.c
--- linux-git/drivers/video/impact.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/drivers/video/impact.c	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,906 @@
+/*
+ * linux/drivers/video/impactsr.c -- SGI Octane MardiGras (IMPACTSR) graphics
+ * linux/drivers/video/impact.c   -- SGI Indigo2 MardiGras (IMPACT) graphics
+ *
+ *  Copyright (c) 2004 by Stanislaw Skowronek
+ *  Adapted to Indigo2 by pf, 2005
+ *
+ *  Based on linux/drivers/video/skeletonfb.c
+ *
+ *  This driver, as most of the IP30 (SGI Octane) port, is a result of massive
+ *  amounts of reverse engineering and trial-and-error. If anyone is interested
+ *  in helping with it, please contact me: <sskowron@et.put.poznan.pl>.
+ *
+ *  The basic functions of this driver are filling and blitting rectangles.
+ *  To achieve the latter, two DMA operations are used on Impact. It is unclear
+ *  to me, why is it so, but even Xsgi (the IRIX X11 server) does it this way.
+ *  It seems that fb->fb operations are not operational on these cards.
+ *
+ *  For this purpose, a kernel DMA pool is allocated (pool number 0). This pool
+ *  is (by default) 64kB in size. An ioctl could be used to set the value at
+ *  run-time. Applications can use this pool, however proper locking has to be
+ *  guaranteed. Kernel should be locked out from this pool by an ioctl.
+ *
+ *  The IMPACTSR is quite well worked-out currently, except for the Geometry
+ *  Engines (GE11). Any information about use of those devices would be very
+ *  useful. It would enable a Linux OpenGL driver, as most of OpenGL calls are
+ *  supported directly by the hardware. So far, I can't initialize the GE11.
+ *  Verification of microcode crashes the graphics.
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/font.h>
+#include <asm/sgi/mc.h>
+
+#include <video/impact.h>
+
+#if defined(CONFIG_SGI_IP28)||defined(CONFIG_SGI_IP26)||defined(CONFIG_SGI_IP22)
+ #define INDIGO2 1
+#else
+ #undef INDIGO2
+#endif
+
+/* Some fixed register values. */
+
+#ifdef INDIGO2 /* Impact (HQ3) registers */
+#define MSK_CFIFO_CNT	0x7f
+#define POOLS	4
+#else /* ImpactSR (HQ4) registers */
+#define VAL_CFIFO_HW	0x47
+#define VAL_CFIFO_LW	0x14
+#define VAL_CFIFO_DELAY	0x64
+#define VAL_DFIFO_HW	0x40
+#define VAL_DFIFO_LW	0x10
+#define VAL_DFIFO_DELAY	0
+#define MSK_CFIFO_CNT	0xff
+#define POOLS	5
+#endif
+
+#define IMPACT_KPOOL_SIZE	65536
+
+struct impact_par {
+	/* physical mmio base in HEART XTalk space */
+	unsigned long mmio_base;
+	/* virtual mmio base in kernel space */
+	unsigned long mmio_virt;
+	/* DMA pool management */
+	unsigned int *pool_txtbl[POOLS];
+	unsigned int pool_txnum[POOLS];
+	unsigned int pool_txmax[POOLS];
+	unsigned long pool_txphys[POOLS];
+	/* kernel DMA pools */
+	unsigned long **kpool_virt[POOLS];
+	unsigned long *kpool_phys[POOLS];
+	unsigned int kpool_size[POOLS];
+	/* locks to prevent simultaneous user and kernel access */
+	int open_flag;
+	int mmap_flag;
+	spinlock_t lock;
+};
+
+static struct fb_fix_screeninfo impact_fix = {
+	.id =		"Impact",
+	.smem_start = 	0,
+	.smem_len =	0,
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_TRUECOLOR,
+	.xpanstep =	0,
+	.ypanstep =	0,
+	.ywrapstep =	0,
+	.line_length =	0,
+	.accel =	FB_ACCEL_SGI_IMPACT,
+};
+
+static struct fb_var_screeninfo impact_var = {
+	.xres =		1280,
+	.yres =		1024,
+	.xres_virtual =	1280,
+	.yres_virtual =	1024,
+	.bits_per_pixel = 24,
+	.red =		{ .offset = 0, .length = 8 },
+	.green =	{ .offset = 8, .length = 8 },
+	.blue =		{ .offset = 16, .length = 8 },
+	.transp =	{ .offset = 24, .length = 8 },
+};
+
+static struct fb_info info;
+
+static unsigned int pseudo_palette[256];
+
+static struct impact_par current_par;
+
+int impact_init(void);
+
+/* --------------------- Gory Details --------------------- */
+#define MMIO (((struct impact_par *)p->par)->mmio_virt)
+#define PAR (*((struct impact_par *)p->par))
+
+static void impact_wait_cfifo(struct fb_info *p,int nslots)
+{
+	while((IMPACT_FIFOSTATUS(MMIO)&MSK_CFIFO_CNT)>(IMPACT_CFIFO_MAX-nslots));
+}
+static void impact_wait_cfifo_empty(struct fb_info *p)
+{
+	while(IMPACT_FIFOSTATUS(MMIO)&MSK_CFIFO_CNT);
+}
+static void impact_wait_bfifo(struct fb_info *p,int nslots)
+{
+	while((IMPACT_GIOSTATUS(MMIO)&0x1f)>(IMPACT_BFIFO_MAX-nslots));
+}
+static void impact_wait_bfifo_empty(struct fb_info *p)
+{
+	while(IMPACT_GIOSTATUS(MMIO)&0x1f);
+}
+static void impact_wait_dma(struct fb_info *p)
+{
+	while(IMPACT_DMABUSY(MMIO)&0x1f);
+	while(!(IMPACT_STATUS(MMIO)&1));
+	while(!(IMPACT_STATUS(MMIO)&2));
+	while(!(IMPACT_RESTATUS(MMIO)&0x100));
+}
+static void impact_wait_dmaready(struct fb_info *p)
+{
+	IMPACT_CFIFOW(MMIO)=0x000e0100;
+	while(IMPACT_DMABUSY(MMIO)&0x1eff);
+	while(!(IMPACT_STATUS(MMIO)&2));
+}
+
+static void impact_inithq(struct fb_info *p)
+{
+#ifndef INDIGO2 /* The friendly PROM did this already for us... */
+	/* CFIFO parameters */
+	IMPACT_CFIFO_HW(MMIO)=VAL_CFIFO_HW;
+	IMPACT_CFIFO_LW(MMIO)=VAL_CFIFO_LW;
+	IMPACT_CFIFO_DELAY(MMIO)=VAL_CFIFO_DELAY;
+	/* DFIFO parameters */
+	IMPACT_DFIFO_HW(MMIO)=VAL_DFIFO_HW;
+	IMPACT_DFIFO_LW(MMIO)=VAL_DFIFO_LW;
+	IMPACT_DFIFO_DELAY(MMIO)=VAL_DFIFO_DELAY;
+#endif
+}
+
+static void impact_initrss(struct fb_info *p)
+{
+	/* transfer mask registers */
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKMSBS(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMASKLO(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMASKHI(0xffffff);
+	/* use the main plane */
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_DRBPOINTERS(0xc8240);
+	/* set the RE into vertical flip mode */
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_CONFIG(0xcac);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XYWIN(0,0x3ff);
+}
+
+static void impact_initxmap(struct fb_info *p)
+{
+	/* set XMAP into 24-bpp mode */
+	IMPACT_XMAP_PP1SELECT(MMIO)=0x01;
+	IMPACT_XMAP_INDEX(MMIO)=0x00;
+	IMPACT_XMAP_MAIN_MODE(MMIO)=0x07a4;
+}
+
+static void impact_initvc3(struct fb_info *p)
+{
+	/* cursor-b-gone (disable DISPLAY bit) */
+	IMPACT_VC3_INDEXDATA(MMIO)=0x1d000100;
+}
+
+static void impact_initdma(struct fb_info *p)
+{
+	unsigned long pool;
+	/* clear DMA pools */
+	for(pool=0;pool<POOLS;pool++) {
+		impact_wait_cfifo_empty(p);
+		IMPACT_CFIFOPW(MMIO)=IMPACT_CMD_HQ_TXBASE(pool);
+		IMPACT_CFIFOP(MMIO)=0x0000000000000009;
+		IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_TXMAX(pool,0);
+		IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_PGBITS(pool,0);
+		IMPACT_CFIFOP(MMIO)=0x00484b0400080000|(pool<<41);
+		PAR.pool_txmax[pool]=0;
+		PAR.pool_txnum[pool]=0;
+	}
+	/* set DMA parameters */
+	IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_PGSIZE(0);
+	IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_STACKPTR(0);
+	IMPACT_CFIFOP(MMIO)=0x00484a0400180000;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_REG32(MMIO,X40918)=0x00680000;
+	IMPACT_REG32(MMIO,X40920)=0x80280000;
+	IMPACT_REG32(MMIO,X40928)=0x00000000;
+}
+
+static void impact_alloctxtbl(struct fb_info *p,int pool,int txmax)
+{
+	dma_addr_t dma_handle;
+	int alloc_size;
+	if(txmax>PAR.pool_txmax[pool]) { /* grow the pool - unlikely but supported */
+		alloc_size=txmax;
+		if(alloc_size<1024)
+			alloc_size=1024;
+		if(PAR.pool_txmax[pool])
+			dma_free_coherent(NULL,PAR.pool_txmax[pool]*4,
+				PAR.pool_txtbl[pool],PAR.pool_txphys[pool]);
+		PAR.pool_txtbl[pool]=
+			dma_alloc_coherent(NULL,alloc_size*4,&dma_handle,GFP_KERNEL);
+		PAR.pool_txphys[pool]=dma_handle;
+		PAR.pool_txmax[pool]=alloc_size;
+	}
+	PAR.pool_txnum[pool]=txmax;
+}
+
+static void impact_writetxtbl(struct fb_info *p,int pool)
+{
+	impact_wait_cfifo_empty(p);
+	/* inform the card about a new DMA pool */
+	IMPACT_CFIFOPW(MMIO)=IMPACT_CMD_HQ_TXBASE(pool);
+	IMPACT_CFIFOP(MMIO)=PAR.pool_txphys[pool];
+	IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_TXMAX(pool,PAR.pool_txnum[pool]);
+	IMPACT_CFIFOP(MMIO)=IMPACT_CMD_HQ_PGBITS(pool,0x0a);
+	IMPACT_CFIFOP(MMIO)=0x00484b0400180000|((long)pool<<41);
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+	IMPACT_CFIFOPW(MMIO)=0x000e0100;
+}
+
+static void impact_settxtbl(struct fb_info *p,int pool,unsigned *txtbl,int txmax)
+{
+	impact_alloctxtbl(p,pool,txmax);
+	#if defined(CONFIG_SGI_IP28)||defined(CONFIG_SGI_IP26)
+	{	void *ca = (typeof(p)) TO_CAC((unsigned long)PAR.pool_txtbl[pool]);
+		memcpy(ca,txtbl,txmax*4);
+		dma_cache_wback_inv((unsigned long)ca, txmax*4);
+	}
+	#else
+		memcpy(PAR.pool_txtbl[pool],txtbl,txmax*4);
+	#endif
+	impact_writetxtbl(p,pool);
+}
+
+static void impact_resizekpool(struct fb_info *p,int pool,int size,int growonly)
+{
+	typeof(PAR.pool_txtbl[pool]) txtbl;
+	int pages;
+	int i;
+	dma_addr_t dma_handle;
+	if(growonly && PAR.kpool_size[pool]>=size)
+		return;
+	if(size<8192)	/* single line smallcopy (1280*4) *must* work */
+		size=8192;
+	pages=(size+PAGE_SIZE-1)>>PAGE_SHIFT;
+	if(PAR.kpool_size[pool]>0) {
+		for(i=0;i<PAR.pool_txnum[pool];i++) {
+			unsigned long x=(typeof(x))PAR.kpool_virt[pool][i];
+			#if defined(CONFIG_DMA_NONCOHERENT)
+				/* Screw it, or this damned virt_to_page() will blow up the driver. */
+				x=(typeof(x))phys_to_virt(kernel_physaddr(x));
+			#endif
+			ClearPageReserved(virt_to_page(x));
+			dma_free_coherent(NULL,PAGE_SIZE,PAR.kpool_virt[pool][i],
+					PAR.kpool_phys[pool][i]);
+		}
+		vfree(PAR.kpool_phys[pool]);
+		vfree(PAR.kpool_virt[pool]);
+	}
+	impact_alloctxtbl(p,pool,pages);
+	txtbl = PAR.pool_txtbl[pool];
+	#if defined(CONFIG_SGI_IP28)||defined(CONFIG_SGI_IP26)
+		txtbl = (typeof(txtbl)) TO_CAC((unsigned long) txtbl);
+	#endif
+	PAR.kpool_virt[pool]=vmalloc(pages*sizeof(unsigned long));
+	PAR.kpool_phys[pool]=vmalloc(pages*sizeof(unsigned long));
+	for(i=0;i<PAR.pool_txnum[pool];i++) {
+		unsigned long x;
+		PAR.kpool_virt[pool][i]=
+			dma_alloc_coherent(NULL,PAGE_SIZE,&dma_handle,GFP_KERNEL);
+		x=(typeof(x))PAR.kpool_virt[pool][i];
+		#if defined(CONFIG_DMA_NONCOHERENT)
+			/* Screw it, or this damned virt_to_page() will blow up the driver. */
+			x=(typeof(x))phys_to_virt(kernel_physaddr(x));
+		#endif
+		SetPageReserved(virt_to_page(x));
+		PAR.kpool_phys[pool][i]=dma_handle;
+		txtbl[i]=dma_handle>>PAGE_SHIFT;
+	}
+	#if defined(CONFIG_SGI_IP28) || defined(CONFIG_SGI_IP26)
+		i=sizeof(*txtbl)*PAR.pool_txnum[pool];
+		dma_cache_wback_inv((unsigned long)txtbl, i);
+	#endif
+	impact_writetxtbl(p,pool);
+	PAR.kpool_size[pool]=pages*PAGE_SIZE;
+}
+
+static void
+impact_rect(struct fb_info *p, int x, int y, int w, int h, unsigned c, int lo)
+{
+	impact_wait_cfifo_empty(p);
+	if(lo==IMPACT_LO_COPY)
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x6300,lo);
+	else
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x6304,lo);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_FILLMODE(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PACKEDCOLOR(c);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYSTARTI(x,y);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYENDI(x+w-1,y+h-1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_IR_ALIAS(0x18);
+}
+
+static void
+impact_framerect(struct fb_info *p, int x, int y, int w, int h, unsigned c)
+{
+	impact_rect(p,x,y,w,1,c,IMPACT_LO_COPY);
+	impact_rect(p,x,y+h-1,w,1,c,IMPACT_LO_COPY);
+	impact_rect(p,x,y,1,h,c,IMPACT_LO_COPY);
+	impact_rect(p,x+w-1,y,1,h,c,IMPACT_LO_COPY);
+}
+
+static unsigned long dcntr;
+static void impact_debug(struct fb_info *p,int v)
+{
+	int i;
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PIXCMD(3);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PIXELFORMAT(0xe00);
+	switch(v) {
+	case 0:
+		for(i=0;i<64;i++)
+			impact_rect(p,4*(i&7),28-4*(i>>3),4,4,
+				(dcntr&(1L<<i))?0xa080ff:0x100030,IMPACT_LO_COPY);
+		break;
+	case 1:
+		dcntr++;
+		for(i=0;i<64;i++)
+			impact_rect(p,4*(i&7),28-4*(i>>3),4,4,
+				(dcntr&(1L<<i))?0xff80a0:0x300010,IMPACT_LO_COPY);
+		break;
+	case 2:
+		for(i=0;i<64;i++)
+			impact_rect(p,4*(i&7),28-4*(i>>3),4,4,
+				(dcntr&(1L<<i))?0xa0ff80:0x103000,IMPACT_LO_COPY);
+	}
+}
+
+static void impact_smallcopy(struct fb_info *p,unsigned sx,unsigned sy,
+				unsigned dx,unsigned dy,unsigned w,unsigned h)
+{
+	if(w<1 || h<1)
+		return;
+	w=(w+1)&~1;
+	/* setup and perform DMA from RE to HOST */
+	impact_wait_dma(p);
+#ifndef INDIGO2 /* Beware, only MaxImpact has 2 REs, SI,HI will hang ! */
+	if(sy&1)
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_CONFIG(0xca5);
+	else
+#endif
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_CONFIG(0xca4);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PIXCMD(2);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x2200,IMPACT_LO_COPY);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKLSBSA(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKLSBSB(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_COLORMASKMSBS(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_DRBPOINTERS(0xc8240);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYSTARTI(sx,sy+h-1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYENDI(sx+w-1,sy);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMASKLO(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMASKHI(0xffffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRSIZE(w,h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(w,h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMODE(0x00080);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_FILLMODE(0x01000000);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PIXELFORMAT(0x200);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_SCANWIDTH(w<<2);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_DMATYPE(0x0a);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_LIST_0(0x80000000);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_WIDTH(w<<2);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_OFFSET(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_STARTADDR(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_LINECNT(h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_WIDTHA(w<<2);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCONTROL(8);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_IR_ALIAS(0x18);
+	#if 0
+	IMPACT_CFIFOW(MMIO)=0x00080b04;
+	IMPACT_CFIFO(MMIO)=0x000000b900190204L;
+	IMPACT_CFIFOW(MMIO)=0x00000009;
+	#else
+	IMPACT_CFIFO(MMIO)=0x00080b04000000b9L;
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCONTROL(9);
+	#endif
+	impact_wait_dmaready(p);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_RE_TOGGLECNTX(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(0,0);
+	/* setup and perform DMA from HOST to RE */
+	impact_wait_dma(p);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_CONFIG(0xca4);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x6200,IMPACT_LO_COPY);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYSTARTI(dx,dy+h-1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYENDI(dx+w-1,dy);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_FILLMODE(0x01400000);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMODE(0x00080);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PIXELFORMAT(0x600);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_SCANWIDTH(w<<2);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_DMATYPE(0x0c);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PIXCMD(3);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRSIZE(w,h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(w,h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_IR_ALIAS(0x18);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCONTROL(1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_LIST_0(0x80000000);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_OFFSET(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_STARTADDR(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_LINECNT(h);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PG_WIDTHA(w<<2);
+	#if 0
+	IMPACT_CFIFOW(MMIO)=0x0080b04;
+	IMPACT_CFIFO(MMIO)=0x000000b1000e0400L;
+	#else
+	IMPACT_CFIFO(MMIO)=0x0080b04000000b1L;
+	IMPACT_CFIFOW(MMIO)=0x000e0400;
+	#endif
+	impact_wait_dma(p);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_RE_TOGGLECNTX(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(0,0);
+}
+
+static unsigned impact_getpalreg(struct fb_info *p, unsigned i)
+{
+	return ((unsigned *)p->pseudo_palette)[i];
+}
+
+/* ------------ Accelerated Functions --------------------- */
+
+static void impact_fillrect(struct fb_info *p, const struct fb_fillrect *region)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock,flags);
+	if(!PAR.open_flag)
+		switch(region->rop) {
+		case ROP_XOR:
+			impact_rect(p,region->dx,region->dy,region->width,region->height,
+				impact_getpalreg(p,region->color),IMPACT_LO_XOR);
+			break;
+		case ROP_COPY:
+		default:
+			impact_rect(p,region->dx,region->dy,region->width,region->height,
+				impact_getpalreg(p,region->color),IMPACT_LO_COPY);
+			break;
+		}
+	spin_unlock_irqrestore(&PAR.lock,flags);
+}
+
+static void impact_copyarea(struct fb_info *p, const struct fb_copyarea *area)
+{
+	unsigned sx,sy,dx,dy,w,h;
+	unsigned th,ah;
+	unsigned long flags;
+	w=area->width;
+	h=area->height;
+	if(w<1 || h<1)
+		return;
+	spin_lock_irqsave(&PAR.lock,flags);
+	if(PAR.open_flag) {
+		spin_unlock_irqrestore(&PAR.lock,flags);
+		return;
+	}
+	sx=area->sx;
+	sy=0x3ff-(area->sy+h-1);
+	dx=area->dx;
+	dy=0x3ff-(area->dy+h-1);
+	th=PAR.kpool_size[0]/(w*4);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XYWIN(0,0);
+	if(dy>sy) {
+		dy+=h;
+		sy+=h;
+		while(h>0) {
+			ah=th>h?h:th;
+			impact_smallcopy(p,sx,sy-ah,dx,dy-ah,w,ah);
+			dy-=ah;
+			sy-=ah;
+			h-=ah;
+		}
+	} else {
+		while(h>0) {
+			ah=th>h?h:th;
+			impact_smallcopy(p,sx,sy,dx,dy,w,ah);
+			dy+=ah;
+			sy+=ah;
+			h-=ah;
+		}
+	}
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PIXCMD(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_HQ_PIXELFORMAT(0xe00);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_CONFIG(0xcac);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XYWIN(0,0x3ff);
+	spin_unlock_irqrestore(&PAR.lock,flags);
+}
+
+/* 8-bpp blits are done as PIO draw operation; the pixels are unpacked into
+   32-bpp values from the current palette in software */
+static void
+impact_imageblit_8bpp(struct fb_info *p, const struct fb_image *image)
+{
+	int i,u,v;
+	const unsigned char *dp;
+	unsigned pix;
+	unsigned pal[256];
+	/* setup PIO to RE */
+	impact_wait_cfifo_empty(p);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x6300,IMPACT_LO_COPY);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYSTARTI(image->dx,image->dy);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYENDI(image->dx+image->width-1,
+						image->dy+image->height-1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_FILLMODE(0x00c00000);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRMODE(0x00080);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRSIZE(image->width,image->height);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(image->width,image->height);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(1);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_IR_ALIAS(0x18);
+	/* another workaround.. 33 writes to alpha... hmm... */
+	for(i=0;i<33;i++)
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_ALPHA(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCONTROL(2);
+	/* pairs of pixels are sent in two writes to the RE */
+	i=0;
+	dp=image->data;
+	for(v=0;v<256;v++)
+		pal[v]=impact_getpalreg(p,v);
+	for(v=0;v<image->height;v++) {
+		for(u=0;u<image->width;u++) {
+			pix=pal[*(dp++)];
+			if(i)
+				IMPACT_CFIFO(MMIO)=IMPACT_CMD_CHAR_L(pix);
+			else
+				IMPACT_CFIFO(MMIO)=IMPACT_CMD_CHAR_H(pix);
+			i^=1;
+		}
+	}
+	if(i)
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_CHAR_L(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_GLINE_XSTARTF(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_RE_TOGGLECNTX(0);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_XFRCOUNTERS(0,0);
+}
+
+/* 1-bpp blits are done as character drawing; the bitmaps are drawn as 8-bit wide
+   strips; technically, Impact supports 16-pixel wide characters, but Linux bitmap
+   alignment is 8 bits and most draws are 8 pixels wide (font width), anyway */
+static void impact_imageblit_1bpp(struct fb_info *p, const struct fb_image *image)
+{
+	int x,y,w,h,b;
+	int u,v,a;
+	const unsigned char *d;
+	impact_wait_cfifo_empty(p);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PP1FILLMODE(0x6300,IMPACT_LO_COPY);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_FILLMODE(0x400018);
+	a=impact_getpalreg(p,image->fg_color);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_PACKEDCOLOR(a);
+	a=impact_getpalreg(p,image->bg_color);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BKGRD_RG(a&0xffff);
+	IMPACT_CFIFO(MMIO)=IMPACT_CMD_BKGRD_BA((a&0xff0000)>>16);
+	x=image->dx;
+	y=image->dy;
+	w=image->width;
+	h=image->height;
+	b=(w+7)/8;
+	for(u=0;u<b;u++) {
+		impact_wait_cfifo_empty(p);
+		a=(w<8)?w:8;
+		d=image->data+u;
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYSTARTI(x,y);
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_BLOCKXYENDI(x+a-1,y+h-1);
+		IMPACT_CFIFO(MMIO)=IMPACT_CMD_IR_ALIAS(0x18);
+		for(v=0;v<h;v++) {
+			IMPACT_CFIFO(MMIO)=IMPACT_CMD_CHAR((*d)<<24);
+			d+=b;
+		}
+		w-=a;
+		x+=a;
+	}
+}
+
+static void impact_imageblit(struct fb_info *p, const struct fb_image *image)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock,flags);
+	if(!PAR.open_flag)
+		switch(image->depth) {
+		case 1:
+			impact_imageblit_1bpp(p,image);
+			break;
+		case 8:
+			impact_imageblit_8bpp(p,image);
+			break;
+		}
+	spin_unlock_irqrestore(&PAR.lock,flags);
+}
+
+static int impact_sync(struct fb_info *info)
+{
+	return 0;
+}
+
+static int impact_blank(int blank_mode, struct fb_info *info)
+{
+	/* TODO */
+	return 0;
+}
+
+static int impact_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp, struct fb_info *info)
+{
+	if(regno>255)
+		return 1;
+	((unsigned *)info->pseudo_palette)[regno]=
+		(red>>8)|(green&0xff00)|((blue<<8)&0xff0000);
+	return 0;
+}
+
+/* ------------------- Framebuffer Access -------------------- */
+
+ssize_t impact_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+ssize_t
+impact_write(struct file *file, const char *buf, size_t count, loff_t *ppos)
+{
+	return -EINVAL;
+}
+
+/* --------------------- Userland Access --------------------- */
+
+int impact_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+			unsigned long arg, struct fb_info *info)
+{
+	return -EINVAL;
+}
+
+int
+impact_mmap(struct fb_info *p, struct file *file, struct vm_area_struct *vma)
+{
+	unsigned pool, i, n;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long start = vma->vm_start;
+
+#ifdef INDIGO2
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+		return -EINVAL;
+	if (offset + size > 0x400000)
+		return -EINVAL;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_flags |= VM_IO;
+	if (remap_pfn_range(vma, vma->vm_start, (offset+MMIO)>>PAGE_SHIFT,
+				size, vma->vm_page_prot))
+			return -EAGAIN;
+	vma->vm_file = file;
+	PAR.mmap_flag = 1;
+#else
+	switch(offset) {
+	case 0x0000000:
+	default:
+		if (offset+size>0x200000) /* >0x400000, >0x1000000 ? */
+			return -EINVAL;
+		if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
+			return -EINVAL;
+		offset += MMIO;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		vma->vm_flags |= VM_IO;
+		if (remap_pfn_range(vma, vma->vm_start, offset>>PAGE_SHIFT,
+				size, vma->vm_page_prot))
+			return -EAGAIN;
+		vma->vm_file = file;
+		PAR.mmap_flag = 1;
+		break;
+	case 0x1000000:
+	case 0x2000000:
+	case 0x3000000:
+	case 0x8000000:
+	case 0x9000000:
+	case 0xa000000:
+	case 0xb000000:
+		if(size>0x1000000)
+			return EINVAL;
+		pool=(offset>>24)&7;
+		if (pool>=POOLS)
+			return -EINVAL;
+		impact_resizekpool(&info,pool,size,offset&0x8000000);
+		n=(size+PAGE_SIZE-1)>>PAGE_SHIFT;
+		for(i=0;i<n;i++) {
+			if (remap_pfn_range(vma, start,
+				PAR.kpool_phys[pool][i]>>PAGE_SHIFT, PAGE_SIZE,
+				vma->vm_page_prot))
+				return -EAGAIN;
+			start += PAGE_SIZE;
+		}
+		vma->vm_file = file;
+		PAR.mmap_flag = 1;
+	}
+#endif
+	return 0;
+}
+
+static int impact_open(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock,flags);
+	if (user)
+		PAR.open_flag++;
+	spin_unlock_irqrestore(&PAR.lock,flags);
+	return 0;
+}
+
+static int impact_release(struct fb_info *p, int user)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&PAR.lock,flags);
+	if (user && PAR.open_flag) {
+		PAR.open_flag--;
+		if (PAR.open_flag == 0) {
+			impact_resizekpool(&info,1,8192,0);
+			impact_resizekpool(&info,2,8192,0);
+			impact_resizekpool(&info,3,8192,0);
+			PAR.mmap_flag = 0;
+		}
+	}
+	spin_unlock_irqrestore(&PAR.lock,flags);
+	return 0;
+}
+
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Frame buffer operations
+     */
+
+static struct fb_ops impact_ops = {
+	.owner		= THIS_MODULE,
+	.fb_read	= impact_read,
+	.fb_write	= impact_write,
+	.fb_blank	= impact_blank,
+	.fb_fillrect	= impact_fillrect,
+	.fb_copyarea	= impact_copyarea,
+	.fb_imageblit	= impact_imageblit,
+	.fb_cursor	= soft_cursor,
+	.fb_sync	= impact_sync,
+	.fb_ioctl	= impact_ioctl,
+	.fb_setcolreg	= impact_setcolreg,
+	.fb_mmap	= impact_mmap,
+	.fb_open	= impact_open,
+	.fb_release	= impact_release,
+};
+
+/* ------------------------------------------------------------------------- */
+
+    /*
+     *  Initialization
+     */
+
+static inline unsigned long gfxphysaddr(void)
+{
+#ifdef INDIGO2
+	extern unsigned long sgi_gfxaddr;	/* provided by ARCS */
+	return sgi_gfxaddr;
+#else
+	return 0x1c000000;	/* first card in Octane */
+#endif
+}
+
+static void __init impact_hwinit(void)
+{
+	/* initialize hardware */
+	impact_inithq(&info);
+	impact_initvc3(&info);
+	impact_initrss(&info);
+	impact_initxmap(&info);
+	impact_initdma(&info);
+}
+
+static int __init impact_devinit(void)
+{
+	int i;
+	current_par.open_flag = 0;
+	current_par.mmap_flag = 0;
+	current_par.lock = SPIN_LOCK_UNLOCKED;
+
+	current_par.mmio_base = gfxphysaddr();
+	if (!current_par.mmio_base) {
+		printk(KERN_INFO "impact_devinit: !gfxaddr\n");
+		return -EINVAL;
+	}
+	current_par.mmio_virt = (unsigned long)
+		ioremap(current_par.mmio_base,0x200000);
+	impact_fix.mmio_start = current_par.mmio_base;
+	impact_fix.mmio_len = 0x200000;
+
+	info.flags = FBINFO_FLAG_DEFAULT;
+	info.screen_base = NULL;
+	info.fbops = &impact_ops;
+	info.fix = impact_fix;
+	info.var = impact_var;
+	info.par = &current_par;
+	info.pseudo_palette = pseudo_palette;
+
+	impact_hwinit();
+	/* initialize buffers */
+	impact_resizekpool(&info,0,65536,0);
+	for (i = 1; i < POOLS; ++i)
+		impact_resizekpool(&info,i,8192,0);
+
+	/* This has to been done !!! */
+	fb_alloc_cmap(&info.cmap, 256, 0);
+
+	if (register_framebuffer(&info) < 0)
+		return -EINVAL;
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
+		info.fix.id);
+	return 0;
+}
+
+static int __init impact_probe(struct device *dev)
+{
+	return impact_devinit();
+}
+
+static struct device_driver impact_driver = {
+	.name = "impact",
+	.bus = &platform_bus_type,
+	.probe = impact_probe,
+	/* add remove someday */
+};
+
+static struct platform_device impact_device = {
+	.name = "impact",
+};
+
+int __init impact_init(void)
+{
+	int ret = driver_register(&impact_driver);
+	if (!ret) {
+		ret = platform_device_register(&impact_device);
+		if (ret)
+			driver_unregister(&impact_driver);
+	}
+	return ret;
+}
+
+void __exit impact_exit(void)
+{
+	 driver_unregister(&impact_driver);
+}
+
+module_init(impact_init);
+module_exit(impact_exit);
+
+MODULE_LICENSE("GPL");
diff -Nur linux-git/drivers/video/Kconfig linux-git-mit-R10k-patches/drivers/video/Kconfig
--- linux-git/drivers/video/Kconfig	2005-10-15 16:01:25.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/video/Kconfig	2005-10-16 13:22:04.000000000 +0200
@@ -568,6 +568,14 @@
 	  This is the amount of memory reserved for the framebuffer,
 	  which can be any value between 1MB and 8MB.
 
+config FB_IMPACT
+	tristate "SGI Octane ImpactSR / Indigo2 Impact graphics support"
+	depends on FB && (SGI_IP22 || SGI_IP26 || SGI_IP28 || SGI_IP30)
+	select FB_SOFT_CURSOR
+	help
+	  SGI Octane ImpactSR (SI/SSI/MXI/SE/SSE/MXE) graphics card support.
+	  SGI Indigo2 Impact (SI/HI/MI) graphics card support.
+
 config BUS_I2C
 	bool
 	depends on (FB = y) && VISWS
@@ -1609,3 +1617,5 @@
 
 endmenu
 
+
+# Revision 1.36, Tue Apr 19 20:56:41 2005
diff -Nur linux-git/drivers/video/logo/Kconfig linux-git-mit-R10k-patches/drivers/video/logo/Kconfig
--- linux-git/drivers/video/logo/Kconfig	2005-10-15 16:01:26.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/video/logo/Kconfig	2005-10-16 13:22:04.000000000 +0200
@@ -40,7 +40,7 @@
 
 config LOGO_SGI_CLUT224
 	bool "224-color SGI Linux logo"
-	depends on LOGO && (SGI_IP22 || SGI_IP27 || SGI_IP32 || X86_VISWS)
+	depends on LOGO && (SGI_IP22 || SGI_IP27 || SGI_IP28 || SGI_IP32 || X86_VISWS)
 	default y
 
 config LOGO_SUN_CLUT224
diff -Nur linux-git/drivers/video/Makefile linux-git-mit-R10k-patches/drivers/video/Makefile
--- linux-git/drivers/video/Makefile	2005-10-15 16:01:25.000000000 +0200
+++ linux-git-mit-R10k-patches/drivers/video/Makefile	2005-10-16 13:45:33.000000000 +0200
@@ -94,6 +94,7 @@
 obj-$(CONFIG_FB_MAXINE)		  += maxinefb.o
 obj-$(CONFIG_FB_TX3912)		  += tx3912fb.o
 obj-$(CONFIG_FB_S1D13XXX)	  += s1d13xxxfb.o
+obj-$(CONFIG_FB_IMPACT)		  += impact.o
 obj-$(CONFIG_FB_IMX)              += imxfb.o
 obj-$(CONFIG_FB_SMIVGX)		  += smivgxfb.o
 obj-$(CONFIG_FB_S3C2410)	  += s3c2410fb.o
@@ -105,3 +106,5 @@
 
 # the test framebuffer is last
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
+
+# Revision 1.89, Tue Apr 19 20:56:41 2005
diff -Nur linux-git/fs/partitions/Kconfig linux-git-mit-R10k-patches/fs/partitions/Kconfig
--- linux-git/fs/partitions/Kconfig	2005-10-15 16:01:30.000000000 +0200
+++ linux-git-mit-R10k-patches/fs/partitions/Kconfig	2005-10-16 13:22:04.000000000 +0200
@@ -188,7 +188,7 @@
 
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
-	default y if (SGI_IP22 || SGI_IP27 || ((MACH_JAZZ || SNI_RM200_PCI) && !CPU_LITTLE_ENDIAN))
+	default y if (SGI_IP22 || SGI_IP27 || SGI_IP28 || ((MACH_JAZZ || SNI_RM200_PCI) && !CPU_LITTLE_ENDIAN))
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by SGI machines.
diff -Nur linux-git/include/asm-mips/addrspace.h linux-git-mit-R10k-patches/include/asm-mips/addrspace.h
--- linux-git/include/asm-mips/addrspace.h	2005-10-15 16:01:33.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/addrspace.h	2005-10-16 13:58:45.000000000 +0200
@@ -53,6 +53,16 @@
 
 #ifdef CONFIG_64BIT
 
+static inline unsigned long kernel_physaddr(unsigned long kva)
+{
+	if((kva&0xffffffff80000000UL)==0xffffffff80000000UL)
+		return CPHYSADDR(kva);
+	return XPHYSADDR(kva);
+}
+#else
+#define kernel_physaddr CPHYSADDR
+#endif
+
 /*
  * Memory segments (64bit kernel mode addresses)
  * The compatibility segments use the full 64-bit sign extended value.  Note
@@ -108,14 +118,14 @@
 /*
  * Cache modes for XKPHYS address conversion macros
  */
-#define K_CALG_COH_EXCL1_NOL2	0
-#define K_CALG_COH_SHRL1_NOL2	1
-#define K_CALG_UNCACHED		2
-#define K_CALG_NONCOHERENT	3
-#define K_CALG_COH_EXCL		4
-#define K_CALG_COH_SHAREABLE	5
-#define K_CALG_NOTUSED		6
-#define K_CALG_UNCACHED_ACCEL	7
+#define K_CALG_COH_EXCL1_NOL2	0L
+#define K_CALG_COH_SHRL1_NOL2	1L
+#define K_CALG_UNCACHED		2L
+#define K_CALG_NONCOHERENT	3L
+#define K_CALG_COH_EXCL		4L
+#define K_CALG_COH_SHAREABLE	5L
+#define K_CALG_NOTUSED		6L
+#define K_CALG_UNCACHED_ACCEL	7L
 
 /*
  * 64-bit address conversions
@@ -199,3 +209,7 @@
 #define PHYS_TO_K0(x)		(_ACAST64_ (x) | CAC_BASE)
 
 #endif /* _ASM_ADDRSPACE_H */
+/*
+ * Revision 1.15, Mon Dec 27 03:16:18 2004
+ * Jun/Dec 2004
+ */
diff -Nur linux-git/include/asm-mips/dma.h linux-git-mit-R10k-patches/include/asm-mips/dma.h
--- linux-git/include/asm-mips/dma.h	2005-10-15 16:01:33.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/dma.h	2005-10-16 13:22:04.000000000 +0200
@@ -83,10 +83,13 @@
  * Deskstations or Acer PICA but not the much more versatile DMA logic used
  * for the local devices on Acer PICA or Magnums.
  */
-#ifdef CONFIG_SGI_IP22
+#if defined(CONFIG_SGI_IP22)
 /* Horrible hack to have a correct DMA window on IP22 */
 #include <asm/sgi/mc.h>
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
+#elif defined(CONFIG_SGI_IP28)
+#include <asm/sgi/mc.h>
+#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG1_BADDR + 0x01000000)
 #else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
@@ -311,3 +314,7 @@
 #endif
 
 #endif /* _ASM_DMA_H */
+/*
+ * Revision 1.14, Tue Jul 29 03:21:47 2003
+ * Sun Jun 13 01:04:27 2004	- IP28
+ */
diff -Nur linux-git/include/asm-mips/io.h linux-git-mit-R10k-patches/include/asm-mips/io.h
--- linux-git/include/asm-mips/io.h	2005-10-15 16:01:33.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/io.h	2005-10-16 13:22:04.000000000 +0200
@@ -63,7 +63,7 @@
 
 # define ioswabb(x)		(x)
 # define mem_ioswabb(x)		(x)
-# ifdef CONFIG_SGI_IP22
+# if defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP28)
 /*
  * IP22 seems braindead enough to swap 16bits values in hardware, but
  * not 32bits.  Go figure... Can't tell without documentation.
diff -Nur linux-git/include/asm-mips/mach-ip28/cpu-feature-overrides.h linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/cpu-feature-overrides.h
--- linux-git/include/asm-mips/mach-ip28/cpu-feature-overrides.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/cpu-feature-overrides.h	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,41 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Ralf Baechle
+ * 6/2004	pf
+ */
+#ifndef __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
+#define __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H
+
+/*
+ * IP28 only comes with R10000 family processors all using the same config
+ */
+#define cpu_has_watch		1
+#define cpu_has_mips16		0
+#define cpu_has_divec		0
+#define cpu_has_vce		0
+#define cpu_has_cache_cdex_p	0
+#define cpu_has_cache_cdex_s	0
+#define cpu_has_prefetch	1
+#define cpu_has_mcheck		0
+#define cpu_has_ejtag		0
+
+#define cpu_has_llsc		1
+#define cpu_has_vtag_icache	0
+#define cpu_has_dc_aliases	0 /* see probe_pcache() */
+#define cpu_has_ic_fills_f_dc	0
+
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		1
+
+#define cpu_has_subset_pcaches	1
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	64
+/* we better read it from COP0 $16 (SCBlkSize bit), can be 128 or 64
+#define cpu_scache_line_size()	128
+*/
+
+#endif /* __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H */
diff -Nur linux-git/include/asm-mips/mach-ip28/ds1286.h linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/ds1286.h
--- linux-git/include/asm-mips/mach-ip28/ds1286.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/ds1286.h	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_IP28_DS1286_H
+#define __ASM_MACH_IP28_DS1286_H
+#include <asm/mach-ip22/ds1286.h>
+#endif /* __ASM_MACH_IP28_DS1286_H */
diff -Nur linux-git/include/asm-mips/mach-ip28/spaces.h linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/spaces.h
--- linux-git/include/asm-mips/mach-ip28/spaces.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/include/asm-mips/mach-ip28/spaces.h	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,29 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994 - 1999, 2000, 03, 04 Ralf Baechle
+ * Copyright (C) 2000, 2002  Maciej W. Rozycki
+ * Copyright (C) 1990, 1999, 2000 Silicon Graphics, Inc.
+ * 2004	pf
+ */
+#ifndef _ASM_MACH_IP28_SPACES_H
+#define _ASM_MACH_IP28_SPACES_H
+
+#include <linux/config.h>
+
+#define CAC_BASE		0xa800000000000000
+#define IO_BASE			0x9000000000000000
+#define UNCAC_BASE		0x9000000000000000
+#define MAP_BASE		0xc000000000000000
+
+#define TO_PHYS(x)		(             ((x) & TO_PHYS_MASK))
+#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+
+#define PAGE_OFFSET		CAC_BASE
+
+#define HIGHMEM_START		(~0UL)
+
+#endif /* _ASM_MACH_IP28_SPACES_H */
diff -Nur linux-git/include/asm-mips/sgi/ioc.h linux-git-mit-R10k-patches/include/asm-mips/sgi/ioc.h
--- linux-git/include/asm-mips/sgi/ioc.h	2005-10-15 16:01:34.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/sgi/ioc.h	2005-10-16 13:48:36.000000000 +0200
@@ -138,8 +138,8 @@
 	u8 _sysid[3];
 	volatile u8 sysid;
 #define SGIOC_SYSID_FULLHOUSE	0x01
-#define SGIOC_SYSID_BOARDREV(x)	((x & 0xe0) > 5)
-#define SGIOC_SYSID_CHIPREV(x)	((x & 0x1e) > 1)
+#define SGIOC_SYSID_BOARDREV(x)	(((x) & 0x1e) >> 1)
+#define SGIOC_SYSID_CHIPREV(x)	(((x) & 0xe0) >> 5)
 	u32 _unused2;
 	u8 _read[3];
 	volatile u8 read;
@@ -198,3 +198,7 @@
 extern struct sgint_regs *sgint;
 
 #endif
+/*
+ * Revision 1.8, Sat Sep 25 14:20:00 2004
+ * May 2004	pf	- SYSID
+ */
diff -Nur linux-git/include/asm-mips/sgi/mc.h linux-git-mit-R10k-patches/include/asm-mips/sgi/mc.h
--- linux-git/include/asm-mips/sgi/mc.h	2005-10-15 16:01:34.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/sgi/mc.h	2005-10-16 13:22:04.000000000 +0200
@@ -227,5 +227,11 @@
 #define SGIMC_SEG1_SIZE_IP26_IP28	0x20000000 /* 512MB */
 
 extern void sgimc_init(void);
+extern unsigned long ip2628_enable_ucmem(void);
+extern void ip2628_return_ucmem(unsigned long);
 
 #endif /* _SGI_MC_H */
+/*
+ * Revision 1.4, Mon Jun 16 13:54:54 2003
+ * Wed Jun 16 13:54:54 2004 pf	- IP28
+ */
diff -Nur linux-git/include/asm-mips/stackframe.h linux-git-mit-R10k-patches/include/asm-mips/stackframe.h
--- linux-git/include/asm-mips/stackframe.h	2005-10-15 16:01:34.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/stackframe.h	2005-10-16 13:22:04.000000000 +0200
@@ -351,3 +351,7 @@
 		.endm
 
 #endif /* _ASM_STACKFRAME_H */
+/*
+ * Revision 1.37, Tue Apr 19 21:26:28 2005
+ * May 2004	pf	- xkphys kernel addresses
+ */
Binärdateien linux-git/include/asm-mips/.stackframe.h.rej.swp and linux-git-mit-R10k-patches/include/asm-mips/.stackframe.h.rej.swp sind verschieden.
diff -Nur linux-git/include/asm-mips/war.h linux-git-mit-R10k-patches/include/asm-mips/war.h
--- linux-git/include/asm-mips/war.h	2005-10-15 16:01:34.000000000 +0200
+++ linux-git-mit-R10k-patches/include/asm-mips/war.h	2005-10-16 13:22:04.000000000 +0200
@@ -194,6 +194,10 @@
 #ifdef CONFIG_SGI_IP27
 #define R10000_LLSC_WAR 1
 #endif
+/* Branch-likely and friends won't hurt a weird uniprocessor system either */
+#ifdef CONFIG_SGI_IP28
+#define R10000_LLSC_WAR 1
+#endif
 
 /*
  * Workarounds default to off
@@ -236,3 +240,7 @@
 #endif
 
 #endif /* _ASM_WAR_H */
+/*
+ * Revision 1.19, Tue Aug 17 17:49:44 2004
+ * Sun Dec  5 23:28:19 2004	- ip28 cache barrier
+ */
diff -Nur linux-git/include/linux/fb.h linux-git-mit-R10k-patches/include/linux/fb.h
--- linux-git/include/linux/fb.h	2005-10-15 16:01:35.000000000 +0200
+++ linux-git-mit-R10k-patches/include/linux/fb.h	2005-10-16 13:22:04.000000000 +0200
@@ -118,6 +118,7 @@
 #define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+#define FB_ACCEL_SGI_IMPACT     333	/* SGI IMPACT graphics          */
 
 #define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
 #define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
@@ -948,3 +949,6 @@
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_FB_H */
+/*
+ * Revision 1.55, Tue Apr 19 21:33:27 2005
+ */
diff -Nur linux-git/include/video/impact.h linux-git-mit-R10k-patches/include/video/impact.h
--- linux-git/include/video/impact.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git-mit-R10k-patches/include/video/impact.h	2005-10-16 13:22:04.000000000 +0200
@@ -0,0 +1,181 @@
+/*
+ *  linux/drivers/video/impactsr.h -- SGI Octane MardiGras (IMPACTSR) graphics
+ *  linux/include/video/impact.h   -- SGI Indigo2 MardiGras (IMPACT) graphics
+ *
+ *  Copyright (c) 2004 by Stanislaw Skowronek
+ *  Hacked for Indigo2 by pf, 2005
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef IMPACT_H
+#define IMPACT_H
+
+/* Convenient access macros */
+#define IMPACT_REG64(vma,off)		(*(volatile unsigned long *)((vma)+(off)))
+#define IMPACT_REG32(vma,off)		(*(volatile unsigned int *)((vma)+(off)))
+#define IMPACT_REG16(vma,off)		(*(volatile unsigned short *)((vma)+(off)))
+#define IMPACT_REG8(vma,off)		(*(volatile unsigned char *)((vma)+(off)))
+
+#if defined(CONFIG_SGI_IP28)||defined(CONFIG_SGI_IP26)||defined(CONFIG_SGI_IP22)
+/* Impact (HQ3) register offsets */
+
+#define IMPACT_CFIFO(vma)		IMPACT_REG64(vma,0x70080)
+#define IMPACT_CFIFOW(vma)		IMPACT_REG32(vma,0x70080)
+#define IMPACT_CFIFOP(vma)		IMPACT_REG64(vma,0x50080)
+#define IMPACT_CFIFOPW(vma)		IMPACT_REG32(vma,0x50080)
+
+#define IMPACT_STATUS(vma)		IMPACT_REG32(vma,0x70000)
+#define IMPACT_FIFOSTATUS(vma)	IMPACT_REG32(vma,0x70004)
+#define IMPACT_GIOSTATUS(vma)		IMPACT_REG32(vma,0x70100)
+#define IMPACT_DMABUSY(vma)		IMPACT_REG32(vma,0x70104)
+
+#define IMPACT_CFIFO_HW(vma)		IMPACT_REG32(vma,0x50020)
+#define IMPACT_CFIFO_LW(vma)		IMPACT_REG32(vma,0x50024)
+#define IMPACT_CFIFO_DELAY(vma)	IMPACT_REG32(vma,0x50028)
+#define IMPACT_DFIFO_HW(vma)		IMPACT_REG32(vma,0x5002c)
+#define IMPACT_DFIFO_LW(vma)		IMPACT_REG32(vma,0x50030)
+#define IMPACT_DFIFO_DELAY(vma)	IMPACT_REG32(vma,0x50034)
+
+#define X40918	0x50918
+#define X40920	0x50920
+#define X40928	0x50928
+#define IMPACT_XMAP_OFF(off)	(0x61c00+(off))
+#define IMPACT_VC3_OFF(off)	(0x62000+(off))
+#define IMPACT_RSS_OFF(off)	(0x7c000+(off))
+
+#else /* ImpactSR (HQ4) register offsets */
+
+#define IMPACT_CFIFO(vma)		IMPACT_REG64(vma,0x20400)
+#define IMPACT_CFIFOW(vma)		IMPACT_REG32(vma,0x20400)
+#define IMPACT_CFIFOP(vma)		IMPACT_REG64(vma,0x130400)
+#define IMPACT_CFIFOPW(vma)		IMPACT_REG32(vma,0x130400)
+
+#define IMPACT_STATUS(vma)		IMPACT_REG32(vma,0x20000)
+#define IMPACT_FIFOSTATUS(vma)	IMPACT_REG32(vma,0x20008)
+#define IMPACT_GIOSTATUS(vma)		IMPACT_REG32(vma,0x20100)
+#define IMPACT_DMABUSY(vma)		IMPACT_REG32(vma,0x20200)
+
+#define IMPACT_CFIFO_HW(vma)		IMPACT_REG32(vma,0x40000)
+#define IMPACT_CFIFO_LW(vma)		IMPACT_REG32(vma,0x40008)
+#define IMPACT_CFIFO_DELAY(vma)	IMPACT_REG32(vma,0x40010)
+#define IMPACT_DFIFO_HW(vma)		IMPACT_REG32(vma,0x40020)
+#define IMPACT_DFIFO_LW(vma)		IMPACT_REG32(vma,0x40028)
+#define IMPACT_DFIFO_DELAY(vma)	IMPACT_REG32(vma,0x40030)
+
+#define X40918	0x40918
+#define X40920	0x40920
+#define X40928	0x40928
+#define IMPACT_XMAP_OFF(off)	(0x71c00+(off))
+#define IMPACT_VC3_OFF(off)	(0x72000+(off))
+#define IMPACT_RSS_OFF(off)	(0x2c000+(off))
+
+#endif
+
+#define IMPACT_RESTATUS(vma)		IMPACT_REG32(vma,IMPACT_RSS_OFF(0x578))
+
+#define IMPACT_XMAP_PP1SELECT(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x008))
+#define IMPACT_XMAP_INDEX(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x088))
+#define IMPACT_XMAP_CONFIG(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x100))
+#define IMPACT_XMAP_CONFIGB(vma)	IMPACT_REG8(vma,IMPACT_XMAP_OFF(0x108))
+#define IMPACT_XMAP_BUF_SELECT(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x180))
+#define IMPACT_XMAP_MAIN_MODE(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x200))
+#define IMPACT_XMAP_OVERLAY_MODE(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x280))
+#define IMPACT_XMAP_DIB(vma)		IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x300))
+#define IMPACT_XMAP_DIB_DW(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x340))
+#define IMPACT_XMAP_RE_RAC(vma)	IMPACT_REG32(vma,IMPACT_XMAP_OFF(0x380))
+
+#define IMPACT_VC3_INDEX(vma)		IMPACT_REG8(vma,IMPACT_VC3_OFF(0x008))
+#define IMPACT_VC3_INDEXDATA(vma)	IMPACT_REG32(vma,IMPACT_VC3_OFF(0x038))
+#define IMPACT_VC3_DATA(vma)		IMPACT_REG16(vma,IMPACT_VC3_OFF(0x0b0))
+#define IMPACT_VC3_RAM(vma)		IMPACT_REG16(vma,IMPACT_VC3_OFF(0x190))
+
+/* FIFO status */
+#if defined(CONFIG_SGI_IP28)||defined(CONFIG_SGI_IP26)||defined(CONFIG_SGI_IP22)
+#define IMPACT_CFIFO_MAX		64
+#else
+#define IMPACT_CFIFO_MAX		128
+#endif
+#define IMPACT_BFIFO_MAX		16
+
+/* Commands for CFIFO */
+#define IMPACT_CMD_WRITERSS(reg,val)\
+	(((0x00180004L|((reg)<<8))<<32)|(unsigned)(val))
+#define IMPACT_CMD_EXECRSS(reg,val)\
+	(((0x001c0004L|((reg)<<8))<<32)|(unsigned)(val))
+
+#define IMPACT_CMD_GLINE_XSTARTF(v)	IMPACT_CMD_WRITERSS(0x00c,v)
+#define IMPACT_CMD_IR_ALIAS(v)	IMPACT_CMD_EXECRSS(0x045,v)
+#define IMPACT_CMD_BLOCKXYSTARTI(x,y)	IMPACT_CMD_WRITERSS(0x046,((x)<<16)|(y))
+#define IMPACT_CMD_BLOCKXYENDI(x,y)	IMPACT_CMD_WRITERSS(0x047,((x)<<16)|(y))
+#define IMPACT_CMD_PACKEDCOLOR(v)	IMPACT_CMD_WRITERSS(0x05b,v)
+#define IMPACT_CMD_RED(v)		IMPACT_CMD_WRITERSS(0x05c,v)
+#define IMPACT_CMD_ALPHA(v)		IMPACT_CMD_WRITERSS(0x05f,v)
+#define IMPACT_CMD_CHAR(v)		IMPACT_CMD_EXECRSS(0x070,v)
+#define IMPACT_CMD_CHAR_H(v)		IMPACT_CMD_WRITERSS(0x070,v)
+#define IMPACT_CMD_CHAR_L(v)		IMPACT_CMD_EXECRSS(0x071,v)
+#define IMPACT_CMD_XFRCONTROL(v)	IMPACT_CMD_WRITERSS(0x102,v)
+#define IMPACT_CMD_FILLMODE(v)	IMPACT_CMD_WRITERSS(0x110,v)
+#define IMPACT_CMD_CONFIG(v)		IMPACT_CMD_WRITERSS(0x112,v)
+#define IMPACT_CMD_XYWIN(x,y)		IMPACT_CMD_WRITERSS(0x115,((y)<<16)|(x))
+#define IMPACT_CMD_BKGRD_RG(v)	IMPACT_CMD_WRITERSS(0x140,((v)<<8))
+#define IMPACT_CMD_BKGRD_BA(v)	IMPACT_CMD_WRITERSS(0x141,((v)<<8))
+#define IMPACT_CMD_WINMODE(v)		IMPACT_CMD_WRITERSS(0x14f,v)
+#define IMPACT_CMD_XFRSIZE(x,y)	IMPACT_CMD_WRITERSS(0x153,((y)<<16)|(x))
+#define IMPACT_CMD_XFRMASKLO(v)	IMPACT_CMD_WRITERSS(0x156,v)
+#define IMPACT_CMD_XFRMASKHI(v)	IMPACT_CMD_WRITERSS(0x157,v)
+#define IMPACT_CMD_XFRCOUNTERS(x,y)	IMPACT_CMD_WRITERSS(0x158,((y)<<16)|(x))
+#define IMPACT_CMD_XFRMODE(v)		IMPACT_CMD_WRITERSS(0x159,v)
+#define IMPACT_CMD_RE_TOGGLECNTX(v)	IMPACT_CMD_WRITERSS(0x15f,v)
+#define IMPACT_CMD_PIXCMD(v)		IMPACT_CMD_WRITERSS(0x160,v)
+#define IMPACT_CMD_PP1FILLMODE(m,o)	IMPACT_CMD_WRITERSS(0x161,(m)|(o<<26))
+#define IMPACT_CMD_COLORMASKMSBS(v)	IMPACT_CMD_WRITERSS(0x162,v)
+#define IMPACT_CMD_COLORMASKLSBSA(v)	IMPACT_CMD_WRITERSS(0x163,v)
+#define IMPACT_CMD_COLORMASKLSBSB(v)	IMPACT_CMD_WRITERSS(0x164,v)
+#define IMPACT_CMD_BLENDFACTOR(v)	IMPACT_CMD_WRITERSS(0x165,v)
+#define IMPACT_CMD_DRBPOINTERS(v)	IMPACT_CMD_WRITERSS(0x16d,v)
+
+#define	IMPACT_CMD_HQ_PIXELFORMAT(v)	(0x000c000400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_SCANWIDTH(v)	(0x000a020400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_DMATYPE(v)	(0x000a060400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_LIST_0(v)	(0x0008000400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_WIDTH(v)	(0x0008040400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_OFFSET(v)	(0x0008050400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_STARTADDR(v)	(0x0008060400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_LINECNT(v)	(0x0008070400000000L|(unsigned)(v))
+#define	IMPACT_CMD_HQ_PG_WIDTHA(v)	(0x0008080400000000L|(unsigned)(v))
+#define IMPACT_CMD_HQ_TXBASE(p)	(0x00482008|((p)<<9))
+#define IMPACT_CMD_HQ_TXMAX(p,v)\
+	(0x0048300400000000L|(unsigned)(v)|((unsigned long)(p)<<41))
+#define IMPACT_CMD_HQ_PGBITS(p,v)\
+	(0x00482b0400000000L|(unsigned)(v)|((unsigned long)(p)<<41))
+#define IMPACT_CMD_HQ_PGSIZE(v)	(0x00482a0400000000L|(unsigned)(v))
+#define IMPACT_CMD_HQ_STACKPTR(v)	(0x00483a0400000000L|(unsigned)(v))
+
+/* Logic operations for the PP1 (SI=source invert, DI=dest invert, RI=result invert) */
+#define IMPACT_LO_CLEAR	0
+#define IMPACT_LO_AND		1
+#define IMPACT_LO_DIAND	2
+#define IMPACT_LO_COPY	3
+#define IMPACT_LO_SIAND	4
+#define IMPACT_LO_NOP		5
+#define IMPACT_LO_XOR		6
+#define IMPACT_LO_OR		7
+#define IMPACT_LO_RIOR	8
+#define IMPACT_LO_RIXOR	9
+#define IMPACT_LO_RINOP	10
+#define IMPACT_LO_DIOR	11
+#define IMPACT_LO_RICOPY	12
+#define IMPACT_LO_SIOR	13
+#define IMPACT_LO_RIAND	14
+#define IMPACT_LO_SET		15
+
+/* Blending factors */
+#define IMPACT_BLEND_ALPHA	0x0704c900
+
+#endif /* IMPACT_H */
+/*
+ * Fri Mar 18 21:42:10 2005
+ */
diff -Nur linux-git/sound/oss/Kconfig linux-git-mit-R10k-patches/sound/oss/Kconfig
--- linux-git/sound/oss/Kconfig	2005-10-15 16:01:40.000000000 +0200
+++ linux-git-mit-R10k-patches/sound/oss/Kconfig	2005-10-16 19:24:17.000000000 +0200
@@ -199,10 +199,10 @@
 
 config SOUND_HAL2
 	tristate "SGI HAL2 sound (EXPERIMENTAL)"
-	depends on SOUND_PRIME && SGI_IP22 && EXPERIMENTAL
+	depends on SOUND_PRIME && (SGI_IP22 || SGI_IP28) && EXPERIMENTAL
 	help
-	  Say Y or M if you have an SGI Indy system and want to be able to
-	  use it's on-board A2 audio system
+	  Say Y or M if you have an SGI Indy or Indigo2 system and want to
+	  be able to use it's on-board A2 audio system
 
 config SOUND_IT8172
 	tristate "IT8172G Sound"

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stackframe.h.patch"

diff -Nau cvs-/include/asm-mips/stackframe.h ip28/include/asm-mips/stackframe.h
--- cvs-/include/asm-mips/stackframe.h	Tue Apr 19 21:26:28 2005
+++ ip28/include/asm-mips/stackframe.h	Tue Apr 26 23:48:41 2005
@@ -107,12 +107,37 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+# ifdef CONFIG_XKPHYS_KERNEL
+		/*
+		 * Beware!
+		 * 1) This is called, before $at is saved, so the
+		 *    assembler MUST NOT use $at.
+		 * 2) k1 and any implicitely used k0 are not saved. Thus
+		 *    this MUST NOT be called with interrupts enabled.
+		 *    (applies as well to the ckseg version below)
+		 */
+		.set	push
+		.set	noat
+		dla	k1, kernelsp
+		LONG_L	k1, (k1)
+		.set	pop
+# else
 		lui	k1, %hi(kernelsp)
 		LONG_L	k1, %lo(kernelsp)(k1)
+# endif
 		.endm
 
 		.macro	set_saved_sp stackp temp temp2
+		/*
+		 * Beware!  This is called with interrupts enabled, so
+		 * make sure the assembler generated code-sequence only
+		 * uses registers ($at), that will be saved/restored
+		 * (especially true for elf64-.. format).
+		 */
+		/* .set	push */
+		/* .set	at   */
 		LONG_S	\stackp, kernelsp
+		/* .set	pop  */
 		.endm
 #endif
 
@@ -349,1 +374,5 @@
 #endif /* _ASM_STACKFRAME_H */
+/*
+ * Revision 1.37, Tue Apr 19 21:26:28 2005
+ * May 2004	pf	- xkphys kernel addresses
+ */

--AhhlLboLdkugWU4S--
