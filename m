Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 12:52:43 +0200 (CEST)
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34075 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993254AbcHLKwRjLkG5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 12:52:17 +0200
Received: by mail-pf0-f194.google.com with SMTP id g202so1387766pfb.1
        for <linux-mips@linux-mips.org>; Fri, 12 Aug 2016 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jcGA3gZtLzGYZjlucUtCs0kIkcQwujezV4QpFxcWcV0=;
        b=psz+hZeeLuhL2m7d6JhXhCRJfxjk7OQOFv2L2jGRny202m9rGLDQJ6GiX+YlrX2FJw
         8RGKX+dcFpVte2mJHMUyCT/KtzKNYA2KJqD4DvCMikQERzHAm7yebYd/TlWZChzoZRSq
         mJ00TgDNfF+ZsNxwDTuZJ/SGOCiV+V8kphN/qMyPZBcpfeSJozY6X3f2tBS2KDvrG88G
         KQD7kX4eLYv82cYkoF8Tt4ToARSmy/bAFu4HI8qGTO8URmotku/zMohlQFc8NsSjhcvB
         XehknkyVKoIe+kddpr4f0patQ+eNVz0HJaDBocAuwDMMV/ifB8qFiZMc50bdUFTAO3mc
         fXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jcGA3gZtLzGYZjlucUtCs0kIkcQwujezV4QpFxcWcV0=;
        b=B01fjqyxyGgIpi7B4XfESTE2IAuIENzAJJEAJG/Qi/wpEV80oCWRcrofR7OgGvvozb
         wvcfpV+TZnUTMG59t2MIkIb1EbGz6y2TpiB+NfQJ3IBxZM6CVnYe5go03Z7m90Tt1XZx
         vasfiHXsQf4+MfHnAVLi482Tijh/OWNW05l+KtOnmAlIGEH7nkJfNFAIV76OHvKTbm8p
         VyUq8R6SCSMRlCFft5sjzW8plYNt4MQdesomqx7nHpKJIlSUwFtrTqLZmaM17V/sZvg2
         WJl5RnWGzfg9IEZcF9ynTb4OcmXvbJvD6R4+1AqazdfhgoN9VBv1QaFGuQiyGzmP8edA
         Oq1Q==
X-Gm-Message-State: AEkoousj/x9FMxYNhCWfuwbKmHTeW2A8ytqMM/gN5rZjm2LWOUwqJeHWvxM3u33LjgWrmg==
X-Received: by 10.98.7.200 with SMTP id 69mr26015987pfh.33.1470999131488;
        Fri, 12 Aug 2016 03:52:11 -0700 (PDT)
Received: from localhost.localdomain ([175.111.195.49])
        by smtp.gmail.com with ESMTPSA id k78sm12034940pfa.78.2016.08.12.03.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Aug 2016 03:52:10 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 1/3] clk: Loongson1: Refactor Loongson1 clock
Date:   Fri, 12 Aug 2016 18:51:46 +0800
Message-Id: <1470999108-9851-2-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
References: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
Return-Path: <keguang.zhang@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54503
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

Factor out the common functions into loongson1/clk.c
to support both Loongson1B and Loongson1C. And, put
the rest into loongson1/clk-loongson1b.c.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 drivers/clk/Makefile                               |  2 +-
 drivers/clk/loongson1/Makefile                     |  2 +
 .../clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} | 48 ++------------------
 drivers/clk/loongson1/clk.c                        | 52 ++++++++++++++++++++++
 drivers/clk/loongson1/clk.h                        | 21 +++++++++
 5 files changed, 80 insertions(+), 45 deletions(-)
 create mode 100644 drivers/clk/loongson1/Makefile
 rename drivers/clk/{clk-ls1x.c => loongson1/clk-loongson1b.c} (80%)
 create mode 100644 drivers/clk/loongson1/clk.c
 create mode 100644 drivers/clk/loongson1/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3b6f9cf..a508375 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
-obj-$(CONFIG_MACH_LOONGSON32)		+= clk-ls1x.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
@@ -91,3 +90,4 @@ obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
new file mode 100644
index 0000000..5a162a1
--- /dev/null
+++ b/drivers/clk/loongson1/Makefile
@@ -0,0 +1,2 @@
+obj-y				+= clk.o
+obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
diff --git a/drivers/clk/clk-ls1x.c b/drivers/clk/loongson1/clk-loongson1b.c
similarity index 80%
rename from drivers/clk/clk-ls1x.c
rename to drivers/clk/loongson1/clk-loongson1b.c
index 5097831..336ff95 100644
--- a/drivers/clk/clk-ls1x.c
+++ b/drivers/clk/loongson1/clk-loongson1b.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2012 Zhang, Keguang <keguang.zhang@gmail.com>
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -10,25 +10,16 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/slab.h>
 #include <linux/err.h>
 
 #include <loongson1.h>
+#include "clk.h"
 
 #define OSC		(33 * 1000000)
 #define DIV_APB		2
 
 static DEFINE_SPINLOCK(_lock);
 
-static int ls1x_pll_clk_enable(struct clk_hw *hw)
-{
-	return 0;
-}
-
-static void ls1x_pll_clk_disable(struct clk_hw *hw)
-{
-}
-
 static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
 					  unsigned long parent_rate)
 {
@@ -48,38 +39,6 @@ static const struct clk_ops ls1x_pll_clk_ops = {
 	.recalc_rate = ls1x_pll_recalc_rate,
 };
 
-static struct clk *__init clk_register_pll(struct device *dev,
-					   const char *name,
-					   const char *parent_name,
-					   unsigned long flags)
-{
-	struct clk_hw *hw;
-	struct clk *clk;
-	struct clk_init_data init;
-
-	/* allocate the divider */
-	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
-	if (!hw) {
-		pr_err("%s: could not allocate clk_hw\n", __func__);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	init.name = name;
-	init.ops = &ls1x_pll_clk_ops;
-	init.flags = flags | CLK_IS_BASIC;
-	init.parent_names = (parent_name ? &parent_name : NULL);
-	init.num_parents = (parent_name ? 1 : 0);
-	hw->init = &init;
-
-	/* register the clock */
-	clk = clk_register(dev, hw);
-
-	if (IS_ERR(clk))
-		kfree(hw);
-
-	return clk;
-}
-
 static const char * const cpu_parents[] = { "cpu_clk_div", "osc_33m_clk", };
 static const char * const ahb_parents[] = { "ahb_clk_div", "osc_33m_clk", };
 static const char * const dc_parents[] = { "dc_clk_div", "osc_33m_clk", };
@@ -92,7 +51,8 @@ void __init ls1x_clk_init(void)
 	clk_register_clkdev(clk, "osc_33m_clk", NULL);
 
 	/* clock derived from 33 MHz OSC clk */
-	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk", 0);
+	clk = clk_register_pll(NULL, "pll_clk", "osc_33m_clk",
+			       &ls1x_pll_clk_ops, 0);
 	clk_register_clkdev(clk, "pll_clk", NULL);
 
 	/* clock derived from PLL clk */
diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
new file mode 100644
index 0000000..367b84a
--- /dev/null
+++ b/drivers/clk/loongson1/clk.c
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+
+int ls1x_pll_clk_enable(struct clk_hw *hw)
+{
+	return 0;
+}
+
+void ls1x_pll_clk_disable(struct clk_hw *hw)
+{
+}
+
+struct clk *__init clk_register_pll(struct device *dev,
+				    const char *name,
+				    const char *parent_name,
+				    const struct clk_ops *ops,
+				    unsigned long flags)
+{
+	struct clk_hw *hw;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+	hw->init = &init;
+
+	/* register the clock */
+	clk = clk_register(dev, hw);
+
+	if (IS_ERR(clk))
+		kfree(hw);
+
+	return clk;
+}
+
diff --git a/drivers/clk/loongson1/clk.h b/drivers/clk/loongson1/clk.h
new file mode 100644
index 0000000..aa880e6
--- /dev/null
+++ b/drivers/clk/loongson1/clk.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LOONGSON1_CLK_H
+#define __LOONGSON1_CLK_H
+
+int ls1x_pll_clk_enable(struct clk_hw *hw);
+void ls1x_pll_clk_disable(struct clk_hw *hw);
+struct clk *__init clk_register_pll(struct device *dev,
+				    const char *name,
+				    const char *parent_name,
+				    const struct clk_ops *ops,
+				    unsigned long flags);
+
+#endif /* __LOONGSON1_CLK_H */
-- 
1.9.1
