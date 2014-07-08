Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:56:36 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37297 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861345AbaGHOx7dssur (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:59 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 113F928B44E;
        Tue,  8 Jul 2014 16:51:55 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D08D528B95B;
        Tue,  8 Jul 2014 16:51:30 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 5/8] MIPS: BCM63XX: remove !RUNTIME_DETECT from spi code
Date:   Tue,  8 Jul 2014 16:53:21 +0200
Message-Id: <1404831204-30659-6-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41081
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
 arch/mips/bcm63xx/dev-spi.c                        |  4 ---
 .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     | 31 ----------------------
 2 files changed, 35 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-spi.c b/arch/mips/bcm63xx/dev-spi.c
index d12daed..ad448e4 100644
--- a/arch/mips/bcm63xx/dev-spi.c
+++ b/arch/mips/bcm63xx/dev-spi.c
@@ -18,7 +18,6 @@
 #include <bcm63xx_dev_spi.h>
 #include <bcm63xx_regs.h>
 
-#ifdef BCMCPU_RUNTIME_DETECT
 /*
  * register offsets
  */
@@ -41,9 +40,6 @@ static __init void bcm63xx_spi_regs_init(void)
 		BCMCPU_IS_6362() || BCMCPU_IS_6368())
 		bcm63xx_regs_spi = bcm6358_regs_spi;
 }
-#else
-static __init void bcm63xx_spi_regs_init(void) { }
-#endif
 
 static struct resource spi_resources[] = {
 	{
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
index c426cab..2573765 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
@@ -30,26 +30,6 @@ enum bcm63xx_regs_spi {
 	SPI_RX_DATA,
 };
 
-#define __GEN_SPI_RSET_BASE(__cpu, __rset)				\
-	case SPI_## __rset:						\
-		return SPI_## __cpu ##_## __rset;
-
-#define __GEN_SPI_RSET(__cpu)						\
-	switch (reg) {							\
-	__GEN_SPI_RSET_BASE(__cpu, CMD)					\
-	__GEN_SPI_RSET_BASE(__cpu, INT_STATUS)				\
-	__GEN_SPI_RSET_BASE(__cpu, INT_MASK_ST)				\
-	__GEN_SPI_RSET_BASE(__cpu, INT_MASK)				\
-	__GEN_SPI_RSET_BASE(__cpu, ST)					\
-	__GEN_SPI_RSET_BASE(__cpu, CLK_CFG)				\
-	__GEN_SPI_RSET_BASE(__cpu, FILL_BYTE)				\
-	__GEN_SPI_RSET_BASE(__cpu, MSG_TAIL)				\
-	__GEN_SPI_RSET_BASE(__cpu, RX_TAIL)				\
-	__GEN_SPI_RSET_BASE(__cpu, MSG_CTL)				\
-	__GEN_SPI_RSET_BASE(__cpu, MSG_DATA)				\
-	__GEN_SPI_RSET_BASE(__cpu, RX_DATA)				\
-	}
-
 #define __GEN_SPI_REGS_TABLE(__cpu)					\
 	[SPI_CMD]		= SPI_## __cpu ##_CMD,			\
 	[SPI_INT_STATUS]	= SPI_## __cpu ##_INT_STATUS,		\
@@ -66,20 +46,9 @@ enum bcm63xx_regs_spi {
 
 static inline unsigned long bcm63xx_spireg(enum bcm63xx_regs_spi reg)
 {
-#ifdef BCMCPU_RUNTIME_DETECT
 	extern const unsigned long *bcm63xx_regs_spi;
 
 	return bcm63xx_regs_spi[reg];
-#else
-#if defined(CONFIG_BCM63XX_CPU_6338) || defined(CONFIG_BCM63XX_CPU_6348)
-	__GEN_SPI_RSET(6348)
-#endif
-#if defined(CONFIG_BCM63XX_CPU_6358) || defined(CONFIG_BCM63XX_CPU_6362) || \
-	defined(CONFIG_BCM63XX_CPU_6368)
-	__GEN_SPI_RSET(6358)
-#endif
-#endif
-	return 0;
 }
 
 #endif /* BCM63XX_DEV_SPI_H */
-- 
2.0.0
