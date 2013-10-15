Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2013 22:04:29 +0200 (CEST)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:52415 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827336Ab3JOUE1SYh92 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Oct 2013 22:04:27 +0200
Received: by mail-wi0-f177.google.com with SMTP id h11so1386873wiv.4
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yn6yY4MO7KrSywzE0v++qrp7+KEMkmfg/lIn+2WWedg=;
        b=XRwigqcgAIpbO3caUIwFxLk8RRHHBST072E40G+hiULmMFUrtwok05/M0MOZpNHEUQ
         SLkXrha2W+mstFe0ta+icpu8yaWzMdTdq1UP+BcRB5SmDs37qKCq0e+VnUUDf4gzQEvg
         ClRHOU42Tswo5a7TJ+AyQfWtDtknbQwDqq9FCCRflPT76M7THodGKQVn1CwkCn1Aw8QO
         np2inN751p7yeMAWbZJPEIqHz2yDA2pbt5x2BHH7Z5RZay7hM8MIw7VkNACoR27xGF1X
         XIQLrwBsrcu8/aGbYT66gM+pZ4yAwn3gmcfoivL4XeJwgaBiK5hzFPH5j4kcVNgbeErm
         iq9w==
X-Received: by 10.194.20.202 with SMTP id p10mr9239670wje.39.1381867461789;
        Tue, 15 Oct 2013 13:04:21 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id i8sm9355718wiy.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 13:04:20 -0700 (PDT)
Message-ID: <525D9FC1.2040204@gmail.com>
Date:   Tue, 15 Oct 2013 22:04:17 +0200
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     linux@arm.linux.org.uk, mturquette@linaro.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        t.figa@samsung.com, g.liakhovetski@gmx.de,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, LMML <linux-media@vger.kernel.org>
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com> <52420664.2040604@gmail.com> <3160771.O1gFkR91vK@avalon>
In-Reply-To: <3160771.O1gFkR91vK@avalon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38347
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

Hi,

(adding linux-media mailing list at Cc)

On 09/25/2013 11:47 AM, Laurent Pinchart wrote:
> On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
[...]
>> The only issue I found might be at the omap3isp driver, which provides
>> clock to its sub-drivers and takes reference on the sub-driver modules.
>> When sub-driver calls clk_get() all modules would get locked in memory,
>> due to circular reference. One solution to that could be to pass NULL
>> struct device pointer, as in the below patch.
>
> Doesn't that introduce race conditions ? If the sub-drivers require the clock,
> they want to be sure that the clock won't disappear beyond their backs. I
> agree that the circular dependency needs to be solved somehow, but we probably
> need a more generic solution. The problem will become more widespread in the
> future with DT-based device instantiation in both V4L2 and KMS.

I'm wondering whether subsystems and drivers itself should be written so
they deal with such dependencies they are aware of.

There is similar situation in the regulator API, regulator_get() simply
takes a reference on a module providing the regulator object.

Before a "more generic solution" is available, what do you think about
keeping obtaining a reference on a clock provider module in clk_get() and
doing clk_get(), clk_prepare_enable(), ..., clk_unprepare_disable(),
clk_put() in sub-driver whenever a clock is actively used, to avoid
permanent circular reference ?

--
Thanks,
Sylwester

>> ---------8<------------------
>>   From ca5963041aad67e31324cb5d4d5e2cfce1706d4f Mon Sep 17 00:00:00 2001
>> From: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Date: Thu, 19 Sep 2013 23:52:04 +0200
>> Subject: [PATCH] omap3isp: Pass NULL device pointer to clk_register()
>>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> ---
>>    drivers/media/platform/omap3isp/isp.c |   15 ++++++++++-----
>>    drivers/media/platform/omap3isp/isp.h |    1 +
>>    2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/omap3isp/isp.c
>> b/drivers/media/platform/omap3isp/isp.c
>> index df3a0ec..d7f3c98 100644
>> --- a/drivers/media/platform/omap3isp/isp.c
>> +++ b/drivers/media/platform/omap3isp/isp.c
>> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
>>    	struct clk_init_data init;
>>    	unsigned int i;
>>
>> +	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i)
>> +		isp->xclks[i] = ERR_PTR(-EINVAL);
>> +
>>    	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
>>    		struct isp_xclk *xclk =&isp->xclks[i];
>> -		struct clk *clk;
>>
>>    		xclk->isp = isp;
>>    		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
>> @@ -306,9 +308,9 @@ static int isp_xclk_init(struct isp_device *isp)
>>
>>    		xclk->hw.init =&init;
>>
>> -		clk = devm_clk_register(isp->dev,&xclk->hw);
>> -		if (IS_ERR(clk))
>> -			return PTR_ERR(clk);
>> +		xclk->clk = clk_register(NULL,&xclk->hw);
>> +		if (IS_ERR(xclk->clk))
>> +			return PTR_ERR(xclk->clk);
>>
>>    		if (pdata->xclks[i].con_id == NULL&&
>>    		pdata->xclks[i].dev_id == NULL)
>> @@ -320,7 +322,7 @@ static int isp_xclk_init(struct isp_device *isp)
>>
>>    		xclk->lookup->con_id = pdata->xclks[i].con_id;
>>    		xclk->lookup->dev_id = pdata->xclks[i].dev_id;
>> -		xclk->lookup->clk = clk;
>> +		xclk->lookup->clk = xclk->clk;
>>
>>    		clkdev_add(xclk->lookup);
>>    	}
>> @@ -335,6 +337,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
>>    	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
>>    		struct isp_xclk *xclk =&isp->xclks[i];
>>
>> +		if (!IS_ERR(xclk->clk))
>> +			clk_unregister(xclk->clk);
>> +
>>    		if (xclk->lookup)
>>    			clkdev_drop(xclk->lookup);
>>    	}
>> diff --git a/drivers/media/platform/omap3isp/isp.h
>> b/drivers/media/platform/omap3isp/isp.h
>> index cd3eff4..1498f2b 100644
>> --- a/drivers/media/platform/omap3isp/isp.h
>> +++ b/drivers/media/platform/omap3isp/isp.h
>> @@ -135,6 +135,7 @@ struct isp_xclk {
>>    	struct isp_device *isp;
>>    	struct clk_hw hw;
>>    	struct clk_lookup *lookup;
>> +	struct clk *clk;
>>    	enum isp_xclk_id id;
>>
>>    	spinlock_t lock;	/* Protects enabled and divider */
>> ---------8<------------------
