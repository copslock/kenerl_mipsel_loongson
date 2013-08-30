Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 16:57:44 +0200 (CEST)
Received: from mailout2.samsung.com ([203.254.224.25]:37429 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6826364Ab3H3OzVTGPzA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 16:55:21 +0200
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSC004XNMRXSZK0@mailout2.samsung.com> for
 linux-mips@linux-mips.org; Fri, 30 Aug 2013 23:55:12 +0900 (KST)
X-AuditID: cbfee61b-b7f776d0000016c8-36-5220b250ecb4
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id BD.1A.05832.052B0225; Fri,
 30 Aug 2013 23:55:12 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MSC00KB2MP05U90@mmp1.samsung.com>; Fri,
 30 Aug 2013 23:55:12 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 3/5] clk: Add common __clk_get(), __clk_put() implementations
Date:   Fri, 30 Aug 2013 16:53:20 +0200
Message-id: <1377874402-2944-4-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t9jAd2ATQpBBg2/DCzeb5zHZNHzp9Li
        bNMbdovOiUvYLTY9vsZqcXnXHDaLCVMnsVvM+TOF2eL2ZV6LpxMuslncblzBZnH4TTurxfoZ
        r1kceD1amnvYPD58jPOY3TGT1ePOtT1sHkdXrmXy2Lyk3mP31yZGj74tqxg9Pm+SC+CM4rJJ
        Sc3JLEst0rdL4MqYsqKNtaBduWLHiinMDYznZboYOTkkBEwkdi9exgphi0lcuLeerYuRi0NI
        YBGjxMu3c1ggnA4mife3ljGBVLEJGEr0Hu1jBLFFBDQkpnQ9ZgcpYha4zCSx6UsXO0hCWCBA
        4u3+XSwgNouAqsSszdfAbF4BV4lFv78BNXMArVOQmDPJBiTMKeAmcWEayGZOoGWuEnNOrGKc
        wMi7gJFhFaNoakFyQXFSeq6RXnFibnFpXrpecn7uJkZwyD6T3sG4qsHiEKMAB6MSD+/O5QpB
        QqyJZcWVuYcYJTiYlUR4Py4GCvGmJFZWpRblxxeV5qQWH2KU5mBREuc92GodKCSQnliSmp2a
        WpBaBJNl4uCUamBUTVfziDn8KbQ2Jlnl6PpZ9xzVVi+7PO9nufzj2zPYNY0C/CySU1p6k545
        /bW/dL3M9qFZYe9Xh0mKCxiu+R7psFk6w8zslcyvjTK+l2ZclAt6OGVa7q+He5gu6hxe6rPl
        2GKPXwffBbNoswpelNi2c/+i/1b26j+SHj4+X/cnO2ZiB4deXv8DJZbijERDLeai4kQAcGyx
        31UCAAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: s.nawrocki@samsung.com
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
Changes since v5:
 - none.

Changes since v4:
 - dropped unnecessary struct module forward declaration from
   clk-provider.h

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
 include/linux/clkdev.h             |    5 +++++
 7 files changed, 36 insertions(+)

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
index 8f18564..dcf061a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1965,6 +1965,26 @@ void devm_clk_unregister(struct device *dev, struct clk *clk)
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
1.7.9.5
