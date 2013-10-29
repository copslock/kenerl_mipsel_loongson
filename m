Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2013 00:38:17 +0100 (CET)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:39847 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817537Ab3J2XiPAPvnf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Oct 2013 00:38:15 +0100
Received: by mail-wi0-f174.google.com with SMTP id cb5so6018765wib.13
        for <linux-mips@linux-mips.org>; Tue, 29 Oct 2013 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EYl88PMxBzz9D+4Jt66XITaXKsq4l3MkO6qW9yMgJ90=;
        b=mNFFh0M8TO2PyYULpu66nW+8RfwkbNEir/PE2NarrNmZZxFu6OpZrZjylOFaITzd0d
         ZD0vWeT0jR2Apef4HZAA0LN7TGk3o7OxL5oAw9D214KV1c8+OwzWZJWeEGxdJpqyFZG0
         0jd98wNrc4Qt1h0FdauvN7WQR/U5IJjwCqa0R/JhAo2MRMkm/54r7uWqPVxLTKJRXWqn
         sHOv9ZCP8lKBcz6/piKOkaLRv2wHgbIGs0LQi0EXcXqezIe4YPdesWuNHI3u+lc0V0lH
         JuXdp8Jc2duUGgFeDv/Um32UN0fFE++8rxRLX+X7Y+M+wWUfZW/Rzbefn436ykWl5hCF
         cVTQ==
X-Received: by 10.194.20.170 with SMTP id o10mr1976654wje.4.1383089889658;
        Tue, 29 Oct 2013 16:38:09 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id pi6sm9777656wic.3.2013.10.29.16.38.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Oct 2013 16:38:08 -0700 (PDT)
Message-ID: <527046DE.6050009@gmail.com>
Date:   Wed, 30 Oct 2013 00:38:06 +0100
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk,
        mturquette@linaro.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, jiada_wang@mentor.com,
        t.figa@samsung.com, linux-kernel@vger.kernel.org,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        g.liakhovetski@gmx.de
Subject: Re: [PATCH v6 0/5] clk: clock deregistration support
References: <1377874402-2944-1-git-send-email-s.nawrocki@samsung.com> <52420664.2040604@gmail.com> <13429728.zDYQ5qS5ur@avalon>
In-Reply-To: <13429728.zDYQ5qS5ur@avalon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38409
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

On 10/28/2013 10:05 PM, Laurent Pinchart wrote:
> On Tuesday 24 September 2013 23:38:44 Sylwester Nawrocki wrote:
>> On 08/30/2013 04:53 PM, Sylwester Nawrocki wrote:
>>> This patch series implements clock deregistration in the common clock
>>> framework. Comparing to v5 it only includes further corrections of NULL
>>> clock handling.
[...]
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
>
> I don't think you've compile-tested this :-)

Thank you for the comments. Yeah, I messed up this, I thought this part
got recompiled but it didn't. I've fixed this in the recently posted
patch.

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
>
> This doesn't introduce any regression in the sense that it will trade a
> problem for another one, so I'm fine with it in the short. Could you add a
> small comment above the clk_register() call to explain why the first argument
> is NULL ?

I'm not entirely happy about doing something like that. Nevertheless I 
didn't
hear so far any better proposals and I guess it could be treated as a short
term modification while we're working on proper handling of those circular
references.

--
Thanks,
Sylwester
