Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Mar 2013 16:05:18 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:37262 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834908Ab3CUPDzurNmI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Mar 2013 16:03:55 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m6tXePbGe-5k; Thu, 21 Mar 2013 16:03:21 +0100 (CET)
Received: from shaker64.lan (dslb-088-073-029-203.pools.arcor-ip.net [88.73.29.203])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 25E8E2815AD;
        Thu, 21 Mar 2013 16:03:21 +0100 (CET)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 5/7] MIPS: BCM63XX: enable SPI controller for BCM6362
Date:   Thu, 21 Mar 2013 16:03:18 +0100
Message-Id: <1363878200-4523-5-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1363878200-4523-1-git-send-email-jogo@openwrt.org>
References: <1363878001-4461-1-git-send-email-jogo@openwrt.org>
 <1363878200-4523-1-git-send-email-jogo@openwrt.org>
X-archive-position: 35933
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

The SPI controller shares the same register layout as the 6358 one.

Signed-off-by: Jonas Gorski <jogo@openwrt.org>
---
 arch/mips/bcm63xx/clk.c                              |    2 ++
 arch/mips/bcm63xx/dev-spi.c                          |    4 ++--
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index b9e948d..e357d55 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -196,6 +196,8 @@ static void spi_set(struct clk *clk, int enable)
 		mask = CKCTL_6348_SPI_EN;
 	else if (BCMCPU_IS_6358())
 		mask = CKCTL_6358_SPI_EN;
+	else if (BCMCPU_IS_6362())
+		mask = CKCTL_6362_SPI_EN;
 	else
 		/* BCMCPU_IS_6368 */
 		mask = CKCTL_6368_SPI_EN;
diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index 2a43825..854e936 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -37,7 +37,7 @@ static __init void bcm63xx_spi_regs_init(void)
 {
 	if (BCMCPU_IS_6338() || BCMCPU_IS_6348())
 		bcm63xx_regs_spi = bcm6348_regs_spi;
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6368())
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6362() || BCMCPU_IS_6368())
 		bcm63xx_regs_spi = bcm6358_regs_spi;
 }
 #else
@@ -98,7 +98,7 @@ int __init bcm63xx_spi_register(void)
 		spi_pdata.msg_ctl_width = SPI_6348_MSG_CTL_WIDTH;
 	}
 
-	if (BCMCPU_IS_6358() || BCMCPU_IS_6368()) {
+	if (BCMCPU_IS_6358() || BCMCPU_IS_6362() || BCMCPU_IS_6368()) {
 		spi_resources[0].end += BCM_6358_RSET_SPI_SIZE - 1;
 		spi_pdata.fifo_size = SPI_6358_MSG_DATA_SIZE;
 		spi_pdata.msg_type_shift = SPI_6358_MSG_TYPE_SHIFT;
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index cc15f7c..6515da9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -75,7 +75,8 @@ static inline unsigned long bcm63xx_spireg(enum bcm63xx_regs_spi reg)
 #if defined(CONFIG_BCM63XX_CPU_6338) || defined(CONFIG_BCM63XX_CPU_6348)
 	__GEN_SPI_RSET(6348)
 #endif
-#if defined(CONFIG_BCM63XX_CPU_6358) || defined(CONFIG_BCM63XX_CPU_6368)
+#if defined(CONFIG_BCM63XX_CPU_6358) || defined(CONFIG_BCM63XX_CPU_6362) || \
+	defined(CONFIG_BCM63XX_CPU_6368)
 	__GEN_SPI_RSET(6358)
 #endif
 #endif
-- 
1.7.10.4
