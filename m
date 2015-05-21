Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 02:03:51 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28997 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012557AbbEVADuAVTEC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 02:03:50 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BB3F8EA31137E;
        Fri, 22 May 2015 01:03:42 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 01:03:46 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 01:03:45 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        <cernekee@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 7/9] clk: pistachio: Add a rate table for the MIPS PLL
Date:   Thu, 21 May 2015 20:57:41 -0300
Message-ID: <1432252663-31318-8-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

This commit adds a rate parameter table, which makes it possible for
the MIPS PLL to support rate change.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clk/pistachio/clk-pistachio.c | 12 +++++++++++-
 drivers/clk/pistachio/clk.h           | 12 ++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 22a7ebd..0ac7429 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -145,8 +145,18 @@ static struct pistachio_mux pistachio_muxes[] __initdata = {
 	MUX(CLK_BT_PLL_MUX, "bt_pll_mux", mux_xtal_bt, 0x200, 17),
 };
 
+static struct pistachio_pll_rate_table mips_pll_rates[] = {
+	MIPS_PLL_RATES(52000000, 416000000, 1, 16, 2, 1),
+	MIPS_PLL_RATES(52000000, 442000000, 1, 17, 2, 1),
+	MIPS_PLL_RATES(52000000, 468000000, 1, 18, 2, 1),
+	MIPS_PLL_RATES(52000000, 494000000, 1, 19, 2, 1),
+	MIPS_PLL_RATES(52000000, 520000000, 1, 20, 2, 1),
+	MIPS_PLL_RATES(52000000, 546000000, 1, 21, 2, 1),
+};
+
 static struct pistachio_pll pistachio_plls[] __initdata = {
-	PLL_FIXED(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0),
+	PLL(CLK_MIPS_PLL, "mips_pll", "xtal", PLL_GF40LP_LAINT, 0x0,
+	    mips_pll_rates),
 	PLL_FIXED(CLK_AUDIO_PLL, "audio_pll", "audio_refclk_mux",
 		  PLL_GF40LP_FRAC, 0xc),
 	PLL_FIXED(CLK_RPU_V_PLL, "rpu_v_pll", "xtal", PLL_GF40LP_LAINT, 0x20),
diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index 3bb6bbe..b5d22d6 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -121,6 +121,18 @@ struct pistachio_pll_rate_table {
 	unsigned int frac;
 };
 
+#define MIPS_PLL_RATES(_fref, _fout, _refdiv, _fbdiv,	\
+		       _postdiv1, _postdiv2)		\
+{                                                       \
+	.fref           = _fref,                        \
+	.fout           = _fout,                        \
+	.refdiv         = _refdiv,                      \
+	.fbdiv          = _fbdiv,                       \
+	.postdiv1       = _postdiv1,                    \
+	.postdiv2       = _postdiv2,                    \
+	.frac           = 0,                            \
+}
+
 enum pistachio_pll_type {
 	PLL_GF40LP_LAINT,
 	PLL_GF40LP_FRAC,
-- 
2.3.3
