Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:55:00 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37264 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861329AbaGHOxv7JcnH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:51 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 5CF9128B44E;
        Tue,  8 Jul 2014 16:51:47 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6A5B128B955;
        Tue,  8 Jul 2014 16:51:29 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 2/8] MIPS: BCM63XX: remove !RUNTIME_DETECT from irq setup code
Date:   Tue,  8 Jul 2014 16:53:18 +0200
Message-Id: <1404831204-30659-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 109 ------------------------------------------------
 1 file changed, 109 deletions(-)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 1525f8a..30c6803 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -26,114 +26,6 @@ static void __internal_irq_mask_64(unsigned int irq) __maybe_unused;
 static void __internal_irq_unmask_32(unsigned int irq) __maybe_unused;
 static void __internal_irq_unmask_64(unsigned int irq) __maybe_unused;
 
-#ifndef BCMCPU_RUNTIME_DETECT
-#ifdef CONFIG_BCM63XX_CPU_3368
-#define irq_stat_reg		PERF_IRQSTAT_3368_REG
-#define irq_mask_reg		PERF_IRQMASK_3368_REG
-#define irq_bits		32
-#define is_ext_irq_cascaded	0
-#define ext_irq_start		0
-#define ext_irq_end		0
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_3368
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6328
-#define irq_stat_reg		PERF_IRQSTAT_6328_REG
-#define irq_mask_reg		PERF_IRQMASK_6328_REG
-#define irq_bits		64
-#define is_ext_irq_cascaded	1
-#define ext_irq_start		(BCM_6328_EXT_IRQ0 - IRQ_INTERNAL_BASE)
-#define ext_irq_end		(BCM_6328_EXT_IRQ3 - IRQ_INTERNAL_BASE)
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6328
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6338
-#define irq_stat_reg		PERF_IRQSTAT_6338_REG
-#define irq_mask_reg		PERF_IRQMASK_6338_REG
-#define irq_bits		32
-#define is_ext_irq_cascaded	0
-#define ext_irq_start		0
-#define ext_irq_end		0
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6338
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6345
-#define irq_stat_reg		PERF_IRQSTAT_6345_REG
-#define irq_mask_reg		PERF_IRQMASK_6345_REG
-#define irq_bits		32
-#define is_ext_irq_cascaded	0
-#define ext_irq_start		0
-#define ext_irq_end		0
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6345
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6348
-#define irq_stat_reg		PERF_IRQSTAT_6348_REG
-#define irq_mask_reg		PERF_IRQMASK_6348_REG
-#define irq_bits		32
-#define is_ext_irq_cascaded	0
-#define ext_irq_start		0
-#define ext_irq_end		0
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6348
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6358
-#define irq_stat_reg		PERF_IRQSTAT_6358_REG
-#define irq_mask_reg		PERF_IRQMASK_6358_REG
-#define irq_bits		32
-#define is_ext_irq_cascaded	1
-#define ext_irq_start		(BCM_6358_EXT_IRQ0 - IRQ_INTERNAL_BASE)
-#define ext_irq_end		(BCM_6358_EXT_IRQ3 - IRQ_INTERNAL_BASE)
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6358
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6362
-#define irq_stat_reg		PERF_IRQSTAT_6362_REG
-#define irq_mask_reg		PERF_IRQMASK_6362_REG
-#define irq_bits		64
-#define is_ext_irq_cascaded	1
-#define ext_irq_start		(BCM_6362_EXT_IRQ0 - IRQ_INTERNAL_BASE)
-#define ext_irq_end		(BCM_6362_EXT_IRQ3 - IRQ_INTERNAL_BASE)
-#define ext_irq_count		4
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6362
-#define ext_irq_cfg_reg2	0
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6368
-#define irq_stat_reg		PERF_IRQSTAT_6368_REG
-#define irq_mask_reg		PERF_IRQMASK_6368_REG
-#define irq_bits		64
-#define is_ext_irq_cascaded	1
-#define ext_irq_start		(BCM_6368_EXT_IRQ0 - IRQ_INTERNAL_BASE)
-#define ext_irq_end		(BCM_6368_EXT_IRQ5 - IRQ_INTERNAL_BASE)
-#define ext_irq_count		6
-#define ext_irq_cfg_reg1	PERF_EXTIRQ_CFG_REG_6368
-#define ext_irq_cfg_reg2	PERF_EXTIRQ_CFG_REG2_6368
-#endif
-
-#if irq_bits == 32
-#define dispatch_internal			__dispatch_internal
-#define internal_irq_mask			__internal_irq_mask_32
-#define internal_irq_unmask			__internal_irq_unmask_32
-#else
-#define dispatch_internal			__dispatch_internal_64
-#define internal_irq_mask			__internal_irq_mask_64
-#define internal_irq_unmask			__internal_irq_unmask_64
-#endif
-
-#define irq_stat_addr	(bcm63xx_regset_address(RSET_PERF) + irq_stat_reg)
-#define irq_mask_addr	(bcm63xx_regset_address(RSET_PERF) + irq_mask_reg)
-
-static inline void bcm63xx_init_irq(void)
-{
-}
-#else /* ! BCMCPU_RUNTIME_DETECT */
-
 static u32 irq_stat_addr, irq_mask_addr;
 static void (*dispatch_internal)(void);
 static int is_ext_irq_cascaded;
@@ -234,7 +126,6 @@ static void bcm63xx_init_irq(void)
 		internal_irq_unmask = __internal_irq_unmask_64;
 	}
 }
-#endif /* ! BCMCPU_RUNTIME_DETECT */
 
 static inline u32 get_ext_irq_perf_reg(int irq)
 {
-- 
2.0.0
