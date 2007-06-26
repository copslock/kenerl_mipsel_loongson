Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 15:34:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:40650 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022134AbXFZOeI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2007 15:34:08 +0100
Received: from localhost (p6214-ipad208funabasi.chiba.ocn.ne.jp [60.43.107.214])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9F351A567; Tue, 26 Jun 2007 23:32:48 +0900 (JST)
Date:	Tue, 26 Jun 2007 23:33:32 +0900 (JST)
Message-Id: <20070626.233332.74753130.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] generic clk API implementation for MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com>
References: <20070626.011449.132112302.anemo@mba.ocn.ne.jp>
	<cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Jun 2007 11:37:31 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> Did you consider Atmel implementation which is even more stripped ?

Well, it seems simpler, but I suppose clk_register() is very useful ;)

> The main difference seems that your version has module support. I'm
> not sure how usefull it is though.

Indeed.  Revised.


Subject: [PATCH] generic clk API implementation for MIPS

The clock framework (clk_get(), etc.) would be useful to provide some
clock values to platform devices or so.

This MIPS implementation is derived (and stripped) from the SH
implementation.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lib/Makefile   |    2 +-
 arch/mips/lib/clock.c    |  185 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-mips/clock.h |   38 ++++++++++
 3 files changed, 224 insertions(+), 1 deletions(-)

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index a960c05..ecea595 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -3,7 +3,7 @@
 #
 
 lib-y	+= csum_partial.o memcpy.o memcpy-inatomic.o memset.o strlen_user.o \
-	   strncpy_user.o strnlen_user.o uncached.o
+	   strncpy_user.o strnlen_user.o uncached.o clock.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
diff --git a/arch/mips/lib/clock.c b/arch/mips/lib/clock.c
new file mode 100644
index 0000000..2bfd0b4
--- /dev/null
+++ b/arch/mips/lib/clock.c
@@ -0,0 +1,185 @@
+/*
+ * arch/mips/lib/clock.c - MIPS clock framework
+ *
+ * This clock framework is derived from the SH version by:
+ *
+ *  Copyright (C) 2005, 2006  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <asm/clock.h>
+
+static LIST_HEAD(clock_list);
+static DEFINE_SPINLOCK(clock_lock);
+static DEFINE_MUTEX(clock_list_lock);
+
+static int __clk_enable(struct clk *clk)
+{
+	/*
+	 * See if this is the first time we're enabling the clock, some
+	 * clocks that are always enabled still require "special"
+	 * initialization. This is especially true if the clock mode
+	 * changes and the clock needs to hunt for the proper set of
+	 * divisors to use before it can effectively recalc.
+	 */
+	if (unlikely(atomic_read(&clk->kref.refcount) == 1))
+		if (clk->ops && clk->ops->init)
+			clk->ops->init(clk);
+
+	if (clk->flags & CLK_ALWAYS_ENABLED)
+		return 0;
+
+	if (likely(clk->ops && clk->ops->enable))
+		clk->ops->enable(clk);
+
+	kref_get(&clk->kref);
+	return 0;
+}
+
+int clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&clock_lock, flags);
+	ret = __clk_enable(clk);
+	spin_unlock_irqrestore(&clock_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+static void clk_kref_release(struct kref *kref)
+{
+	/* Nothing to do */
+}
+
+static void __clk_disable(struct clk *clk)
+{
+	if (clk->flags & CLK_ALWAYS_ENABLED)
+		return;
+
+	kref_put(&clk->kref, clk_kref_release);
+}
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clock_lock, flags);
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+int clk_register(struct clk *clk)
+{
+	mutex_lock(&clock_list_lock);
+
+	list_add(&clk->node, &clock_list);
+	kref_init(&clk->kref);
+
+	mutex_unlock(&clock_list_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_register);
+
+void clk_unregister(struct clk *clk)
+{
+	mutex_lock(&clock_list_lock);
+	list_del(&clk->node);
+	mutex_unlock(&clock_list_lock);
+}
+EXPORT_SYMBOL_GPL(clk_unregister);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (likely(clk->ops && clk->ops->set_rate)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_rate(clk, rate);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+/*
+ * Returns a clock. Note that we first try to use device id on the bus
+ * and clock name. If this fails, we try to use clock name only.
+ */
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	struct clk *p, *clk = ERR_PTR(-ENOENT);
+	int idno;
+
+	if (dev == NULL || dev->bus != &platform_bus_type)
+		idno = -1;
+	else
+		idno = to_platform_device(dev)->id;
+
+	mutex_lock(&clock_list_lock);
+	list_for_each_entry(p, &clock_list, node) {
+		if (p->id == idno && strcmp(id, p->name) == 0) {
+			clk = p;
+			goto found;
+		}
+	}
+
+	list_for_each_entry(p, &clock_list, node) {
+		if (strcmp(id, p->name) == 0) {
+			clk = p;
+			break;
+		}
+	}
+
+found:
+	mutex_unlock(&clock_list_lock);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(clk_get);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL_GPL(clk_put);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return rate;
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	clk->parent = parent;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	return clk->parent ?: ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
diff --git a/include/asm-mips/clock.h b/include/asm-mips/clock.h
new file mode 100644
index 0000000..1c1429b
--- /dev/null
+++ b/include/asm-mips/clock.h
@@ -0,0 +1,38 @@
+#ifndef __ASM_MIPS_CLOCK_H
+#define __ASM_MIPS_CLOCK_H
+
+/* generic clk API implementation --- derived from include/asm-sh/clock.h */
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/clk.h>
+
+struct clk;
+
+struct clk_ops {
+	void (*init)(struct clk *clk);
+	void (*enable)(struct clk *clk);
+	void (*disable)(struct clk *clk);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+};
+
+struct clk {
+	struct list_head	node;
+	const char		*name;
+	int			id;
+
+	struct clk		*parent;
+	struct clk_ops		*ops;
+
+	struct kref		kref;
+
+	unsigned long		rate;
+	unsigned long		flags;
+};
+
+#define CLK_ALWAYS_ENABLED	(1 << 0)
+
+int clk_register(struct clk *);
+void clk_unregister(struct clk *);
+
+#endif /* __ASM_MIPS_CLOCK_H */
