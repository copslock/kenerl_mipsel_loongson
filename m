Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:04:34 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37251 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827483Ab3CUPDxEPmtN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:53 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7MJVQJv1wbIC; Thu, 21 Mar 2013 16:03:20 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 154EC2815AD;
        Thu, 21 Mar 2013 16:03:20 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/7] MIPS: BCM63XX: rework chip detection
Date:   Thu, 21 Mar 2013 16:03:16 +0100
Message-Id: <1363878200-4523-3-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35931
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Instead of trying to use a correlation of cpu prid and chip id and
hoping they will always be unique, use the cpu prid to determine the
chip id register location and just read out the chip id.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/cpu.c |   87 +++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index ae16626..fef168d 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -240,53 +240,27 @@ static unsigned int detect_memory_size(void)
 
 void __init bcm63xx_cpu_init(void)
 {
-	unsigned int tmp, expected_cpu_id;
+	unsigned int tmp;
 	struct cpuinfo_mips *c = &current_cpu_data;
 	unsigned int cpu = smp_processor_id();
+	u32 chipid_reg;
 
 	/* soc registers location depends on cpu type */
-	expected_cpu_id = 0;
+	chipid_reg = 0;
 
 	switch (c->cputype) {
 	case CPU_BMIPS3300:
-		if ((read_c0_prid() & 0xff00) == PRID_IMP_BMIPS3300_ALT) {
-			expected_cpu_id = BCM6348_CPU_ID;
-			bcm63xx_regs_base = bcm6348_regs_base;
-			bcm63xx_irqs = bcm6348_irqs;
-		} else {
+		if ((read_c0_prid() & 0xff00) != PRID_IMP_BMIPS3300_ALT)
 			__cpu_name[cpu] = "Broadcom BCM6338";
-			expected_cpu_id = BCM6338_CPU_ID;
-			bcm63xx_regs_base = bcm6338_regs_base;
-			bcm63xx_irqs = bcm6338_irqs;
-		}
-		break;
+		/* fall-through */
 	case CPU_BMIPS32:
-		expected_cpu_id = BCM6345_CPU_ID;
-		bcm63xx_regs_base = bcm6345_regs_base;
-		bcm63xx_irqs = bcm6345_irqs;
+		chipid_reg = BCM_6345_PERF_BASE;
 		break;
 	case CPU_BMIPS4350:
-		if ((read_c0_prid() & 0xf0) == 0x10) {
-			expected_cpu_id = BCM6358_CPU_ID;
-			bcm63xx_regs_base = bcm6358_regs_base;
-			bcm63xx_irqs = bcm6358_irqs;
-		} else {
-			/* all newer chips have the same chip id location */
-			u16 chip_id = bcm_readw(BCM_6368_PERF_BASE);
-
-			switch (chip_id) {
-			case BCM6328_CPU_ID:
-				expected_cpu_id = BCM6328_CPU_ID;
-				bcm63xx_regs_base = bcm6328_regs_base;
-				bcm63xx_irqs = bcm6328_irqs;
-				break;
-			case BCM6368_CPU_ID:
-				expected_cpu_id = BCM6368_CPU_ID;
-				bcm63xx_regs_base = bcm6368_regs_base;
-				bcm63xx_irqs = bcm6368_irqs;
-				break;
-			}
-		}
+		if ((read_c0_prid() & 0xf0) == 0x10)
+			chipid_reg = BCM_6345_PERF_BASE;
+		else
+			chipid_reg = BCM_6368_PERF_BASE;
 		break;
 	}
 
@@ -294,20 +268,43 @@ void __init bcm63xx_cpu_init(void)
 	 * really early to panic, but delaying panic would not help since we
 	 * will never get any working console
 	 */
-	if (!expected_cpu_id)
+	if (!chipid_reg)
 		panic("unsupported Broadcom CPU");
 
-	/*
-	 * bcm63xx_regs_base is set, we can access soc registers
-	 */
-
-	/* double check CPU type */
-	tmp = bcm_perf_readl(PERF_REV_REG);
+	/* read out CPU type */
+	tmp = bcm_readl(chipid_reg);
 	bcm63xx_cpu_id = (tmp & REV_CHIPID_MASK) >> REV_CHIPID_SHIFT;
 	bcm63xx_cpu_rev = (tmp & REV_REVID_MASK) >> REV_REVID_SHIFT;
 
-	if (bcm63xx_cpu_id != expected_cpu_id)
-		panic("bcm63xx CPU id mismatch");
+	switch (bcm63xx_cpu_id) {
+	case BCM6328_CPU_ID:
+		bcm63xx_regs_base = bcm6328_regs_base;
+		bcm63xx_irqs = bcm6328_irqs;
+		break;
+	case BCM6338_CPU_ID:
+		bcm63xx_regs_base = bcm6338_regs_base;
+		bcm63xx_irqs = bcm6338_irqs;
+		break;
+	case BCM6345_CPU_ID:
+		bcm63xx_regs_base = bcm6345_regs_base;
+		bcm63xx_irqs = bcm6345_irqs;
+		break;
+	case BCM6348_CPU_ID:
+		bcm63xx_regs_base = bcm6348_regs_base;
+		bcm63xx_irqs = bcm6348_irqs;
+		break;
+	case BCM6358_CPU_ID:
+		bcm63xx_regs_base = bcm6358_regs_base;
+		bcm63xx_irqs = bcm6358_irqs;
+		break;
+	case BCM6368_CPU_ID:
+		bcm63xx_regs_base = bcm6368_regs_base;
+		bcm63xx_irqs = bcm6368_irqs;
+		break;
+	default:
+		panic("unsupported broadcom CPU %x", bcm63xx_cpu_id);
+		break;
+	}
 
 	bcm63xx_cpu_freq = detect_cpu_clock();
 	bcm63xx_memory_size = detect_memory_size();
-- 
1.7.10.4
