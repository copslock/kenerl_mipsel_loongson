Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 03:41:32 +0100 (CET)
Received: from mail-pg0-x243.google.com ([IPv6:2607:f8b0:400e:c05::243]:53642
        "EHLO mail-pg0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992996AbdKPClZArPtX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 03:41:25 +0100
Received: by mail-pg0-x243.google.com with SMTP id r12so2728522pgu.10
        for <linux-mips@linux-mips.org>; Wed, 15 Nov 2017 18:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rHB/YB03UY3ew8OLOvZqX/FN2yHbFy2QZBFmiyuy+SU=;
        b=ewgHGcxqbSJLOGGaE+rNIKeJ6sqEEIyZkupu6/vytgrOE05O6+mdXyUcizK9GjTxhD
         QNUnGxvFJQRh99ztxfbl39QExJwOzshxEgosQ7jXLaYrJSJ1wYWAJHL5gUtCWJhZYpog
         1X8WYV6UC/fO4KmfENqaSv1k2sVHolBrgxb5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rHB/YB03UY3ew8OLOvZqX/FN2yHbFy2QZBFmiyuy+SU=;
        b=MBWmar2tVM9V7uggMC1tFa/GyIF8+odW5GBW2rQlszmTorQpj4MkzR6LygS8BU/yB/
         3e1tV9JfQ3ijenoU9uOSJiGuxQFENgzKtsNI0WRpJA+MOlX8YmAKTtv1fFCTzI+WmbFs
         QlF9EdIRzyI9lOMGTOCyGK6+1Z9VJ6hmQhLltyvlig049rAOrW4cl6y+OcSh9vj8qmG6
         xBVax+ag5f/dfj8yR17mKrax6p7klC3IXmyU3TRQwKonfV8wAINCzuj7ciAItRjKYNF2
         GhJvgJo072bbrheDnHbRWWeEmwY9aW732um1tICWuRVmelBkhbQCttvjI8W5JqyxxKRS
         d3jw==
X-Gm-Message-State: AJaThX43r9T3IxKlhkD9/7TCNoV4GOjuJDh7XrTy9pI21iTHnrb0f+35
        8Ssg6/g8GnNbLwnRS+RMzosaEA==
X-Google-Smtp-Source: AGs4zMZGWyEmOgpQ6NGX7vjul5X5K753SLPSs+gKG6P3MLbKO2FpzMCm1CFNWGk+24HkuS75umuLFw==
X-Received: by 10.84.130.67 with SMTP id 61mr171335plc.368.1510800078428;
        Wed, 15 Nov 2017 18:41:18 -0800 (PST)
Received: from localhost ([122.171.67.221])
        by smtp.gmail.com with ESMTPSA id t4sm98188pfj.56.2017.11.15.18.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Nov 2017 18:41:17 -0800 (PST)
Date:   Thu, 16 Nov 2017 08:11:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keguang Zhang <keguang.zhang@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] cpufreq: Add Loongson machine dependencies
Message-ID: <20171116024115.GP3257@vireshk-i7>
References: <20171115211755.25102-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171115211755.25102-1-james.hogan@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60968
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

On 15-11-17, 21:17, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> The MIPS loongson cpufreq drivers don't build unless configured for the
> correct machine type, due to dependency on machine specific architecture
> headers and symbols in machine specific platform code.
> 
> More specifically loongson1-cpufreq.c uses RST_CPU_EN and RST_CPU,
> neither of which is defined in asm/mach-loongson32/regs-clk.h unless
> CONFIG_LOONGSON1_LS1B=y, and loongson2_cpufreq.c references
> loongson2_clockmod_table[], which is only defined in
> arch/mips/loongson64/lemote-2f/clock.c, i.e. when
> CONFIG_LEMOTE_MACH2F=y.
> 
> Add these dependencies to Kconfig to avoid randconfig / allyesconfig
> build failures (e.g. when based on BMIPS which also has a cpufreq
> driver).
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/cpufreq/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 4ebae43118ef..d8addbce40bc 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -275,6 +275,7 @@ config BMIPS_CPUFREQ
>  
>  config LOONGSON2_CPUFREQ
>  	tristate "Loongson2 CPUFreq Driver"
> +	depends on LEMOTE_MACH2F
>  	help
>  	  This option adds a CPUFreq driver for loongson processors which
>  	  support software configurable cpu frequency.
> @@ -287,6 +288,7 @@ config LOONGSON2_CPUFREQ
>  
>  config LOONGSON1_CPUFREQ
>  	tristate "Loongson1 CPUFreq Driver"
> +	depends on LOONGSON1_LS1B
>  	help
>  	  This option adds a CPUFreq driver for loongson1 processors which
>  	  support software configurable cpu frequency.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
