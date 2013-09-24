Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Sep 2013 23:39:01 +0200 (CEST)
Received: from mail-ee0-f41.google.com ([74.125.83.41]:45166 "EHLO
        mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824811Ab3IXVi6mig-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Sep 2013 23:38:58 +0200
Received: by mail-ee0-f41.google.com with SMTP id d17so2796226eek.28
        for <linux-mips@linux-mips.org>; Tue, 24 Sep 2013 14:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eOrABs7rL8FZX5ZXX0+zkYtv5+70zAWyrIJ/9rHZg2M=;
        b=WgAqyAr5NweOJgVJX6ijIAAHjcneeGhLWb5v+z4a56lkxgfmPya3gzFs4fQOckfwZO
         +d3U2as4uenp2B0+QvIW0jVVFpbxHi4Ma1IXpcZklvz1pTb/unnMWkPZdsfMYV6ipyev
         KwV7fxfx90slFHiXK3222sP+tpT+BjXxxxMUGcYJLSnrTCnY/5CyJRfYa9tG69/V/PrB
         DhYRcful3xpR2gVaJ+BkzCdCEGhwiqHP3ZNjGkE06U1Rj+uuSlFkfS2FQPPo/8nmHGp1
         eHLoeNBY/G75G9tBwzmpT193AaaC4ntuGF+Z0ezY/Ptz2TwwmLp+5Dxb95R2m8fXgwle
         M68g==
X-Received: by 10.14.183.2 with SMTP id p2mr17826332eem.44.1380058733346;
        Tue, 24 Sep 2013 14:38:53 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id i1sm57754164eeg.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 14:38:52 -0700 (PDT)
Message-ID: <52420664.2040604@gmail.com>
Date:   Tue, 24 Sep 2013 23:38:44 +0200
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     linux@arm.linux.org.uk, mturquette@linaro.org
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37941
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

On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
> This patch series implements clock deregistration in the common clock
> framework. Comparing to v5 it only includes further corrections of NULL
> clock handling.
[...]
>    clk: Provide not locked variant of of_clk_get_from_provider()
>    clkdev: Fix race condition in clock lookup from device tree
>    clk: Add common __clk_get(), __clk_put() implementations
>    clk: Assign module owner of a clock being registered
>    clk: Implement clk_unregister

Hi Mike, Russell,

Would you have any further comments/suggestions on this series ?

I have inspected all callers of clk_register() and all should be fine
with regards to dereferencing dev->driver. The first argument to this
function is either NULL or clk_register() is being called in drivers'
probe() callback, which ensures dev->driver won't change due to holding
dev->mutex.

The only issue I found might be at the omap3isp driver, which provides
clock to its sub-drivers and takes reference on the sub-driver modules.
When sub-driver calls clk_get() all modules would get locked in memory,
due to circular reference. One solution to that could be to pass NULL
struct device pointer, as in the below patch.

---------8<------------------
 From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 19 Sep 2013 23:52:04 +0200
Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
  drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
  drivers/media/platform/omap3isp/isp.h |    1 +
  2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c 
b/drivers/media/platform/omap3isp/isp.c
index df3a0ec..d7f3c98 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
  	struct clk_init_data init;
  	unsigned int i;

+	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i)
+		isp->xclks[i] = ERR_PTR(-EINVAL);
+
  	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
  		struct isp_xclk *xclk = &isp->xclks[i];
-		struct clk *clk;

  		xclk->isp = isp;
  		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
@@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)

  		xclk->hw.init = &init;

-		clk = devm_clk_register(isp->dev, &xclk->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		xclk->clk = clk_register(NULL, &xclk->hw);
+		if (IS_ERR(xclk->clk))
+			return PTR_ERR(xclk->clk);

  		if (pdata->xclks[i].con_id == NULL &&
  		    pdata->xclks[i].dev_id == NULL)
@@ -320,7 +322,7 @@ static int isp_xclk_init(struct isp_device *isp)

  		xclk->lookup->con_id = pdata->xclks[i].con_id;
  		xclk->lookup->dev_id = pdata->xclks[i].dev_id;
-		xclk->lookup->clk = clk;
+		xclk->lookup->clk = xclk->clk;

  		clkdev_add(xclk->lookup);
  	}
@@ -335,6 +337,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
  	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
  		struct isp_xclk *xclk = &isp->xclks[i];

+		if (!IS_ERR(xclk->clk))
+			clk_unregister(xclk->clk);
+
  		if (xclk->lookup)
  			clkdev_drop(xclk->lookup);
  	}
diff --git a/drivers/media/platform/omap3isp/isp.h 
b/drivers/media/platform/omap3isp/isp.h
index cd3eff4..1498f2b 100644
--- a/drivers/media/platform/omap3isp/isp.h
+++ b/drivers/media/platform/omap3isp/isp.h
@@ -135,6 +135,7 @@ struct isp_xclk {
  	struct isp_device *isp;
  	struct clk_hw hw;
  	struct clk_lookup *lookup;
+	struct clk *clk;
  	enum isp_xclk_id id;

  	spinlock_t lock;	/* Protects enabled and divider */
-- 
---------8<------------------


Alternatively an additional argument could be added to the clk_register*()
functions. Something like:

---------8<------------------
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 27f8c42..ef934ac 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1837,7 +1837,8 @@ struct clk *__clk_register(struct device *dev, 
struct clk_hw *hw)
  }
  EXPORT_SYMBOL_GPL(__clk_register);

-static int _clk_register(struct device *dev, struct clk_hw *hw, struct 
clk *clk)
+static int _clk_register(struct device *dev, struct clk_hw *hw, struct 
clk *clk,
+							struct module *owner)
  {
  	int i, ret;

@@ -1877,6 +1878,8 @@ static int _clk_register(struct device *dev, 
struct clk_hw *hw, struct clk *clk)
  		}
  	}

+	clk->owner = owner;
+
  	ret = __clk_init(dev, clk);
  	if (!ret)
  		return 0;
@@ -1892,7 +1895,7 @@ fail_name:
  }

  /**
- * clk_register - allocate a new clock, register it and return an 
opaque cookie
+ * ___clk_register - allocate a new clock, register it and return an 
opaque cookie
   * @dev: device that is registering this clock
   * @hw: link to hardware-specific clock data
   *
@@ -1902,7 +1905,8 @@ fail_name:
   * rest of the clock API.  In the event of an error clk_register will 
return an
   * error code; drivers must test for an error code after calling 
clk_register.
   */
-struct clk *clk_register(struct device *dev, struct clk_hw *hw)
+struct clk *___clk_register(struct device *dev, struct clk_hw *hw,
+						struct module *owner)
  {
  	int ret;
  	struct clk *clk;
@@ -1914,7 +1918,7 @@ struct clk *clk_register(struct device *dev, 
struct clk_hw *hw)
  		goto fail_out;
  	}

-	ret = _clk_register(dev, hw, clk);
+	ret = _clk_register(dev, hw, clk, owner);
  	if (!ret)
  		return clk;

@@ -1922,7 +1926,7 @@ struct clk *clk_register(struct device *dev, 
struct clk_hw *hw)
  fail_out:
  	return ERR_PTR(ret);
  }
-EXPORT_SYMBOL_GPL(clk_register);
+EXPORT_SYMBOL_GPL(___clk_register);

  /*
   * Free memory allocated for a clock.
@@ -2040,7 +2044,8 @@ static void devm_clk_release(struct device *dev, 
void *res)
   * automatically clk_unregister()ed on driver detach. See 
clk_register() for
   * more information.
   */
-struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
+struct clk *__devm_clk_register(struct device *dev, struct clk_hw *hw,
+						struct module *owner)
  {
  	struct clk *clk;
  	int ret;
@@ -2049,7 +2054,7 @@ struct clk *devm_clk_register(struct device *dev, 
struct clk_hw *hw)
  	if (!clk)
  		return ERR_PTR(-ENOMEM);

-	ret = _clk_register(dev, hw, clk);
+	ret = _clk_register(dev, hw, clk, owner);
  	if (!ret) {
  		devres_add(dev, clk);
  	} else {
@@ -2059,7 +2064,7 @@ struct clk *devm_clk_register(struct device *dev, 
struct clk_hw *hw)

  	return clk;
  }
-EXPORT_SYMBOL_GPL(devm_clk_register);
+EXPORT_SYMBOL_GPL(__devm_clk_register);

  static int devm_clk_match(struct device *dev, void *res, void *data)
  {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 13623f3..c656ebf 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -31,6 +31,7 @@
  #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate 
change */

  struct clk_hw;
+struct module;

  /**
   * struct clk_ops -  Callback operations for hardware clocks; these are to
@@ -436,8 +437,21 @@ struct clk *clk_register_composite(struct device 
*dev, const char *name,
   * rest of the clock API.  In the event of an error clk_register will 
return an
   * error code; drivers must test for an error code after calling 
clk_register.
   */
-struct clk *clk_register(struct device *dev, struct clk_hw *hw);
-struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
+struct clk *___clk_register(struct device *dev, struct clk_hw *hw,
+		struct module *owner);
+
+static inline struct clk *clk_register(struct device *dev, struct 
clk_hw *hw)
+{
+	return ___clk_register(dev, hw, THIS_MODULE);
+}
+
+struct clk *__devm_clk_register(struct device *dev, struct clk_hw *hw,
+				struct module *owner);
+static inline struct clk *devm_clk_register(struct device *dev,
+					    struct clk_hw *hw)
+{
+	return __devm_clk_register(dev, hw, THIS_MODULE);
+}

  void clk_unregister(struct clk *clk);
  void devm_clk_unregister(struct device *dev, struct clk *clk);

---------8<------------------

Similarly it would need to be done for the remaining clk_register*() 
functions,
which have much longer arguments list.

It's a bit messy, since there is already __clk_register() function with 
double
underscore prefix. Perhaps that could be renamed to something else so 
all the
functions taking struct module * parameter are prefixed with double 
underscore.


I would squash patches 3/5 and 4/5 in the next iteration, if it is decided
to keep using dev->driver->owner.

--
Thanks,
Sylwester
