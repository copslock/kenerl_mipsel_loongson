Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 15:42:38 +0100 (CET)
Received: from bhuna.collabora.co.uk ([93.93.135.160]:35457 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010483AbbAVOmgKjEVM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 15:42:36 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 58C25600E93
Message-ID: <54C10C54.6070500@collabora.com>
Date:   Thu, 22 Jan 2015 15:42:28 +0100
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Stephen Boyd <sboyd@codeaurora.org>
CC:     linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        =?windows-1252?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Matt Porter <mporter@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Bintian Wang <bintian.wang@huawei.com>,
        Chao Xie <chao.xie@marvell.com>, linux-doc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v11 3/4] clk: Add rate constraints to clocks
References: <1421847039-29544-1-git-send-email-tomeu.vizoso@collabora.com> <1421847039-29544-4-git-send-email-tomeu.vizoso@collabora.com> <20150122014635.GI27202@codeaurora.org>
In-Reply-To: <20150122014635.GI27202@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <tomeu.vizoso@collabora.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45430
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

On 01/22/2015 02:46 AM, Stephen Boyd wrote:
> On 01/21, Tomeu Vizoso wrote:
>> Adds a way for clock consumers to set maximum and minimum rates. This
>> can be used for thermal drivers to set minimum rates, or by misc.
>> drivers to set maximum rates to assure a minimum performance level.
>>
>> Changes the signature of the determine_rate callback by adding the
>> parameters min_rate and max_rate.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>> v11:	* Recalculate the rate before putting the reference to clk_core
>> 	* Don't recalculate the rate when freeing the per-user clock
>> 	in the initialization error paths
>> 	* Move __clk_create_clk to be next to __clk_free_clk for more
>> 	comfortable reading
> 
> Can we do this in the previous patch where we introduce the
> function?

Ok.

>> @@ -2143,9 +2314,16 @@ struct clk *__clk_register(struct device *dev, struct clk_hw *hw)
>>  	else
>>  		clk->owner = NULL;
>>  
>> +	INIT_HLIST_HEAD(&clk->clks);
>> +
>> +	hw->clk = __clk_create_clk(hw, NULL, NULL);
>> +
>>  	ret = __clk_init(dev, hw->clk);
>> -	if (ret)
>> +	if (ret) {
>> +		__clk_free_clk(hw->clk);
>> +		hw->clk = NULL;
>>  		return ERR_PTR(ret);
>> +	}
>>  
>>  	return hw->clk;
>>  }
>> @@ -2210,12 +2388,16 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
>>  		}
>>  	}
>>  
>> +	INIT_HLIST_HEAD(&clk->clks);
>> +
>>  	hw->clk = __clk_create_clk(hw, NULL, NULL);
>>  	ret = __clk_init(dev, hw->clk);
>>  	if (!ret)
>>  		return hw->clk;
>>  
>> -	kfree(hw->clk);
>> +	__clk_free_clk(hw->clk);
>> +	hw->clk = NULL;
> 
> Shouldn't we be assigning to NULL in the previous patch (same
> comment for __clk_register)?

Agreed, though I have gone ahead and removed __clk_register completely
because AFAICS it has never been used.

>>  fail_parent_names_copy:
>>  	while (--i >= 0)
>>  		kfree(clk->parent_names[i]);
>> @@ -2420,7 +2602,14 @@ void __clk_put(struct clk *clk)
>>  	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
>>  		return;
>>  
>> +	clk_prepare_lock();
>> +	hlist_del(&clk->child_node);
>> +	clk_prepare_unlock();
>> +
>> +	clk_core_set_rate(clk->core, clk->core->req_rate);
>> +
>>  	clk_core_put(clk->core);
>> +
> 
> Sad that we take the lock 3 times during __clk_put(). We should
> be able to do it only once if we have a lockless
> clk_core_set_rate() function and put the contents of
> clk_core_put() into this function. Actually we need to do that to
> be thread safe with clk->core->req_rate changing. We can call the
> same function in clk_set_rate_range() too so that we don't have
> to deal with recursive locking there.

Sweet, done.

>>  	kfree(clk);
>>  }
>>  
> 

Thanks,

Tomeu
