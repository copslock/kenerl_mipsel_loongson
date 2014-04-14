Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2014 17:04:29 +0200 (CEST)
Received: from mail-ee0-f42.google.com ([74.125.83.42]:60773 "EHLO
        mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825633AbaDNPEW5DpNg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Apr 2014 17:04:22 +0200
Received: by mail-ee0-f42.google.com with SMTP id d17so6760378eek.1
        for <multiple recipients>; Mon, 14 Apr 2014 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GLexJg8YMcEsfMeRJ+TGw/xfcyhL82yUFWGoU6jiJlE=;
        b=SCw124cbYM7QNR0CfVa59GtdG+ryBwLKy3UxmLFljXrno2RI/v0Rf3+huP8oLGPMFr
         Jzym3Zuez9ROyjuopAbeu6wDHlF7aRBIy6PA+ssIZdbkEsC2c3MUpzUns28TaCrfYvDS
         TxBUF1fSQab7W43Wlrlo0RIwKf5aMc5iFbw/xcqij39LrU0+pVx80Np8P8nt/bV1YrO/
         2sA8CnCGMx5jNhJa/fLvR3zfb4p3t75OFhemTmbtQeN972p5oDOiCNH0WsX7xHb7GmFL
         sZVozktSEHndn7MEsQn1ZcKzUxSg4yIuWnVK8cJ+QquJb8Og/lasN4ggd41lK8aPtipb
         9YWg==
X-Received: by 10.15.36.6 with SMTP id h6mr4630621eev.54.1397487857534;
        Mon, 14 Apr 2014 08:04:17 -0700 (PDT)
Received: from alberich ([2.171.76.237])
        by mx.google.com with ESMTPSA id m8sm41664290eeg.11.2014.04.14.08.04.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Apr 2014 08:04:16 -0700 (PDT)
Date:   Mon, 14 Apr 2014 17:04:13 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Subject: Re: [PATCH V2 2/8] MIPS: Support CPU topology files in sysfs
Message-ID: <20140414150413.GB10997@alberich>
References: <1397348662-22502-1-git-send-email-chenhc@lemote.com>
 <1397348662-22502-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1397348662-22502-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Sun, Apr 13, 2014 at 08:24:16AM +0800, Huacai Chen wrote:
> This patch is prepared for Loongson's NUMA support, it offer meaningful
> sysfs files such as physical_package_id, core_id, core_siblings and
> thread_siblings in /sys/devices/system/cpu/cpu?/topology.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Reviewed-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>


Thanks,
Andreas

> ---
>  arch/mips/include/asm/cpu-info.h |    1 +
>  arch/mips/include/asm/smp.h      |    6 ++++++
>  arch/mips/kernel/proc.c          |    1 +
>  arch/mips/kernel/smp.c           |   26 +++++++++++++++++++++++++-
>  4 files changed, 33 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
> index dc2135b..2dfa00b 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -61,6 +61,7 @@ struct cpuinfo_mips {
>  	struct cache_desc	scache; /* Secondary cache */
>  	struct cache_desc	tcache; /* Tertiary/split secondary cache */
>  	int			srsets; /* Shadow register sets */
> +	int			package;/* physical package number */
>  	int			core;	/* physical core number */
>  #ifdef CONFIG_64BIT
>  	int			vmbits; /* Virtual memory size in bits */
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index efa02ac..fea4051 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -22,6 +22,7 @@
>  
>  extern int smp_num_siblings;
>  extern cpumask_t cpu_sibling_map[];
> +extern cpumask_t cpu_core_map[];
>  
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
>  
> @@ -36,6 +37,11 @@ extern int __cpu_logical_map[NR_CPUS];
>  
>  #define NO_PROC_ID	(-1)
>  
> +#define topology_physical_package_id(cpu)	(cpu_data[cpu].package)
> +#define topology_core_id(cpu)			(cpu_data[cpu].core)
> +#define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
> +#define topology_thread_cpumask(cpu)		(&cpu_sibling_map[cpu])
> +
>  #define SMP_RESCHEDULE_YOURSELF 0x1	/* XXX braindead */
>  #define SMP_CALL_FUNCTION	0x2
>  /* Octeon - Tell another core to flush its icache */
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 037a44d..62c4439 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -123,6 +123,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		      cpu_data[n].srsets);
>  	seq_printf(m, "kscratch registers\t: %d\n",
>  		      hweight8(cpu_data[n].kscratch_mask));
> +	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
>  	seq_printf(m, "core\t\t\t: %d\n", cpu_data[n].core);
>  
>  	sprintf(fmt, "VCE%%c exceptions\t\t: %s\n",
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 0a022ee..0fa5429 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -63,9 +63,16 @@ EXPORT_SYMBOL(smp_num_siblings);
>  cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
>  EXPORT_SYMBOL(cpu_sibling_map);
>  
> +/* representing the core map of multi-core chips of each logical CPU */
> +cpumask_t cpu_core_map[NR_CPUS] __read_mostly;
> +EXPORT_SYMBOL(cpu_core_map);
> +
>  /* representing cpus for which sibling maps can be computed */
>  static cpumask_t cpu_sibling_setup_map;
>  
> +/* representing cpus for which core maps can be computed */
> +static cpumask_t cpu_core_setup_map;
> +
>  static inline void set_cpu_sibling_map(int cpu)
>  {
>  	int i;
> @@ -74,7 +81,8 @@ static inline void set_cpu_sibling_map(int cpu)
>  
>  	if (smp_num_siblings > 1) {
>  		for_each_cpu_mask(i, cpu_sibling_setup_map) {
> -			if (cpu_data[cpu].core == cpu_data[i].core) {
> +			if (cpu_data[cpu].package == cpu_data[i].package &&
> +				    cpu_data[cpu].core == cpu_data[i].core) {
>  				cpu_set(i, cpu_sibling_map[cpu]);
>  				cpu_set(cpu, cpu_sibling_map[i]);
>  			}
> @@ -83,6 +91,20 @@ static inline void set_cpu_sibling_map(int cpu)
>  		cpu_set(cpu, cpu_sibling_map[cpu]);
>  }
>  
> +static inline void set_cpu_core_map(int cpu)
> +{
> +	int i;
> +
> +	cpu_set(cpu, cpu_core_setup_map);
> +
> +	for_each_cpu_mask(i, cpu_core_setup_map) {
> +		if (cpu_data[cpu].package == cpu_data[i].package) {
> +			cpu_set(i, cpu_core_map[cpu]);
> +			cpu_set(cpu, cpu_core_map[i]);
> +		}
> +	}
> +}
> +
>  struct plat_smp_ops *mp_ops;
>  EXPORT_SYMBOL(mp_ops);
>  
> @@ -129,6 +151,7 @@ asmlinkage void start_secondary(void)
>  	set_cpu_online(cpu, true);
>  
>  	set_cpu_sibling_map(cpu);
> +	set_cpu_core_map(cpu);
>  
>  	cpu_set(cpu, cpu_callin_map);
>  
> @@ -183,6 +206,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  	current_thread_info()->cpu = 0;
>  	mp_ops->prepare_cpus(max_cpus);
>  	set_cpu_sibling_map(0);
> +	set_cpu_core_map(0);
>  #ifndef CONFIG_HOTPLUG_CPU
>  	init_cpu_present(cpu_possible_mask);
>  #endif
> -- 
> 1.7.7.3
> 
> 
