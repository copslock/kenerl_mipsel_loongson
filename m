Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2011 20:02:22 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:59803 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903738Ab1LITBy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Dec 2011 20:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 2527D360DCA;
        Fri,  9 Dec 2011 20:01:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id chRBsQK6THr4; Fri,  9 Dec 2011 20:01:53 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id C0ED138FEB9;
        Fri,  9 Dec 2011 20:01:53 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     Matt Mackall <mpm@selenic.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/5] MIPS: BCM63XX: add TRNG peripheral definitions
Date:   Fri,  9 Dec 2011 20:01:08 +0100
Message-Id: <1323457270-16330-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1323457270-16330-1-git-send-email-florian@openwrt.org>
References: <1323457270-16330-1-git-send-email-florian@openwrt.org>
X-archive-position: 32071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7986

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h  |    9 +++++++++
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   13 +++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 5b8d15b..f0ab172 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -130,6 +130,7 @@ enum bcm63xx_regs_set {
 	RSET_PCMDMA,
 	RSET_PCMDMAC,
 	RSET_PCMDMAS,
+	RSET_TRNG
 };
 
 #define RSET_DSL_LMEM_SIZE		(64 * 1024 * 4)
@@ -149,6 +150,7 @@ enum bcm63xx_regs_set {
 #define RSET_XTMDMA_SIZE		256
 #define RSET_XTMDMAC_SIZE(chans)	(16 * (chans))
 #define RSET_XTMDMAS_SIZE(chans)	(16 * (chans))
+#define RSET_TRNG_SIZE			20
 
 /*
  * 6338 register sets base address
@@ -193,6 +195,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6338_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6338_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6338_TRNG_BASE		(0xdeadbeef)
 
 /*
  * 6345 register sets base address
@@ -237,6 +240,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6345_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6345_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6345_TRNG_BASE		(0xdeadbeef)
 
 /*
  * 6348 register sets base address
@@ -278,6 +282,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_PCMDMA_BASE		(0xdeadbeef)
 #define BCM_6348_PCMDMAC_BASE		(0xdeadbeef)
 #define BCM_6348_PCMDMAS_BASE		(0xdeadbeef)
+#define BCM_6348_TRNG_BASE		(0xdeadbeef)
 
 /*
  * 6358 register sets base address
@@ -319,6 +324,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_PCMDMA_BASE		(0xfffe1800)
 #define BCM_6358_PCMDMAC_BASE		(0xfffe1900)
 #define BCM_6358_PCMDMAS_BASE		(0xfffe1a00)
+#define BCM_6358_TRNG_BASE		(0xdeadbeef)
 
 
 /*
@@ -361,6 +367,7 @@ enum bcm63xx_regs_set {
 #define BCM_6368_PCMDMA_BASE		(0xb0005800)
 #define BCM_6368_PCMDMAC_BASE		(0xb0005a00)
 #define BCM_6368_PCMDMAS_BASE		(0xb0005c00)
+#define BCM_6368_TRNG_BASE		(0xb0004180)
 
 
 extern const unsigned long *bcm63xx_regs_base;
@@ -407,6 +414,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	__GEN_RSET_BASE(__cpu, PCMDMA)					\
 	__GEN_RSET_BASE(__cpu, PCMDMAC)					\
 	__GEN_RSET_BASE(__cpu, PCMDMAS)					\
+	__GEN_RSET_BASE(__cpu, TRNG)					\
 	}
 
 #define __GEN_CPU_REGS_TABLE(__cpu)					\
@@ -446,6 +454,7 @@ extern const unsigned long *bcm63xx_regs_base;
 	[RSET_PCMDMA]		= BCM_## __cpu ##_PCMDMA_BASE,		\
 	[RSET_PCMDMAC]		= BCM_## __cpu ##_PCMDMAC_BASE,		\
 	[RSET_PCMDMAS]		= BCM_## __cpu ##_PCMDMAS_BASE,		\
+	[RSET_TRNG]		= BCM_## __cpu ##_TRNG_BASE,		\
 
 
 static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index fdcd78c..0de0bd9 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -973,4 +973,17 @@
 #define M2M_SRCID_REG(x)		((x) * 0x40 + 0x14)
 #define M2M_DSTID_REG(x)		((x) * 0x40 + 0x18)
 
+/*************************************************************************
+ * _REG relative to RSET_TRNG
+ *************************************************************************/
+#define TRNG_CTRL			0x00
+#define TRNG_EN				(1 << 0)
+
+#define TRNG_STAT			0x04
+#define TRNG_AVAIL_MASK			(0xff000000)
+
+#define TRNG_DATA			0x08
+#define TRNG_THRES			0x0c
+#define TRNG_MASK			0x10
+
 #endif /* BCM63XX_REGS_H_ */
-- 
1.7.5.4
