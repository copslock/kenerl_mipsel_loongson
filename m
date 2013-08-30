Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 16:55:21 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:44969 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825655Ab3H3OyUu0ACE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Aug 2013 16:54:20 +0200
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSC002TJMQ4N5M0@mailout3.samsung.com> for
 linux-mips@linux-mips.org; Fri, 30 Aug 2013 23:54:11 +0900 (KST)
X-AuditID: cbfee61a-b7f7a6d00000235f-f2-5220b21355f2
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm1.samsung.com (EPCPMTA) with SMTP id D4.1F.09055.312B0225; Fri,
 30 Aug 2013 23:54:11 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MSC00KB2MP05U90@mmp1.samsung.com>; Fri,
 30 Aug 2013 23:54:11 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v6 1/5] clk: Provide not locked variant of
 of_clk_get_from_provider()
Date:   Fri, 30 Aug 2013 16:53:18 +0200
Message-id: <1377874402-2944-2-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t9jAV3hTQpBBhcfC1q83ziPyaLnT6XF
        2aY37BadE5ewW2x6fI3V4vKuOWwWE6ZOYreY82cKs8Xty7wWTydcZLO43biCzeLwm3ZWi/Uz
        XrM48Hq0NPeweXz4GOcxu2Mmq8eda3vYPI6uXMvksXlJvcfur02MHn1bVjF6fN4kF8AZxWWT
        kpqTWZZapG+XwJVxYOsS9oI3chWrn/xjb2A8J9nFyMkhIWAi8eTCRHYIW0ziwr31bF2MXBxC
        AosYJe63XmKBcDqYJNadnQ9WxSZgKNF7tI8RxBYR0JCY0vWYHaSIWeAyk8SmL11gRcIC4RIr
        Lq8As1kEVCX2vdgD1sAr4CrxePoa1i5GDqB1ChJzJtmAhDkF3CQuTAPZzAm0zFVizolVjBMY
        eRcwMqxiFE0tSC4oTkrPNdQrTswtLs1L10vOz93ECA7ZZ1I7GFc2WBxiFOBgVOLhTViqECTE
        mlhWXJl7iFGCg1lJhPfjYqAQb0piZVVqUX58UWlOavEhRmkOFiVx3gOt1oFCAumJJanZqakF
        qUUwWSYOTqkGxtIuWa41zFftXqr8XS+e+qQu5tWkNtOI/V49mcqO9/ompR8pOBOjcK9Cxotb
        8X5BxO+QjHvzAj8/09Uo3vkpss6RJdTZ/JgPu8TTsIcC6z7YpL7QVbcsZAg7N4VReLKy9N4Z
        1feWhX81O8qibCMpsibQKev/1+6K8OW9iywe8HMsvdh/9sE8JZbijERDLeai4kQA1sdU6VUC        AAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37714
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

Add helper functions for the of_clk_providers list locking and
an unlocked variant of of_clk_get_from_provider().
These functions are intended to be used in the clkdev to avoid
race condition in the device tree based clock look up in clk_get().

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Changes since v3:
 - none.

Changes since v2:
 - fixed typo in clk.h.

Changes since v1:
 - moved the function declaractions to a local header.
---
 drivers/clk/clk.c |   38 ++++++++++++++++++++++++++++++--------
 drivers/clk/clk.h |   16 ++++++++++++++++
 2 files changed, 46 insertions(+), 8 deletions(-)
 create mode 100644 drivers/clk/clk.h

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2db08c0..8f18564 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 
+#include "clk.h"
+
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
 
@@ -2103,7 +2105,18 @@ static const struct of_device_id __clk_of_table_sentinel
 	__used __section(__clk_of_table_end);
 
 static LIST_HEAD(of_clk_providers);
-static DEFINE_MUTEX(of_clk_lock);
+static DEFINE_MUTEX(of_clk_mutex);
+
+/* of_clk_provider list locking helpers */
+void of_clk_lock(void)
+{
+	mutex_lock(&of_clk_mutex);
+}
+
+void of_clk_unlock(void)
+{
+	mutex_unlock(&of_clk_mutex);
+}
 
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
 				     void *data)
@@ -2147,9 +2160,9 @@ int of_clk_add_provider(struct device_node *np,
 	cp->data = data;
 	cp->get = clk_src_get;
 
-	mutex_lock(&of_clk_lock);
+	mutex_lock(&of_clk_mutex);
 	list_add(&cp->link, &of_clk_providers);
-	mutex_unlock(&of_clk_lock);
+	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clock from %s\n", np->full_name);
 
 	return 0;
@@ -2164,7 +2177,7 @@ void of_clk_del_provider(struct device_node *np)
 {
 	struct of_clk_provider *cp;
 
-	mutex_lock(&of_clk_lock);
+	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
 			list_del(&cp->link);
@@ -2173,24 +2186,33 @@ void of_clk_del_provider(struct device_node *np)
 			break;
 		}
 	}
-	mutex_unlock(&of_clk_lock);
+	mutex_unlock(&of_clk_mutex);
 }
 EXPORT_SYMBOL_GPL(of_clk_del_provider);
 
-struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
 	struct of_clk_provider *provider;
 	struct clk *clk = ERR_PTR(-ENOENT);
 
 	/* Check if we have such a provider in our array */
-	mutex_lock(&of_clk_lock);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np)
 			clk = provider->get(clkspec, provider->data);
 		if (!IS_ERR(clk))
 			break;
 	}
-	mutex_unlock(&of_clk_lock);
+
+	return clk;
+}
+
+struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
+{
+	struct clk *clk;
+
+	mutex_lock(&of_clk_mutex);
+	clk = __of_clk_get_from_provider(clkspec);
+	mutex_unlock(&of_clk_mutex);
 
 	return clk;
 }
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
new file mode 100644
index 0000000..795cc9f
--- /dev/null
+++ b/drivers/clk/clk.h
@@ -0,0 +1,16 @@
+/*
+ * linux/drivers/clk/clk.h
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec);
+void of_clk_lock(void);
+void of_clk_unlock(void);
+#endif
-- 
1.7.9.5
