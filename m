Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Aug 2013 20:28:34 +0200 (CEST)
Received: from mail-ea0-f181.google.com ([209.85.215.181]:51443 "EHLO
        mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817237Ab3HXS2a10pge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Aug 2013 20:28:30 +0200
Received: by mail-ea0-f181.google.com with SMTP id d10so865698eaj.12
        for <linux-mips@linux-mips.org>; Sat, 24 Aug 2013 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J5S7P41X70UuN1Rfy0Zef7vnTwHZ9o5DIJHfHr2+p40=;
        b=jtQ+rDSwdMvb3asL2c9gcLtYZACZ5293ujEMECLAd8nnEY4znwPlcWYs3tLpqou71Y
         rLqZ+6hcyV4bse3Nvis7hPHxv+1GGk+sKWd3KX4Hf5Z6pkg+TBHUszjjISsae2UXpgFX
         gUvlP2y0ORtxbPHaZZMj5QbKjwAR6ci4I26DjE6HKj+ckSd8ikA0gigsk/RSvz+qk1Kv
         OCRSRTQcVmAMYglVFpZykhNOQ770iYbcJHJaHlo9BxYkI1oMnFs6RUunbq46LHJiIPdN
         UvZ3SgD6DEdGsyETFP8Nf9YxBaMZ+1ZNIb+cQw9vouUrNXeVThWgWRPqe5WWDMmAULUq
         lCpQ==
X-Received: by 10.15.48.197 with SMTP id h45mr10072570eew.0.1377368905144;
        Sat, 24 Aug 2013 11:28:25 -0700 (PDT)
Received: from localhost.localdomain (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id b45sm8446922eef.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 11:28:24 -0700 (PDT)
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, s.nawrocki@samsung.com,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH v5 1/5] clk: Provide not locked variant of of_clk_get_from_provider()
Date:   Sat, 24 Aug 2013 20:27:01 +0200
Message-Id: <1377368825-30715-2-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1377368825-30715-1-git-send-email-s.nawrocki@samsung.com>
References: <1377368825-30715-1-git-send-email-s.nawrocki@samsung.com>
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37681
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
index bc02037..f46444f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,8 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 
+#include "clk.h"
+
 static DEFINE_SPINLOCK(enable_lock);
 static DEFINE_MUTEX(prepare_lock);
 
@@ -2097,7 +2099,18 @@ static const struct of_device_id __clk_of_table_sentinel
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
@@ -2141,9 +2154,9 @@ int of_clk_add_provider(struct device_node *np,
 	cp->data = data;
 	cp->get = clk_src_get;
 
-	mutex_lock(&of_clk_lock);
+	mutex_lock(&of_clk_mutex);
 	list_add(&cp->link, &of_clk_providers);
-	mutex_unlock(&of_clk_lock);
+	mutex_unlock(&of_clk_mutex);
 	pr_debug("Added clock from %s\n", np->full_name);
 
 	return 0;
@@ -2158,7 +2171,7 @@ void of_clk_del_provider(struct device_node *np)
 {
 	struct of_clk_provider *cp;
 
-	mutex_lock(&of_clk_lock);
+	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(cp, &of_clk_providers, link) {
 		if (cp->node == np) {
 			list_del(&cp->link);
@@ -2167,24 +2180,33 @@ void of_clk_del_provider(struct device_node *np)
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
1.7.4.1
