Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 22:53:12 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.12]:35550 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdBFVwQgnnWT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 22:52:16 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id arCocb3LlcWiHarCpclgnf; Mon, 06 Feb 2017 14:52:15 -0700
X-Authority-Analysis: v=2.2 cv=JLBLi4Cb c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=BraJ9Q4k4nOvCSIzy4UA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 57AAD33ABBB8; Mon,  6 Feb 2017 13:52:14 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
Date:   Mon,  6 Feb 2017 13:51:18 -0800
Message-Id: <20170206215119.87099-4-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170206215119.87099-1-code@mmayer.net>
References: <20170206215119.87099-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfJWyhVw3QtdehsM8sYWuMQ44Itri8knXkdf1o0g/VcwqLqWmuD+cLBvURYvdWW14i6szpgCHjCQkWhXe2gMAcqNyBpxarturerwl8C8CkJD3EPsxSdH7
 8bhxmHu23v4qz08zINntgPxbIyNR1IU0rKJFb46WLNTsXYkSQjUcQtGmZwV64ZMh0D8XVbzR3BhU9MdfMqFiG4uC/J+lKC2vYffwjWwCC29arDyHLq/W92L8
 rkAHOIo4zKS/B1V6R0+V1kTYHbXyqQCiMXIFtU49PUaeATYF8AulvU+hiDMHsl7x/WUPatpKCfLbgOQ/hFkRLGBPeQeyxQ2oI9laSnaoiteA6Cv0RxXJE/Qw
 W1LtPHHb1w2KdajsjMjkQ8vsnimNjg==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

From: Markus Mayer <mmayer@broadcom.com>

Add the MIPS CPUfreq driver. This driver currently supports CPUfreq on
BMIPS5xxx-based SoCs.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/Kconfig         |  10 +++
 drivers/cpufreq/Makefile        |   1 +
 drivers/cpufreq/bmips-cpufreq.c | 195 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 15adef4..ec040a5 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -263,6 +263,16 @@ config IA64_ACPI_CPUFREQ
 endif
 
 if MIPS
+config BMIPS_CPUFREQ
+	tristate "BMIPS CPUfreq Driver"
+	help
+	  This option adds a CPUfreq driver for BMIPS processors with
+	  support for configurable CPU frequency.
+
+	  For now, BMIPS5 chips are supported (such as the Broadcom 7425).
+
+	  If in doubt, say N.
+
 config LOONGSON2_CPUFREQ
 	tristate "Loongson2 CPUFreq Driver"
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 1e46c39..b7b3fc7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -98,6 +98,7 @@ obj-$(CONFIG_POWERNV_CPUFREQ)		+= powernv-cpufreq.o
 # Other platform drivers
 obj-$(CONFIG_AVR32_AT32AP_CPUFREQ)	+= at32ap-cpufreq.o
 obj-$(CONFIG_BFIN_CPU_FREQ)		+= blackfin-cpufreq.o
+obj-$(CONFIG_BMIPS_CPUFREQ)		+= bmips-cpufreq.o
 obj-$(CONFIG_CRIS_MACH_ARTPEC3)		+= cris-artpec3-cpufreq.o
 obj-$(CONFIG_ETRAXFS)			+= cris-etraxfs-cpufreq.o
 obj-$(CONFIG_IA64_ACPI_CPUFREQ)		+= ia64-acpi-cpufreq.o
diff --git a/drivers/cpufreq/bmips-cpufreq.c b/drivers/cpufreq/bmips-cpufreq.c
new file mode 100644
index 0000000..505aa83
--- /dev/null
+++ b/drivers/cpufreq/bmips-cpufreq.c
@@ -0,0 +1,195 @@
+/*
+ * CPU frequency scaling for Broadcom BMIPS SoCs
+ *
+ * Copyright (c) 2017 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+/* for mips_hpt_frequency */
+#include <asm/time.h>
+
+#define BMIPS_CPUFREQ_PREFIX	"bmips"
+#define BMIPS_CPUFREQ_NAME	BMIPS_CPUFREQ_PREFIX "-cpufreq"
+
+#define TRANSITION_LATENCY	(25 * 1000)	/* 25 us */
+
+#define BMIPS5_CLK_DIV_SET_SHIFT	0x7
+#define BMIPS5_CLK_DIV_SHIFT		0x4
+#define BMIPS5_CLK_DIV_MASK		0xf
+
+enum bmips_type {
+	BMIPS5000,
+	BMIPS5200,
+};
+
+struct cpufreq_compat {
+	const char *compatible;
+	unsigned int bmips_type;
+	unsigned int clk_mult;
+	unsigned int max_freqs;
+};
+
+#define BMIPS(c, t, m, f) { \
+	.compatible = c, \
+	.bmips_type = (t), \
+	.clk_mult = (m), \
+	.max_freqs = (f), \
+}
+
+static struct cpufreq_compat bmips_cpufreq_compat[] = {
+	BMIPS("brcm,bmips5000", BMIPS5000, 8, 4),
+	BMIPS("brcm,bmips5200", BMIPS5200, 8, 4),
+	{ }
+};
+
+static struct cpufreq_compat *priv;
+
+static int htp_freq_to_cpu_freq(unsigned int clk_mult)
+{
+	return mips_hpt_frequency * clk_mult / 1000;
+}
+
+static struct cpufreq_frequency_table *
+bmips_cpufreq_get_freq_table(const struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table;
+	unsigned long cpu_freq;
+	int i;
+
+	cpu_freq = htp_freq_to_cpu_freq(priv->clk_mult);
+
+	table = kmalloc((priv->max_freqs + 1) * sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < priv->max_freqs; i++) {
+		table[i].frequency = cpu_freq / (1 << i);
+		table[i].driver_data = i;
+	}
+	table[i].frequency = CPUFREQ_TABLE_END;
+
+	return table;
+}
+
+static unsigned int bmips_cpufreq_get(unsigned int cpu)
+{
+	unsigned long freq, cpu_freq;
+	unsigned int div;
+	uint32_t mode;
+
+	switch (priv->bmips_type) {
+	case BMIPS5200:
+	case BMIPS5000:
+		mode = read_c0_brcm_mode();
+		div = ((mode >> BMIPS5_CLK_DIV_SHIFT) & BMIPS5_CLK_DIV_MASK);
+		break;
+	default:
+		div = 0;
+	}
+
+	cpu_freq = htp_freq_to_cpu_freq(priv->clk_mult);
+	freq = cpu_freq / (1 << div);
+
+	return freq;
+}
+
+static int bmips_cpufreq_target_index(struct cpufreq_policy *policy,
+				      unsigned int index)
+{
+	unsigned int div = policy->freq_table[index].driver_data;
+
+	switch (priv->bmips_type) {
+	case BMIPS5200:
+	case BMIPS5000:
+		change_c0_brcm_mode(BMIPS5_CLK_DIV_MASK << BMIPS5_CLK_DIV_SHIFT,
+				    (1 << BMIPS5_CLK_DIV_SET_SHIFT) |
+				    (div << BMIPS5_CLK_DIV_SHIFT));
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
+static int bmips_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	kfree(policy->freq_table);
+
+	return 0;
+}
+
+static int bmips_cpufreq_init(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *freq_table;
+	int ret;
+
+	/* Store the compatibility data. */
+	priv = cpufreq_get_driver_data();
+
+	freq_table = bmips_cpufreq_get_freq_table(policy);
+	if (IS_ERR(freq_table)) {
+		ret = PTR_ERR(freq_table);
+		pr_err("%s: couldn't determine frequency table (%d).\n",
+			BMIPS_CPUFREQ_NAME, ret);
+		return ret;
+	}
+
+	ret = cpufreq_generic_init(policy, freq_table, TRANSITION_LATENCY);
+	if (ret)
+		bmips_cpufreq_exit(policy);
+	else
+		pr_info("%s: registered\n", BMIPS_CPUFREQ_NAME);
+
+	return ret;
+}
+
+static struct cpufreq_driver bmips_cpufreq_driver = {
+	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= bmips_cpufreq_target_index,
+	.get		= bmips_cpufreq_get,
+	.init		= bmips_cpufreq_init,
+	.exit		= bmips_cpufreq_exit,
+	.attr		= cpufreq_generic_attr,
+	.name		= BMIPS_CPUFREQ_PREFIX,
+};
+
+static int __init bmips_cpufreq_probe(void)
+{
+	struct cpufreq_compat *cc;
+	struct device_node *np;
+
+	for (cc = bmips_cpufreq_compat; cc->compatible; cc++) {
+		np = of_find_compatible_node(NULL, "cpu", cc->compatible);
+		if (np) {
+			of_node_put(np);
+			bmips_cpufreq_driver.driver_data = cc;
+			break;
+		}
+	}
+
+	/* We hit the guard element of the array. No compatible CPU found. */
+	if (!cc->compatible)
+		return -ENODEV;
+
+	return cpufreq_register_driver(&bmips_cpufreq_driver);
+}
+device_initcall(bmips_cpufreq_probe);
+
+MODULE_AUTHOR("Markus Mayer <mmayer@broadcom.com>");
+MODULE_DESCRIPTION("CPUfreq driver for Broadcom BMIPS SoCs");
+MODULE_LICENSE("GPL");
-- 
2.7.4
