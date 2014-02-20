Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 09:52:35 +0100 (CET)
Received: from mail-wg0-f51.google.com ([74.125.82.51]:48204 "EHLO
        mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871352AbaBTIwdHqf0J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 09:52:33 +0100
Received: by mail-wg0-f51.google.com with SMTP id n12so1218400wgh.30
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 00:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=q9vFQ1IxDnpcPz9TCKqVli1t/Bqa7/GA0Dibb/hT2hQ=;
        b=BZ+94GY0UqqenC49xCOMn/9Q/Z2kt3eVkx4i57ZjNXSVnUj3BWWbWT+baLx99K5uCC
         ZXw1tPRqC8NLEESjdjInrUMNnpe85jxCl2qdjXDw+dV3yeI5KkVMNexM0bwvIopt4ZoT
         +8AwrPz0R52AZc/wGehKmNuuinAJ1ta58RyWBz3KlNENUSnn/B9dtWr2I9Mn8NAeHHce
         0MX3dv7k7huUYwWslPqSUnkDT7CctG8Rfzk9F+T9WwFvYk4S8BcOO43Z0kSZdbiSEk+g
         kEHawrtpfWtsD4QpoOZtME+sYgy7OcXmXkdCon2C/PJnxGI+awAHAb6vK7uOi33GK8pz
         8OHw==
X-Gm-Message-State: ALoCoQnTbW0rYPlwZDQVsyDscyq/8hsbeOVDLadMhmM02rh7ukzGrnQyEr5s+fn3NV7+yFENm5CI
X-Received: by 10.180.185.232 with SMTP id ff8mr1217108wic.25.1392886347613;
        Thu, 20 Feb 2014 00:52:27 -0800 (PST)
Received: from [192.168.1.150] (AToulouse-654-1-343-25.w90-55.abo.wanadoo.fr. [90.55.62.25])
        by mx.google.com with ESMTPSA id fm3sm59522136wib.8.2014.02.20.00.52.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Feb 2014 00:52:26 -0800 (PST)
Message-ID: <5305C24A.1070006@linaro.org>
Date:   Thu, 20 Feb 2014 09:52:26 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/10] MIPS: support use of cpuidle
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1389794137-11361-9-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39348
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

On 01/15/2014 02:55 PM, Paul Burton wrote:
> This patch lays the groundwork for MIPS platforms to make use of the
> cpuidle framework. The arch_cpu_idle function simply calls cpuidle &
> falls back to the regular cpu_wait path if cpuidle should fail (eg. if
> it's not selected or no driver is registered). A generic cpuidle state
> for the wait instruction is introduced, intended to ease use of the wait
> instruction from cpuidle drivers and reduce code duplication.

Hi,

What is the status of this patchset ? Still need comments ?

Thanks
   -- Daniel

>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   arch/mips/Kconfig            |  2 ++
>   arch/mips/include/asm/idle.h | 14 ++++++++++++++
>   arch/mips/kernel/idle.c      | 20 +++++++++++++++++++-
>   3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 5bc27c0..95f2f11 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1838,6 +1838,8 @@ config CPU_R4K_CACHE_TLB
>   	bool
>   	default y if !(CPU_R3000 || CPU_R8000 || CPU_SB1 || CPU_TX39XX || CPU_CAVIUM_OCTEON)
>
> +source "drivers/cpuidle/Kconfig"
> +
>   choice
>   	prompt "MIPS MT options"
>
> diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/idle.h
> index d192158..d9f932d 100644
> --- a/arch/mips/include/asm/idle.h
> +++ b/arch/mips/include/asm/idle.h
> @@ -1,6 +1,7 @@
>   #ifndef __ASM_IDLE_H
>   #define __ASM_IDLE_H
>
> +#include <linux/cpuidle.h>
>   #include <linux/linkage.h>
>
>   extern void (*cpu_wait)(void);
> @@ -20,4 +21,17 @@ static inline int address_is_in_r4k_wait_irqoff(unsigned long addr)
>   	       addr < (unsigned long)__pastwait;
>   }
>
> +extern int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> +				   struct cpuidle_driver *drv, int index);
> +
> +#define MIPS_CPUIDLE_WAIT_STATE {\
> +	.enter			= mips_cpuidle_wait_enter,\
> +	.exit_latency		= 1,\
> +	.target_residency	= 1,\
> +	.power_usage		= UINT_MAX,\
> +	.flags			= CPUIDLE_FLAG_TIME_VALID,\
> +	.name			= "wait",\
> +	.desc			= "MIPS wait",\
> +}
> +
>   #endif /* __ASM_IDLE_H  */
> diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
> index 3553243..64e91e4 100644
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -11,6 +11,7 @@
>    * as published by the Free Software Foundation; either version
>    * 2 of the License, or (at your option) any later version.
>    */
> +#include <linux/cpuidle.h>
>   #include <linux/export.h>
>   #include <linux/init.h>
>   #include <linux/irqflags.h>
> @@ -239,7 +240,7 @@ static void smtc_idle_hook(void)
>   #endif
>   }
>
> -void arch_cpu_idle(void)
> +static void mips_cpu_idle(void)
>   {
>   	smtc_idle_hook();
>   	if (cpu_wait)
> @@ -247,3 +248,20 @@ void arch_cpu_idle(void)
>   	else
>   		local_irq_enable();
>   }
> +
> +void arch_cpu_idle(void)
> +{
> +	if (cpuidle_idle_call())
> +		mips_cpu_idle();
> +}
> +
> +#ifdef CONFIG_CPU_IDLE
> +
> +int mips_cpuidle_wait_enter(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index)
> +{
> +	mips_cpu_idle();
> +	return index;
> +}
> +
> +#endif
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
