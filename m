Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2015 12:04:45 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:63795 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010730AbbAWLElveGSc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jan 2015 12:04:41 +0100
Received: by mail-wg0-f45.google.com with SMTP id x12so6823936wgg.4;
        Fri, 23 Jan 2015 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pZzQ7lmifQ5lvZqJY76py96lqs6f0IpRnqAAf/pM5/M=;
        b=Vvy3zg4FyAgURRTau6FKX7+H4munL3Klo9Il0vXj4dce4FTvdLu/VPToLRw5mhO6+U
         9Cf6b4AjtOAgCKEooHPSFHh5GaMuncfsi9BhTnikw8o1KbiAZBMLwIWPb2iBuVshq1xf
         6N+6pXw6MnSB+1ugCZwjtfTF2m9hmtTawS0p9RhOmOraFQuIUz275sZn4i2GRwczYhQ0
         VHx06EkvscxUTqzBZXPoNp0Dq/Qk03HWq3AJRFigvhH8/TDS3yaEbH08k37k8hSvctHy
         zyQY7Phzh3qFrAYB14Rlmnv7uTRjftuqaMTGWmoXAelD50wd1F1qvM9ynqfzl0ITZy5F
         dCzQ==
X-Received: by 10.180.82.137 with SMTP id i9mr2706184wiy.38.1422011076041;
        Fri, 23 Jan 2015 03:04:36 -0800 (PST)
Received: from cizrna.lan (37-48-35-209.tmcz.cz. [37.48.35.209])
        by mx.google.com with ESMTPSA id b1sm1383019wiz.6.2015.01.23.03.04.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2015 03:04:35 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
Subject: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date:   Fri, 23 Jan 2015 12:03:31 +0100
Message-Id: <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomeu.vizoso@collabora.com
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

Adds a way for clock consumers to set maximum and minimum rates. This
can be used for thermal drivers to set minimum rates, or by misc.
drivers to set maximum rates to assure a minimum performance level.

Changes the signature of the determine_rate callback by adding the
parameters min_rate and max_rate.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

---
v13:	* Cut one line to the 80-column limit
	* Make clear in the docs that the ranges are inclusive

v12:	* Refactor locking so that __clk_put takes the lock only once

v11:	* Recalculate the rate before putting the reference to clk_core
	* Don't recalculate the rate when freeing the per-user clock
	in the initialization error paths
	* Move __clk_create_clk to be next to __clk_free_clk for more
	comfortable reading

v10:	* Refactor __clk_determine_rate to share code with
	clk_round_rate.
	* Remove clk_core_round_rate_nolock as it's unused now

v9:	* s/floor/min and s/ceiling/max
	* Add a bunch of NULL checks
	* Propagate our rate range when querying our parent for the rate
	* Take constraints into account in clk_round_rate
	* Add __clk_determine_rate() for clk providers to ask their
	parents for a rate within their range
	* Make sure that what ops->round_rate returns when changing
	rates is within the range

v7:	* Update a few more instances in new code

v6:	* Take the prepare lock before removing a per-user clk
	* Init per-user clks list before adding the first clk
	* Pass the constraints to determine_rate and let clk
	  implementations deal with constraints
	* Add clk_set_rate_range

v5:	* Initialize clk.ceiling_constraint to ULONG_MAX
	* Warn about inconsistent constraints

v4:	* Copy function docs from header
	* Move WARN out of critical section
	* Refresh rate after removing a per-user clk
	* Rename clk_core.per_user_clks to clk_core.clks
	* Store requested rate and re-apply it when constraints are updated
---
 Documentation/clk.txt               |   2 +
 arch/arm/mach-omap2/dpll3xxx.c      |   2 +
 arch/arm/mach-omap2/dpll44xx.c      |   2 +
 arch/mips/alchemy/common/clock.c    |   8 ++
 drivers/clk/at91/clk-programmable.c |   2 +
 drivers/clk/bcm/clk-kona.c          |   2 +
 drivers/clk/clk-composite.c         |   9 +-
 drivers/clk/clk.c                   | 249 +++++++++++++++++++++++++++++-------
 drivers/clk/hisilicon/clk-hi3620.c  |   2 +
 drivers/clk/mmp/clk-mix.c           |   2 +
 drivers/clk/qcom/clk-pll.c          |   1 +
 drivers/clk/qcom/clk-rcg.c          |  10 +-
 drivers/clk/qcom/clk-rcg2.c         |   6 +
 drivers/clk/sunxi/clk-factors.c     |   2 +
 drivers/clk/sunxi/clk-sun6i-ar100.c |   2 +
 include/linux/clk-private.h         |   6 +
 include/linux/clk-provider.h        |  15 ++-
 include/linux/clk.h                 |  28 ++++
 include/linux/clk/ti.h              |   4 +
 19 files changed, 298 insertions(+), 56 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index 4ff8462..0e4f90a 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -73,6 +73,8 @@ the operations defined in clk.h:
 						unsigned long *parent_rate);
 		long		(*determine_rate)(struct clk_hw *hw,
 						unsigned long rate,
+						unsigned long min_rate,
+						unsigned long max_rate,
 						unsigned long *best_parent_rate,
 						struct clk_hw **best_parent_clk);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index c2da2a0..ac3fb11 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -473,6 +473,8 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
  * in failure.
  */
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
 				       unsigned long *best_parent_rate,
 				       struct clk_hw **best_parent_clk)
 {
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 0e58e5a..acacb90 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -222,6 +222,8 @@ out:
  * in failure.
  */
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk)
 {
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 48a9dfc..4e65404 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -373,6 +373,8 @@ static long alchemy_calc_div(unsigned long rate, unsigned long prate,
 }
 
 static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk,
 					int scale, int maxdiv)
@@ -546,6 +548,8 @@ static unsigned long alchemy_clk_fgv1_recalc(struct clk_hw *hw,
 }
 
 static long alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk)
 {
@@ -678,6 +682,8 @@ static unsigned long alchemy_clk_fgv2_recalc(struct clk_hw *hw,
 }
 
 static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk)
 {
@@ -897,6 +903,8 @@ static int alchemy_clk_csrc_setr(struct clk_hw *hw, unsigned long rate,
 }
 
 static long alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk)
 {
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index bbdb1b9..86c8a07 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -56,6 +56,8 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 
 static long clk_programmable_determine_rate(struct clk_hw *hw,
 					    unsigned long rate,
+					    unsigned long min_rate,
+					    unsigned long max_rate,
 					    unsigned long *best_parent_rate,
 					    struct clk_hw **best_parent_hw)
 {
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 1c06f6f..05abae8 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1032,6 +1032,8 @@ static long kona_peri_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long min_rate,
+		unsigned long max_rate,
 		unsigned long *best_parent_rate, struct clk_hw **best_parent)
 {
 	struct kona_clk *bcm_clk = to_kona_clk(hw);
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 4386697..dee81b8 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -56,6 +56,8 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 }
 
 static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_p)
 {
@@ -73,7 +75,9 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (rate_hw && rate_ops && rate_ops->determine_rate) {
 		rate_hw->clk = hw->clk;
-		return rate_ops->determine_rate(rate_hw, rate, best_parent_rate,
+		return rate_ops->determine_rate(rate_hw, rate, min_rate,
+						max_rate,
+						best_parent_rate,
 						best_parent_p);
 	} else if (rate_hw && rate_ops && rate_ops->round_rate &&
 		   mux_hw && mux_ops && mux_ops->set_parent) {
@@ -117,7 +121,8 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 		return best_rate;
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		mux_hw->clk = hw->clk;
-		return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
+		return mux_ops->determine_rate(mux_hw, rate, min_rate,
+					       max_rate, best_parent_rate,
 					       best_parent_p);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0b7091c..ec51978 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -42,8 +42,6 @@ static unsigned long clk_core_get_rate(struct clk_core *clk);
 static int clk_core_get_phase(struct clk_core *clk);
 static bool clk_core_is_prepared(struct clk_core *clk);
 static bool clk_core_is_enabled(struct clk_core *clk);
-static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
-						unsigned long rate);
 static struct clk_core *clk_core_lookup(const char *name);
 
 /***           locking             ***/
@@ -746,12 +744,30 @@ struct clk *__clk_lookup(const char *name)
 	return !core ? NULL : core->hw->clk;
 }
 
+static void clk_core_get_boundaries(struct clk_core *clk,
+				    unsigned long *min_rate,
+				    unsigned long *max_rate)
+{
+	struct clk *clk_user;
+
+	*min_rate = 0;
+	*max_rate = ULONG_MAX;
+
+	hlist_for_each_entry(clk_user, &clk->clks, child_node)
+		*min_rate = max(*min_rate, clk_user->min_rate);
+
+	hlist_for_each_entry(clk_user, &clk->clks, child_node)
+		*max_rate = min(*max_rate, clk_user->max_rate);
+}
+
 /*
  * Helper for finding best parent to provide a given frequency. This can be used
  * directly as a determine_rate callback (e.g. for a mux), or from a more
  * complex clock that may combine a mux with other operations.
  */
 long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long min_rate,
+			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
 			      struct clk_hw **best_parent_p)
 {
@@ -763,7 +779,8 @@ long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
 		parent = core->parent;
 		if (core->flags & CLK_SET_RATE_PARENT)
-			best = clk_core_round_rate_nolock(parent, rate);
+			best = __clk_determine_rate(parent->hw, rate,
+						    min_rate, max_rate);
 		else if (parent)
 			best = clk_core_get_rate_nolock(parent);
 		else
@@ -778,7 +795,9 @@ long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (!parent)
 			continue;
 		if (core->flags & CLK_SET_RATE_PARENT)
-			parent_rate = clk_core_round_rate_nolock(parent, rate);
+			parent_rate = __clk_determine_rate(parent->hw, rate,
+							   min_rate,
+							   max_rate);
 		else
 			parent_rate = clk_core_get_rate_nolock(parent);
 		if (parent_rate <= rate && parent_rate > best) {
@@ -1006,7 +1025,9 @@ int clk_enable(struct clk *clk)
 EXPORT_SYMBOL_GPL(clk_enable);
 
 static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
-						unsigned long rate)
+						unsigned long rate,
+						unsigned long min_rate,
+						unsigned long max_rate)
 {
 	unsigned long parent_rate = 0;
 	struct clk_core *parent;
@@ -1021,17 +1042,41 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
 
 	if (clk->ops->determine_rate) {
 		parent_hw = parent ? parent->hw : NULL;
-		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
-						&parent_hw);
+		return clk->ops->determine_rate(clk->hw, rate,
+						min_rate, max_rate,
+						&parent_rate, &parent_hw);
 	} else if (clk->ops->round_rate)
 		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
 	else if (clk->flags & CLK_SET_RATE_PARENT)
-		return clk_core_round_rate_nolock(clk->parent, rate);
+		return clk_core_round_rate_nolock(clk->parent, rate, min_rate,
+						  max_rate);
 	else
 		return clk->rate;
 }
 
 /**
+ * __clk_determine_rate - get the closest rate actually supported by a clock
+ * @hw: determine the rate of this clock
+ * @rate: target rate
+ * @min_rate: returned rate must be greater than this rate
+ * @max_rate: returned rate must be less than this rate
+ *
+ * Caller must hold prepare_lock.  Useful for clk_ops such as .set_rate and
+ * .determine_rate.
+ */
+unsigned long __clk_determine_rate(struct clk_hw *hw,
+				   unsigned long rate,
+				   unsigned long min_rate,
+				   unsigned long max_rate)
+{
+	if (!hw)
+		return 0;
+
+	return clk_core_round_rate_nolock(hw->core, rate, min_rate, max_rate);
+}
+EXPORT_SYMBOL_GPL(__clk_determine_rate);
+
+/**
  * __clk_round_rate - round the given rate for a clk
  * @clk: round the rate of this clock
  * @rate: the rate which is to be rounded
@@ -1040,10 +1085,15 @@ static unsigned long clk_core_round_rate_nolock(struct clk_core *clk,
  */
 unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
+	unsigned long min_rate;
+	unsigned long max_rate;
+
 	if (!clk)
 		return 0;
 
-	return clk_core_round_rate_nolock(clk->core, rate);
+	clk_core_get_boundaries(clk->core, &min_rate, &max_rate);
+
+	return clk_core_round_rate_nolock(clk->core, rate, min_rate, max_rate);
 }
 EXPORT_SYMBOL_GPL(__clk_round_rate);
 
@@ -1064,7 +1114,7 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 		return 0;
 
 	clk_prepare_lock();
-	ret = clk_core_round_rate_nolock(clk->core, rate);
+	ret = __clk_round_rate(clk, rate);
 	clk_prepare_unlock();
 
 	return ret;
@@ -1455,6 +1505,8 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	struct clk_hw *parent_hw;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
+	unsigned long min_rate;
+	unsigned long max_rate;
 	int p_index = 0;
 
 	/* sanity */
@@ -1466,16 +1518,22 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *clk,
 	if (parent)
 		best_parent_rate = parent->rate;
 
+	clk_core_get_boundaries(clk, &min_rate, &max_rate);
+
 	/* find the closest rate and parent clk/rate */
 	if (clk->ops->determine_rate) {
 		parent_hw = parent ? parent->hw : NULL;
 		new_rate = clk->ops->determine_rate(clk->hw, rate,
+						    min_rate,
+						    max_rate,
 						    &best_parent_rate,
 						    &parent_hw);
 		parent = parent_hw ? parent_hw->core : NULL;
 	} else if (clk->ops->round_rate) {
 		new_rate = clk->ops->round_rate(clk->hw, rate,
 						&best_parent_rate);
+		if (new_rate < min_rate || new_rate > max_rate)
+			return NULL;
 	} else if (!parent || !(clk->flags & CLK_SET_RATE_PARENT)) {
 		/* pass-through clock without adjustable parent */
 		clk->new_rate = clk->rate;
@@ -1613,6 +1671,45 @@ static void clk_change_rate(struct clk_core *clk)
 		clk_change_rate(clk->new_child);
 }
 
+static int clk_core_set_rate_nolock(struct clk_core *clk,
+				    unsigned long req_rate)
+{
+	struct clk_core *top, *fail_clk;
+	unsigned long rate = req_rate;
+	int ret = 0;
+
+	if (!clk)
+		return 0;
+
+	/* bail early if nothing to do */
+	if (rate == clk_core_get_rate_nolock(clk))
+		return 0;
+
+	if ((clk->flags & CLK_SET_RATE_GATE) && clk->prepare_count)
+		return -EBUSY;
+
+	/* calculate new rates and get the topmost changed clock */
+	top = clk_calc_new_rates(clk, rate);
+	if (!top)
+		return -EINVAL;
+
+	/* notify that we are about to change rates */
+	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
+	if (fail_clk) {
+		pr_debug("%s: failed to set %s rate\n", __func__,
+				fail_clk->name);
+		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+		return -EBUSY;
+	}
+
+	/* change the rates */
+	clk_change_rate(top);
+
+	clk->req_rate = req_rate;
+
+	return ret;
+}
+
 /**
  * clk_set_rate - specify a new rate for clk
  * @clk: the clk whose rate is being changed
@@ -1636,8 +1733,7 @@ static void clk_change_rate(struct clk_core *clk)
  */
 int clk_set_rate(struct clk *clk, unsigned long rate)
 {
-	struct clk_core *top, *fail_clk;
-	int ret = 0;
+	int ret;
 
 	if (!clk)
 		return 0;
@@ -1645,42 +1741,81 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
-	/* bail early if nothing to do */
-	if (rate == clk_get_rate(clk))
-		goto out;
+	ret = clk_core_set_rate_nolock(clk->core, rate);
 
-	if ((clk->core->flags & CLK_SET_RATE_GATE) &&
-	    clk->core->prepare_count) {
-		ret = -EBUSY;
-		goto out;
-	}
+	clk_prepare_unlock();
 
-	/* calculate new rates and get the topmost changed clock */
-	top = clk_calc_new_rates(clk->core, rate);
-	if (!top) {
-		ret = -EINVAL;
-		goto out;
-	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
 
-	/* notify that we are about to change rates */
-	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
-	if (fail_clk) {
-		pr_debug("%s: failed to set %s rate\n", __func__,
-				fail_clk->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		ret = -EBUSY;
-		goto out;
+/**
+ * clk_set_rate_range - set a rate range for a clock source
+ * @clk: clock source
+ * @min: desired minimum clock rate in Hz, inclusive
+ * @max: desired maximum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
+{
+	int ret = 0;
+
+	if (!clk)
+		return 0;
+
+	if (min > max) {
+		pr_err("%s: clk %s dev %s con %s: invalid range [%lu, %lu]\n",
+		       __func__, clk->core->name, clk->dev_id, clk->con_id,
+		       min, max);
+		return -EINVAL;
 	}
 
-	/* change the rates */
-	clk_change_rate(top);
+	clk_prepare_lock();
+
+	if (min != clk->min_rate || max != clk->max_rate) {
+		clk->min_rate = min;
+		clk->max_rate = max;
+		ret = clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
+	}
 
-out:
 	clk_prepare_unlock();
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(clk_set_rate);
+EXPORT_SYMBOL_GPL(clk_set_rate_range);
+
+/**
+ * clk_set_min_rate - set a minimum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired minimum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_min_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk)
+		return 0;
+
+	return clk_set_rate_range(clk, rate, clk->max_rate);
+}
+EXPORT_SYMBOL_GPL(clk_set_min_rate);
+
+/**
+ * clk_set_max_rate - set a maximum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired maximum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_max_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk)
+		return 0;
+
+	return clk_set_rate_range(clk, clk->min_rate, rate);
+}
+EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
 /**
  * clk_get_parent - return the parent of a clk
@@ -2127,10 +2262,24 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	clk->core = hw->core;
 	clk->dev_id = dev_id;
 	clk->con_id = con_id;
+	clk->max_rate = ULONG_MAX;
+
+	clk_prepare_lock();
+	hlist_add_head(&clk->child_node, &hw->core->clks);
+	clk_prepare_unlock();
 
 	return clk;
 }
 
+static void __clk_free_clk(struct clk *clk)
+{
+	clk_prepare_lock();
+	hlist_del(&clk->child_node);
+	clk_prepare_unlock();
+
+	kfree(clk);
+}
+
 /**
  * clk_register - allocate a new clock, register it and return an opaque cookie
  * @dev: device that is registering this clock
@@ -2190,6 +2339,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 		}
 	}
 
+	INIT_HLIST_HEAD(&clk->clks);
+
 	hw->clk = __clk_create_clk(hw, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		pr_err("%s: could not allocate per-user clk\n", __func__);
@@ -2201,8 +2352,9 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	if (!ret)
 		return hw->clk;
 
-	kfree(hw->clk);
+	__clk_free_clk(hw->clk);
 	hw->clk = NULL;
+
 fail_parent_names_copy:
 	while (--i >= 0)
 		kfree(clk->parent_names[i]);
@@ -2391,25 +2543,24 @@ int __clk_get(struct clk *clk)
 	return 1;
 }
 
-static void clk_core_put(struct clk_core *core)
+void __clk_put(struct clk *clk)
 {
 	struct module *owner;
 
-	owner = core->owner;
+	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
+		return;
 
 	clk_prepare_lock();
-	kref_put(&core->ref, __clk_release);
+
+	hlist_del(&clk->child_node);
+	clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
+	owner = clk->core->owner;
+	kref_put(&clk->core->ref, __clk_release);
+
 	clk_prepare_unlock();
 
 	module_put(owner);
-}
-
-void __clk_put(struct clk *clk)
-{
-	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
-		return;
 
-	clk_core_put(clk->core);
 	kfree(clk);
 }
 
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 007144f..2e4f6d4 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -295,6 +295,8 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
 }
 
 static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long min_rate,
+			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
 			      struct clk_hw **best_parent_p)
 {
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index 48fa53c..de6a873 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -202,6 +202,8 @@ error:
 }
 
 static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk)
 {
diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
index 60873a7..b4325f6 100644
--- a/drivers/clk/qcom/clk-pll.c
+++ b/drivers/clk/qcom/clk-pll.c
@@ -141,6 +141,7 @@ struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
 
 static long
 clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
+		       unsigned long min_rate, unsigned long max_rate,
 		       unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index 0b93972..0039bd7 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -368,6 +368,7 @@ clk_dyn_rcg_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 
 static long _freq_tbl_determine_rate(struct clk_hw *hw,
 		const struct freq_tbl *f, unsigned long rate,
+		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	unsigned long clk_flags;
@@ -397,22 +398,27 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 }
 
 static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, p_rate, p);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
+			max_rate, p_rate, p);
 }
 
 static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, p_rate, p);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, rate, min_rate,
+			max_rate, p_rate, p);
 }
 
 static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 08b8b37..742acfa 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -208,6 +208,7 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 }
 
 static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long min_rate, unsigned long max_rate,
 		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -361,6 +362,8 @@ static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
 }
 
 static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
 				 unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -412,6 +415,7 @@ const struct clk_ops clk_edp_pixel_ops = {
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
 
 static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long min_rate, unsigned long max_rate,
 			 unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -476,6 +480,8 @@ static const struct frac_entry frac_table_pixel[] = {
 };
 
 static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
 				 unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 62e08fb..761029b 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -80,6 +80,8 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
 				       unsigned long *best_parent_rate,
 				       struct clk_hw **best_parent_p)
 {
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index 3d282fb..63cf149 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -45,6 +45,8 @@ static unsigned long ar100_recalc_rate(struct clk_hw *hw,
 }
 
 static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long min_rate,
+				 unsigned long max_rate,
 				 unsigned long *best_parent_rate,
 				 struct clk_hw **best_parent_clk)
 {
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index ae55d99..5136b30 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -39,6 +39,7 @@ struct clk_core {
 	u8			num_parents;
 	u8			new_parent_index;
 	unsigned long		rate;
+	unsigned long		req_rate;
 	unsigned long		new_rate;
 	struct clk_core		*new_parent;
 	struct clk_core		*new_child;
@@ -50,6 +51,7 @@ struct clk_core {
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	struct hlist_node	debug_node;
+	struct hlist_head	clks;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
@@ -61,6 +63,10 @@ struct clk {
 	struct clk_core	*core;
 	const char *dev_id;
 	const char *con_id;
+
+	unsigned long min_rate;
+	unsigned long max_rate;
+	struct hlist_node child_node;
 };
 
 /*
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 9afd438..2416026 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -175,9 +175,12 @@ struct clk_ops {
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
 					unsigned long *parent_rate);
-	long		(*determine_rate)(struct clk_hw *hw, unsigned long rate,
-					unsigned long *best_parent_rate,
-					struct clk_hw **best_parent_hw);
+	long		(*determine_rate)(struct clk_hw *hw,
+					  unsigned long rate,
+					  unsigned long min_rate,
+					  unsigned long max_rate,
+					  unsigned long *best_parent_rate,
+					  struct clk_hw **best_parent_hw);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
@@ -555,8 +558,14 @@ bool __clk_is_prepared(struct clk *clk);
 bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long min_rate,
+			      unsigned long max_rate,
 			      unsigned long *best_parent_rate,
 			      struct clk_hw **best_parent_p);
+unsigned long __clk_determine_rate(struct clk_hw *core,
+				   unsigned long rate,
+				   unsigned long min_rate,
+				   unsigned long max_rate);
 
 /*
  * FIXME clock api without lock protection
diff --git a/include/linux/clk.h b/include/linux/clk.h
index c7f258a..a891e21 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -302,6 +302,34 @@ long clk_round_rate(struct clk *clk, unsigned long rate);
 int clk_set_rate(struct clk *clk, unsigned long rate);
 
 /**
+ * clk_set_rate_range - set a rate range for a clock source
+ * @clk: clock source
+ * @min: desired minimum clock rate in Hz, inclusive
+ * @max: desired maximum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max);
+
+/**
+ * clk_set_min_rate - set a minimum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired minimum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_min_rate(struct clk *clk, unsigned long rate);
+
+/**
+ * clk_set_max_rate - set a maximum clock rate for a clock source
+ * @clk: clock source
+ * @rate: desired maximum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_max_rate(struct clk *clk, unsigned long rate);
+
+/**
  * clk_set_parent - set the parent clock source for this clock
  * @clk: clock source
  * @parent: parent clock source
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 55ef529..cfb9e55 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -263,6 +263,8 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 					   u8 index);
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 				       unsigned long rate,
+				       unsigned long min_rate,
+				       unsigned long max_rate,
 				       unsigned long *best_parent_rate,
 				       struct clk_hw **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
@@ -272,6 +274,8 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 				    unsigned long *parent_rate);
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long rate,
+					unsigned long min_rate,
+					unsigned long max_rate,
 					unsigned long *best_parent_rate,
 					struct clk_hw **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
-- 
1.9.3
