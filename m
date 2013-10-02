Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 23:40:57 +0200 (CEST)
Received: from mail-pb0-f50.google.com ([209.85.160.50]:51393 "EHLO
        mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868559Ab3JBVkyDMvho convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Oct 2013 23:40:54 +0200
Received: by mail-pb0-f50.google.com with SMTP id uo5so1498844pbc.9
        for <linux-mips@linux-mips.org>; Wed, 02 Oct 2013 14:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=3FpFe9BCBFFccWb7UO01U2rwVaykMZa0hMzl56TMsNY=;
        b=HGhkZKekMGDFqW/mIThQJl9X1mBns/ytGa3U3kxXboEH8dZfhYohbxler3Is1Ai0GL
         yDLNlqntYxc7gDPcUqO1BwF3z7nIM9ua35yDXd3kcW94xoRKGjXCH2y5ZIpylickyfAQ
         bTwVdK4qx/wrscc5ZI3JYnk5Ia/eJ9w458ZL7D4wE4VJ8I04s+qVcvuz/gm+mz374jXw
         M2BDmSb7jf9zPQEkr9EZKYzjwuvuLMaeB7in8KaH3j+3WMDUzIM8CWT/ySrIVPDD0niT
         6jjy480mqhwoparZlv5zJLwYxLjuc9xm6pIVAwsdVMVN9vmdXLc2o0Jt4sRUVl01oDbE
         1pDw==
X-Gm-Message-State: ALoCoQmNmoKvKFMVC63QNm2/4ZNLXeZ4NRTKz9vbGN4yw6pGmHXCRYGXRXVE5ymPdvvSmKQm/+C2
X-Received: by 10.68.139.168 with SMTP id qz8mr4852060pbb.1.1380750047552;
        Wed, 02 Oct 2013 14:40:47 -0700 (PDT)
Received: from localhost ([2601:9:5b00:11d:ca60:ff:fe0a:8a36])
        by mx.google.com with ESMTPSA id y5sm3967710pbs.18.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Oct 2013 14:40:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        linux@arm.linux.org.uk
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <52420664.2040604@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <52420664.2040604@gmail.com>
Message-ID: <20131002214044.4343.24022@quantum>
User-Agent: alot/0.3.4
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
Date:   Wed, 02 Oct 2013 14:40:44 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@linaro.org
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

Quoting Sylwester Nawrocki (2013-09-24 14:38:44)
> On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
> > This patch series implements clock deregistration in the common clock
> > framework. Comparing to v5 it only includes further corrections of NULL
> > clock handling.
> [...]
> >    clk: Provide not locked variant of of_clk_get_from_provider()
> >    clkdev: Fix race condition in clock lookup from device tree
> >    clk: Add common __clk_get(), __clk_put() implementations
> >    clk: Assign module owner of a clock being registered
> >    clk: Implement clk_unregister
> 
> Hi Mike, Russell,
> 
> Would you have any further comments/suggestions on this series ?

I don't have any further comments. The changes look good to me and push
things in the right direction. I'll wait for Laurent's feedback on the
omap3isp driver implications though.

Regards,
Mike

> 
> I have inspected all callers of clk_register() and all should be fine
> with regards to dereferencing dev->driver. The first argument to this
> function is either NULL or clk_register() is being called in drivers'
> probe() callback, which ensures dev->driver won't change due to holding
> dev->mutex.
> 
> The only issue I found might be at the omap3isp driver, which provides
> clock to its sub-drivers and takes reference on the sub-driver modules.
> When sub-driver calls clk_get() all modules would get locked in memory,
> due to circular reference. One solution to that could be to pass NULL
> struct device pointer, as in the below patch.
> 
> ---------8<------------------
>  From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
> From: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Date: Thu, 19 Sep 2013 23:52:04 +0200
> Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>   drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
>   drivers/media/platform/omap3isp/isp.h |    1 +
>   2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/isp.c 
> b/drivers/media/platform/omap3isp/isp.c
> index df3a0ec..d7f3c98 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
>         struct clk_init_data init;
>         unsigned int i;
> 
> +       for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i)
> +               isp->xclks[i] = ERR_PTR(-EINVAL);
> +
>         for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
>                 struct isp_xclk *xclk = &isp->xclks[i];
> -               struct clk *clk;
> 
>                 xclk->isp = isp;
>                 xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
> @@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)
> 
>                 xclk->hw.init = &init;
> 
> -               clk = devm_clk_register(isp->dev, &xclk->hw);
> -               if (IS_ERR(clk))
> -                       return PTR_ERR(clk);
> +               xclk->clk = clk_register(NULL, &xclk->hw);
> +               if (IS_ERR(xclk->clk))
> +                       return PTR_ERR(xclk->clk);
> 
>                 if (pdata->xclks[i].con_id == NULL &&
>                     pdata->xclks[i].dev_id == NULL)
> @@ -320,7 +322,7 @@ static int isp_xclk_init(struct isp_device *isp)
> 
>                 xclk->lookup->con_id = pdata->xclks[i].con_id;
>                 xclk->lookup->dev_id = pdata->xclks[i].dev_id;
> -               xclk->lookup->clk = clk;
> +               xclk->lookup->clk = xclk->clk;
> 
>                 clkdev_add(xclk->lookup);
>         }
> @@ -335,6 +337,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
>         for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i) {
>                 struct isp_xclk *xclk = &isp->xclks[i];
> 
> +               if (!IS_ERR(xclk->clk))
> +                       clk_unregister(xclk->clk);
> +
>                 if (xclk->lookup)
>                         clkdev_drop(xclk->lookup);
>         }
> diff --git a/drivers/media/platform/omap3isp/isp.h 
> b/drivers/media/platform/omap3isp/isp.h
> index cd3eff4..1498f2b 100644
> --- a/drivers/media/platform/omap3isp/isp.h
> +++ b/drivers/media/platform/omap3isp/isp.h
> @@ -135,6 +135,7 @@ struct isp_xclk {
>         struct isp_device *isp;
>         struct clk_hw hw;
>         struct clk_lookup *lookup;
> +       struct clk *clk;
>         enum isp_xclk_id id;
> 
>         spinlock_t lock;        /* Protects enabled and divider */
> -- 
> ---------8<------------------
> 
> 
> Alternatively an additional argument could be added to the clk_register*()
> functions. Something like:
> 
> ---------8<------------------
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 27f8c42..ef934ac 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1837,7 +1837,8 @@ struct clk *__clk_register(struct device *dev, 
> struct clk_hw *hw)
>   }
>   EXPORT_SYMBOL_GPL(__clk_register);
> 
> -static int _clk_register(struct device *dev, struct clk_hw *hw, struct 
> clk *clk)
> +static int _clk_register(struct device *dev, struct clk_hw *hw, struct 
> clk *clk,
> +                                                       struct module *owner)
>   {
>         int i, ret;
> 
> @@ -1877,6 +1878,8 @@ static int _clk_register(struct device *dev, 
> struct clk_hw *hw, struct clk *clk)
>                 }
>         }
> 
> +       clk->owner = owner;
> +
>         ret = __clk_init(dev, clk);
>         if (!ret)
>                 return 0;
> @@ -1892,7 +1895,7 @@ fail_name:
>   }
> 
>   /**
> - * clk_register - allocate a new clock, register it and return an 
> opaque cookie
> + * ___clk_register - allocate a new clock, register it and return an 
> opaque cookie
>    * @dev: device that is registering this clock
>    * @hw: link to hardware-specific clock data
>    *
> @@ -1902,7 +1905,8 @@ fail_name:
>    * rest of the clock API.  In the event of an error clk_register will 
> return an
>    * error code; drivers must test for an error code after calling 
> clk_register.
>    */
> -struct clk *clk_register(struct device *dev, struct clk_hw *hw)
> +struct clk *___clk_register(struct device *dev, struct clk_hw *hw,
> +                                               struct module *owner)
>   {
>         int ret;
>         struct clk *clk;
> @@ -1914,7 +1918,7 @@ struct clk *clk_register(struct device *dev, 
> struct clk_hw *hw)
>                 goto fail_out;
>         }
> 
> -       ret = _clk_register(dev, hw, clk);
> +       ret = _clk_register(dev, hw, clk, owner);
>         if (!ret)
>                 return clk;
> 
> @@ -1922,7 +1926,7 @@ struct clk *clk_register(struct device *dev, 
> struct clk_hw *hw)
>   fail_out:
>         return ERR_PTR(ret);
>   }
> -EXPORT_SYMBOL_GPL(clk_register);
> +EXPORT_SYMBOL_GPL(___clk_register);
> 
>   /*
>    * Free memory allocated for a clock.
> @@ -2040,7 +2044,8 @@ static void devm_clk_release(struct device *dev, 
> void *res)
>    * automatically clk_unregister()ed on driver detach. See 
> clk_register() for
>    * more information.
>    */
> -struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw)
> +struct clk *__devm_clk_register(struct device *dev, struct clk_hw *hw,
> +                                               struct module *owner)
>   {
>         struct clk *clk;
>         int ret;
> @@ -2049,7 +2054,7 @@ struct clk *devm_clk_register(struct device *dev, 
> struct clk_hw *hw)
>         if (!clk)
>                 return ERR_PTR(-ENOMEM);
> 
> -       ret = _clk_register(dev, hw, clk);
> +       ret = _clk_register(dev, hw, clk, owner);
>         if (!ret) {
>                 devres_add(dev, clk);
>         } else {
> @@ -2059,7 +2064,7 @@ struct clk *devm_clk_register(struct device *dev, 
> struct clk_hw *hw)
> 
>         return clk;
>   }
> -EXPORT_SYMBOL_GPL(devm_clk_register);
> +EXPORT_SYMBOL_GPL(__devm_clk_register);
> 
>   static int devm_clk_match(struct device *dev, void *res, void *data)
>   {
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 13623f3..c656ebf 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -31,6 +31,7 @@
>   #define CLK_SET_RATE_NO_REPARENT BIT(7) /* don't re-parent on rate 
> change */
> 
>   struct clk_hw;
> +struct module;
> 
>   /**
>    * struct clk_ops -  Callback operations for hardware clocks; these are to
> @@ -436,8 +437,21 @@ struct clk *clk_register_composite(struct device 
> *dev, const char *name,
>    * rest of the clock API.  In the event of an error clk_register will 
> return an
>    * error code; drivers must test for an error code after calling 
> clk_register.
>    */
> -struct clk *clk_register(struct device *dev, struct clk_hw *hw);
> -struct clk *devm_clk_register(struct device *dev, struct clk_hw *hw);
> +struct clk *___clk_register(struct device *dev, struct clk_hw *hw,
> +               struct module *owner);
> +
> +static inline struct clk *clk_register(struct device *dev, struct 
> clk_hw *hw)
> +{
> +       return ___clk_register(dev, hw, THIS_MODULE);
> +}
> +
> +struct clk *__devm_clk_register(struct device *dev, struct clk_hw *hw,
> +                               struct module *owner);
> +static inline struct clk *devm_clk_register(struct device *dev,
> +                                           struct clk_hw *hw)
> +{
> +       return __devm_clk_register(dev, hw, THIS_MODULE);
> +}
> 
>   void clk_unregister(struct clk *clk);
>   void devm_clk_unregister(struct device *dev, struct clk *clk);
> 
> ---------8<------------------
> 
> Similarly it would need to be done for the remaining clk_register*() 
> functions,
> which have much longer arguments list.
> 
> It's a bit messy, since there is already __clk_register() function with 
> double
> underscore prefix. Perhaps that could be renamed to something else so 
> all the
> functions taking struct module * parameter are prefixed with double 
> underscore.
> 
> 
> I would squash patches 3/5 and 4/5 in the next iteration, if it is decided
> to keep using dev->driver->owner.
> 
> --
> Thanks,
> Sylwester
