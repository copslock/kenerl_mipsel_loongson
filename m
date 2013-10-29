Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 20:54:50 +0100 (CET)
Received: from mailout1.samsung.com ([203.254.224.24]:21684 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823327Ab3J2TxoR9ySY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Oct 2013 20:53:44 +0100
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MVG00JV94KVD6N0@mailout1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 30 Oct 2013 04:53:19 +0900 (KST)
X-AuditID: cbfee61b-b7fd56d000001fc6-1b-5270122fbe66
Received: from epmmp1.local.host ( [203.254.227.16])
        by epcpsbgm2.samsung.com (EPCPMTA) with SMTP id 20.54.08134.F2210725; Wed,
 30 Oct 2013 04:53:19 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MVG00CM84HJ3H10@mmp1.samsung.com>; Wed,
 30 Oct 2013 04:53:19 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, mturquette@linaro.org
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v7 5/5] clk: Implement clk_unregister()
Date:   Tue, 29 Oct 2013 20:51:08 +0100
Message-id: <1383076268-8984-6-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t9jAV19oYIgg7eP9C16/lRanG16w27R
        OXEJu8Wmx9dYLS7vmsNmMWHqJHaLOX+mMFvcvsxr8XTCRTaLw2/aWS0WNnxhd+D2aGnuYfNY
        Od3bY3bHTFaPO9f2sHkcXbmWyWPzknqP3V+bGD36tqxi9Pi8SS6AM4rLJiU1J7MstUjfLoEr
        o/8OS8Fi/Yr/szYxNjD2qnUxcnJICJhIvGt9ygxhi0lcuLeerYuRi0NIYBGjxPyZ+5ggnA4m
        iZ8LulhAqtgEDCV6j/YxgtgiAvYSPya8ZAEpYhaYxyQx58MBNpCEsIC5xLFnt5hAbBYBVYkl
        d3+A2bwCrhLbZ05n72LkAFqnIDFnkg2IySngJrF/sShIhRBQxalbl5knMPIuYGRYxSiaWpBc
        UJyUnmukV5yYW1yal66XnJ+7iREcms+kdzCuarA4xCjAwajEw2vwID9IiDWxrLgy9xCjBAez
        kgjv9ONAId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwHW60DhQTSE0tSs1NTC1KLYLJMHJxSDYwm
        +/SehD95PfWlitvex4vCmpllzVTn6wq4JfUJaT4R1q7eLMU13yQv81s/g1bTXkfNWIWY19YT
        ZG5tFPddzTD5uU6n+TnPV+z2nbc4q3UVt9dsbVO4l6q9ueu59GGfd/ZChYscshiP8idcjd0f
        wDepwT1Or/SaQAZTkoUWm8Nxj6CK240WSizFGYmGWsxFxYkAQVeeeUkCAAA=
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38406
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

clk_unregister() is currently not implemented and it is required when
a clock provider module needs to be unloaded.

Normally the clock supplier module is prevented to be unloaded by
taking reference on the module in clk_get().

For cases when the clock supplier module deinitializes despite the
consumers of its clocks holding a reference on the module, e.g. when
the driver is unbound through "unbind" sysfs attribute, there are
empty clock ops added. These ops are assigned temporarily to struct
clk and used until all consumers release the clock, to avoid invoking
callbacks from the module which just got removed.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes since v6:
 - fixed NULL clk handling and replaced pr_err() with WARN_ON_ONCE().

Changes since v4:
 - none.

Changes since v3:
 - Use WARN_ON_ONCE() rather than WARN_ON() in clk_nodrv_disable_unprepare()
   callback.

Changes since v2:
 - none.

Changes since RFC v1:
 - renamed clk_dummy_* to clk_nodrv_*.
---
 drivers/clk/clk.c           |  121 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk-private.h |    2 +
 2 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 25b249c..7a33961 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -344,6 +344,21 @@ out:
 	return ret;
 }
 
+ /**
+ * clk_debug_unregister - remove a clk node from the debugfs clk tree
+ * @clk: the clk being removed from the debugfs clk tree
+ *
+ * Dynamically removes a clk and all it's children clk nodes from the
+ * debugfs clk tree if clk->dentry points to debugfs created by
+ * clk_debug_register in __clk_init.
+ *
+ * Caller must hold prepare_lock.
+ */
+static void clk_debug_unregister(struct clk *clk)
+{
+	debugfs_remove_recursive(clk->dentry);
+}
+
 /**
  * clk_debug_reparent - reparent clk node in the debugfs clk tree
  * @clk: the clk being reparented
@@ -434,6 +449,9 @@ static inline int clk_debug_register(struct clk *clk) { return 0; }
 static inline void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
 {
 }
+static inline void clk_debug_unregister(struct clk *clk)
+{
+}
 #endif
 
 /* caller must hold prepare_lock */
@@ -1777,6 +1795,7 @@ int __clk_init(struct device *dev, struct clk *clk)
 
 	clk_debug_register(clk);
 
+	kref_init(&clk->ref);
 out:
 	clk_prepare_unlock();
 
@@ -1912,13 +1931,104 @@ fail_out:
 }
 EXPORT_SYMBOL_GPL(clk_register);
 
+/*
+ * Free memory allocated for a clock.
+ * Caller must hold prepare_lock.
+ */
+static void __clk_release(struct kref *ref)
+{
+	struct clk *clk = container_of(ref, struct clk, ref);
+	int i = clk->num_parents;
+
+	kfree(clk->parents);
+	while (--i >= 0)
+		kfree(clk->parent_names[i]);
+
+	kfree(clk->parent_names);
+	kfree(clk->name);
+	kfree(clk);
+}
+
+/*
+ * Empty clk_ops for unregistered clocks. These are used temporarily
+ * after clk_unregister() was called on a clock and until last clock
+ * consumer calls clk_put() and the struct clk object is freed.
+ */
+static int clk_nodrv_prepare_enable(struct clk_hw *hw)
+{
+	return -ENXIO;
+}
+
+static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
+{
+	WARN_ON_ONCE(1);
+}
+
+static int clk_nodrv_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	return -ENXIO;
+}
+
+static int clk_nodrv_set_parent(struct clk_hw *hw, u8 index)
+{
+	return -ENXIO;
+}
+
+static const struct clk_ops clk_nodrv_ops = {
+	.enable		= clk_nodrv_prepare_enable,
+	.disable	= clk_nodrv_disable_unprepare,
+	.prepare	= clk_nodrv_prepare_enable,
+	.unprepare	= clk_nodrv_disable_unprepare,
+	.set_rate	= clk_nodrv_set_rate,
+	.set_parent	= clk_nodrv_set_parent,
+};
+
 /**
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
- *
- * Currently unimplemented.
  */
-void clk_unregister(struct clk *clk) {}
+void clk_unregister(struct clk *clk)
+{
+	unsigned long flags;
+
+       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
+               return;
+
+	clk_prepare_lock();
+
+	if (clk->ops == &clk_nodrv_ops) {
+		pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
+		goto out;
+	}
+	/*
+	 * Assign empty clock ops for consumers that might still hold
+	 * a reference to this clock.
+	 */
+	flags = clk_enable_lock();
+	clk->ops = &clk_nodrv_ops;
+	clk_enable_unlock(flags);
+
+	if (!hlist_empty(&clk->children)) {
+		struct clk *child;
+
+		/* Reparent all children to the orphan list. */
+		hlist_for_each_entry(child, &clk->children, child_node)
+			clk_set_parent(child, NULL);
+	}
+
+	clk_debug_unregister(clk);
+
+	hlist_del_init(&clk->child_node);
+
+	if (clk->prepare_count)
+		pr_warn("%s: unregistering prepared clock: %s\n",
+					__func__, clk->name);
+
+	kref_put(&clk->ref, __clk_release);
+out:
+	clk_prepare_unlock();
+}
 EXPORT_SYMBOL_GPL(clk_unregister);
 
 static void devm_clk_release(struct device *dev, void *res)
@@ -1986,6 +2096,7 @@ int __clk_get(struct clk *clk)
 	if (clk && !try_module_get(clk->owner))
 		return 0;
 
+	kref_get(&clk->ref);
 	return 1;
 }
 
@@ -1994,6 +2105,10 @@ void __clk_put(struct clk *clk)
 	if (WARN_ON_ONCE(IS_ERR(clk)))
 		return;
 
+	clk_prepare_lock();
+	kref_put(&clk->ref, __clk_release);
+	clk_prepare_unlock();
+
 	if (clk)
 		module_put(clk->owner);
 }
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 8cb1865..72c65e0 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -12,6 +12,7 @@
 #define __LINUX_CLK_PRIVATE_H
 
 #include <linux/clk-provider.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 
 /*
@@ -50,6 +51,7 @@ struct clk {
 #ifdef CONFIG_COMMON_CLK_DEBUG
 	struct dentry		*dentry;
 #endif
+	struct kref		ref;
 };
 
 /*
-- 
1.7.9.5
