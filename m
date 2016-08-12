Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 05:18:20 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:58510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992477AbcHLDSMdTA3w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2016 05:18:12 +0200
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 397191556C;
        Fri, 12 Aug 2016 03:18:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (vpn1-4-20.pek2.redhat.com [10.72.4.20])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7C3Hu95011470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2016 23:17:59 -0400
Date:   Fri, 12 Aug 2016 11:17:55 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Baoquan He <bhe@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>, x86@kernel.org,
        David Daney <david.daney@cavium.com>,
        Xunlei Pang <xpang@redhat.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        linux-mips@linux-mips.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven J. Hill" <steven.hill@cavium.com>,
        xen-devel@lists.xenproject.org, Daniel Walker <dwalker@fifo99.com>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [V4 PATCH 2/2] mips/panic: Replace smp_send_stop() with kdump
 friendly version in panic path
Message-ID: <20160812031755.GB2983@dhcp-128-65.nay.redhat.com>
References: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
 <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160810080950.11028.28000.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 12 Aug 2016 03:18:06 +0000 (UTC)
Return-Path: <dyoung@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dyoung@redhat.com
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

On 08/10/16 at 05:09pm, Hidehiro Kawai wrote:
> Daniel Walker reported problems which happens when
> crash_kexec_post_notifiers kernel option is enabled
> (https://lkml.org/lkml/2015/6/24/44).
> 
> In that case, smp_send_stop() is called before entering kdump routines
> which assume other CPUs are still online.  As the result, kdump
> routines fail to save other CPUs' registers.  Additionally for MIPS
> OCTEON, it misses to stop the watchdog timer.
> 
> To fix this problem, call a new kdump friendly function,
> crash_smp_send_stop(), instead of the smp_send_stop() when
> crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
> weak function, and it just call smp_send_stop().  Architecture
> codes should override it so that kdump can work appropriately.
> This patch provides MIPS version.
> 
> Reported-by: Daniel Walker <dwalker@fifo99.com>
> Fixes: f06e5153f4ae (kernel/panic.c: add "crash_kexec_post_notifiers" option)
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: David Daney <david.daney@cavium.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: "Steven J. Hill" <steven.hill@cavium.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> 
> ---
> I'm not familiar with MIPS, and I don't have a test environment and
> just did build tests only.  Please don't apply this patch until
> someone does enough tests, otherwise simply drop this patch.
> ---
>  arch/mips/cavium-octeon/setup.c  |   14 ++++++++++++++
>  arch/mips/include/asm/kexec.h    |    1 +
>  arch/mips/kernel/crash.c         |   18 +++++++++++++++++-
>  arch/mips/kernel/machine_kexec.c |    1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cb16fcc..5537f95 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -267,6 +267,17 @@ static void octeon_crash_shutdown(struct pt_regs *regs)
>  	default_machine_crash_shutdown(regs);
>  }
>  
> +#ifdef CONFIG_SMP
> +void octeon_crash_smp_send_stop(void)
> +{
> +	int cpu;
> +
> +	/* disable watchdogs */
> +	for_each_online_cpu(cpu)
> +		cvmx_write_csr(CVMX_CIU_WDOGX(cpu_logical_map(cpu)), 0);
> +}
> +#endif
> +
>  #endif /* CONFIG_KEXEC */
>  
>  #ifdef CONFIG_CAVIUM_RESERVE32
> @@ -911,6 +922,9 @@ void __init prom_init(void)
>  	_machine_kexec_shutdown = octeon_shutdown;
>  	_machine_crash_shutdown = octeon_crash_shutdown;
>  	_machine_kexec_prepare = octeon_kexec_prepare;
> +#ifdef CONFIG_SMP
> +	_crash_smp_send_stop = octeon_crash_smp_send_stop;
> +#endif
>  #endif
>  
>  	octeon_user_io_init();
> diff --git a/arch/mips/include/asm/kexec.h b/arch/mips/include/asm/kexec.h
> index ee25ebb..493a3cc 100644
> --- a/arch/mips/include/asm/kexec.h
> +++ b/arch/mips/include/asm/kexec.h
> @@ -45,6 +45,7 @@ extern const unsigned char kexec_smp_wait[];
>  extern unsigned long secondary_kexec_args[4];
>  extern void (*relocated_kexec_smp_wait) (void *);
>  extern atomic_t kexec_ready_to_reboot;
> +extern void (*_crash_smp_send_stop)(void);
>  #endif
>  #endif
>  
> diff --git a/arch/mips/kernel/crash.c b/arch/mips/kernel/crash.c
> index 610f0f3..1723b17 100644
> --- a/arch/mips/kernel/crash.c
> +++ b/arch/mips/kernel/crash.c
> @@ -47,9 +47,14 @@ static void crash_shutdown_secondary(void *passed_regs)
>  
>  static void crash_kexec_prepare_cpus(void)
>  {
> +	static int cpus_stopped;
>  	unsigned int msecs;
> +	unsigned int ncpus;
>  
> -	unsigned int ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
> +	if (cpus_stopped)
> +		return;
> +
> +	ncpus = num_online_cpus() - 1;/* Excluding the panic cpu */
>  
>  	dump_send_ipi(crash_shutdown_secondary);
>  	smp_wmb();
> @@ -64,6 +69,17 @@ static void crash_kexec_prepare_cpus(void)
>  		cpu_relax();
>  		mdelay(1);
>  	}
> +
> +	cpus_stopped = 1;
> +}
> +
> +/* Override the weak function in kernel/panic.c */
> +void crash_smp_send_stop(void)
> +{
> +	if (_crash_smp_send_stop)
> +		_crash_smp_send_stop();
> +
> +	crash_kexec_prepare_cpus();
>  }
>  
>  #else /* !defined(CONFIG_SMP)  */
> diff --git a/arch/mips/kernel/machine_kexec.c b/arch/mips/kernel/machine_kexec.c
> index 50980bf3..5972520 100644
> --- a/arch/mips/kernel/machine_kexec.c
> +++ b/arch/mips/kernel/machine_kexec.c
> @@ -25,6 +25,7 @@ void (*_machine_crash_shutdown)(struct pt_regs *regs) = NULL;
>  #ifdef CONFIG_SMP
>  void (*relocated_kexec_smp_wait) (void *);
>  atomic_t kexec_ready_to_reboot = ATOMIC_INIT(0);
> +void (*_crash_smp_send_stop)(void) = NULL;
>  #endif
>  
>  int
> 
> 

Can any mips people review this patch and have a test?

Thanks
Dave
