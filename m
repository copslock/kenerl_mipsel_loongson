Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jul 2014 16:55:26 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:37269 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861342AbaGHOxwpb0ch (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Jul 2014 16:53:52 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3C11928B952;
        Tue,  8 Jul 2014 16:51:48 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from ixxyvirt.lan (p5081183E.dip0.t-ipconnect.de [80.129.24.62])
        by arrakis.dune.hu (Postfix) with ESMTPSA id DF56C28B956;
        Tue,  8 Jul 2014 16:51:29 +0200 (CEST)
From:   Jonas Gorski <jogo@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/8] MIPS: BCM63XX: remove !RUNTIME_DETECT from reset code
Date:   Tue,  8 Jul 2014 16:53:19 +0200
Message-Id: <1404831204-30659-4-git-send-email-jogo@openwrt.org>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
References: <1404831204-30659-1-git-send-email-jogo@openwrt.org>
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41078
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
 arch/mips/bcm63xx/reset.c | 60 -----------------------------------------------
 1 file changed, 60 deletions(-)

diff --git a/arch/mips/bcm63xx/reset.c b/arch/mips/bcm63xx/reset.c
index acbeb1f..d1fe51e 100644
--- a/arch/mips/bcm63xx/reset.c
+++ b/arch/mips/bcm63xx/reset.c
@@ -125,8 +125,6 @@
 #define BCM6368_RESET_PCIE	0
 #define BCM6368_RESET_PCIE_EXT	0
 
-#ifdef BCMCPU_RUNTIME_DETECT
-
 /*
  * core reset bits
  */
@@ -188,64 +186,6 @@ static int __init bcm63xx_reset_bits_init(void)
 
 	return 0;
 }
-#else
-
-#ifdef CONFIG_BCM63XX_CPU_3368
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(3368)
-};
-#define reset_reg PERF_SOFTRESET_6358_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6328
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6328)
-};
-#define reset_reg PERF_SOFTRESET_6328_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6338
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6338)
-};
-#define reset_reg PERF_SOFTRESET_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6345
-static const u32 bcm63xx_reset_bits[] = { };
-#define reset_reg 0
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6348
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6348)
-};
-#define reset_reg PERF_SOFTRESET_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6358
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6358)
-};
-#define reset_reg PERF_SOFTRESET_6358_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6362
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6362)
-};
-#define reset_reg PERF_SOFTRESET_6362_REG
-#endif
-
-#ifdef CONFIG_BCM63XX_CPU_6368
-static const u32 bcm63xx_reset_bits[] = {
-	__GEN_RESET_BITS_TABLE(6368)
-};
-#define reset_reg PERF_SOFTRESET_6368_REG
-#endif
-
-static int __init bcm63xx_reset_bits_init(void) { return 0; }
-#endif
 
 static DEFINE_SPINLOCK(reset_mutex);
 
-- 
2.0.0
