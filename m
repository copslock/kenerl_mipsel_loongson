Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2016 05:43:26 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35665 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27030543AbcESDnYsnxZz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2016 05:43:24 +0200
Received: by mail-pf0-f195.google.com with SMTP id b66so6786387pfb.2
        for <linux-mips@linux-mips.org>; Wed, 18 May 2016 20:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RAm3Rpyq9mS8y0wLYtlwzRnFq2GGPViJEIj/UW6rXzw=;
        b=Fhctgh4sKiH8/hnIp8kqZP89tvHW6YJxvKtmRRlTJntnxpD88QZ7+I1lfEh0s2cfkS
         I4Lr1x8pJoWW86H6uGunaxOP95UtzPfetg83R4YRrg5pw2OP6BEp2BjBGYgasFZEG6tH
         jE37sDPykYY4miX7u3SMNYrwxFcSFfnghnBjbbmb/tAawj8ceJt2fSrLU9oq/Y264SEd
         2SKsh70XJ45QN5KVPW9VBsLCIaGW7pAy9/Yn0T3TjFd8r57KpE1woxy9LXlHJiPPMV1z
         tBvmvrNlKOfax145vmcHszqlQ5ZElCHrZyPQv+C6zOmuNA7j3nBgR1pHcJQCkzHcst/D
         Ox6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RAm3Rpyq9mS8y0wLYtlwzRnFq2GGPViJEIj/UW6rXzw=;
        b=MLTlhb42VRkRBzinAF7FeKfeFm9L1Xf9IaGFYnTdVyo1uiRU5jsqX1VgQIQf0AbQhe
         8bWsigbISsvzSVAg7wl3dDjWWE4BPolG477dBWZ5Xp3z/PLtAPJCL7nqgA/qqTs6f0w6
         1+EnKbvE+weWGbNA4QapjSXFTrAoj6J0Ym3QWeFGkOpiS2CfwSiRs6CXrW57JG16Jppj
         qhk5iD5nE5jLvZeZvHOBFxN6TeKy4FSS38I19XCQtPUFo/L2pCWlq6b7qJ6cwH5QTL/s
         0wyCIuKMyolZNs0DFS4WQ4idLAYeR3aCZABhMSt6+i0CkzH1lJMRGdyaqaCzy/IASAW6
         SJNg==
X-Gm-Message-State: AOPr4FVhSFeJw4y1e6B2wAJD9625ep2AhLNv9BNgvDRNgyXDq65we5w3A97gpY/CzRQiNA==
X-Received: by 10.98.103.28 with SMTP id b28mr16286744pfc.155.1463629398722;
        Wed, 18 May 2016 20:43:18 -0700 (PDT)
Received: from ly-pc (li734-185.members.linode.com. [106.185.31.185])
        by smtp.gmail.com with ESMTPSA id m86sm15502583pfj.77.2016.05.18.20.43.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 20:43:17 -0700 (PDT)
Date:   Thu, 19 May 2016 11:42:59 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, mturquette@baylibre.com,
        sboyd@codeaurora.org
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, gnaygnil@gmail.com
Subject: [PATCH V1 1/4] clk: add Loongson1C clock support
Message-ID: <20160519034251.GA5111@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

This adds clock support to Loongson1C SoC.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 drivers/clk/clk-loongson1.c | 52 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-loongson1.c b/drivers/clk/clk-loongson1.c
index ce2135c..cc9793a 100644
--- a/drivers/clk/clk-loongson1.c
+++ b/drivers/clk/clk-loongson1.c
@@ -15,8 +15,16 @@
 
 #include <loongson1.h>
 
+#if defined(CONFIG_LOONGSON1_LS1B)
 #define OSC		(33 * 1000000)
 #define DIV_APB		2
+#define OSC_CLK		"osc_33m_clk"
+#elif defined(CONFIG_LOONGSON1_LS1C)
+#define OSC		(24 * 1000000)
+#define DIV_APB		1
+#define OSC_CLK		"osc_24m_clk"
+#endif
+
 
 static DEFINE_SPINLOCK(_lock);
 
@@ -35,9 +43,15 @@ static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 	u32 pll, rate;
 
 	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
+#if defined(CONFIG_LOONGSON1_LS1B)
 	rate = 12 + (pll & 0x3f) + (((pll >> 8) & 0x3ff) >> 10);
 	rate *= OSC;
 	rate >>= 1;
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
+	rate *= OSC;
+	rate >>= 2;
+#endif
 
 	return rate;
 }
@@ -78,20 +92,27 @@ static struct clk *__init clk_register_pll(struct device *dev,
 	return clk;
 }
 
-static const char *const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char *const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char *const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char *const cpu_parents[] = { "cpu_clk_div", OSC_CLK, };
+static const char *const ahb_parents[] = { "ahb_clk_div", OSC_CLK, };
+static const char *const dc_parents[] = { "dc_clk_div", OSC_CLK, };
+
+static const struct clk_div_table ahb_div_table[] = {
+	[0] = { .val = 0, .div = 2 },
+	[1] = { .val = 1, .div = 4 },
+	[2] = { .val = 2, .div = 3 },
+	[3] = { .val = 3, .div = 3 },
+};
 
 void __init ls1x_clk_init(void)
 {
 	struct clk *clk;
 
-	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, CLK_IS_ROOT,
+	clk = clk_register_fixed_rate(NULL, OSC_CLK, NULL, CLK_IS_ROOT,
 				      OSC);
-	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+	clk_register_clkdev(clk, OSC_CLK, NULL);
 
-	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	/* clock derived from OSC clk */
+	clk = clk_register_pll(NULL, "pll_clk", OSC_CLK, 0);
 	clk_register_clkdev(clk, "pll_clk", NULL);
 
 	/* clock derived from PLL clk */
@@ -107,10 +128,14 @@ void __init ls1x_clk_init(void)
 				   CLK_DIVIDER_ONE_BASED |
 				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
 	clk_register_clkdev(clk, "cpu_clk_div", NULL);
+#if defined(CONFIG_LOONGSON1_LS1B)
 	clk = clk_register_mux(NULL, "cpu_clk", cpu_parents,
 			       ARRAY_SIZE(cpu_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	clk = clk_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div", 0, 1, 1);
+#endif
 	clk_register_clkdev(clk, "cpu_clk", NULL);
 
 	/*                                 _____
@@ -123,10 +148,14 @@ void __init ls1x_clk_init(void)
 				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
 				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
 	clk_register_clkdev(clk, "dc_clk_div", NULL);
+#if defined(CONFIG_LOONGSON1_LS1B)
 	clk = clk_register_mux(NULL, "dc_clk", dc_parents,
 			       ARRAY_SIZE(dc_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	clk = clk_register_fixed_factor(NULL, "dc_clk", "dc_clk_div", 0, 1, 1);
+#endif
 	clk_register_clkdev(clk, "dc_clk", NULL);
 
 	/*                                 _____
@@ -135,6 +164,7 @@ void __init ls1x_clk_init(void)
 	 *        \___ PLL ___ DDR DIV ___|     |
 	 *                                |_____|
 	 */
+#if defined(CONFIG_LOONGSON1_LS1B)
 	clk = clk_register_divider(NULL, "ahb_clk_div", "pll_clk",
 				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
 				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
@@ -144,6 +174,14 @@ void __init ls1x_clk_init(void)
 			       ARRAY_SIZE(ahb_parents),
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
+#elif defined(CONFIG_LOONGSON1_LS1C)
+	clk = clk_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
+					 0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
+					 DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
+					 ahb_div_table, &_lock);
+	clk_register_clkdev(clk, "ahb_clk_div", NULL);
+	clk = clk_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div", 0, 1, 1);
+#endif
 	clk_register_clkdev(clk, "ahb_clk", NULL);
 	clk_register_clkdev(clk, "ls1x-dma", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
-- 
1.9.1


Rebase changes base on the following patch.
https://patchwork.linux-mips.org/patch/13035/
