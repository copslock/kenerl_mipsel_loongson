Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2016 12:55:31 +0200 (CEST)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36054 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992180AbcIHKzUyJGFj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Sep 2016 12:55:20 +0200
Received: by mail-wm0-f49.google.com with SMTP id b187so161585832wme.1
        for <linux-mips@linux-mips.org>; Thu, 08 Sep 2016 03:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=snBF2WGMce/7WZ0vCtHVeetKq4obosB6iFQ2pd6E+k0=;
        b=aiKI5pO7eI9bDj8xMo9awhPNe5Po0L87gIcT7u2XpRjooppG9O/xBTLjGeD7xnAsHt
         1QQ3fjZnPosCtBwPe2QTJpojy3I3usKxE+PjbWqjUdlSzSDemnTyBmzGSR04/a8O7auG
         T8kratflcmp9Mt10fqrghcUx7A9BKVW8geDSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=snBF2WGMce/7WZ0vCtHVeetKq4obosB6iFQ2pd6E+k0=;
        b=ERjNKBCzQVmpnMRVgoE1PwJq6tHcy4V1Out2L9/WISiYY3fpin3uvZgRFxuu7o6qj2
         qYTHExr51r6TB6n1tfrjzVqxORrN97kPr+HCf8Nzfo6gR2P0XeZxNtC9Pbi7YBSC/sij
         sx33FofEYMFUW3xlXf7qyvwzDzQ8+UVK4JnnLIYascp8XA+fKLEkK7PIH5WuYdMu84Kd
         LWqA5etFoIlW1T5QaWwfU01zYfShqCVQ+VmZeebcl2cS1wnrysrY74/QXj+7t1JqmmnE
         mVASM5ObD0SFvXRe5F0lUbPg3v7ydUdsT3woyJRLUZyo2NAFLKI/uoV082GQ+Avn20Cs
         ojfg==
X-Gm-Message-State: AE9vXwPngAyHdXCsOzKx/kCtLQdQ1u1Jt3r0VrAljGbHC+7CyYvxuoAifoJDktL8uhAVwES5
X-Received: by 10.28.165.83 with SMTP id o80mr300570wme.3.1473332115564;
        Thu, 08 Sep 2016 03:55:15 -0700 (PDT)
Received: from ?IPv6:2a01:e35:879a:6cd0:4cdd:4d81:26ad:bdec? ([2a01:e35:879a:6cd0:4cdd:4d81:26ad:bdec])
        by smtp.googlemail.com with ESMTPSA id n7sm31168348wjs.34.2016.09.08.03.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2016 03:55:15 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] cpuidle: cpuidle-cps: Enable use with MIPSr6
 CPUs.
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1473241520-14917-1-git-send-email-matt.redfearn@imgtec.com>
 <1473241520-14917-13-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f0e9df57-a19f-a94d-6cf8-60ea7c84a732@linaro.org>
Date:   Thu, 8 Sep 2016 12:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473241520-14917-13-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 07/09/2016 11:45, Matt Redfearn wrote:
> This patch enables the MIPS CPS driver for MIPSr6 CPUs.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> 

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v2: None
> 
>  drivers/cpuidle/Kconfig.mips  | 2 +-
>  drivers/cpuidle/cpuidle-cps.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
> index 4102be01d06a..512ee37b374b 100644
> --- a/drivers/cpuidle/Kconfig.mips
> +++ b/drivers/cpuidle/Kconfig.mips
> @@ -5,7 +5,7 @@ config MIPS_CPS_CPUIDLE
>  	bool "CPU Idle driver for MIPS CPS platforms"
>  	depends on CPU_IDLE && MIPS_CPS
>  	depends on SYS_SUPPORTS_MIPS_CPS
> -	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT || CPU_MIPSR6
>  	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select MIPS_CPS_PM
>  	default y
> diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
> index 1adb6980b707..926ba9871c62 100644
> --- a/drivers/cpuidle/cpuidle-cps.c
> +++ b/drivers/cpuidle/cpuidle-cps.c
> @@ -163,7 +163,7 @@ static int __init cps_cpuidle_init(void)
>  		core = cpu_data[cpu].core;
>  		device = &per_cpu(cpuidle_dev, cpu);
>  		device->cpu = cpu;
> -#ifdef CONFIG_MIPS_MT
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>  		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
>  #endif
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
