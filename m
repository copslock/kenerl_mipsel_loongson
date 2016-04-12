Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:41:48 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34066 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026404AbcDLKkwaXxaN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:40:52 +0200
Received: by mail-pa0-f66.google.com with SMTP id hb4so1131451pac.1
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sNEZZgswadNqoVhLdwUhMztOXxBmqiT8t5fGAbfpfOk=;
        b=wJwh5WbhUw+N4fO33kajUv9nWwBJBEAwss9NwJ/S7P/7GOKfNq0yWgbxRDrLpJY2j1
         ia1q5fQG23lNDyLFPaPIxqfGVL20OkKLfiA2jvbh4TdN5RJCX6zbLedUBSKYYuZAmweP
         3VAxHdy9x04uv2JM6wBu/IK60TdnvePFjntoTfInhGMwRdr20LMiMwa/z+zA84q5D+BT
         hPsstV0165t2NsP+gWVeuPrQOZT9tqyYEQYuPdYYyOgiRTzYwDaxJhcHuUhboe9XULss
         varHnZ/zJcx0SMaoVhkrHXEtSnt2HGxH8mopkePkdROxnuP2ecrHTY5NYf3g1/uQUXMl
         Ok0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sNEZZgswadNqoVhLdwUhMztOXxBmqiT8t5fGAbfpfOk=;
        b=k9ZLTpF/ltjdAvVf1qN7VvvMI+NE16d9XiP7O3jgqhqbHAARPLbxT+DSQpq/xVfaIC
         vJNOzbve3tAHXuC1vlPDzTAuFnBQq8on9zRitTERwbTYQ1NbtGe4lTTNe9+BE+1nUUW7
         5A658vUXE67CW/hOZiMe+2q8KKgtPegykyKFtSeuljckM7Df9I/c1HcQkwGMIwpMjmuL
         +PL1OuAG1lDK2PCnYQM8vYgvRQG6LH3NugZ+86ZkcO91lF5sxYCglpRlC5KXffJablVD
         XI8hQCuUmsz2gvYD+1I7KcJPD3VmZ64QNkU3fSgGBU+btqyRmLdbdJ3E70yi0I3JFenB
         NDEg==
X-Gm-Message-State: AOPr4FV9jZuOjCuXrJbP9XHjIUHyht9IoePSnCi+opupf+F6zrzrEb/f5AvTc7rzXAvprw==
X-Received: by 10.66.139.70 with SMTP id qw6mr3458435pab.67.1460457646755;
        Tue, 12 Apr 2016 03:40:46 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m87sm42588365pfj.38.2016.04.12.03.40.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 03:40:45 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 4/5] cpufreq: Loongson1: Use devm_kzalloc() instead of global structure
Date:   Tue, 12 Apr 2016 18:40:18 +0800
Message-Id: <1460457619-14786-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52962
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

This patch uses devm_kzalloc() instead of global structure.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 63 ++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 1b63b4a..f0d0156 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
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
@@ -60,25 +63,26 @@ static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
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
 	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
@@ -87,18 +91,17 @@ static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
 
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
@@ -141,51 +144,56 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
 		return -EINVAL;
 
-	ls1x_cpufreq.dev = &pdev->dev;
+	cpufreq =
+	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
+	if (!cpufreq)
+		return -ENOMEM;
+
+	cpufreq->dev = &pdev->dev;
 
 	clk = devm_clk_get(&pdev->dev, pdata->clk_name);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
 		ret = PTR_ERR(clk);
 		goto out;
 	}
-	ls1x_cpufreq.clk = clk;
+	cpufreq->clk = clk;
 
 	clk = clk_get_parent(clk);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.clk));
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->clk));
 		ret = PTR_ERR(clk);
 		goto out;
 	}
-	ls1x_cpufreq.mux_clk = clk;
+	cpufreq->mux_clk = clk;
 
 	clk = clk_get_parent(clk);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.mux_clk));
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->mux_clk));
 		ret = PTR_ERR(clk);
 		goto out;
 	}
-	ls1x_cpufreq.pll_clk = clk;
+	cpufreq->pll_clk = clk;
 
 	clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
 	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
 		ret = PTR_ERR(clk);
 		goto out;
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
+		dev_err(&pdev->dev,
+			"failed to register CPUFreq driver: %d\n", ret);
 		goto out;
 	}
 
@@ -195,8 +203,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (!ret)
 		goto out;
 
-	dev_err(ls1x_cpufreq.dev, "failed to register cpufreq notifier: %d\n",
-		ret);
+	dev_err(&pdev->dev, "failed to register cpufreq notifier: %d\n", ret);
 
 	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
 out:
-- 
1.9.1
