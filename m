Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 09:24:10 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64840 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011468AbaJOHYG4L4OS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 09:24:06 +0200
Received: by mail-pd0-f180.google.com with SMTP id fp1so757984pdb.25
        for <multiple recipients>; Wed, 15 Oct 2014 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dhH/W2oYIIO8mjQ5NYd2sfrCUY9J+0Z8jWeGDSHLtYk=;
        b=OiBt7uPq9aWF/lQ0kHvx+v0sI1Y4CLAjIA3P4UbaAwUSfhIUoAWIyLBVGq+TO/xGyN
         4vz2byGvCu8OSxlBy3wEvAvOK7MGU+0jBUV3jI1lH/E7TdeU3DkT0w4aSXfPoTO4/6l8
         fn3d3UUHQdOLJCUDcqvmQbg9sZx7x6jYt5/0beiYLztk3q/iRzGE1c4likN+NlILWBLl
         HclzrNEl63vjlQzdLfuubIY7sBV5EYyq9ZspBlc8hX9CZq6zdzN46oY6tJa766uOsIhY
         hPfe3jJmFyh/UKym/wt3pUPMzkWZSsNukDo/MqFzPu4kavbgU0NC7HtMNzVjKndSFkcm
         wPVQ==
X-Received: by 10.69.21.33 with SMTP id hh1mr9572242pbd.42.1413357840329;
        Wed, 15 Oct 2014 00:24:00 -0700 (PDT)
Received: from localhost.localdomain ([171.213.62.98])
        by mx.google.com with ESMTPSA id b3sm16162004pdm.65.2014.10.15.00.23.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Oct 2014 00:23:59 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B (UPDATED)
Date:   Wed, 15 Oct 2014 15:23:32 +0800
Message-Id: <1413357812-16895-1-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43288
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

This patch adds cpufreq driver for Loongson1B which
is capable of changing the CPU frequency dynamically.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/cpufreq/Kconfig        |  10 ++
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/ls1x-cpufreq.c | 233 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 drivers/cpufreq/ls1x-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ffe350f..99464d7 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -250,6 +250,16 @@ config LOONGSON2_CPUFREQ
 
 	  If in doubt, say N.
 
+config LOONGSON1_CPUFREQ
+	tristate "Loongson1 CPUFreq Driver"
+	help
+	  This option adds a CPUFreq driver for loongson1 processors which
+	  support software configurable cpu frequency.
+
+	  For details, take a look at <file:Documentation/cpu-freq/>.
+
+	  If in doubt, say N.
+
 endmenu
 
 menu "PowerPC CPU frequency scaling drivers"
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index db6d9a2..aca7bd3 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
 obj-$(CONFIG_LOONGSON2_CPUFREQ)		+= loongson2_cpufreq.o
+obj-$(CONFIG_LOONGSON1_CPUFREQ)		+= ls1x-cpufreq.o
 obj-$(CONFIG_SH_CPU_FREQ)		+= sh-cpufreq.o
 obj-$(CONFIG_SPARC_US2E_CPUFREQ)	+= sparc-us2e-cpufreq.o
 obj-$(CONFIG_SPARC_US3_CPUFREQ)		+= sparc-us3-cpufreq.o
diff --git a/drivers/cpufreq/ls1x-cpufreq.c b/drivers/cpufreq/ls1x-cpufreq.c
new file mode 100644
index 0000000..2655960
--- /dev/null
+++ b/drivers/cpufreq/ls1x-cpufreq.c
@@ -0,0 +1,233 @@
+/*
+ * CPU Frequency Scaling for Loongson 1 SoC
+ *
+ * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
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
+#include <asm/mach-loongson1/cpufreq.h>
+#include <asm/mach-loongson1/loongson1.h>
+
+static struct {
+	struct device *dev;
+	struct clk *clk;	/* CPU clk */
+	struct clk *mux_clk;	/* MUX of CPU clk */
+	struct clk *pll_clk;	/* PLL clk */
+	struct clk *osc_clk;	/* OSC clk */
+	unsigned int max_freq;
+	unsigned int min_freq;
+} ls1x_cpufreq;
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
+	dev_dbg(ls1x_cpufreq.dev, "%u KHz --> %u KHz\n", old_freq, new_freq);
+	clk_set_parent(policy->clk, ls1x_cpufreq.osc_clk);
+	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) | RST_CPU_EN | RST_CPU,
+		     LS1X_CLK_PLL_DIV);
+	__raw_writel(__raw_readl(LS1X_CLK_PLL_DIV) & ~(RST_CPU_EN | RST_CPU),
+		     LS1X_CLK_PLL_DIV);
+	clk_set_rate(ls1x_cpufreq.mux_clk, new_freq * 1000);
+	clk_set_parent(policy->clk, ls1x_cpufreq.mux_clk);
+
+	return 0;
+}
+
+static int ls1x_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_tbl;
+	unsigned int pll_freq, freq;
+	int steps, i, ret;
+
+	pll_freq = clk_get_rate(ls1x_cpufreq.pll_clk) / 1000;
+
+	steps = 1 << DIV_CPU_WIDTH;
+	freq_tbl = kzalloc(sizeof(*freq_tbl) * steps, GFP_KERNEL);
+	if (!freq_tbl) {
+		dev_err(ls1x_cpufreq.dev,
+			"failed to alloc cpufreq_frequency_table\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < (steps - 1); i++) {
+		freq = pll_freq / (i + 1);
+		if ((freq < ls1x_cpufreq.min_freq) ||
+		    (freq > ls1x_cpufreq.max_freq))
+			freq_tbl[i].frequency = CPUFREQ_ENTRY_INVALID;
+		else
+			freq_tbl[i].frequency = freq;
+		dev_dbg(ls1x_cpufreq.dev,
+			"cpufreq table: index %d: frequency %d\n", i,
+			freq_tbl[i].frequency);
+	}
+	freq_tbl[i].frequency = CPUFREQ_TABLE_END;
+
+	policy->clk = ls1x_cpufreq.clk;
+	ret = cpufreq_generic_init(policy, freq_tbl, 0);
+	if (ret)
+		kfree(freq_tbl);
+out:
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
+	clk_put(ls1x_cpufreq.osc_clk);
+	clk_put(ls1x_cpufreq.clk);
+
+	return 0;
+}
+
+static int ls1x_cpufreq_probe(struct platform_device *pdev)
+{
+	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
+	struct clk *clk;
+	int ret;
+
+	if (!pdata)
+		return -EINVAL;
+	if (!pdata->clk_name)
+		return -EINVAL;
+	if (!pdata->osc_clk_name)
+		return -EINVAL;
+
+	ls1x_cpufreq.dev = &pdev->dev;
+
+	clk = clk_get(NULL, pdata->clk_name);
+	if (IS_ERR(clk)) {
+		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+			pdata->clk_name);
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+	ls1x_cpufreq.clk = clk;
+
+	clk = clk_get_parent(clk);
+	if (IS_ERR(clk)) {
+		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
+			__clk_get_name(ls1x_cpufreq.clk));
+		ret = PTR_ERR(clk);
+		goto err_mux;
+	}
+	ls1x_cpufreq.mux_clk = clk;
+
+	clk = clk_get_parent(clk);
+	if (IS_ERR(clk)) {
+		dev_err(ls1x_cpufreq.dev, "unable to get parent of %s clock\n",
+			__clk_get_name(ls1x_cpufreq.mux_clk));
+		ret = PTR_ERR(clk);
+		goto err_mux;
+	}
+	ls1x_cpufreq.pll_clk = clk;
+
+	clk = clk_get(NULL, pdata->osc_clk_name);
+	if (IS_ERR(clk)) {
+		dev_err(ls1x_cpufreq.dev, "unable to get %s clock\n",
+			pdata->osc_clk_name);
+		ret = PTR_ERR(clk);
+		goto err_mux;
+	}
+	ls1x_cpufreq.osc_clk = clk;
+
+	ls1x_cpufreq.max_freq = pdata->max_freq;
+	ls1x_cpufreq.min_freq = pdata->min_freq;
+
+	ret = cpufreq_register_driver(&ls1x_cpufreq_driver);
+	if (ret) {
+		dev_err(ls1x_cpufreq.dev,
+			"failed to register cpufreq driver: %d\n", ret);
+		goto err_driver;
+	}
+
+	ret = cpufreq_register_notifier(&ls1x_cpufreq_notifier_block,
+					CPUFREQ_TRANSITION_NOTIFIER);
+
+	if (!ret)
+		goto out;
+
+	dev_err(ls1x_cpufreq.dev, "failed to register cpufreq notifier: %d\n",
+		ret);
+
+	cpufreq_unregister_driver(&ls1x_cpufreq_driver);
+err_driver:
+	clk_put(ls1x_cpufreq.osc_clk);
+err_mux:
+	clk_put(ls1x_cpufreq.clk);
+out:
+	return ret;
+}
+
+static struct platform_driver ls1x_cpufreq_platdrv = {
+	.driver = {
+		.name	= "ls1x-cpufreq",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ls1x_cpufreq_probe,
+	.remove		= ls1x_cpufreq_remove,
+};
+
+module_platform_driver(ls1x_cpufreq_platdrv);
+
+MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
