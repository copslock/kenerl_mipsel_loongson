Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:56:15 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37293 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861344AbaGHOx56ynwg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 7890B28B952;
        Tue,  8 Jul 2014 16:51:53 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 5938428BB81;
        Tue,  8 Jul 2014 16:51:31 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 6/8] MIPS: BCM63XX: remove !RUNTIME_DETECT usage from enet code
Date:   Tue,  8 Jul 2014 16:53:22 +0200
Message-Id: <1404831204-30659-7-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41080
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

---
 arch/mips/bcm63xx/dev-enet.c                       |  4 --
 .../include/asm/mach-bcm63xx/bcm63xx_dev_enet.h    | 46 ----------------------
 2 files changed, 50 deletions(-)

diff --git a/arch/mips/bcm63xx/dev-enet.c b/arch/mips/bcm63xx/dev-enet.c
index 52bc01d..e828477 100644
--- a/arch/mips/bcm63xx/dev-enet.c
+++ b/arch/mips/bcm63xx/dev-enet.c
@@ -14,7 +14,6 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
-#ifdef BCMCPU_RUNTIME_DETECT
 static const unsigned long bcm6348_regs_enetdmac[] = {
 	[ENETDMAC_CHANCFG]	= ENETDMAC_CHANCFG_REG,
 	[ENETDMAC_IR]		= ENETDMAC_IR_REG,
@@ -43,9 +42,6 @@ static __init void bcm63xx_enetdmac_regs_init(void)
 	else
 		bcm63xx_regs_enetdmac = bcm6348_regs_enetdmac;
 }
-#else
-static __init void bcm63xx_enetdmac_regs_init(void) { }
-#endif
 
 static struct resource shared_res[] = {
 	{
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
index 753953e..466fc85 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_enet.h
@@ -112,55 +112,9 @@ enum bcm63xx_regs_enetdmac {
 
 static inline unsigned long bcm63xx_enetdmacreg(enum bcm63xx_regs_enetdmac reg)
 {
-#ifdef BCMCPU_RUNTIME_DETECT
 	extern const unsigned long *bcm63xx_regs_enetdmac;
 
 	return bcm63xx_regs_enetdmac[reg];
-#else
-#ifdef CONFIG_BCM63XX_CPU_6345
-	switch (reg) {
-	case ENETDMAC_CHANCFG:
-		return ENETDMA_6345_CHANCFG_REG;
-	case ENETDMAC_IR:
-		return ENETDMA_6345_IR_REG;
-	case ENETDMAC_IRMASK:
-		return ENETDMA_6345_IRMASK_REG;
-	case ENETDMAC_MAXBURST:
-		return ENETDMA_6345_MAXBURST_REG;
-	case ENETDMAC_BUFALLOC:
-		return ENETDMA_6345_BUFALLOC_REG;
-	case ENETDMAC_RSTART:
-		return ENETDMA_6345_RSTART_REG;
-	case ENETDMAC_FC:
-		return ENETDMA_6345_FC_REG;
-	case ENETDMAC_LEN:
-		return ENETDMA_6345_LEN_REG;
-	}
-#endif
-#if defined(CONFIG_BCM63XX_CPU_6328) || \
-	defined(CONFIG_BCM63XX_CPU_6338) || \
-	defined(CONFIG_BCM63XX_CPU_6348) || \
-	defined(CONFIG_BCM63XX_CPU_6358) || \
-	defined(CONFIG_BCM63XX_CPU_6362) || \
-	defined(CONFIG_BCM63XX_CPU_6368)
-	switch (reg) {
-	case ENETDMAC_CHANCFG:
-		return ENETDMAC_CHANCFG_REG;
-	case ENETDMAC_IR:
-		return ENETDMAC_IR_REG;
-	case ENETDMAC_IRMASK:
-		return ENETDMAC_IRMASK_REG;
-	case ENETDMAC_MAXBURST:
-		return ENETDMAC_MAXBURST_REG;
-	case ENETDMAC_BUFALLOC:
-	case ENETDMAC_RSTART:
-	case ENETDMAC_FC:
-	case ENETDMAC_LEN:
-		return 0;
-	}
-#endif
-#endif
-	return 0;
 }
 
 
-- 
2.0.0
