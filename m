Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 07:24:32 +0200 (CEST)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33202 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014448AbcDLFY3LopVb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 07:24:29 +0200
Received: by mail-pf0-f173.google.com with SMTP id 184so6814844pff.0
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 22:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSzT3ULB+9mrL2wduG+iSjImYOHrm0rRUzlyKfekR8A=;
        b=cG6B1xNakDv/JwxFkiIELHafmjBvEviEmjU79l2TqBFM9XksxmswKTsRlx9pS85VIu
         /AqhTIb2OGL1KiuoR4h06YXwwd9cP0vCgdpV0nIO8S4MPrZhDITOn9yrEPU+5mpm02c3
         06RDxsfWuQC5U4Wm9Js/M9eKacW2pshebC3MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSzT3ULB+9mrL2wduG+iSjImYOHrm0rRUzlyKfekR8A=;
        b=T1QA9UQhwwIQMggdMdQKCI0dqmmv94+IPYHMT6O+UfvABEDHVHzSMtufcT0dNStxt1
         3O7/aRWyZUimFGOXd5YFlS5f/LHhF/1G267hCGMTPHVAOVof2+KyErwQPWf3idQDuUtw
         rrGxUP7tim4OTkC+TIRXoz+wrNdxv6HzuRPonxlVHTqNhO4dEKifExNca+eRuuoZJAIw
         w/xIS8xj2UkNqd9fk+v5CziZ79mZp+pzyoW3sezCmSHFCGhbX2LcJn0jDvTiq5vGn4iJ
         cHb+OuHQS9g4vyg3v8B1gOCUT2TVU8xn0R3/rINLtocWyW5V1QOKRBuDTPqvYODtqjRr
         MWKQ==
X-Gm-Message-State: AOPr4FUMhz15sYls8iZdFlWRpezCTimuqAhPsbiU1oYaPlPZfe0kRnZu74qbd4Rh23wG0Wal
X-Received: by 10.98.10.156 with SMTP id 28mr1960491pfk.130.1460438663465;
        Mon, 11 Apr 2016 22:24:23 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id to9sm40052055pab.27.2016.04.11.22.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 22:24:22 -0700 (PDT)
Date:   Tue, 12 Apr 2016 10:54:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] cpufreq: Loongson1: Replace goto out with return in
 ls1x_cpufreq_probe()
Message-ID: <20160412052417.GS16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460375759-20705-5-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch replaces goto out with return in ls1x_cpufreq_probe(),
> and also includes some minor fixes.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> index 5074f5e..1bc90af 100644
> --- a/drivers/cpufreq/loongson1-cpufreq.c
> +++ b/drivers/cpufreq/loongson1-cpufreq.c
> @@ -1,7 +1,7 @@
>  /*
>   * CPU Frequency Scaling for Loongson 1 SoC
>   *
> - * Copyright (C) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
> + * Copyright (C) 2014-2016 Zhang, Keguang <keguang.zhang@gmail.com>

Actually you should fold above into the first patch of the series,
that renames this file. It makes much sense that way.

>   *
>   * This file is licensed under the terms of the GNU General Public
>   * License version 2. This program is licensed "as is" without any
> @@ -141,7 +141,8 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	int ret;
>  
> -	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name)
> +	if (!pdata || !pdata->clk_name || !pdata->osc_clk_name) {

You added a '{' here, but the closing '}' is added way down..
Something is wrong here I feel..

> +		dev_err(&pdev->dev, "platform data missing\n");
>  		return -EINVAL;
>  
>  	cpufreq =
> @@ -155,8 +156,7 @@ static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk)) {
>  		dev_err(&pdev->dev, "unable to get %s clock\n",
>  			pdata->clk_name);
> -		ret = PTR_ERR(clk);
> -		goto out;
> +		return PTR_ERR(clk);
>  	}

>  static struct platform_driver ls1x_cpufreq_platdrv = {
> -	.driver = {
> +	.probe	= ls1x_cpufreq_probe,
> +	.remove	= ls1x_cpufreq_remove,
> +	.driver	= {
>  		.name	= "ls1x-cpufreq",
>  	},
> -	.probe		= ls1x_cpufreq_probe,
> -	.remove		= ls1x_cpufreq_remove,

Why do this change at all? Do it in the first patch if you really want
to.

>  };
>  
>  module_platform_driver(ls1x_cpufreq_platdrv);
>  
>  MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> -MODULE_DESCRIPTION("Loongson 1 CPUFreq driver");
> +MODULE_DESCRIPTION("Loongson1 CPUFreq driver");

This one as well, move it to the first patch.

>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1

-- 
viresh
