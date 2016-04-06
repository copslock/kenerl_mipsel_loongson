Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Apr 2016 14:36:12 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35711 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026138AbcDFMfuWgRdZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Apr 2016 14:35:50 +0200
Received: by mail-pa0-f68.google.com with SMTP id zy2so3964070pac.2;
        Wed, 06 Apr 2016 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0TMYFFpXKae3A229KObByE1fjBfprJbQqr5Lq5UWjCw=;
        b=E0RzViuVoBr0lSU8HfhTjuQcFgOuVcW9NO/XQnVOrnKnifnIijiZRUTh7tpUswrI/t
         VZQ3/iOk6+3T99zd5I+FFDo/M9rOHSh+hyFc+HYGbWyHmR3vLRHDyvdLk5hBnjCoIvBA
         IpbsJaZN+/PNlWeqCMCKiOoYNQGr+PQc5GhwplMwz7PzmyDlmEYVrBT+t1Bed4bGCGFR
         RfaBSPONibK+hVgP4ub2OOT8bGWM0asmLTy8DFoglbSeAJ+e13cA2DEUAIh3SfUUTwiA
         cuOmC1Nw5LQCRwQb+nj2/1IfVzGIViA4oeu96/QyHmrzfIUXb5SuqUcaGcrn+njb5TvQ
         f+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0TMYFFpXKae3A229KObByE1fjBfprJbQqr5Lq5UWjCw=;
        b=fQ1tVnKd8ReYZSXOcJQV5HK3gRKTJOZOnKFtZSXtHWwbtZfbSrbI3r6b2JYs7XSpJ6
         XUoCxetE8XxV3LY3Fkmp+tRW9bVxGMCcvw4ScV0M5sWAlGSfNcFa2nks2EzFaFaEFj3I
         JstnFu76vq/mBweaCsSQbJ9o8zSh70m8ZQ9QVxs/neBuDr0cHhKzB3dQmAI9WYlVmRZX
         IZi/6usS3SSVITPQxKKL+080z9Z4hPEAQARC3MUQy5pdb0g+sLAuq5ank/uWwYaqOocE
         JvDDHHpN22luDqv48fpl9pE6ScHJqeLMIsB3y4XbPkx/7RXjsYl4x6PHBltCIqIu3nAa
         ncKA==
X-Gm-Message-State: AD7BkJKY3JcgxqYzC489CXOVV4Ykk3lsVr3Pfv29TGxMMatUojJoLxRoSlMlk8otugDtuQ==
X-Received: by 10.66.218.161 with SMTP id ph1mr48994458pac.83.1459946144411;
        Wed, 06 Apr 2016 05:35:44 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id 27sm4851789pfo.58.2016.04.06.05.35.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 05:35:43 -0700 (PDT)
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
Subject: [PATCH V1 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Date:   Wed,  6 Apr 2016 20:34:50 +0800
Message-Id: <1459946095-7637-3-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52908
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
 drivers/cpufreq/Makefile            |   2 +-
 drivers/cpufreq/loongson1-cpufreq.c | 230 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/ls1x-cpufreq.c      | 222 ----------------------------------
 3 files changed, 231 insertions(+), 223 deletions(-)
 create mode 100644 drivers/cpufreq/loongson1-cpufreq.c
 delete mode 100644 drivers/cpufreq/ls1x-cpufreq.c

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
diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
new file mode 100644
index 0000000..d029211
--- /dev/null
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -0,0 +1,230 @@
+/*
+ * CPU Frequency Scaling for Loongson 1 SoC
+ *
+ * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <cpufreq.h>
+#include <loongson1.h>
+
+struct ls1x_cpufreq {
+	struct device *dev;
+	struct clk *clk;	/* CPU clk */
+	struct clk *mux_clk;	/* MUX of CPU clk */
+	struct clk *pll_clk;	/* PLL clk */
+	struct clk *osc_clk;	/* OSC clk */
+	unsigned int max_freq;
+	unsigned int min_freq;
+};
+
+static struct ls1x_cpufreq *cpufreq;
+
+static int ls1x_cpufreq_notifier(struct notifier_block *nb,
+				 unsigned long val, void *data)
+{
+	if (val == CPUFREQ_POSTCHANGE)
+		current_cpu_data.udelay_val = loops_per_jiffy;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block ls1x_cpufreq_notifier_block = {
+	.notifier_call = ls1x_cpufreq_notifier
+};
+
+static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
+			       unsigned int index)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	unsigned int old_freq, new_freq;
+
+	old_freq = policy->cur;
+	new_freq = policy->freq_table[index].frequency;
+
+	/*
+	 * The procedure of reconfiguring CPU clk is as below.
+	 *
+	 *  - Reparent CPU clk to OSC clk
+	 *  - Reset CPU clock (very important)
+	 *  - Reconfigure CPU DIV
+	 *  - Reparent CPU clk back to CPU DIV clk
+	 */
+
+	clk_set_parent(policy->clk, cpufreq->osc_clk);
+	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
+		     LS1X_CLK_PLL_DIV);
+	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
+		     LS1X_CLK_PLL_DIV);
+	clk_set_rate(cpufreq->mux_clk, new_freq * 1000);
+	clk_set_parent(policy->clk, cpufreq->mux_clk);
+	dev_dbg(cpu_dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
+
+	return 0;
+}
+
+static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev = get_cpu_device(policy->cpu);
+	struct cpufreq_frequency_table *freq_tbl;
+	unsigned int pll_freq, freq;
+	int steps, i, ret;
+
+	pll_freq = clk_get_rate(cpufreq->pll_clk) / 1000;
+
+	steps = 1 << DIV_CPU_WIDTH;
+	freq_tbl = kcalloc(steps, sizeof(*freq_tbl), GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
+
+	for (i = 0; i < (steps - 1); i++) {
+		freq = pll_freq / (i + 1);
+		if ((freq < cpufreq->min_freq) || (freq > cpufreq->max_freq))
+			freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
+		else
+			freq_tbl[i].frequency = freq;
+		dev_dbg(cpu_dev,
+			"cpufreq table: index %d: frequency %d\n", i,
+			freq_tbl[i].frequency);
+	}
+	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
+
+	policy->clk = cpufreq->clk;
+	ret = cpufreq_generic_init(policy, freq_tbl, 0);
+	if (ret)
+		kfree(freq_tbl);
+
+	return ret;
+}
+
+static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	kfree(policy->freq_table);
+	return 0;
+}
+
+static struct cpufreq_driver ls1x_cpufreq_driver = {
+	.name		= "cpufreq-ls1x",
+	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= ls1x_cpufreq_target,
+	.get		= cpufreq_generic_get,
+	.init		= ls1x_cpufreq_init,
+	.exit		= ls1x_cpufreq_exit,
+	.attr		= cpufreq_generic_attr,
+};
+
+static int ls1x_cpufreq_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
+				    CPUFREQ_TRANSITION_NOTIFIER);
+	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+
+	return 0;
+}
+
+static int ls1x_cpufreq_probe(struct platform_device *pdev)
+{
+	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
+	struct clk *clk;
+	int ret;
+
+	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {
+		dev_err(&pdev->dev, "platform data missing\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cpufreq =
+	    devm_kzalloc(&pdev->dev, sizeof(struct ls1x_cpufreq), GFP_KERNEL);
+	if (!cpufreq) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cpufreq->dev = &pdev->dev;
+
+	clk = devm_clk_get(&pdev->dev, pdata->clk_name);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get %s clock\n",
+			pdata->clk_name);
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	cpufreq->clk = clk;
+
+	clk = clk_get_parent(clk);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->clk));
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	cpufreq->mux_clk = clk;
+
+	clk = clk_get_parent(clk);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get parent of %s clock\n",
+			__clk_get_name(cpufreq->mux_clk));
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	cpufreq->pll_clk = clk;
+
+	clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "unable to get %s clock\n",
+			pdata->osc_clk_name);
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	cpufreq->osc_clk = clk;
+
+	cpufreq->max_freq = pdata->max_freq;
+	cpufreq->min_freq = pdata->min_freq;
+
+	ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register CPUFreq driver: %d\n", ret);
+		goto out;
+	}
+
+	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+
+	if (!ret)
+		goto out;
+
+	dev_err(&pdev->dev, "failed to register CPUFreq notifier: %d\n", ret);
+
+	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+out:
+	return ret;
+}
+
+static struct platform_driver ls1x_cpufreq_platdrv = {
+	.probe	= ls1x_cpufreq_probe,
+	.remove	= ls1x_cpufreq_remove,
+	.driver	= {
+		.name	= "ls1x-cpufreq",
+	},
+};
+
+module_platform_driver(ls1x_cpufreq_platdrv);
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson1 CPUFreq driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/ls1x-cpufreq.c
deleted file mode 100644
index 262581b..0000000
--- a/drivers/cpufreq/ls1x-cpufreq.c
+++ /dev/null
@@ -1,222 +0,0 @@
-/*
- * CPU Frequency Scaling for Loongson 1 SoC
- *
- * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/clk.h>
-#include <linux/clk-provider.h>
-#include <linux/cpu.h>
-#include <linux/cpufreq.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include <cpufreq.h>
-#include <loongson1.h>
-
-static struct {
-	struct device *dev;
-	struct clk *clk;	/* CPU clk */
-	struct clk *mux_clk;	/* MUX of CPU clk */
-	struct clk *pll_clk;	/* PLL clk */
-	struct clk *osc_clk;	/* OSC clk */
-	unsigned int max_freq;
-	unsigned int min_freq;
-} ls1x_cpufreq;
-
-static int ls1x_cpufreq_notifier(struct notifier_block *nb,
-				 unsigned long val, void *data)
-{
-	if (val == CPUFREQ_POSTCHANGE)
-		current_cpu_data.udelay_val = loops_per_jiffy;
-
-	return NOTIFY_OK;
-}
-
-static struct notifier_block ls1x_cpufreq_notifier_block = {
-	.notifier_call = ls1x_cpufreq_notifier
-};
-
-static int ls1x_cpufreq_target(struct cpufreq_policy *policy,
-			       unsigned int index)
-{
-	unsigned int old_freq, new_freq;
-
-	old_freq = policy->cur;
-	new_freq = policy->freq_table[index].frequency;
-
-	/*
-	 * The procedure of reconfiguring CPU clk is as below.
-	 *
-	 *  - Reparent CPU clk to OSC clk
-	 *  - Reset CPU clock (very important)
-	 *  - Reconfigure CPU DIV
-	 *  - Reparent CPU clk back to CPU DIV clk
-	 */
-
-	dev_dbg(ls1x_cpufreq.dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
-	clk_set_parent(policy->clk, ls1x_cpufreq.osc_clk);
-	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
-		     LS1X_CLK_PLL_DIV);
-	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
-		     LS1X_CLK_PLL_DIV);
-	clk_set_rate(ls1x_cpufreq.mux_clk, new_freq * 1000);
-	clk_set_parent(policy->clk, ls1x_cpufreq.mux_clk);
-
-	return 0;
-}
-
-static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
-{
-	struct cpufreq_frequency_table *freq_tbl;
-	unsigned int pll_freq, freq;
-	int steps, i, ret;
-
-	pll_freq = clk_get_rate(ls1x_cpufreq.pll_clk) / 1000;
-
-	steps = 1 << DIV_CPU_WIDTH;
-	freq_tbl = kzalloc(sizeof(*freq_tbl) * steps, GFP_KERNEL);
-	if (!freq_tbl) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to alloc cpufreq_frequency_table\n");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	for (i = 0; i < (steps - 1); i++) {
-		freq = pll_freq / (i + 1);
-		if ((freq < ls1x_cpufreq.min_freq) ||
-		    (freq > ls1x_cpufreq.max_freq))
-			freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
-		else
-			freq_tbl[i].frequency = freq;
-		dev_dbg(ls1x_cpufreq.dev,
-			"cpufreq table: index %d: frequency %d\n", i,
-			freq_tbl[i].frequency);
-	}
-	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
-
-	policy->clk = ls1x_cpufreq.clk;
-	ret = cpufreq_generic_init(policy, freq_tbl, 0);
-	if (ret)
-		kfree(freq_tbl);
-out:
-	return ret;
-}
-
-static int ls1x_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	kfree(policy->freq_table);
-	return 0;
-}
-
-static struct cpufreq_driver ls1x_cpufreq_driver = {
-	.name		= "cpufreq-ls1x",
-	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= cpufreq_generic_frequency_table_verify,
-	.target_index	= ls1x_cpufreq_target,
-	.get		= cpufreq_generic_get,
-	.init		= ls1x_cpufreq_init,
-	.exit		= ls1x_cpufreq_exit,
-	.attr		= cpufreq_generic_attr,
-};
-
-static int ls1x_cpufreq_remove(struct platform_device *pdev)
-{
-	cpufreq_unregister_notifier(&ls1x_cpufreq_notifier_block,
-				    CPUFREQ_TRANSITION_NOTIFIER);
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-
-	return 0;
-}
-
-static int ls1x_cpufreq_probe(struct platform_device *pdev)
-{
-	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
-	struct clk *clk;
-	int ret;
-
-	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
-		return -EINVAL;
-
-	ls1x_cpufreq.dev = &pdev->dev;
-
-	clk = devm_clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
-			pdata->clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
-	}
-	ls1x_cpufreq.clk = clk;
-
-	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.clk));
-		ret = PTR_ERR(clk);
-		goto out;
-	}
-	ls1x_cpufreq.mux_clk = clk;
-
-	clk = clk_get_parent(clk);
-	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
-			__clk_get_name(ls1x_cpufreq.mux_clk));
-		ret = PTR_ERR(clk);
-		goto out;
-	}
-	ls1x_cpufreq.pll_clk = clk;
-
-	clk = devm_clk_get(&pdev->dev, pdata->osc_clk_name);
-	if (IS_ERR(clk)) {
-		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
-			pdata->osc_clk_name);
-		ret = PTR_ERR(clk);
-		goto out;
-	}
-	ls1x_cpufreq.osc_clk = clk;
-
-	ls1x_cpufreq.max_freq = pdata->max_freq;
-	ls1x_cpufreq.min_freq = pdata->min_freq;
-
-	ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
-	if (ret) {
-		dev_err(ls1x_cpufreq.dev,
-			"failed to register cpufreq driver: %d\n", ret);
-		goto out;
-	}
-
-	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
-					CPUFREQ_TRANSITION_NOTIFIER);
-
-	if (!ret)
-		goto out;
-
-	dev_err(ls1x_cpufreq.dev, "failed to register cpufreq notifier: %d\n",
-		ret);
-
-	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
-out:
-	return ret;
-}
-
-static struct platform_driver ls1x_cpufreq_platdrv = {
-	.driver = {
-		.name	= "ls1x-cpufreq",
-	},
-	.probe		= ls1x_cpufreq_probe,
-	.remove		= ls1x_cpufreq_remove,
-};
-
-module_platform_driver(ls1x_cpufreq_platdrv);
-
-MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
-MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
-MODULE_LICENSE("GPL");
-- 
1.9.1
