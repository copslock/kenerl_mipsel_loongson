Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 12:32:45 +0200 (CEST)
Received: from mail-pg0-x234.google.com ([IPv6:2607:f8b0:400e:c05::234]:36832
        "EHLO mail-pg0-x234.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdDJKchoh4UI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 12:32:37 +0200
Received: by mail-pg0-x234.google.com with SMTP id g2so102477074pge.3
        for <linux-mips@linux-mips.org>; Mon, 10 Apr 2017 03:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sC5aJL0zZ6LqryAZqDyY61Mv6ANElTFbfROKMcCMTEs=;
        b=W96J0YNrhepmRpgn9w2l17HOfrN55LGoiWJuu1wVUJMNa2GDM9J6gZWBH18Xca2KKS
         /+6bO2vXPAc/HzjbOGFTdxNZRQtKHEfHJEpob/MjKAz17QdPTFmYw8KRDb9RIdatfbSw
         PTUAcrb9nqJP8TIThXRfB9BI0NQs8wP4UX0Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sC5aJL0zZ6LqryAZqDyY61Mv6ANElTFbfROKMcCMTEs=;
        b=do7iYidC5HiROLbmL6HRx9iJ/uEIMLKRbvcrWNrdfgsIXcOPtq9hc8tfh99z2j5jPl
         RGjOvtuaDCfDh3RNaeh6J06B2o3QmXhm7tAoc0DP0ylwq2LK/L/VSpsVylb/pePPuosz
         I+dgGboHINZVkOQspKSe+eNDQ5B25wDrUyLPO2e409IgPpOsdo9cSvBCzTuy+fE1rSnK
         kE28UsjV61Z4ZPYTCkvoXa942ygAxnKQihqS9sd0tXlE8TWgwxlOQ5oSeJ/FPsVNaySO
         BuUIEr3NsLlXDTXitbHC6RZboo9kItgrB/rueb9qzyWmomhHqRZhzz+N2st29qfqvHJZ
         8AXw==
X-Gm-Message-State: AN3rC/7FHEyO9KUSEfIKxGCT/CWDaN35xUw7Lt+oS9XRdeni0iLiOMLJ1pFyuxljzXdpcMZv
X-Received: by 10.84.238.198 with SMTP id l6mr13673038pln.95.1491820347967;
        Mon, 10 Apr 2017 03:32:27 -0700 (PDT)
Received: from localhost ([122.172.101.74])
        by smtp.gmail.com with ESMTPSA id b185sm12208667pfa.61.2017.04.10.03.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 03:31:56 -0700 (PDT)
Date:   Mon, 10 Apr 2017 16:01:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wuzhangjin@gmail.com
Cc:     linux-mips@linux-mips.org, tglx@linutronix.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] CPUFREQ: Loongson2: drop set_cpus_allowed_ptr()
Message-ID: <20170410103153.GK24555@vireshk-i7>
References: <20170404154957.19678-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170404154957.19678-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57626
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

On 04-04-17, 17:49, Sebastian Andrzej Siewior wrote:
> It is pure mystery to me why we need to be on a specific CPU while
> looking up a value in an array.
> My best shot at this is that before commit d4019f0a92ab ("cpufreq: move
> freq change notifications to cpufreq core") it was required to invoke
> cpufreq_notify_transition() on a special CPU.
> 
> Since it looks like a waste, remove it.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index 6bbdac1065ff..9ac27b22476c 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -51,19 +51,12 @@ static int loongson2_cpu_freq_notifier(struct notifier_block *nb,
>  static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
>  				     unsigned int index)
>  {
> -	unsigned int cpu = policy->cpu;
> -	cpumask_t cpus_allowed;
>  	unsigned int freq;
>  
> -	cpus_allowed = current->cpus_allowed;
> -	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> -
>  	freq =
>  	    ((cpu_clock_freq / 1000) *
>  	     loongson2_clockmod_table[index].driver_data) / 8;
>  
> -	set_cpus_allowed_ptr(current, &cpus_allowed);
> -
>  	/* setting the cpu frequency */
>  	clk_set_rate(policy->clk, freq * 1000);

It was Zhangjin who wrote the first version and he may be able to
answer the questions we have. Anyway, it is safe to apply this patch
right now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
