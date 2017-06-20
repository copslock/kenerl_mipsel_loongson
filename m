Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 10:59:38 +0200 (CEST)
Received: from smtpbg342.qq.com ([14.17.44.37]:58160 "EHLO smtpbg342.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992160AbdFTI5cq8GY2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Jun 2017 10:57:32 +0200
X-QQ-mid: bizesmtp2t1497949013t9y53zhq2
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 20 Jun 2017 16:56:52 +0800 (CST)
X-QQ-SSF: 01100000008000F0FIF1000A0000000
X-QQ-FEAT: wKTPh8u/SrrVOf8jo0BSfYLPV77kprtvMp+YLLoqQ6gMP78++qnpox3CoqM4p
        +hmo7Y+tVtWyqvpAfDFSZ0zGdT5ZPvKq6KNYxsbb2+dcJgsnpMWK3AoQal6tXNF0ImEpE/G
        inPIlkNqLGer8OdB+A1RK519F0uGI6/gF+an5wN8FL3RrZQ4eqsSyArdoGEoX7Z8Rvdf44v
        uoMATzFF/vmijC6jkpojUTic5kpaXKHvjCeeiMf+/XB+DiMvI6a2BOitua5HOW1MkVgIABb
        o5dEOUAsFN7kYdZ7ieN93CD5JQhAQuwsocXeTcgsTWOavJzsIt4Yz6r34=
X-QQ-GoodBg: 0
From:   Binbin Zhou <zhoubb@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6?= <Yeking@Red54.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Binbin Zhou <zhoubb@lemote.com>,
        HuaCai Chen <chenhc@lemote.com>
Subject: [PATCH v8 7/9] clk: Loongson: A descriptive spinlock name for Loongson1's clk driver
Date:   Tue, 20 Jun 2017 16:57:05 +0800
Message-Id: <1497949027-10988-8-git-send-email-zhoubb@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
References: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
X-QQ-SENDSIZE: 520
Return-Path: <zhoubb@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhoubb@lemote.com
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

The spinlock name in clk-loongson1*.c is "_lock", that's not a very good
name for something that may show up in lockdep debugging error messages.

Give it a bit more descriptive name--ls1x_clk_lock.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
Signed-off-by: HuaCai Chen <chenhc@lemote.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/loongson1/clk-loongson1b.c | 14 +++++++-------
 drivers/clk/loongson1/clk-loongson1c.c |  8 ++++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index f36a97e..8d5be12 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -18,7 +18,7 @@
 #define OSC		(33 * 1000000)
 #define DIV_APB		2
 
-static DEFINE_SPINLOCK(_lock);
+static DEFINE_SPINLOCK(ls1x_clk_lock);
 
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
@@ -64,12 +64,12 @@ void __init ls1x_clk_init(void)
 				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+				   CLK_DIVIDER_ROUND_CLOSEST, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
 	hw = clk_hw_register_mux(NULL, "cpu_clk", cpu_parents,
 			       ARRAY_SIZE(cpu_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
+			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
 
 	/*                                 _____
@@ -80,12 +80,12 @@ void __init ls1x_clk_init(void)
 	 */
 	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
 	hw = clk_hw_register_mux(NULL, "dc_clk", dc_parents,
 			       ARRAY_SIZE(dc_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
+			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "dc_clk", NULL);
 
 	/*                                 _____
@@ -97,12 +97,12 @@ void __init ls1x_clk_init(void)
 	hw = clk_hw_register_divider(NULL, "ahb_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
 				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
-				   &_lock);
+				   &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
 	hw = clk_hw_register_mux(NULL, "ahb_clk", ahb_parents,
 			       ARRAY_SIZE(ahb_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
+			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
 	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
 	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
index 3466f73..7635848 100644
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -16,7 +16,7 @@
 #define OSC		(24 * 1000000)
 #define DIV_APB		1
 
-static DEFINE_SPINLOCK(_lock);
+static DEFINE_SPINLOCK(ls1x_clk_lock);
 
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
@@ -58,7 +58,7 @@ void __init ls1x_clk_init(void)
 				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
 				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
 				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
+				   CLK_DIVIDER_ROUND_CLOSEST, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
 	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
 					0, 1, 1);
@@ -66,7 +66,7 @@ void __init ls1x_clk_init(void)
 
 	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
+				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
 	hw = clk_hw_register_fixed_factor(NULL, "dc_clk", "dc_clk_div",
 					0, 1, 1);
@@ -75,7 +75,7 @@ void __init ls1x_clk_init(void)
 	hw = clk_hw_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
 				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
 				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
-				ahb_div_table, &_lock);
+				ahb_div_table, &ls1x_clk_lock);
 	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
 	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
 					0, 1, 1);
-- 
2.9.4
