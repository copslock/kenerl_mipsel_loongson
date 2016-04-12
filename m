Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2016 07:18:40 +0200 (CEST)
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34420 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025752AbcDLFSd2ik32 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Apr 2016 07:18:33 +0200
Received: by mail-pf0-f172.google.com with SMTP id c20so6675989pfc.1
        for <linux-mips@linux-mips.org>; Mon, 11 Apr 2016 22:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZeJYxUXyE0rGzDosJbcmTpcGpihwCLIJPJrFp60k+M=;
        b=WM8W1GuMY+fgHm43VsC0HhTtMqm+zGf3bh/0Mty4qUkEWSW8dPq0ZXsfi8ijX/KgH2
         Ugzc4QRYYIyz90OOLhZbW8p3x2HD73XxDomTl49pNiUNRpV/9bIoyn5EkEONo0vXKory
         UTawTksH6gIS8BCgZgrAeQgY8eKS6lq1qbidc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZeJYxUXyE0rGzDosJbcmTpcGpihwCLIJPJrFp60k+M=;
        b=LfizxK9Xy/wuDRX4TBw4b/hHKbfyn7YQp8i5rizMcr9lXQFbZF0RSV1IUuhUOpqlYw
         cRmPPJQExF8MSG4gKwblfpmA2sYUhw1l6n8O1xiKwlvvD6yHMKX8SkOwsj0j4H7r9vJp
         SQQI+coSIBjqhZKHfIMYintohnLaV1Q2FcMHinc1brEOnr3C7X7jafeq+rmfUwmuTvDw
         nBLn6hP1gWW+8Wi6wFUcbOdSb85tMghvO8aw82GLDa7GV8YH7flEOQ/6Fv5EVGyPRBxj
         /dVDLM1Ib+dqMNyvaiyctklavf4p1CJPRO1S5MzKenVytGGwqNwy2nrkHUEWe3V59OmQ
         0KwA==
X-Gm-Message-State: AOPr4FWqjtHL6IKF09Iez4sz7/FX0j252S1zw3RxfsYadNgDLi9ICaQcJmxVcOI7hXsg/hPv
X-Received: by 10.98.7.153 with SMTP id 25mr1963450pfh.38.1460438307750;
        Mon, 11 Apr 2016 22:18:27 -0700 (PDT)
Received: from localhost ([122.172.42.224])
        by smtp.gmail.com with ESMTPSA id r191sm39904200pfr.36.2016.04.11.22.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Apr 2016 22:18:27 -0700 (PDT)
Date:   Tue, 12 Apr 2016 10:48:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/5] cpufreq: Loongson1: Use dev_get_platdata() to get
 platform_data
Message-ID: <20160412051824.GQ16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460375759-20705-3-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52956
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
> This patch uses dev_get_platdata() to get the platform_data
> instead of referencing it directly.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
> index 2d83744..f0d40fd 100644
> --- a/drivers/cpufreq/loongson1-cpufreq.c
> +++ b/drivers/cpufreq/loongson1-cpufreq.c
> @@ -134,7 +134,7 @@ static int ls1x_cpufreq_remove(struct platform_device *pdev)
>  
>  static int ls1x_cpufreq_probe(struct platform_device *pdev)
>  {
> -	struct plat_ls1x_cpufreq *pdata = pdev->dev.platform_data;
> +	struct plat_ls1x_cpufreq *pdata = dev_get_platdata(&pdev->dev);
>  	struct clk *clk;
>  	int ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
