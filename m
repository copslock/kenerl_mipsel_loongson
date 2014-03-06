Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 03:24:10 +0100 (CET)
Received: from e39.co.us.ibm.com ([32.97.110.160]:59074 "EHLO
        e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825493AbaCFCYHp512v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2014 03:24:07 +0100
Received: from /spool/local
        by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <preeti@linux.vnet.ibm.com>;
        Wed, 5 Mar 2014 19:24:00 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
        by e39.co.us.ibm.com (192.168.1.139) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Wed, 5 Mar 2014 19:23:59 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 6779119D8036
        for <linux-mips@linux-mips.org>; Wed,  5 Mar 2014 19:23:56 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
        by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s262Nwu39961862
        for <linux-mips@linux-mips.org>; Thu, 6 Mar 2014 03:23:58 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
        by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s262Nuoq014205
        for <linux-mips@linux-mips.org>; Wed, 5 Mar 2014 19:23:58 -0700
Received: from [9.124.31.42] (preeti.in.ibm.com [9.124.31.42])
        by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id s262Nqo4013862;
        Wed, 5 Mar 2014 19:23:53 -0700
Message-ID: <5317DB5B.60109@linux.vnet.ibm.com>
Date:   Thu, 06 Mar 2014 07:50:11 +0530
From:   Preeti U Murthy <preeti@linux.vnet.ibm.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] sched: Remove unused mc_capable() and smt_capable()
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com> <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140304210737.16893.54289.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 14030602-9332-0000-0000-000000071326
Return-Path: <preeti@linux.vnet.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: preeti@linux.vnet.ibm.com
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

On 03/05/2014 02:37 AM, Bjorn Helgaas wrote:
> Remove mc_capable() and smt_capable().  Neither is used.
> 
> Both were added by 5c45bf279d37 ("sched: mc/smt power savings sched
> policy").  Uses of both were removed by 8e7fbcbc22c1 ("sched: Remove stale
> power aware scheduling remnants and dysfunctional knobs").
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm/include/asm/topology.h      |    3 ---
>  arch/ia64/include/asm/topology.h     |    1 -
>  arch/mips/include/asm/topology.h     |    4 ----
>  arch/powerpc/include/asm/topology.h  |    1 -
>  arch/sparc/include/asm/topology_64.h |    2 --
>  arch/x86/include/asm/topology.h      |    6 ------
>  6 files changed, 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
> index 58b8b84adcd2..2fe85fff5cca 100644
> --- a/arch/arm/include/asm/topology.h
> +++ b/arch/arm/include/asm/topology.h
> @@ -20,9 +20,6 @@ extern struct cputopo_arm cpu_topology[NR_CPUS];
>  #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
>  #define topology_thread_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
>  
> -#define mc_capable()	(cpu_topology[0].socket_id != -1)
> -#define smt_capable()	(cpu_topology[0].thread_id != -1)
> -
>  void init_cpu_topology(void);
>  void store_cpu_topology(unsigned int cpuid);
>  const struct cpumask *cpu_coregroup_mask(int cpu);
> diff --git a/arch/ia64/include/asm/topology.h b/arch/ia64/include/asm/topology.h
> index a2496e449b75..5cb55a1e606b 100644
> --- a/arch/ia64/include/asm/topology.h
> +++ b/arch/ia64/include/asm/topology.h
> @@ -77,7 +77,6 @@ void build_cpu_to_node_map(void);
>  #define topology_core_id(cpu)			(cpu_data(cpu)->core_id)
>  #define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
>  #define topology_thread_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
> -#define smt_capable() 				(smp_num_siblings > 1)
>  #endif
>  
>  extern void arch_fix_phys_package_id(int num, u32 slot);
> diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
> index 12609a17dc8b..20ea4859c822 100644
> --- a/arch/mips/include/asm/topology.h
> +++ b/arch/mips/include/asm/topology.h
> @@ -10,8 +10,4 @@
>  
>  #include <topology.h>
>  
> -#ifdef CONFIG_SMP
> -#define smt_capable()	(smp_num_siblings > 1)
> -#endif
> -
>  #endif /* __ASM_TOPOLOGY_H */
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index d0b5fca6b077..c9202151079f 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -99,7 +99,6 @@ static inline int prrn_is_enabled(void)
>  
>  #ifdef CONFIG_SMP
>  #include <asm/cputable.h>
> -#define smt_capable()		(cpu_has_feature(CPU_FTR_SMT))
>  
>  #ifdef CONFIG_PPC64
>  #include <asm/smp.h>
> diff --git a/arch/sparc/include/asm/topology_64.h b/arch/sparc/include/asm/topology_64.h
> index 1754390a426f..a2d10fc64faf 100644
> --- a/arch/sparc/include/asm/topology_64.h
> +++ b/arch/sparc/include/asm/topology_64.h
> @@ -42,8 +42,6 @@ static inline int pcibus_to_node(struct pci_bus *pbus)
>  #define topology_core_id(cpu)			(cpu_data(cpu).core_id)
>  #define topology_core_cpumask(cpu)		(&cpu_core_map[cpu])
>  #define topology_thread_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
> -#define mc_capable()				(sparc64_multi_core)
> -#define smt_capable()				(sparc64_multi_core)
>  #endif /* CONFIG_SMP */
>  
>  extern cpumask_t cpu_core_map[NR_CPUS];
> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index d35f24e231cd..9bcc724cafdd 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -133,12 +133,6 @@ static inline void arch_fix_phys_package_id(int num, u32 slot)
>  struct pci_bus;
>  void x86_pci_root_bus_resources(int bus, struct list_head *resources);
>  
> -#ifdef CONFIG_SMP
> -#define mc_capable()	((boot_cpu_data.x86_max_cores > 1) && \
> -			(cpumask_weight(cpu_core_mask(0)) != nr_cpu_ids))
> -#define smt_capable()			(smp_num_siblings > 1)
> -#endif
> -
>  #ifdef CONFIG_NUMA
>  extern int get_mp_bus_to_node(int busnum);
>  extern void set_mp_bus_to_node(int busnum, int node);
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
