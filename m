Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2016 13:57:41 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32993 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026372AbcDKL4hqsdef (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2016 13:56:37 +0200
Received: by mail-pa0-f68.google.com with SMTP id vv3so1605016pab.0
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 04:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eVSAIqV7BmZo6hU3TbjKO+7OTJgZEzEcUEfTujlNeb8=;
        b=DSzoosqAKevMJA9kedrCTG/EzHW+G+O3zbEoGZJLCpPkyXkA/w6ri4XdSVj6X5p7Z4
         isVMsrPtTk2FiycJfhBf1/pOljAH5EZSw3tXiiq+6l1dy/hst+4wIQ6LtgDv9/mK6PeL
         gXf7YrQCtmPaq5FnhwFtaoja6cE2LrmMD5gYL5r2hfuD02q5AlWGrUA3XeIX4PYfXaoh
         MgDeH018AApwwcypFtO7S5rkQVgNDH407k+jn+J15+QoDNg1wOJLyhLptaUOBSMQGm/6
         pveh9OQPa79FqQ6pcUSZGH9EMCbyBNGQLyaUgfneNmwyUxtb4BugSOGnoaDy437eYTDp
         waFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eVSAIqV7BmZo6hU3TbjKO+7OTJgZEzEcUEfTujlNeb8=;
        b=PZr2kEBibvrhuFA7WpcgCXHVCMMXf/28rnVCr+uI6a5TyXvJKcMaZa0h18k6+fI0Jh
         vL/WHjJt7ZO399+/OF/dS0+HSjZCzzQfR1+tHISYf4/EP4yyfhPmEFHmkOjM9UBLUjMn
         0bfOK5NP/+ngEZzVNcL6gJm5UkRfSNf8EcL8Qz7xvje1DHZG+Eyz689J+yyc6NPsnN7C
         +4OWB+C6AJ6XtT6bkoNd9k94aChbjk8wR8+7TifX5iK+qa+4an5wAvqAJuIj+D5y52Of
         VA6nyUOcWqYxt2gOpeJ+KLD0l/jB/QrU9P13pa2PEiSoT710Y961BhJNdWXA6rzZjSFq
         z2sQ==
X-Gm-Message-State: AD7BkJKV09zPekuRiXO6I6I7W1/qNFONud+0BLEJwtoo4cD4vEFikl8667JsJSerD5+/uw==
X-Received: by 10.66.121.97 with SMTP id lj1mr32082169pab.51.1460375792010;
        Mon, 11 Apr 2016 04:56:32 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id o71sm35814708pfj.68.2016.04.11.04.56.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 04:56:31 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 5/5] cpufreq: Loongson1: Replace goto out with return in ls1x_cpufreq_probe()
Date:   Mon, 11 Apr 2016 19:55:59 +0800
Message-Id: <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52950
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

This patch replaces goto out with return in ls1x_cpufreq_probe(),
and also includes some minor fixes.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/loongson1-cpufreq.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index 5074f5e..1bc90af 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
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
@@ -141,7 +141,8 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
 		return -EINVAL;
 
 	cpufreq =
@@ -155,8 +156,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->clk = clk;
 
@@ -164,8 +164,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->mux_clk = clk;
 
@@ -173,8 +172,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->pll_clk = clk;
 
@@ -182,8 +180,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->osc_clk = clk;
 
@@ -194,32 +191,30 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"failed to register CPUFreq driver: %d\n", ret);
-		goto out;
+		return ret;
 	}
 
 	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
 
-	if (!ret)
-		goto out;
-
-	dev_err(&pdev->dev, "failed to register cpufreq notifier: %d\n", ret);
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
