Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:05:36 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37269 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834917Ab3CUPDzvoP8D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:55 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3C3s0j0BPgjD; Thu, 21 Mar 2013 16:03:22 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id A51852815AD;
        Thu, 21 Mar 2013 16:03:21 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 6/7] MIPS: BCM63XX: enable pcie for BCM6362
Date:   Thu, 21 Mar 2013 16:03:19 +0100
Message-Id: <1363878200-4523-6-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35934
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

The PCIe controller is almost the same as the BCM6328 one, with only
the SERDES register being at a different location.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |    3 ++-
 arch/mips/pci/pci-bcm63xx.c                       |   11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 129b8a6..243bab9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1365,7 +1365,8 @@
 /*************************************************************************
  * _REG relative to RSET_MISC
  *************************************************************************/
-#define MISC_SERDES_CTRL_REG		0x0
+#define MISC_SERDES_CTRL_6328_REG	0x0
+#define MISC_SERDES_CTRL_6362_REG	0x4
 #define SERDES_PCIE_EN			(1 << 0)
 #define SERDES_PCIE_EXD_EN		(1 << 15)
 
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 88e781c..2eb9542 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -121,11 +121,17 @@ void __iomem *pci_iospace_start;
 static void __init bcm63xx_reset_pcie(void)
 {
 	u32 val;
+	u32 reg;
 
 	/* enable SERDES */
-	val = bcm_misc_readl(MISC_SERDES_CTRL_REG);
+	if (BCMCPU_IS_6328())
+		reg = MISC_SERDES_CTRL_6328_REG;
+	else
+		reg = MISC_SERDES_CTRL_6362_REG;
+
+	val = bcm_misc_readl(reg);
 	val |= SERDES_PCIE_EN | SERDES_PCIE_EXD_EN;
-	bcm_misc_writel(val, MISC_SERDES_CTRL_REG);
+	bcm_misc_writel(val, reg);
 
 	/* reset the PCIe core */
 	bcm63xx_core_set_reset(BCM63XX_RESET_PCIE, 1);
@@ -330,6 +336,7 @@ static int __init bcm63xx_pci_init(void)
 
 	switch (bcm63xx_get_cpu_id()) {
 	case BCM6328_CPU_ID:
+	case BCM6362_CPU_ID:
 		return bcm63xx_register_pcie();
 	case BCM6348_CPU_ID:
 	case BCM6358_CPU_ID:
-- 
1.7.10.4
