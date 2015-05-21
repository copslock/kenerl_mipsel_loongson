Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 02:04:41 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20707 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026763AbbEVAEUxsvou (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 02:04:20 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BDEB630F14EE8;
        Fri, 22 May 2015 01:04:13 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 01:03:12 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 01:03:11 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        <cernekee@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 6/9] clk: pistachio: Propagate rate changes in the MIPS PLL clock sub-tree
Date:   Thu, 21 May 2015 20:57:40 -0300
Message-ID: <1432252663-31318-7-git-send-email-ezequiel.garcia@imgtec.com>
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
X-archive-position: 47545
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

This commit passes CLK_SET_RATE_PARENT to the "mips_div",
"mips_internal_div", and "mips_pll_mux" clocks. This flag is needed for the
"mips" clock to propagate rate changes up to the "mips_pll" root clock.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clk/pistachio/clk-pistachio.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 47e2fb1..22a7ebd 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -57,9 +57,10 @@ static struct pistachio_fixed_factor pistachio_ffs[] __initdata = {
 };
 
 static struct pistachio_div pistachio_divs[] __initdata = {
-	DIV(CLK_MIPS_INTERNAL_DIV, "mips_internal_div", "mips_pll_mux",
-	    0x204, 2),
-	DIV(CLK_MIPS_DIV, "mips_div", "mips_internal_div", 0x208, 8),
+	DIV_F(CLK_MIPS_INTERNAL_DIV, "mips_internal_div", "mips_pll_mux",
+		0x204, 2, CLK_SET_RATE_PARENT, 0),
+	DIV_F(CLK_MIPS_DIV, "mips_div", "mips_internal_div",
+		0x208, 8, CLK_SET_RATE_PARENT, 0),
 	DIV_F(CLK_AUDIO_DIV, "audio_div", "audio_mux",
 		0x20c, 8, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_I2S_DIV, "i2s_div", "audio_pll_mux",
@@ -126,7 +127,8 @@ PNAME(mux_xtal_bt) = { "xtal", "bt_pll" };
 static struct pistachio_mux pistachio_muxes[] __initdata = {
 	MUX(CLK_AUDIO_REF_MUX, "audio_refclk_mux", mux_xtal_audio_refclk,
 	    0x200, 0),
-	MUX(CLK_MIPS_PLL_MUX, "mips_pll_mux", mux_xtal_mips, 0x200, 1),
+	MUX_F(CLK_MIPS_PLL_MUX, "mips_pll_mux", mux_xtal_mips,
+	    0x200, 1, CLK_SET_RATE_PARENT),
 	MUX(CLK_AUDIO_PLL_MUX, "audio_pll_mux", mux_xtal_audio, 0x200, 2),
 	MUX(CLK_AUDIO_MUX, "audio_mux", mux_audio_debug, 0x200, 4),
 	MUX(CLK_RPU_V_PLL_MUX, "rpu_v_pll_mux", mux_xtal_rpu_v, 0x200, 5),
-- 
2.3.3
