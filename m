Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 17:21:59 +0200 (CEST)
Received: from mail-ea0-f173.google.com ([209.85.215.173]:49957 "EHLO
        mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825118Ab3HXPVTVkAcb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 17:21:19 +0200
Received: by mail-ea0-f173.google.com with SMTP id g10so800437eak.4
        for <multiple recipients>; Sat, 24 Aug 2013 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BI6WDRHrHM8kbIV3CshIfJziJEY+tkWAEsJjq/mzjWY=;
        b=WJZArB6SA3ErzsknPUupO8GyCP0WsNYXiiLRYkMAUjiOzJ17AVoxNiScfATUTPH5e5
         756AGoizaIU3XoMu93LkGJs0+FY45nm7NlBlAuwRVTKHLN+ptpltmEBycY9G86/fEaZE
         /VuWPQh9yqg7Danv8g48HCtCFExFvPz6wtCN7JVCn1SQe1gJGA2kaA8nCBVKx2mXkPAZ
         fTM2wuBa+utL9Zfx7Hlk05hruH02wNQY/9toR4/uV3gYgNzpdknEahkMblK/qa/vOXjO
         eI9ZEdFWSsVoru/lGwnJ+M/bRrITbc2+jpF1+Irt9GFik4OR/BXdMkMo51kE9N1cVlKm
         AcDw==
X-Received: by 10.14.220.200 with SMTP id o48mr528075eep.62.1377357674012;
        Sat, 24 Aug 2013 08:21:14 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id x47sm7415825eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 08:21:13 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com
Subject: [PATCH v4 3/5] clk: Add common __clk_get(), __clk_put() implementations
Date:   Sat, 24 Aug 2013 17:19:47 +0200
Message-Id: <1377357589-13242-4-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1377357589-13242-1-git-send-email-s.nawrocki@samsung.com>
References: <1377357589-13242-1-git-send-email-s.nawrocki@samsung.com>
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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

This patch adds common __clk_get(), __clk_put() clkdev helpers which
replace their platform specific counterparts when the common clock
API is enabled.

The owner module pointer field is added to struct clk so a reference
to the clock supplier module can be taken by the clock consumers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v3:
 - dropped exporting of __clk_get(), __clk_put().

Changes since v2:
 - fixed handling of NULL clock pointers in __clk_get(), __clk_put();
---
 arch/arm/include/asm/clkdev.h      |    2 ++
 arch/blackfin/include/asm/clkdev.h |    2 ++
 arch/mips/include/asm/clkdev.h     |    2 ++
 arch/sh/include/asm/clkdev.h       |    2 ++
 drivers/clk/clk.c                  |   20 ++++++++++++++++++++
 include/linux/clk-private.h        |    3 +++
 include/linux/clk-provider.h       |    2 ++
 include/linux/clkdev.h             |    5 +++++
 8 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/clkdev.h b/arch/arm/include/asm/clkdev.h
index 80751c1..4e8a4b2 100644
--- a/arch/arm/include/asm/clkdev.h
+++ b/arch/arm/include/asm/clkdev.h
@@ -14,12 +14,14 @@
 
 #include <linux/slab.h>
 
+#ifndef CONFIG_COMMON_CLK
 #ifdef CONFIG_HAVE_MACH_CLKDEV
 #include <mach/clkdev.h>
 #else
 #define __clk_get(clk)	({ 1; })
 #define __clk_put(clk)	do { } while (0)
 #endif
+#endif
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/arch/blackfin/include/asm/clkdev.h b/arch/blackfin/include/asm/clkdev.h
index 9053bed..7ac2436 100644
--- a/arch/blackfin/include/asm/clkdev.h
+++ b/arch/blackfin/include/asm/clkdev.h
@@ -8,7 +8,9 @@ static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 	return kzalloc(size, GFP_KERNEL);
 }
 
+#ifndef CONFIG_COMMON_CLK
 #define __clk_put(clk)
 #define __clk_get(clk) ({ 1; })
+#endif
 
 #endif
diff --git a/arch/mips/include/asm/clkdev.h b/arch/mips/include/asm/clkdev.h
index 2624754..1b3ad7b 100644
--- a/arch/mips/include/asm/clkdev.h
+++ b/arch/mips/include/asm/clkdev.h
@@ -14,8 +14,10 @@
 
 #include <linux/slab.h>
 
+#ifndef CONFIG_COMMON_CLK
 #define __clk_get(clk)	({ 1; })
 #define __clk_put(clk)	do { } while (0)
+#endif
 
 static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 {
diff --git a/arch/sh/include/asm/clkdev.h b/arch/sh/include/asm/clkdev.h
index 6ba9186..c419014 100644
--- a/arch/sh/include/asm/clkdev.h
+++ b/arch/sh/include/asm/clkdev.h
@@ -25,7 +25,9 @@ static inline struct clk_lookup_alloc *__clkdev_alloc(size_t size)
 		return kzalloc(size, GFP_KERNEL);
 }
 
+#ifndef CONFIG_COMMON_CLK
 #define __clk_put(clk)
 #define __clk_get(clk) ({ 1; })
+#endif
 
 #endif /* __CLKDEV_H__ */
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f46444f..8ccc1cd 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1959,6 +1959,26 @@ void devm_clk_unregister(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(devm_clk_unregister);
 
+/*
+ * clkdev helpers
+ */
+int __clk_get(struct clk *clk)
+{
+	if (clk && !try_module_get(clk->owner))
+		return 0;
+
+	return 1;
+}
+
+void __clk_put(struct clk *clk)
+{
+	if (WARN_ON_ONCE(IS_ERR(clk)))
+		return;
+
+	if (clk)
+		module_put(clk->owner);
+}
+
 /***        clk rate change notifiers        ***/
 
 /**
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 8138c94..8cb1865 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -25,10 +25,13 @@
 
 #ifdef CONFIG_COMMON_CLK
 
+struct module;
+
 struct clk {
 	const char		*name;
 	const struct clk_ops	*ops;
 	struct clk_hw		*hw;
+	struct module		*owner;
 	struct clk		*parent;
 	const char		**parent_names;
 	struct clk		**parents;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 1f0285b..6341e79 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -141,6 +141,8 @@ struct clk_ops {
 	void		(*init)(struct clk_hw *hw);
 };
 
+struct module;
+
 /**
  * struct clk_init_data - holds init data that's common to all clocks and is
  * shared between the clock provider and the common clock framework.
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index a6a6f60..94bad77 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -43,4 +43,9 @@ int clk_add_alias(const char *, const char *, char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *, ...);
 int clk_register_clkdevs(struct clk *, struct clk_lookup *, size_t);
 
+#ifdef CONFIG_COMMON_CLK
+int __clk_get(struct clk *clk);
+void __clk_put(struct clk *clk);
+#endif
+
 #endif
-- 
1.7.4.1
