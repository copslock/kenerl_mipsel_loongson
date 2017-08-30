Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2017 09:05:58 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55213 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993935AbdH3HEfoS13B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2017 09:04:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lMp5vmZe9jWoDFCkt3rK6zMnKJeC19VfKgOSbtGoJnc=; b=5UWvmPTFXvVBRWLEu9roQYb1jT
        359ezOpeV0em0EXDr/KOx/vQ3vg2BiFeVIAw8NHtGvnspVegGXj1MZZDEUARIm6zXCSIkbQs498fU
        t/fYLedK095aT6+7EU+tIiXpqdLqX9S3OF2f7VlzOi3t8sM/gSzsr/BUszMZdPAYDHimaVHJsyJoE
        DTrg6hfLngxqUXkxe3DNaJEd6x4o5wrIY4pPU/+x+v9aKPmLt/CyHMs7BqXug5cKYCBkmbddYDEcB
        hEzoeMkRawAH1DNbhqXLS4yKiIsTEOQINUjaMK4bTc0qN78bAbFFQuBfeaOsn5pCFdke96WdNU3Ds
        sI0VllEw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53250 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1dmuhK-001xLa-EC; Wed, 30 Aug 2017 04:33:52 +0000
Date:   Tue, 29 Aug 2017 21:33:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 6/8] watchdog: octeon-wdt: File cleaning.
Message-ID: <20170830043349.GB14791@roeck-us.net>
References: <1504021238-3184-1-git-send-email-steven.hill@cavium.com>
 <1504021238-3184-7-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504021238-3184-7-git-send-email-steven.hill@cavium.com>
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
X-archive-position: 59889
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

On Tue, Aug 29, 2017 at 10:40:36AM -0500, Steven J. Hill wrote:
> From: "Steven J. Hill" <Steven.Hill@cavium.com>
> 
> * Update copyright and company name.
> * Remove unused headers.
> * Fix variable spelling and data type.
> * Use octal values for module parameters.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/octeon-wdt-main.c | 45 +++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
> index fbdd484..73b5102 100644
> --- a/drivers/watchdog/octeon-wdt-main.c
> +++ b/drivers/watchdog/octeon-wdt-main.c
> @@ -1,7 +1,7 @@
>  /*
>   * Octeon Watchdog driver
>   *
> - * Copyright (C) 2007, 2008, 2009, 2010 Cavium Networks
> + * Copyright (C) 2007-2017 Cavium, Inc.
>   *
>   * Converted to use WATCHDOG_CORE by Aaro Koskinen <aaro.koskinen@iki.fi>.
>   *
> @@ -59,14 +59,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/watchdog.h>
>  #include <linux/cpumask.h>
> -#include <linux/bitops.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
> -#include <linux/smp.h>
> -#include <linux/fs.h>
>  #include <linux/irq.h>
>  
>  #include <asm/mipsregs.h>
> @@ -85,7 +80,7 @@ static unsigned int max_timeout_sec;
>  static unsigned int timeout_sec;
>  
>  /* Set to non-zero when userspace countdown mode active */
> -static int do_coundown;
> +static bool do_countdown;
>  static unsigned int countdown_reset;
>  static unsigned int per_cpu_countdown[NR_CPUS];
>  
> @@ -94,17 +89,22 @@ static cpumask_t irq_enabled_cpus;
>  #define WD_TIMO 60			/* Default heartbeat = 60 seconds */
>  
>  static int heartbeat = WD_TIMO;
> -module_param(heartbeat, int, S_IRUGO);
> +module_param(heartbeat, int, 0444);
>  MODULE_PARM_DESC(heartbeat,
>  	"Watchdog heartbeat in seconds. (0 < heartbeat, default="
>  				__MODULE_STRING(WD_TIMO) ")");
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
> -module_param(nowayout, bool, S_IRUGO);
> +module_param(nowayout, bool, 0444);
>  MODULE_PARM_DESC(nowayout,
>  	"Watchdog cannot be stopped once started (default="
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>  
> +static int disable;
> +module_param(disable, int, 0444);
> +MODULE_PARM_DESC(disable,
> +	"Disable the watchdog entirely (default=0)");
> +
>  static struct cvmx_boot_vector_element *octeon_wdt_bootvector;
>  
>  void octeon_wdt_nmi_stage2(void);
> @@ -140,7 +140,7 @@ static irqreturn_t octeon_wdt_poke_irq(int cpl, void *dev_id)
>  	unsigned int core = cvmx_get_core_num();
>  	int cpu = core2cpu(core);
>  
> -	if (do_coundown) {
> +	if (do_countdown) {
>  		if (per_cpu_countdown[cpu] > 0) {
>  			/* We're alive, poke the watchdog */
>  			cvmx_write_csr(CVMX_CIU_PP_POKEX(core), 1);
> @@ -324,11 +324,14 @@ static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
>  	int cpu;
>  	int coreid;
>  
> +	if (disable)
> +		return 0;
> +
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
>  		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
>  		per_cpu_countdown[cpu] = countdown_reset;
> -		if ((countdown_reset || !do_coundown) &&
> +		if ((countdown_reset || !do_countdown) &&
>  		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
>  			/* We have to enable the irq */
>  			int irq = OCTEON_IRQ_WDOG0 + coreid;
> @@ -378,6 +381,9 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  
>  	octeon_wdt_calc_parameters(t);
>  
> +	if (disable)
> +		return 0;
> +
>  	for_each_online_cpu(cpu) {
>  		coreid = cpu2core(cpu);
>  		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
> @@ -394,13 +400,13 @@ static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
>  static int octeon_wdt_start(struct watchdog_device *wdog)
>  {
>  	octeon_wdt_ping(wdog);
> -	do_coundown = 1;
> +	do_countdown = 1;
>  	return 0;
>  }
>  
>  static int octeon_wdt_stop(struct watchdog_device *wdog)
>  {
> -	do_coundown = 0;
> +	do_countdown = 0;
>  	octeon_wdt_ping(wdog);
>  	return 0;
>  }
> @@ -473,6 +479,11 @@ static int __init octeon_wdt_init(void)
>  		return ret;
>  	}
>  
> +	if (disable) {
> +		pr_notice("disabled\n");
> +		return 0;
> +	}
> +
>  	cpumask_clear(&irq_enabled_cpus);
>  
>  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "watchdog/octeon:online",
> @@ -493,6 +504,10 @@ static int __init octeon_wdt_init(void)
>  static void __exit octeon_wdt_cleanup(void)
>  {
>  	watchdog_unregister_device(&octeon_wdt);
> +
> +	if (disable)
> +		return;
> +
>  	cpuhp_remove_state(octeon_wdt_online);
>  
>  	/*
> @@ -503,7 +518,7 @@ static void __exit octeon_wdt_cleanup(void)
>  }
>  
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Cavium Networks <support@caviumnetworks.com>");
> -MODULE_DESCRIPTION("Cavium Networks Octeon Watchdog driver.");
> +MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
> +MODULE_DESCRIPTION("Cavium Inc. OCTEON Watchdog driver.");
>  module_init(octeon_wdt_init);
>  module_exit(octeon_wdt_cleanup);
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
