Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:32:23 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:49347 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008886AbaINTbtxUzKj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:31:49 +0200
Received: by mail-la0-f47.google.com with SMTP id mc6so3458306lab.6
        for <multiple recipients>; Sun, 14 Sep 2014 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X16dnRxB8N6GDAEdGil4TW5lXrMeh+umoql4VPxU5MI=;
        b=fAZaGPP5OgK/eA69BEJrV2B8gqyZx1xZfI2MwlZd3JxsVh6Ln1myW9Jh1o62NWGhkv
         EXDCGSzoxCnk5QRo63wWL0wO4jnd3I0HTeRJ1omqAHQXZY1Y022PO+vLWjvZ/k8Hll1D
         2BNi6zuRg7okRcO+x6e7xlempMuVZdhlvFY2IptMc9M/EPFQ5hdaxGgJJ4YpNb7opchm
         iRZMUbrs3o3xQZzlBWyPtUoyUQvB/fcB88p9VxWNeZuebX9YNRrwbYO4+jNH+Cy3H57B
         JdLF6jJ5w+S7ZGdtUY6Chg7QsbhDHW7wg0ymzqWqKhJfQbvSUhc0QkwMgR3IYhXK6W5w
         2P2A==
X-Received: by 10.152.10.203 with SMTP id k11mr23767508lab.30.1410723104333;
        Sun, 14 Sep 2014 12:31:44 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.31.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:31:43 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Subject: [RFC 02/18] MIPS: ar231x: add basic AR5312 SoC support
Date:   Sun, 14 Sep 2014 23:33:17 +0400
Message-Id: <1410723213-22440-3-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42545
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

Add basic support for Atheros AR5312/AR2312 SoCs: registers definition
file and initial setup code.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 arch/mips/Kconfig                               |   1 +
 arch/mips/ar231x/Kconfig                        |   4 +
 arch/mips/ar231x/Makefile                       |   2 +
 arch/mips/ar231x/ar5312.c                       | 143 ++++++++++++++++++
 arch/mips/ar231x/ar5312.h                       |  18 +++
 arch/mips/ar231x/board.c                        |   5 +
 arch/mips/ar231x/prom.c                         |   3 +
 arch/mips/include/asm/mach-ar231x/ar5312_regs.h | 190 ++++++++++++++++++++++++
 8 files changed, 366 insertions(+)
 create mode 100644 arch/mips/ar231x/Kconfig
 create mode 100644 arch/mips/ar231x/ar5312.c
 create mode 100644 arch/mips/ar231x/ar5312.h
 create mode 100644 arch/mips/include/asm/mach-ar231x/ar5312_regs.h

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 6adae4c..bd81f7a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -845,6 +845,7 @@ config MIPS_PARAVIRT
 endchoice
 
 source "arch/mips/alchemy/Kconfig"
+source "arch/mips/ar231x/Kconfig"
 source "arch/mips/ath79/Kconfig"
 source "arch/mips/bcm47xx/Kconfig"
 source "arch/mips/bcm63xx/Kconfig"
diff --git a/arch/mips/ar231x/Kconfig b/arch/mips/ar231x/Kconfig
new file mode 100644
index 0000000..7634a64
--- /dev/null
+++ b/arch/mips/ar231x/Kconfig
@@ -0,0 +1,4 @@
+config SOC_AR5312
+	bool "Atheros AR5312/AR2312+ SoC support"
+	depends on AR231X
+	default y
diff --git a/arch/mips/ar231x/Makefile b/arch/mips/ar231x/Makefile
index 9199fa1..3361619 100644
--- a/arch/mips/ar231x/Makefile
+++ b/arch/mips/ar231x/Makefile
@@ -9,3 +9,5 @@
 #
 
 obj-y += board.o prom.o devices.o
+
+obj-$(CONFIG_SOC_AR5312) += ar5312.o
diff --git a/arch/mips/ar231x/ar5312.c b/arch/mips/ar231x/ar5312.c
new file mode 100644
index 0000000..909bee0
--- /dev/null
+++ b/arch/mips/ar231x/ar5312.c
@@ -0,0 +1,143 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 FON Technology, SL.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006-2009 Felix Fietkau <nbd@openwrt.org>
+ * Copyright (C) 2012 Alexandros C. Couloumbis <alex@ozo.com>
+ */
+
+/*
+ * Platform devices for Atheros AR5312 SoCs
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/reboot.h>
+#include <asm/bootinfo.h>
+#include <asm/reboot.h>
+#include <asm/time.h>
+
+#include <ar5312_regs.h>
+#include <ar231x.h>
+
+#include "devices.h"
+#include "ar5312.h"
+
+static void ar5312_restart(char *command)
+{
+	/* reset the system */
+	local_irq_disable();
+	while (1)
+		ar231x_write_reg(AR5312_RESET, AR5312_RESET_SYSTEM);
+}
+
+/*
+ * This table is indexed by bits 5..4 of the CLOCKCTL1 register
+ * to determine the predevisor value.
+ */
+static unsigned clockctl1_predivide_table[4] __initdata = { 1, 2, 4, 5 };
+
+static unsigned __init ar5312_cpu_frequency(void)
+{
+	u32 scratch, devid, clock_ctl1;
+	u32 predivide_mask, multiplier_mask, doubler_mask;
+	unsigned predivide_shift, multiplier_shift;
+	unsigned predivide_select, predivisor, multiplier;
+
+	/* Trust the bootrom's idea of cpu frequency. */
+	scratch = ar231x_read_reg(AR5312_SCRATCH);
+	if (scratch)
+		return scratch;
+
+	devid = ar231x_read_reg(AR5312_REV);
+	devid = (devid & AR5312_REV_MAJ) >> AR5312_REV_MAJ_S;
+	if (devid == AR5312_REV_MAJ_AR2313) {
+		predivide_mask = AR2313_CLOCKCTL1_PREDIVIDE_MASK;
+		predivide_shift = AR2313_CLOCKCTL1_PREDIVIDE_SHIFT;
+		multiplier_mask = AR2313_CLOCKCTL1_MULTIPLIER_MASK;
+		multiplier_shift = AR2313_CLOCKCTL1_MULTIPLIER_SHIFT;
+		doubler_mask = AR2313_CLOCKCTL1_DOUBLER_MASK;
+	} else { /* AR5312 and AR2312 */
+		predivide_mask = AR5312_CLOCKCTL1_PREDIVIDE_MASK;
+		predivide_shift = AR5312_CLOCKCTL1_PREDIVIDE_SHIFT;
+		multiplier_mask = AR5312_CLOCKCTL1_MULTIPLIER_MASK;
+		multiplier_shift = AR5312_CLOCKCTL1_MULTIPLIER_SHIFT;
+		doubler_mask = AR5312_CLOCKCTL1_DOUBLER_MASK;
+	}
+
+	/*
+	 * Clocking is derived from a fixed 40MHz input clock.
+	 *
+	 *  cpu_freq = input_clock * MULT (where MULT is PLL multiplier)
+	 *  sys_freq = cpu_freq / 4	  (used for APB clock, serial,
+	 *				   flash, Timer, Watchdog Timer)
+	 *
+	 *  cnt_freq = cpu_freq / 2	  (use for CPU count/compare)
+	 *
+	 * So, for example, with a PLL multiplier of 5, we have
+	 *
+	 *  cpu_freq = 200MHz
+	 *  sys_freq = 50MHz
+	 *  cnt_freq = 100MHz
+	 *
+	 * We compute the CPU frequency, based on PLL settings.
+	 */
+
+	clock_ctl1 = ar231x_read_reg(AR5312_CLOCKCTL1);
+	predivide_select = (clock_ctl1 & predivide_mask) >> predivide_shift;
+	predivisor = clockctl1_predivide_table[predivide_select];
+	multiplier = (clock_ctl1 & multiplier_mask) >> multiplier_shift;
+
+	if (clock_ctl1 & doubler_mask)
+		multiplier <<= 1;
+
+	return (40000000 / predivisor) * multiplier;
+}
+
+static inline unsigned ar5312_sys_frequency(void)
+{
+	return ar5312_cpu_frequency() / 4;
+}
+
+void __init ar5312_plat_time_init(void)
+{
+	if (!is_5312())
+		return;
+
+	mips_hpt_frequency = ar5312_cpu_frequency() / 2;
+}
+
+void __init ar5312_plat_mem_setup(void)
+{
+	if (!is_5312())
+		return;
+
+	/* Clear any lingering AHB errors */
+	ar231x_read_reg(AR5312_PROCADDR);
+	ar231x_read_reg(AR5312_DMAADDR);
+	ar231x_write_reg(AR5312_WD_CTRL, AR5312_WD_CTRL_IGNORE_EXPIRATION);
+
+	_machine_restart = ar5312_restart;
+}
+
+void __init ar5312_prom_init(void)
+{
+	u32 memsize, memcfg, bank0_ac, bank1_ac;
+
+	if (!is_5312())
+		return;
+
+	/* Detect memory size */
+	memcfg = ar231x_read_reg(AR5312_MEM_CFG1);
+	bank0_ac = AR231X_REG_MS(memcfg, AR5312_MEM_CFG1_AC0);
+	bank1_ac = AR231X_REG_MS(memcfg, AR5312_MEM_CFG1_AC1);
+	memsize = (bank0_ac ? (1 << (bank0_ac + 1)) : 0) +
+		  (bank1_ac ? (1 << (bank1_ac + 1)) : 0);
+	memsize <<= 20;
+	add_memory_region(0, memsize, BOOT_MEM_RAM);
+}
+
diff --git a/arch/mips/ar231x/ar5312.h b/arch/mips/ar231x/ar5312.h
new file mode 100644
index 0000000..339b28e
--- /dev/null
+++ b/arch/mips/ar231x/ar5312.h
@@ -0,0 +1,18 @@
+#ifndef __AR5312_H
+#define __AR5312_H
+
+#ifdef CONFIG_SOC_AR5312
+
+void ar5312_plat_time_init(void);
+void ar5312_plat_mem_setup(void);
+void ar5312_prom_init(void);
+
+#else
+
+static inline void ar5312_plat_time_init(void) {}
+static inline void ar5312_plat_mem_setup(void) {}
+static inline void ar5312_prom_init(void) {}
+
+#endif
+
+#endif	/* __AR5312_H */
diff --git a/arch/mips/ar231x/board.c b/arch/mips/ar231x/board.c
index 9cde045..0014967 100644
--- a/arch/mips/ar231x/board.c
+++ b/arch/mips/ar231x/board.c
@@ -16,6 +16,8 @@
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 
+#include "ar5312.h"
+
 static void ar231x_halt(void)
 {
 	local_irq_disable();
@@ -28,6 +30,8 @@ void __init plat_mem_setup(void)
 	_machine_halt = ar231x_halt;
 	pm_power_off = ar231x_halt;
 
+	ar5312_plat_mem_setup();
+
 	/* Disable data watchpoints */
 	write_c0_watchlo0(0);
 }
@@ -38,6 +42,7 @@ asmlinkage void plat_irq_dispatch(void)
 
 void __init plat_time_init(void)
 {
+	ar5312_plat_time_init();
 }
 
 unsigned int __cpuinit get_c0_compare_int(void)
diff --git a/arch/mips/ar231x/prom.c b/arch/mips/ar231x/prom.c
index 522357f..d3efdd8 100644
--- a/arch/mips/ar231x/prom.c
+++ b/arch/mips/ar231x/prom.c
@@ -17,8 +17,11 @@
 #include <linux/init.h>
 #include <asm/bootinfo.h>
 
+#include "ar5312.h"
+
 void __init prom_init(void)
 {
+	ar5312_prom_init();
 }
 
 void __init prom_free_prom_memory(void)
diff --git a/arch/mips/include/asm/mach-ar231x/ar5312_regs.h b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
new file mode 100644
index 0000000..5eb22fd
--- /dev/null
+++ b/arch/mips/include/asm/mach-ar231x/ar5312_regs.h
@@ -0,0 +1,190 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 Atheros Communications, Inc.,  All Rights Reserved.
+ * Copyright (C) 2006 Imre Kaloz <kaloz@openwrt.org>
+ * Copyright (C) 2006 Felix Fietkau <nbd@openwrt.org>
+ */
+
+#ifndef __ASM_MACH_AR231X_AR5312_REGS_H
+#define __ASM_MACH_AR231X_AR5312_REGS_H
+
+/*
+ * Address Map
+ *
+ * The AR5312 supports 2 enet MACS, even though many reference boards only
+ * actually use 1 of them (i.e. Only MAC 0 is actually connected to an enet
+ * PHY or PHY switch. The AR2312 supports 1 enet MAC.
+ */
+#define AR5312_WLAN0		0x18000000
+#define AR5312_WLAN1		0x18500000
+#define AR5312_ENET0		0x18100000
+#define AR5312_ENET1		0x18200000
+#define AR5312_SDRAMCTL		0x18300000
+#define AR5312_FLASHCTL		0x18400000
+#define AR5312_APBBASE		0x1c000000
+#define AR5312_UART0		0x1c000000	/* UART MMR */
+#define AR5312_FLASH		0x1e000000
+
+/*
+ * Need these defines to determine true number of ethernet MACs
+ */
+#define AR5312_AR5312_REV2	0x0052		/* AR5312 WMAC (AP31) */
+#define AR5312_AR5312_REV7	0x0057		/* AR5312 WMAC (AP30-040) */
+#define AR5312_AR2313_REV8	0x0058		/* AR2313 WMAC (AP43-030) */
+
+/* Reset/Timer Block Address Map */
+#define AR5312_RESETTMR		(AR5312_APBBASE  + 0x3000)
+#define AR5312_TIMER		(AR5312_RESETTMR + 0x0000) /* countdown timer */
+#define AR5312_WD_CTRL		(AR5312_RESETTMR + 0x0008) /* watchdog cntrl */
+#define AR5312_WD_TIMER		(AR5312_RESETTMR + 0x000c) /* watchdog timer */
+#define AR5312_ISR		(AR5312_RESETTMR + 0x0010) /* Intr Status Reg */
+#define AR5312_IMR		(AR5312_RESETTMR + 0x0014) /* Intr Mask Reg */
+#define AR5312_RESET		(AR5312_RESETTMR + 0x0020)
+#define AR5312_CLOCKCTL1	(AR5312_RESETTMR + 0x0064)
+#define AR5312_SCRATCH		(AR5312_RESETTMR + 0x006c)
+#define AR5312_PROCADDR		(AR5312_RESETTMR + 0x0070)
+#define AR5312_PROC1		(AR5312_RESETTMR + 0x0074)
+#define AR5312_DMAADDR		(AR5312_RESETTMR + 0x0078)
+#define AR5312_DMA1		(AR5312_RESETTMR + 0x007c)
+#define AR5312_ENABLE		(AR5312_RESETTMR + 0x0080) /* interface enb */
+#define AR5312_REV		(AR5312_RESETTMR + 0x0090) /* revision */
+
+/* AR5312_WD_CTRL register bit field definitions */
+#define AR5312_WD_CTRL_IGNORE_EXPIRATION	0x0000
+#define AR5312_WD_CTRL_NMI			0x0001
+#define AR5312_WD_CTRL_RESET			0x0002
+
+/* AR5312_ISR register bit field definitions */
+#define AR5312_ISR_TIMER	0x0001
+#define AR5312_ISR_AHBPROC	0x0002
+#define AR5312_ISR_AHBDMA	0x0004
+#define AR5312_ISR_GPIO		0x0008
+#define AR5312_ISR_UART0	0x0010
+#define AR5312_ISR_UART0DMA	0x0020
+#define AR5312_ISR_WD		0x0040
+#define AR5312_ISR_LOCAL	0x0080
+
+/* AR5312_RESET register bit field definitions */
+#define AR5312_RESET_SYSTEM		0x00000001  /* cold reset full system */
+#define AR5312_RESET_PROC		0x00000002  /* cold reset MIPS core */
+#define AR5312_RESET_WLAN0		0x00000004  /* cold reset WLAN MAC/BB */
+#define AR5312_RESET_EPHY0		0x00000008  /* cold reset ENET0 phy */
+#define AR5312_RESET_EPHY1		0x00000010  /* cold reset ENET1 phy */
+#define AR5312_RESET_ENET0		0x00000020  /* cold reset ENET0 MAC */
+#define AR5312_RESET_ENET1		0x00000040  /* cold reset ENET1 MAC */
+#define AR5312_RESET_UART0		0x00000100  /* cold reset UART0 */
+#define AR5312_RESET_WLAN1		0x00000200  /* cold reset WLAN MAC/BB */
+#define AR5312_RESET_APB		0x00000400  /* cold reset APB ar5312 */
+#define AR5312_RESET_WARM_PROC		0x00001000  /* warm reset MIPS core */
+#define AR5312_RESET_WARM_WLAN0_MAC	0x00002000  /* warm reset WLAN0 MAC */
+#define AR5312_RESET_WARM_WLAN0_BB	0x00004000  /* warm reset WLAN0 BB */
+#define AR5312_RESET_NMI		0x00010000  /* send an NMI to the CPU */
+#define AR5312_RESET_WARM_WLAN1_MAC	0x00020000  /* warm reset WLAN1 MAC */
+#define AR5312_RESET_WARM_WLAN1_BB	0x00040000  /* warm reset WLAN1 BB */
+#define AR5312_RESET_LOCAL_BUS		0x00080000  /* reset local bus */
+#define AR5312_RESET_WDOG		0x00100000  /* last reset was a wdt */
+
+#define AR5312_RESET_WMAC0_BITS		(AR5312_RESET_WLAN0 |\
+					 AR5312_RESET_WARM_WLAN0_MAC |\
+					 AR5312_RESET_WARM_WLAN0_BB)
+
+#define AR5312_RESET_WMAC1_BITS		(AR5312_RESET_WLAN1 |\
+					 AR5312_RESET_WARM_WLAN1_MAC |\
+					 AR5312_RESET_WARM_WLAN1_BB)
+
+/* AR5312_CLOCKCTL1 register bit field definitions */
+#define AR5312_CLOCKCTL1_PREDIVIDE_MASK		0x00000030
+#define AR5312_CLOCKCTL1_PREDIVIDE_SHIFT	4
+#define AR5312_CLOCKCTL1_MULTIPLIER_MASK	0x00001f00
+#define AR5312_CLOCKCTL1_MULTIPLIER_SHIFT	8
+#define AR5312_CLOCKCTL1_DOUBLER_MASK		0x00010000
+
+/* Valid for AR5312 and AR2312 */
+#define AR5312_CLOCKCTL1_PREDIVIDE_MASK		0x00000030
+#define AR5312_CLOCKCTL1_PREDIVIDE_SHIFT	4
+#define AR5312_CLOCKCTL1_MULTIPLIER_MASK	0x00001f00
+#define AR5312_CLOCKCTL1_MULTIPLIER_SHIFT	8
+#define AR5312_CLOCKCTL1_DOUBLER_MASK		0x00010000
+
+/* Valid for AR2313 */
+#define AR2313_CLOCKCTL1_PREDIVIDE_MASK		0x00003000
+#define AR2313_CLOCKCTL1_PREDIVIDE_SHIFT	12
+#define AR2313_CLOCKCTL1_MULTIPLIER_MASK	0x001f0000
+#define AR2313_CLOCKCTL1_MULTIPLIER_SHIFT	16
+#define AR2313_CLOCKCTL1_DOUBLER_MASK		0x00000000
+
+/* AR5312_ENABLE register bit field definitions */
+#define AR5312_ENABLE_WLAN0			0x0001
+#define AR5312_ENABLE_ENET0			0x0002
+#define AR5312_ENABLE_ENET1			0x0004
+#define AR5312_ENABLE_UART_AND_WLAN1_PIO	0x0008   /* UART & WLAN1 PIOs */
+#define AR5312_ENABLE_WLAN1_DMA			0x0010   /* WLAN1 DMAs */
+#define AR5312_ENABLE_WLAN1		(AR5312_ENABLE_UART_AND_WLAN1_PIO |\
+					 AR5312_ENABLE_WLAN1_DMA)
+
+/* AR5312_REV register bit field definitions */
+#define AR5312_REV_WMAC_MAJ	0xf000
+#define AR5312_REV_WMAC_MAJ_S	12
+#define AR5312_REV_WMAC_MIN	0x0f00
+#define AR5312_REV_WMAC_MIN_S	8
+#define AR5312_REV_MAJ		0x00f0
+#define AR5312_REV_MAJ_S	4
+#define AR5312_REV_MIN		0x000f
+#define AR5312_REV_MIN_S	0
+#define AR5312_REV_CHIP		(AR5312_REV_MAJ|AR5312_REV_MIN)
+
+/* Major revision numbers, bits 7..4 of Revision ID register */
+#define AR5312_REV_MAJ_AR5312		0x4
+#define AR5312_REV_MAJ_AR2313		0x5
+
+/* Minor revision numbers, bits 3..0 of Revision ID register */
+#define AR5312_REV_MIN_DUAL		0x0	/* Dual WLAN version */
+#define AR5312_REV_MIN_SINGLE		0x1	/* Single WLAN version */
+
+/* AR5312_FLASHCTL register bit field definitions */
+#define AR5312_FLASHCTL_IDCY	0x0000000f	/* Idle cycle turnaround time */
+#define AR5312_FLASHCTL_IDCY_S	0
+#define AR5312_FLASHCTL_WST1	0x000003e0	/* Wait state 1 */
+#define AR5312_FLASHCTL_WST1_S	5
+#define AR5312_FLASHCTL_RBLE	0x00000400	/* Read byte lane enable */
+#define AR5312_FLASHCTL_WST2	0x0000f800	/* Wait state 2 */
+#define AR5312_FLASHCTL_WST2_S	11
+#define AR5312_FLASHCTL_AC	0x00070000	/* Flash addr check (added) */
+#define AR5312_FLASHCTL_AC_S	16
+#define AR5312_FLASHCTL_AC_128K	0x00000000
+#define AR5312_FLASHCTL_AC_256K	0x00010000
+#define AR5312_FLASHCTL_AC_512K	0x00020000
+#define AR5312_FLASHCTL_AC_1M	0x00030000
+#define AR5312_FLASHCTL_AC_2M	0x00040000
+#define AR5312_FLASHCTL_AC_4M	0x00050000
+#define AR5312_FLASHCTL_AC_8M	0x00060000
+#define AR5312_FLASHCTL_AC_RES	0x00070000	/* 16MB is not supported */
+#define AR5312_FLASHCTL_E	0x00080000	/* Flash bank enable (added) */
+#define AR5312_FLASHCTL_BUSERR	0x01000000	/* Bus transfer error flag */
+#define AR5312_FLASHCTL_WPERR	0x02000000	/* Write protect error flag */
+#define AR5312_FLASHCTL_WP	0x04000000	/* Write protect */
+#define AR5312_FLASHCTL_BM	0x08000000	/* Burst mode */
+#define AR5312_FLASHCTL_MW	0x30000000	/* Mem width */
+#define AR5312_FLASHCTL_MW8	0x00000000	/* Mem width x8 */
+#define AR5312_FLASHCTL_MW16	0x10000000	/* Mem width x16 */
+#define AR5312_FLASHCTL_MW32	0x20000000	/* Mem width x32 (not supp) */
+#define AR5312_FLASHCTL_ATNR	0x00000000	/* Access == no retry */
+#define AR5312_FLASHCTL_ATR	0x80000000	/* Access == retry every */
+#define AR5312_FLASHCTL_ATR4	0xc0000000	/* Access == retry every 4 */
+
+/* ARM Flash Controller -- 3 flash banks with either x8 or x16 devices.  */
+#define AR5312_FLASHCTL0	(AR5312_FLASHCTL + 0x00)
+#define AR5312_FLASHCTL1	(AR5312_FLASHCTL + 0x04)
+#define AR5312_FLASHCTL2	(AR5312_FLASHCTL + 0x08)
+
+/* ARM SDRAM Controller -- just enough to determine memory size */
+#define AR5312_MEM_CFG1		(AR5312_SDRAMCTL + 0x04)
+#define AR5312_MEM_CFG1_AC0_M	0x00000700	/* bank 0: SDRAM addr check */
+#define AR5312_MEM_CFG1_AC0_S	8
+#define AR5312_MEM_CFG1_AC1_M	0x00007000	/* bank 1: SDRAM addr check */
+#define AR5312_MEM_CFG1_AC1_S	12
+
+#endif	/* __ASM_MACH_AR231X_AR5312_REGS_H */
-- 
1.8.1.5
