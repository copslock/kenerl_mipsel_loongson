Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 14:37:36 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:56890 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025398AbbDQMhJsVquq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 14:37:09 +0200
Received: from localhost.localdomain (unknown [78.54.181.212])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id A491E4C80DE;
        Fri, 17 Apr 2015 14:34:48 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] MIPS: ath79: Correctly name the defines for the PLL_FB register
Date:   Fri, 17 Apr 2015 14:36:16 +0200
Message-Id: <1429274178-4337-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429274178-4337-1-git-send-email-albeu@free.fr>
References: <1429274178-4337-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

This register is named PLL_FB and is not a divider but a multiplier.
To make things less confusing rename the ARxxxx_PLL_DIV_SHIFT and
ARxxxx_PLL_DIV_MASK macros to ARxxxx_PLL_FB_SHIFT and
ARxxxx_PLL_FB_MASK.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/clock.c                        |  6 +++---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 26479f4..226ddf0 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -62,7 +62,7 @@ static void __init ar71xx_clocks_init(void)
 
 	pll = ath79_pll_rr(AR71XX_PLL_REG_CPU_CONFIG);
 
-	div = ((pll >> AR71XX_PLL_DIV_SHIFT) & AR71XX_PLL_DIV_MASK) + 1;
+	div = ((pll >> AR71XX_PLL_FB_SHIFT) & AR71XX_PLL_FB_MASK) + 1;
 	freq = div * ref_rate;
 
 	div = ((pll >> AR71XX_CPU_DIV_SHIFT) & AR71XX_CPU_DIV_MASK) + 1;
@@ -96,7 +96,7 @@ static void __init ar724x_clocks_init(void)
 	ref_rate = AR724X_BASE_FREQ;
 	pll = ath79_pll_rr(AR724X_PLL_REG_CPU_CONFIG);
 
-	div = ((pll >> AR724X_PLL_DIV_SHIFT) & AR724X_PLL_DIV_MASK);
+	div = ((pll >> AR724X_PLL_FB_SHIFT) & AR724X_PLL_FB_MASK);
 	freq = div * ref_rate;
 
 	div = ((pll >> AR724X_PLL_REF_DIV_SHIFT) & AR724X_PLL_REF_DIV_MASK);
@@ -132,7 +132,7 @@ static void __init ar913x_clocks_init(void)
 	ref_rate = AR913X_BASE_FREQ;
 	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
 
-	div = ((pll >> AR913X_PLL_DIV_SHIFT) & AR913X_PLL_DIV_MASK);
+	div = ((pll >> AR913X_PLL_FB_SHIFT) & AR913X_PLL_FB_MASK);
 	freq = div * ref_rate;
 
 	cpu_rate = freq;
diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index cd41e93..aa3800c 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -157,8 +157,8 @@
 #define AR71XX_PLL_REG_ETH0_INT_CLOCK	0x10
 #define AR71XX_PLL_REG_ETH1_INT_CLOCK	0x14
 
-#define AR71XX_PLL_DIV_SHIFT		3
-#define AR71XX_PLL_DIV_MASK		0x1f
+#define AR71XX_PLL_FB_SHIFT		3
+#define AR71XX_PLL_FB_MASK		0x1f
 #define AR71XX_CPU_DIV_SHIFT		16
 #define AR71XX_CPU_DIV_MASK		0x3
 #define AR71XX_DDR_DIV_SHIFT		18
@@ -169,8 +169,8 @@
 #define AR724X_PLL_REG_CPU_CONFIG	0x00
 #define AR724X_PLL_REG_PCIE_CONFIG	0x18
 
-#define AR724X_PLL_DIV_SHIFT		0
-#define AR724X_PLL_DIV_MASK		0x3ff
+#define AR724X_PLL_FB_SHIFT		0
+#define AR724X_PLL_FB_MASK		0x3ff
 #define AR724X_PLL_REF_DIV_SHIFT	10
 #define AR724X_PLL_REF_DIV_MASK		0xf
 #define AR724X_AHB_DIV_SHIFT		19
@@ -183,8 +183,8 @@
 #define AR913X_PLL_REG_ETH0_INT_CLOCK	0x14
 #define AR913X_PLL_REG_ETH1_INT_CLOCK	0x18
 
-#define AR913X_PLL_DIV_SHIFT		0
-#define AR913X_PLL_DIV_MASK		0x3ff
+#define AR913X_PLL_FB_SHIFT		0
+#define AR913X_PLL_FB_MASK		0x3ff
 #define AR913X_DDR_DIV_SHIFT		22
 #define AR913X_DDR_DIV_MASK		0x3
 #define AR913X_AHB_DIV_SHIFT		19
-- 
2.0.0
