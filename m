Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 12:42:09 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36355 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026405AbcDLKkzi0w3N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 12:40:55 +0200
Received: by mail-pa0-f65.google.com with SMTP id k3so1126039pav.3
        for <linux-mips@linux-mips.org>; Tue, 12 Apr 2016 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPUb3V3FH9BoCMEf9+uAsRAxl2s9VDnBWkfHRg6jtC4=;
        b=M1j3y6GXe/KbF2+fVXrWJItqMAZPrGCHSaWztGiolmhIsDzL66sK6fRTdZn54QsaCE
         qWuNegB2bmjPwWAj/8Kw7XbUN/NWlp/ZIF6cDBPFISIjkKC9Up2om/H6ZngMAOuK1In0
         BNfK1Skgl0yB0NNOYweD+vOWz8ZcmLZfk0wbSyx6LZihYrjJqYh13JaxaBCWYzdB8cin
         TljJzbw5mHxjVga9KhV+WdUP+NcfHVkx68T/qC3unGBwLP3F7jOZwcly2m8TXMOxGEqY
         qIH8N7o9aYDCBAw/IiKSxYQlpQuBYZCjvc9qT0srh8HL3XmsgPJKXyhIDmyDBZxReM8v
         LOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPUb3V3FH9BoCMEf9+uAsRAxl2s9VDnBWkfHRg6jtC4=;
        b=EbUQHdZQMEXxolES3DH2bYLwCRXBC06+REC0OANXZWEpeGjSR1ZgwKHTJzLTfV4M1C
         0c04slVkjMkW5gohAhsfVKqqg/w2fTG2W2VPHsiBJ+uLGcke8ltGcpmCpdNNS6CH+YWe
         sNsfOIL997edhCYaec5aORgdl9ato0r8e5DTVikye+trDomqZVhUOTbZC+8NLiIPLRLW
         CPLxixaNPP/bPzu+E08c2G5nRFNly/RfEwWYBYPa6QO1NmQ25nxootan6dnS4TM97cZu
         noCYNYIGPpEFy9/UumZZ6y827fQ/HRdKF5Dr1xNzRdKzQf6nLqyB3+vMXT3HtEOA7AGH
         8pog==
X-Gm-Message-State: AOPr4FWI2kcK0/nY0jEwVpD/XG5FJ1vdlDEMM/enExz+qlOfgZ3qcVdMLx+NeIF+SxZ+jg==
X-Received: by 10.67.15.9 with SMTP id fk9mr3460270pad.77.1460457649882;
        Tue, 12 Apr 2016 03:40:49 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id m87sm42588365pfj.38.2016.04.12.03.40.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 03:40:48 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH V1 5/5] cpufreq: Loongson1: Replace goto out with return in ls1x_cpufreq_probe()
Date:   Tue, 12 Apr 2016 18:40:19 +0800
Message-Id: <1460457619-14786-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52963
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

This patch replaces goto out with return in ls1x_cpufreq_probe().

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

---
V1:
   Move the minor updates into patch#1.
   Fix the brace problem in ls1x_cpufreq_probe().
---
 drivers/cpufreq/loongson1-cpufreq.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index f0d0156..be89416 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -141,8 +141,10 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
 		return -EINVAL;
+	}
 
 	cpufreq =
 	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
@@ -155,8 +157,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->clk = clk;
 
@@ -164,8 +165,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->mux_clk = clk;
 
@@ -173,8 +173,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
 			__clk_get_name(cpufreq->mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->pll_clk = clk;
 
@@ -182,8 +181,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to get %s clock\n",
 			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
+		return PTR_ERR(clk);
 	}
 	cpufreq->osc_clk = clk;
 
@@ -194,19 +192,18 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
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
+		dev_err(&pdev->dev,
+			"failed to register CPUFreq notifier: %d\n",ret);
+		cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+	}
 
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-out:
 	return ret;
 }
 
-- 
1.9.1
