Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:53:04 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33029 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993255AbcHLKwUgM5E5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:52:20 +0200
Received: by mail-pf0-f194.google.com with SMTP id i6so1383368pfe.0
        for <linux-mips@linux-mips.org>; Fri, 12 Aug 2016 03:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mx1x7WXdWx1OmGiQa8j/Ocnd1yGzb9TNnARrKEjT+x4=;
        b=K4bzmiErucRlEUqEBfwmUuCKnSgtIBbAfbA7vCeHaFn6sck4MLX/WeG/Cp6Yfd6lUn
         zJydRk9IfJBx1VNZuM5n0glKpmG0H9zuobbcNGsQ/k5zkNTaK3XARXS1HNnG7FuwSMDm
         HY5IJ84Hvix3/2xSP1xgB2qeXa8a34fw085R4RhNAInM1ddwk3FGFOrKT/gjXEVit/Po
         nCw1chGWK0A2/eo+1ZPGJJs4AoSzZ72ChwvzrHiLp9vNIucKRPuukIm3nJGdgqu7u57u
         IXl7SxMn7Usnfd0CdVpdqbdNZgxJBa/q5FPP+58Uy3jChi9NsLRc2v6YyLq3UPTMx/ZY
         sbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mx1x7WXdWx1OmGiQa8j/Ocnd1yGzb9TNnARrKEjT+x4=;
        b=C0SR9ClQza/Cw31t7mPBZJfWIMuwe7muXn9ogQtMYPIswRFF9yt7rGkC0TVdMSKkTS
         knBKV70GIs6T8QsLnaH7RJnDsQbxHS0XCgHv6Ae3MGS56WQoUJ0jdBW4iMfe+WT+mWXT
         ANW8oPJU72V5B7FVtg1FjywDB8KCw9AOYBsH/J6JWIz7N1kSLEoTP8q2Kf8MRjr/nRZa
         n6s20Me99H/8jlUQFWrAg5ZPXgXCf+s/bfk+kOnpzTkSR098fJZtilMqPfnLLR1q7IZn
         apOEiYAmOylB2OSn1PDBE3OaFeP8mnq6WBWkGDGM1fGkv3xhvTEBFqaI6nDQioe5O2+A
         wsjw==
X-Gm-Message-State: AEkoouswUQ6mMBNrxZr4eIYTYT3HG8AlXYaNhCdZUzrL1E+FzcAxjF85ipGJcWbyXXmmFg==
X-Received: by 10.98.59.70 with SMTP id i67mr25785296pfa.45.1470999134831;
        Fri, 12 Aug 2016 03:52:14 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id k78sm12034940pfa.78.2016.08.12.03.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 03:52:13 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 2/3] clk: Loongson1: Update clocks of Loongson1B
Date:   Fri, 12 Aug 2016 18:51:47 +0800
Message-Id: <1470999108-9851-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
References: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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

From: Kelvin Cheung <keguang.zhang@gmail.com>

This patch updates some clock names of Loongson1B,
and adds AC97, DMA and NAND clock.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/loongson1/clk-loongson1b.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index 336ff95..2302ee5 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -39,19 +39,19 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
-static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
-static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
+static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
+static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
+static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
 
 void __init ls1x_clk_init(void)
 {
 	struct clk *clk;
 
-	clk = clk_register_fixed_rate(NULL, "osc_33m_clk", NULL, 0, OSC);
-	clk_register_clkdev(clk, "osc_33m_clk", NULL);
+	clk = clk_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
+	clk_register_clkdev(clk, "osc_clk", NULL);
 
 	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk",
+	clk = clk_register_pll(NULL, "pll_clk", "osc_clk",
 			       &ls1x_pll_clk_ops, 0);
 	clk_register_clkdev(clk, "pll_clk", NULL);
 
@@ -106,6 +106,7 @@ void __init ls1x_clk_init(void)
 			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
 			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
+	clk_register_clkdev(clk, "ls1x-dma", NULL);
 	clk_register_clkdev(clk, "stmmaceth", NULL);
 
 	/* clock derived from AHB clk */
@@ -113,9 +114,11 @@ void __init ls1x_clk_init(void)
 	clk = clk_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
 					DIV_APB);
 	clk_register_clkdev(clk, "apb_clk", NULL);
-	clk_register_clkdev(clk, "ls1x_i2c", NULL);
-	clk_register_clkdev(clk, "ls1x_pwmtimer", NULL);
-	clk_register_clkdev(clk, "ls1x_spi", NULL);
-	clk_register_clkdev(clk, "ls1x_wdt", NULL);
+	clk_register_clkdev(clk, "ls1x-ac97", NULL);
+	clk_register_clkdev(clk, "ls1x-i2c", NULL);
+	clk_register_clkdev(clk, "ls1x-nand", NULL);
+	clk_register_clkdev(clk, "ls1x-pwmtimer", NULL);
+	clk_register_clkdev(clk, "ls1x-spi", NULL);
+	clk_register_clkdev(clk, "ls1x-wdt", NULL);
 	clk_register_clkdev(clk, "serial8250", NULL);
 }
-- 
1.9.1
