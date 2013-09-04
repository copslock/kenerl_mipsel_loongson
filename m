Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2013 17:43:34 +0200 (CEST)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:13922 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825118Ab3IDPn3doLJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Sep 2013 17:43:29 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MSL006CLYBZX680@mailout3.w1.samsung.com> for
 linux-mips@linux-mips.org; Wed, 04 Sep 2013 16:43:21 +0100 (BST)
X-AuditID: cbfec7f5-b7ef66d00000795a-22-52275518bbea
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 3C.DC.31066.81557225; Wed,
 04 Sep 2013 16:43:21 +0100 (BST)
Received: from [106.116.147.32] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPA id <0MSL00BWWYC8YP20@eusync1.samsung.com>; Wed,
 04 Sep 2013 16:43:20 +0100 (BST)
Message-id: <52275517.2090906@samsung.com>
Date:   Wed, 04 Sep 2013 17:43:19 +0200
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-version: 1.0
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux@arm.linux.org.uk, mturquette@linaro.org,
        jiada_wang@mentor.com, kyungmin.park@samsung.com,
        myungjoo.ham@samsung.com, t.figa@samsung.com,
        g.liakhovetski@gmx.de, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH v6 5/5] clk: Implement clk_unregister
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com>
 <1377874402-2944-6-git-send-email-s.nawrocki@samsung.com>
In-reply-to: <1377874402-2944-6-git-send-email-s.nawrocki@samsung.com>
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t/xy7qSoepBBu02Fu83zmOy6PlTaXG2
        6Q27RefEJewWmx5fY7W4vGsOm8WEqZPYLeb8mcJscfsyr8XTCRfZLG43rmCzWD/jNYsDj0dL
        cw+bx4ePcR6zO2ayety5tofN4+jKtUwem5fUe+z+2sTo0bdlFaPH501yAZxRXDYpqTmZZalF
        +nYJXBmvdt1gLLgsXDFj1Sb2BsbD/F2MnBwSAiYSF/vns0LYYhIX7q1n62Lk4hASWMoo0fb0
        IZTziVFi6ryn7CBVvAJaErd3NDKB2CwCqhITnu1gA7HZBAwleo/2MYLYogIBEouXnIOqF5T4
        MfkeC4gtIqAhMaXrMTvIUGaBZUwSVz8dAWsWFrCUeLfhKdS2RkaJ9yueMoMkOAXcJE5ebgLb
        xiygI7G/dRobhC0vsXnNW+YJjAKzkCyZhaRsFpKyBYzMqxhFU0uTC4qT0nON9IoTc4tL89L1
        kvNzNzFCYufrDsalx6wOMQpwMCrx8GoYqgcJsSaWFVfmHmKU4GBWEuGV8wYK8aYkVlalFuXH
        F5XmpBYfYmTi4JRqYJQVvL57z8Q8oYyJSVeyCo+oy8+tXNd/hi3X1Gj/g5ytbz4ffbF7Q2Sd
        1i7DXhfrDKf3ARcSK/ep/AzkOP1SfIF1/x821ds31TR+HWOTXFAyw3nmzmud7VfM3rboVy1/
        qrnqSMNtdZ/bxy490TDrV9tx9OiavL8JyasNfKpCzZl+L9i5wO3RRkYlluKMREMt5qLiRADW
        ZwQOewIAAA==
Return-Path: <s.nawrocki@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37755
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

On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
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
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
[...]
>  /**
>   * clk_unregister - unregister a currently registered clock
>   * @clk: clock to unregister
> - *
> - * Currently unimplemented.
>   */
> -void clk_unregister(struct clk *clk) {}
> +void clk_unregister(struct clk *clk)
> +{
> +	unsigned long flags;
> +
> +	clk_prepare_lock();
> +
> +	if (!clk || IS_ERR(clk)) {
> +		pr_err("%s: invalid clock: %p\n", __func__, clk);
> +		goto out;
> +	}

Actually this check could be done before taking the mutex. And to handle
NULL clocks properly it should be something like:

       if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
               return;

I will hold on with posting a corrected version until there are any
further comments.

> +	if (clk->ops == &clk_nodrv_ops) {
> +		pr_err("%s: unregistered clock: %s\n", __func__, clk->name);
> +		goto out;
> +	}
> +	/*
> +	 * Assign empty clock ops for consumers that might still hold
> +	 * a reference to this clock.
> +	 */
> +	flags = clk_enable_lock();
> +	clk->ops = &clk_nodrv_ops;
> +	clk_enable_unlock(flags);
> +
> +	if (!hlist_empty(&clk->children)) {
> +		struct clk *child;
> +
> +		/* Reparent all children to the orphan list. */
> +		hlist_for_each_entry(child, &clk->children, child_node)
> +			clk_set_parent(child, NULL);
> +	}
> +
> +	clk_debug_unregister(clk);
> +
> +	hlist_del_init(&clk->child_node);
> +
> +	if (clk->prepare_count)
> +		pr_warn("%s: unregistering prepared clock: %s\n",
> +					__func__, clk->name);
> +
> +	kref_put(&clk->ref, __clk_release);
> +out:
> +	clk_prepare_unlock();
> +}
>  EXPORT_SYMBOL_GPL(clk_unregister);
