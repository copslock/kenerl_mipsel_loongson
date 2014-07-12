Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Jul 2014 12:51:45 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:46969 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860088AbaGLKuMHT6r0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Jul 2014 12:50:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1A8012845A0;
        Sat, 12 Jul 2014 12:48:04 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (dslb-088-073-046-107.pools.arcor-ip.net [88.73.46.107])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DC392284604;
        Sat, 12 Jul 2014 12:47:47 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Subject: [PATCH 05/10] MIPS: BCM63XX: populate irq_{stat,mask}_addr for second cpu
Date:   Sat, 12 Jul 2014 12:49:37 +0200
Message-Id: <1405162182-30399-6-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
References: <1405162182-30399-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41165
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

Set it to zero if there is no second set.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/irq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/bcm63xx/irq.c b/arch/mips/bcm63xx/irq.c
index 91d1765..f467e44 100644
--- a/arch/mips/bcm63xx/irq.c
+++ b/arch/mips/bcm63xx/irq.c
@@ -342,11 +342,15 @@ static void bcm63xx_init_irq(void)
 
 	irq_stat_addr[0] = bcm63xx_regset_address(RSET_PERF);
 	irq_mask_addr[0] = bcm63xx_regset_address(RSET_PERF);
+	irq_stat_addr[1] = bcm63xx_regset_address(RSET_PERF);
+	irq_mask_addr[1] = bcm63xx_regset_address(RSET_PERF);
 
 	switch (bcm63xx_get_cpu_id()) {
 	case BCM3368_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_3368_REG;
 		irq_mask_addr[0] += PERF_IRQMASK_3368_REG;
+		irq_stat_addr[1] = 0;
+		irq_stat_addr[1] = 0;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_3368;
@@ -354,6 +358,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6328_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6328_REG(0);
 		irq_mask_addr[0] += PERF_IRQMASK_6328_REG(0);
+		irq_stat_addr[1] += PERF_IRQSTAT_6328_REG(1);
+		irq_stat_addr[1] += PERF_IRQMASK_6328_REG(1);
 		irq_bits = 64;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -364,6 +370,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6338_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6338_REG;
 		irq_mask_addr[0] += PERF_IRQMASK_6338_REG;
+		irq_stat_addr[1] = 0;
+		irq_mask_addr[1] = 0;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6338;
@@ -371,6 +379,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6345_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6345_REG;
 		irq_mask_addr[0] += PERF_IRQMASK_6345_REG;
+		irq_stat_addr[1] = 0;
+		irq_mask_addr[1] = 0;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6345;
@@ -378,6 +388,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6348_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6348_REG;
 		irq_mask_addr[0] += PERF_IRQMASK_6348_REG;
+		irq_stat_addr[1] = 0;
+		irq_mask_addr[1] = 0;
 		irq_bits = 32;
 		ext_irq_count = 4;
 		ext_irq_cfg_reg1 = PERF_EXTIRQ_CFG_REG_6348;
@@ -385,6 +397,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6358_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6358_REG(0);
 		irq_mask_addr[0] += PERF_IRQMASK_6358_REG(0);
+		irq_stat_addr[1] += PERF_IRQSTAT_6358_REG(1);
+		irq_mask_addr[1] += PERF_IRQMASK_6358_REG(1);
 		irq_bits = 32;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -395,6 +409,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6362_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6362_REG(0);
 		irq_mask_addr[0] += PERF_IRQMASK_6362_REG(0);
+		irq_stat_addr[1] += PERF_IRQSTAT_6362_REG(1);
+		irq_mask_addr[1] += PERF_IRQMASK_6362_REG(1);
 		irq_bits = 64;
 		ext_irq_count = 4;
 		is_ext_irq_cascaded = 1;
@@ -405,6 +421,8 @@ static void bcm63xx_init_irq(void)
 	case BCM6368_CPU_ID:
 		irq_stat_addr[0] += PERF_IRQSTAT_6368_REG(0);
 		irq_mask_addr[0] += PERF_IRQMASK_6368_REG(0);
+		irq_stat_addr[1] += PERF_IRQSTAT_6368_REG(1);
+		irq_mask_addr[1] += PERF_IRQMASK_6368_REG(1);
 		irq_bits = 64;
 		ext_irq_count = 6;
 		is_ext_irq_cascaded = 1;
-- 
2.0.0
