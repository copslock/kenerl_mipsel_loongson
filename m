Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g590DmnC006940
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 8 Jun 2002 17:13:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g590DlDH006936
	for linux-mips-outgoing; Sat, 8 Jun 2002 17:13:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-40.ka.dial.de.ignite.net [62.180.196.40])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g590DFnC006858
	for <linux-mips@oss.sgi.com>; Sat, 8 Jun 2002 17:13:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g590EAK07868
	for linux-mips@oss.sgi.com; Sun, 9 Jun 2002 02:14:10 +0200
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g57CwJnC010310
	for <linux-mips@oss.sgi.com>; Fri, 7 Jun 2002 05:58:19 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id GAA20147
	for <linux-mips@oss.sgi.com>; Fri, 7 Jun 2002 06:00:17 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA11407
	for <linux-mips@oss.sgi.com>; Fri, 7 Jun 2002 06:00:15 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g57D0Fb21789
	for <linux-mips@oss.sgi.com>; Fri, 7 Jun 2002 15:00:15 +0200 (MEST)
Message-ID: <3D00AE5F.ED130473@mips.com>
Date: Fri, 07 Jun 2002 15:00:15 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips mailing list <linux-mips@oss.sgi.com>
Subject: 64-bit linux
Content-Type: multipart/mixed;
 boundary="------------6A228B530B40164C0D9211A7"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

There has been some interest for the 64-bit kernel, so I have pull
together a patch against the latest sources, which contains our local
fixes and changes.
Could some please apply these fixes.

Added file are
arch/mips64/mm/c-mips64.c
arch/mips64/mm/pg-mips64.c
arch/mips64/mm/tlb-r4k.c
include/asm-mips64/mips64_cache.h

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com



--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15;
 name="linux-2.4.18.64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.18.64.patch"

Index: arch/mips64/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips64/Makefile,v
retrieving revision 1.22.2.3
diff -u -r1.22.2.3 Makefile
--- arch/mips64/Makefile	2002/02/26 23:59:53	1.22.2.3
+++ arch/mips64/Makefile	2002/06/07 12:26:00
@@ -66,6 +66,9 @@
 ifdef CONFIG_CPU_SB1
 CFLAGS		+= -mcpu=r8000 -mips4
 endif
+ifdef CONFIG_CPU_MIPS64
+CFLAGS		+= -mcpu=r8000 -mips4
+endif
 
 #
 # We unconditionally build the math emulator
Index: arch/mips64/config.in
===================================================================
RCS file: /cvs/linux/arch/mips64/config.in,v
retrieving revision 1.50.2.9
diff -u -r1.50.2.9 config.in
--- arch/mips64/config.in	2002/05/29 14:30:57	1.50.2.9
+++ arch/mips64/config.in	2002/06/07 12:26:00
@@ -70,10 +70,14 @@
 if [ "$CONFIG_MIPS_MALTA" = "y" ]; then
    define_bool CONFIG_BOOT_ELF32 y
    define_bool CONFIG_I8259 y
+   define_bool CONFIG_HAVE_STD_PC_SERIAL_PORT y
+   define_bool CONFIG_NEW_IRQ y
+   define_bool CONFIG_NEW_TIME_C y
    define_int CONFIG_L1_CACHE_SHIFT 5
    define_bool CONFIG_NONCOHERENT_IO y
    define_bool CONFIG_PCI y
    define_bool CONFIG_SWAP_IO_SPACE y
+   define_bool CONFIG_PC_KEYB y
 fi
 if [ "$CONFIG_SGI_IP22" = "y" ]; then
    define_bool CONFIG_ARC32 y
@@ -118,20 +122,25 @@
 mainmenu_option next_comment
 comment 'CPU selection'
 
-choice 'CPU type' \
-	"R4300	CONFIG_CPU_R4300 \
-	 R4x00	CONFIG_CPU_R4X00 \
-	 R5000	CONFIG_CPU_R5000 \
-	 R52x0	CONFIG_CPU_NEVADA \
-	 R8000	CONFIG_CPU_R8000 \
-	 R10000	CONFIG_CPU_R10000 \
-	 SB1	CONFIG_CPU_SB1" R4x00
+choice 'CPU type'				\
+	"R4300 CONFIG_CPU_R4300			\
+	 R4x00 CONFIG_CPU_R4X00			\
+	 R5000 CONFIG_CPU_R5000			\
+	 R52x0 CONFIG_CPU_NEVADA		\
+	 R8000 CONFIG_CPU_R8000			\
+	 R10000 CONFIG_CPU_R10000		\
+	 SB1   CONFIG_CPU_SB1			\
+	 MIPS64 CONFIG_CPU_MIPS64" R4x00
 endmenu
 
 if [ "$CONFIG_CPU_SB1" = "y" ]; then
    bool '  Workarounds for pass 1 sb1 bugs' CONFIG_SB1_PASS_1_WORKAROUNDS
    bool '  Support for SB1 Cache Error handler' CONFIG_SB1_CACHE_ERROR
    define_bool CONFIG_VTAG_ICACHE y
+fi
+
+if [ "$CONFIG_CPU_MIPS64" = "y" ]; then
+   bool '  Support for Virtual Tagged I-cache' CONFIG_VTAG_ICACHE
 fi
 
 define_bool CONFIG_CPU_HAS_LLSC y
Index: arch/mips64/kernel/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/Makefile,v
retrieving revision 1.11.2.5
diff -u -r1.11.2.5 Makefile
--- arch/mips64/kernel/Makefile	2002/06/03 15:16:49	1.11.2.5
+++ arch/mips64/kernel/Makefile	2002/06/07 12:26:00
@@ -15,12 +15,15 @@
 
 export-objs = irq.o mips64_ksyms.o pci-dma.o setup.o smp.o
 
-obj-y	:= branch.o entry.o irq.o proc.o process.o ptrace.o r4k_cache.o \
-	   r4k_fpu.o r4k_genex.o r4k_switch.o reset.o scall_64.o semaphore.o \
-	   setup.o signal.o syscall.o time.o traps.o unaligned.o
+obj-y	:= branch.o entry.o proc.o process.o ptrace.o r4k_cache.o \
+	   r4k_fpu.o r4k_genex.o r4k_switch.o reset.o scall_64.o \
+	   semaphore.o setup.o signal.o syscall.o traps.o unaligned.o
 
+obj-$(CONFIG_NEW_IRQ)           += irq.o
 obj-$(CONFIG_I8259)		+= i8259.o
 obj-$(CONFIG_IRQ_CPU)		+= irq_cpu.o
+
+obj-$(CONFIG_NEW_TIME_C)	+= time.o
 
 obj-$(CONFIG_MODULES)		+= mips64_ksyms.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o scall_o32.o signal32.o ioctl32.o
Index: arch/mips64/kernel/entry.S
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/entry.S,v
retrieving revision 1.11.2.4
diff -u -r1.11.2.4 entry.S
--- arch/mips64/kernel/entry.S	2002/05/29 03:03:17	1.11.2.4
+++ arch/mips64/kernel/entry.S	2002/06/07 12:26:00
@@ -24,7 +24,7 @@
 FEXPORT(ret_from_fork)
 		move	a0, v0			# prev
 		jal	schedule_tail
-		lw	t0, TASK_PTRACE($28)	# syscall tracing enabled?
+		ld	t0, TASK_PTRACE($28)	# syscall tracing enabled?
 		andi	t0, PT_TRACESYS
 		bnez	t0, tracesys_exit
 		j	ret_from_sys_call
Index: arch/mips64/kernel/head.S
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/head.S,v
retrieving revision 1.34.2.4
diff -u -r1.34.2.4 head.S
--- arch/mips64/kernel/head.S	2002/02/26 05:59:03	1.34.2.4
+++ arch/mips64/kernel/head.S	2002/06/07 12:26:00
@@ -92,7 +92,7 @@
 	__INIT
 
 NESTED(kernel_entry, 16, sp)			# kernel entry point
-
+	.set	noreorder
 	ori	sp, 0xf				# align stack on 16 byte.
 	xori	sp, 0xf
 
@@ -111,8 +111,22 @@
 	set_saved_sp	sp, t0
 
 	dsubu	sp, 4*SZREG			# init stack pointer
+	
+	/* The firmware/bootloader passes argc/argp/envp
+	 * to us as arguments.  But clear bss first because
+	 * the romvec and other important info is stored there
+	 * by prom_init().
+	 */
+        la      t0, _edata
+        sd      zero, (t0)
+        la      t1, (_end - 8)
+1:
+        daddiu  t0, 8
+        bne     t0, t1, 1b
+         sd     zero, (t0)
 
 	j	init_arch
+	 nop
 	END(kernel_entry)
 
 #ifdef CONFIG_SMP
Index: arch/mips64/kernel/ioctl32.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/ioctl32.c,v
retrieving revision 1.10.2.1
diff -u -r1.10.2.1 ioctl32.c
--- arch/mips64/kernel/ioctl32.c	2001/12/03 07:26:20	1.10.2.1
+++ arch/mips64/kernel/ioctl32.c	2002/06/07 12:26:00
@@ -27,6 +27,7 @@
 #include <linux/auto_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/raid/md_u.h>
+#include <linux/rtc.h>
 #include <scsi/scsi.h>
 #undef __KERNEL__		/* This file was born to be ugly ...  */
 #include <scsi/scsi_ioctl.h>
@@ -834,7 +835,25 @@
 	IOCTL32_DEFAULT(AUTOFS_IOC_CATATONIC),
 	IOCTL32_DEFAULT(AUTOFS_IOC_PROTOVER),
 	IOCTL32_HANDLER(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout),
-	IOCTL32_DEFAULT(AUTOFS_IOC_EXPIRE)
+	IOCTL32_DEFAULT(AUTOFS_IOC_EXPIRE),
+
+	/* Little p (/dev/rtc, /dev/envctrl, etc.) */
+	IOCTL32_DEFAULT(_IOR('p', 20, int[7])), /* RTCGET */
+	IOCTL32_DEFAULT(_IOW('p', 21, int[7])), /* RTCSET */
+	IOCTL32_DEFAULT(RTC_AIE_ON),
+	IOCTL32_DEFAULT(RTC_AIE_OFF),
+	IOCTL32_DEFAULT(RTC_UIE_ON),
+	IOCTL32_DEFAULT(RTC_UIE_OFF),
+	IOCTL32_DEFAULT(RTC_PIE_ON),
+	IOCTL32_DEFAULT(RTC_PIE_OFF),
+	IOCTL32_DEFAULT(RTC_WIE_ON),
+	IOCTL32_DEFAULT(RTC_WIE_OFF),
+	IOCTL32_DEFAULT(RTC_ALM_SET),
+	IOCTL32_DEFAULT(RTC_ALM_READ),
+	IOCTL32_DEFAULT(RTC_RD_TIME),
+	IOCTL32_DEFAULT(RTC_SET_TIME),
+	IOCTL32_DEFAULT(RTC_WKALM_SET),
+	IOCTL32_DEFAULT(RTC_WKALM_RD)
 };
 
 #define NR_IOCTL32_HANDLERS	(sizeof(ioctl32_handler_table) /	\
Index: arch/mips64/kernel/pci-dma.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/Attic/pci-dma.c,v
retrieving revision 1.1.2.2
diff -u -r1.1.2.2 pci-dma.c
--- arch/mips64/kernel/pci-dma.c	2002/05/29 03:03:17	1.1.2.2
+++ arch/mips64/kernel/pci-dma.c	2002/06/07 12:26:00
@@ -10,6 +10,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/pci.h>
 
@@ -22,24 +23,31 @@
 	void *ret;
 	int gfp = GFP_ATOMIC;
 
-	if (hwdev != NULL && hwdev->dma_mask != 0xffffffff)
+	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
 		gfp |= GFP_DMA;
 	ret = (void *) __get_free_pages(gfp, get_order(size));
-
 	if (ret != NULL) {
 		memset(ret, 0, size);
+		*dma_handle = __pa(ret);
 #ifdef CONFIG_NONCOHERENT_IO
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = KSEG1ADDR(ret);
 #endif
-		*dma_handle = __pa(ret);
-		return ret;
 	}
-	return NULL;
+
+	return ret;
 }
 
 void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 			 void *vaddr, dma_addr_t dma_handle)
 {
-	free_pages((unsigned long) KSEG0ADDR(vaddr), get_order(size));
+	unsigned long addr = (unsigned long) vaddr;
+
+#ifdef CONFIG_NONCOHERENT_IO
+	addr = KSEG0ADDR(addr);
+#endif
+	free_pages(addr, get_order(size));
 }
+
+EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(pci_free_consistent);
Index: arch/mips64/kernel/r4k_fpu.S
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/r4k_fpu.S,v
retrieving revision 1.3
diff -u -r1.3 r4k_fpu.S
--- arch/mips64/kernel/r4k_fpu.S	2001/05/25 20:07:50	1.3
+++ arch/mips64/kernel/r4k_fpu.S	2002/06/07 12:26:00
@@ -31,7 +31,7 @@
 
 	.set	noreorder
 	/* Save floating point context */
-LEAF(save_fp_context)
+LEAF(_save_fp_context)
 	mfc0	t1, CP0_STATUS
 	sll	t2, t1,5
 
@@ -79,7 +79,7 @@
 
 	jr	ra
 	 li	v0, 0					# success
-	END(save_fp_context)
+	END(_save_fp_context)
 
 /*
  * Restore FPU state:
@@ -90,7 +90,7 @@
  * frame on the current content of c0_status, not on the content of the
  * stack frame which might have been changed by the user.
  */
-LEAF(restore_fp_context)
+LEAF(_restore_fp_context)
 	mfc0	t1, CP0_STATUS
 	sll	t0, t1,5
 	bgez	t0, 1f
@@ -139,7 +139,7 @@
 	ctc1	t0, fcr31
 	jr	ra
 	 li	v0, 0					# success
-	END(restore_fp_context)
+	END(_restore_fp_context)
 
 	.type	fault@function
 	.ent	fault
Index: arch/mips64/kernel/setup.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/setup.c,v
retrieving revision 1.31.2.6
diff -u -r1.31.2.6 setup.c
--- arch/mips64/kernel/setup.c	2002/06/03 15:16:49	1.31.2.6
+++ arch/mips64/kernel/setup.c	2002/06/07 12:26:00
@@ -141,9 +141,6 @@
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_TX49XX:
-	case CPU_4KC:
-	case CPU_4KEC:
-	case CPU_4KSC:
 	case CPU_5KC:
 /*	case CPU_20KC:*/
 		cpu_wait = r4k_wait;
@@ -182,6 +179,20 @@
 #endif
 }
 
+/*
+ * Get the FPU Implementation/Revision.
+ */
+static inline unsigned long cpu_get_fpu_id(void)
+{
+	unsigned long tmp, fpu_id;
+
+	tmp = read_32bit_cp0_register(CP0_STATUS);
+	__enable_fpu();
+	fpu_id = read_32bit_cp1_register(CP1_REVISION);
+	write_32bit_cp0_register(CP0_STATUS, tmp);
+	return fpu_id;
+}
+
 /* declaration of the global struct */
 struct mips_cpu mips_cpu = {
     processor_id:	PRID_IMP_UNKNOWN,
@@ -194,15 +205,16 @@
 
 static inline void cpu_probe(void)
 {
-#ifdef CONFIG_CPU_MIPS32
-	unsigned long config0 = read_32bit_cp0_register(CP0_CONFIG);
-	unsigned long config1;
+#ifdef CONFIG_CPU_MIPS64
+	unsigned int config0 = read_32bit_cp0_register(CP0_CONFIG);
+	unsigned int config1;
 
         if (config0 & (1 << 31)) {
-		/* MIPS32 compliant CPU. Read Config 1 register. */
-		mips_cpu.isa_level = MIPS_CPU_ISA_M32;
+		/* MIPS64 compliant CPU. Read Config 1 register. */
+		mips_cpu.isa_level = MIPS_CPU_ISA_M64;
 		mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX | 
-			MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | MIPS_CPU_DIVEC;
+			MIPS_CPU_4KTLB | MIPS_CPU_COUNTER | MIPS_CPU_DIVEC |
+			MIPS_CPU_32FPR;
 		config1 = read_mips32_cp0_config1();
 		if (config1 & (1 << 3))
 			mips_cpu.options |= MIPS_CPU_WATCH;
@@ -399,25 +411,15 @@
 			break;
 		}
 		break;
-#ifdef CONFIG_CPU_MIPS32
+#ifdef CONFIG_CPU_MIPS64
 	case PRID_COMP_MIPS:
 		switch (mips_cpu.processor_id & 0xff00) {
-		case PRID_IMP_4KC:
-			mips_cpu.cputype = CPU_4KC;
-			break;
-		case PRID_IMP_4KEC:
-			mips_cpu.cputype = CPU_4KEC;
-			break;
-		case PRID_IMP_4KSC:
-			mips_cpu.cputype = CPU_4KSC;
-			break;
 		case PRID_IMP_5KC:
 			mips_cpu.cputype = CPU_5KC;
-			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
 			break;
 		case PRID_IMP_20KC:
 			mips_cpu.cputype = CPU_20KC;
-			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
+			break;
 		default:
 			mips_cpu.cputype = CPU_UNKNOWN;
 			break;
@@ -459,6 +461,8 @@
 	default:
 		mips_cpu.cputype = CPU_UNKNOWN;
 	}
+	if (mips_cpu.options & MIPS_CPU_FPU)
+		mips_cpu.fpu_id = cpu_get_fpu_id();
 }
 
 static inline void cpu_report(void)
@@ -721,10 +725,11 @@
 #endif
 #ifdef CONFIG_SIBYTE_SWARM
 	swarm_setup();
-	bootmem_init();		/* XXX */
 #endif
-
-#ifdef CONFIG_ARC_MEMORY
+#ifdef CONFIG_MIPS_MALTA
+        malta_setup();
+#endif
+#if defined(CONFIG_ARC_MEMORY) || defined(CONFIG_SIBYTE_SWARM) || defined(CONFIG_MIPS_MALTA)
 	bootmem_init();
 #endif
 
Index: arch/mips64/kernel/traps.c
===================================================================
RCS file: /cvs/linux/arch/mips64/kernel/traps.c,v
retrieving revision 1.30.2.13
diff -u -r1.30.2.13 traps.c
--- arch/mips64/kernel/traps.c	2002/05/28 06:33:13	1.30.2.13
+++ arch/mips64/kernel/traps.c	2002/06/07 12:26:00
@@ -607,6 +607,15 @@
 	}
 }
 
+asmlinkage int (*save_fp_context)(struct sigcontext *sc);
+asmlinkage int (*restore_fp_context)(struct sigcontext *sc);
+extern asmlinkage int _save_fp_context(struct sigcontext *sc);
+extern asmlinkage int _restore_fp_context(struct sigcontext *sc);
+
+extern asmlinkage int fpu_emulator_save_context(struct sigcontext *sc);
+extern asmlinkage int fpu_emulator_restore_context(struct sigcontext *sc);
+
+
 void __init per_cpu_trap_init(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -630,6 +639,7 @@
 void __init trap_init(void)
 {
 	extern char except_vec0;
+/*	extern char except_vec1_r4k;*/
 	extern char except_vec1_r10k;
 	extern char except_vec2_generic, except_vec2_sb1;
 	extern char except_vec3_generic, except_vec3_r4000;
@@ -692,14 +702,18 @@
 	case CPU_R4600:
 	case CPU_R5000:
 	case CPU_NEVADA:
-		/* Cache error vector  */
-		memcpy((void *)(KSEG0 + 0x100), (void *) KSEG0, 0x80);
-
+        case CPU_5KC:
+        case CPU_20KC:
+        case CPU_RM7000:
 nocache:
 		/* Debug TLB refill handler.  */
 		memcpy((void *)KSEG0, &except_vec0, 0x80);
-		memcpy((void *)KSEG0 + 0x080, &except_vec1_r10k, 0x80);
-
+/*		if ((mips_cpu.options & MIPS_CPU_4KEX)
+                    && (mips_cpu.options & MIPS_CPU_4KTLB)) {
+                        memcpy((void *)KSEG0 + 0x080, &except_vec1_r4k, 0x80);
+			} else { */
+			memcpy((void *)KSEG0 + 0x080, &except_vec1_r10k, 0x80);
+/*		}*/
 		if (mips_cpu.options & MIPS_CPU_VCE) {
 			memcpy((void *)(KSEG0 + 0x180), &except_vec3_r4000,
 			       0x80);
@@ -746,6 +760,15 @@
 	default:
 		panic("Unknown CPU type");
 	}
+
+	if (mips_cpu.options & MIPS_CPU_FPU) {
+                save_fp_context = _save_fp_context;
+                restore_fp_context = _restore_fp_context;
+        } else {
+                save_fp_context = fpu_emulator_save_context;
+                restore_fp_context = fpu_emulator_restore_context;
+        }
+
 	flush_icache_range(KSEG0, KSEG0 + 0x200);
 
 	if (mips_cpu.isa_level == MIPS_CPU_ISA_IV)
Index: arch/mips64/mm/Makefile
===================================================================
RCS file: /cvs/linux/arch/mips64/mm/Makefile,v
retrieving revision 1.8.2.2
diff -u -r1.8.2.2 Makefile
--- arch/mips64/mm/Makefile	2002/02/21 04:38:01	1.8.2.2
+++ arch/mips64/mm/Makefile	2002/06/07 12:26:00
@@ -17,6 +17,8 @@
 obj-$(CONFIG_CPU_R10000)	+= andes.o tlbex-r4k.o tlb-glue-r4k.o
 obj-$(CONFIG_CPU_SB1)		+= pg-sb1.o c-sb1.o tlb-sb1.o tlbex-r4k.o \
 				   tlb-glue-r4k.o
+obj-$(CONFIG_CPU_MIPS64)	+= pg-mips64.o c-mips64.o tlb-r4k.o \
+				   tlbex-r4k.o tlb-glue-r4k.o
 
 #
 # Debug TLB exception handler, currently unused
Index: arch/mips64/mm/loadmmu.c
===================================================================
RCS file: /cvs/linux/arch/mips64/mm/loadmmu.c,v
retrieving revision 1.14.2.3
diff -u -r1.14.2.3 loadmmu.c
--- arch/mips64/mm/loadmmu.c	2002/02/18 01:14:46	1.14.2.3
+++ arch/mips64/mm/loadmmu.c	2002/06/07 12:26:01
@@ -54,33 +54,27 @@
 extern void ld_mmu_andes(void);
 extern void ld_mmu_sb1(void);
 extern void sb1_tlb_init(void);
+extern void ld_mmu_mips64(void);
+extern void r4k_tlb_init(void);
 
+
 void __init load_mmu(void)
 {
-	switch(mips_cpu.cputype) {
+	if (mips_cpu.options & MIPS_CPU_4KTLB) {
 #if defined (CONFIG_CPU_R4300)						\
     || defined (CONFIG_CPU_R4X00)					\
     || defined (CONFIG_CPU_R5000)					\
     || defined (CONFIG_CPU_NEVADA)
-	case CPU_R4000PC:
-	case CPU_R4000SC:
-	case CPU_R4000MC:
-	case CPU_R4200:
-	case CPU_R4300:
-	case CPU_R4400PC:
-	case CPU_R4400SC:
-	case CPU_R4400MC:
-	case CPU_R4600:
-	case CPU_R4640:
-	case CPU_R4650:
-	case CPU_R4700:
-	case CPU_R5000:
-	case CPU_R5000A:
-	case CPU_NEVADA:
 		printk("Loading R4000 MMU routines.\n");
 		ld_mmu_r4xx0();
-		break;
 #endif
+#if defined(CONFIG_CPU_MIPS64)
+		printk("Loading MIPS64 MMU routines.\n");
+		ld_mmu_mips64();
+		r4k_tlb_init();
+#endif
+
+	} else switch(mips_cpu.cputype) {
 #ifdef CONFIG_CPU_R10000
 	case CPU_R10000:
 		printk("Loading R10000 MMU routines.\n");
@@ -94,8 +88,7 @@
 		sb1_tlb_init();
 		break;
 #endif
-
 	default:
 		/* XXX We need an generic routine in the MIPS port
 		 * XXX to jabber stuff onto the screen on all machines
Index: include/asm-mips64/addrspace.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/addrspace.h,v
retrieving revision 1.10
diff -u -r1.10 addrspace.h
--- include/asm-mips64/addrspace.h	2001/07/09 00:25:37	1.10
+++ include/asm-mips64/addrspace.h	2002/06/07 12:26:15
@@ -29,15 +29,15 @@
  * Returns the physical address of a KSEG0/KSEG1 address
  */
 #define CPHYSADDR(a)		(((unsigned long)(a)) & 0x000000001fffffffUL)
-#define PHYSADDR(a)		(((unsigned long)(a)) & 0x000000ffffffffffUL)
+#define PHYSADDR(a)		(((unsigned long)(a)) & 0x000000001fffffffUL)
 
 /*
  * Map an address to a certain kernel segment
  */
-#define KSEG0ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000ffffffffffUL) | KSEG0))
-#define KSEG1ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000ffffffffffUL) | KSEG1))
-#define KSEG2ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000ffffffffffUL) | KSEG2))
-#define KSEG3ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000ffffffffffUL) | KSEG3))
+#define KSEG0ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000001fffffffUL) | KSEG0))
+#define KSEG1ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000001fffffffUL) | KSEG1))
+#define KSEG2ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000001fffffffUL) | KSEG2))
+#define KSEG3ADDR(a)		((__typeof__(a))(((unsigned long)(a) & 0x000000001fffffffUL) | KSEG3))
 
 /*
  * Memory segments (64bit kernel mode addresses)
Index: include/asm-mips64/cache.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/cache.h,v
retrieving revision 1.7.2.1
diff -u -r1.7.2.1 cache.h
--- include/asm-mips64/cache.h	2002/05/29 03:03:18	1.7.2.1
+++ include/asm-mips64/cache.h	2002/06/07 12:26:15
@@ -23,6 +23,11 @@
 };
 #endif
 
+/*
+ * Flag definitions
+ */
+#define MIPS_CACHE_NOT_PRESENT 0x00000001
+
 /* bytes per L1 cache line */
 #define L1_CACHE_BYTES		(1 << CONFIG_L1_CACHE_SHIFT)
 
Index: include/asm-mips64/checksum.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/checksum.h,v
retrieving revision 1.12
diff -u -r1.12 checksum.h
--- include/asm-mips64/checksum.h	2001/10/31 02:31:23	1.12
+++ include/asm-mips64/checksum.h	2002/06/07 12:26:15
@@ -161,9 +161,9 @@
 	: "=r" (sum)
 	: "0" (daddr), "r"(saddr),
 #ifdef __MIPSEL__
-	  "r" ((ntohs(len)<<16)+proto*256),
+	  "r" (((unsigned long)ntohs(len)<<16)+proto*256),
 #else
-	  "r" (((proto)<<16)+len),
+	  "r" ((((unsigned long)proto)<<16)+len),
 #endif
 	  "r" (sum));
 
Index: include/asm-mips64/ide.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/ide.h,v
retrieving revision 1.6
diff -u -r1.6 ide.h
--- include/asm-mips64/ide.h	2001/08/22 03:25:05	1.6
+++ include/asm-mips64/ide.h	2002/06/07 12:26:15
@@ -18,6 +18,7 @@
 #ifdef __KERNEL__
 
 #include <linux/config.h>
+#include <asm/io.h>
 
 #ifndef MAX_HWIFS
 # ifdef CONFIG_BLK_DEV_IDEPCI
@@ -79,11 +80,19 @@
 typedef union {
 	unsigned all			: 8;	/* all of the bits together */
 	struct {
+#ifdef __MIPSEB__
+		unsigned bit7           : 1;    /* always 1 */
+		unsigned lba            : 1;    /* using LBA instead of CHS */
+		unsigned bit5           : 1;    /* always 1 */
+		unsigned unit           : 1;    /* drive select number, 0 or 1 */
+		unsigned head           : 4;    /* always zeros here */
+#else
 		unsigned head		: 4;	/* always zeros here */
 		unsigned unit		: 1;	/* drive select number, 0 or 1 */
 		unsigned bit5		: 1;	/* always 1 */
 		unsigned lba		: 1;	/* using LBA instead of CHS */
 		unsigned bit7		: 1;	/* always 1 */
+#endif
 	} b;
 	} select_t;
 
@@ -118,54 +127,141 @@
 
 #if defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)
 
-#ifdef insl
-#undef insl
-#endif
-#ifdef outsl
-#undef outsl
-#endif
+/* get rid of defs from io.h - ide has its private and conflicting versions */
 #ifdef insw
 #undef insw
 #endif
 #ifdef outsw
 #undef outsw
 #endif
+#ifdef insl
+#undef insl
+#endif
+#ifdef outsl
+#undef outsl
+#endif
+
+#define insw(port, addr, count) ide_insw(port, addr, count)
+#define insl(port, addr, count) ide_insl(port, addr, count)
+#define outsw(port, addr, count) ide_outsw(port, addr, count)
+#define outsl(port, addr, count) ide_outsl(port, addr, count)
+
+static inline void ide_insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = *(volatile u16 *)(mips_io_port_base + port);
+		addr += 2;
+	}
+}
+
+static inline void ide_outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u16 *)(mips_io_port_base + (port)) = *(u16 *)addr;
+		addr += 2;
+	}
+}
+
+static inline void ide_insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = *(volatile u32 *)(mips_io_port_base + port);
+		addr += 4;
+	}
+}
+
+static inline void ide_outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(volatile u32 *)(mips_io_port_base + (port)) = *(u32 *)addr;
+		addr += 4;
+	}
+}
+
+#define T_CHAR          (0x0000)        /* char:  don't touch  */
+#define T_SHORT         (0x4000)        /* short: 12 -> 21     */
+#define T_INT           (0x8000)        /* int:   1234 -> 4321 */
+#define T_TEXT          (0xc000)        /* text:  12 -> 21     */
+
+#define T_MASK_TYPE     (0xc000)
+#define T_MASK_COUNT    (0x3fff)
+
+#define D_CHAR(cnt)     (T_CHAR  | (cnt))
+#define D_SHORT(cnt)    (T_SHORT | (cnt))
+#define D_INT(cnt)      (T_INT   | (cnt))
+#define D_TEXT(cnt)     (T_TEXT  | (cnt))
+
+static u_short driveid_types[] = {
+	D_SHORT(10),    /* config - vendor2 */
+	D_TEXT(20),     /* serial_no */
+	D_SHORT(3),     /* buf_type - ecc_bytes */
+	D_TEXT(48),     /* fw_rev - model */
+	D_CHAR(2),      /* max_multsect - vendor3 */
+	D_SHORT(1),     /* dword_io */
+	D_CHAR(2),      /* vendor4 - capability */
+	D_SHORT(1),     /* reserved50 */
+	D_CHAR(4),      /* vendor5 - tDMA */
+	D_SHORT(4),     /* field_valid - cur_sectors */
+	D_INT(1),       /* cur_capacity */
+	D_CHAR(2),      /* multsect - multsect_valid */
+	D_INT(1),       /* lba_capacity */
+	D_SHORT(194)    /* dma_1word - reservedyy */
+};
 
-#define insw(p,a,c)							\
-do {									\
-	unsigned short *ptr = (unsigned short *)(a);			\
-	unsigned int i = (c);						\
-	while (i--)							\
-		*ptr++ = inw(p);					\
-} while (0)
-#define insl(p,a,c)							\
-do {									\
-	unsigned long *ptr = (unsigned long *)(a);			\
-	unsigned int i = (c);						\
-	while (i--)							\
-		*ptr++ = inl(p);					\
-} while (0)
-#define outsw(p,a,c)							\
-do {									\
-	unsigned short *ptr = (unsigned short *)(a);			\
-	unsigned int i = (c);						\
-	while (i--)							\
-		outw(*ptr++, (p));					\
-} while (0)
-#define outsl(p,a,c) {							\
-	unsigned long *ptr = (unsigned long *)(a);			\
-	unsigned int i = (c);						\
-	while (i--)							\
-		outl(*ptr++, (p));					\
-} while (0)
+#define num_driveid_types       (sizeof(driveid_types)/sizeof(*driveid_types))
 
-#endif /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
+static __inline__ void ide_fix_driveid(struct hd_driveid *id)
+{
+	u_char *p = (u_char *)id;
+	int i, j, cnt;
+	u_char t;
+
+	for (i = 0; i < num_driveid_types; i++) {
+		cnt = driveid_types[i] & T_MASK_COUNT;
+		switch (driveid_types[i] & T_MASK_TYPE) {
+		case T_CHAR:
+			p += cnt;
+			break;
+		case T_SHORT:
+			for (j = 0; j < cnt; j++) {
+				t = p[0];
+				p[0] = p[1];
+				p[1] = t;
+				p += 2;
+			}
+			break;
+		case T_INT:
+			for (j = 0; j < cnt; j++) {
+				t = p[0];
+				p[0] = p[3];
+				p[3] = t;
+				t = p[1];
+				p[1] = p[2];
+				p[2] = t;
+				p += 4;
+			}
+			break;
+		case T_TEXT:
+			for (j = 0; j < cnt; j += 2) {
+				t = p[0];
+				p[0] = p[1];
+				p[1] = t;
+				p += 2;
+			}
+			break;
+		};
+	}
+}
+#else /* defined(CONFIG_SWAP_IO_SPACE) && defined(__MIPSEB__)  */
+
+#define ide_fix_driveid(id)             do {} while (0)
+
+#endif
 
 /*
  * The following are not needed for the non-m68k ports
  */
 #define ide_ack_intr(hwif)		(1)
-#define ide_fix_driveid(id)		do {} while (0)
 #define ide_release_lock(lock)		do {} while (0)
 #define ide_get_lock(lock, hdlr, data)	do {} while (0)
 
Index: include/asm-mips64/io.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/io.h,v
retrieving revision 1.25.2.5
diff -u -r1.25.2.5 io.h
--- include/asm-mips64/io.h	2002/02/07 02:39:41	1.25.2.5
+++ include/asm-mips64/io.h	2002/06/07 12:26:15
@@ -13,6 +13,7 @@
 #include <linux/config.h>
 #include <asm/addrspace.h>
 #include <asm/page.h>
+#include <asm/byteorder.h>
 
 #ifdef CONFIG_MIPS_ATLAS
 #include <asm/mips-boards/io.h>
@@ -98,23 +99,23 @@
 /*
  * This assumes sane hardware.  The Origin is.
  */
-#define readb(addr)		(*(volatile unsigned char *) (addr))
-#define readw(addr)		(*(volatile unsigned short *) (addr))
-#define readl(addr)		(*(volatile unsigned int *) (addr))
+#define readb(addr)		(*(volatile unsigned char *)(addr))
+#define readw(addr)		__ioswab16((*(volatile unsigned short *)(addr)))
+#define readl(addr)		__ioswab32((*(volatile unsigned int *)(addr)))
 
 #define __raw_readb(addr)	(*(volatile unsigned char *)(addr))
 #define __raw_readw(addr)	(*(volatile unsigned short *)(addr))
 #define __raw_readl(addr)	(*(volatile unsigned int *)(addr))
 
-#define writeb(b,addr)		(*(volatile unsigned char *) (addr) = (b))
-#define writew(w,addr)		(*(volatile unsigned short *) (addr) = (w))
-#define writel(l,addr)		(*(volatile unsigned int *) (addr) = (l))
+#define writeb(b,addr) ((*(volatile unsigned char *)(addr)) = (__ioswab8(b)))
+#define writew(b,addr) ((*(volatile unsigned short *)(addr)) = (__ioswab16(b)))
+#define writel(b,addr) ((*(volatile unsigned int *)(addr)) = (__ioswab32(b)))
 
 #define __raw_writeb(b,addr)	((*(volatile unsigned char *)(addr)) = (b))
 #define __raw_writew(w,addr)	((*(volatile unsigned short *)(addr)) = (w))
 #define __raw_writel(l,addr)	((*(volatile unsigned int *)(addr)) = (l))
 
-#define memset_io(a,b,c)	memset((void *) a,(b),(c))
+#define memset_io(a,b,c)	memset((void *)(a),(b),(c))
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))
 #define memcpy_toio(a,b,c)	memcpy((void *)(a),(b),(c))
 
@@ -154,12 +155,12 @@
  */
 static inline unsigned long virt_to_phys(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return (unsigned long)address & ~PAGE_OFFSET;
 }
 
 static inline void * phys_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return (void *)(address | PAGE_OFFSET);
 }
 
 /*
@@ -167,12 +168,12 @@
  */
 static inline unsigned long virt_to_bus(volatile void * address)
 {
-	return (unsigned long)address - PAGE_OFFSET;
+	return (unsigned long)address & ~PAGE_OFFSET;
 }
 
 static inline void * bus_to_virt(unsigned long address)
 {
-	return (void *)(address + PAGE_OFFSET);
+	return (void *)(address | PAGE_OFFSET);
 }
 
 
@@ -229,202 +230,131 @@
 	return retval;
 }
 
-/*
- * Talk about misusing macros..
- */
 
-#define __OUT1(s) \
-static inline void __out##s(unsigned int value, unsigned long port) {
+#define outb(val,port)							\
+do {									\
+	*(volatile u8 *)(mips_io_port_base + (port)) = __ioswab8(val);	\
+} while(0)
+
+#define outw(val,port)							\
+do {									\
+	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);\
+} while(0)
+
+#define outl(val,port)							\
+do {									\
+	*(volatile u32 *)(mips_io_port_base + (port)) = __ioswab32(val);\
+} while(0)
+
+#define outb_p(val,port)						\
+do {									\
+	*(volatile u8 *)(mips_io_port_base + (port)) = __ioswab8(val);	\
+	SLOW_DOWN_IO;							\
+} while(0)
+
+#define outw_p(val,port)						\
+do {									\
+	*(volatile u16 *)(mips_io_port_base + (port)) = __ioswab16(val);\
+	SLOW_DOWN_IO;							\
+} while(0)
+
+#define outl_p(val,port)						\
+do {									\
+	*(volatile u32 *)(mips_io_port_base + (port)) = __ioswab32(val);\
+	SLOW_DOWN_IO;							\
+} while(0)
 
-#define __OUT2(m) \
-__asm__ __volatile__ ("s" #m "\t%0,%1(%2)"
+static inline unsigned char inb(unsigned long port)
+{
+	return __ioswab8(*(volatile u8 *)(mips_io_port_base + port));
+}
 
-#define __OUT(m,s) \
-__OUT1(s) __OUT2(m) : : "r" (value), "i" (0), "r" (mips_io_port_base+port)); } \
-__OUT1(s##c) __OUT2(m) : : "r" (value), "ir" (port), "r" (mips_io_port_base)); } \
-__OUT1(s##_p) __OUT2(m) : : "r" (value), "i" (0), "r" (mips_io_port_base+port)); \
-	SLOW_DOWN_IO; } \
-__OUT1(s##c_p) __OUT2(m) : : "r" (value), "ir" (port), "r" (mips_io_port_base)); \
-	SLOW_DOWN_IO; }
-
-#define __IN1(t,s) \
-static inline t __in##s(unsigned long port) { t _v;
-
-/*
- * Required nops will be inserted by the assembler
- */
-#define __IN2(m) \
-__asm__ __volatile__ ("l" #m "\t%0,%1(%2)"
-
-#define __IN(t,m,s) \
-__IN1(t,s) __IN2(m) : "=r" (_v) : "i" (0), "r" (mips_io_port_base+port)); return _v; } \
-__IN1(t,s##c) __IN2(m) : "=r" (_v) : "ir" (port), "r" (mips_io_port_base)); return _v; } \
-__IN1(t,s##_p) __IN2(m) : "=r" (_v) : "i" (0), "r" (mips_io_port_base+port)); SLOW_DOWN_IO; return _v; } \
-__IN1(t,s##c_p) __IN2(m) : "=r" (_v) : "ir" (port), "r" (mips_io_port_base)); SLOW_DOWN_IO; return _v; }
-
-#define __INS1(s) \
-static inline void __ins##s(unsigned long port, void * addr, unsigned long count) {
-
-#define __INS2(m) \
-if (count) \
-__asm__ __volatile__ ( \
-	".set\tnoreorder\n\t" \
-	".set\tnoat\n" \
-	"1:\tl" #m "\t$1, %4(%5)\n\t" \
-	"dsubu\t%1, 1\n\t" \
-	"s" #m "\t$1,(%0)\n\t" \
-	"bnez\t%1, 1b\n\t" \
-	"daddiu\t%0, %6\n\t" \
-	".set\tat\n\t" \
-	".set\treorder"
-
-#define __INS(m,s,i) \
-__INS1(s) __INS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "i" (0), "r" (mips_io_port_base+port), \
-	  "I" (i));} \
-__INS1(s##c) __INS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "ir" (port), "r" (mips_io_port_base), \
-	  "I" (i));}
-
-#define __OUTS1(s) \
-static inline void __outs##s(unsigned long port, const void * addr, unsigned long count) {
-
-#define __OUTS2(m) \
-if (count) \
-__asm__ __volatile__ ( \
-	".set\tnoreorder\n\t" \
-	".set\tnoat\n" \
-	"1:\tl" #m "\t$1, (%0)\n\t" \
-	"dsubu\t%1, 1\n\t" \
-	"s" #m "\t$1, %4(%5)\n\t" \
-	"bnez\t%1, 1b\n\t" \
-	"daddiu\t%0, %6\n\t" \
-	".set\tat\n\t" \
-	".set\treorder"
-
-#define __OUTS(m,s,i) \
-__OUTS1(s) __OUTS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "i" (0), "r" (mips_io_port_base+port), \
-	  "I" (i));} \
-__OUTS1(s##c) __OUTS2(m) \
-	: "=r" (addr), "=r" (count) \
-	: "0" (addr), "1" (count), "ir" (port), "r" (mips_io_port_base), \
-	  "I" (i));}
-
-__IN(unsigned char,b,b)
-__IN(unsigned short,h,w)
-__IN(unsigned int,w,l)
-
-__OUT(b,b)
-__OUT(h,w)
-__OUT(w,l)
-
-__INS(b,b,1)
-__INS(h,w,2)
-__INS(w,l,4)
-
-__OUTS(b,b,1)
-__OUTS(h,w,2)
-__OUTS(w,l,4)
-
-/*
- * Note that due to the way __builtin_constant_p() works, you
- *  - can't use it inside an inline function (it will never be true)
- *  - you don't have to worry about side effects within the __builtin..
- */
-#define outb(val,port) \
-((__builtin_constant_p((port)^(3)) && ((port)^(3)) < 32768) ? \
-	__outbc((val),(port)^(3)) : \
-	__outb((val),(port)^(3)))
-
-#define inb(port) \
-((__builtin_constant_p((port)^(3)) && ((port)^(3)) < 32768) ? \
-	__inbc((port)^(3)) : \
-	__inb((port)^(3)))
-
-#define outb_p(val,port) \
-((__builtin_constant_p((port)^(3)) && ((port)^(3)) < 32768) ? \
-	__outbc_p((val),(port)^(3)) : \
-	__outb_p((val),(port)^(3)))
-
-#define inb_p(port) \
-((__builtin_constant_p((port)^(3)) && ((port)^(3)) < 32768) ? \
-	__inbc_p((port)^(3)) : \
-	__inb_p((port)^(3)))
-
-#define outw(val,port) \
-((__builtin_constant_p(((port)^(2))) && ((port)^(2)) < 32768) ? \
-	__outwc((val),((port)^(2))) : \
-	__outw((val),((port)^(2))))
-
-#define inw(port) \
-((__builtin_constant_p(((port)^(2))) && ((port)^(2)) < 32768) ? \
-	__inwc((port)^(2)) : \
-	__inw((port)^(2)))
-
-#define outw_p(val,port) \
-((__builtin_constant_p((port)^(2)) && ((port)^(2)) < 32768) ? \
-	__outwc_p((val),(port)^(2)) : \
-	__outw_p((val),(port)^(2)))
-
-#define inw_p(port) \
-((__builtin_constant_p((port)^(2)) && ((port)^(2)) < 32768) ? \
-	__inwc_p((port)^(2)) : \
-	__inw_p((port)^(2)))
-
-#define outl(val,port) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__outlc((val),(port)) : \
-	__outl((val),(port)))
-
-#define inl(port) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__inlc(port) : \
-	__inl(port))
-
-#define outl_p(val,port) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__outlc_p((val),(port)) : \
-	__outl_p((val),(port)))
-
-#define inl_p(port) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__inlc_p(port) : \
-	__inl_p(port))
-
-
-#define outsb(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__outsbc((port),(addr),(count)) : \
-	__outsb ((port),(addr),(count)))
-
-#define insb(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__insbc((port),(addr),(count)) : \
-	__insb((port),(addr),(count)))
-
-#define outsw(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__outswc((port),(addr),(count)) : \
-	__outsw ((port),(addr),(count)))
-
-#define insw(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__inswc((port),(addr),(count)) : \
-	__insw((port),(addr),(count)))
-
-#define outsl(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__outslc((port),(addr),(count)) : \
-	__outsl ((port),(addr),(count)))
-
-#define insl(port,addr,count) \
-((__builtin_constant_p((port)) && (port) < 32768) ? \
-	__inslc((port),(addr),(count)) : \
-	__insl((port),(addr),(count)))
+static inline unsigned short inw(unsigned long port)
+{
+	return __ioswab16(*(volatile u16 *)(mips_io_port_base + port));
+}
+
+static inline unsigned int inl(unsigned long port)
+{
+	return __ioswab32(*(volatile u32 *)(mips_io_port_base + port));
+}
+
+static inline unsigned char inb_p(unsigned long port)
+{
+	u8 __val;
+
+	__val = *(volatile u8 *)(mips_io_port_base + port);
+	SLOW_DOWN_IO;
+
+	return __ioswab8(__val);
+}
+
+static inline unsigned short inw_p(unsigned long port)
+{
+	u16 __val;
+
+	__val = *(volatile u16 *)(mips_io_port_base + port);
+	SLOW_DOWN_IO;
+
+	return __ioswab16(__val);
+}
+
+static inline unsigned int inl_p(unsigned long port)
+{
+	u32 __val;
+
+	__val = *(volatile u32 *)(mips_io_port_base + port);
+	SLOW_DOWN_IO;
+	return __ioswab32(__val);
+}
+
+static inline void outsb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		outb(*(u8 *)addr, port);
+		addr++;
+	}
+}
+
+static inline void insb(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u8 *)addr = inb(port);
+		addr++;
+	}
+}
+
+static inline void outsw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		outw(*(u16 *)addr, port);
+		addr += 2;
+	}
+}
+
+static inline void insw(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u16 *)addr = inw(port);
+		addr += 2;
+	}
+}
+
+static inline void outsl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		outl(*(u32 *)addr, port);
+		addr += 4;
+	}
+}
+
+static inline void insl(unsigned long port, void *addr, unsigned int count)
+{
+	while (count--) {
+		*(u32 *)addr = inl(port);
+		addr += 4;
+	}
+}
 
 /*
  * The caches on some architectures aren't dma-coherent and have need to
Index: include/asm-mips64/irq.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/irq.h,v
retrieving revision 1.4
diff -u -r1.4 irq.h
--- include/asm-mips64/irq.h	2001/03/02 03:04:55	1.4
+++ include/asm-mips64/irq.h	2002/06/07 12:26:15
@@ -48,6 +48,12 @@
 extern void disable_irq(unsigned int);
 extern void enable_irq(unsigned int);
 
+#ifndef CONFIG_NEW_IRQ
+#define disable_irq_nosync      disable_irq
+#else
+extern void disable_irq_nosync(unsigned int);
+#endif
+
 /* Machine specific interrupt initialization  */
 extern void (*irq_setup)(void);
 
Index: include/asm-mips64/page.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/page.h,v
retrieving revision 1.10.2.6
diff -u -r1.10.2.6 page.h
--- include/asm-mips64/page.h	2002/01/24 23:14:28	1.10.2.6
+++ include/asm-mips64/page.h	2002/06/07 12:26:15
@@ -29,6 +29,10 @@
  */
 void sb1_clear_page(void * page);
 void sb1_copy_page(void * to, void * from);
+void mips64_clear_page_dc(unsigned long page);
+void mips64_clear_page_sc(unsigned long page);
+void mips64_copy_page_dc(unsigned long to, unsigned long from);
+void mips64_copy_page_sc(unsigned long to, unsigned long from);
 
 extern void (*_clear_page)(void * page);
 extern void (*_copy_page)(void * to, void * from);
@@ -94,8 +98,8 @@
 #define PAGE_OFFSET	0xa800000000000000UL
 #endif
 
-#define __pa(x)		((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)		((void *)((unsigned long) (x) + PAGE_OFFSET))
+#define __pa(x)		((unsigned long) (x) & ~PAGE_OFFSET)
+#define __va(x)		((void *)((unsigned long) (x) | PAGE_OFFSET))
 #ifndef CONFIG_DISCONTIGMEM
 #define virt_to_page(kaddr)	(mem_map + (__pa(kaddr) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
Index: include/asm-mips64/pci.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/pci.h,v
retrieving revision 1.16.2.2
diff -u -r1.16.2.2 pci.h
--- include/asm-mips64/pci.h	2002/02/26 06:00:25	1.16.2.2
+++ include/asm-mips64/pci.h	2002/06/07 12:26:15
@@ -173,7 +173,7 @@
 	dma_cache_wback_inv(addr, size);
 #endif
 
-	return virt_to_bus(addr);
+	return virt_to_bus((void *)addr);
 }
 
 static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
@@ -213,7 +213,7 @@
 #ifdef CONFIG_NONCOHERENT_IO
 		dma_cache_wback_inv((unsigned long)sg->address, sg->length);
 #endif
-		sg->dma_address = (char *)(__pa(sg->address));
+/*		sg->dma_address = (char *)(__pa(sg->address));*/
 	}
 
 	return nents;
@@ -250,7 +250,7 @@
 	if (direction == PCI_DMA_NONE)
 		BUG();
 #ifdef CONFIG_NONCOHERENT_IO
-	dma_cache_wback_inv((unsigned long)__va(dma_handle - bus_to_baddr[hwdev->bus->number]), size);
+	dma_cache_wback_inv((unsigned long)bus_to_virt(dma_handle), size);
 #endif
 }
 
@@ -287,7 +287,7 @@
 	 * so we can't guarantee allocations that must be
 	 * within a tighter range than GFP_DMA..
 	 */
-	if (mask < 0x00ffffff)
+	if (mask < 0x1fffffff)
 		return 0;
 
 	return 1;
@@ -339,7 +339,7 @@
  * returns, or alternatively stop on the first sg_dma_len(sg) which
  * is 0.
  */
-#define sg_dma_address(sg)	((unsigned long)((sg)->address))
+#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
 #define sg_dma_len(sg)		((sg)->length)
 
 #endif /* __KERNEL__ */
Index: include/asm-mips64/pgtable.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/pgtable.h,v
retrieving revision 1.47.2.10
diff -u -r1.47.2.10 pgtable.h
--- include/asm-mips64/pgtable.h	2002/05/28 09:49:45	1.47.2.10
+++ include/asm-mips64/pgtable.h	2002/06/07 12:26:15
@@ -74,23 +74,13 @@
 
 #else
 
-extern void (*_flush_icache_all)(void);
-extern void (*_flush_icache_range)(unsigned long start, unsigned long end);
-extern void (*_flush_icache_page)(struct vm_area_struct *vma, struct page *page);
-
 #define flush_cache_mm(mm)		_flush_cache_mm(mm)
 #define flush_cache_range(mm,start,end)	_flush_cache_range(mm,start,end)
 #define flush_cache_page(vma,page)	_flush_cache_page(vma, page)
 #define flush_page_to_ram(page)		_flush_page_to_ram(page)
 #define flush_icache_range(start, end)	_flush_icache_range(start, end)
 #define flush_icache_page(vma, page)	_flush_icache_page(vma, page)
-#ifdef CONFIG_VTAG_ICACHE
-#define flush_icache_all()		_flush_icache_all()
-#else
-#define flush_icache_all()		do { } while(0)
-#endif
 
-
 #endif /* !CONFIG_CPU_R10000 */
 
 #define flush_cache_sigtramp(addr)	_flush_cache_sigtramp(addr)
@@ -198,11 +188,11 @@
 #ifdef CONFIG_MIPS_UNCACHED
 #define PAGE_CACHABLE_DEFAULT _CACHE_UNCACHED
 #else /* ! UNCACHED */
-#ifdef CONFIG_SGI_IP22
-#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
-#else /* ! IP22 */
+#if defined(CONFIG_SGI_IP27) || defined(CONFIG_SGI_IP32)
 #define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_COW
-#endif /* IP22 */
+#else
+#define PAGE_CACHABLE_DEFAULT _CACHE_CACHABLE_NONCOHERENT
+#endif
 #endif /* UNCACHED */
 
 #define PAGE_NONE	__pgprot(_PAGE_PRESENT | PAGE_CACHABLE_DEFAULT)
@@ -569,6 +559,8 @@
 #ifndef CONFIG_DISCONTIGMEM
 #define kern_addr_valid(addr)	(1)
 #endif
+
+#define io_remap_page_range remap_page_range
 
 /*
  * No page table caches to initialise
Index: include/asm-mips64/serial.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/serial.h,v
retrieving revision 1.7.2.3
diff -u -r1.7.2.3 serial.h
--- include/asm-mips64/serial.h	2002/05/29 03:03:18	1.7.2.3
+++ include/asm-mips64/serial.h	2002/06/07 12:26:15
@@ -65,7 +65,6 @@
 /*
  * The IP32 (SGI O2) has standard serial ports (UART 16550A) mapped in memory
  */
-
 /* Standard COM flags (except for COM4, because of the 8514 problem) */
 #ifdef CONFIG_SERIAL_DETECT_IRQ
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
@@ -88,13 +87,37 @@
           iomem_base: (u8*)MACE_BASE+MACEISA_SER2_BASE,	\
           iomem_reg_shift: 8,				\
           io_type: SERIAL_IO_MEM},                      
+
 #else
 #define IP32_SERIAL_PORT_DEFNS
 #endif /* CONFIG_SGI_IP31 */
 
+#ifdef CONFIG_HAVE_STD_PC_SERIAL_PORT
+
+/* Standard COM flags (except for COM4, because of the 8514 problem) */
+#ifdef CONFIG_SERIAL_DETECT_IRQ
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ)
+#define STD_COM4_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_AUTO_IRQ)
+#else
+#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
+#define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
+#endif
+
+#define STD_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
+	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
+	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+
+#else /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
+#define STD_SERIAL_PORT_DEFNS
+#endif /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
+
 #define SERIAL_PORT_DFNS				\
 	IP27_SERIAL_PORT_DEFNS				\
-	IP32_SERIAL_PORT_DEFNS
+	IP32_SERIAL_PORT_DEFNS				\
+	STD_SERIAL_PORT_DEFNS
 
 #define RS_TABLE_SIZE	64
 
Index: include/asm-mips64/system.h
===================================================================
RCS file: /cvs/linux/include/asm-mips64/system.h,v
retrieving revision 1.18.2.7
diff -u -r1.18.2.7 system.h
--- include/asm-mips64/system.h	2002/05/28 05:53:06	1.18.2.7
+++ include/asm-mips64/system.h	2002/06/07 12:26:15
@@ -202,9 +202,9 @@
 
 extern asmlinkage void lazy_fpu_switch(void *, void *);
 extern asmlinkage void init_fpu(void);
-extern asmlinkage void save_fp(struct task_struct *);
-extern asmlinkage void restore_fp(struct task_struct *);
+extern asmlinkage void save_fp(void *);
+extern asmlinkage void restore_fp(void *);
 
 #ifdef CONFIG_SMP
 #define SWITCH_DO_LAZY_FPU \

--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15;
 name="c-mips64.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c-mips64.c"

/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
 *
 * This program is free software; you can distribute it and/or modify it
 * under the terms of the GNU General Public License (Version 2) as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * MIPS64 CPU variant specific Cache routines.
 * These routine are not optimized in any way, they are done in a generic way
 * so they can be used on all MIPS64 compliant CPUs, and also done in an 
 * attempt not to break anything for the R4xx0 style CPUs.
 */
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <linux/mm.h>

#include <asm/bootinfo.h>
#include <asm/cpu.h>
#include <asm/bcache.h>
#include <asm/io.h>
#include <asm/page.h>
#include <asm/pgtable.h>
#include <asm/system.h>
#include <asm/mmu_context.h>

/* CP0 hazard avoidance. */
#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
				     "nop; nop; nop; nop; nop; nop;\n\t" \
				     ".set reorder\n\t")

/* Primary cache parameters. */
int icache_size, dcache_size; /* Size in bytes */
int ic_lsize, dc_lsize;       /* LineSize in bytes */

/* Secondary cache (if present) parameters. */
unsigned int scache_size, sc_lsize;	/* Again, in bytes */

#include <asm/cacheops.h>
#include <asm/mips64_cache.h>

#undef DEBUG_CACHE

/*
 * Dummy cache handling routines for machines without boardcaches
 */
static void no_sc_noop(void) {}

static struct bcache_ops no_sc_ops = {
	(void *)no_sc_noop, (void *)no_sc_noop,
	(void *)no_sc_noop, (void *)no_sc_noop
};

struct bcache_ops *bcops = &no_sc_ops;


static inline void mips64_flush_cache_all_sc(void)
{
	unsigned long flags;

	__save_and_cli(flags);
	blast_dcache(); blast_icache(); blast_scache();
	__restore_flags(flags);
}

static inline void mips64_flush_cache_all_pc(void)
{
	unsigned long flags;

	__save_and_cli(flags);
	blast_dcache(); blast_icache();
	__restore_flags(flags);
}

static void
mips64_flush_cache_range_sc(struct mm_struct *mm,
			 unsigned long start,
			 unsigned long end)
{
	struct vm_area_struct *vma;
	unsigned long flags;

	if(mm->context == 0)
		return;

	start &= PAGE_MASK;
#ifdef DEBUG_CACHE
	printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
#endif
	vma = find_vma(mm, start);
	if(vma) {
		if(mm->context != current->mm->context) {
			mips64_flush_cache_all_sc();
		} else {
			pgd_t *pgd;
			pmd_t *pmd;
			pte_t *pte;

			__save_and_cli(flags);
			while(start < end) {
				pgd = pgd_offset(mm, start);
				pmd = pmd_offset(pgd, start);
				pte = pte_offset(pmd, start);

				if(pte_val(*pte) & _PAGE_VALID)
					blast_scache_page(start);
				start += PAGE_SIZE;
			}
			__restore_flags(flags);
		}
	}
}

static void mips64_flush_cache_range_pc(struct mm_struct *mm,
				     unsigned long start,
				     unsigned long end)
{
	if(mm->context != 0) {
		unsigned long flags;

#ifdef DEBUG_CACHE
		printk("crange[%d,%08lx,%08lx]", (int)mm->context, start, end);
#endif
		__save_and_cli(flags);
		blast_dcache(); blast_icache();
		__restore_flags(flags);
	}
}

/*
 * On architectures like the Sparc, we could get rid of lines in
 * the cache created only by a certain context, but on the MIPS
 * (and actually certain Sparc's) we cannot.
 */
static void mips64_flush_cache_mm_sc(struct mm_struct *mm)
{
	if(mm->context != 0) {
#ifdef DEBUG_CACHE
		printk("cmm[%d]", (int)mm->context);
#endif
		mips64_flush_cache_all_sc();
	}
}

static void mips64_flush_cache_mm_pc(struct mm_struct *mm)
{
	if(mm->context != 0) {
#ifdef DEBUG_CACHE
		printk("cmm[%d]", (int)mm->context);
#endif
		mips64_flush_cache_all_pc();
	}
}

static void mips64_flush_cache_page_sc(struct vm_area_struct *vma,
				    unsigned long page)
{
	struct mm_struct *mm = vma->vm_mm;
	unsigned long flags;
	pgd_t *pgdp;
	pmd_t *pmdp;
	pte_t *ptep;

	/*
	 * If ownes no valid ASID yet, cannot possibly have gotten
	 * this page into the cache.
	 */
	if (mm->context == 0)
		return;

#ifdef DEBUG_CACHE
	printk("cpage[%d,%08lx]", (int)mm->context, page);
#endif
	__save_and_cli(flags);
	page &= PAGE_MASK;
	pgdp = pgd_offset(mm, page);
	pmdp = pmd_offset(pgdp, page);
	ptep = pte_offset(pmdp, page);

	/*
	 * If the page isn't marked valid, the page cannot possibly be
	 * in the cache.
	 */
	if (!(pte_val(*ptep) & _PAGE_VALID))
		goto out;

	/*
	 * Doing flushes for another ASID than the current one is
	 * too difficult since R4k caches do a TLB translation
	 * for every cache flush operation.  So we do indexed flushes
	 * in that case, which doesn't overly flush the cache too much.
	 */
	if (mm->context != current->active_mm->context) {
		/*
		 * Do indexed flush, too much work to get the (possible)
		 * tlb refills to work correctly.
		 */
		page = (KSEG0 + (page & (scache_size - 1)));
		blast_dcache_page_indexed(page);
		blast_scache_page_indexed(page);
	} else
		blast_scache_page(page);
out:
	__restore_flags(flags);
}

static void mips64_flush_cache_page_pc(struct vm_area_struct *vma,
				    unsigned long page)
{
	struct mm_struct *mm = vma->vm_mm;
	unsigned long flags;
	pgd_t *pgdp;
	pmd_t *pmdp;
	pte_t *ptep;

	/*
	 * If ownes no valid ASID yet, cannot possibly have gotten
	 * this page into the cache.
	 */
	if (mm->context == 0)
		return;

#ifdef DEBUG_CACHE
	printk("cpage[%d,%08lx]", (int)mm->context, page);
#endif
	__save_and_cli(flags);
	page &= PAGE_MASK;
	pgdp = pgd_offset(mm, page);
	pmdp = pmd_offset(pgdp, page);
	ptep = pte_offset(pmdp, page);

	/*
	 * If the page isn't marked valid, the page cannot possibly be
	 * in the cache.
	 */
	if (!(pte_val(*ptep) & _PAGE_VALID))
		goto out;

	/*
	 * Doing flushes for another ASID than the current one is
	 * too difficult since Mips64 caches do a TLB translation
	 * for every cache flush operation.  So we do indexed flushes
	 * in that case, which doesn't overly flush the cache too much.
	 */
	if (mm == current->active_mm) {
		blast_dcache_page(page);
	} else {
		/* Do indexed flush, too much work to get the (possible)
		 * tlb refills to work correctly.
		 */
		page = (KSEG0 + (page & ((unsigned long)dcache_size - 1)));
		blast_dcache_page_indexed(page);
	}
out:
	__restore_flags(flags);
}

/* If the addresses passed to these routines are valid, they are
 * either:
 *
 * 1) In KSEG0, so we can do a direct flush of the page.
 * 2) In KSEG2, and since every process can translate those
 *    addresses all the time in kernel mode we can do a direct
 *    flush.
 * 3) In KSEG1, no flush necessary.
 */
static void mips64_flush_page_to_ram_sc(struct page *page)
{
	blast_scache_page((unsigned long)page_address(page));
}

static void mips64_flush_page_to_ram_pc(struct page *page)
{
	blast_dcache_page((unsigned long)page_address(page));
}

static void
mips64_flush_icache_page_s(struct vm_area_struct *vma, struct page *page)
{
	/*
	 * We did an scache flush therefore PI is already clean.
	 */
}

static void
mips64_flush_icache_range(unsigned long start, unsigned long end)
{
	flush_cache_all();
}

static void
mips64_flush_icache_page(struct vm_area_struct *vma, struct page *page)
{
	unsigned long address;

	if (!(vma->vm_flags & VM_EXEC))
		return;

	address = KSEG0 + ((unsigned long)page_address(page) & PAGE_MASK & ((unsigned long)dcache_size - 1));
	blast_icache_page_indexed(address);
}

/*
 * Writeback and invalidate the primary cache dcache before DMA.
 */
static void
mips64_dma_cache_wback_inv_pc(unsigned long addr, unsigned long size)
{
	unsigned long end, a;
	unsigned int flags;

	if (size >= (unsigned long)dcache_size) {
		flush_cache_all();
	} else {
	        __save_and_cli(flags);
		a = addr & ~(dc_lsize - 1);
		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
		while (1) {
			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
			if (a == end) break;
			a += dc_lsize;
		}
		__restore_flags(flags);
	}
	bc_wback_inv(addr, size);
}

static void
mips64_dma_cache_wback_inv_sc(unsigned long addr, unsigned long size)
{
	unsigned long end, a;

	if (size >= scache_size) {
		flush_cache_all();
		return;
	}

	a = addr & ~(sc_lsize - 1);
	end = (addr + size) & ~(sc_lsize - 1);
	while (1) {
		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
		if (a == end) break;
		a += sc_lsize;
	}
}

static void
mips64_dma_cache_inv_pc(unsigned long addr, unsigned long size)
{
	unsigned long end, a;
	unsigned int flags;

	if (size >= (unsigned long)dcache_size) {
		flush_cache_all();
	} else {
	        __save_and_cli(flags);
		a = addr & ~((unsigned long)dc_lsize - 1);
		end = (addr + size) & ~((unsigned long)dc_lsize - 1);
		while (1) {
			flush_dcache_line(a); /* Hit_Writeback_Inv_D */
			if (a == end) break;
			a += (unsigned long)dc_lsize;
		}
		__restore_flags(flags);
	}

	bc_inv(addr, size);
}

static void
mips64_dma_cache_inv_sc(unsigned long addr, unsigned long size)
{
	unsigned long end, a;

	if (size >= scache_size) {
		flush_cache_all();
		return;
	}

	a = addr & ~(sc_lsize - 1);
	end = (addr + size) & ~(sc_lsize - 1);
	while (1) {
		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
		if (a == end) break;
		a += sc_lsize;
	}
}

static void
mips64_dma_cache_wback(unsigned long addr, unsigned long size)
{
	panic("mips64_dma_cache called - should not happen.\n");
}

/*
 * While we're protected against bad userland addresses we don't care
 * very much about what happens in that case.  Usually a segmentation
 * fault will dump the process later on anyway ...
 */
static void mips64_flush_cache_sigtramp(unsigned long addr)
{
	protected_writeback_dcache_line(addr & ~(dc_lsize - 1));
	protected_flush_icache_line(addr & ~(ic_lsize - 1));
}

static void
mips64_flush_icache_all(void)
{
	if (mips_cpu.cputype == CPU_20KC) {
		blast_icache();
	}
}


/* Detect and size the various caches. */
static void __init probe_icache(unsigned long config)
{
        unsigned long config1;
	unsigned int lsize;

        if (!(config & (1 << 31))) {
	        /* 
		 * Not a MIPS64 complainant CPU. 
		 * Config 1 register not supported, we assume R4k style.
		 */
	        icache_size = 1 << (12 + ((config >> 9) & 7));
		ic_lsize = 16 << ((config >> 5) & 1);
		mips_cpu.icache.linesz = ic_lsize;
		
		/* 
		 * We cannot infer associativity - assume direct map
		 * unless probe template indicates otherwise
		 */
		if(!mips_cpu.icache.ways) mips_cpu.icache.ways = 1;
		mips_cpu.icache.sets = 
			(icache_size / ic_lsize) / mips_cpu.icache.ways;
	} else {
	       config1 = read_mips32_cp0_config1(); 

	       if ((lsize = ((config1 >> 19) & 7)))
		       mips_cpu.icache.linesz = 2 << lsize;
	       else 
		       mips_cpu.icache.linesz = lsize;
	       mips_cpu.icache.sets = 64 << ((config1 >> 22) & 7);
	       mips_cpu.icache.ways = 1 + ((config1 >> 16) & 7);

	       ic_lsize = mips_cpu.icache.linesz;
	       icache_size = mips_cpu.icache.sets * mips_cpu.icache.ways * 
		             ic_lsize;
	}
	printk("Primary instruction cache %dkb, linesize %d bytes (%d ways)\n",
	       icache_size >> 10, ic_lsize, mips_cpu.icache.ways);
}

static void __init probe_dcache(unsigned long config)
{
        unsigned long config1;
	unsigned int lsize;

        if (!(config & (1 << 31))) {
	        /* 
		 * Not a MIPS64 complainant CPU. 
		 * Config 1 register not supported, we assume R4k style.
		 */  
		dcache_size = 1 << (12 + ((config >> 6) & 7));
		dc_lsize = 16 << ((config >> 4) & 1);
		mips_cpu.dcache.linesz = dc_lsize;
		/* 
		 * We cannot infer associativity - assume direct map
		 * unless probe template indicates otherwise
		 */
		if(!mips_cpu.dcache.ways) mips_cpu.dcache.ways = 1;
		mips_cpu.dcache.sets = 
			(dcache_size / dc_lsize) / mips_cpu.dcache.ways;
	} else {
	        config1 = read_mips32_cp0_config1();

		if ((lsize = ((config1 >> 10) & 7)))
		        mips_cpu.dcache.linesz = 2 << lsize;
		else 
		        mips_cpu.dcache.linesz= lsize;
		mips_cpu.dcache.sets = 64 << ((config1 >> 13) & 7);
		mips_cpu.dcache.ways = 1 + ((config1 >> 7) & 7);

		dc_lsize = mips_cpu.dcache.linesz;
		dcache_size = 
			mips_cpu.dcache.sets * mips_cpu.dcache.ways
			* dc_lsize;
	}
	printk("Primary data cache %dkb, linesize %d bytes (%d ways)\n",
	       dcache_size >> 10, dc_lsize, mips_cpu.dcache.ways);
}


/* If you even _breathe_ on this function, look at the gcc output
 * and make sure it does not pop things on and off the stack for
 * the cache sizing loop that executes in KSEG1 space or else
 * you will crash and burn badly.  You have been warned.
 */
static int __init probe_scache(unsigned long config)
{
	extern unsigned long stext;
	unsigned long flags, addr, begin, end, pow2;
	int tmp;

	if (mips_cpu.scache.flags == MIPS_CACHE_NOT_PRESENT)
		return 0;

	tmp = ((config >> 17) & 1);
	if(tmp)
		return 0;
	tmp = ((config >> 22) & 3);
	switch(tmp) {
	case 0:
		sc_lsize = 16;
		break;
	case 1:
		sc_lsize = 32;
		break;
	case 2:
		sc_lsize = 64;
		break;
	case 3:
		sc_lsize = 128;
		break;
	}

	begin = (unsigned long) &stext;
	begin &= ~((4 * 1024 * 1024) - 1);
	end = begin + (4 * 1024 * 1024);

	/* This is such a bitch, you'd think they would make it
	 * easy to do this.  Away you daemons of stupidity!
	 */
	__save_and_cli(flags);

	/* Fill each size-multiple cache line with a valid tag. */
	pow2 = (64 * 1024);
	for(addr = begin; addr < end; addr = (begin + pow2)) {
		unsigned long *p = (unsigned long *) addr;
		__asm__ __volatile__("nop" : : "r" (*p)); /* whee... */
		pow2 <<= 1;
	}

	/* Load first line with zero (therefore invalid) tag. */
	set_taglo(0);
	set_taghi(0);
	__asm__ __volatile__("nop; nop; nop; nop;"); /* avoid the hazard */
	__asm__ __volatile__("\n\t.set noreorder\n\t"
			     "cache 8, (%0)\n\t"
			     ".set reorder\n\t" : : "r" (begin));
	__asm__ __volatile__("\n\t.set noreorder\n\t"
			     "cache 9, (%0)\n\t"
			     ".set reorder\n\t" : : "r" (begin));
	__asm__ __volatile__("\n\t.set noreorder\n\t"
			     "cache 11, (%0)\n\t"
			     ".set reorder\n\t" : : "r" (begin));

	/* Now search for the wrap around point. */
	pow2 = (128 * 1024);
	tmp = 0;
	for(addr = (begin + (128 * 1024)); addr < (end); addr = (begin + pow2)) {
		__asm__ __volatile__("\n\t.set noreorder\n\t"
				     "cache 7, (%0)\n\t"
				     ".set reorder\n\t" : : "r" (addr));
		__asm__ __volatile__("nop; nop; nop; nop;"); /* hazard... */
		if(!get_taglo())
			break;
		pow2 <<= 1;
	}
	__restore_flags(flags);
	addr -= begin;
	printk("Secondary cache sized at %dK linesize %d bytes.\n",
	       (int) (addr >> 10), sc_lsize);
	scache_size = addr;
	return 1;
}

static void __init setup_noscache_funcs(void)
{
	_clear_page = (void *)mips64_clear_page_dc;
	_copy_page = (void *)mips64_copy_page_dc;
	_flush_cache_all = mips64_flush_cache_all_pc;
	___flush_cache_all = mips64_flush_cache_all_pc;
	_flush_cache_mm = mips64_flush_cache_mm_pc;
	_flush_cache_range = mips64_flush_cache_range_pc;
	_flush_cache_page = mips64_flush_cache_page_pc;
	_flush_page_to_ram = mips64_flush_page_to_ram_pc;

	_flush_icache_page = mips64_flush_icache_page;

	_dma_cache_wback_inv = mips64_dma_cache_wback_inv_pc;
	_dma_cache_wback = mips64_dma_cache_wback;
	_dma_cache_inv = mips64_dma_cache_inv_pc;
}

static void __init setup_scache_funcs(void)
{
        _flush_cache_all = mips64_flush_cache_all_sc;
        ___flush_cache_all = mips64_flush_cache_all_sc;
	_flush_cache_mm = mips64_flush_cache_mm_sc;
	_flush_cache_range = mips64_flush_cache_range_sc;
	_flush_cache_page = mips64_flush_cache_page_sc;
	_flush_page_to_ram = mips64_flush_page_to_ram_sc;
	_clear_page = (void *)mips64_clear_page_sc;
	_copy_page = (void *)mips64_copy_page_sc;

	_flush_icache_page = mips64_flush_icache_page_s;

	_dma_cache_wback_inv = mips64_dma_cache_wback_inv_sc;
	_dma_cache_wback = mips64_dma_cache_wback;
	_dma_cache_inv = mips64_dma_cache_inv_sc;
}

typedef int (*probe_func_t)(unsigned long);

static inline void __init setup_scache(unsigned int config)
{
	probe_func_t probe_scache_kseg1;
	int sc_present = 0;

	/* Maybe the cpu knows about a l2 cache? */
	probe_scache_kseg1 = (probe_func_t) (KSEG1ADDR(&probe_scache));
	sc_present = probe_scache_kseg1(config);

	if (sc_present) {
	  	mips_cpu.scache.linesz = sc_lsize;
		/* 
		 * We cannot infer associativity - assume direct map
		 * unless probe template indicates otherwise
		 */
		if(!mips_cpu.scache.ways) mips_cpu.scache.ways = 1;
		mips_cpu.scache.sets = 
		  (scache_size / sc_lsize) / mips_cpu.scache.ways;

		setup_scache_funcs();
		return;
	}

	setup_noscache_funcs();
}

void __init ld_mmu_mips64(void)
{
	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);

#ifdef CONFIG_MIPS_UNCACHED
	change_cp0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
#else
	change_cp0_config(CONF_CM_CMASK, CONF_CM_CACHABLE_NONCOHERENT);
#endif

	probe_icache(config);
	probe_dcache(config);
	setup_scache(config);

	_flush_cache_sigtramp = mips64_flush_cache_sigtramp;
	_flush_icache_range = mips64_flush_icache_range;	/* Ouch */
	_flush_icache_all = mips64_flush_icache_all;
	_flush_cache_l1 = _flush_cache_all;
	_flush_cache_l2 = _flush_cache_all;

	__flush_cache_all();
}

--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15;
 name="pg-mips64.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pg-mips64.c"

/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
 *
 * This program is free software; you can distribute it and/or modify it
 * under the terms of the GNU General Public License (Version 2) as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * MIPS64 CPU variant specific Cache routines.
 * These routine are not optimized in any way, they are done in a generic way
 * so they can be used on all MIPS64 compliant CPUs, and also done in an 
 * attempt not to break anything for the R4xx0 style CPUs.
 */
#include <linux/sched.h>
#include <linux/mm.h>

#include <asm/bootinfo.h>
#include <asm/cacheops.h>
#include <asm/cpu.h>

extern int dc_lsize, ic_lsize, sc_lsize;

/*
 * Zero an entire page.
 */

void mips64_clear_page_dc(unsigned long page)
{
	unsigned long i;

        if (mips_cpu.options & MIPS_CPU_CACHE_CDEX)
	{
	        for (i=page; i<page+PAGE_SIZE; i+=dc_lsize)
		{
		        __asm__ __volatile__(
			        ".set\tnoreorder\n\t"
				".set\tnoat\n\t"
				"cache\t%2,(%0)\n\t"
				".set\tat\n\t"
				".set\treorder"
				:"=r" (i)
				:"0" (i),
				"I" (Create_Dirty_Excl_D));
		}
	}
	for (i=page; i<page+PAGE_SIZE; i+=sizeof(long))
	        *(unsigned long *)(i) = 0;
}

void mips64_clear_page_sc(unsigned long page)
{
	unsigned long i;

        if (mips_cpu.options & MIPS_CPU_CACHE_CDEX)
	{
	        for (i=page; i<page+PAGE_SIZE; i+=sc_lsize)
		{
		        __asm__ __volatile__(
				".set\tnoreorder\n\t"
				".set\tnoat\n\t"
				"cache\t%2,(%0)\n\t"
				".set\tat\n\t"
				".set\treorder"
				:"=r" (i)
				:"0" (i),
				"I" (Create_Dirty_Excl_SD));
		}
	}
	for (i=page; i<page+PAGE_SIZE; i+=sizeof(long))
	        *(unsigned long *)(i) = 0;
}

void mips64_copy_page_dc(unsigned long to, unsigned long from)
{
	unsigned long i;

        if (mips_cpu.options & MIPS_CPU_CACHE_CDEX)
	{
	        for (i=to; i<to+PAGE_SIZE; i+=dc_lsize)
		{
		        __asm__ __volatile__(
			        ".set\tnoreorder\n\t"
				".set\tnoat\n\t"
				"cache\t%2,(%0)\n\t"
				".set\tat\n\t"
				".set\treorder"
				:"=r" (i)
				:"0" (i),
				"I" (Create_Dirty_Excl_D));
		}
	}
	for (i=0; i<PAGE_SIZE; i+=sizeof(long))
	        *(unsigned long *)(to+i) = *(unsigned long *)(from+i);
}

void mips64_copy_page_sc(unsigned long to, unsigned long from)
{
	unsigned long i;

        if (mips_cpu.options & MIPS_CPU_CACHE_CDEX)
	{
	        for (i=to; i<to+PAGE_SIZE; i+=sc_lsize)
		{
		        __asm__ __volatile__(
				".set\tnoreorder\n\t"
				".set\tnoat\n\t"
				"cache\t%2,(%0)\n\t"
				".set\tat\n\t"
				".set\treorder"
				:"=r" (i)
				:"0" (i),
				"I" (Create_Dirty_Excl_SD));
		}
	}
	for (i=0; i<PAGE_SIZE; i+=sizeof(long))
	        *(unsigned long *)(to+i) = *(unsigned long *)(from+i);
}

--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15;
 name="tlb-r4k.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tlb-r4k.c"

/*
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
 *
 * This program is free software; you can distribute it and/or modify it
 * under the terms of the GNU General Public License (Version 2) as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * MIPS64 CPU variant specific MMU routines.
 * These routine are not optimized in any way, they are done in a generic way
 * so they can be used on all MIPS64 compliant CPUs, and also done in an 
 * attempt not to break anything for the R4xx0 style CPUs.
 */
#include <linux/init.h>
#include <linux/sched.h>
#include <linux/mm.h>

#include <asm/cpu.h>
#include <asm/bootinfo.h>
#include <asm/mmu_context.h>
#include <asm/pgtable.h>
#include <asm/system.h>

#undef DEBUG_TLB
#undef DEBUG_TLBUPDATE

/*extern char except_vec1_r4k;*/

/* CP0 hazard avoidance. */
#define BARRIER __asm__ __volatile__(".set noreorder\n\t" \
				     "nop; nop; nop; nop; nop; nop;\n\t" \
				     ".set reorder\n\t")

void local_flush_tlb_all(void)
{
	unsigned long flags;
	unsigned long old_ctx;
	int entry;

#ifdef DEBUG_TLB
	printk("[tlball]");
#endif

	__save_and_cli(flags);
	/* Save old context and create impossible VPN2 value */
	old_ctx = (get_entryhi() & 0xff);
	set_entryhi(KSEG0);
	set_entrylo0(0);
	set_entrylo1(0);
	BARRIER;

	entry = get_wired();

	/* Blast 'em all away. */
	while(entry < mips_cpu.tlbsize) {
	        /* Make sure all entries differ. */  
	        set_entryhi(KSEG0+entry*0x2000);
		set_index(entry);
		BARRIER;
		tlb_write_indexed();
		BARRIER;
		entry++;
	}
	BARRIER;
	set_entryhi(old_ctx);
	__restore_flags(flags);
}

void local_flush_tlb_mm(struct mm_struct *mm)
{
	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
		unsigned long flags;

#ifdef DEBUG_TLB
		printk("[tlbmm<%d>]", mm->context);
#endif
		__save_and_cli(flags);
		get_new_mmu_context(mm, smp_processor_id());
		if (mm == current->active_mm)
			set_entryhi(CPU_CONTEXT(smp_processor_id(), mm) & 
				    0xff);
		__restore_flags(flags);
	}
}

void local_flush_tlb_range(struct mm_struct *mm, unsigned long start,
				unsigned long end)
{
	if (CPU_CONTEXT(smp_processor_id(), mm) != 0) {
		unsigned long flags;
		int size;

#ifdef DEBUG_TLB
		printk("[tlbrange<%02x,%08lx,%08lx>]", (mm->context & 0xff),
		       start, end);
#endif
		__save_and_cli(flags);
		size = (end - start + (PAGE_SIZE - 1)) >> PAGE_SHIFT;
		size = (size + 1) >> 1;
		if(size <= mips_cpu.tlbsize/2) {
			int oldpid = (get_entryhi() & 0xff);
			int newpid = (CPU_CONTEXT(smp_processor_id(), mm) & 
				      0xff);

			start &= (PAGE_MASK << 1);
			end += ((PAGE_SIZE << 1) - 1);
			end &= (PAGE_MASK << 1);
			while(start < end) {
				int idx;

				set_entryhi(start | newpid);
				start += (PAGE_SIZE << 1);
				BARRIER;
				tlb_probe();
				BARRIER;
				idx = get_index();
				set_entrylo0(0);
				set_entrylo1(0);
				if(idx < 0)
					continue;
				/* Make sure all entries differ. */
				set_entryhi(KSEG0+idx*0x2000);
				BARRIER;
				tlb_write_indexed();
				BARRIER;
			}
			set_entryhi(oldpid);
		} else {
			get_new_mmu_context(mm, smp_processor_id());
			if (mm == current->active_mm)
				set_entryhi(CPU_CONTEXT(smp_processor_id(), 
							mm) & 0xff);
		}
		__restore_flags(flags);
	}
}

void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
{
	if (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) != 0) {
		unsigned long flags;
		unsigned long oldpid, newpid, idx;

#ifdef DEBUG_TLB
		printk("[tlbpage<%d,%08lx>]", vma->vm_mm->context, page);
#endif
		newpid = (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) & 0xff);
		page &= (PAGE_MASK << 1);
		__save_and_cli(flags);
		oldpid = (get_entryhi() & 0xff);
		set_entryhi(page | newpid);
		BARRIER;
		tlb_probe();
		BARRIER;
		idx = get_index();
		set_entrylo0(0);
		set_entrylo1(0);
		if(idx < 0)
			goto finish;
		/* Make sure all entries differ. */  
		set_entryhi(KSEG0+idx*0x2000);
		BARRIER;
		tlb_write_indexed();
	finish:
		BARRIER;
		set_entryhi(oldpid);
		__restore_flags(flags);
	}
}

/* 
 * Updates the TLB with the new pte(s).
 */
void mips64_update_mmu_cache(struct vm_area_struct * vma,
		      unsigned long address, pte_t pte)
{
	unsigned long flags;
	pgd_t *pgdp;
	pmd_t *pmdp;
	pte_t *ptep;
	int idx, pid;

	/*
	 * Handle debugger faulting in for debugee.
	 */
	if (current->active_mm != vma->vm_mm)
		return;

	pid = get_entryhi() & 0xff;

#ifdef DEBUG_TLB
	if((pid != (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) & 0xff)) ||
	   (CPU_CONTEXT(smp_processor_id(), vma->vm_mm) == 0)) {
		printk("update_mmu_cache: Wheee, bogus tlbpid mmpid=%d
			tlbpid=%d\n", (int) (CPU_CONTEXT(smp_processor_id(),
			vma->vm_mm) & 0xff), pid);
	}
#endif

	__save_and_cli(flags);
	address &= (PAGE_MASK << 1);
	set_entryhi(address | (pid));
	pgdp = pgd_offset(vma->vm_mm, address);
	BARRIER;
	tlb_probe();
	BARRIER;
	pmdp = pmd_offset(pgdp, address);
	idx = get_index();
	ptep = pte_offset(pmdp, address);
	BARRIER;
	set_entrylo0(pte_val(*ptep++) >> 6);
	set_entrylo1(pte_val(*ptep) >> 6);
	set_entryhi(address | (pid));
	BARRIER;
	if(idx < 0) {
		tlb_write_random();
	} else {
		tlb_write_indexed();
	}
	BARRIER;
	set_entryhi(pid);
	BARRIER;
	__restore_flags(flags);
}

void dump_mm_page(unsigned long addr)
{
	pgd_t	*page_dir, *pgd;
	pmd_t	*pmd;
	pte_t	*pte, page;
	unsigned long val;

	page_dir = pgd_offset(current->mm, 0);
	pgd = pgd_offset(current->mm, addr);
	pmd = pmd_offset(pgd, addr);
	pte = pte_offset(pmd, addr);
	page = *pte;
	printk("Memory Mapping: VA = %08x, PA = %08x ", addr, (unsigned int) pte_val(page));
	val = pte_val(page);
	if (val & _PAGE_PRESENT) printk("present ");
	if (val & _PAGE_READ) printk("read ");
	if (val & _PAGE_WRITE) printk("write ");
	if (val & _PAGE_ACCESSED) printk("accessed ");
	if (val & _PAGE_MODIFIED) printk("modified ");
	if (val & _PAGE_R4KBUG) printk("r4kbug ");
	if (val & _PAGE_GLOBAL) printk("global ");
	if (val & _PAGE_VALID) printk("valid ");
	printk("\n");
}

void show_tlb(void)
{
        unsigned int flags;
        unsigned int old_ctx;
	unsigned int entry;
	unsigned int entrylo0, entrylo1, entryhi;

	__save_and_cli(flags);

	/* Save old context */
	old_ctx = (get_entryhi() & 0xff);

	printk("TLB content:\n");
	entry = 0;
	while(entry < mips_cpu.tlbsize) {
		set_index(entry);
		BARRIER;
		tlb_read();
		BARRIER;
		entryhi = get_entryhi();
		entrylo0 = get_entrylo0();
		entrylo1 = get_entrylo1();
		printk("%02d: ASID=%02d%s VA=0x%08x ", entry, entryhi & ASID_MASK, (entrylo0 & entrylo1 & 1) ? "(G)" : "   ", entryhi & ~ASID_MASK);
		printk("PA0=0x%08x C0=%x %s%s%s\n", (entrylo0>>6)<<12, (entrylo0>>3) & 7, (entrylo0 & 4) ? "Dirty " : "", (entrylo0 & 2) ? "Valid " : "Invalid ", (entrylo0 & 1) ? "Global" : ""); 
		printk("\t\t\t     PA1=0x%08x C1=%x %s%s%s\n", (entrylo1>>6)<<12, (entrylo1>>3) & 7, (entrylo1 & 4) ? "Dirty " : "", (entrylo1 & 2) ? "Valid " : "Invalid ", (entrylo1 & 1) ? "Global" : ""); 

		dump_mm_page(entryhi & ~0xff);
		dump_mm_page((entryhi & ~0xff) | 0x1000);
		entry++;
	}
	BARRIER;
	set_entryhi(old_ctx);

	__restore_flags(flags);
}

void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
				      unsigned long entryhi, unsigned long pagemask)
{
        unsigned long flags;
        unsigned long wired;
        unsigned long old_pagemask;
        unsigned long old_ctx;

        __save_and_cli(flags);
        /* Save old context and create impossible VPN2 value */
        old_ctx = (get_entryhi() & 0xff);
        old_pagemask = get_pagemask();
        wired = get_wired();
        set_wired (wired + 1);
        set_index (wired);
        BARRIER;    
        set_pagemask (pagemask);
        set_entryhi(entryhi);
        set_entrylo0(entrylo0);
        set_entrylo1(entrylo1);
        BARRIER;    
        tlb_write_indexed();
        BARRIER;    
    
        set_entryhi(old_ctx);
        BARRIER;    
        set_pagemask (old_pagemask);
        local_flush_tlb_all();    
        __restore_flags(flags);
}

/*
 * Used for loading TLB entries before trap_init() has started, when we
 * don't actually want to add a wired entry which remains throughout the
 * lifetime of the system
 */

static int temp_tlb_entry __initdata;

__init int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
			       unsigned long entryhi, unsigned long pagemask)
{
	int ret = 0;
	unsigned long flags;
	unsigned long wired;
	unsigned long old_pagemask;
	unsigned long old_ctx;

	__save_and_cli(flags);
	/* Save old context and create impossible VPN2 value */
	old_ctx = get_entryhi() & 0xff;
	old_pagemask = get_pagemask();
	wired = get_wired();
	if (--temp_tlb_entry < wired) {
		printk(KERN_WARNING "No TLB space left for add_temporary_entry\n");
		ret = -ENOSPC;
		goto out;
	}

	set_index(temp_tlb_entry);
	BARRIER;    
	set_pagemask(pagemask);
	set_entryhi(entryhi);
	set_entrylo0(entrylo0);
	set_entrylo1(entrylo1);
	BARRIER;    
	tlb_write_indexed();
	BARRIER;    
    
	set_entryhi(old_ctx);
	BARRIER;    
	set_pagemask(old_pagemask);
out:
	__restore_flags(flags);
	return ret;
}

static void __init probe_tlb(unsigned long config)
{
        unsigned long config1;

        if (!(config & (1 << 31))) {
	        /* 
		 * Not a MIPS64 complainant CPU. 
		 * Config 1 register not supported, we assume R4k style.
		 */  
	        mips_cpu.tlbsize = 48;
	} else {
	        config1 = read_mips32_cp0_config1();
		if (!((config >> 7) & 3))
		        panic("No MMU present");
		else
		        mips_cpu.tlbsize = ((config1 >> 25) & 0x3f) + 1;
	}	

	printk("Number of TLB entries %d.\n", mips_cpu.tlbsize);
}

void __init r4k_tlb_init(void)
{
	unsigned long config = read_32bit_cp0_register(CP0_CONFIG);

	probe_tlb(config);
	_update_mmu_cache = mips64_update_mmu_cache;
	set_pagemask(PM_4K);
	write_32bit_cp0_register(CP0_WIRED, 0);
	temp_tlb_entry = mips_cpu.tlbsize - 1;
	local_flush_tlb_all();

/*	memcpy((void *)(KSEG0 + 0x80), &except_vec1_r4k, 0x80);*/
	flush_icache_range(KSEG0, KSEG0 + 0x80);
}

--------------6A228B530B40164C0D9211A7
Content-Type: text/plain; charset=iso-8859-15;
 name="mips64_cache.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mips64_cache.h"

/*
 * mips64_cache.h
 *
 * Carsten Langgaard, carstenl@mips.com
 * Copyright (C) 2002 MIPS Technologies, Inc.  All rights reserved.
 *
 * ########################################################################
 *
 *  This program is free software; you can distribute it and/or modify it
 *  under the terms of the GNU General Public License (Version 2) as
 *  published by the Free Software Foundation.
 *
 *  This program is distributed in the hope it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  59 Temple Place - Suite 330, Boston MA 02111-1307, USA.
 *
 * ########################################################################
 *
 * Inline assembly cache operations.
 * 
 * This file is the original r4cache.c file with modification that makes the
 * cache handling more generic.
 *
 * FIXME: Handle split L2 caches.
 *
 */
#ifndef _MIPS_MIPS64_CACHE_H
#define _MIPS_MIPS64_CACHE_H

#include <asm/asm.h>
#include <asm/cacheops.h>

static inline void flush_icache_line_indexed(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Index_Invalidate_I));
}

static inline void flush_dcache_line_indexed(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Index_Writeback_Inv_D));
}

static inline void flush_scache_line_indexed(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Index_Writeback_Inv_SD));
}

static inline void flush_icache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_I));
}

static inline void flush_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Writeback_Inv_D));
}

static inline void invalidate_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_D));
}

static inline void invalidate_scache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Invalidate_SD));
}

static inline void flush_scache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"cache %1, (%0)\n\t"
		".set reorder"
		:
		: "r" (addr),
		  "i" (Hit_Writeback_Inv_SD));
}

/*
 * The next two are for badland addresses like signal trampolines.
 */
static inline void protected_flush_icache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"1:\tcache %1,(%0)\n"
		"2:\t.set reorder\n\t"
		".section\t__ex_table,\"a\"\n\t"
		".dword\t1b,2b\n\t"
		".previous"
		:
		: "r" (addr), "i" (Hit_Invalidate_I));
}

static inline void protected_writeback_dcache_line(unsigned long addr)
{
	__asm__ __volatile__(
		".set noreorder\n\t"
		"1:\tcache %1,(%0)\n"
		"2:\t.set reorder\n\t"
		".section\t__ex_table,\"a\"\n\t"
		".dword\t1b,2b\n\t"
		".previous"
		:
		: "r" (addr), "i" (Hit_Writeback_D));
}

#define cache_unroll(base,op)			\
	__asm__ __volatile__("			\
		.set noreorder;			\
		cache %1, (%0);			\
		.set reorder"			\
		:				\
		: "r" (base),			\
		  "i" (op));


static inline void blast_dcache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = (start + dcache_size);

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_D);
		start += dc_lsize;
	}
}

static inline void blast_dcache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Hit_Writeback_Inv_D);
		start += dc_lsize;
	}
}

static inline void blast_dcache_page_indexed(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_D);
		start += dc_lsize;
	}
}

static inline void blast_icache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = (start + icache_size);

	while(start < end) {
		cache_unroll(start,Index_Invalidate_I);
		start += ic_lsize;
	}
}

static inline void blast_icache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Hit_Invalidate_I);
		start += ic_lsize;
	}
}

static inline void blast_icache_page_indexed(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = (start + PAGE_SIZE);

	while(start < end) {
		cache_unroll(start,Index_Invalidate_I);
		start += ic_lsize;
	}
}

static inline void blast_scache(void)
{
	unsigned long start = KSEG0;
	unsigned long end = KSEG0 + scache_size;

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_SD);
		start += sc_lsize;
	}
}

static inline void blast_scache_page(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = page + PAGE_SIZE;

	while(start < end) {
		cache_unroll(start,Hit_Writeback_Inv_SD);
		start += sc_lsize;
	}
}

static inline void blast_scache_page_indexed(unsigned long page)
{
	unsigned long start = page;
	unsigned long end = page + PAGE_SIZE;

	while(start < end) {
		cache_unroll(start,Index_Writeback_Inv_SD);
		start += sc_lsize;
	}
}

#endif /* !(_MIPS_MIPS64_CACHE_H) */



--------------6A228B530B40164C0D9211A7--
