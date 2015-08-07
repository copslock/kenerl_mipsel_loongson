Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 18:22:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5881 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012535AbbHGQVA2oM3x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 18:21:00 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 888D58A7AC31C;
        Fri,  7 Aug 2015 17:20:51 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 7 Aug
 2015 17:20:54 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 7 Aug 2015 17:20:54 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Subject: [PATCH v2 4/4] clk: pistachio: correct critical clock list
Date:   Fri, 7 Aug 2015 17:20:13 +0100
Message-ID: <1438964413-18876-5-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438964413-18876-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438964413-18876-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Current critical clock list for pistachio enables
only mips and sys clocks by default but there also
other clocks that are not claimed by anyone and
needs to be enabled by default.

This patch updates the critical clocks that needs
to enabled by default.

Add a separate struct to distinguish the critical clocks
one is core clock(mips) and others are from periph_clk_*

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
---
 drivers/clk/pistachio/clk-pistachio.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 8c0fe88..c4ceb5e 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -159,9 +159,15 @@ PNAME(mux_debug) = { "mips_pll_mux", "rpu_v_pll_mux",
 		     "wifi_pll_mux", "bt_pll_mux" };
 static u32 mux_debug_idx[] = { 0x0, 0x1, 0x2, 0x4, 0x8, 0x10 };
 
-static unsigned int pistachio_critical_clks[] __initdata = {
-	CLK_MIPS,
-	CLK_PERIPH_SYS,
+static unsigned int pistachio_critical_clks_core[] __initdata = {
+	CLK_MIPS
+};
+
+static unsigned int pistachio_critical_clks_sys[] __initdata = {
+	PERIPH_CLK_SYS,
+	PERIPH_CLK_SYS_BUS,
+	PERIPH_CLK_DDR,
+	PERIPH_CLK_ROM,
 };
 
 static void __init pistachio_clk_init(struct device_node *np)
@@ -193,8 +199,8 @@ static void __init pistachio_clk_init(struct device_node *np)
 
 	pistachio_clk_register_provider(p);
 
-	pistachio_clk_force_enable(p, pistachio_critical_clks,
-				   ARRAY_SIZE(pistachio_critical_clks));
+	pistachio_clk_force_enable(p, pistachio_critical_clks_core,
+				   ARRAY_SIZE(pistachio_critical_clks_core));
 }
 CLK_OF_DECLARE(pistachio_clk, "img,pistachio-clk", pistachio_clk_init);
 
@@ -261,6 +267,9 @@ static void __init pistachio_clk_periph_init(struct device_node *np)
 				    ARRAY_SIZE(pistachio_periph_gates));
 
 	pistachio_clk_register_provider(p);
+
+	pistachio_clk_force_enable(p, pistachio_critical_clks_sys,
+				   ARRAY_SIZE(pistachio_critical_clks_sys));
 }
 CLK_OF_DECLARE(pistachio_clk_periph, "img,pistachio-clk-periph",
 	       pistachio_clk_periph_init);
-- 
1.9.1
