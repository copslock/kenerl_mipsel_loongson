Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 14:24:47 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:47132 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993256AbeGTMX4iTuww (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Jul 2018 14:23:56 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 14/25] MIPS: ath79: move legacy "wdt" and "uart" clock aliases out of soc init
Date:   Fri, 20 Jul 2018 13:58:31 +0200
Message-Id: <20180720115842.8406-15-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720115842.8406-1-john@phrozen.org>
References: <20180720115842.8406-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

From: Felix Fietkau <nbd@nbd.name>

Preparation for reusing functions for DT

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ath79/clock.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 50bc3b01a4c4..e02b819b2f5d 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -110,9 +110,6 @@ static void __init ar71xx_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar724x_clk_init(struct clk *ref_clk, void __iomem *pll_base)
@@ -140,9 +137,6 @@ static void __init ar724x_clocks_init(void)
 	ref_clk = ath79_set_clk(ATH79_CLK_REF, AR724X_BASE_FREQ);
 
 	ar724x_clk_init(ref_clk, ath79_pll_base);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ahb", NULL);
 }
 
 static void __init ar9330_clk_init(struct clk *ref_clk, void __iomem *pll_base)
@@ -218,9 +212,6 @@ static void __init ar933x_clocks_init(void)
 	ref_clk = ath79_set_clk(ATH79_CLK_REF, ref_rate);
 
 	ar9330_clk_init(ref_clk, ath79_pll_base);
-
-	clk_add_alias("wdt", NULL, "ahb", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
@@ -353,9 +344,6 @@ static void __init ar934x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
-
 	iounmap(dpll_base);
 }
 
@@ -439,9 +427,6 @@ static void __init qca953x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static void __init qca955x_clocks_init(void)
@@ -524,9 +509,6 @@ static void __init qca955x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 static void __init qca956x_clocks_init(void)
@@ -628,13 +610,13 @@ static void __init qca956x_clocks_init(void)
 	ath79_set_clk(ATH79_CLK_CPU, cpu_rate);
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
-
-	clk_add_alias("wdt", NULL, "ref", NULL);
-	clk_add_alias("uart", NULL, "ref", NULL);
 }
 
 void __init ath79_clocks_init(void)
 {
+	const char *wdt;
+	const char *uart;
+
 	if (soc_is_ar71xx())
 		ar71xx_clocks_init();
 	else if (soc_is_ar724x() || soc_is_ar913x())
@@ -651,6 +633,20 @@ void __init ath79_clocks_init(void)
 		qca956x_clocks_init();
 	else
 		BUG();
+
+	if (soc_is_ar71xx() || soc_is_ar724x() || soc_is_ar913x()) {
+		wdt = "ahb";
+		uart = "ahb";
+	} else if (soc_is_ar933x()) {
+		wdt = "ahb";
+		uart = "ref";
+	} else {
+		wdt = "ref";
+		uart = "ref";
+	}
+
+	clk_add_alias("wdt", NULL, wdt, NULL);
+	clk_add_alias("uart", NULL, uart, NULL);
 }
 
 unsigned long __init
-- 
2.11.0
