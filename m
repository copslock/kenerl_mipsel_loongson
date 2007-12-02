Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 12:02:31 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:20453 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023380AbXLBMBB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 12:01:01 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IynVJ-0001dY-01; Sun, 02 Dec 2007 13:00:57 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 2A477C2EB6; Sun,  2 Dec 2007 13:00:32 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [UPDATED PATCH] IP28 support
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20071202120032.2A477C2EB6@solo.franken.de>
Date:	Sun,  2 Dec 2007 13:00:32 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
This work is mainly based on Peter Fuersts work.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Changes to last version:

- restructered Kconfig to make device/feature selection easier

 arch/mips/Kconfig                                  |   66 ++-
 arch/mips/Makefile                                 |   14 +
 arch/mips/sgi-ip22/Makefile                        |    8 +-
 arch/mips/sgi-ip22/ip22-mc.c                       |    4 +
 arch/mips/sgi-ip22/ip28-berr.c                     |  700 ++++++++++++++++++++
 include/asm-mips/dma.h                             |    7 +-
 include/asm-mips/mach-ip28/cpu-feature-overrides.h |   50 ++
 include/asm-mips/mach-ip28/ds1286.h                |    4 +
 include/asm-mips/mach-ip28/spaces.h                |   22 +
 include/asm-mips/mach-ip28/war.h                   |   25 +
 10 files changed, 890 insertions(+), 10 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 455bd1f..aae317d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -122,6 +122,7 @@ config MACH_JAZZ
 	select ARCH_MAY_HAVE_PC_FDC
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select GENERIC_ISA_DMA
 	select IRQ_CPU
 	select I8253
@@ -398,6 +399,7 @@ config SGI_IP22
 	select BOOT_ELF32
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION
 	select DMA_NONCOHERENT
 	select HW_HAS_EISA
 	select I8253
@@ -405,6 +407,12 @@ config SGI_IP22
 	select IP22_CPU_SCACHE
 	select IRQ_CPU
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
+	select SGI_HAS_DS1286
+	select SGI_HAS_I8042
+	select SGI_HAS_INDYDOG
+	select SGI_HAS_SEEQ
+	select SGI_HAS_WD93
+	select SGI_HAS_ZILOG
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_R4X00
 	select SYS_HAS_CPU_R5000
@@ -422,6 +430,7 @@ config SGI_IP27
 	select ARC
 	select ARC64
 	select BOOT_ELF64
+	select DEFAULT_SGI_PARTITION
 	select DMA_IP27
 	select SYS_HAS_EARLY_PRINTK
 	select HW_HAS_PCI
@@ -438,6 +447,35 @@ config SGI_IP27
 	  workstations.  To compile a Linux kernel that runs on these, say Y
 	  here.
 
+config SGI_IP28
+	bool "SGI IP28 (Indigo2 R10k) (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	select ARC
+	select ARC64
+	select BOOT_ELF64
+	select CEVT_R4K
+	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION
+	select DMA_NONCOHERENT
+	select IRQ_CPU
+	select HW_HAS_EISA
+	select I8253
+	select I8259
+	select SGI_HAS_DS1286
+	select SGI_HAS_I8042
+	select SGI_HAS_INDYDOG
+	select SGI_HAS_SEEQ
+	select SGI_HAS_WD93
+	select SGI_HAS_ZILOG
+	select SWAP_IO_SPACE
+	select SYS_HAS_CPU_R10000
+	select SYS_HAS_EARLY_PRINTK
+	select SYS_SUPPORTS_64BIT_KERNEL
+	select SYS_SUPPORTS_BIG_ENDIAN
+      help
+        This is the SGI Indigo2 with R10000 processor.  To compile a Linux
+        kernel that runs on these, say Y here.
+
 config SGI_IP32
 	bool "SGI IP32 (O2)"
 	select ARC
@@ -577,6 +615,7 @@ config SNI_RM
 	select BOOT_ELF32
 	select CEVT_R4K
 	select CSRC_R4K
+	select DEFAULT_SGI_PARTITION if CPU_BIG_ENDIAN
 	select DMA_NONCOHERENT
 	select GENERIC_ISA_DMA
 	select HW_HAS_EISA
@@ -950,6 +989,27 @@ config EMMA2RH
 config SERIAL_RM9000
 	bool
 
+config SGI_HAS_DS1286
+	bool
+
+config SGI_HAS_INDYDOG
+	bool
+
+config SGI_HAS_SEEQ
+	bool
+
+config SGI_HAS_WD93
+	bool
+
+config SGI_HAS_ZILOG
+	bool
+
+config SGI_HAS_I8042
+	bool
+
+config DEFAULT_SGI_PARTITION
+	bool
+
 config ARC32
 	bool
 
@@ -959,7 +1019,7 @@ config BOOT_ELF32
 config MIPS_L1_CACHE_SHIFT
 	int
 	default "4" if MACH_DECSTATION
-	default "7" if SGI_IP27 || SNI_RM
+	default "7" if SGI_IP27 || SGI_IP28 || SNI_RM
 	default "4" if PMC_MSP4200_EVAL
 	default "5"
 
@@ -968,7 +1028,7 @@ config HAVE_STD_PC_SERIAL_PORT
 
 config ARC_CONSOLE
 	bool "ARC console support"
-	depends on SGI_IP22 || (SNI_RM && CPU_LITTLE_ENDIAN)
+	depends on SGI_IP22 || SGI_IP28 || (SNI_RM && CPU_LITTLE_ENDIAN)
 
 config ARC_MEMORY
 	bool
@@ -977,7 +1037,7 @@ config ARC_MEMORY
 
 config ARC_PROMLIB
 	bool
-	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP32
+	depends on MACH_JAZZ || SNI_RM || SGI_IP22 || SGI_IP28 || SGI_IP32
 	default y
 
 config ARC64
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a1f8d8b..d91fbca 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -475,6 +475,20 @@ endif
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
+cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=1 -Iinclude/asm-mips/mach-ip28
+#cflags-$(CONFIG_SGI_IP28)	+= -Iinclude/asm-mips/mach-ip28
+load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
+
+#
 # SGI-IP32 (O2)
 #
 # Set the load address to >= 80069000 if you want to leave space for symmon,
diff --git a/arch/mips/sgi-ip22/Makefile b/arch/mips/sgi-ip22/Makefile
index e3acb51..ef1564e 100644
--- a/arch/mips/sgi-ip22/Makefile
+++ b/arch/mips/sgi-ip22/Makefile
@@ -3,9 +3,11 @@
 # under Linux.
 #
 
-obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-berr.o \
-	   ip22-time.o ip22-nvram.o ip22-platform.o ip22-reset.o ip22-setup.o
+obj-y	+= ip22-mc.o ip22-hpc.o ip22-int.o ip22-time.o ip22-nvram.o \
+	   ip22-platform.o ip22-reset.o ip22-setup.o
 
+obj-$(CONFIG_SGI_IP22) += ip22-berr.o
+obj-$(CONFIG_SGI_IP28) += ip28-berr.o
 obj-$(CONFIG_EISA)	+= ip22-eisa.o
 
-EXTRA_CFLAGS += -Werror
+# EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/sgi-ip22/ip22-mc.c b/arch/mips/sgi-ip22/ip22-mc.c
index 01a805d..3f35d63 100644
--- a/arch/mips/sgi-ip22/ip22-mc.c
+++ b/arch/mips/sgi-ip22/ip22-mc.c
@@ -4,6 +4,7 @@
  * Copyright (C) 1996 David S. Miller (dm@engr.sgi.com)
  * Copyright (C) 1999 Andrew R. Baker (andrewb@uab.edu) - Indigo2 changes
  * Copyright (C) 2003 Ladislav Michl  (ladis@linux-mips.org)
+ * Copyright (C) 2004 Peter Fuerst    (pf@net.alphadv.de) - IP28
  */
 
 #include <linux/init.h>
@@ -137,9 +138,12 @@ void __init sgimc_init(void)
 	/* Step 2: Enable all parity checking in cpu control register
 	 *         zero.
 	 */
+	/* don't touch parity settings for IP28 */
+#ifndef CONFIG_SGI_IP28
 	tmp = sgimc->cpuctrl0;
 	tmp |= (SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM |
 		SGIMC_CCTRL0_R4KNOCHKPARR);
+#endif
 	sgimc->cpuctrl0 = tmp;
 
 	/* Step 3: Setup the MC write buffer depth, this is controlled
diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
new file mode 100644
index 0000000..0ee5be8
--- /dev/null
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -0,0 +1,700 @@
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
+#include <linux/seq_file.h>
+
+#include <asm/addrspace.h>
+#include <asm/system.h>
+#include <asm/traps.h>
+#include <asm/branch.h>
+#include <asm/irq_regs.h>
+#include <asm/sgi/mc.h>
+#include <asm/sgi/hpc3.h>
+#include <asm/sgi/ioc.h>
+#include <asm/sgi/ip22.h>
+#include <asm/r4kcache.h>
+#include <asm/uaccess.h>
+#include <asm/bootinfo.h>
+
+static unsigned int count_be_is_fixup;
+static unsigned int count_be_handler;
+static unsigned int count_be_interrupt;
+static int debug_be_interrupt;
+
+static unsigned int cpu_err_stat;	/* Status reg for CPU */
+static unsigned int gio_err_stat;	/* Status reg for GIO */
+static unsigned int cpu_err_addr;	/* Error address reg for CPU */
+static unsigned int gio_err_addr;	/* Error address reg for GIO */
+static unsigned int extio_stat;
+static unsigned int hpc3_berr_stat;	/* Bus error interrupt status */
+
+struct hpc3_stat {
+	unsigned long addr;
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
+	struct {
+		u32 lo;
+		u32 hi;
+	} tags[1][2], tagd[4][2], tagi[4][2]; /* Way 0/1 */
+} cache_tags;
+
+static inline void save_cache_tags(unsigned busaddr)
+{
+	unsigned long addr = CAC_BASE | busaddr;
+	int i;
+	cache_tags.err_addr = addr;
+
+	/*
+	 * Starting with a bus-address, save secondary cache (indexed by
+	 * PA[23..18:7..6]) tags first.
+	 */
+	addr &= ~1L;
+#define tag cache_tags.tags[0]
+	cache_op(Index_Load_Tag_S, addr);
+	tag[0].lo = read_c0_taglo();	/* PA[35:18], VA[13:12] */
+	tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+	cache_op(Index_Load_Tag_S, addr | 1L);
+	tag[1].lo = read_c0_taglo();	/* PA[35:18], VA[13:12] */
+	tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+#undef tag
+
+	/*
+	 * Save all primary data cache (indexed by VA[13:5]) tags which
+	 * might fit to this bus-address, knowing that VA[11:0] == PA[11:0].
+	 * Saving all tags and evaluating them later is easier and safer
+	 * than relying on VA[13:12] from the secondary cache tags to pick
+	 * matching primary tags here already.
+	 */
+	addr &= (0xffL << 56) | ((1 << 12) - 1);
+#define tag cache_tags.tagd[i]
+	for (i = 0; i < 4; ++i, addr += (1 << 12)) {
+		cache_op(Index_Load_Tag_D, addr);
+		tag[0].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+		cache_op(Index_Load_Tag_D, addr | 1L);
+		tag[1].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+	}
+#undef tag
+
+	/*
+	 * Save primary instruction cache (indexed by VA[13:6]) tags
+	 * the same way.
+	 */
+	addr &= (0xffL << 56) | ((1 << 12) - 1);
+#define tag cache_tags.tagi[i]
+	for (i = 0; i < 4; ++i, addr += (1 << 12)) {
+		cache_op(Index_Load_Tag_I, addr);
+		tag[0].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[0].hi = read_c0_taghi();	/* PA[39:36] */
+		cache_op(Index_Load_Tag_I, addr | 1L);
+		tag[1].lo = read_c0_taglo();	/* PA[35:12] */
+		tag[1].hi = read_c0_taghi();	/* PA[39:36] */
+	}
+#undef tag
+}
+
+#define GIO_ERRMASK	0xff00
+#define CPU_ERRMASK	0x3f00
+
+static void save_and_clear_buserr(void)
+{
+	int i;
+
+	/* save status registers */
+	cpu_err_addr = sgimc->cerr;
+	cpu_err_stat = sgimc->cstat;
+	gio_err_addr = sgimc->gerr;
+	gio_err_stat = sgimc->gstat;
+	extio_stat = sgioc->extio;
+	hpc3_berr_stat = hpc3c0->bestat;
+
+	hpc3.scsi[0].addr  = (unsigned long)&hpc3c0->scsi_chan0;
+	hpc3.scsi[0].ctrl  = hpc3c0->scsi_chan0.ctrl; /* HPC3_SCTRL_ACTIVE ? */
+	hpc3.scsi[0].cbp   = hpc3c0->scsi_chan0.cbptr;
+	hpc3.scsi[0].ndptr = hpc3c0->scsi_chan0.ndptr;
+
+	hpc3.scsi[1].addr  = (unsigned long)&hpc3c0->scsi_chan1;
+	hpc3.scsi[1].ctrl  = hpc3c0->scsi_chan1.ctrl; /* HPC3_SCTRL_ACTIVE ? */
+	hpc3.scsi[1].cbp   = hpc3c0->scsi_chan1.cbptr;
+	hpc3.scsi[1].ndptr = hpc3c0->scsi_chan1.ndptr;
+
+	hpc3.ethrx.addr  = (unsigned long)&hpc3c0->ethregs.rx_cbptr;
+	hpc3.ethrx.ctrl  = hpc3c0->ethregs.rx_ctrl; /* HPC3_ERXCTRL_ACTIVE ? */
+	hpc3.ethrx.cbp   = hpc3c0->ethregs.rx_cbptr;
+	hpc3.ethrx.ndptr = hpc3c0->ethregs.rx_ndptr;
+
+	hpc3.ethtx.addr  = (unsigned long)&hpc3c0->ethregs.tx_cbptr;
+	hpc3.ethtx.ctrl  = hpc3c0->ethregs.tx_ctrl; /* HPC3_ETXCTRL_ACTIVE ? */
+	hpc3.ethtx.cbp   = hpc3c0->ethregs.tx_cbptr;
+	hpc3.ethtx.ndptr = hpc3c0->ethregs.tx_ndptr;
+
+	for (i = 0; i < 8; ++i) {
+		/* HPC3_PDMACTRL_ISACT ? */
+		hpc3.pbdma[i].addr  = (unsigned long)&hpc3c0->pbdma[i];
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
+	u32 scb, scw;
+	int i;
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
+		printk(KERN_ERR
+		       "D: 0: %08x %08x, 1: %08x %08x  (VA[13:5]  %04x)\n",
+			cache_tags.tagd[i][0].hi, cache_tags.tagd[i][0].lo,
+			cache_tags.tagd[i][1].hi, cache_tags.tagd[i][1].lo,
+			scb | (1 << 12)*i);
+	}
+	scb = cache_tags.err_addr & ((1 << 12) - 1) & ~((1 << 6) - 1);
+	for (i = 0; i < 4; ++i) { /* for each possible VA[13:12] value */
+		if ((cache_tags.tagi[i][0].lo & 0x0fffff00) != scw &&
+		    (cache_tags.tagi[i][1].lo & 0x0fffff00) != scw)
+		    continue;
+		printk(KERN_ERR
+		       "I: 0: %08x %08x, 1: %08x %08x  (VA[13:6]  %04x)\n",
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
+static void print_buserr(const struct pt_regs *regs)
+{
+	const int field = 2 * sizeof(unsigned long);
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
+	printk(KERN_ALERT "%s, epc == %0*lx, ra == %0*lx\n",
+	       cause_excode_text(regs->cp0_cause),
+	       field, regs->cp0_epc, field, regs->regs[31]);
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
+	unsigned long uaddr;
+
+	if ((vaddr & 0xffffffff80000000L) == 0xffffffff80000000L)
+		uaddr = (unsigned) CPHYSADDR(vaddr);
+	else if ((vaddr >> 62) == 2)
+		uaddr = (unsigned) XPHYSADDR(vaddr);
+	else {
+		unsigned long eh = vaddr & ~0x1fffL;
+
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
+		case Index_Writeback_Inv_D:
+		case Hit_Writeback_Inv_D:
+		case Index_Writeback_Inv_S:
+		case Hit_Writeback_Inv_S:
+			return BASE_OFFSET_OP;
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
+	case 0:   /* LWXC1 */
+	case 1:   /* LDXC1 */
+	case 8:   /* SWXC1 */
+	case 8+1: /* SDXC1 */
+		return BASE_IDXREG_OP;
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
+	if ((4     <= opcode && opcode <= 7) ||   /* BEQ, BNE, BLEZ, BGTZ */
+	    (4+2*8 <= opcode && opcode <= 7+2*8)) /* BEQL, BNEL, BLEZL, BGTZL */
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
+static int check_addr_in_insn(unsigned paddr, const struct pt_regs *regs)
+{
+	unsigned long epc;
+	unsigned insn;
+	unsigned long a;
+	int typ;
+
+	epc = regs->cp0_cause & CAUSEF_BD ? regs->cp0_epc:regs->cp0_epc+4;
+
+	/* show_code() from kernel/traps.c */
+	if (__get_user(insn, (u32 *)epc))
+		return 1;
+
+	/* See Doc1, pages A-180, B-108 ff. */
+	switch (insn >> 26) {
+	case 0:
+		typ = check_special(insn);
+		break;
+	case 1:
+		typ = check_regimm(insn);
+		break;
+	case 2*8:   /* COP0 */
+	case 5*8+7: /* CACHE */
+		typ = check_cop0(insn);
+		break;
+	case 2*8+1:
+		typ = check_cop1(insn);
+		break;
+	case 2*8+3:
+		typ = check_cop1x(insn);
+		break;
+	default:
+		typ = check_plain(insn);
+		break;
+	}
+	switch (typ) {
+	case JMP_INDEX26_OP:
+		a = (regs->cp0_epc + 4) & ~0xfffffff;
+		a |= (insn & 0x3ffffff) << 2;
+		return match_addr(paddr, a);
+	case JMP_REGISTER_OP:
+		a = regs->regs[(insn >> 21) & 0x1f];
+		return match_addr(paddr, a);
+	case JMP_PCREL16_OP:
+		a = regs->cp0_epc + 4 + ((insn & 0xffff) << 2);
+		return match_addr(paddr, a);
+	case BASE_OFFSET_OP:
+		a = regs->regs[(insn >> 21) & 0x1f] + (insn & 0xffff);
+		return match_addr(paddr, a);
+	case BASE_IDXREG_OP:
+		a = regs->regs[(insn >> 21) & 0x1f];
+		a += regs->regs[(insn >> 16) & 0x1f];
+		return match_addr(paddr, a);
+	case 0:
+		return 0;
+	}
+	/* Assume it would be too dangerous to continue ... */
+	return 1;
+}
+
+/*
+ * Check, whether MC's (virtual) DMA address caused the bus error.
+ * See "Virtual DMA Specification", Draft 1.5, Feb 13 1992, SGI
+ */
+
+static int addr_is_ram(unsigned long addr, unsigned sz)
+{
+	int i;
+
+	for (i = 0; i < boot_mem_map.nr_map; i++) {
+		unsigned long a = boot_mem_map.map[i].addr;
+		if (a <= addr && addr+sz <= a+boot_mem_map.map[i].size)
+			return 1;
+	}
+	return 0;
+}
+
+static int check_microtlb(u32 hi, u32 lo, unsigned long vaddr)
+{
+	/* This is likely rather similar to correct code ;-) */
+
+	vaddr &= 0x7fffffff; /* Doc. states that top bit is ignored */
+
+	/* If tlb-entry is valid and VPN-high (bits [30:21] ?) matches... */
+	if ((lo & 2) && (vaddr >> 21) == ((hi<<1) >> 22)) {
+		u32 ctl = sgimc->dma_ctrl;
+		if (ctl & 1) {
+			unsigned int pgsz = (ctl & 2) ? 14:12; /* 16k:4k */
+			/* PTEIndex is VPN-low (bits [22:14]/[20:12] ?) */
+			unsigned long pte = (lo >> 6) << 12; /* PTEBase */
+			pte += 8*((vaddr >> pgsz) & 0x1ff);
+			if (addr_is_ram(pte, 8)) {
+				/*
+				 * Note: Since DMA hardware does look up
+				 * translation on its own, this PTE *must*
+				 * match the TLB/EntryLo-register format !
+				 */
+				unsigned long a = *(unsigned long *)
+						PHYS_TO_XKSEG_UNCACHED(pte);
+				a = (a & 0x3f) << 6; /* PFN */
+				a += vaddr & ((1 << pgsz) - 1);
+				return (cpu_err_addr == a);
+			}
+		}
+	}
+	return 0;
+}
+
+static int check_vdma_memaddr(void)
+{
+	if (cpu_err_stat & CPU_ERRMASK) {
+		u32 a = sgimc->maddronly;
+
+		if (!(sgimc->dma_ctrl & 0x100)) /* Xlate-bit clear ? */
+			return (cpu_err_addr == a);
+
+		if (check_microtlb(sgimc->dtlb_hi0, sgimc->dtlb_lo0, a) ||
+		    check_microtlb(sgimc->dtlb_hi1, sgimc->dtlb_lo1, a) ||
+		    check_microtlb(sgimc->dtlb_hi2, sgimc->dtlb_lo2, a) ||
+		    check_microtlb(sgimc->dtlb_hi3, sgimc->dtlb_lo3, a))
+			return 1;
+	}
+	return 0;
+}
+
+static int check_vdma_gioaddr(void)
+{
+	if (gio_err_stat & GIO_ERRMASK) {
+		u32 a = sgimc->gio_dma_trans;
+		a = (sgimc->gmaddronly & ~a) | (sgimc->gio_dma_sbits & a);
+		return (gio_err_addr == a);
+	}
+	return 0;
+}
+
+/*
+ * MC sends an interrupt whenever bus or parity errors occur. In addition,
+ * if the error happened during a CPU read, it also asserts the bus error
+ * pin on the R4K. Code in bus error handler save the MC bus error registers
+ * and then clear the interrupt when this happens.
+ */
+
+static int ip28_be_interrupt(const struct pt_regs *regs)
+{
+	int i;
+
+	save_and_clear_buserr();
+	/*
+	 * Try to find out, whether we got here by a mispredicted speculative
+	 * load/store operation.  If so, it's not fatal, we can go on.
+	 */
+	/* Any cause other than "Interrupt" (ExcCode 0) is fatal. */
+	if (regs->cp0_cause & CAUSEF_EXCCODE)
+		goto mips_be_fatal;
+
+	/* Any cause other than "Bus error interrupt" (IP6) is weird. */
+	if ((regs->cp0_cause & CAUSEF_IP6) != CAUSEF_IP6)
+		goto mips_be_fatal;
+
+	if (extio_stat & (EXTIO_HPC3_BUSERR | EXTIO_EISA_BUSERR))
+		goto mips_be_fatal;
+
+	/* Any state other than "Memory bus error" is fatal. */
+	if (cpu_err_stat & CPU_ERRMASK & ~SGIMC_CSTAT_ADDR)
+			goto mips_be_fatal;
+
+	/* GIO errors are fatal */
+	if (gio_err_stat & GIO_ERRMASK)
+		goto mips_be_fatal;
+
+	/* Finding `cpu_err_addr' in the insn at EPC is fatal. */
+	if ((cpu_err_stat & CPU_ERRMASK) &&
+	     check_addr_in_insn(cpu_err_addr, regs))
+			goto mips_be_fatal;
+
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
+		goto mips_be_fatal;
+	}
+	/* Check MC's virtual DMA stuff. */
+	if (check_vdma_memaddr()) {
+		printk(KERN_ERR "at GIO DMA: mem address 0x%08x.\n",
+			sgimc->maddronly);
+		goto mips_be_fatal;
+	}
+	if (check_vdma_gioaddr()) {
+		printk(KERN_ERR "at GIO DMA: gio address 0x%08x.\n",
+			sgimc->gmaddronly);
+		goto mips_be_fatal;
+	}
+	/* A speculative bus error... */
+	if (debug_be_interrupt) {
+		print_buserr(regs);
+		printk(KERN_ERR "discarded!\n");
+	}
+	return MIPS_BE_DISCARD;
+
+mips_be_fatal:
+	print_buserr(regs);
+	return MIPS_BE_FATAL;
+}
+
+void ip22_be_interrupt(int irq)
+{
+	const struct pt_regs *regs = get_irq_regs();
+
+	count_be_interrupt++;
+
+	if (ip28_be_interrupt(regs) != MIPS_BE_DISCARD) {
+		/* Assume it would be too dangerous to continue ... */
+		die_if_kernel("Oops", regs);
+		force_sig(SIGBUS, current);
+	} else if (debug_be_interrupt)
+		show_regs((struct pt_regs *)regs);
+}
+
+static int ip28_be_handler(struct pt_regs *regs, int is_fixup)
+{
+	/*
+	 * We arrive here only in the unusual case of do_be() invocation,
+	 * i.e. by a bus error exception without a bus error interrupt.
+	 */
+	if (is_fixup) {
+		count_be_is_fixup++;
+		save_and_clear_buserr();
+		return MIPS_BE_FIXUP;
+	}
+	count_be_handler++;
+	return ip28_be_interrupt(regs);
+}
+
+void __init ip22_be_init(void)
+{
+	board_be_handler = ip28_be_handler;
+}
+
+int ip28_show_be_info(struct seq_file *m)
+{
+	seq_printf(m, "IP28 be fixups\t\t: %u\n", count_be_is_fixup);
+	seq_printf(m, "IP28 be interrupts\t: %u\n", count_be_interrupt);
+	seq_printf(m, "IP28 be handler\t\t: %u\n", count_be_handler);
+
+	return 0;
+}
+
+static int __init debug_be_setup(char *str)
+{
+	debug_be_interrupt++;
+	return 1;
+}
+__setup("ip28_debug_be", debug_be_setup);
+
diff --git a/include/asm-mips/dma.h b/include/asm-mips/dma.h
index d6a6c21..1353c81 100644
--- a/include/asm-mips/dma.h
+++ b/include/asm-mips/dma.h
@@ -84,10 +84,9 @@
  * Deskstations or Acer PICA but not the much more versatile DMA logic used
  * for the local devices on Acer PICA or Magnums.
  */
-#ifdef CONFIG_SGI_IP22
-/* Horrible hack to have a correct DMA window on IP22 */
-#include <asm/sgi/mc.h>
-#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SGIMC_SEG0_BADDR + 0x01000000)
+#if defined(CONFIG_SGI_IP22) || defined(CONFIG_SGI_IP28)
+/* don't care; ISA bus master won't work, ISA slave DMA supports 32bit addr */
+#define MAX_DMA_ADDRESS		PAGE_OFFSET
 #else
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET + 0x01000000)
 #endif
diff --git a/include/asm-mips/mach-ip28/cpu-feature-overrides.h b/include/asm-mips/mach-ip28/cpu-feature-overrides.h
new file mode 100644
index 0000000..9a53b32
--- /dev/null
+++ b/include/asm-mips/mach-ip28/cpu-feature-overrides.h
@@ -0,0 +1,50 @@
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
+#define cpu_has_dsp		0
+#define cpu_icache_snoops_remote_store  1
+#define cpu_has_mipsmt		0
+#define cpu_has_userlocal	0
+
+#define cpu_has_nofpuex		0
+#define cpu_has_64bits		1
+
+#define cpu_has_4kex		1
+#define cpu_has_4k_cache	1
+
+#define cpu_has_inclusive_pcaches	1
+
+#define cpu_dcache_line_size()	32
+#define cpu_icache_line_size()	64
+
+#define cpu_has_mips32r1	0
+#define cpu_has_mips32r2	0
+#define cpu_has_mips64r1	0
+#define cpu_has_mips64r2	0
+
+#endif /* __ASM_MACH_IP28_CPU_FEATURE_OVERRIDES_H */
diff --git a/include/asm-mips/mach-ip28/ds1286.h b/include/asm-mips/mach-ip28/ds1286.h
new file mode 100644
index 0000000..471bb9a
--- /dev/null
+++ b/include/asm-mips/mach-ip28/ds1286.h
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_IP28_DS1286_H
+#define __ASM_MACH_IP28_DS1286_H
+#include <asm/mach-ip22/ds1286.h>
+#endif /* __ASM_MACH_IP28_DS1286_H */
diff --git a/include/asm-mips/mach-ip28/spaces.h b/include/asm-mips/mach-ip28/spaces.h
new file mode 100644
index 0000000..05aabb2
--- /dev/null
+++ b/include/asm-mips/mach-ip28/spaces.h
@@ -0,0 +1,22 @@
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
+#define CAC_BASE		0xa800000000000000
+
+#define HIGHMEM_START		(~0UL)
+
+#define PHYS_OFFSET		_AC(0x20000000, UL)
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* _ASM_MACH_IP28_SPACES_H */
diff --git a/include/asm-mips/mach-ip28/war.h b/include/asm-mips/mach-ip28/war.h
new file mode 100644
index 0000000..a1baafa
--- /dev/null
+++ b/include/asm-mips/mach-ip28/war.h
@@ -0,0 +1,25 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2002, 2004, 2007 by Ralf Baechle <ralf@linux-mips.org>
+ */
+#ifndef __ASM_MIPS_MACH_IP28_WAR_H
+#define __ASM_MIPS_MACH_IP28_WAR_H
+
+#define R4600_V1_INDEX_ICACHEOP_WAR	0
+#define R4600_V1_HIT_CACHEOP_WAR	0
+#define R4600_V2_HIT_CACHEOP_WAR	0
+#define R5432_CP0_INTERRUPT_WAR		0
+#define BCM1250_M3_WAR			0
+#define SIBYTE_1956_WAR			0
+#define MIPS4K_ICACHE_REFILL_WAR	0
+#define MIPS_CACHE_SYNC_WAR		0
+#define TX49XX_ICACHE_INDEX_INV_WAR	0
+#define RM9000_CDEX_SMP_WAR		0
+#define ICACHE_REFILLS_WORKAROUND_WAR	0
+#define R10000_LLSC_WAR			1
+#define MIPS34K_MISSED_ITLB_WAR		0
+
+#endif /* __ASM_MIPS_MACH_IP28_WAR_H */
