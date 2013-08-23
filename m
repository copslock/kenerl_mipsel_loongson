Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2013 23:59:00 +0200 (CEST)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:42422 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827310Ab3HWV6vFV7KD convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Aug 2013 23:58:51 +0200
Received: by mail-pa0-f54.google.com with SMTP id kx10so1169192pab.41
        for <linux-mips@linux-mips.org>; Fri, 23 Aug 2013 14:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=P8orVJrx+fcVRN71JpIcO08tI+RcfHtLBDwZWOf/USQ=;
        b=V72VfyfS4MjJfHsmJcXLlEX+RbV/E7osBzI+s6+wEooaUOotU5n7ZX/nXor962ALHw
         LvULx0UspTxTOUpgm0FkfJZQR641e71o/cM3tIoXUXCeKbmnTZU3R45GpS2NlGDJXiFZ
         IOhII+eeS5pouCoqphSRlMw5YOx+1NIjyxNLXRASWt7lyQLmrt3PU/Y2lfK/R/rhbx8V
         4ZkmSZBGLu7aqGBqlRdSVtKMw4NMcP1p+4oYQiYWRwFoWeV4+gyrzeE2S9hhRN7QdbHq
         e7k4RotSuab7d54KNfZDTNeXSQRCubTWS7u//FwRxQBXIQlzCTBpuh+Tv3Ug7FN2IuJI
         50zw==
X-Gm-Message-State: ALoCoQnl31QIYeUmWil1gFD7xFLkQHOvFHYZmK9j/2A0P7ZVm7CokXkCi5TTaAkzdfSMDqQ8hK+1
X-Received: by 10.66.161.229 with SMTP id xv5mr1157970pab.87.1377295122518;
        Fri, 23 Aug 2013 14:58:42 -0700 (PDT)
Received: from localhost ([2601:9:5b00:11d:ca60:ff:fe0a:8a36])
        by mx.google.com with ESMTPSA id ia5sm1889123pbc.42.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 14:58:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org
From:   Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1377020063-30213-3-git-send-email-s.nawrocki@samsung.com>
Cc:     linux@arm.linux.org.uk, jiada_wang@mentor.com,
        robherring2@gmail.com, grant.likely@linaro.org, broonie@kernel.org,
        vapier@gentoo.org, ralf@linux-mips.org, kyungmin.park@samsung.com,
        shawn.guo@linaro.org, sebastian.hesselbarth@gmail.com,
        LW@KARO-electronics.de, t.figa@samsung.com, g.liakhovetski@gmx.de,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130823215838.8231.21635@quantum>
User-Agent: alot/0.3.4
Subject: Re: [PATCH v2 2/4] clk: implement clk_unregister
Date:   Fri, 23 Aug 2013 14:58:38 -0700
Return-Path: <mturquette@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37670
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

Quoting Sylwester Nawrocki (2013-08-20 10:34:21)
> clk_unregister() is currently not implemented and it is required when
> a clock provider module needs to be unloaded.
> 
> Normally the clock supplier module is prevented to be unloaded by
> taking reference on the module in clk_get().
> 
> For cases when the clock supplier module deinitializes despite the
> consumers of its clocks holding a reference on the module, e.g. when
> the driver is unbound through "unbind" sysfs attribute, there are
> empty clock ops added. These ops are assigned temporarily to struct
> clk and used until all consumers release the clock, to avoid invoking
> callbacks from the module which just got removed.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

This change looks good to me. One minor nitpick below.

> ---
> Changes since RFC v1:
>  - renamed clk_dummy_* to clk_nodrv_*.
> 
> Changes since v3 of the original patch [1]:
>  - reparent all children to the orphan list instead of leaving
>    the clock unregistered when it has child clocks,
>  - removed unnecessary prerequisite checks in clk_debug_unregister(),
>  - struct clk is now being freed only when the last clock consumer
>    calls clk_put(),
>  - empty clock ops are used after clk_unregister() has been called
>    until all references to the clock are released and the clock
>    object is freed.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg247548.html
> ---
>  drivers/clk/clk.c           |  123 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/clk-private.h |    2 +
>  2 files changed, 122 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 0e0eb31..549fcb7 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -342,6 +342,21 @@ out:
>         return ret;
>  }
>  
> + /**
> + * clk_debug_unregister - remove a clk node from the debugfs clk tree
> + * @clk: the clk being removed from the debugfs clk tree
> + *
> + * Dynamically removes a clk and all it's children clk nodes from the
> + * debugfs clk tree if clk->dentry points to debugfs created by
> + * clk_debug_register in __clk_init.
> + *
> + * Caller must hold prepare_lock.
> + */
> +static void clk_debug_unregister(struct clk *clk)
> +{
> +       debugfs_remove_recursive(clk->dentry);
> +}
> +
>  /**
>   * clk_debug_reparent - reparent clk node in the debugfs clk tree
>   * @clk: the clk being reparented
> @@ -432,6 +447,9 @@ static inline int clk_debug_register(struct clk *clk) { return 0; }
>  static inline void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
>  {
>  }
> +static inline void clk_debug_unregister(struct clk *clk)
> +{
> +}
>  #endif
>  
>  /* caller must hold prepare_lock */
> @@ -1656,6 +1674,7 @@ int __clk_init(struct device *dev, struct clk *clk)
>  
>         clk_debug_register(clk);
>  
> +       kref_init(&clk->ref);
>  out:
>         clk_prepare_unlock();
>  
> @@ -1785,13 +1804,106 @@ fail_out:
>  }
>  EXPORT_SYMBOL_GPL(clk_register);
>  
> +/*
> + * Free memory allocated for a clock.
> + * Caller must hold prepare_lock.
> + */
> +static void __clk_release(struct kref *ref)
> +{
> +       struct clk *clk = container_of(ref, struct clk, ref);
> +       int i = clk->num_parents;
> +
> +       kfree(clk->parents);
> +       while (--i >= 0)
> +               kfree(clk->parent_names[i]);
> +
> +       kfree(clk->parent_names);
> +       kfree(clk->name);
> +       kfree(clk);
> +}
> +
> +/*
> + * Empty clk_ops for unregistered clocks. These are used temporarily
> + * after clk_unregister() was called on a clock and until last clock
> + * consumer calls clk_put() and the struct clk object is freed.
> + */
> +static int clk_nodrv_prepare_enable(struct clk_hw *hw)
> +{
> +       return -ENXIO;
> +}
> +
> +static void clk_nodrv_disable_unprepare(struct clk_hw *hw)
> +{
> +       WARN_ON(1);

Ideally we shouldn't get here, but if we do I guess it could be very
noisy. How about WARN_ONCE?

After you address Russell's comments in patch #1 I will be happy to take
this series.

Thanks,
Mike

> +}
> +
> +static int clk_nodrv_set_rate(struct clk_hw *hw, unsigned long rate,
> +                                       unsigned long parent_rate)
> +{
> +       return -ENXIO;
> +}
> +
> +static int clk_nodrv_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       return -ENXIO;
> +}
> +
> +static const struct clk_ops clk_nodrv_ops = {
> +       .enable         = clk_nodrv_prepare_enable,
> +       .disable        = clk_nodrv_disable_unprepare,
> +       .prepare        = clk_nodrv_prepare_enable,
> +       .unprepare      = clk_nodrv_disable_unprepare,
> +       .set_rate       = clk_nodrv_set_rate,
> +       .set_parent     = clk_nodrv_set_parent,
> +};
> +
>  /**
>   * clk_unregister - unregister a currently registered clock
>   * @clk: clock to unregister
> - *
> - * Currently unimplemented.
>   */
> -void clk_unregister(struct clk *clk) {}
> +void clk_unregister(struct clk *clk)
> +{
> +       unsigned long flags;
> +
> +       clk_prepare_lock();
> +
> +       if (!clk || IS_ERR(clk)) {
> +               pr_err("%s: invalid clock: %p\n", __func__, clk);
> +               goto out;
> +       }
> +
> +       if (clk->ops == &clk_nodrv_ops) {
> +               pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
> +               goto out;
> +       }
> +       /*
> +        * Assign empty clock ops for consumers that might still hold
> +        * a reference to this clock.
> +        */
> +       flags = clk_enable_lock();
> +       clk->ops = &clk_nodrv_ops;
> +       clk_enable_unlock(flags);
> +
> +       if (!hlist_empty(&clk->children)) {
> +               struct clk *child;
> +
> +               /* Reparent all children to the orphan list. */
> +               hlist_for_each_entry(child, &clk->children, child_node)
> +                       clk_set_parent(child, NULL);
> +       }
> +
> +       clk_debug_unregister(clk);
> +
> +       hlist_del_init(&clk->child_node);
> +
> +       if (clk->prepare_count)
> +               pr_warn("%s: unregistering prepared clock: %s\n",
> +                                       __func__, clk->name);
> +
> +       kref_put(&clk->ref, __clk_release);
> +out:
> +       clk_prepare_unlock();
> +}
>  EXPORT_SYMBOL_GPL(clk_unregister);
>  
>  static void devm_clk_release(struct device *dev, void *res)
> @@ -1862,6 +1974,7 @@ int __clk_get(struct clk *clk)
>         if (!try_module_get(clk->owner))
>                 return 0;
>  
> +       kref_get(&clk->ref);
>         return 1;
>  }
>  EXPORT_SYMBOL(__clk_get);
> @@ -1871,6 +1984,10 @@ void __clk_put(struct clk *clk)
>         if (!clk || IS_ERR(clk))
>                 return;
>  
> +       clk_prepare_lock();
> +       kref_put(&clk->ref, __clk_release);
> +       clk_prepare_unlock();
> +
>         module_put(clk->owner);
>  }
>  EXPORT_SYMBOL(__clk_put);
> diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
> index b7c0b58..36c1fc8 100644
> --- a/include/linux/clk-private.h
> +++ b/include/linux/clk-private.h
> @@ -12,6 +12,7 @@
>  #define __LINUX_CLK_PRIVATE_H
>  
>  #include <linux/clk-provider.h>
> +#include <linux/kref.h>
>  #include <linux/list.h>
>  
>  /*
> @@ -47,6 +48,7 @@ struct clk {
>  #ifdef CONFIG_COMMON_CLK_DEBUG
>         struct dentry           *dentry;
>  #endif
> +       struct kref             ref;
>  };
>  
>  /*
> -- 
> 1.7.9.5
