Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:27:45 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:58302 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993032AbeFYRYcJvr0P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:24:32 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Felix Fietkau <nbd@nbd.name>
Subject: [PATCH 19/25] MIPS: ath79: export switch MDIO reference clock
Date:   Mon, 25 Jun 2018 19:15:43 +0200
Message-Id: <20180625171549.4618-20-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64452
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

On AR934x, the MDIO reference clock can be configured to a fixed 100 MHz
clock. If that feature is not used, it defaults to the main reference
clock, like on all other SoC.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/mips/ath79/clock.c               | 8 ++++++++
 include/dt-bindings/clock/ath79-clk.h | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index c234818b30e1..699f00f096cb 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -42,6 +42,7 @@ static const char * const clk_names[ATH79_CLK_END] = {
 	[ATH79_CLK_DDR] = "ddr",
 	[ATH79_CLK_AHB] = "ahb",
 	[ATH79_CLK_REF] = "ref",
+	[ATH79_CLK_MDIO] = "mdio",
 };
 
 static const char * __init ath79_clk_name(int type)
@@ -342,6 +343,10 @@ static void __init ar934x_clocks_init(void __iomem *pll_base)
 	ath79_set_clk(ATH79_CLK_DDR, ddr_rate);
 	ath79_set_clk(ATH79_CLK_AHB, ahb_rate);
 
+	clk_ctrl = __raw_readl(pll_base + AR934X_PLL_SWITCH_CLOCK_CONTROL_REG);
+	if (clk_ctrl & AR934X_PLL_SWITCH_CLOCK_CONTROL_MDIO_CLK_SEL)
+		ath79_set_clk(ATH79_CLK_MDIO, 100 * 1000 * 1000);
+
 	iounmap(dpll_base);
 }
 
@@ -698,6 +703,9 @@ static void __init ath79_clocks_init_dt(struct device_node *np)
 	else if (of_device_is_compatible(np, "qca,qca9560-pll"))
 		qca956x_clocks_init(pll_base);
 
+	if (!clks[ATH79_CLK_MDIO])
+		clks[ATH79_CLK_MDIO] = clks[ATH79_CLK_REF];
+
 	if (of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data)) {
 		pr_err("%pOF: could not register clk provider\n", np);
 		goto err_iounmap;
diff --git a/include/dt-bindings/clock/ath79-clk.h b/include/dt-bindings/clock/ath79-clk.h
index 262d7c5eb248..dcc679a7ad85 100644
--- a/include/dt-bindings/clock/ath79-clk.h
+++ b/include/dt-bindings/clock/ath79-clk.h
@@ -14,7 +14,8 @@
 #define ATH79_CLK_DDR		1
 #define ATH79_CLK_AHB		2
 #define ATH79_CLK_REF		3
+#define ATH79_CLK_MDIO		4
 
-#define ATH79_CLK_END		4
+#define ATH79_CLK_END		5
 
 #endif /* __DT_BINDINGS_ATH79_CLK_H */
-- 
2.11.0
