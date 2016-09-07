Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2016 10:25:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18633 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992022AbcIGIZNz-Qph (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Sep 2016 10:25:13 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id CCE3088266811;
        Wed,  7 Sep 2016 09:24:54 +0100 (IST)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 7 Sep
 2016 09:24:57 +0100
Subject: Re: [PATCH 15/21] mips: octeon: smp: Convert to hotplug state machine
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-16-bigeasy@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <rt@linutronix.de>,
        <tglx@linutronix.de>, Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <6ef2674b-aca6-f45f-03b2-ec9aa9a5bf91@imgtec.com>
Date:   Wed, 7 Sep 2016 09:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160906170457.32393-16-bigeasy@linutronix.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

HI Sebastian,


On 06/09/16 18:04, Sebastian Andrzej Siewior wrote:
> Install the callbacks via the state machine.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   arch/mips/cavium-octeon/smp.c | 24 +++---------------------
>   include/linux/cpuhotplug.h    |  1 +
>   2 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 4d457d602d3b..228c1cab2912 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -380,29 +380,11 @@ static int octeon_update_boot_vector(unsigned int cpu)
>   	return 0;
>   }
>   
> -static int octeon_cpu_callback(struct notifier_block *nfb,
> -	unsigned long action, void *hcpu)
> -{
> -	unsigned int cpu = (unsigned long)hcpu;
> -
> -	switch (action & ~CPU_TASKS_FROZEN) {
> -	case CPU_UP_PREPARE:
> -		octeon_update_boot_vector(cpu);
> -		break;
> -	case CPU_ONLINE:
> -		pr_info("Cpu %d online\n", cpu);
> -		break;
> -	case CPU_DEAD:
> -		break;
> -	}
> -
> -	return NOTIFY_OK;
> -}
> -
>   static int register_cavium_notifier(void)
>   {
> -	hotcpu_notifier(octeon_cpu_callback, 0);
> -	return 0;
> +	return cpuhp_setup_state_nocalls(CPUHP_MIPS_CAVIUM_PREPARE,
> +					 "mips/cavium:prepare",
> +					 octeon_update_boot_vector, NULL);

This looks like a nice change which results in much cleaner code

>   }
>   late_initcall(register_cavium_notifier);
>   
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 4cbf88c955d6..058d312fdf6f 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -44,6 +44,7 @@ enum cpuhp_state {
>   	CPUHP_SH_SH3X_PREPARE,
>   	CPUHP_X86_MICRCODE_PREPARE,
>   	CPUHP_NOTF_ERR_INJ_PREPARE,
> +	CPUHP_MIPS_CAVIUM_PREPARE,

But I'm curious why we have to create a new state here - this is going 
to get very unwieldy if every variant of every architecture has to have 
it's own state values in that enumeration. Can this use, what I assume 
is (and perhaps could be documented better in 
include/linux/cpuhotplug.h), the generic prepare state CPUHP_NOTIFY_PREPARE?

Thanks,
Matt

>   	CPUHP_TIMERS_DEAD,
>   	CPUHP_BRINGUP_CPU,
>   	CPUHP_AP_IDLE_DEAD,
