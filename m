From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 9 Jul 2015 12:20:21 +0200
Subject: [PATCH] clk: fix some determine_rate implementations
Message-ID: <20150709102021.E_nfeehPddAf8EnE_gtEXHNv603zB8CfJZSPMjExGFc@z>

Some determine_rate implementations are not returning an error when then
failed to adapt the rate according to the rate request.
Fix them so that they return an error instead of silently returning 0.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/mips/alchemy/common/clock.c    |  4 ++++
 drivers/clk/clk-composite.c         |  3 +--
 drivers/clk/clk.c                   | 15 ++++++---------
 drivers/clk/hisilicon/clk-hi3620.c  |  2 +-
 drivers/clk/mmp/clk-mix.c           |  5 ++++-
 drivers/clk/sunxi/clk-factors.c     |  6 ++++--
 drivers/clk/sunxi/clk-sun6i-ar100.c |  3 +++
 drivers/clk/sunxi/clk-sunxi.c       |  6 ++++--
 8 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c
b/arch/mips/alchemy/common/clock.c index 0b4cf3e..7cc3eed 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -469,9 +469,13 @@ static int alchemy_clk_fgcs_detr(struct clk_hw *hw,
 		}
 	}
 
+	if (br < 0)
+		return br;
+
 	req->best_parent_rate = bpr;
 	req->best_parent_hw = __clk_get_hw(bpc);
 	req->rate = br;
+
 	return 0;
 }
 
diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 9e69f34..35ac062 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -125,8 +125,7 @@ static int clk_composite_determine_rate(struct
clk_hw *hw, return mux_ops->determine_rate(mux_hw, req);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function
called, but no mux or rate callback set!\n");
-		req->rate = 0;
-		return 0;
+		return -EINVAL;
 	}
 }
 
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c182d8a..d67d9b4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -447,24 +447,18 @@ clk_mux_determine_rate_flags(struct clk_hw *hw,
struct clk_rate_request *req, 
 	/* if NO_REPARENT flag set, pass through to current parent */
 	if (core->flags & CLK_SET_RATE_NO_REPARENT) {
-		parent = core->parent;
+		best_parent = core->parent;
 		if (core->flags & CLK_SET_RATE_PARENT) {
-			ret = __clk_determine_rate(parent ?
parent->hw : NULL,
+			ret = __clk_determine_rate(best_parent ?
best_parent->hw : NULL, &parent_req);
 			if (ret)
 				return ret;
 
 			best = parent_req.rate;
-			req->best_parent_hw = parent->hw;
-			req->best_parent_rate = best;
-		} else if (parent) {
+		} else if (best_parent) {
 			best = clk_core_get_rate_nolock(parent);
-			req->best_parent_hw = parent->hw;
-			req->best_parent_rate = best;
 		} else {
 			best = clk_core_get_rate_nolock(core);
-			req->best_parent_hw = NULL;
-			req->best_parent_rate = 0;
 		}
 
 		goto out;
@@ -493,6 +487,9 @@ clk_mux_determine_rate_flags(struct clk_hw *hw,
struct clk_rate_request *req, }
 	}
 
+	if (!best_parent)
+		return -EINVAL;
+
 out:
 	if (best_parent)
 		req->best_parent_hw = best_parent->hw;
diff --git a/drivers/clk/hisilicon/clk-hi3620.c
b/drivers/clk/hisilicon/clk-hi3620.c index a0674ba..c84ec86 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -316,7 +316,7 @@ static int mmc_clk_determine_rate(struct clk_hw *hw,
 		req->rate = 180000000;
 		req->best_parent_rate = 1440000000;
 	}
-	return 0;
+	return -EINVAL;
 }
 
 static u32 mmc_clk_delay(u32 val, u32 para, u32 off, u32 len)
diff --git a/drivers/clk/mmp/clk-mix.c b/drivers/clk/mmp/clk-mix.c
index 7a37432..665cb67 100644
--- a/drivers/clk/mmp/clk-mix.c
+++ b/drivers/clk/mmp/clk-mix.c
@@ -218,7 +218,7 @@ static int mmp_clk_mix_determine_rate(struct clk_hw
*hw, parent = NULL;
 	mix_rate_best = 0;
 	parent_rate_best = 0;
-	gap_best = req->rate;
+	gap_best = ULONG_MAX;
 	parent_best = NULL;
 
 	if (mix->table) {
@@ -262,6 +262,9 @@ static int mmp_clk_mix_determine_rate(struct clk_hw
*hw, }
 
 found:
+	if (!parent_best)
+		return -EINVAL;
+
 	req->best_parent_rate = parent_rate_best;
 	req->best_parent_hw = __clk_get_hw(parent_best);
 	req->rate = mix_rate_best;
diff --git a/drivers/clk/sunxi/clk-factors.c
b/drivers/clk/sunxi/clk-factors.c index 7a48587..94e2570 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -107,8 +107,10 @@ static int clk_factors_determine_rate(struct
clk_hw *hw, }
 	}
 
-	if (best_parent)
-		req->best_parent_hw = __clk_get_hw(best_parent);
+	if (!best_parent)
+		return -EINVAL;
+
+	req->best_parent_hw = __clk_get_hw(best_parent);
 	req->best_parent_rate = best;
 	req->rate = best_child_rate;
 
diff --git a/drivers/clk/sunxi/clk-sun6i-ar100.c
b/drivers/clk/sunxi/clk-sun6i-ar100.c index d70c1ea..21b076e 100644
--- a/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ b/drivers/clk/sunxi/clk-sun6i-ar100.c
@@ -105,6 +105,9 @@ static int ar100_determine_rate(struct clk_hw *hw,
 		}
 	}
 
+	if (best_rate < 0)
+		return best_rate;
+
 	req->rate = best_rate;
 
 	return 0;
diff --git a/drivers/clk/sunxi/clk-sunxi.c
b/drivers/clk/sunxi/clk-sunxi.c index d0f72a1..0e15165 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -146,8 +146,10 @@ static int sun6i_ahb1_clk_determine_rate(struct
clk_hw *hw, }
 	}
 
-	if (best_parent)
-		req->best_parent_hw = __clk_get_hw(best_parent);
+	if (!best_parent)
+		return -EINVAL;
+
+	req->best_parent_hw = __clk_get_hw(best_parent);
 	req->best_parent_rate = best;
 	req->rate = best_child_rate;
 
-- 
1.9.1
