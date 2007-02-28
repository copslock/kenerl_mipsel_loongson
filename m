Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 00:05:28 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:7887 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039226AbXB1AFX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 00:05:23 +0000
Received: (qmail 10188 invoked by uid 101); 28 Feb 2007 00:04:11 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by father.pmc-sierra.com with SMTP; 28 Feb 2007 00:04:11 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1S04AgZ020191
	for <linux-mips@linux-mips.org>; Tue, 27 Feb 2007 16:04:10 -0800
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l1S04AtY016247
	for linux-mips@linux-mips.org; Tue, 27 Feb 2007 18:04:10 -0600
Date:	Tue, 27 Feb 2007 18:04:10 -0600
Message-Id: <200702280004.l1S04AtY016247@pasqua.pmc-sierra.bc.ca>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/5] mips: PMC MSP71xx mips common
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stjeanma@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

[PATCH 2/5] mips: PMC MSP71xx mips common

Patch to add mips common support for the PMC-Sierra
MSP71xx devices.

These 5 patches along with the previously posted serial patch
will boot the PMC-Sierra MSP7120 Residential Gateway board.

Thanks,
Marc

Signed-off-by: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
---
Re-posting patch with three recommended changes:
1. Added CONFIG_BOOT_RAW and selected in MIPS_SIM and PMC_MSP
to allow jumping to the kernel_entry at start of text.
(arch/mips/Kconfig, arch/mips/kernel/head.S)

2. Defined a VMLINUX_LOAD_ADDRESS flag to eliminate the .fill
for exception handlers.
(arch/mips/Makefile, arch/mips/kernel/head.S)

3. Changed MACH_GROUP_MSP from 23 to 26 follow last entry.
(include/asm-mips/bootinfo.h)

 arch/mips/Kconfig           |   83 +++++++++++++++++++++
 arch/mips/Makefile          |   11 ++
 arch/mips/kernel/head.S     |    4 -
 arch/mips/kernel/traps.c    |    6 +
 include/asm-mips/bootinfo.h |   12 +++
 include/asm-mips/mipsregs.h |   30 +++++++
 include/asm-mips/regops.h   |  168 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/war.h      |   11 ++
 8 files changed, 323 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5da6b0d..b9f0286 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -354,6 +354,7 @@ config MIPS_SIM
 	bool 'MIPS simulator (MIPSsim)'
 	select DMA_NONCOHERENT
 	select IRQ_CPU
+	select BOOT_RAW
 	select SYS_HAS_CPU_MIPS32_R1
 	select SYS_HAS_CPU_MIPS32_R2
 	select SYS_SUPPORTS_32BIT_KERNEL
@@ -504,6 +505,26 @@ config MACH_VR41XX
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
+config PMC_MSP
+	bool "PMC-Sierra MSP chipsets"
+	depends on EXPERIMENTAL
+	select DMA_NONCOHERENT
+	select SWAP_IO_SPACE
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
@@ -815,6 +836,55 @@ config TOSHIBA_RBTX4938
 
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
+	select MSP_USB
+
+config PMC_MSP7120_GW
+	bool "PMC-Sierra MSP7120 Residential Gateway"
+	select SYS_SUPPORTS_MULTITHREADING
+	select IRQ_MSP_CIC
+	select HW_HAS_PCI
+	select MSP_USB
+
+config PMC_MSP7120_FPGA
+	bool "PMC-Sierra MSP7120 FPGA"
+	select SYS_SUPPORTS_MULTITHREADING
+	select IRQ_MSP_CIC
+	select HW_HAS_PCI
+	select MSP_USB
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
@@ -879,6 +949,9 @@ config ARC
 config ARCH_MAY_HAVE_PC_FDC
 	bool
 
+config BOOT_RAW
+	bool
+
 config DMA_COHERENT
 	bool
 
@@ -971,6 +1044,15 @@ config IRQ_CPU_RM9K
 config IRQ_MV64340
 	bool
 
+config IRQ_MSP_SLP
+	bool
+
+config IRQ_MSP_CIC
+	bool
+
+config MSP_USB
+	bool
+
 config DDB5XXX_COMMON
 	bool
 	select SYS_SUPPORTS_KGDB
@@ -1086,6 +1168,7 @@ config MIPS_L1_CACHE_SHIFT
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
 
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 6f57ca4..b73cf67 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -129,16 +129,18 @@
 #endif
 	.endm
 
+#if VMLINUX_LOAD_ADDRESS == 0xffffffff80000000
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
index 18f56a9..2c812c2 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -70,6 +70,7 @@ extern asmlinkage void handle_reserved(void);
 extern int fpu_emulator_cop1Handler(struct pt_regs *xcp,
 	struct mips_fpu_struct *ctx, int has_fpu);
 
+void (*board_watchpoint_handler)(struct pt_regs *regs);
 void (*board_be_init)(void);
 int (*board_be_handler)(struct pt_regs *regs, int is_fixup);
 void (*board_nmi_handler_setup)(void);
@@ -860,6 +861,11 @@ asmlinkage void do_mdmx(struct pt_regs *regs)
 
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
index c7c945b..7fc52c7 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -213,6 +213,18 @@
 #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
+/*
+ * Valid machtype for group PMC-MSP
+ */
+#define MACH_GROUP_MSP         26	/* PMC-Sierra MSP boards/CPUs    */
+#define MACH_MSP4200_EVAL       0	/* PMC-Sierra MSP4200 Evaluation board */
+#define MACH_MSP4200_GW         1	/* PMC-Sierra MSP4200 Gateway demo board */
+#define MACH_MSP4200_FPGA       2	/* PMC-Sierra MSP4200 Emulation board */
+#define MACH_MSP7120_EVAL       3	/* PMC-Sierra MSP7120 Evaluation board */
+#define MACH_MSP7120_GW         4	/* PMC-Sierra MSP7120 Residential Gateway board */
+#define MACH_MSP7120_FPGA       5	/* PMC-Sierra MSP7120 Emulation board */
+#define MACH_MSP_OTHER        255	/* PMC-Sierra unknown board type */
+
 #define CL_SIZE			COMMAND_LINE_SIZE
 
 const char *get_system_type(void);
diff --git a/include/asm-mips/mipsregs.h b/include/asm-mips/mipsregs.h
index 9985cb7..bd683b6 100644
--- a/include/asm-mips/mipsregs.h
+++ b/include/asm-mips/mipsregs.h
@@ -15,6 +15,7 @@
 
 #include <linux/linkage.h>
 #include <asm/hazards.h>
+#include <asm/war.h>
 
 /*
  * The following macros are especially useful for __asm__
@@ -1292,10 +1293,39 @@ static inline void tlb_probe(void)
 
 static inline void tlb_read(void)
 {
+#if MIPS34K_MISSED_ITLB_WAR
+	int res = 0;
+
+	__asm__ __volatile__(
+	"	.set	push						\n"
+	"	.set	noreorder					\n"
+	"	.set	noat						\n"
+	"	.set	mips32r2					\n"
+	"	.word	0x41610001		# dvpe $1		\n"
+	"	move	%0, $1						\n"
+	"	ehb							\n"
+	"	.set	pop						\n"
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
+		"	.set	push						\n"
+		"	.set	noreorder					\n"
+		"	.set	noat						\n"
+		"	.set	mips32r2					\n"
+		"	.word	0x41600021		# evpe			\n"
+		"	ehb							\n"
+		"	.set	pop						\n");
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
diff --git a/include/asm-mips/regops.h b/include/asm-mips/regops.h
new file mode 100644
index 0000000..fbfc940
--- /dev/null
+++ b/include/asm-mips/regops.h
@@ -0,0 +1,168 @@
+/*
+ * $Id: regops.h,v 1.2 2006/05/08 22:00:34 ramsayji Exp $
+ *
+ * VPE/SMP-safe functions to access registers.  They use ll/sc instructions, so
+ * it is your responsibility to ensure these are available on your platform
+ * before including this file.
+ *
+ * In addition, there is a bug on the R10000 chips which has a workaround.  If
+ * you are affected by this bug, make sure to define the symbol
+ * 'R10000_LLSC_WAR' to be non-zero.  If you are using this header from within
+ * linux, you may include <asm/war.h> before including this file to have this
+ * defined appropriately for you.
+ *
+ * Copyright 2005 PMC-Sierra, Inc.
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
+ *  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF USE,
+ *  DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc., 675
+ *  Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_REGOPS_H__
+#define __ASM_REGOPS_H__
+
+#ifndef R10000_LLSC_WAR
+#define R10000_LLSC_WAR 0
+#endif
+
+#if R10000_LLSC_WAR == 1
+#define __beqz	"beqzl	"
+#else
+#define __beqz	"beqz	"
+#endif
+
+#ifndef _LINUX_TYPES_H
+typedef unsigned int uint32_t;
+#endif
+
+/*
+ * Sets all the masked bits to the corresponding value bits
+ */
+static inline void set_value_reg32( volatile uint32_t * const addr,
+					uint32_t const mask,
+					uint32_t const value )
+{
+	uint32_t temp;
+
+	__asm__ __volatile__(
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1	# set_value_reg32	\n"
+	"	and	%0, %2				\n"
+	"	or	%0, %3				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	.set	mips0				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (~mask), "ir" (value), "m" (*addr) );
+}
+
+/*
+ * Sets all the masked bits to '1'
+ */
+static inline void set_reg32( volatile uint32_t * const addr,
+				uint32_t const mask )
+{
+	uint32_t temp;
+
+	__asm__ __volatile__(
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# set_reg32	\n"
+	"	or	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	.set	mips0				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (mask), "m" (*addr) );
+}
+
+/*
+ * Sets all the masked bits to '0'
+ */
+static inline void clear_reg32( volatile uint32_t * const addr,
+				uint32_t const mask )
+{
+	uint32_t temp;
+
+	__asm__ __volatile__(
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# clear_reg32	\n"
+	"	and	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	.set	mips0				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (~mask), "m" (*addr) );
+}
+
+/*
+ * Toggles all masked bits from '0' to '1' and '1' to '0'
+ */
+static inline void toggle_reg32( volatile uint32_t * const addr,
+				uint32_t const mask )
+{
+	uint32_t temp;
+
+	__asm__ __volatile__(
+	"	.set	mips3				\n"
+	"1:	ll	%0, %1		# toggle_reg32	\n"
+	"	xor	%0, %2				\n"
+	"	sc	%0, %1				\n"
+	"	"__beqz"%0, 1b				\n"
+	"	.set	mips0				\n"
+	: "=&r" (temp), "=m" (*addr)
+	: "ir" (mask), "m" (*addr) );
+}
+
+/* For special strange cases only:
+ *
+ * If you need custom processing within a ll/sc loop, use the following macros
+ * VERY CAREFULLY:
+ *
+ *   uint32_t tmp;                      <-- Define a variable to hold the data
+ *
+ *   custom_reg32_start(address, tmp);	<-- Reads the address and puts the value
+ *						in the 'tmp' variable given
+ *
+ *	< From here on out, you are (basicly) atomic, so don't do anything too
+ *	< fancy!
+ *	< Also, this code may loop if the end of this block fails to write
+ *	< everything back safely due do the other CPU, so do NOT do anything
+ *	< with side-effects!
+ *
+ *   custom_reg32_stop(address, tmp);	<-- Writes back 'tmp' safely. 
+ *
+ */
+#define custom_reg32_read(address, tmp)				\
+	__asm__ __volatile__(					\
+	"	.set	mips3				\n"	\
+	"1:	ll	%0, %1	#custom_reg32_read	\n"	\
+	"	.set	mips0				\n"	\
+	: "=r" (tmp), "=m" (*address)				\
+	: "m" (*address) )
+
+#define custom_reg32_write(address, tmp)			\
+	__asm__ __volatile__(					\
+	"	.set	mips3				\n"	\
+	"	sc	%0, %1	#custom_reg32_write	\n"	\
+	"	"__beqz"%0, 1b				\n"	\
+	"	.set	mips0				\n"	\
+	: "=&r" (tmp), "=m" (*address)				\
+	: "0" (tmp), "m" (*address) )
+
+#endif  /* __ASM_REGOPS_H__ */
