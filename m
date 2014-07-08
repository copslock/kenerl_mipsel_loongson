Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:54:39 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37254 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861336AbaGHOxr0ibzy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 76ECD28B44E;
        Tue,  8 Jul 2014 16:51:42 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DF74528B952;
        Tue,  8 Jul 2014 16:51:28 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/8] MIPS: BCM63XX: remove !RUNTIME_DETECT code from register sets
Date:   Tue,  8 Jul 2014 16:53:17 +0200
Message-Id: <1404831204-30659-2-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41076
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
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h | 78 ------------------------
 1 file changed, 78 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 3112f08..4d76fc7 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -598,55 +598,6 @@ enum bcm63xx_regs_set {
 
 extern const unsigned long *bcm63xx_regs_base;
 
-#define __GEN_RSET_BASE(__cpu, __rset)					\
-	case RSET_## __rset :						\
-		return BCM_## __cpu ##_## __rset ##_BASE;
-
-#define __GEN_RSET(__cpu)						\
-	switch (set) {							\
-	__GEN_RSET_BASE(__cpu, DSL_LMEM)				\
-	__GEN_RSET_BASE(__cpu, PERF)					\
-	__GEN_RSET_BASE(__cpu, TIMER)					\
-	__GEN_RSET_BASE(__cpu, WDT)					\
-	__GEN_RSET_BASE(__cpu, UART0)					\
-	__GEN_RSET_BASE(__cpu, UART1)					\
-	__GEN_RSET_BASE(__cpu, GPIO)					\
-	__GEN_RSET_BASE(__cpu, SPI)					\
-	__GEN_RSET_BASE(__cpu, HSSPI)					\
-	__GEN_RSET_BASE(__cpu, UDC0)					\
-	__GEN_RSET_BASE(__cpu, OHCI0)					\
-	__GEN_RSET_BASE(__cpu, OHCI_PRIV)				\
-	__GEN_RSET_BASE(__cpu, USBH_PRIV)				\
-	__GEN_RSET_BASE(__cpu, USBD)					\
-	__GEN_RSET_BASE(__cpu, USBDMA)					\
-	__GEN_RSET_BASE(__cpu, MPI)					\
-	__GEN_RSET_BASE(__cpu, PCMCIA)					\
-	__GEN_RSET_BASE(__cpu, PCIE)					\
-	__GEN_RSET_BASE(__cpu, DSL)					\
-	__GEN_RSET_BASE(__cpu, ENET0)					\
-	__GEN_RSET_BASE(__cpu, ENET1)					\
-	__GEN_RSET_BASE(__cpu, ENETDMA)					\
-	__GEN_RSET_BASE(__cpu, ENETDMAC)				\
-	__GEN_RSET_BASE(__cpu, ENETDMAS)				\
-	__GEN_RSET_BASE(__cpu, ENETSW)					\
-	__GEN_RSET_BASE(__cpu, EHCI0)					\
-	__GEN_RSET_BASE(__cpu, SDRAM)					\
-	__GEN_RSET_BASE(__cpu, MEMC)					\
-	__GEN_RSET_BASE(__cpu, DDR)					\
-	__GEN_RSET_BASE(__cpu, M2M)					\
-	__GEN_RSET_BASE(__cpu, ATM)					\
-	__GEN_RSET_BASE(__cpu, XTM)					\
-	__GEN_RSET_BASE(__cpu, XTMDMA)					\
-	__GEN_RSET_BASE(__cpu, XTMDMAC)					\
-	__GEN_RSET_BASE(__cpu, XTMDMAS)					\
-	__GEN_RSET_BASE(__cpu, PCM)					\
-	__GEN_RSET_BASE(__cpu, PCMDMA)					\
-	__GEN_RSET_BASE(__cpu, PCMDMAC)					\
-	__GEN_RSET_BASE(__cpu, PCMDMAS)					\
-	__GEN_RSET_BASE(__cpu, RNG)					\
-	__GEN_RSET_BASE(__cpu, MISC)					\
-	}
-
 #define __GEN_CPU_REGS_TABLE(__cpu)					\
 	[RSET_DSL_LMEM]		= BCM_## __cpu ##_DSL_LMEM_BASE,	\
 	[RSET_PERF]		= BCM_## __cpu ##_PERF_BASE,		\
@@ -693,36 +644,7 @@ extern const unsigned long *bcm63xx_regs_base;
 
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 {
-#ifdef BCMCPU_RUNTIME_DETECT
 	return bcm63xx_regs_base[set];
-#else
-#ifdef CONFIG_BCM63XX_CPU_3368
-	__GEN_RSET(3368)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6328
-	__GEN_RSET(6328)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6338
-	__GEN_RSET(6338)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6345
-	__GEN_RSET(6345)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6348
-	__GEN_RSET(6348)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6358
-	__GEN_RSET(6358)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6362
-	__GEN_RSET(6362)
-#endif
-#ifdef CONFIG_BCM63XX_CPU_6368
-	__GEN_RSET(6368)
-#endif
-#endif
-	/* unreached */
-	return 0;
 }
 
 /*
-- 
2.0.0
