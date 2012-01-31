Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 15:17:04 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59765 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904038Ab2AaOMs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 15:12:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 68D66358976;
        Tue, 31 Jan 2012 15:12:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id roZ35Ixyb7dv; Tue, 31 Jan 2012 15:12:47 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id BE30E338ACE;
        Tue, 31 Jan 2012 15:12:47 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/5 v2] MIPS: BCM63XX: add RNG peripheral definitions
Date:   Tue, 31 Jan 2012 15:12:23 +0100
Message-Id: <1328019145-5946-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328019145-5946-1-git-send-email-florian@openwrt.org>
References: <1328019145-5946-1-git-send-email-florian@openwrt.org>
X-archive-position: 32362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
Changes since v1:
- renamed TRNG -> RNG to be consistent everywhere

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    9 +++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   14 ++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 82a8175..0c981aa 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -129,6 +129,7 @@ enum bcm63xx_regs_set {
 	RSET_PCMDMA,
 	RSET_PCMDMAC,
 	RSET_PCMDMAS,
+	RSET_RNG
 };
 
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
@@ -152,6 +153,7 @@ enum bcm63xx_regs_set {
 #define RSET_XTMDMA_SIZE		256
 #define RSET_XTMDMAC_SIZE(chans)	(16 * (chans))
 #define RSET_XTMDMAS_SIZE(chans)	(16 * (chans))
+#define RSET_RNG_SIZE			20
 
 /*
  * 6338 register sets base address
@@ -195,6 +197,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6338_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6338_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6338_RNG_BASE		(0xdeadbeef)
 
 /*
  * 6345 register sets base address
@@ -238,6 +241,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6345_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6345_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6345_RNG_BASE		(0xdeadbeef)
 
 /*
  * 6348 register sets base address
@@ -278,6 +282,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6348_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6348_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6348_RNG_BASE		(0xdeadbeef)
 
 /*
  * 6358 register sets base address
@@ -318,6 +323,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_PCMDMA_BASE		(0xfffe1800)
 #define BCM_6358_PCMDMAC_BASE		(0xfffe1900)
 #define BCM_6358_PCMDMAS_BASE		(0xfffe1a00)
+#define BCM_6358_RNG_BASE		(0xdeadbeef)
 
 
 /*
@@ -359,6 +365,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_PCMDMA_BASE		(0xb0005800)
 #define BCM_6368_PCMDMAC_BASE		(0xb0005a00)
 #define BCM_6368_PCMDMAS_BASE		(0xb0005c00)
+#define BCM_6368_RNG_BASE		(0xb0004180)
 
 
 extern const unsigned long *bcm63xx_regs_base;
@@ -404,6 +411,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, PCMDMA)					\
 	__GEN_RSET_BASE(__cpu, PCMDMAC)					\
 	__GEN_RSET_BASE(__cpu, PCMDMAS)					\
+	__GEN_RSET_BASE(__cpu, RNG)					\
 	}
 
 #define __GEN_CPU_REGS_TABLE(__cpu)					\
@@ -442,6 +450,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_PCMDMA]		= BCM_## __cpu ##_PCMDMA_BASE,		\
 	[RSET_PCMDMAC]		= BCM_## __cpu ##_PCMDMAC_BASE,		\
 	[RSET_PCMDMAS]		= BCM_## __cpu ##_PCMDMAS_BASE,		\
+	[RSET_RNG]		= BCM_## __cpu ##_RNG_BASE,		\
 
 
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index be107e9..6fdde35 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -1092,4 +1092,18 @@
 #define SPI_SSOFFTIME_SHIFT		3
 #define SPI_BYTE_SWAP			0x80
 
+/*************************************************************************
+ * _REG relative to RSET_RNG
+ *************************************************************************/
+
+#define RNG_CTRL			0x00
+#define RNG_EN				(1 << 0)
+
+#define RNG_STAT			0x04
+#define RNG_AVAIL_MASK			(0xff000000)
+
+#define RNG_DATA			0x08
+#define RNG_THRES			0x0c
+#define RNG_MASK			0x10
+
 #endif /* BCM63XX_REGS_H_ */
-- 
1.7.5.4
