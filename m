Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Aug 2013 17:53:03 +0200 (CEST)
Received: from mailout3.samsung.com ([203.254.224.33]:8688 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6865285Ab3HFPw7iNo4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Aug 2013 17:52:59 +0200
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MR400KZD9G2U220@mailout3.samsung.com>; Wed,
 07 Aug 2013 00:52:51 +0900 (KST)
X-AuditID: cbfee61a-b7f196d000007dfa-7b-52011bd27720
Received: from epmmp2 ( [203.254.227.17])       by epcpsbgm1.samsung.com (EPCPMTA)
 with SMTP id 63.43.32250.2DB11025; Wed, 07 Aug 2013 00:52:51 +0900 (KST)
Received: from amdc1344.digital.local ([106.116.147.32])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MR4001I69EOKL20@mmp2.samsung.com>; Wed,
 07 Aug 2013 00:52:50 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, broonie@kernel.org, vapier@gentoo.org,
        ralf@linux-mips.org, lethal@linux-sh.org,
        kyungmin.park@samsung.com, shawn.guo@linaro.org,
        sebastian.hesselbarth@gmail.com, LW@KARO-electronics.de,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH RFC 1/2] clk: add common __clk_get(),
 __clk_put() implementations
Date:   Tue, 06 Aug 2013 17:51:56 +0200
Message-id: <1375804317-10576-2-git-send-email-s.nawrocki@samsung.com>
X-Mailer: git-send-email 1.7.9.5
In-reply-to: <1375804317-10576-1-git-send-email-s.nawrocki@samsung.com>
References: <1375804317-10576-1-git-send-email-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t9jQd3L0oxBBp/mslhMffiEzeL9xnlM
        Fj1/Ki3ONr1ht+icuITdYv/bn6wWmx5fY7W4vGsOm8WEqZPYLeb8mcJscfsyr8WBJ8vZLJ5O
        uMhmcWmPisXhN+2sFu9/Olo8XbeE2WL9jNcsFgsbvrBb3Jzwg9lBxKOluYfNY+V0b4/L398w
        e+ycdZfd48PHOI/ZHTNZPeZPf8TssWlVJ5vHnWt72DyOrlzL5HH6/SFWj81L6j12f21i9Ojb
        sorR4/MmuQD+KC6blNSczLLUIn27BK6MVa9WMxdMUKz4fuElcwPjXOkuRg4OCQETidPzfbsY
        OYFMMYkL99azgdhCAtMZJf7uyYSwO5gkVi7WBrHZBAwleo/2MYLYIgIaElO6HrN3MXJxMAt0
        sEi0TPsKlhAWCJaY0rCeBcRmEVCVWLizlxXE5hVwk3i4o5ENYq+CxJxJNiBhTgF3iZXT/jNC
        7HKTuHJ/CusERt4FjAyrGEVTC5ILipPScw31ihNzi0vz0vWS83M3MYIj5ZnUDsaVDRaHGAU4
        GJV4eCvEGIOEWBPLiitzDzFKcDArifD6SACFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8x5otQ4U
        EkhPLEnNTk0tSC2CyTJxcEo1MHKyPZPW7oso971/Z91rbe//Ly8zqr180Xjw257zU6av+HJL
        nNHIdWqEWL+K4IWknq8rdy25EqZXtDPxRr2VzJZMM40jKyvKH8w+rcjBU79B1iFqle3mlTeE
        Y0ul3jyUrJs1Z74Lz9z60hvV/xJ6Q2avSvgs8T8jZvrkA4e3Hv/NzjQ/1M94C6MSS3FGoqEW
        c1FxIgDoUa9rkAIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37438
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

This patch adds common __clk_get(), __clk_put() clkdev helpers
which replace their platform specific counterparts when the
common clock API enabled.

An owner module pointer is added to struct clk so a reference
to the clock supplier module is taken when the clock has active
consumers.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/include/asm/clkdev.h      |    2 ++
 arch/blackfin/include/asm/clkdev.h |    2 ++
 arch/mips/include/asm/clkdev.h     |    2 ++
 arch/sh/include/asm/clkdev.h       |    2 ++
 drivers/clk/clk.c                  |   24 ++++++++++++++++++++++++
 include/linux/clk-private.h        |    3 +++
 include/linux/clkdev.h             |    5 +++++
 7 files changed, 40 insertions(+)

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
index 54a191c..4877bd6 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1850,6 +1850,30 @@ void devm_clk_unregister(struct device *dev, struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(devm_clk_unregister);

+/*
+ * clkdev helpers
+ */
+int __clk_get(struct clk *clk)
+{
+	if (WARN_ON((!clk)))
+		return 0;
+
+	if (!try_module_get(clk->owner))
+		return 0;
+
+	return 1;
+}
+EXPORT_SYMBOL(__clk_get);
+
+void __clk_put(struct clk *clk)
+{
+	if (!clk || IS_ERR(clk))
+		return;
+
+	module_put(clk->owner);
+}
+EXPORT_SYMBOL(__clk_put);
+
 /***        clk rate change notifiers        ***/

 /**
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index dd7adff..b7c0b58 100644
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
