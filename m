Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 09:05:06 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55213 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990829AbdH3HEWnNs7B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 09:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q50XmG15a9yvBttvbdMv6G0pwjLNFOG1QV/PUKUUn+o=; b=D3i3r4FLMcTl2zaM9PIC447arJ
        MtgfWkAhYNjohJRVKANDbbzjFC0dPLvvGdQGmUWnenT56BRMe3zVEtYzYjfxRVdkznFbUrl9h7b9m
        PFSDYfmj//Za5qTNp0VDadtdXij3BwxHrO3JRt+i/sHWkbw6jn2UX8RmQ/TeW7Ag3dEMyAKxB3+Z+
        83oiZVlQgK+AjF54QeZQhk8B1O0v5l4jv/pst9iGH/+jxc6zmExN4QoTbkk1JWQuI7N4KN9cWHGiv
        4CZYSkSZ8txCGIo8ci+t8b6NLmqtRjszc6THogwOXshru1VmOGjsgNpF/R0Ft4JyKDVROQgOXNrfH
        eC5u82Xw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53258 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1dmuhl-001yEV-Gm; Wed, 30 Aug 2017 04:34:18 +0000
Date:   Tue, 29 Aug 2017 21:34:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 8/8] watchdog: octeon-wdt: Add support for 78XX SOCs.
Message-ID: <20170830043416.GD14791@roeck-us.net>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-9-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504021238-3184-9-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Tue, Aug 29, 2017 at 10:40:38AM -0500, Steven J. Hill wrote:
> From: Carlos Munoz <carlos.munoz@caviumnetworks.com>
> 
> Signed-off-by: Carlos Munoz <carlos.munoz@caviumnetworks.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 133 ++++++++++++++++++++++++++++---------
>  1 file changed, 103 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index 410800f..0ec419a 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -70,6 +70,10 @@
>  #include <asm/octeon/octeon.h>
>  #include <asm/octeon/cvmx-boot-vector.h>
>  #include <asm/octeon/cvmx-ciu2-defs.h>
> +#include <asm/octeon/cvmx-rst-defs.h>
> +
> +/* Watchdog interrupt major block number (8 MSBs of intsn) */
> +#define WD_BLOCK_NUMBER		0x01
>  
>  static int divisor;
>  
> @@ -91,6 +95,8 @@ static cpumask_t irq_enabled_cpus;
>  
>  #define WD_TIMO 60			/* Default heartbeat = 60 seconds */
>  
> +#define CVMX_GSERX_SCRATCH(offset) (CVMX_ADD_IO_SEG(0x0001180090000020ull) + ((offset) & 15) * 0x1000000ull)
> +
>  static int heartbeat = WD_TIMO;
>  module_param(heartbeat, int, 0444);
>  MODULE_PARM_DESC(heartbeat,
> @@ -115,21 +121,12 @@ void octeon_wdt_nmi_stage2(void);
>  static int cpu2core(int cpu)
>  {
>  #ifdef CONFIG_SMP
> -	return cpu_logical_map(cpu);
> +	return cpu_logical_map(cpu) & 0x3f;
>  #else
>  	return cvmx_get_core_num();
>  #endif
>  }
>  
> -static int core2cpu(int coreid)
> -{
> -#ifdef CONFIG_SMP
> -	return cpu_number_map(coreid);
> -#else
> -	return 0;
> -#endif
> -}
> -
>  /**
>   * Poke the watchdog when an interrupt is received
>   *
> @@ -140,13 +137,14 @@ static int core2cpu(int coreid)
>   */
>  static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
>  {
> -	unsigned int core = cvmx_get_core_num();
> -	int cpu = core2cpu(core);
> +	int cpu = raw_smp_processor_id();
> +	unsigned int core = cpu2core(cpu);
> +	int node = cpu_to_node(cpu);
>  
>  	if (do_countdown) {
>  		if (per_cpu_countdown[cpu] > 0) {
>  			/* We're alive, poke the watchdog */
> -			cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> +			cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
>  			per_cpu_countdown[cpu]--;
>  		} else {
>  			/* Bad news, you are about to reboot. */
> @@ -155,7 +153,7 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
>  		}
>  	} else {
>  		/* Not open, just ping away... */
> -		cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> +		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
>  	}
>  	return IRQ_HANDLED;
>  }
> @@ -280,26 +278,74 @@ void octeon_wdt_nmi_stage3(u64 reg[32])
>  	}
>  
>  	octeon_wdt_write_string("*** Chip soft reset soon ***\r\n");
> +
> +	/*
> +	 * G-30204: We must trigger a soft reset before watchdog
> +	 * does an incomplete job of doing it.
> +	 */
> +	if (OCTEON_IS_OCTEON3() && !OCTEON_IS_MODEL(OCTEON_CN70XX)) {
> +		u64 scr;
> +		unsigned int node = cvmx_get_node_num();
> +		unsigned int lcore = cvmx_get_local_core_num();
> +		union cvmx_ciu_wdogx ciu_wdog;
> +
> +		/*
> +		 * Wait for other cores to print out information, but
> +		 * not too long.  Do the soft reset before watchdog
> +		 * can trigger it.
> +		 */
> +		do {
> +			ciu_wdog.u64 = cvmx_read_csr_node(node, CVMX_CIU_WDOGX(lcore));
> +		} while (ciu_wdog.s.cnt > 0x10000);
> +
> +		scr = cvmx_read_csr_node(0, CVMX_GSERX_SCRATCH(0));
> +		scr |= 1 << 11; /* Indicate watchdog in bit 11 */
> +		cvmx_write_csr_node(0, CVMX_GSERX_SCRATCH(0), scr);
> +		cvmx_write_csr_node(0, CVMX_RST_SOFT_RST, 1);
> +	}
> +}
> +
> +static int octeon_wdt_cpu_to_irq(int cpu)
> +{
> +	unsigned int coreid;
> +	int node;
> +	int irq;
> +
> +	coreid = cpu2core(cpu);
> +	node = cpu_to_node(cpu);
> +
> +	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> +		struct irq_domain *domain;
> +		int hwirq;
> +
> +		domain = octeon_irq_get_block_domain(node,
> +						     WD_BLOCK_NUMBER);
> +		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | coreid;
> +		irq = irq_find_mapping(domain, hwirq);
> +	} else {
> +		irq = OCTEON_IRQ_WDOG0 + coreid;
> +	}
> +	return irq;
>  }
>  
>  static int octeon_wdt_cpu_pre_down(unsigned int cpu)
>  {
>  	unsigned int core;
> -	unsigned int irq;
> +	int node;
>  	union cvmx_ciu_wdogx ciu_wdog;
>  
>  	core = cpu2core(cpu);
>  
> -	irq = OCTEON_IRQ_WDOG0 + core;
> +	node = cpu_to_node(cpu);
>  
>  	/* Poke the watchdog to clear out its state */
> -	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> +	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
>  
>  	/* Disable the hardware. */
>  	ciu_wdog.u64 = 0;
> -	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
> +	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
>  
> -	free_irq(irq, octeon_wdt_poke_irq);
> +	free_irq(octeon_wdt_cpu_to_irq(cpu), octeon_wdt_poke_irq);
>  	return 0;
>  }
>  
> @@ -308,33 +354,56 @@ static int octeon_wdt_cpu_online(unsigned int cpu)
>  	unsigned int core;
>  	unsigned int irq;
>  	union cvmx_ciu_wdogx ciu_wdog;
> +	int node;
> +	struct irq_domain *domain;
> +	int hwirq;
>  
>  	core = cpu2core(cpu);
> +	node = cpu_to_node(cpu);
>  
>  	octeon_wdt_bootvector[core].target_ptr = (u64)octeon_wdt_nmi_stage2;
>  
>  	/* Disable it before doing anything with the interrupts. */
>  	ciu_wdog.u64 = 0;
> -	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
> +	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
>  
>  	per_cpu_countdown[cpu] = countdown_reset;
>  
> -	irq = OCTEON_IRQ_WDOG0 + core;
> +	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> +		/* Must get the domain for the watchdog block */
> +		domain = octeon_irq_get_block_domain(node, WD_BLOCK_NUMBER);
> +
> +		/* Get a irq for the wd intsn (hardware interrupt) */
> +		hwirq = WD_BLOCK_NUMBER << 12 | 0x200 | core;
> +		irq = irq_create_mapping(domain, hwirq);
> +		irqd_set_trigger_type(irq_get_irq_data(irq),
> +				      IRQ_TYPE_EDGE_RISING);
> +	} else
> +		irq = OCTEON_IRQ_WDOG0 + core;
>  
>  	if (request_irq(irq, octeon_wdt_poke_irq,
>  			IRQF_NO_THREAD, "octeon_wdt", octeon_wdt_poke_irq))
>  		panic("octeon_wdt: Couldn't obtain irq %d", irq);
>  
> +	/* Must set the irq affinity here */
> +	if (octeon_has_feature(OCTEON_FEATURE_CIU3)) {
> +		cpumask_t mask;
> +
> +		cpumask_clear(&mask);
> +		cpumask_set_cpu(cpu, &mask);
> +		irq_set_affinity(irq, &mask);
> +	}
> +
>  	cpumask_set_cpu(cpu, &irq_enabled_cpus);
>  
>  	/* Poke the watchdog to clear out its state */
> -	cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> +	cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(core), 1);
>  
>  	/* Finally enable the watchdog now that all handlers are installed */
>  	ciu_wdog.u64 = 0;
>  	ciu_wdog.s.len = timeout_cnt;
>  	ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
> -	cvmx_write_csr(CVMX_CIU_WDOGX(core), ciu_wdog.u64);
> +	cvmx_write_csr_node(node, CVMX_CIU_WDOGX(core), ciu_wdog.u64);
>  
>  	return 0;
>  }
> @@ -343,20 +412,20 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
>  {
>  	int cpu;
>  	int coreid;
> +	int node;
>  
>  	if (disable)
>  		return 0;
>  
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
> -		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
> +		node = cpu_to_node(cpu);
> +		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
>  		per_cpu_countdown[cpu] = countdown_reset;
>  		if ((countdown_reset || !do_countdown) &&
>  		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
>  			/* We have to enable the irq */
> -			int irq = OCTEON_IRQ_WDOG0 + coreid;
> -
> -			enable_irq(irq);
> +			enable_irq(octeon_wdt_cpu_to_irq(cpu));
>  			cpumask_set_cpu(cpu, &irq_enabled_cpus);
>  		}
>  	}
> @@ -395,6 +464,7 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  	int cpu;
>  	int coreid;
>  	union cvmx_ciu_wdogx ciu_wdog;
> +	int node;
>  
>  	if (t <= 0)
>  		return -1;
> @@ -406,12 +476,13 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
> -		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
> +		node = cpu_to_node(cpu);
> +		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
>  		ciu_wdog.u64 = 0;
>  		ciu_wdog.s.len = timeout_cnt;
>  		ciu_wdog.s.mode = 3;	/* 3 = Interrupt + NMI + Soft-Reset */
> -		cvmx_write_csr(CVMX_CIU_WDOGX(coreid), ciu_wdog.u64);
> -		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
> +		cvmx_write_csr_node(node, CVMX_CIU_WDOGX(coreid), ciu_wdog.u64);
> +		cvmx_write_csr_node(node, CVMX_CIU_PP_POKEX(coreid), 1);
>  	}
>  	octeon_wdt_ping(wdog); /* Get the irqs back on. */
>  	return 0;
> @@ -467,6 +538,8 @@ static int __init octeon_wdt_init(void)
>  
>  	if (OCTEON_IS_MODEL(OCTEON_CN68XX))
>  		divisor = 0x200;
> +	else if (OCTEON_IS_MODEL(OCTEON_CN78XX))
> +		divisor = 0x400;
>  	else
>  		divisor = 0x100;
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
