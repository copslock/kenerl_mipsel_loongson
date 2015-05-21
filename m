Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 02:04:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63085 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026764AbbEVAEbejcRK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 02:04:31 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E2EA7AC031418;
        Fri, 22 May 2015 01:04:23 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 01:02:22 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 01:02:20 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        <cernekee@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 4/9] clk: pistachio: Extend DIV_F to pass clk_flags as well
Date:   Thu, 21 May 2015 20:57:38 -0300
Message-ID: <1432252663-31318-5-git-send-email-ezequiel.garcia@imgtec.com>
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
X-archive-position: 47546
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

As preparation work to support MIPS PLL rate change propagation, this
commit extends the DIV_F macro to pass clk_flags in addition to div_flags.

Signed-off-by: Govindraj Raja <Govindraj.Raja@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/clk/pistachio/clk-pistachio.c | 24 ++++++++++++------------
 drivers/clk/pistachio/clk.c           |  3 ++-
 drivers/clk/pistachio/clk.h           |  7 +++++--
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 8c0fe88..47e2fb1 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -61,13 +61,13 @@ static struct pistachio_div pistachio_divs[] __initdata = {
 	    0x204, 2),
 	DIV(CLK_MIPS_DIV, "mips_div", "mips_internal_div", 0x208, 8),
 	DIV_F(CLK_AUDIO_DIV, "audio_div", "audio_mux",
-		0x20c, 8, CLK_DIVIDER_ROUND_CLOSEST),
+		0x20c, 8, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_I2S_DIV, "i2s_div", "audio_pll_mux",
-		0x210, 8, CLK_DIVIDER_ROUND_CLOSEST),
+		0x210, 8, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_SPDIF_DIV, "spdif_div", "audio_pll_mux",
-		0x214, 8, CLK_DIVIDER_ROUND_CLOSEST),
+		0x214, 8, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_AUDIO_DAC_DIV, "audio_dac_div", "audio_pll_mux",
-		0x218, 8, CLK_DIVIDER_ROUND_CLOSEST),
+		0x218, 8, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV(CLK_RPU_V_DIV, "rpu_v_div", "rpu_v_pll_mux", 0x21c, 2),
 	DIV(CLK_RPU_L_DIV, "rpu_l_div", "rpu_l_mux", 0x220, 2),
 	DIV(CLK_RPU_SLEEP_DIV, "rpu_sleep_div", "xtal", 0x224, 10),
@@ -75,13 +75,13 @@ static struct pistachio_div pistachio_divs[] __initdata = {
 	DIV(CLK_USB_PHY_DIV, "usb_phy_div", "sys_internal_div", 0x22c, 6),
 	DIV(CLK_ENET_DIV, "enet_div", "enet_mux", 0x230, 6),
 	DIV_F(CLK_UART0_INTERNAL_DIV, "uart0_internal_div", "sys_pll_mux",
-	      0x234, 3, CLK_DIVIDER_ROUND_CLOSEST),
+	      0x234, 3, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_UART0_DIV, "uart0_div", "uart0_internal_div", 0x238, 10,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_UART1_INTERNAL_DIV, "uart1_internal_div", "sys_pll_mux",
-	      0x23c, 3, CLK_DIVIDER_ROUND_CLOSEST),
+	      0x23c, 3, 0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(CLK_UART1_DIV, "uart1_div", "uart1_internal_div", 0x240, 10,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV(CLK_SYS_INTERNAL_DIV, "sys_internal_div", "sys_pll_mux", 0x244, 3),
 	DIV(CLK_SPI0_INTERNAL_DIV, "spi0_internal_div", "sys_pll_mux",
 	    0x248, 3),
@@ -226,13 +226,13 @@ static struct pistachio_div pistachio_periph_divs[] __initdata = {
 	DIV(PERIPH_CLK_COUNTER_SLOW_DIV, "counter_slow_div",
 	    "counter_slow_pre_div", 0x118, 7),
 	DIV_F(PERIPH_CLK_IR_PRE_DIV, "ir_pre_div", "periph_sys", 0x11c, 7,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(PERIPH_CLK_IR_DIV, "ir_div", "ir_pre_div", 0x120, 7,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(PERIPH_CLK_WD_PRE_DIV, "wd_pre_div", "periph_sys", 0x124, 7,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV_F(PERIPH_CLK_WD_DIV, "wd_div", "wd_pre_div", 0x128, 7,
-	      CLK_DIVIDER_ROUND_CLOSEST),
+	      0, CLK_DIVIDER_ROUND_CLOSEST),
 	DIV(PERIPH_CLK_PDM_PRE_DIV, "pdm_pre_div", "periph_sys", 0x12c, 7),
 	DIV(PERIPH_CLK_PDM_DIV, "pdm_div", "pdm_pre_div", 0x130, 7),
 	DIV(PERIPH_CLK_PWM_PRE_DIV, "pwm_pre_div", "periph_sys", 0x134, 7),
diff --git a/drivers/clk/pistachio/clk.c b/drivers/clk/pistachio/clk.c
index 85faa83..380879b 100644
--- a/drivers/clk/pistachio/clk.c
+++ b/drivers/clk/pistachio/clk.c
@@ -99,7 +99,8 @@ void pistachio_clk_register_div(struct pistachio_clk_provider *p,
 
 	for (i = 0; i < num; i++) {
 		clk = clk_register_divider(NULL, div[i].name, div[i].parent,
-					   0, p->base + div[i].reg, 0,
+					   div[i].clk_flags,
+					   p->base + div[i].reg, 0,
 					   div[i].width, div[i].div_flags,
 					   NULL);
 		p->clk_data.clks[div[i].id] = clk;
diff --git a/drivers/clk/pistachio/clk.h b/drivers/clk/pistachio/clk.h
index ea48d15..1589227 100644
--- a/drivers/clk/pistachio/clk.h
+++ b/drivers/clk/pistachio/clk.h
@@ -54,6 +54,7 @@ struct pistachio_div {
 	unsigned int id;
 	unsigned long reg;
 	unsigned int width;
+	unsigned int clk_flags;
 	unsigned int div_flags;
 	const char *name;
 	const char *parent;
@@ -64,17 +65,19 @@ struct pistachio_div {
 		.id		= _id,				\
 		.reg		= _reg,				\
 		.width		= _width,			\
+		.clk_flags	= 0,				\
 		.div_flags	= 0,				\
 		.name		= _name,			\
 		.parent		= _pname,			\
 	}
 
-#define DIV_F(_id, _name, _pname, _reg, _width, _div_flags)	\
+#define DIV_F(_id, _name, _pname, _reg, _width, _clkf, _divf)	\
 	{							\
 		.id		= _id,				\
 		.reg		= _reg,				\
 		.width		= _width,			\
-		.div_flags	= _div_flags,			\
+		.clk_flags	= _clkf,			\
+		.div_flags	= _divf,			\
 		.name		= _name,			\
 		.parent		= _pname,			\
 	}
-- 
2.3.3
