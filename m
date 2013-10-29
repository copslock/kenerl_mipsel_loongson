Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 00:58:02 +0100 (CET)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35934 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823051Ab3J2X6AOAA-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 00:58:00 +0100
Received: by mail-wg0-f48.google.com with SMTP id b13so588970wgh.3
        for <linux-mips@linux-mips.org>; Tue, 29 Oct 2013 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yg90Bcmdt26K7xka3WX7h6YckB4hzG1wHhQtZWCmtWM=;
        b=Bunk68RHLBRS1GoIuuNQpNImz81Je1fcNbwi4E9waR7coJJw5GYrF5shAPb04YpDG4
         WjlmrL+QMCOqFbCosaf9k6u/lm1L4jukuYQYCgqNbeXtwBtm1z9rJUmoXTnfOtivFf+n
         FbyjH1gb/yDxGCoWoQksvtJp2bf7tduzz8isW74lrQq7c0UAMwim0PqMmKH7e7yi0o5/
         ObCDa4Ek8i+1zfIZSZmfmQnVv8gSE1S2Clqru3T+PdtohPLEE2Aj21G/SNiPi0JkaQKW
         C2S1sSBjo7NGpIR/+2SvLXsuq9cEWnMJU8g4HjvtDCqixv/2OeGsVJgGapUQXdj3Mz8e
         BVbA==
X-Received: by 10.180.38.34 with SMTP id d2mr208392wik.31.1383091074857;
        Tue, 29 Oct 2013 16:57:54 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id ft19sm9923887wic.5.2013.10.29.16.57.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Oct 2013 16:57:54 -0700 (PDT)
Message-ID: <52704B80.2040507@gmail.com>
Date:   Wed, 30 Oct 2013 00:57:52 +0100
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org, mturquette@linaro.org,
        linux@arm.linux.org.uk, jiada_wang@mentor.com,
        kyungmin.park@samsung.com, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, LMML <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: Re: [PATCH v7 1/5] omap3isp: Modify clocks registration to avoid
 circular references
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com> <1383076268-8984-2-git-send-email-s.nawrocki@samsung.com> <16467881.81yEf9zq68@avalon>
In-Reply-To: <16467881.81yEf9zq68@avalon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38411
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

Hi Laurent,

(adding Mauro and LMML at Cc)

On 10/29/2013 11:28 PM, Laurent Pinchart wrote:
> Hi Sylwester,
>
> Thank you for the patch.
>
> On Tuesday 29 October 2013 20:51:04 Sylwester Nawrocki wrote:
>> The clock core code is going to be modified so clk_get() takes
>> reference on the clock provider module. Until the potential circular
>> reference issue is properly addressed, we pass NULL as as the first
>> argument to clk_register(), in order to disallow sub-devices taking
>> a reference on the ISP module back trough clk_get(). This should
>> prevent locking the modules in memory.
>>
>> Cc: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
>> Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> Acked-by: Laurent Pinchart<laurent.pinchart@ideasonboard.com>
>
> Do you plan to push this to mainline as part of this patch series ? I don't
> have pending patches for the omap3isp that would conflict with this patch, so
> that would be fine with me.

Thanks, yes I thought this patch might be merged together through the clk
tree, if Mike is willing to take it and we get yours and Mauro's Ack on it.

>> ---
>> This patch has been "compile tested" only.
>>
>> ---
>>   drivers/media/platform/omap3isp/isp.c |   22 ++++++++++++++++------
>>   drivers/media/platform/omap3isp/isp.h |    1 +
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/omap3isp/isp.c
>> b/drivers/media/platform/omap3isp/isp.c index df3a0ec..286027a 100644
>> --- a/drivers/media/platform/omap3isp/isp.c
>> +++ b/drivers/media/platform/omap3isp/isp.c
>> @@ -290,9 +290,11 @@ static int isp_xclk_init(struct isp_device *isp)
>>   	struct clk_init_data init;
>>   	unsigned int i;
>>
>> +	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i)
>> +		isp->xclks[i].clk = ERR_PTR(-EINVAL);
>> +
>>   	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
>>   		struct isp_xclk *xclk =&isp->xclks[i];
>> -		struct clk *clk;
>>
>>   		xclk->isp = isp;
>>   		xclk->id = i == 0 ? ISP_XCLK_A : ISP_XCLK_B;
>> @@ -305,10 +307,15 @@ static int isp_xclk_init(struct isp_device *isp)
>>   		init.num_parents = 1;
>>
>>   		xclk->hw.init =&init;
>> -
>> -		clk = devm_clk_register(isp->dev,&xclk->hw);
>> -		if (IS_ERR(clk))
>> -			return PTR_ERR(clk);
>> +		/*
>> +		 * The first argument is NULL in order to avoid circular
>> +		 * reference, as this driver takes reference on the
>> +		 * sensor subdevice modules and the sensors would take
>> +		 * reference on this module through clk_get().
>> +		 */
>> +		xclk->clk = clk_register(NULL,&xclk->hw);
>> +		if (IS_ERR(xclk->clk))
>> +			return PTR_ERR(xclk->clk);
>>
>>   		if (pdata->xclks[i].con_id == NULL&&
>>   		pdata->xclks[i].dev_id == NULL)
>> @@ -320,7 +327,7 @@ static int isp_xclk_init(struct isp_device *isp)
>>
>>   		xclk->lookup->con_id = pdata->xclks[i].con_id;
>>   		xclk->lookup->dev_id = pdata->xclks[i].dev_id;
>> -		xclk->lookup->clk = clk;
>> +		xclk->lookup->clk = xclk->clk;
>>
>>   		clkdev_add(xclk->lookup);
>>   	}
>> @@ -335,6 +342,9 @@ static void isp_xclk_cleanup(struct isp_device *isp)
>>   	for (i = 0; i<  ARRAY_SIZE(isp->xclks); ++i) {
>>   		struct isp_xclk *xclk =&isp->xclks[i];
>>
>> +		if (!IS_ERR(xclk->clk))
>> +			clk_unregister(xclk->clk);
>> +
>>   		if (xclk->lookup)
>>   			clkdev_drop(xclk->lookup);
>>   	}
>> diff --git a/drivers/media/platform/omap3isp/isp.h
>> b/drivers/media/platform/omap3isp/isp.h index cd3eff4..1498f2b 100644
>> --- a/drivers/media/platform/omap3isp/isp.h
>> +++ b/drivers/media/platform/omap3isp/isp.h
>> @@ -135,6 +135,7 @@ struct isp_xclk {
>>   	struct isp_device *isp;
>>   	struct clk_hw hw;
>>   	struct clk_lookup *lookup;
>> +	struct clk *clk;
>>   	enum isp_xclk_id id;
>>
>>   	spinlock_t lock;	/* Protects enabled and divider */

--
Regards,
Sylwester
