Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 13:03:39 +0100 (CET)
Received: from smtp3-g21.free.fr ([212.27.42.3]:47281 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013022AbbKVMD1Nk6fw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 13:03:27 +0100
Received: from localhost.localdomain (unknown [78.54.96.206])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 82022A6236;
        Sun, 22 Nov 2015 13:03:04 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Weijie Gao <hackpascal@gmail.com>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] MIPS: ath79: Fix the ar913x reference clock rate
Date:   Sun, 22 Nov 2015 13:03:05 +0100
Message-Id: <1448193785-31072-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1448193785-31072-1-git-send-email-albeu@free.fr>
References: <1448193785-31072-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50039
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

The reference clock on ar913x is at 40MHz and not 5MHz. The current
implementation use the wrong reference rate because it doesn't take
the PLL divider in account. But if we fix the code to use the divider
it becomes identical with the implementation for ar724x, so just drop
the broken ar913x implementation.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/clock.c | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index ed28465..618dfd7 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -27,7 +27,6 @@
 
 #define AR71XX_BASE_FREQ	40000000
 #define AR724X_BASE_FREQ	40000000
-#define AR913X_BASE_FREQ	5000000
 
 static struct clk *clks[3];
 static struct clk_onecell_data clk_data = {
@@ -123,39 +122,6 @@ static void __init ar724x_clocks_init(void)
 	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
-static void __init ar913x_clocks_init(void)
-{
-	unsigned long ref_rate;
-	unsigned long cpu_rate;
-	unsigned long ddr_rate;
-	unsigned long ahb_rate;
-	u32 pll;
-	u32 freq;
-	u32 div;
-
-	ref_rate = AR913X_BASE_FREQ;
-	pll = ath79_pll_rr(AR913X_PLL_REG_CPU_CONFIG);
-
-	div = ((pll >> AR913X_PLL_FB_SHIFT) & AR913X_PLL_FB_MASK);
-	freq = div * ref_rate;
-
-	cpu_rate = freq;
-
-	div = ((pll >> AR913X_DDR_DIV_SHIFT) & AR913X_DDR_DIV_MASK) + 1;
-	ddr_rate = freq / div;
-
-	div = (((pll >> AR913X_AHB_DIV_SHIFT) & AR913X_AHB_DIV_MASK) + 1) * 2;
-	ahb_rate = cpu_rate / div;
-
-	ath79_add_sys_clkdev("ref", ref_rate);
-	clks[0] = ath79_add_sys_clkdev("cpu", cpu_rate);
-	clks[1] = ath79_add_sys_clkdev("ddr", ddr_rate);
-	clks[2] = ath79_add_sys_clkdev("ahb", ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
-}
-
 static void __init ar933x_clocks_init(void)
 {
 	unsigned long ref_rate;
@@ -443,10 +409,8 @@ void __init ath79_clocks_init(void)
 {
 	if (soc_is_ar71xx())
 		ar71xx_clocks_init();
-	else if (soc_is_ar724x())
+	else if (soc_is_ar724x() || soc_is_ar913x())
 		ar724x_clocks_init();
-	else if (soc_is_ar913x())
-		ar913x_clocks_init();
 	else if (soc_is_ar933x())
 		ar933x_clocks_init();
 	else if (soc_is_ar934x())
-- 
2.0.0
