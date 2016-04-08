Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 13:43:45 +0200 (CEST)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35019 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026280AbcDHLneA4x5B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Apr 2016 13:43:34 +0200
Received: by mail-pf0-f196.google.com with SMTP id r187so9400711pfr.2;
        Fri, 08 Apr 2016 04:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2iXgMHE7Idc4t1NcZnRsaBRTRDeqfzkucavr4SkLmvQ=;
        b=XWhWtq+DsyOM49icULMwvDTkDf/bxfx639hdP1r5FCV5LsiO0J6hIB3Bt/HV+Gr+N8
         etXWV6B3wJZuGqOzbqRdM0cNwKEkI1jmMcVafHRCvqr7o6Cab87vQGMno5SQ69a1xSp2
         IkaGjjIYqaEO1SpnqvhM+4Cfo/Qor/NcDjIkgeMmHKG+FXxh+JbP78zUd7bSgerCvyxO
         3X8Nc/QFMZHJne5je5FHtnBA5SYJR/KQB52uC93jCnRa8PjYcuLlIR1SnIcyQYYv5vXB
         iY4mqIZ748uEuX/px2742DL2tQ0LCJa4EpjIvqoeKSWNBx5WS0XPFwc5ahjAcyxu7WeM
         dgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2iXgMHE7Idc4t1NcZnRsaBRTRDeqfzkucavr4SkLmvQ=;
        b=hMuvLC7Xbk3+m4jdDIyPAi2OIPKjdzIqV1QcF4HCFu4AY6mn9BH7Ki//bzrgq/gHke
         MlIjJ3NVjTuPthskNza7JigT8EbEK7rAuU7bVLxbGAOMYIMiP6xDDzSJnygWiMBwfO0O
         xsUD5kJtEPetCEz7YQhAaxUH4WKrajgnZ7ylXBgU6cAH2InpzGmTYXxft32AZE/c3idF
         CM0p6h2NdekZk/YMba5k1wmpoLu9KEqjYvzCUqx0Sn34uPKW6XvNi9R9S6B47DOpwCdZ
         UMuwTlPbVkil4n3mgPyDYTRvoXx2XNv+O5pAD5II2rB+fFv+jQmEGwQJ1SiHmWLI4bhN
         +LhQ==
X-Gm-Message-State: AD7BkJIUwhzA+Rq48xQKWkpI9f1avKwGfyOFvMVCs6Z6YvFVAvTMxLZRoBUvCsO30pBGVQ==
X-Received: by 10.98.74.200 with SMTP id c69mr11952328pfj.129.1460115807969;
        Fri, 08 Apr 2016 04:43:27 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id p75sm18350744pfi.29.2016.04.08.04.43.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Apr 2016 04:43:26 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V2 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Date:   Fri,  8 Apr 2016 19:42:56 +0800
Message-Id: <1460115779-13141-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52933
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

- Rename the file to loongson1-cpufreq.c
- Use kcalloc() instead of kzalloc()
- Use devm_kzalloc() instead of global structure
- Use dev_get_platdata() to access the platform_data field
  instead of referencing it directly
- Remove superfluous error messages

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V2:
   Regenerate the patch to make it review-able.
---
 drivers/cpufreq/Makefile                           |   2 +-
 .../{ls1x-cpufreq.c => loongson1-cpufreq.c}        | 114 ++++++++++-----------
 2 files changed, 58 insertions(+), 58 deletions(-)
 rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (65%)

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9e63fb1..bebe9c8 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -100,7 +100,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
-obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= loongson1-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
similarity index 65%
rename from drivers/cpufreq/ls1x-cpufreq.c
rename to drivers/cpufreq/loongson1-cpufreq.c
index 262581b..0117820 100644
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  * CPU Frequency Scaling for Loongson 1 SoC
  *
- * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
@@ -20,7 +20,7 @@
 #include <cpufreq.h>
 #include <loongson1.h>
 
-static struct {
+struct ls1x_cpufreq {
 	struct device *dev;
 	struct clk *clk;	/* CPU clk */
 	struct clk *mux_clk;	/* MUX of CPU clk */
@@ -28,7 +28,9 @@ static struct {
 	struct clk *osc_clk;	/* OSC clk */
 	unsigned int max_freq;
 	unsigned int min_freq;
-} ls1x_cpufreq;
+};
+
+static struct ls1x_cpufreq *cpufreq;
 
 static int ls1x_cpufreq_notifier(struct notifier_block *nb,
 				 unsigned long val, void *data)
@@ -46,6 +48,7 @@ static struct notifier_block ls1x_cpufreq_notifier_block = {
 static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
 			       unsigned int index)
 {
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	unsigned int old_freq, new_freq;
 
 	old_freq = policy->cur;
@@ -60,53 +63,49 @@ static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
 	 *  - Reparent CPU clk back to CPU DIV clk
 	 */
 
-	dev_dbg(ls1x_cpufreq.dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
-	clk_set_parent(policy->clk, ls1x_cpufreq.osc_clk);
+	clk_set_parent(policy->clk, cpufreq->osc_clk);
 	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
 		     LS1X_CLK_PLL_DIV);
 	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
 		     LS1X_CLK_PLL_DIV);
-	clk_set_rate(ls1x_cpufreq.mux_clk, new_freq * 1000);
-	clk_set_parent(policy->clk, ls1x_cpufreq.mux_clk);
+	clk_set_rate(cpufreq->mux_clk, new_freq * 1000);
+	clk_set_parent(policy->clk, cpufreq->mux_clk);
+	dev_dbg(cpu_dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
 
 	return 0;
 }
 
 static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 {
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	struct cpufreq_frequency_table *freq_tbl;
 	unsigned int pll_freq, freq;
 	int steps, i, ret;
 
-	pll_freq = clk_get_rate(ls1x_cpufreq.pll_clk) / 1000;
+	pll_freq = clk_get_rate(cpufreq->pll_clk) / 1000;
 
 	steps = 1 << DIV_CPU_WIDTH;
-	freq_tbl = kzalloc(sizeof(*freq_tbl) * steps, GFP_KERNEL);
-	if (!freq_tbl) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to alloc cpufreq_frequency_table\n");
-		ret = -ENOMEM;
-		goto out;
-	}
+	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
 
 	for (i = 0; i < (steps - 1); i++) {
 		freq = pll_freq / (i + 1);
-		if ((freq < ls1x_cpufreq.min_freq) ||
-		    (freq > ls1x_cpufreq.max_freq))
+		if ((freq < cpufreq->min_freq) || (freq > cpufreq->max_freq))
 			freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
 		else
 			freq_tbl[i].frequency = freq;
-		dev_dbg(ls1x_cpufreq.dev,
+		dev_dbg(cpu_dev,
 			"cpufreq table: index %d: frequency %d\n", i,
 			freq_tbl[i].frequency);
 	}
 	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
 
-	policy->clk = ls1x_cpufreq.clk;
+	policy->clk = cpufreq->clk;
 	ret = cpufreq_generic_init(policy, freq_tbl, 0);
 	if (ret)
 		kfree(freq_tbl);
-out:
+
 	return ret;
 }
 
@@ -138,85 +137,86 @@ static int ls1x_cpufreq_remove(struct platform_device *pdev)
 
 static int ls1x_cpufreq_probe(struct platform_device *pdev)
 {
-	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
+	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
 	struct clk *clk;
 	int ret;
 
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
 		return -EINVAL;
+	}
 
-	ls1x_cpufreq.dev = &pdev->dev;
+	cpufreq =
+	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
+	if (!cpufreq) {
+		return -ENOMEM;
+	}
+
+	cpufreq->dev = &pdev->dev;
 
 	clk = devm_clk_get(&pdev->dev, pdata->clk_name);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
-	ls1x_cpufreq.clk = clk;
+	cpufreq->clk = clk;
 
 	clk = clk_get_parent(clk);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->clk));
+		return PTR_ERR(clk);
 	}
-	ls1x_cpufreq.mux_clk = clk;
+	cpufreq->mux_clk = clk;
 
 	clk = clk_get_parent(clk);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->mux_clk));
+		return PTR_ERR(clk);
 	}
-	ls1x_cpufreq.pll_clk = clk;
+	cpufreq->pll_clk = clk;
 
 	clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
-	ls1x_cpufreq.osc_clk = clk;
+	cpufreq->osc_clk = clk;
 
-	ls1x_cpufreq.max_freq = pdata->max_freq;
-	ls1x_cpufreq.min_freq = pdata->min_freq;
+	cpufreq->max_freq = pdata->max_freq;
+	cpufreq->min_freq = pdata->min_freq;
 
 	ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
 	if (ret) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to register cpufreq driver: %d\n", ret);
-		goto out;
+		dev_err(&pdev->dev,
+			"failed to register CPUFreq driver: %d\n", ret);
+		return ret;
 	}
 
 	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
 
-	if (!ret)
-		goto out;
-
-	dev_err(ls1x_cpufreq.dev, "failed to register cpufreq notifier: %d\n",
-		ret);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register CPUFreq notifier: %d\n", ret);
+		cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+	}
 
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-out:
 	return ret;
 }
 
 static struct platform_driver ls1x_cpufreq_platdrv = {
-	.driver = {
+	.probe	= ls1x_cpufreq_probe,
+	.remove	= ls1x_cpufreq_remove,
+	.driver	= {
 		.name	= "ls1x-cpufreq",
 	},
-	.probe		= ls1x_cpufreq_probe,
-	.remove		= ls1x_cpufreq_remove,
 };
 
 module_platform_driver(ls1x_cpufreq_platdrv);
 
 MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
+MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
 MODULE_LICENSE("GPL");
-- 
1.9.1
