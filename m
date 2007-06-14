Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 22:57:04 +0100 (BST)
Received: from father.pmc-sierra.com ([216.241.224.13]:39041 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20022896AbXFNV4k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 22:56:40 +0100
Received: (qmail 29251 invoked by uid 101); 14 Jun 2007 21:55:33 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 14 Jun 2007 21:55:33 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l5ELtWkO003671;
	Thu, 14 Jun 2007 14:55:32 -0700
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l5ELtVY4021526;
	Thu, 14 Jun 2007 15:55:31 -0600
Date:	Thu, 14 Jun 2007 15:55:31 -0600
Message-Id: <200706142155.l5ELtVY4021526@pasqua.pmc-sierra.bc.ca>
To:	ralf@linux-mips.org
Subject: [PATCH 2/12] mips: PMC MSP71xx mips common
Cc:	linux-mips@linux-mips.org
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15410
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

[PATCH 2/12] mips: PMC MSP71xx mips common

Patch to add mips common support for the PMC-Sierra
MSP71xx devices.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---
Re-posting patch as requested by Ralf. Changes since last post:
-Minor cleanups as recommended by checkpatch.pl.

 arch/mips/Kconfig            |   84 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/Makefile           |   11 +++++
 arch/mips/kernel/cpu-probe.c |   20 ++++++++++
 arch/mips/kernel/head.S      |    5 ++
 arch/mips/kernel/traps.c     |    6 +++
 include/asm-mips/bootinfo.h  |   12 ++++++
 include/asm-mips/cpu.h       |    2 +
 include/asm-mips/mipsregs.h  |   33 ++++++++++++++++
 include/asm-mips/war.h       |   11 +++++
 9 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c78b143..8330db3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -360,6 +360,7 @@ config MIPS_SIM
 	select DMA_NONCOHERENT
 	select SYS_HAS_EARLY_PRINTK
 	select IRQ_CPU
+	select BOOT_RAW
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_HAS_EARLY_PRINTK
@@ -507,6 +508,27 @@ config MACH_VR41XX
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
+config PMC_MSP
+	bool "PMC-Sierra MSP chipsets"
+	depends on EXPERIMENTAL
+	select DMA_NONCOHERENT
+	select SWAP_IO_SPACE
+	select NO_EXCEPT_FILL
+	select BOOT_RAW
+	select SYS_HAS_CPU_MIPS32_R1
+	select SYS_HAS_CPU_MIPS32_R2
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+	select SYS_SUPPORTS_KGDB
+	select IRQ_CPU
+	select SERIAL_8250
+	select SERIAL_8250_CONSOLE
+	help
+	  This adds support for the PMC-Sierra family of Multi-Service
+	  Processor System-On-A-Chips.  These parts include a number
+	  of integrated peripherals, interfaces and DSPs in addition to
+	  a variety of MIPS cores.
+
 config PMC_YOSEMITE
 	bool "PMC-Sierra Yosemite eval board"
 	select DMA_COHERENT
@@ -823,6 +845,55 @@ config TOSHIBA_RBTX4938
 
 endchoice
 
+choice
+	prompt "PMC-Sierra MSP SOC type"
+	depends on PMC_MSP
+
+config PMC_MSP4200_EVAL
+	bool "PMC-Sierra MSP4200 Eval Board"
+	select IRQ_MSP_SLP
+	select HW_HAS_PCI
+
+config PMC_MSP4200_GW
+	bool "PMC-Sierra MSP4200 VoIP Gateway"
+	select IRQ_MSP_SLP
+	select HW_HAS_PCI
+
+config PMC_MSP7120_EVAL
+	bool "PMC-Sierra MSP7120 Eval Board"
+	select SYS_SUPPORTS_MULTITHREADING
+	select IRQ_MSP_CIC
+	select HW_HAS_PCI
+	select USB_MSP71XX
+
+config PMC_MSP7120_GW
+	bool "PMC-Sierra MSP7120 Residential Gateway"
+	select SYS_SUPPORTS_MULTITHREADING
+	select IRQ_MSP_CIC
+	select HW_HAS_PCI
+	select USB_MSP71XX
+
+config PMC_MSP7120_FPGA
+	bool "PMC-Sierra MSP7120 FPGA"
+	select SYS_SUPPORTS_MULTITHREADING
+	select IRQ_MSP_CIC
+	select HW_HAS_PCI
+	select USB_MSP71XX
+
+endchoice
+
+menu "Options for PMC-Sierra MSP chipsets"
+	depends on PMC_MSP
+
+config PMC_MSP_EMBEDDED_ROOTFS
+	bool "Root filesystem embedded in kernel image"
+	select MTD
+	select MTD_BLOCK
+	select MTD_PMC_MSP_RAMROOT
+	select MTD_RAM
+
+endmenu
+
 source "arch/mips/ddb5xxx/Kconfig"
 source "arch/mips/gt64120/ev64120/Kconfig"
 source "arch/mips/jazz/Kconfig"
@@ -886,6 +957,9 @@ config ARC
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
+config BOOT_RAW
+	bool
+
 config DMA_COHERENT
 	bool
 
@@ -945,6 +1019,9 @@ config MIPS_DISABLE_OBSOLETE_IDE
 
 config GENERIC_ISA_DMA_SUPPORT_BROKEN
 	bool
+	
+config NO_EXCEPT_FILL
+	bool
 
 #
 # Endianess selection.  Sufficiently obscure so many users don't know what to
@@ -992,6 +1069,12 @@ config IRQ_CPU_RM9K
 config IRQ_MV64340
 	bool
 
+config IRQ_MSP_SLP
+	bool
+
+config IRQ_MSP_CIC
+	bool
+
 config DDB5XXX_COMMON
 	bool
 	select SYS_SUPPORTS_KGDB
@@ -1108,6 +1191,7 @@ config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || SNI_RM
 	default "7" if SGI_IP27
+	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
 config HAVE_STD_PC_SERIAL_PORT
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92bca6a..1c38332 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -360,6 +360,14 @@ core-$(CONFIG_MOMENCO_OCELOT_C)	+= arch/mips/momentum/ocelot_c/
 load-$(CONFIG_MOMENCO_OCELOT_C)	+= 0xffffffff80100000
 
 #
+# PMC-Sierra MSP SOCs
+#
+core-$(CONFIG_PMC_MSP)		+= arch/mips/pmc-sierra/msp71xx/
+cflags-$(CONFIG_PMC_MSP)	+= -Iinclude/asm-mips/pmc-sierra/msp71xx \
+					-mno-branch-likely
+load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
+
+#
 # PMC-Sierra Yosemite
 #
 core-$(CONFIG_PMC_YOSEMITE)	+= arch/mips/pmc-sierra/yosemite/
@@ -619,7 +627,8 @@ JIFFIES			= jiffies_64
 endif
 
 AFLAGS		+= $(cflags-y)
-CFLAGS		+= $(cflags-y)
+CFLAGS		+= $(cflags-y) \
+			-D"VMLINUX_LOAD_ADDRESS=$(load-y)"
 
 LDFLAGS			+= -m $(ld-emul)
 
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ab755ea..ce8c9c7 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -165,9 +165,29 @@ static inline void check_wait(void)
 	}
 }
 
+static inline void check_errata(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	switch (c->cputype) {
+	case CPU_34K:
+		/*
+		 * Erratum "RPS May Cause Incorrect Instruction Execution"
+		 * This code only handles VPE0, any SMP/SMTC/RTOS code
+		 * making use of VPE1 will be responsable for that VPE.
+		 */
+		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
+			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
+		break;
+	default:
+		break;
+	}
+}
+
 void __init check_bugs32(void)
 {
 	check_wait();
+	check_errata();
 }
 
 /*
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 6f57ca4..27366f6 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 
+#include <asm/addrspace.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/irqflags.h>
@@ -129,16 +130,18 @@
 #endif
 	.endm
 
+#ifndef CONFIG_NO_EXCEPT_FILL
 	/*
 	 * Reserved space for exception handlers.
 	 * Necessary for machines which link their kernels at KSEG0.
 	 */
 	.fill	0x400
+#endif
 
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
 
-#ifdef CONFIG_MIPS_SIM
+#ifdef CONFIG_BOOT_RAW
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.  This is needed because this platform does
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 493cb29..0086afc 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -70,6 +70,7 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
+void (*board_watchpoint_handler)(struct pt_regs *regs);
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -835,6 +836,11 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 
 asmlinkage void do_watch(struct pt_regs *regs)
 {
+	if (board_watchpoint_handler) {
+		(*board_watchpoint_handler)(regs);
+		return;
+	}
+	
 	/*
 	 * We use the watch exception where available to detect stack
 	 * overflows.
diff --git a/include/asm-mips/bootinfo.h b/include/asm-mips/bootinfo.h
index c7c945b..0f818b3 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -213,6 +213,18 @@
 #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
+/*
+ * Valid machtype for group PMC-MSP
+ */
+#define MACH_GROUP_MSP         26	/* PMC-Sierra MSP boards/CPUs    */
+#define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation */
+#define MACH_MSP4200_GW         1	/* PMC-Sierra MSP4200 Gateway demo */
+#define MACH_MSP4200_FPGA       2	/* PMC-Sierra MSP4200 Emulation */
+#define MACH_MSP7120_EVAL       3	/* PMC-Sierra MSP7120 Evaluation */
+#define MACH_MSP7120_GW         4	/* PMC-Sierra MSP7120 Residential GW */
+#define MACH_MSP7120_FPGA       5	/* PMC-Sierra MSP7120 Emulation */
+#define MACH_MSP_OTHER        255	/* PMC-Sierra unknown board type */
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
diff --git a/include/asm-mips/cpu.h b/include/asm-mips/cpu.h
index d38fdbf..9415dc2 100644
--- a/include/asm-mips/cpu.h
+++ b/include/asm-mips/cpu.h
@@ -107,6 +107,7 @@
  * Definitions for 7:0 on legacy processors
  */
 
+#define PRID_REV_MASK		0x00ff
 
 #define PRID_REV_TX4927		0x0022
 #define PRID_REV_TX4937		0x0030
@@ -123,6 +124,7 @@
 #define PRID_REV_VR4122		0x0070
 #define PRID_REV_VR4181A	0x0070	/* Same as VR4122 */
 #define PRID_REV_VR4130		0x0080
+#define PRID_REV_34K_V1_0_2	0x0022
 
 /*
  * FPU implementation/revision register (CP1 control register 0).
diff --git a/include/asm-mips/mipsregs.h b/include/asm-mips/mipsregs.h
index 9985cb7..eabbdf5 100644
--- a/include/asm-mips/mipsregs.h
+++ b/include/asm-mips/mipsregs.h
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 #include <asm/hazards.h>
+#include <asm/war.h>
 
 /*
  * The following macros are especially useful for __asm__
@@ -534,6 +535,9 @@
 #define MIPS_CONF3_LPA		(_ULCAST_(1) <<  7)
 #define MIPS_CONF3_DSP		(_ULCAST_(1) << 10)
 
+#define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+
+
 /*
  * Bits in the MIPS32/64 coprocessor 1 (FPU) revision register.
  */
@@ -1292,10 +1296,39 @@ static inline void tlb_probe(void)
 
 static inline void tlb_read(void)
 {
+#if MIPS34K_MISSED_ITLB_WAR
+	int res = 0;
+
+	__asm__ __volatile__(
+	"	.set	push					\n"
+	"	.set	noreorder				\n"
+	"	.set	noat					\n"
+	"	.set	mips32r2				\n"
+	"	.word	0x41610001		# dvpe $1	\n"
+	"	move	%0, $1					\n"
+	"	ehb						\n"
+	"	.set	pop					\n"
+	: "=r" (res));
+
+	instruction_hazard();
+#endif
+
 	__asm__ __volatile__(
 		".set noreorder\n\t"
 		"tlbr\n\t"
 		".set reorder");
+
+#if MIPS34K_MISSED_ITLB_WAR
+	if ((res & _ULCAST_(1)))
+		__asm__ __volatile__(
+		"	.set	push				\n"
+		"	.set	noreorder			\n"
+		"	.set	noat				\n"
+		"	.set	mips32r2			\n"
+		"	.word	0x41600021	# evpe		\n"
+		"	ehb					\n"
+		"	.set	pop				\n");
+#endif
 }
 
 static inline void tlb_write_indexed(void)
diff --git a/include/asm-mips/war.h b/include/asm-mips/war.h
index 13a3502..74c08e6 100644
--- a/include/asm-mips/war.h
+++ b/include/asm-mips/war.h
@@ -196,6 +196,14 @@
 #endif
 
 /*
+ * 34K core erratum: "Problems Executing the TLBR Instruction"
+ */
+#if defined(CONFIG_PMC_MSP7120_EVAL) || defined(CONFIG_PMC_MSP7120_GW) || \
+	defined(CONFIG_PMC_MSP7120_FPGA)
+#define MIPS34K_MISSED_ITLB_WAR		1
+#endif
+
+/*
  * Workarounds default to off
  */
 #ifndef ICACHE_REFILLS_WORKAROUND_WAR
@@ -234,5 +242,8 @@
 #ifndef R10000_LLSC_WAR
 #define R10000_LLSC_WAR			0
 #endif
+#ifndef MIPS34K_MISSED_ITLB_WAR
+#define MIPS34K_MISSED_ITLB_WAR		0
+#endif
 
 #endif /* _ASM_WAR_H */
