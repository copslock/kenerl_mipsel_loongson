Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 15:14:08 +0100 (CET)
Received: from relmlor1.renesas.com ([210.160.252.171]:37435 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991185AbeKSONLNqA7z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 15:13:11 +0100
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 19 Nov 2018 23:13:07 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5B929401BF07;
        Mon, 19 Nov 2018 23:13:03 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@pku.edu.cn>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: Add (devm_)clk_get_optional() functions
Date:   Mon, 19 Nov 2018 14:12:59 +0000
Message-Id: <20181119141259.11992-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Return-Path: <phil.edworthy@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil.edworthy@renesas.com
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

This adds clk_get_optional() and devm_clk_get_optional() functions to get
optional clocks.
They behave the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v7:
 - Instead of messing with the core functions, simply wrap them for the
   _optional() versions. By putting clk_get_optional() inline in the header
   file, we can get rid of the arch specific patches as well.
v6:
 - Add doxygen style comment for devm_clk_get_optional() args
v5:
 - No changes.
v4:
 - No changes.
v3:
 - No changes.
---
 drivers/clk/clk-devres.c | 11 +++++++++++
 include/linux/clk.h      | 27 +++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 12c87457eca1..f0033d937c39 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -34,6 +34,17 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = devm_clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		return NULL;
+	else
+		return clk;
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a7773b5c0b9f..c7bbb0678057 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -383,6 +383,17 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  */
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -718,6 +729,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_optional(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {
@@ -862,6 +879,16 @@ static inline void clk_bulk_disable_unprepare(int num_clks,
 	clk_bulk_unprepare(num_clks, clks);
 }
 
+static inline struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		return NULL;
+	else
+		return clk;
+}
+
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-- 
2.17.1
