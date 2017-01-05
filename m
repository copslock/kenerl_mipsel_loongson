Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 07:33:20 +0100 (CET)
Received: from smtpbgau2.qq.com ([54.206.34.216]:41087 "EHLO smtpbgau2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbdAEGdMsQItz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jan 2017 07:33:12 +0100
X-QQ-mid: Xesmtp31t1483597978tvgu23zi3
Received: from localhost (unknown [113.87.162.116])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 05 Jan 2017 14:32:56 +0800 (CST)
X-QQ-SSF: 00000000000000000M104F00000000U
X-QQ-FEAT: Tp2hW+Mew+cD1CoLxXpMia6FIR9r035SkKUk3xYMgaqALT08Gl/Rytsy/8udy
        h8qXSy6vG2WYPZU1inDIIokWVBkvBE3ykKJlurDYL+smm0lm6FFWwv5bnshjtQuRo3GZ4Yw
        zP3NrO1G6nw/UIwi9Bt0u35LKr5Cg/JIiQRPglCSj5hbNK3ZGQWYjHMTfD20LDL2YZAIkR3
        GEjbbHxuvOgj/Qry2eBepIaJIpGUojAhuvmc+t57NyQ2Ud/iaBhXXaUTVg8efu8nES95jRo
        3qV3CiKMo5Ne4JhgZur17rVKc=
X-QQ-GoodBg: 0
Date:   Thu, 5 Jan 2017 14:32:55 +0800
From:   =?utf-8?B?6LCi6Ie06YKmIChYSUUgWmhpYmFuZyk=?= <Yeking@Red54.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Loongson: Add OSC support
Message-ID: <20170105063237.GB14323@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received: from Red54.com (unknown [183.39.159.125]) by esmtp4.qq.com (ESMTP)
 with SMTP id 0 for <linux-mips@linux-mips.org>; Thu, 05 Jan 2017 00:01:24
 +0800 (CST)
X-QQ-SSF: 00000000000000100M104F00000000U
X-QQ-FEAT: Tp2hW+Mew+dm8lBh5eAPwDvseNBd29svfKmmUiXg9GDetKEVCV0nkKuNgQHYG
 HZJSUu/vBOWB50OjOsNxkjLLKFAzmcI5skjRMYQljrIZRoQ2Y/g/Ggzkv9xeJ4umJXmG1z9
 ai2YpBm/j7mEgo3SMkbUOn+fFF7h+fCXQbjNjxCX+KiAvDbgNdjqcO6NbcBX0Z1S74nHjs3
 G+NFUYqWC/U2WhYkXxcFHQgr6oNjJQoJW8T9h3b0yyLHPdRHwfc2cObKMAvzb8sHNAROJ+F
 3/A8vCKMe4ou/1m5Pc2T3NM0w=
X-QQ-GoodBg: 0
Received: by Red54.com (sSMTP sendmail emulation); Thu, 05 Jan 2017 00:01:24
 +0800
User-Agent: Mutt/1.7.2 (2016-11-26)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:Red54.com:bgforeign:bgforeign1
X-QQ-Bgrelay: 1
Return-Path: <Yeking@Red54.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Yeking@Red54.com
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

Loongson 1B can connect to 25MHz or 33MHz OSC.

Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
---
 arch/mips/loongson32/Kconfig           | 15 +++++++++++++++
 arch/mips/loongson32/common/platform.c |  8 ++++++++
 drivers/clk/loongson1/clk-loongson1b.c |  6 +++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index 3c0c2f20..1893e08b 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -19,6 +19,21 @@ config LOONGSON1_LS1B
 	select USE_GENERIC_EARLY_PRINTK_8250
 	select COMMON_CLK
 
+if LOONGSON1_LS1B
+
+choice
+	prompt "OSC Type"
+	default OSC_33M
+
+config OSC_33M
+	bool "33 MHz OSC"
+
+config OSC_25M
+	bool "25 MHz OSC"
+endchoice
+
+endif
+
 config LOONGSON1_LS1C
 	bool "Loongson LS1C board"
 	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index f9d877d4..683c8469 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -83,8 +83,16 @@ void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
 	.osc_clk_name	= "osc_clk",
+#if defined(CONFIG_LOONGSON1_LS1C)
+	.max_freq	= 300 * 1000,
+	.min_freq	= 24 * 1000,
+#elif defined(CONFIG_OSC_25M)
+	.max_freq	= 200 * 1000,
+	.min_freq	= 25 * 1000,
+#else
 	.max_freq	= 266 * 1000,
 	.min_freq	= 33 * 1000,
+#endif
 };
 
 struct platform_device ls1x_cpufreq_pdev = {
diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
index f36a97e9..225b53e7 100644
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -15,7 +15,11 @@
 #include <loongson1.h>
 #include "clk.h"
 
+#if defined(CONFIG_OSC_25M)
+#define OSC		(25 * 1000000)
+#else
 #define OSC		(33 * 1000000)
+#endif
 #define DIV_APB		2
 
 static DEFINE_SPINLOCK(_lock);
@@ -48,7 +52,7 @@ void __init ls1x_clk_init(void)
 	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
 	clk_hw_register_clkdev(hw, "osc_clk", NULL);
 
-	/* clock derived from 33 MHz OSC clk */
+	/* clock derived from OSC clk */
 	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
 				 &ls1x_pll_clk_ops, 0);
 	clk_hw_register_clkdev(hw, "pll_clk", NULL);
-- 
2.11.0
