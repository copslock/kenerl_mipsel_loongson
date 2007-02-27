Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Feb 2007 00:14:27 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:11199 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039087AbXB0AOW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Feb 2007 00:14:22 +0000
Received: (qmail 26206 invoked by uid 101); 27 Feb 2007 00:12:56 -0000
Received: from unknown (HELO pmxedge2.pmc-sierra.bc.ca) (216.241.226.184)
  by mother.pmc-sierra.com with SMTP; 27 Feb 2007 00:12:56 -0000
Received: from pasqua.pmc-sierra.bc.ca (pasqua.pmc-sierra.bc.ca [134.87.183.161])
	by pmxedge2.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1R0Ctc5022529
	for <linux-mips@linux-mips.org>; Mon, 26 Feb 2007 16:12:56 -0800
From:	Marc St-Jean <stjeanma@pmc-sierra.com>
Received: (from stjeanma@localhost)
	by pasqua.pmc-sierra.bc.ca (8.13.4/8.12.11) id l1R0Ctq2006513
	for linux-mips@linux-mips.org; Mon, 26 Feb 2007 18:12:55 -0600
Date:	Mon, 26 Feb 2007 18:12:55 -0600
Message-Id: <200702270012.l1R0Ctq2006513@pasqua.pmc-sierra.bc.ca>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/5] mips: PMC MSP71xx mips common
Return-Path: <stjeanma@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14252
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
Re-posting patch with two recommended changes:
1. Dropped the PMC_MSP_UNCACHED configuration item as this was
already available in arch/mips/Kconfig.debug.
3. Dropped 'else' case to simplify patch to do_watch() in
arch/mips/kernel/traps.c

 arch/mips/Kconfig           |   78 ++++++++++++++++++++
 arch/mips/Makefile          |    8 ++
 arch/mips/kernel/head.S     |    8 ++
 arch/mips/kernel/traps.c    |    6 +
 include/asm-mips/bootinfo.h |   12 +++
 include/asm-mips/mipsregs.h |   30 +++++++
 include/asm-mips/regops.h   |  168 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/war.h      |   11 ++
 8 files changed, 321 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5da6b0d..77fc083 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -504,6 +504,25 @@ config MACH_VR41XX
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
 	select GENERIC_HARDIRQS_NO__DO_IRQ
 
+config PMC_MSP
+	bool "PMC-Sierra MSP chipsets"
+	depends on EXPERIMENTAL
+	select DMA_NONCOHERENT
+	select SWAP_IO_SPACE
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
@@ -815,6 +834,55 @@ config TOSHIBA_RBTX4938
 
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
@@ -971,6 +1039,15 @@ config IRQ_CPU_RM9K
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
@@ -1086,6 +1163,7 @@ config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION || SNI_RM
 	default "7" if SGI_IP27
+	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
 config HAVE_STD_PC_SERIAL_PORT
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 92bca6a..fc406f7 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -367,6 +367,14 @@ cflags-$(CONFIG_PMC_YOSEMITE)	+= -Iinclude/asm-mips/mach-yosemite
 load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
 
 #
+# PMC-Sierra MSP SOCs
+#
+core-$(CONFIG_PMC_MSP)		+= arch/mips/pmc-sierra/msp71xx/
+cflags-$(CONFIG_PMC_MSP)	+= -Iinclude/asm-mips/pmc-sierra/msp71xx \
+					-mno-branch-likely
+load-$(CONFIG_PMC_MSP)		+= 0xffffffff80100000
+
+#
 # Qemu simulating MIPS32 4Kc
 #
 core-$(CONFIG_QEMU)		+= arch/mips/qemu/
diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 6f57ca4..d7451b1 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -130,10 +130,18 @@
 	.endm
 
 	/*
+	 * Reserverd space not required for PMC boards, although we need to
+	 * jump to kernel start.
+	 */
+#ifdef CONFIG_PMC_MSP
+	jal	kernel_entry
+#else
+	/*
 	 * Reserved space for exception handlers.
 	 * Necessary for machines which link their kernels at KSEG0.
 	 */
 	.fill	0x400
+#endif /* CONFIG_PMC_MSP */
 
 EXPORT(stext)					# used for profiling
 EXPORT(_stext)
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
index c7c945b..ab29fd4 100644
--- a/include/asm-mips/bootinfo.h
+++ b/include/asm-mips/bootinfo.h
@@ -213,6 +213,18 @@
 #define MACH_GROUP_NEC_EMMA2RH 25	/* NEC EMMA2RH (was 23)		*/
 #define  MACH_NEC_MARKEINS	0	/* NEC EMMA2RH Mark-eins	*/
 
+/*
+ * Valid machtype for group PMC-MSP
+ */
+#define MACH_GROUP_MSP         23	/* PMC-Sierra MSP boards/CPUs    */
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
