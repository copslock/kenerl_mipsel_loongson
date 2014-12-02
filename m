Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2014 08:56:51 +0100 (CET)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51761 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006715AbaLBH4sZb8T9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Dec 2014 08:56:48 +0100
Received: by mail-wi0-f172.google.com with SMTP id n3so27091649wiv.17
        for <multiple recipients>; Mon, 01 Dec 2014 23:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwiaPwrRAxdbi6yA67W0WAJ6EzYBxMvloIvXZrTS8YQ=;
        b=ykmZiHOnAzaSYGioDNHNZURuX61hzqnzscr+UrHvXBNqb1Bb/REXPHNrOa60asKrOd
         KWlNOudX6cEkr0haBGIKQ+vOGjyeDPeLSS4OKiMb5RLtrKeSDn/RQVpDEW5gtOqRjlwQ
         hE0BGpxhQcA+RdGOiCJIqmp8JKZlwyhPsV72jWE5oDB/7MmjUlsWSZKj02U3qKmkcA66
         bbnsGiE5tlAcmcLi4P5WUvrOHfzvl8PdO6trG5R5g1Pc7791NLzMEiTVoCfopHj1a+Oq
         i1xYReoE+p2V32ve71j+g9tm2gvPItHnyh927V5J9dSKAmbbKfgvZroQHae67ZDKnum8
         J7kA==
X-Received: by 10.180.104.197 with SMTP id gg5mr53236959wib.7.1417507001545;
        Mon, 01 Dec 2014 23:56:41 -0800 (PST)
Received: from cizrna.lan (37-48-45-211.tmcz.cz. [37.48.45.211])
        by mx.google.com with ESMTPSA id vy7sm30775533wjc.27.2014.12.01.23.56.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Dec 2014 23:56:40 -0800 (PST)
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Mike Turquette <mturquette@linaro.org>,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v7 5/7] clk: Change clk_ops->determine_rate to return a clk_hw as the best parent
Date:   Tue,  2 Dec 2014 08:54:22 +0100
Message-Id: <1417506933-8915-6-git-send-email-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1417506933-8915-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1417506933-8915-1-git-send-email-tomeu.vizoso@collabora.com>
Return-Path: <tomeu.vizoso@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44542
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

This is in preparation for clock providers to not have to deal with struct clk.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

---
v7:	* Update a few more instances in new code

v4:	* Make sure that best_parent_p is populated with the current parent
	  before calling clk_ops.determine_rate()

v3:	* Rebase on top of linux-next 20141009
	* Update Documentation/clk.txt
---
 Documentation/clk.txt               |  2 +-
 arch/arm/mach-omap2/dpll3xxx.c      |  6 +++---
 arch/arm/mach-omap2/dpll44xx.c      |  6 +++---
 arch/mips/alchemy/common/clock.c    | 10 +++++-----
 drivers/clk/at91/clk-programmable.c |  4 ++--
 drivers/clk/bcm/clk-kona.c          |  4 ++--
 drivers/clk/clk-composite.c         |  9 +++++----
 drivers/clk/clk.c                   | 17 +++++++++++------
 drivers/clk/hisilicon/clk-hi3620.c  |  2 +-
 drivers/clk/mmp/clk-mix.c           |  4 ++--
 drivers/clk/qcom/clk-pll.c          |  2 +-
 drivers/clk/qcom/clk-rcg.c          | 20 ++++++++++++--------
 drivers/clk/qcom/clk-rcg2.c         | 28 +++++++++++++++++-----------
 drivers/clk/sunxi/clk-factors.c     |  4 ++--
 drivers/clk/sunxi/clk-sun6i-ar100.c |  4 ++--
 include/linux/clk-provider.h        |  4 ++--
 include/linux/clk/ti.h              |  4 ++--
 17 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/Documentation/clk.txt b/Documentation/clk.txt
index 1fee72f..4ff8462 100644
--- a/Documentation/clk.txt
+++ b/Documentation/clk.txt
@@ -74,7 +74,7 @@ the operations defined in clk.h:
 		long		(*determine_rate)(struct clk_hw *hw,
 						unsigned long rate,
 						unsigned long *best_parent_rate,
-						struct clk **best_parent_clk);
+						struct clk_hw **best_parent_clk);
 		int		(*set_parent)(struct clk_hw *hw, u8 index);
 		u8		(*get_parent)(struct clk_hw *hw);
 		int		(*set_rate)(struct clk_hw *hw,
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 20e120d..c2da2a0 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -474,7 +474,7 @@ void omap3_noncore_dpll_disable(struct clk_hw *hw)
  */
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_clk)
+				       struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
@@ -488,10 +488,10 @@ long omap3_noncore_dpll_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = dd->clk_bypass;
+		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
 		rate = omap2_dpll_round_rate(hw, rate, best_parent_rate);
-		*best_parent_clk = dd->clk_ref;
+		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
 	*best_parent_rate = rate;
diff --git a/arch/arm/mach-omap2/dpll44xx.c b/arch/arm/mach-omap2/dpll44xx.c
index 535822f..0e58e5a 100644
--- a/arch/arm/mach-omap2/dpll44xx.c
+++ b/arch/arm/mach-omap2/dpll44xx.c
@@ -223,7 +223,7 @@ out:
  */
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	struct dpll_data *dd;
@@ -237,11 +237,11 @@ long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
-		*best_parent_clk = dd->clk_bypass;
+		*best_parent_clk = __clk_get_hw(dd->clk_bypass);
 	} else {
 		rate = omap4_dpll_regm4xen_round_rate(hw, rate,
 						      best_parent_rate);
-		*best_parent_clk = dd->clk_ref;
+		*best_parent_clk = __clk_get_hw(dd->clk_ref);
 	}
 
 	*best_parent_rate = rate;
diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 203e440..48a9dfc 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -374,7 +374,7 @@ static long alchemy_calc_div(unsigned long rate, unsigned long prate,
 
 static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk,
+					struct clk_hw **best_parent_clk,
 					int scale, int maxdiv)
 {
 	struct clk *pc, *bpc, *free;
@@ -453,7 +453,7 @@ static long alchemy_clk_fgcs_detr(struct clk_hw *hw, unsigned long rate,
 	}
 
 	*best_parent_rate = bpr;
-	*best_parent_clk = bpc;
+	*best_parent_clk = __clk_get_hw(bpc);
 	return br;
 }
 
@@ -547,7 +547,7 @@ static unsigned long alchemy_clk_fgv1_recalc(struct clk_hw *hw,
 
 static long alchemy_clk_fgv1_detr(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	return alchemy_clk_fgcs_detr(hw, rate, best_parent_rate,
 				     best_parent_clk, 2, 512);
@@ -679,7 +679,7 @@ static unsigned long alchemy_clk_fgv2_recalc(struct clk_hw *hw,
 
 static long alchemy_clk_fgv2_detr(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale, maxdiv;
@@ -898,7 +898,7 @@ static int alchemy_clk_csrc_setr(struct clk_hw *hw, unsigned long rate,
 
 static long alchemy_clk_csrc_detr(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	struct alchemy_fgcs_clk *c = to_fgcs_clk(hw);
 	int scale = c->dt[2] == 3 ? 1 : 2; /* au1300 check */
diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 62e2509..bbdb1b9 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -57,7 +57,7 @@ static unsigned long clk_programmable_recalc_rate(struct clk_hw *hw,
 static long clk_programmable_determine_rate(struct clk_hw *hw,
 					    unsigned long rate,
 					    unsigned long *best_parent_rate,
-					    struct clk **best_parent_clk)
+					    struct clk_hw **best_parent_hw)
 {
 	struct clk *parent = NULL;
 	long best_rate = -EINVAL;
@@ -84,7 +84,7 @@ static long clk_programmable_determine_rate(struct clk_hw *hw,
 		if (best_rate < 0 || (rate - tmp_rate) < (rate - best_rate)) {
 			best_rate = tmp_rate;
 			*best_parent_rate = parent_rate;
-			*best_parent_clk = parent;
+			*best_parent_hw = __clk_get_hw(parent);
 		}
 
 		if (!best_rate)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index 95af2e6..1c06f6f 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -1032,7 +1032,7 @@ static long kona_peri_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *best_parent_rate, struct clk **best_parent)
+		unsigned long *best_parent_rate, struct clk_hw **best_parent)
 {
 	struct kona_clk *bcm_clk = to_kona_clk(hw);
 	struct clk *clk = hw->clk;
@@ -1075,7 +1075,7 @@ static long kona_peri_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 		if (delta < best_delta) {
 			best_delta = delta;
 			best_rate = other_rate;
-			*best_parent = parent;
+			*best_parent = __clk_get_hw(parent);
 			*best_parent_rate = parent_rate;
 		}
 	}
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index b9355da..4386697 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -57,7 +57,7 @@ static unsigned long clk_composite_recalc_rate(struct clk_hw *hw,
 
 static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_p)
+					struct clk_hw **best_parent_p)
 {
 	struct clk_composite *composite = to_clk_composite(hw);
 	const struct clk_ops *rate_ops = composite->rate_ops;
@@ -80,8 +80,9 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 		*best_parent_p = NULL;
 
 		if (__clk_get_flags(hw->clk) & CLK_SET_RATE_NO_REPARENT) {
-			*best_parent_p = clk_get_parent(mux_hw->clk);
-			*best_parent_rate = __clk_get_rate(*best_parent_p);
+			parent = clk_get_parent(mux_hw->clk);
+			*best_parent_p = __clk_get_hw(parent);
+			*best_parent_rate = __clk_get_rate(parent);
 
 			return rate_ops->round_rate(rate_hw, rate,
 						    best_parent_rate);
@@ -103,7 +104,7 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 			if (!rate_diff || !*best_parent_p
 				       || best_rate_diff > rate_diff) {
-				*best_parent_p = parent;
+				*best_parent_p = __clk_get_hw(parent);
 				*best_parent_rate = parent_rate;
 				best_rate_diff = rate_diff;
 				best_rate = tmp_rate;
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f549e8b..44cdc47 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -702,7 +702,7 @@ struct clk *__clk_lookup(const char *name)
  */
 long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *best_parent_rate,
-			      struct clk **best_parent_p)
+			      struct clk_hw **best_parent_p)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -738,7 +738,7 @@ long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 out:
 	if (best_parent)
-		*best_parent_p = best_parent;
+		*best_parent_p = best_parent->hw;
 	*best_parent_rate = best;
 
 	return best;
@@ -946,6 +946,7 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	unsigned long parent_rate = 0;
 	struct clk *parent;
+	struct clk_hw *parent_hw;
 
 	if (!clk)
 		return 0;
@@ -954,10 +955,11 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 	if (parent)
 		parent_rate = parent->rate;
 
-	if (clk->ops->determine_rate)
+	if (clk->ops->determine_rate) {
+		parent_hw = parent ? parent->hw : NULL;
 		return clk->ops->determine_rate(clk->hw, rate, &parent_rate,
-						&parent);
-	else if (clk->ops->round_rate)
+						&parent_hw);
+	} else if (clk->ops->round_rate)
 		return clk->ops->round_rate(clk->hw, rate, &parent_rate);
 	else if (clk->flags & CLK_SET_RATE_PARENT)
 		return __clk_round_rate(clk->parent, rate);
@@ -1345,6 +1347,7 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 {
 	struct clk *top = clk;
 	struct clk *old_parent, *parent;
+	struct clk_hw *parent_hw;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 	int p_index = 0;
@@ -1360,9 +1363,11 @@ static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 
 	/* find the closest rate and parent clk/rate */
 	if (clk->ops->determine_rate) {
+		parent_hw = parent ? parent->hw : NULL;
 		new_rate = clk->ops->determine_rate(clk->hw, rate,
 						    &best_parent_rate,
-						    &parent);
+						    &parent_hw);
+		parent = parent_hw->clk;
 	} else if (clk->ops->round_rate) {
 		new_rate = clk->ops->round_rate(clk->hw, rate,
 						&best_parent_rate);
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 640ea33..007144f 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -296,7 +296,7 @@ static unsigned long mmc_clk_recalc_rate(struct clk_hw *hw,
 
 static long mmc_clk_determine_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *best_parent_rate,
-			      struct clk **best_parent_p)
+			      struct clk_hw **best_parent_p)
 {
 	struct clk_mmc *mclk = to_mmc(hw);
 	unsigned long best = 0;
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index b79742c..48fa53c 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -203,7 +203,7 @@ error:
 
 static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk)
+					struct clk_hw **best_parent_clk)
 {
 	struct mmp_clk_mix *mix = to_clk_mix(hw);
 	struct mmp_clk_mix_clk_table *item;
@@ -264,7 +264,7 @@ static long mmp_clk_mix_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 found:
 	*best_parent_rate = parent_rate_best;
-	*best_parent_clk = parent_best;
+	*best_parent_clk = __clk_get_hw(parent_best);
 
 	return mix_rate_best;
 }
diff --git a/drivers/clk/qcom/clk-pll.c b/drivers/clk/qcom/clk-pll.c
index b823bc3..60873a7 100644
--- a/drivers/clk/qcom/clk-pll.c
+++ b/drivers/clk/qcom/clk-pll.c
@@ -141,7 +141,7 @@ struct pll_freq_tbl *find_freq(const struct pll_freq_tbl *f, unsigned long rate)
 
 static long
 clk_pll_determine_rate(struct clk_hw *hw, unsigned long rate,
-		       unsigned long *p_rate, struct clk **p)
+		       unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_pll *pll = to_clk_pll(hw);
 	const struct pll_freq_tbl *f;
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index b6e6959..0b93972 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -368,16 +368,17 @@ clk_dyn_rcg_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 
 static long _freq_tbl_determine_rate(struct clk_hw *hw,
 		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	unsigned long clk_flags;
+	struct clk *p;
 
 	f = qcom_find_freq(f, rate);
 	if (!f)
 		return -EINVAL;
 
 	clk_flags = __clk_get_flags(hw->clk);
-	*p = clk_get_parent_by_index(hw->clk, f->src);
+	p = clk_get_parent_by_index(hw->clk, f->src);
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		rate = rate * f->pre_div;
 		if (f->n) {
@@ -387,15 +388,16 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 			rate = tmp;
 		}
 	} else {
-		rate =  __clk_get_rate(*p);
+		rate =  __clk_get_rate(p);
 	}
+	*p_hw = __clk_get_hw(p);
 	*p_rate = rate;
 
 	return f->freq;
 }
 
 static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 
@@ -403,7 +405,7 @@ static long clk_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
 
@@ -411,13 +413,15 @@ static long clk_dyn_rcg_determine_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static long clk_rcg_bypass_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
+	struct clk *p;
 
-	*p = clk_get_parent_by_index(hw->clk, f->src);
-	*p_rate = __clk_round_rate(*p, rate);
+	p = clk_get_parent_by_index(hw->clk, f->src);
+	*p_hw = __clk_get_hw(p);
+	*p_rate = __clk_round_rate(p, rate);
 
 	return *p_rate;
 }
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index cfa9eb4..08b8b37 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -175,16 +175,17 @@ clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 
 static long _freq_tbl_determine_rate(struct clk_hw *hw,
 		const struct freq_tbl *f, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	unsigned long clk_flags;
+	struct clk *p;
 
 	f = qcom_find_freq(f, rate);
 	if (!f)
 		return -EINVAL;
 
 	clk_flags = __clk_get_flags(hw->clk);
-	*p = clk_get_parent_by_index(hw->clk, f->src);
+	p = clk_get_parent_by_index(hw->clk, f->src);
 	if (clk_flags & CLK_SET_RATE_PARENT) {
 		if (f->pre_div) {
 			rate /= 2;
@@ -198,15 +199,16 @@ static long _freq_tbl_determine_rate(struct clk_hw *hw,
 			rate = tmp;
 		}
 	} else {
-		rate =  __clk_get_rate(*p);
+		rate =  __clk_get_rate(p);
 	}
+	*p_hw = __clk_get_hw(p);
 	*p_rate = rate;
 
 	return f->freq;
 }
 
 static long clk_rcg2_determine_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *p_rate, struct clk **p)
+		unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
@@ -359,7 +361,7 @@ static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
 }
 
 static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *p_rate, struct clk **p)
+				 unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
@@ -371,7 +373,7 @@ static long clk_edp_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
 	u32 hid_div;
 
 	/* Force the correct parent */
-	*p = clk_get_parent_by_index(hw->clk, f->src);
+	*p = __clk_get_hw(clk_get_parent_by_index(hw->clk, f->src));
 
 	if (src_rate == 810000000)
 		frac = frac_table_810m;
@@ -410,18 +412,20 @@ const struct clk_ops clk_edp_pixel_ops = {
 EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
 
 static long clk_byte_determine_rate(struct clk_hw *hw, unsigned long rate,
-			 unsigned long *p_rate, struct clk **p)
+			 unsigned long *p_rate, struct clk_hw **p_hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f = rcg->freq_tbl;
 	unsigned long parent_rate, div;
 	u32 mask = BIT(rcg->hid_width) - 1;
+	struct clk *p;
 
 	if (rate == 0)
 		return -EINVAL;
 
-	*p = clk_get_parent_by_index(hw->clk, f->src);
-	*p_rate = parent_rate = __clk_round_rate(*p, rate);
+	p = clk_get_parent_by_index(hw->clk, f->src);
+	*p_hw = __clk_get_hw(p);
+	*p_rate = parent_rate = __clk_round_rate(p, rate);
 
 	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
 	div = min_t(u32, div, mask);
@@ -472,14 +476,16 @@ static const struct frac_entry frac_table_pixel[] = {
 };
 
 static long clk_pixel_determine_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *p_rate, struct clk **p)
+				 unsigned long *p_rate, struct clk_hw **p)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	unsigned long request, src_rate;
 	int delta = 100000;
 	const struct freq_tbl *f = rcg->freq_tbl;
 	const struct frac_entry *frac = frac_table_pixel;
-	struct clk *parent = *p = clk_get_parent_by_index(hw->clk, f->src);
+	struct clk *parent = clk_get_parent_by_index(hw->clk, f->src);
+
+	*p = __clk_get_hw(parent);
 
 	for (; frac->num; frac++) {
 		request = (rate * frac->den) / frac->num;
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index 5521e86..62e08fb 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -81,7 +81,7 @@ static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
 
 static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_p)
+				       struct clk_hw **best_parent_p)
 {
 	struct clk *clk = hw->clk, *parent, *best_parent = NULL;
 	int i, num_parents;
@@ -108,7 +108,7 @@ static long clk_factors_determine_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	if (best_parent)
-		*best_parent_p = best_parent;
+		*best_parent_p = __clk_get_hw(best_parent);
 	*best_parent_rate = best;
 
 	return best_child_rate;
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c b/drivers/clk/sunxi/clk-sun6i-ar100.c
index acca532..3d282fb 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -46,7 +46,7 @@ static unsigned long ar100_recalc_rate(struct clk_hw *hw,
 
 static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *best_parent_rate,
-				 struct clk **best_parent_clk)
+				 struct clk_hw **best_parent_clk)
 {
 	int nparents = __clk_get_num_parents(hw->clk);
 	long best_rate = -EINVAL;
@@ -100,7 +100,7 @@ static long ar100_determine_rate(struct clk_hw *hw, unsigned long rate,
 
 		tmp_rate = (parent_rate >> shift) / div;
 		if (!*best_parent_clk || tmp_rate > best_rate) {
-			*best_parent_clk = parent;
+			*best_parent_clk = __clk_get_hw(parent);
 			*best_parent_rate = parent_rate;
 			best_rate = tmp_rate;
 		}
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5e06f23..d936409 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -176,7 +176,7 @@ struct clk_ops {
 					unsigned long *parent_rate);
 	long		(*determine_rate)(struct clk_hw *hw, unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk);
+					struct clk_hw **best_parent_hw);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
@@ -551,7 +551,7 @@ bool __clk_is_enabled(struct clk *clk);
 struct clk *__clk_lookup(const char *name);
 long __clk_mux_determine_rate(struct clk_hw *hw, unsigned long rate,
 			      unsigned long *best_parent_rate,
-			      struct clk **best_parent_p);
+			      struct clk_hw **best_parent_p);
 
 /*
  * FIXME clock api without lock protection
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 74e5341..55ef529 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -264,7 +264,7 @@ int omap3_noncore_dpll_set_rate_and_parent(struct clk_hw *hw,
 long omap3_noncore_dpll_determine_rate(struct clk_hw *hw,
 				       unsigned long rate,
 				       unsigned long *best_parent_rate,
-				       struct clk **best_parent_clk);
+				       struct clk_hw **best_parent_clk);
 unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
 					 unsigned long parent_rate);
 long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
@@ -273,7 +273,7 @@ long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
 long omap4_dpll_regm4xen_determine_rate(struct clk_hw *hw,
 					unsigned long rate,
 					unsigned long *best_parent_rate,
-					struct clk **best_parent_clk);
+					struct clk_hw **best_parent_clk);
 u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
 long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-- 
1.9.3
