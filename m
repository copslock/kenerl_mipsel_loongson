Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 01:04:34 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:61538 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012104AbaJUXDmqEMHA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 01:03:42 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so1920096lab.19
        for <multiple recipients>; Tue, 21 Oct 2014 16:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UR9wN65+8gEdwE4/EDhFxoUwz0YZZSSiqgTgQu4hc5s=;
        b=Si/z8kB+J8s5M8BiDQlI6oyWZs0DjBiKMe45nAeFjNUiD/wsuCfehLf5sQB5eVBI+O
         4KX2dw72Er4BwKhfmeiehpE9TTzS1castulHD4CIjg1bfw4K62mJ/84/8LUK3tHzf0GM
         wkl/mPSnsV5/O5utzUzxIKtbjKeW9XbfGD2ir8H9qBrbMihgrZLtGgf6BTnf31U4bdCZ
         SbZlPpefwDwdbI+UK0qwpb+O9JucTVM/0KrKJVBJUdaoux16NPrRjqce3kSXwNywlqIK
         upOAdPusU2VYeal59yg3IjTlXBJjxT3zM9VHJnlrdqadaKT15L8mkM3hJa5byyu34g/q
         uhjQ==
X-Received: by 10.152.21.39 with SMTP id s7mr38109834lae.0.1413932617288;
        Tue, 21 Oct 2014 16:03:37 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id lk5sm5077133lac.45.2014.10.21.16.03.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 16:03:36 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [PATCH v2 03/13] MIPS: ath25: add basic AR2315 SoC support
Date:   Wed, 22 Oct 2014 03:03:41 +0400
Message-Id: <1413932631-12866-4-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Add basic support for Atheros AR2315+ SoCs: registers definition file
and initial setup code.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---

Changes since v1:
  - rename MIPS machine ar231x -> ath25

 arch/mips/ath25/Kconfig                            |   5 +
 arch/mips/ath25/Makefile                           |   1 +
 arch/mips/ath25/ar2315.c                           | 127 +++++
 arch/mips/ath25/ar2315.h                           |  18 +
 arch/mips/ath25/board.c                            |   5 +
 arch/mips/ath25/prom.c                             |   3 +
 arch/mips/include/asm/mach-ath25/ar2315_regs.h     | 529 +++++++++++++++++++++
 .../include/asm/mach-ath25/cpu-feature-overrides.h |  10 +-
 8 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/ath25/ar2315.c
 create mode 100644 arch/mips/ath25/ar2315.h
 create mode 100644 arch/mips/include/asm/mach-ath25/ar2315_regs.h

diff --git a/arch/mips/ath25/Kconfig b/arch/mips/ath25/Kconfig
index cf933ea..ca3dde4 100644
--- a/arch/mips/ath25/Kconfig
+++ b/arch/mips/ath25/Kconfig
@@ -2,3 +2,8 @@ config SOC_AR5312
 	bool "Atheros AR5312/AR2312+ SoC support"
 	depends on ATH25
 	default y
+
+config SOC_AR2315
+	bool "Atheros AR2315+ SoC support"
+	depends on ATH25
+	default y
diff --git a/arch/mips/ath25/Makefile b/arch/mips/ath25/Makefile
index 3361619..201b7d4 100644
--- a/arch/mips/ath25/Makefile
+++ b/arch/mips/ath25/Makefile
@@ -11,3 +11,4 @@
 obj-y += board.o prom.o devices.o
 
 obj-$(CONFIG_SOC_AR5312) += ar5312.o
+obj-$(CONFIG_SOC_AR2315) += ar2315.o
diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
new file mode 100644
index 0000000..4eee362
--- /dev/null
+++ b/arch/mips/ath25/ar2315.c
@@ -0,0 +1,127 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2012 Alexandros C. Couloumbis <alex@ozo.com>
+ */
+
+/*
+ * Platform devices for Atheros AR2315 SoCs
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+
+#include <ar2315_regs.h>
+#include <ath25.h>
+
+#include "devices.h"
+#include "ar2315.h"
+
+static void ar2315_restart(char *command)
+{
+	void (*mips_reset_vec)(void) = (void *)0xbfc00000;
+
+	local_irq_disable();
+
+	/* try reset the system via reset control */
+	ath25_write_reg(AR2315_COLD_RESET, AR2317_RESET_SYSTEM);
+
+	/* Attempt to jump to the mips reset location - the boot loader
+	 * itself might be able to recover the system */
+	mips_reset_vec();
+}
+
+/*
+ * This table is indexed by bits 5..4 of the CLOCKCTL1 register
+ * to determine the predevisor value.
+ */
+static int clockctl1_predivide_table[4] __initdata = { 1, 2, 4, 5 };
+static int pllc_divide_table[5] __initdata = { 2, 3, 4, 6, 3 };
+
+static unsigned __init ar2315_sys_clk(u32 clock_ctl)
+{
+	unsigned int pllc_ctrl, cpu_div;
+	unsigned int pllc_out, refdiv, fdiv, divby2;
+	unsigned int clk_div;
+
+	pllc_ctrl = ath25_read_reg(AR2315_PLLC_CTL);
+	refdiv = ATH25_REG_MS(pllc_ctrl, AR2315_PLLC_REF_DIV);
+	refdiv = clockctl1_predivide_table[refdiv];
+	fdiv = ATH25_REG_MS(pllc_ctrl, AR2315_PLLC_FDBACK_DIV);
+	divby2 = ATH25_REG_MS(pllc_ctrl, AR2315_PLLC_ADD_FDBACK_DIV) + 1;
+	pllc_out = (40000000 / refdiv) * (2 * divby2) * fdiv;
+
+	/* clkm input selected */
+	switch (clock_ctl & AR2315_CPUCLK_CLK_SEL_M) {
+	case 0:
+	case 1:
+		clk_div = ATH25_REG_MS(pllc_ctrl, AR2315_PLLC_CLKM_DIV);
+		clk_div = pllc_divide_table[clk_div];
+		break;
+	case 2:
+		clk_div = ATH25_REG_MS(pllc_ctrl, AR2315_PLLC_CLKC_DIV);
+		clk_div = pllc_divide_table[clk_div];
+		break;
+	default:
+		pllc_out = 40000000;
+		clk_div = 1;
+		break;
+	}
+
+	cpu_div = ATH25_REG_MS(clock_ctl, AR2315_CPUCLK_CLK_DIV);
+	cpu_div = cpu_div * 2 ?: 1;
+
+	return pllc_out / (clk_div * cpu_div);
+}
+
+static inline unsigned ar2315_cpu_frequency(void)
+{
+	return ar2315_sys_clk(ath25_read_reg(AR2315_CPUCLK));
+}
+
+static inline unsigned ar2315_apb_frequency(void)
+{
+	return ar2315_sys_clk(ath25_read_reg(AR2315_AMBACLK));
+}
+
+void __init ar2315_plat_time_init(void)
+{
+	mips_hpt_frequency = ar2315_cpu_frequency() / 2;
+}
+
+void __init ar2315_plat_mem_setup(void)
+{
+	u32 config;
+
+	/* Clear any lingering AHB errors */
+	config = read_c0_config();
+	write_c0_config(config & ~0x3);
+	ath25_write_reg(AR2315_AHB_ERR0, AR2315_AHB_ERROR_DET);
+	ath25_read_reg(AR2315_AHB_ERR1);
+	ath25_write_reg(AR2315_WDC, AR2315_WDC_IGNORE_EXPIRATION);
+
+	_machine_restart = ar2315_restart;
+}
+
+void __init ar2315_prom_init(void)
+{
+	u32 memsize, memcfg;
+
+	memcfg = ath25_read_reg(AR2315_MEM_CFG);
+	memsize   = 1 + ATH25_REG_MS(memcfg, AR2315_MEM_CFG_DATA_WIDTH);
+	memsize <<= 1 + ATH25_REG_MS(memcfg, AR2315_MEM_CFG_COL_WIDTH);
+	memsize <<= 1 + ATH25_REG_MS(memcfg, AR2315_MEM_CFG_ROW_WIDTH);
+	memsize <<= 3;
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
diff --git a/arch/mips/ath25/ar2315.h b/arch/mips/ath25/ar2315.h
new file mode 100644
index 0000000..98d32b2
--- /dev/null
+++ b/arch/mips/ath25/ar2315.h
@@ -0,0 +1,18 @@
+#ifndef __AR2315_H
+#define __AR2315_H
+
+#ifdef CONFIG_SOC_AR2315
+
+void ar2315_plat_time_init(void);
+void ar2315_plat_mem_setup(void);
+void ar2315_prom_init(void);
+
+#else
+
+static inline void ar2315_plat_time_init(void) {}
+static inline void ar2315_plat_mem_setup(void) {}
+static inline void ar2315_prom_init(void) {}
+
+#endif
+
+#endif	/* __AR2315_H */
diff --git a/arch/mips/ath25/board.c b/arch/mips/ath25/board.c
index 80683e3..a6b8c26 100644
--- a/arch/mips/ath25/board.c
+++ b/arch/mips/ath25/board.c
@@ -17,6 +17,7 @@
 #include <asm/time.h>
 
 #include "ar5312.h"
+#include "ar2315.h"
 
 static void ath25_halt(void)
 {
@@ -32,6 +33,8 @@ void __init plat_mem_setup(void)
 
 	if (is_ar5312())
 		ar5312_plat_mem_setup();
+	else
+		ar2315_plat_mem_setup();
 
 	/* Disable data watchpoints */
 	write_c0_watchlo0(0);
@@ -45,6 +48,8 @@ void __init plat_time_init(void)
 {
 	if (is_ar5312())
 		ar5312_plat_time_init();
+	else
+		ar2315_plat_time_init();
 }
 
 unsigned int __cpuinit get_c0_compare_int(void)
diff --git a/arch/mips/ath25/prom.c b/arch/mips/ath25/prom.c
index ec60b0f..3fc4f93 100644
--- a/arch/mips/ath25/prom.c
+++ b/arch/mips/ath25/prom.c
@@ -19,11 +19,14 @@
 
 #include "devices.h"
 #include "ar5312.h"
+#include "ar2315.h"
 
 void __init prom_init(void)
 {
 	if (is_ar5312())
 		ar5312_prom_init();
+	else
+		ar2315_prom_init();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/include/asm/mach-ath25/ar2315_regs.h b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
new file mode 100644
index 0000000..ff9a4a8
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath25/ar2315_regs.h
@@ -0,0 +1,529 @@
+/*
+ * Register definitions for AR2315+
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2008 Felix Fietkau <nbd@openwrt.org>
+ */
+
+#ifndef __ASM_MACH_ATH25_AR2315_REGS_H
+#define __ASM_MACH_ATH25_AR2315_REGS_H
+
+/*
+ * Address map
+ */
+#define AR2315_SPI_READ		0x08000000	/* SPI flash */
+#define AR2315_WLAN0		0x10000000	/* Wireless MMR */
+#define AR2315_PCI		0x10100000	/* PCI MMR */
+#define AR2315_SDRAMCTL		0x10300000	/* SDRAM MMR */
+#define AR2315_LOCAL		0x10400000	/* Local bus MMR */
+#define AR2315_ENET0		0x10500000	/* Ethernet MMR */
+#define AR2315_DSLBASE		0x11000000	/* Reset control MMR */
+#define AR2315_UART0		0x11100000	/* UART MMR */
+#define AR2315_SPI_MMR		0x11300000	/* SPI flash MMR */
+#define AR2315_PCIEXT		0x80000000	/* PCI external */
+#define AR2315_PCIEXT_SZ	0x40000000
+
+/*
+ * Cold reset register
+ */
+#define AR2315_COLD_RESET		(AR2315_DSLBASE + 0x0000)
+
+#define AR2315_RESET_COLD_AHB		0x00000001
+#define AR2315_RESET_COLD_APB		0x00000002
+#define AR2315_RESET_COLD_CPU		0x00000004
+#define AR2315_RESET_COLD_CPUWARM	0x00000008
+#define AR2315_RESET_SYSTEM		(RESET_COLD_CPU |\
+					 RESET_COLD_APB |\
+					 RESET_COLD_AHB)  /* full system */
+#define AR2317_RESET_SYSTEM		0x00000010
+
+/*
+ * Reset register
+ */
+#define AR2315_RESET			(AR2315_DSLBASE + 0x0004)
+
+#define AR2315_RESET_WARM_WLAN0_MAC	0x00000001  /* warm reset WLAN0 MAC */
+#define AR2315_RESET_WARM_WLAN0_BB	0x00000002  /* warm reset WLAN0 BB */
+#define AR2315_RESET_MPEGTS_RSVD	0x00000004  /* warm reset MPEG-TS */
+#define AR2315_RESET_PCIDMA		0x00000008  /* warm reset PCI ahb/dma */
+#define AR2315_RESET_MEMCTL		0x00000010  /* warm reset mem control */
+#define AR2315_RESET_LOCAL		0x00000020  /* warm reset local bus */
+#define AR2315_RESET_I2C_RSVD		0x00000040  /* warm reset I2C bus */
+#define AR2315_RESET_SPI		0x00000080  /* warm reset SPI iface */
+#define AR2315_RESET_UART0		0x00000100  /* warm reset UART0 */
+#define AR2315_RESET_IR_RSVD		0x00000200  /* warm reset IR iface */
+#define AR2315_RESET_EPHY0		0x00000400  /* cold reset ENET0 phy */
+#define AR2315_RESET_ENET0		0x00000800  /* cold reset ENET0 MAC */
+
+/*
+ * AHB master arbitration control
+ */
+#define AR2315_AHB_ARB_CTL		(AR2315_DSLBASE + 0x0008)
+
+#define AR2315_ARB_CPU			0x00000001  /* CPU, default */
+#define AR2315_ARB_WLAN			0x00000002  /* WLAN */
+#define AR2315_ARB_MPEGTS_RSVD		0x00000004  /* MPEG-TS */
+#define AR2315_ARB_LOCAL		0x00000008  /* Local bus */
+#define AR2315_ARB_PCI			0x00000010  /* PCI bus */
+#define AR2315_ARB_ETHERNET		0x00000020  /* Ethernet */
+#define AR2315_ARB_RETRY		0x00000100  /* Retry policy (debug) */
+
+/*
+ * Config Register
+ */
+#define AR2315_ENDIAN_CTL		(AR2315_DSLBASE + 0x000c)
+
+#define AR2315_CONFIG_AHB		0x00000001  /* EC-AHB bridge endian */
+#define AR2315_CONFIG_WLAN		0x00000002  /* WLAN byteswap */
+#define AR2315_CONFIG_MPEGTS_RSVD	0x00000004  /* MPEG-TS byteswap */
+#define AR2315_CONFIG_PCI		0x00000008  /* PCI byteswap */
+#define AR2315_CONFIG_MEMCTL		0x00000010  /* Mem controller endian */
+#define AR2315_CONFIG_LOCAL		0x00000020  /* Local bus byteswap */
+#define AR2315_CONFIG_ETHERNET		0x00000040  /* Ethernet byteswap */
+#define AR2315_CONFIG_MERGE		0x00000200  /* CPU write buffer merge */
+#define AR2315_CONFIG_CPU		0x00000400  /* CPU big endian */
+#define AR2315_CONFIG_BIG		0x00000400
+#define AR2315_CONFIG_PCIAHB		0x00000800
+#define AR2315_CONFIG_PCIAHB_BRIDGE	0x00001000
+#define AR2315_CONFIG_SPI		0x00008000  /* SPI byteswap */
+#define AR2315_CONFIG_CPU_DRAM		0x00010000
+#define AR2315_CONFIG_CPU_PCI		0x00020000
+#define AR2315_CONFIG_CPU_MMR		0x00040000
+
+/*
+ * NMI control
+ */
+#define AR2315_NMI_CTL			(AR2315_DSLBASE + 0x0010)
+
+#define AR2315_NMI_EN			1
+
+/*
+ * Revision Register - Initial value is 0x3010 (WMAC 3.0, AR231X 1.0).
+ */
+#define AR2315_SREV			(AR2315_DSLBASE + 0x0014)
+
+#define AR2315_REV_MAJ			0x00f0
+#define AR2315_REV_MAJ_S		4
+#define AR2315_REV_MIN			0x000f
+#define AR2315_REV_MIN_S		0
+#define AR2315_REV_CHIP			(AR2315_REV_MAJ | AR2315_REV_MIN)
+
+/*
+ * Interface Enable
+ */
+#define AR2315_IF_CTL			(AR2315_DSLBASE + 0x0018)
+
+#define AR2315_IF_MASK			0x00000007
+#define AR2315_IF_DISABLED		0		/* Disable all */
+#define AR2315_IF_PCI			1		/* PCI */
+#define AR2315_IF_TS_LOCAL		2		/* Local bus */
+#define AR2315_IF_ALL			3		/* Emulation only */
+#define AR2315_IF_LOCAL_HOST		0x00000008
+#define AR2315_IF_PCI_HOST		0x00000010
+#define AR2315_IF_PCI_INTR		0x00000020
+#define AR2315_IF_PCI_CLK_MASK		0x00030000
+#define AR2315_IF_PCI_CLK_INPUT		0
+#define AR2315_IF_PCI_CLK_OUTPUT_LOW	1
+#define AR2315_IF_PCI_CLK_OUTPUT_CLK	2
+#define AR2315_IF_PCI_CLK_OUTPUT_HIGH	3
+#define AR2315_IF_PCI_CLK_SHIFT		16
+
+/*
+ * APB Interrupt control
+ */
+
+#define AR2315_ISR			(AR2315_DSLBASE + 0x0020)
+#define AR2315_IMR			(AR2315_DSLBASE + 0x0024)
+#define AR2315_GISR			(AR2315_DSLBASE + 0x0028)
+
+#define AR2315_ISR_UART0	0x0001		/* high speed UART */
+#define AR2315_ISR_I2C_RSVD	0x0002		/* I2C bus */
+#define AR2315_ISR_SPI		0x0004		/* SPI bus */
+#define AR2315_ISR_AHB		0x0008		/* AHB error */
+#define AR2315_ISR_APB		0x0010		/* APB error */
+#define AR2315_ISR_TIMER	0x0020		/* Timer */
+#define AR2315_ISR_GPIO		0x0040		/* GPIO */
+#define AR2315_ISR_WD		0x0080		/* Watchdog */
+#define AR2315_ISR_IR_RSVD	0x0100		/* IR */
+
+#define AR2315_GISR_MISC	0x0001		/* Misc */
+#define AR2315_GISR_WLAN0	0x0002		/* WLAN0 */
+#define AR2315_GISR_MPEGTS_RSVD	0x0004		/* MPEG-TS */
+#define AR2315_GISR_LOCALPCI	0x0008		/* Local/PCI bus */
+#define AR2315_GISR_WMACPOLL	0x0010
+#define AR2315_GISR_TIMER	0x0020
+#define AR2315_GISR_ETHERNET	0x0040		/* Ethernet */
+
+/*
+ * Timers
+ */
+#define AR2315_TIMER			(AR2315_DSLBASE + 0x0030)
+#define AR2315_RELOAD			(AR2315_DSLBASE + 0x0034)
+#define AR2315_WD			(AR2315_DSLBASE + 0x0038)
+#define AR2315_WDC			(AR2315_DSLBASE + 0x003c)
+
+#define AR2315_WDC_IGNORE_EXPIRATION	0x00000000
+#define AR2315_WDC_NMI			0x00000001	/* NMI on watchdog */
+#define AR2315_WDC_RESET		0x00000002	/* reset on watchdog */
+
+/*
+ * CPU Performance Counters
+ */
+#define AR2315_PERFCNT0			(AR2315_DSLBASE + 0x0048)
+#define AR2315_PERFCNT1			(AR2315_DSLBASE + 0x004c)
+
+#define AR2315_PERF0_DATAHIT	0x0001  /* Count Data Cache Hits */
+#define AR2315_PERF0_DATAMISS	0x0002  /* Count Data Cache Misses */
+#define AR2315_PERF0_INSTHIT	0x0004  /* Count Instruction Cache Hits */
+#define AR2315_PERF0_INSTMISS	0x0008  /* Count Instruction Cache Misses */
+#define AR2315_PERF0_ACTIVE	0x0010  /* Count Active Processor Cycles */
+#define AR2315_PERF0_WBHIT	0x0020  /* Count CPU Write Buffer Hits */
+#define AR2315_PERF0_WBMISS	0x0040  /* Count CPU Write Buffer Misses */
+
+#define AR2315_PERF1_EB_ARDY	0x0001  /* Count EB_ARdy signal */
+#define AR2315_PERF1_EB_AVALID	0x0002  /* Count EB_AValid signal */
+#define AR2315_PERF1_EB_WDRDY	0x0004  /* Count EB_WDRdy signal */
+#define AR2315_PERF1_EB_RDVAL	0x0008  /* Count EB_RdVal signal */
+#define AR2315_PERF1_VRADDR	0x0010  /* Count valid read address cycles */
+#define AR2315_PERF1_VWADDR	0x0020  /* Count valid write address cycles */
+#define AR2315_PERF1_VWDATA	0x0040  /* Count valid write data cycles */
+
+/*
+ * AHB Error Reporting.
+ */
+#define AR2315_AHB_ERR0			(AR2315_DSLBASE + 0x0050)  /* error  */
+#define AR2315_AHB_ERR1			(AR2315_DSLBASE + 0x0054)  /* haddr  */
+#define AR2315_AHB_ERR2			(AR2315_DSLBASE + 0x0058)  /* hwdata */
+#define AR2315_AHB_ERR3			(AR2315_DSLBASE + 0x005c)  /* hrdata */
+#define AR2315_AHB_ERR4			(AR2315_DSLBASE + 0x0060)  /* status */
+
+#define AR2315_AHB_ERROR_DET	1 /* AHB Error has been detected,          */
+				  /* write 1 to clear all bits in ERR0     */
+#define AR2315_AHB_ERROR_OVR	2 /* AHB Error overflow has been detected  */
+#define AR2315_AHB_ERROR_WDT	4 /* AHB Error due to wdt instead of hresp */
+
+#define AR2315_PROCERR_HMAST		0x0000000f
+#define AR2315_PROCERR_HMAST_DFLT	0
+#define AR2315_PROCERR_HMAST_WMAC	1
+#define AR2315_PROCERR_HMAST_ENET	2
+#define AR2315_PROCERR_HMAST_PCIENDPT	3
+#define AR2315_PROCERR_HMAST_LOCAL	4
+#define AR2315_PROCERR_HMAST_CPU	5
+#define AR2315_PROCERR_HMAST_PCITGT	6
+#define AR2315_PROCERR_HMAST_S		0
+#define AR2315_PROCERR_HWRITE		0x00000010
+#define AR2315_PROCERR_HSIZE		0x00000060
+#define AR2315_PROCERR_HSIZE_S		5
+#define AR2315_PROCERR_HTRANS		0x00000180
+#define AR2315_PROCERR_HTRANS_S		7
+#define AR2315_PROCERR_HBURST		0x00000e00
+#define AR2315_PROCERR_HBURST_S		9
+
+/*
+ * Clock Control
+ */
+#define AR2315_PLLC_CTL			(AR2315_DSLBASE + 0x0064)
+#define AR2315_PLLV_CTL			(AR2315_DSLBASE + 0x0068)
+#define AR2315_CPUCLK			(AR2315_DSLBASE + 0x006c)
+#define AR2315_AMBACLK			(AR2315_DSLBASE + 0x0070)
+#define AR2315_SYNCCLK			(AR2315_DSLBASE + 0x0074)
+#define AR2315_DSL_SLEEP_CTL		(AR2315_DSLBASE + 0x0080)
+#define AR2315_DSL_SLEEP_DUR		(AR2315_DSLBASE + 0x0084)
+
+/* PLLc Control fields */
+#define AR2315_PLLC_REF_DIV_M		0x00000003
+#define AR2315_PLLC_REF_DIV_S		0
+#define AR2315_PLLC_FDBACK_DIV_M	0x0000007C
+#define AR2315_PLLC_FDBACK_DIV_S	2
+#define AR2315_PLLC_ADD_FDBACK_DIV_M	0x00000080
+#define AR2315_PLLC_ADD_FDBACK_DIV_S	7
+#define AR2315_PLLC_CLKC_DIV_M		0x0001c000
+#define AR2315_PLLC_CLKC_DIV_S		14
+#define AR2315_PLLC_CLKM_DIV_M		0x00700000
+#define AR2315_PLLC_CLKM_DIV_S		20
+
+/* CPU CLK Control fields */
+#define AR2315_CPUCLK_CLK_SEL_M		0x00000003
+#define AR2315_CPUCLK_CLK_SEL_S		0
+#define AR2315_CPUCLK_CLK_DIV_M		0x0000000c
+#define AR2315_CPUCLK_CLK_DIV_S		2
+
+/* AMBA CLK Control fields */
+#define AR2315_AMBACLK_CLK_SEL_M	0x00000003
+#define AR2315_AMBACLK_CLK_SEL_S	0
+#define AR2315_AMBACLK_CLK_DIV_M	0x0000000c
+#define AR2315_AMBACLK_CLK_DIV_S	2
+
+/*
+ *  PCI Clock Control
+ */
+#define AR2315_PCICLK			(AR2315_DSLBASE + 0x00a4)
+
+#define AR2315_PCICLK_INPUT_M		0x3
+#define AR2315_PCICLK_INPUT_S		0
+#define AR2315_PCICLK_PLLC_CLKM		0
+#define AR2315_PCICLK_PLLC_CLKM1	1
+#define AR2315_PCICLK_PLLC_CLKC		2
+#define AR2315_PCICLK_REF_CLK		3
+#define AR2315_PCICLK_DIV_M		0xc
+#define AR2315_PCICLK_DIV_S		2
+#define AR2315_PCICLK_IN_FREQ		0
+#define AR2315_PCICLK_IN_FREQ_DIV_6	1
+#define AR2315_PCICLK_IN_FREQ_DIV_8	2
+#define AR2315_PCICLK_IN_FREQ_DIV_10	3
+
+/*
+ * Observation Control Register
+ */
+#define AR2315_OCR			(AR2315_DSLBASE + 0x00b0)
+
+#define AR2315_OCR_GPIO0_IRIN		0x0040
+#define AR2315_OCR_GPIO1_IROUT		0x0080
+#define AR2315_OCR_GPIO3_RXCLR		0x0200
+
+/*
+ *  General Clock Control
+ */
+
+#define AR2315_MISCCLK			(AR2315_DSLBASE + 0x00b4)
+
+#define AR2315_MISCCLK_PLLBYPASS_EN	0x00000001
+#define AR2315_MISCCLK_PROCREFCLK	0x00000002
+
+/*
+ * SDRAM Controller
+ *   - No read or write buffers are included.
+ */
+#define AR2315_MEM_CFG			(AR2315_SDRAMCTL + 0x00)
+#define AR2315_MEM_CTRL			(AR2315_SDRAMCTL + 0x0c)
+#define AR2315_MEM_REF			(AR2315_SDRAMCTL + 0x10)
+
+#define AR2315_MEM_CFG_DATA_WIDTH_M	0x00006000
+#define AR2315_MEM_CFG_DATA_WIDTH_S	13
+#define AR2315_MEM_CFG_COL_WIDTH_M	0x00001E00
+#define AR2315_MEM_CFG_COL_WIDTH_S	9
+#define AR2315_MEM_CFG_ROW_WIDTH_M	0x000001E0
+#define AR2315_MEM_CFG_ROW_WIDTH_S	5
+#define AR2315_MEM_CFG_BANKADDR_BITS_M	0x00000018
+#define AR2315_MEM_CFG_BANKADDR_BITS_S	3
+
+/*
+ * PCI Bus Interface Registers
+ */
+#define AR2315_PCI_1MS_REG		(AR2315_PCI + 0x0008)
+
+#define AR2315_PCI_1MS_MASK		0x3FFFF	/* # of AHB clk cycles in 1ms */
+
+#define AR2315_PCI_MISC_CONFIG		(AR2315_PCI + 0x000c)
+
+#define AR2315_PCIMISC_TXD_EN	0x00000001	/* Enable TXD for fragments */
+#define AR2315_PCIMISC_CFG_SEL	0x00000002	/* Mem or Config cycles */
+#define AR2315_PCIMISC_GIG_MASK	0x0000000C	/* bits 31-30 for pci req */
+#define AR2315_PCIMISC_RST_MODE	0x00000030
+#define AR2315_PCIRST_INPUT	0x00000000	/* 4:5=0 rst is input */
+#define AR2315_PCIRST_LOW	0x00000010	/* 4:5=1 rst to GND */
+#define AR2315_PCIRST_HIGH	0x00000020	/* 4:5=2 rst to VDD */
+#define AR2315_PCIGRANT_EN	0x00000000	/* 6:7=0 early grant en */
+#define AR2315_PCIGRANT_FRAME	0x00000040	/* 6:7=1 grant waits 4 frame */
+#define AR2315_PCIGRANT_IDLE	0x00000080	/* 6:7=2 grant waits 4 idle */
+#define AR2315_PCIGRANT_GAP	0x00000000	/* 6:7=2 grant waits 4 idle */
+#define AR2315_PCICACHE_DIS	0x00001000	/* PCI external access cache
+						 * disable */
+
+#define AR2315_PCI_OUT_TSTAMP		(AR2315_PCI + 0x0010)
+
+#define AR2315_PCI_UNCACHE_CFG		(AR2315_PCI + 0x0014)
+
+#define AR2315_PCI_IN_EN		(AR2315_PCI + 0x0100)
+
+#define AR2315_PCI_IN_EN0	0x01	/* Enable chain 0 */
+#define AR2315_PCI_IN_EN1	0x02	/* Enable chain 1 */
+#define AR2315_PCI_IN_EN2	0x04	/* Enable chain 2 */
+#define AR2315_PCI_IN_EN3	0x08	/* Enable chain 3 */
+
+#define AR2315_PCI_IN_DIS		(AR2315_PCI + 0x0104)
+
+#define AR2315_PCI_IN_DIS0	0x01	/* Disable chain 0 */
+#define AR2315_PCI_IN_DIS1	0x02	/* Disable chain 1 */
+#define AR2315_PCI_IN_DIS2	0x04	/* Disable chain 2 */
+#define AR2315_PCI_IN_DIS3	0x08	/* Disable chain 3 */
+
+#define AR2315_PCI_IN_PTR		(AR2315_PCI + 0x0200)
+
+#define AR2315_PCI_OUT_EN		(AR2315_PCI + 0x0400)
+
+#define AR2315_PCI_OUT_EN0	0x01	/* Enable chain 0 */
+
+#define AR2315_PCI_OUT_DIS		(AR2315_PCI + 0x0404)
+
+#define AR2315_PCI_OUT_DIS0	0x01	/* Disable chain 0 */
+
+#define AR2315_PCI_OUT_PTR		(AR2315_PCI + 0x0408)
+
+/*
+ * PCI interrupt status
+ * Write one to clear
+ */
+#define AR2315_PCI_ISR			(AR2315_PCI + 0x0500)
+
+#define AR2315_PCI_INT_TX	0x00000001	/* Desc In Completed */
+#define AR2315_PCI_INT_TXOK	0x00000002	/* Desc In OK */
+#define AR2315_PCI_INT_TXERR	0x00000004	/* Desc In ERR */
+#define AR2315_PCI_INT_TXEOL	0x00000008	/* Desc In End-of-List */
+#define AR2315_PCI_INT_RX	0x00000010	/* Desc Out Completed */
+#define AR2315_PCI_INT_RXOK	0x00000020	/* Desc Out OK */
+#define AR2315_PCI_INT_RXERR	0x00000040	/* Desc Out ERR */
+#define AR2315_PCI_INT_RXEOL	0x00000080	/* Desc Out EOL */
+#define AR2315_PCI_INT_TXOOD	0x00000200	/* Desc In Out-of-Desc */
+#define AR2315_PCI_INT_DESCMASK	0x0000FFFF	/* Desc Mask */
+#define AR2315_PCI_INT_EXT	0x02000000	/* Extern PCI INTA */
+#define AR2315_PCI_INT_ABORT	0x04000000	/* PCI bus abort event */
+
+/* PCI interrupt mask */
+#define AR2315_PCI_IMR			(AR2315_PCI + 0x0504)
+
+/* Global PCI interrupt enable */
+#define AR2315_PCI_IER			(AR2315_PCI + 0x0508)
+
+#define AR2315_PCI_IER_DISABLE		0x00	/* disable pci interrupts */
+#define AR2315_PCI_IER_ENABLE		0x01	/* enable pci interrupts */
+
+#define AR2315_PCI_HOST_IN_EN		(AR2315_PCI + 0x0800)
+#define AR2315_PCI_HOST_IN_DIS		(AR2315_PCI + 0x0804)
+#define AR2315_PCI_HOST_IN_PTR		(AR2315_PCI + 0x0810)
+#define AR2315_PCI_HOST_OUT_EN		(AR2315_PCI + 0x0900)
+#define AR2315_PCI_HOST_OUT_DIS		(AR2315_PCI + 0x0904)
+#define AR2315_PCI_HOST_OUT_PTR		(AR2315_PCI + 0x0908)
+
+/*
+ * Local Bus Interface Registers
+ */
+#define AR2315_LB_CONFIG		(AR2315_LOCAL + 0x0000)
+
+#define AR2315_LBCONF_OE	0x00000001	/* =1 OE is low-true */
+#define AR2315_LBCONF_CS0	0x00000002	/* =1 first CS is low-true */
+#define AR2315_LBCONF_CS1	0x00000004	/* =1 2nd CS is low-true */
+#define AR2315_LBCONF_RDY	0x00000008	/* =1 RDY is low-true */
+#define AR2315_LBCONF_WE	0x00000010	/* =1 Write En is low-true */
+#define AR2315_LBCONF_WAIT	0x00000020	/* =1 WAIT is low-true */
+#define AR2315_LBCONF_ADS	0x00000040	/* =1 Adr Strobe is low-true */
+#define AR2315_LBCONF_MOT	0x00000080	/* =0 Intel, =1 Motorola */
+#define AR2315_LBCONF_8CS	0x00000100	/* =1 8 bits CS, 0= 16bits */
+#define AR2315_LBCONF_8DS	0x00000200	/* =1 8 bits Data S, 0=16bits */
+#define AR2315_LBCONF_ADS_EN	0x00000400	/* =1 Enable ADS */
+#define AR2315_LBCONF_ADR_OE	0x00000800	/* =1 Adr cap on OE, WE or DS */
+#define AR2315_LBCONF_ADDT_MUX	0x00001000	/* =1 Adr and Data share bus */
+#define AR2315_LBCONF_DATA_OE	0x00002000	/* =1 Data cap on OE, WE, DS */
+#define AR2315_LBCONF_16DATA	0x00004000	/* =1 Data is 16 bits wide */
+#define AR2315_LBCONF_SWAPDT	0x00008000	/* =1 Byte swap data */
+#define AR2315_LBCONF_SYNC	0x00010000	/* =1 Bus synchronous to clk */
+#define AR2315_LBCONF_INT	0x00020000	/* =1 Intr is low true */
+#define AR2315_LBCONF_INT_CTR0	0x00000000	/* GND high-Z, Vdd is high-Z */
+#define AR2315_LBCONF_INT_CTR1	0x00040000	/* GND drive, Vdd is high-Z */
+#define AR2315_LBCONF_INT_CTR2	0x00080000	/* GND high-Z, Vdd drive */
+#define AR2315_LBCONF_INT_CTR3	0x000C0000	/* GND drive, Vdd drive */
+#define AR2315_LBCONF_RDY_WAIT	0x00100000	/* =1 RDY is negative of WAIT */
+#define AR2315_LBCONF_INT_PULSE	0x00200000	/* =1 Interrupt is a pulse */
+#define AR2315_LBCONF_ENABLE	0x00400000	/* =1 Falcon respond to LB */
+
+#define AR2315_LB_CLKSEL		(AR2315_LOCAL + 0x0004)
+
+#define AR2315_LBCLK_EXT	0x0001		/* use external clk for lb */
+
+#define AR2315_LB_1MS			(AR2315_LOCAL + 0x0008)
+
+#define AR2315_LB1MS_MASK	0x3FFFF		/* # of AHB clk cycles in 1ms */
+
+#define AR2315_LB_MISCCFG		(AR2315_LOCAL + 0x000C)
+
+#define AR2315_LBM_TXD_EN	0x00000001	/* Enable TXD for fragments */
+#define AR2315_LBM_RX_INTEN	0x00000002	/* Enable LB ints on RX ready */
+#define AR2315_LBM_MBOXWR_INTEN	0x00000004	/* Enable LB ints on mbox wr */
+#define AR2315_LBM_MBOXRD_INTEN	0x00000008	/* Enable LB ints on mbox rd */
+#define AR2315_LMB_DESCSWAP_EN	0x00000010	/* Byte swap desc enable */
+#define AR2315_LBM_TIMEOUT_M	0x00FFFF80
+#define AR2315_LBM_TIMEOUT_S	7
+#define AR2315_LBM_PORTMUX	0x07000000
+
+#define AR2315_LB_RXTSOFF		(AR2315_LOCAL + 0x0010)
+
+#define AR2315_LB_TX_CHAIN_EN		(AR2315_LOCAL + 0x0100)
+
+#define AR2315_LB_TXEN_0	0x01
+#define AR2315_LB_TXEN_1	0x02
+#define AR2315_LB_TXEN_2	0x04
+#define AR2315_LB_TXEN_3	0x08
+
+#define AR2315_LB_TX_CHAIN_DIS		(AR2315_LOCAL + 0x0104)
+#define AR2315_LB_TX_DESC_PTR		(AR2315_LOCAL + 0x0200)
+
+#define AR2315_LB_RX_CHAIN_EN		(AR2315_LOCAL + 0x0400)
+
+#define AR2315_LB_RXEN		0x01
+
+#define AR2315_LB_RX_CHAIN_DIS		(AR2315_LOCAL + 0x0404)
+#define AR2315_LB_RX_DESC_PTR		(AR2315_LOCAL + 0x0408)
+
+#define AR2315_LB_INT_STATUS		(AR2315_LOCAL + 0x0500)
+
+#define AR2315_INT_TX_DESC	0x0001
+#define AR2315_INT_TX_OK	0x0002
+#define AR2315_INT_TX_ERR	0x0004
+#define AR2315_INT_TX_EOF	0x0008
+#define AR2315_INT_RX_DESC	0x0010
+#define AR2315_INT_RX_OK	0x0020
+#define AR2315_INT_RX_ERR	0x0040
+#define AR2315_INT_RX_EOF	0x0080
+#define AR2315_INT_TX_TRUNC	0x0100
+#define AR2315_INT_TX_STARVE	0x0200
+#define AR2315_INT_LB_TIMEOUT	0x0400
+#define AR2315_INT_LB_ERR	0x0800
+#define AR2315_INT_MBOX_WR	0x1000
+#define AR2315_INT_MBOX_RD	0x2000
+
+/* Bit definitions for INT MASK are the same as INT_STATUS */
+#define AR2315_LB_INT_MASK		(AR2315_LOCAL + 0x0504)
+
+#define AR2315_LB_INT_EN		(AR2315_LOCAL + 0x0508)
+#define AR2315_LB_MBOX			(AR2315_LOCAL + 0x0600)
+
+/*
+ * IR Interface Registers
+ */
+#define AR2315_IR_PKTDATA		(AR2315_IR + 0x0000)
+
+#define AR2315_IR_PKTLEN		(AR2315_IR + 0x07fc) /* 0 - 63 */
+
+#define AR2315_IR_CONTROL		(AR2315_IR + 0x0800)
+
+#define AR2315_IRCTL_TX			0x00000000  /* use as tranmitter */
+#define AR2315_IRCTL_RX			0x00000001  /* use as receiver   */
+#define AR2315_IRCTL_SAMPLECLK_M	0x00003ffe  /* Sample clk divisor */
+#define AR2315_IRCTL_SAMPLECLK_S	1
+#define AR2315_IRCTL_OUTPUTCLK_M	0x03ffc000  /* Output clk div */
+#define AR2315_IRCTL_OUTPUTCLK_S	14
+
+#define AR2315_IR_STATUS		(AR2315_IR + 0x0804)
+
+#define AR2315_IRSTS_RX			0x00000001  /* receive in progress */
+#define AR2315_IRSTS_TX			0x00000002  /* transmit in progress */
+
+#define AR2315_IR_CONFIG		(AR2315_IR + 0x0808)
+
+#define AR2315_IRCFG_INVIN		0x00000001  /* invert in polarity */
+#define AR2315_IRCFG_INVOUT		0x00000002  /* invert out polarity */
+#define AR2315_IRCFG_SEQ_START_WIN_SEL	0x00000004  /* 1 => 28, 0 => 7 */
+#define AR2315_IRCFG_SEQ_START_THRESH	0x000000f0
+#define AR2315_IRCFG_SEQ_END_UNIT_SEL	0x00000100
+#define AR2315_IRCFG_SEQ_END_UNIT_THRESH 0x00007e00
+#define AR2315_IRCFG_SEQ_END_WIN_SEL	0x00008000
+#define AR2315_IRCFG_SEQ_END_WIN_THRESH	0x001f0000
+#define AR2315_IRCFG_NUM_BACKOFF_WORDS	0x01e00000
+
+#endif /* __ASM_MACH_ATH25_AR2315_REGS_H */
diff --git a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
index c1aebdc..e66ca0d 100644
--- a/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-ath25/cpu-feature-overrides.h
@@ -36,11 +36,15 @@
 /* #define cpu_has_mcheck		? */
 #define cpu_has_ejtag			1
 
+#if !defined(CONFIG_SOC_AR5312)
+#  define cpu_has_llsc			1
+#else
 /*
  * The MIPS 4Kc V0.9 core in the AR5312/AR2312 have problems with the
  * ll/sc instructions.
  */
-#define cpu_has_llsc			0
+#  define cpu_has_llsc			0
+#endif
 
 #define cpu_has_mips16			0
 #define cpu_has_mdmx			0
@@ -56,6 +60,10 @@
 
 #define cpu_has_mips32r1		1
 
+#if !defined(CONFIG_SOC_AR5312)
+#  define cpu_has_mips32r2		1
+#endif
+
 #define cpu_has_mips64r1		0
 #define cpu_has_mips64r2		0
 
-- 
1.8.5.5
