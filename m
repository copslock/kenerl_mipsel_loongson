Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Jun 2013 05:27:09 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:59902 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818006Ab3F0D1AvutWd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Jun 2013 05:27:00 +0200
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5R3QsUb028389
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 26 Jun 2013 20:26:54 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.146.65) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.2.342.3; Wed, 26 Jun 2013
 20:26:52 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id 31E13E1D350; Wed,
 26 Jun 2013 23:27:41 -0400 (EDT)
Date:   Wed, 26 Jun 2013 23:27:41 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: MIPS __cpuinit patch
Message-ID: <20130627032740.GC3297@windriver.com>
References: <20130626193113.GA24267@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20130626193113.GA24267@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[MIPS __cpuinit patch] On 26/06/2013 (Wed 21:31) Ralf Baechle wrote:

> Hi Paul,
> 
> below I'm sending you the patch to nuke __cpuinit which I still had
> locally.  It's aainst rc5 and based on the following of your patches:
> 
>     http://patchwork.linux-mips.org/patch/5494/
>     http://patchwork.linux-mips.org/patch/5495/
>     http://patchwork.linux-mips.org/patch/5509/
> 
> Since you are carrying the patch to make __cpuinit a no-op and this
> patch should be applied after it I suggest you should merge it upstream.

Yes, I re-added it from the last version in your mips-next and refreshed
accordingly earlier this morning, so it has all your patchwork links and
similar info present.  I'll keep it up to date from here to the end of
the merge window.

Thanks for being an early tester and for the vmlinux.lds patch.

Paul.
--

> 
> Thanks,
> 
>   Ralf
> 
> MIPS: Delete __cpuinit/__CPUINIT usage from MIPS code
> 
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
> 
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
> 
> Note that some harmless section mismatch warnings may result, since
> notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
> and are flagged as __cpuinit  -- so if we remove the __cpuinit from
> the arch specific callers, we will also get section mismatch warnings.
> As an intermediate step, we intend to turn the linux/init.h cpuinit
> related content into no-ops as early as possible, since that will get
> rid of these warnings.  In any case, they are temporary and harmless.
> 
> Here, we remove all the MIPS __cpuinit from C code and __CPUINIT
> from asm files.  MIPS is interesting in this respect, because there
> are also uasm users hiding behind their own renamed versions of the
> __cpuinit macros.
> 
> [1] https://lkml.org/lkml/2013/5/20/589
> 
> [ralf@linux-mips.org: Folded in Paul's followup fixes.]
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: linux-mips@linux-mips.org
> Patchwork: https://patchwork.linux-mips.org/patch/5494/
> Patchwork: https://patchwork.linux-mips.org/patch/5495/
> Patchwork: https://patchwork.linux-mips.org/patch/5509/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> ---
>  arch/mips/ath79/setup.c               |   2 +-
>  arch/mips/cavium-octeon/octeon-irq.c  |  12 +--
>  arch/mips/cavium-octeon/smp.c         |   6 +-
>  arch/mips/include/asm/uasm.h          |  37 +++------
>  arch/mips/kernel/bmips_vec.S          |   4 -
>  arch/mips/kernel/cevt-bcm1480.c       |   2 +-
>  arch/mips/kernel/cevt-gic.c           |   2 +-
>  arch/mips/kernel/cevt-r4k.c           |   2 +-
>  arch/mips/kernel/cevt-sb1250.c        |   2 +-
>  arch/mips/kernel/cevt-smtc.c          |   2 +-
>  arch/mips/kernel/cpu-bugs64.c         |   2 +-
>  arch/mips/kernel/cpu-probe.c          |  14 ++--
>  arch/mips/kernel/head.S               |   4 -
>  arch/mips/kernel/smp-bmips.c          |   6 +-
>  arch/mips/kernel/smp-mt.c             |   6 +-
>  arch/mips/kernel/smp-up.c             |   6 +-
>  arch/mips/kernel/smp.c                |   6 +-
>  arch/mips/kernel/smtc.c               |   2 +-
>  arch/mips/kernel/spram.c              |  14 ++--
>  arch/mips/kernel/sync-r4k.c           |  12 +--
>  arch/mips/kernel/traps.c              |  12 +--
>  arch/mips/kernel/watch.c              |   2 +-
>  arch/mips/lantiq/irq.c                |   2 +-
>  arch/mips/lib/uncached.c              |   2 +-
>  arch/mips/mm/c-octeon.c               |   6 +-
>  arch/mips/mm/c-r3k.c                  |   8 +-
>  arch/mips/mm/c-r4k.c                  |  34 ++++----
>  arch/mips/mm/c-tx39.c                 |   2 +-
>  arch/mips/mm/cache.c                  |   2 +-
>  arch/mips/mm/cex-sb1.S                |   4 -
>  arch/mips/mm/page.c                   |  40 +++++-----
>  arch/mips/mm/sc-ip22.c                |   2 +-
>  arch/mips/mm/sc-mips.c                |   2 +-
>  arch/mips/mm/sc-r5k.c                 |   2 +-
>  arch/mips/mm/sc-rm7k.c                |  12 +--
>  arch/mips/mm/tlb-r3k.c                |   2 +-
>  arch/mips/mm/tlb-r4k.c                |   4 +-
>  arch/mips/mm/tlb-r8k.c                |   4 +-
>  arch/mips/mm/tlbex.c                  | 144 ++++++++++++++++------------------
>  arch/mips/mm/uasm-micromips.c         |  10 +--
>  arch/mips/mm/uasm-mips.c              |  10 +--
>  arch/mips/mm/uasm.c                   | 106 ++++++++++++-------------
>  arch/mips/mti-malta/malta-smtc.c      |   6 +-
>  arch/mips/mti-malta/malta-time.c      |   2 +-
>  arch/mips/mti-sead3/sead3-time.c      |   2 +-
>  arch/mips/netlogic/common/smp.c       |   4 +-
>  arch/mips/netlogic/common/smpboot.S   |   4 -
>  arch/mips/netlogic/common/time.c      |   2 +-
>  arch/mips/netlogic/xlr/wakeup.c       |   2 +-
>  arch/mips/pci/pci-ip27.c              |   2 +-
>  arch/mips/pmcs-msp71xx/msp_smtc.c     |   7 +-
>  arch/mips/pmcs-msp71xx/msp_time.c     |   2 +-
>  arch/mips/pnx833x/common/interrupts.c |   2 +-
>  arch/mips/powertv/time.c              |   2 +-
>  arch/mips/ralink/irq.c                |   2 +-
>  arch/mips/sgi-ip27/ip27-init.c        |   4 +-
>  arch/mips/sgi-ip27/ip27-smp.c         |   6 +-
>  arch/mips/sgi-ip27/ip27-timer.c       |   6 +-
>  arch/mips/sgi-ip27/ip27-xtalk.c       |   6 +-
>  arch/mips/sibyte/bcm1480/smp.c        |   8 +-
>  arch/mips/sibyte/sb1250/smp.c         |   8 +-
>  61 files changed, 294 insertions(+), 338 deletions(-)
> 
> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index 8be4e85..80f4ecd 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -182,7 +182,7 @@ const char *get_system_type(void)
>  	return ath79_sys_type;
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	return CP0_LEGACY_COMPARE_IRQ;
>  }
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index a22f06a..c801d31 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -1095,7 +1095,7 @@ static void octeon_irq_ip3_ciu(void)
>  
>  static bool octeon_irq_use_ip4;
>  
> -static void __cpuinit octeon_irq_local_enable_ip4(void *arg)
> +static void octeon_irq_local_enable_ip4(void *arg)
>  {
>  	set_c0_status(STATUSF_IP4);
>  }
> @@ -1110,21 +1110,21 @@ static void (*octeon_irq_ip2)(void);
>  static void (*octeon_irq_ip3)(void);
>  static void (*octeon_irq_ip4)(void);
>  
> -void __cpuinitdata (*octeon_irq_setup_secondary)(void);
> +void (*octeon_irq_setup_secondary)(void);
>  
> -void __cpuinit octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h)
> +void octeon_irq_set_ip4_handler(octeon_irq_ip4_handler_t h)
>  {
>  	octeon_irq_ip4 = h;
>  	octeon_irq_use_ip4 = true;
>  	on_each_cpu(octeon_irq_local_enable_ip4, NULL, 1);
>  }
>  
> -static void __cpuinit octeon_irq_percpu_enable(void)
> +static void octeon_irq_percpu_enable(void)
>  {
>  	irq_cpu_online();
>  }
>  
> -static void __cpuinit octeon_irq_init_ciu_percpu(void)
> +static void octeon_irq_init_ciu_percpu(void)
>  {
>  	int coreid = cvmx_get_core_num();
>  
> @@ -1167,7 +1167,7 @@ static void octeon_irq_init_ciu2_percpu(void)
>  	cvmx_read_csr(CVMX_CIU2_SUM_PPX_IP2(coreid));
>  }
>  
> -static void __cpuinit octeon_irq_setup_secondary_ciu(void)
> +static void octeon_irq_setup_secondary_ciu(void)
>  {
>  	octeon_irq_init_ciu_percpu();
>  	octeon_irq_percpu_enable();
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index 295137d..138cc80 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -173,7 +173,7 @@ static void octeon_boot_secondary(int cpu, struct task_struct *idle)
>   * After we've done initial boot, this function is called to allow the
>   * board code to clean up state, if needed
>   */
> -static void __cpuinit octeon_init_secondary(void)
> +static void octeon_init_secondary(void)
>  {
>  	unsigned int sr;
>  
> @@ -375,7 +375,7 @@ static int octeon_update_boot_vector(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int __cpuinit octeon_cpu_callback(struct notifier_block *nfb,
> +static int octeon_cpu_callback(struct notifier_block *nfb,
>  	unsigned long action, void *hcpu)
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
> @@ -394,7 +394,7 @@ static int __cpuinit octeon_cpu_callback(struct notifier_block *nfb,
>  	return NOTIFY_OK;
>  }
>  
> -static int __cpuinit register_cavium_notifier(void)
> +static int register_cavium_notifier(void)
>  {
>  	hotcpu_notifier(octeon_cpu_callback, 0);
>  	return 0;
> diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
> index 370d967..c33a956 100644
> --- a/arch/mips/include/asm/uasm.h
> +++ b/arch/mips/include/asm/uasm.h
> @@ -13,12 +13,8 @@
>  
>  #ifdef CONFIG_EXPORT_UASM
>  #include <linux/export.h>
> -#define __uasminit
> -#define __uasminitdata
>  #define UASM_EXPORT_SYMBOL(sym) EXPORT_SYMBOL(sym)
>  #else
> -#define __uasminit __cpuinit
> -#define __uasminitdata __cpuinitdata
>  #define UASM_EXPORT_SYMBOL(sym)
>  #endif
>  
> @@ -54,43 +50,36 @@
>  #endif
>  
>  #define Ip_u1u2u3(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
>  
>  #define Ip_u2u1u3(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
>  
>  #define Ip_u3u1u2(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
>  
>  #define Ip_u1u2s3(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
>  
>  #define Ip_u2s3u1(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
>  
>  #define Ip_u2u1s3(op)							\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
>  
>  #define Ip_u2u1msbu3(op)						\
> -void __uasminit								\
> -ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c,	\
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c, \
>  	   unsigned int d)
>  
>  #define Ip_u1u2(op)							\
> -void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
> +void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b)
>  
>  #define Ip_u1s2(op)							\
> -void __uasminit ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
> +void ISAOPC(op)(u32 **buf, unsigned int a, signed int b)
>  
> -#define Ip_u1(op) void __uasminit ISAOPC(op)(u32 **buf, unsigned int a)
> +#define Ip_u1(op) void ISAOPC(op)(u32 **buf, unsigned int a)
>  
> -#define Ip_0(op) void __uasminit ISAOPC(op)(u32 **buf)
> +#define Ip_0(op) void ISAOPC(op)(u32 **buf)
>  
>  Ip_u2u1s3(_addiu);
>  Ip_u3u1u2(_addu);
> @@ -163,7 +152,7 @@ struct uasm_label {
>  	int lab;
>  };
>  
> -void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
> +void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr,
>  			int lid);
>  #ifdef CONFIG_64BIT
>  int ISAFUNC(uasm_in_compat_space_p)(long addr);
> @@ -174,7 +163,7 @@ void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr);
>  void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr);
>  
>  #define UASM_L_LA(lb)							\
> -static inline void __uasminit ISAFUNC(uasm_l##lb)(struct uasm_label **lab, u32 *addr) \
> +static inline void ISAFUNC(uasm_l##lb)(struct uasm_label **lab, u32 *addr) \
>  {									\
>  	ISAFUNC(uasm_build_label)(lab, addr, label##lb);		\
>  }
> diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
> index 64c4fd6..f739aed 100644
> --- a/arch/mips/kernel/bmips_vec.S
> +++ b/arch/mips/kernel/bmips_vec.S
> @@ -28,8 +28,6 @@
>  	.set	mips0
>  	.endm
>  
> -	__CPUINIT
> -
>  /***********************************************************************
>   * Alternate CPU1 startup vector for BMIPS4350
>   *
> @@ -216,8 +214,6 @@ END(bmips_smp_int_vec)
>   * Certain CPUs support extending kseg0 to 1024MB.
>   ***********************************************************************/
>  
> -	__CPUINIT
> -
>  LEAF(bmips_enable_xks01)
>  
>  #if defined(CONFIG_XKS01)
> diff --git a/arch/mips/kernel/cevt-bcm1480.c b/arch/mips/kernel/cevt-bcm1480.c
> index 15f618b..7976457 100644
> --- a/arch/mips/kernel/cevt-bcm1480.c
> +++ b/arch/mips/kernel/cevt-bcm1480.c
> @@ -109,7 +109,7 @@ static DEFINE_PER_CPU(struct clock_event_device, sibyte_hpt_clockevent);
>  static DEFINE_PER_CPU(struct irqaction, sibyte_hpt_irqaction);
>  static DEFINE_PER_CPU(char [18], sibyte_hpt_name);
>  
> -void __cpuinit sb1480_clockevent_init(void)
> +void sb1480_clockevent_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	unsigned int irq = K_BCM1480_INT_TIMER_0 + cpu;
> diff --git a/arch/mips/kernel/cevt-gic.c b/arch/mips/kernel/cevt-gic.c
> index 730eaf9..594cbbf 100644
> --- a/arch/mips/kernel/cevt-gic.c
> +++ b/arch/mips/kernel/cevt-gic.c
> @@ -59,7 +59,7 @@ void gic_event_handler(struct clock_event_device *dev)
>  {
>  }
>  
> -int __cpuinit gic_clockevent_init(void)
> +int gic_clockevent_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct clock_event_device *cd;
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 02033ea..50d3f5a 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -171,7 +171,7 @@ int c0_compare_int_usable(void)
>  }
>  
>  #ifndef CONFIG_MIPS_MT_SMTC
> -int __cpuinit r4k_clockevent_init(void)
> +int r4k_clockevent_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct clock_event_device *cd;
> diff --git a/arch/mips/kernel/cevt-sb1250.c b/arch/mips/kernel/cevt-sb1250.c
> index 200f277..5ea6d6b 100644
> --- a/arch/mips/kernel/cevt-sb1250.c
> +++ b/arch/mips/kernel/cevt-sb1250.c
> @@ -107,7 +107,7 @@ static DEFINE_PER_CPU(struct clock_event_device, sibyte_hpt_clockevent);
>  static DEFINE_PER_CPU(struct irqaction, sibyte_hpt_irqaction);
>  static DEFINE_PER_CPU(char [18], sibyte_hpt_name);
>  
> -void __cpuinit sb1250_clockevent_init(void)
> +void sb1250_clockevent_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	unsigned int irq = K_INT_TIMER_0 + cpu;
> diff --git a/arch/mips/kernel/cevt-smtc.c b/arch/mips/kernel/cevt-smtc.c
> index 9de5ed7..b6cf0a6 100644
> --- a/arch/mips/kernel/cevt-smtc.c
> +++ b/arch/mips/kernel/cevt-smtc.c
> @@ -248,7 +248,7 @@ irqreturn_t c0_compare_interrupt(int irq, void *dev_id)
>  }
>  
>  
> -int __cpuinit smtc_clockevent_init(void)
> +int smtc_clockevent_init(void)
>  {
>  	uint64_t mips_freq = mips_hpt_frequency;
>  	unsigned int cpu = smp_processor_id();
> diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
> index de3c25f..adf3b40 100644
> --- a/arch/mips/kernel/cpu-bugs64.c
> +++ b/arch/mips/kernel/cpu-bugs64.c
> @@ -167,7 +167,7 @@ static inline void check_mult_sh(void)
>  	panic(bug64hit, !R4000_WAR ? r4kwar : nowar);
>  }
>  
> -static volatile int daddi_ov __cpuinitdata;
> +static volatile int daddi_ov;
>  
>  asmlinkage void __init do_daddi_ov(struct pt_regs *regs)
>  {
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index c6568bf..d866a45 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -27,7 +27,7 @@
>  #include <asm/spram.h>
>  #include <asm/uaccess.h>
>  
> -static int __cpuinitdata mips_fpu_disabled;
> +static int mips_fpu_disabled;
>  
>  static int __init fpu_disable(char *s)
>  {
> @@ -39,7 +39,7 @@ static int __init fpu_disable(char *s)
>  
>  __setup("nofpu", fpu_disable);
>  
> -int __cpuinitdata mips_dsp_disabled;
> +int mips_dsp_disabled;
>  
>  static int __init dsp_disable(char *s)
>  {
> @@ -134,7 +134,7 @@ static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
>  #endif
>  }
>  
> -static void __cpuinit set_isa(struct cpuinfo_mips *c, unsigned int isa)
> +static void set_isa(struct cpuinfo_mips *c, unsigned int isa)
>  {
>  	switch (isa) {
>  	case MIPS_CPU_ISA_M64R2:
> @@ -162,7 +162,7 @@ static void __cpuinit set_isa(struct cpuinfo_mips *c, unsigned int isa)
>  	}
>  }
>  
> -static char unknown_isa[] __cpuinitdata = KERN_ERR \
> +static char unknown_isa[] = KERN_ERR \
>  	"Unsupported ISA type, c0.config0: %d.";
>  
>  static inline unsigned int decode_config0(struct cpuinfo_mips *c)
> @@ -296,7 +296,7 @@ static inline unsigned int decode_config4(struct cpuinfo_mips *c)
>  	return config4 & MIPS_CONF_M;
>  }
>  
> -static void __cpuinit decode_configs(struct cpuinfo_mips *c)
> +static void decode_configs(struct cpuinfo_mips *c)
>  {
>  	int ok;
>  
> @@ -970,7 +970,7 @@ EXPORT_SYMBOL(__ua_limit);
>  const char *__cpu_name[NR_CPUS];
>  const char *__elf_platform;
>  
> -__cpuinit void cpu_probe(void)
> +void cpu_probe(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int cpu = smp_processor_id();
> @@ -1055,7 +1055,7 @@ __cpuinit void cpu_probe(void)
>  #endif
>  }
>  
> -__cpuinit void cpu_report(void)
> +void cpu_report(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  
> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> index c61cdae..a13613a 100644
> --- a/arch/mips/kernel/head.S
> +++ b/arch/mips/kernel/head.S
> @@ -197,8 +197,6 @@ NESTED(kernel_entry, 16, sp)			# kernel entry point
>  	j		start_kernel
>  	END(kernel_entry)
>  
> -	__CPUINIT
> -
>  #ifdef CONFIG_SMP
>  /*
>   * SMP slave cpus entry point.	Board specific code for bootstrap calls this
> @@ -227,5 +225,3 @@ NESTED(smp_bootstrap, 16, sp)
>  	j	start_secondary
>  	END(smp_bootstrap)
>  #endif /* CONFIG_SMP */
> -
> -	__FINIT
> diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
> index 8e393b8..20c637f 100644
> --- a/arch/mips/kernel/smp-bmips.c
> +++ b/arch/mips/kernel/smp-bmips.c
> @@ -381,7 +381,7 @@ struct plat_smp_ops bmips_smp_ops = {
>   * UP BMIPS systems as well.
>   ***********************************************************************/
>  
> -static void __cpuinit bmips_wr_vec(unsigned long dst, char *start, char *end)
> +static void bmips_wr_vec(unsigned long dst, char *start, char *end)
>  {
>  	memcpy((void *)dst, start, end - start);
>  	dma_cache_wback((unsigned long)start, end - start);
> @@ -389,7 +389,7 @@ static void __cpuinit bmips_wr_vec(unsigned long dst, char *start, char *end)
>  	instruction_hazard();
>  }
>  
> -static inline void __cpuinit bmips_nmi_handler_setup(void)
> +static inline void bmips_nmi_handler_setup(void)
>  {
>  	bmips_wr_vec(BMIPS_NMI_RESET_VEC, &bmips_reset_nmi_vec,
>  		&bmips_reset_nmi_vec_end);
> @@ -397,7 +397,7 @@ static inline void __cpuinit bmips_nmi_handler_setup(void)
>  		&bmips_smp_int_vec_end);
>  }
>  
> -void __cpuinit bmips_ebase_setup(void)
> +void bmips_ebase_setup(void)
>  {
>  	unsigned long new_ebase = ebase;
>  	void __iomem __maybe_unused *cbr;
> diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
> index 3e5164c..57a3f7a 100644
> --- a/arch/mips/kernel/smp-mt.c
> +++ b/arch/mips/kernel/smp-mt.c
> @@ -149,7 +149,7 @@ static void vsmp_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>  		vsmp_send_ipi_single(i, action);
>  }
>  
> -static void __cpuinit vsmp_init_secondary(void)
> +static void vsmp_init_secondary(void)
>  {
>  #ifdef CONFIG_IRQ_GIC
>  	/* This is Malta specific: IPI,performance and timer interrupts */
> @@ -162,7 +162,7 @@ static void __cpuinit vsmp_init_secondary(void)
>  					 STATUSF_IP6 | STATUSF_IP7);
>  }
>  
> -static void __cpuinit vsmp_smp_finish(void)
> +static void vsmp_smp_finish(void)
>  {
>  	/* CDFIXME: remove this? */
>  	write_c0_compare(read_c0_count() + (8* mips_hpt_frequency/HZ));
> @@ -188,7 +188,7 @@ static void vsmp_cpus_done(void)
>   * (unsigned long)idle->thread_info the gp
>   * assumes a 1:1 mapping of TC => VPE
>   */
> -static void __cpuinit vsmp_boot_secondary(int cpu, struct task_struct *idle)
> +static void vsmp_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	struct thread_info *gp = task_thread_info(idle);
>  	dvpe();
> diff --git a/arch/mips/kernel/smp-up.c b/arch/mips/kernel/smp-up.c
> index 00500fe..7fde3e4 100644
> --- a/arch/mips/kernel/smp-up.c
> +++ b/arch/mips/kernel/smp-up.c
> @@ -28,11 +28,11 @@ static inline void up_send_ipi_mask(const struct cpumask *mask,
>   *  After we've done initial boot, this function is called to allow the
>   *  board code to clean up state, if needed
>   */
> -static void __cpuinit up_init_secondary(void)
> +static void up_init_secondary(void)
>  {
>  }
>  
> -static void __cpuinit up_smp_finish(void)
> +static void up_smp_finish(void)
>  {
>  }
>  
> @@ -44,7 +44,7 @@ static void up_cpus_done(void)
>  /*
>   * Firmware CPU startup hook
>   */
> -static void __cpuinit up_boot_secondary(int cpu, struct task_struct *idle)
> +static void up_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  }
>  
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 6e7862a..5c208ed 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -86,7 +86,7 @@ static inline void set_cpu_sibling_map(int cpu)
>  struct plat_smp_ops *mp_ops;
>  EXPORT_SYMBOL(mp_ops);
>  
> -__cpuinit void register_smp_ops(struct plat_smp_ops *ops)
> +void register_smp_ops(struct plat_smp_ops *ops)
>  {
>  	if (mp_ops)
>  		printk(KERN_WARNING "Overriding previously set SMP ops\n");
> @@ -98,7 +98,7 @@ __cpuinit void register_smp_ops(struct plat_smp_ops *ops)
>   * First C code run on the secondary CPUs after being started up by
>   * the master.
>   */
> -asmlinkage __cpuinit void start_secondary(void)
> +asmlinkage void start_secondary(void)
>  {
>  	unsigned int cpu;
>  
> @@ -197,7 +197,7 @@ void smp_prepare_boot_cpu(void)
>  	cpu_set(0, cpu_callin_map);
>  }
>  
> -int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
>  	mp_ops->boot_secondary(cpu, tidle);
>  
> diff --git a/arch/mips/kernel/smtc.c b/arch/mips/kernel/smtc.c
> index 75a4fd7..dfc1b91 100644
> --- a/arch/mips/kernel/smtc.c
> +++ b/arch/mips/kernel/smtc.c
> @@ -645,7 +645,7 @@ void smtc_prepare_cpus(int cpus)
>   * (unsigned long)idle->thread_info the gp
>   *
>   */
> -void __cpuinit smtc_boot_secondary(int cpu, struct task_struct *idle)
> +void smtc_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	extern u32 kernelsp[NR_CPUS];
>  	unsigned long flags;
> diff --git a/arch/mips/kernel/spram.c b/arch/mips/kernel/spram.c
> index 6af08d8..93f8681 100644
> --- a/arch/mips/kernel/spram.c
> +++ b/arch/mips/kernel/spram.c
> @@ -37,7 +37,7 @@
>  /*
>   * Different semantics to the set_c0_* function built by __BUILD_SET_C0
>   */
> -static __cpuinit unsigned int bis_c0_errctl(unsigned int set)
> +static unsigned int bis_c0_errctl(unsigned int set)
>  {
>  	unsigned int res;
>  	res = read_c0_errctl();
> @@ -45,7 +45,7 @@ static __cpuinit unsigned int bis_c0_errctl(unsigned int set)
>  	return res;
>  }
>  
> -static __cpuinit void ispram_store_tag(unsigned int offset, unsigned int data)
> +static void ispram_store_tag(unsigned int offset, unsigned int data)
>  {
>  	unsigned int errctl;
>  
> @@ -64,7 +64,7 @@ static __cpuinit void ispram_store_tag(unsigned int offset, unsigned int data)
>  }
>  
>  
> -static __cpuinit unsigned int ispram_load_tag(unsigned int offset)
> +static unsigned int ispram_load_tag(unsigned int offset)
>  {
>  	unsigned int data;
>  	unsigned int errctl;
> @@ -82,7 +82,7 @@ static __cpuinit unsigned int ispram_load_tag(unsigned int offset)
>  	return data;
>  }
>  
> -static __cpuinit void dspram_store_tag(unsigned int offset, unsigned int data)
> +static void dspram_store_tag(unsigned int offset, unsigned int data)
>  {
>  	unsigned int errctl;
>  
> @@ -98,7 +98,7 @@ static __cpuinit void dspram_store_tag(unsigned int offset, unsigned int data)
>  }
>  
>  
> -static __cpuinit unsigned int dspram_load_tag(unsigned int offset)
> +static unsigned int dspram_load_tag(unsigned int offset)
>  {
>  	unsigned int data;
>  	unsigned int errctl;
> @@ -115,7 +115,7 @@ static __cpuinit unsigned int dspram_load_tag(unsigned int offset)
>  	return data;
>  }
>  
> -static __cpuinit void probe_spram(char *type,
> +static void probe_spram(char *type,
>  	    unsigned int base,
>  	    unsigned int (*read)(unsigned int),
>  	    void (*write)(unsigned int, unsigned int))
> @@ -196,7 +196,7 @@ static __cpuinit void probe_spram(char *type,
>  		offset += 2 * SPRAM_TAG_STRIDE;
>  	}
>  }
> -void __cpuinit spram_config(void)
> +void spram_config(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int config0;
> diff --git a/arch/mips/kernel/sync-r4k.c b/arch/mips/kernel/sync-r4k.c
> index 1ff43d5..84536bf 100644
> --- a/arch/mips/kernel/sync-r4k.c
> +++ b/arch/mips/kernel/sync-r4k.c
> @@ -20,15 +20,15 @@
>  #include <asm/barrier.h>
>  #include <asm/mipsregs.h>
>  
> -static atomic_t __cpuinitdata count_start_flag = ATOMIC_INIT(0);
> -static atomic_t __cpuinitdata count_count_start = ATOMIC_INIT(0);
> -static atomic_t __cpuinitdata count_count_stop = ATOMIC_INIT(0);
> -static atomic_t __cpuinitdata count_reference = ATOMIC_INIT(0);
> +static atomic_t count_start_flag = ATOMIC_INIT(0);
> +static atomic_t count_count_start = ATOMIC_INIT(0);
> +static atomic_t count_count_stop = ATOMIC_INIT(0);
> +static atomic_t count_reference = ATOMIC_INIT(0);
>  
>  #define COUNTON 100
>  #define NR_LOOPS 5
>  
> -void __cpuinit synchronise_count_master(int cpu)
> +void synchronise_count_master(int cpu)
>  {
>  	int i;
>  	unsigned long flags;
> @@ -106,7 +106,7 @@ void __cpuinit synchronise_count_master(int cpu)
>  	printk("done.\n");
>  }
>  
> -void __cpuinit synchronise_count_slave(int cpu)
> +void synchronise_count_slave(int cpu)
>  {
>  	int i;
>  	unsigned int initcount;
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index a75ae40..f516841 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -89,7 +89,7 @@ void (*board_nmi_handler_setup)(void);
>  void (*board_ejtag_handler_setup)(void);
>  void (*board_bind_eic_interrupt)(int irq, int regset);
>  void (*board_ebase_setup)(void);
> -void __cpuinitdata(*board_cache_error_setup)(void);
> +void(*board_cache_error_setup)(void);
>  
>  static void show_raw_backtrace(unsigned long reg29)
>  {
> @@ -1642,7 +1642,7 @@ int cp0_compare_irq_shift;
>  int cp0_perfcount_irq;
>  EXPORT_SYMBOL_GPL(cp0_perfcount_irq);
>  
> -static int __cpuinitdata noulri;
> +static int noulri;
>  
>  static int __init ulri_disable(char *s)
>  {
> @@ -1653,7 +1653,7 @@ static int __init ulri_disable(char *s)
>  }
>  __setup("noulri", ulri_disable);
>  
> -void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
> +void per_cpu_trap_init(bool is_boot_cpu)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	unsigned int status_set = ST0_CU0;
> @@ -1770,7 +1770,7 @@ void __cpuinit per_cpu_trap_init(bool is_boot_cpu)
>  }
>  
>  /* Install CPU exception handler */
> -void __cpuinit set_handler(unsigned long offset, void *addr, unsigned long size)
> +void set_handler(unsigned long offset, void *addr, unsigned long size)
>  {
>  #ifdef CONFIG_CPU_MICROMIPS
>  	memcpy((void *)(ebase + offset), ((unsigned char *)addr - 1), size);
> @@ -1780,7 +1780,7 @@ void __cpuinit set_handler(unsigned long offset, void *addr, unsigned long size)
>  	local_flush_icache_range(ebase + offset, ebase + offset + size);
>  }
>  
> -static char panic_null_cerr[] __cpuinitdata =
> +static char panic_null_cerr[] =
>  	"Trying to set NULL cache error exception handler";
>  
>  /*
> @@ -1788,7 +1788,7 @@ static char panic_null_cerr[] __cpuinitdata =
>   * This is suitable only for the cache error exception which is the only
>   * exception handler that is being run uncached.
>   */
> -void __cpuinit set_uncached_handler(unsigned long offset, void *addr,
> +void set_uncached_handler(unsigned long offset, void *addr,
>  	unsigned long size)
>  {
>  	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
> diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
> index 7726f61..3b7b900 100644
> --- a/arch/mips/kernel/watch.c
> +++ b/arch/mips/kernel/watch.c
> @@ -100,7 +100,7 @@ void mips_clear_watch_registers(void)
>  	}
>  }
>  
> -__cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
> +void mips_probe_watch_registers(struct cpuinfo_mips *c)
>  {
>  	unsigned int t;
>  
> diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
> index 5119487..eb3e186 100644
> --- a/arch/mips/lantiq/irq.c
> +++ b/arch/mips/lantiq/irq.c
> @@ -461,7 +461,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
>  	return 0;
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	return MIPS_CPU_TIMER_IRQ;
>  }
> diff --git a/arch/mips/lib/uncached.c b/arch/mips/lib/uncached.c
> index 65e3dfc..d8522f8 100644
> --- a/arch/mips/lib/uncached.c
> +++ b/arch/mips/lib/uncached.c
> @@ -36,7 +36,7 @@
>   * values, so we can avoid sharing the same stack area between a cached
>   * and the uncached mode.
>   */
> -unsigned long __cpuinit run_uncached(void *func)
> +unsigned long run_uncached(void *func)
>  {
>  	register long sp __asm__("$sp");
>  	register long ret __asm__("$2");
> diff --git a/arch/mips/mm/c-octeon.c b/arch/mips/mm/c-octeon.c
> index 8557fb5..a0bcdbb 100644
> --- a/arch/mips/mm/c-octeon.c
> +++ b/arch/mips/mm/c-octeon.c
> @@ -180,7 +180,7 @@ static void octeon_flush_kernel_vmap_range(unsigned long vaddr, int size)
>   * Probe Octeon's caches
>   *
>   */
> -static void __cpuinit probe_octeon(void)
> +static void probe_octeon(void)
>  {
>  	unsigned long icache_size;
>  	unsigned long dcache_size;
> @@ -251,7 +251,7 @@ static void __cpuinit probe_octeon(void)
>  	}
>  }
>  
> -static void  __cpuinit octeon_cache_error_setup(void)
> +static void  octeon_cache_error_setup(void)
>  {
>  	extern char except_vec2_octeon;
>  	set_handler(0x100, &except_vec2_octeon, 0x80);
> @@ -261,7 +261,7 @@ static void  __cpuinit octeon_cache_error_setup(void)
>   * Setup the Octeon cache flush routines
>   *
>   */
> -void __cpuinit octeon_cache_init(void)
> +void octeon_cache_init(void)
>  {
>  	probe_octeon();
>  
> diff --git a/arch/mips/mm/c-r3k.c b/arch/mips/mm/c-r3k.c
> index 704dc73..2fcde0c 100644
> --- a/arch/mips/mm/c-r3k.c
> +++ b/arch/mips/mm/c-r3k.c
> @@ -26,7 +26,7 @@
>  static unsigned long icache_size, dcache_size;		/* Size in bytes */
>  static unsigned long icache_lsize, dcache_lsize;	/* Size in bytes */
>  
> -unsigned long __cpuinit r3k_cache_size(unsigned long ca_flags)
> +unsigned long r3k_cache_size(unsigned long ca_flags)
>  {
>  	unsigned long flags, status, dummy, size;
>  	volatile unsigned long *p;
> @@ -61,7 +61,7 @@ unsigned long __cpuinit r3k_cache_size(unsigned long ca_flags)
>  	return size * sizeof(*p);
>  }
>  
> -unsigned long __cpuinit r3k_cache_lsize(unsigned long ca_flags)
> +unsigned long r3k_cache_lsize(unsigned long ca_flags)
>  {
>  	unsigned long flags, status, lsize, i;
>  	volatile unsigned long *p;
> @@ -90,7 +90,7 @@ unsigned long __cpuinit r3k_cache_lsize(unsigned long ca_flags)
>  	return lsize * sizeof(*p);
>  }
>  
> -static void __cpuinit r3k_probe_cache(void)
> +static void r3k_probe_cache(void)
>  {
>  	dcache_size = r3k_cache_size(ST0_ISC);
>  	if (dcache_size)
> @@ -312,7 +312,7 @@ static void r3k_dma_cache_wback_inv(unsigned long start, unsigned long size)
>  	r3k_flush_dcache_range(start, start + size);
>  }
>  
> -void __cpuinit r3k_cache_init(void)
> +void r3k_cache_init(void)
>  {
>  	extern void build_clear_page(void);
>  	extern void build_copy_page(void);
> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 21813be..f749f68 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -107,7 +107,7 @@ static inline void r4k_blast_dcache_page_dc64(unsigned long addr)
>  	blast_dcache64_page(addr);
>  }
>  
> -static void __cpuinit r4k_blast_dcache_page_setup(void)
> +static void r4k_blast_dcache_page_setup(void)
>  {
>  	unsigned long  dc_lsize = cpu_dcache_line_size();
>  
> @@ -123,7 +123,7 @@ static void __cpuinit r4k_blast_dcache_page_setup(void)
>  
>  static void (* r4k_blast_dcache_page_indexed)(unsigned long addr);
>  
> -static void __cpuinit r4k_blast_dcache_page_indexed_setup(void)
> +static void r4k_blast_dcache_page_indexed_setup(void)
>  {
>  	unsigned long dc_lsize = cpu_dcache_line_size();
>  
> @@ -140,7 +140,7 @@ static void __cpuinit r4k_blast_dcache_page_indexed_setup(void)
>  void (* r4k_blast_dcache)(void);
>  EXPORT_SYMBOL(r4k_blast_dcache);
>  
> -static void __cpuinit r4k_blast_dcache_setup(void)
> +static void r4k_blast_dcache_setup(void)
>  {
>  	unsigned long dc_lsize = cpu_dcache_line_size();
>  
> @@ -227,7 +227,7 @@ static inline void tx49_blast_icache32_page_indexed(unsigned long page)
>  
>  static void (* r4k_blast_icache_page)(unsigned long addr);
>  
> -static void __cpuinit r4k_blast_icache_page_setup(void)
> +static void r4k_blast_icache_page_setup(void)
>  {
>  	unsigned long ic_lsize = cpu_icache_line_size();
>  
> @@ -244,7 +244,7 @@ static void __cpuinit r4k_blast_icache_page_setup(void)
>  
>  static void (* r4k_blast_icache_page_indexed)(unsigned long addr);
>  
> -static void __cpuinit r4k_blast_icache_page_indexed_setup(void)
> +static void r4k_blast_icache_page_indexed_setup(void)
>  {
>  	unsigned long ic_lsize = cpu_icache_line_size();
>  
> @@ -269,7 +269,7 @@ static void __cpuinit r4k_blast_icache_page_indexed_setup(void)
>  void (* r4k_blast_icache)(void);
>  EXPORT_SYMBOL(r4k_blast_icache);
>  
> -static void __cpuinit r4k_blast_icache_setup(void)
> +static void r4k_blast_icache_setup(void)
>  {
>  	unsigned long ic_lsize = cpu_icache_line_size();
>  
> @@ -290,7 +290,7 @@ static void __cpuinit r4k_blast_icache_setup(void)
>  
>  static void (* r4k_blast_scache_page)(unsigned long addr);
>  
> -static void __cpuinit r4k_blast_scache_page_setup(void)
> +static void r4k_blast_scache_page_setup(void)
>  {
>  	unsigned long sc_lsize = cpu_scache_line_size();
>  
> @@ -308,7 +308,7 @@ static void __cpuinit r4k_blast_scache_page_setup(void)
>  
>  static void (* r4k_blast_scache_page_indexed)(unsigned long addr);
>  
> -static void __cpuinit r4k_blast_scache_page_indexed_setup(void)
> +static void r4k_blast_scache_page_indexed_setup(void)
>  {
>  	unsigned long sc_lsize = cpu_scache_line_size();
>  
> @@ -326,7 +326,7 @@ static void __cpuinit r4k_blast_scache_page_indexed_setup(void)
>  
>  static void (* r4k_blast_scache)(void);
>  
> -static void __cpuinit r4k_blast_scache_setup(void)
> +static void r4k_blast_scache_setup(void)
>  {
>  	unsigned long sc_lsize = cpu_scache_line_size();
>  
> @@ -797,11 +797,11 @@ static inline void alias_74k_erratum(struct cpuinfo_mips *c)
>  	}
>  }
>  
> -static char *way_string[] __cpuinitdata = { NULL, "direct mapped", "2-way",
> +static char *way_string[] = { NULL, "direct mapped", "2-way",
>  	"3-way", "4-way", "5-way", "6-way", "7-way", "8-way"
>  };
>  
> -static void __cpuinit probe_pcache(void)
> +static void probe_pcache(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int config = read_c0_config();
> @@ -1119,7 +1119,7 @@ static void __cpuinit probe_pcache(void)
>   * executes in KSEG1 space or else you will crash and burn badly.  You have
>   * been warned.
>   */
> -static int __cpuinit probe_scache(void)
> +static int probe_scache(void)
>  {
>  	unsigned long flags, addr, begin, end, pow2;
>  	unsigned int config = read_c0_config();
> @@ -1196,7 +1196,7 @@ extern int r5k_sc_init(void);
>  extern int rm7k_sc_init(void);
>  extern int mips_sc_init(void);
>  
> -static void __cpuinit setup_scache(void)
> +static void setup_scache(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int config = read_c0_config();
> @@ -1329,7 +1329,7 @@ static void nxp_pr4450_fixup_config(void)
>  	NXP_BARRIER();
>  }
>  
> -static int __cpuinitdata cca = -1;
> +static int cca = -1;
>  
>  static int __init cca_setup(char *str)
>  {
> @@ -1340,7 +1340,7 @@ static int __init cca_setup(char *str)
>  
>  early_param("cca", cca_setup);
>  
> -static void __cpuinit coherency_setup(void)
> +static void coherency_setup(void)
>  {
>  	if (cca < 0 || cca > 7)
>  		cca = read_c0_config() & CONF_CM_CMASK;
> @@ -1380,7 +1380,7 @@ static void __cpuinit coherency_setup(void)
>  	}
>  }
>  
> -static void __cpuinit r4k_cache_error_setup(void)
> +static void r4k_cache_error_setup(void)
>  {
>  	extern char __weak except_vec2_generic;
>  	extern char __weak except_vec2_sb1;
> @@ -1398,7 +1398,7 @@ static void __cpuinit r4k_cache_error_setup(void)
>  	}
>  }
>  
> -void __cpuinit r4k_cache_init(void)
> +void r4k_cache_init(void)
>  {
>  	extern void build_clear_page(void);
>  	extern void build_copy_page(void);
> diff --git a/arch/mips/mm/c-tx39.c b/arch/mips/mm/c-tx39.c
> index ba9da27..8d909db 100644
> --- a/arch/mips/mm/c-tx39.c
> +++ b/arch/mips/mm/c-tx39.c
> @@ -344,7 +344,7 @@ static __init void tx39_probe_cache(void)
>  	}
>  }
>  
> -void __cpuinit tx39_cache_init(void)
> +void tx39_cache_init(void)
>  {
>  	extern void build_clear_page(void);
>  	extern void build_copy_page(void);
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 5aeb3eb..15f813c 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -182,7 +182,7 @@ static inline void setup_protection_map(void)
>  	}
>  }
>  
> -void __cpuinit cpu_cache_init(void)
> +void cpu_cache_init(void)
>  {
>  	if (cpu_has_3k_cache) {
>  		extern void __weak r3k_cache_init(void);
> diff --git a/arch/mips/mm/cex-sb1.S b/arch/mips/mm/cex-sb1.S
> index fe1d887..191cf6e 100644
> --- a/arch/mips/mm/cex-sb1.S
> +++ b/arch/mips/mm/cex-sb1.S
> @@ -49,8 +49,6 @@
>  	 * (0x170-0x17f) are used to preserve k0, k1, and ra.
>  	 */
>  
> -	__CPUINIT
> -
>  LEAF(except_vec2_sb1)
>  	/*
>  	 * If this error is recoverable, we need to exit the handler
> @@ -142,8 +140,6 @@ unrecoverable:
>  
>  END(except_vec2_sb1)
>  
> -	__FINIT
> -
>  	LEAF(handle_vec2_sb1)
>  	mfc0	k0,CP0_CONFIG
>  	li	k1,~CONF_CM_CMASK
> diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> index 4eb8dcf..6bdaa26 100644
> --- a/arch/mips/mm/page.c
> +++ b/arch/mips/mm/page.c
> @@ -66,29 +66,29 @@ UASM_L_LA(_copy_pref_both)
>  UASM_L_LA(_copy_pref_store)
>  
>  /* We need one branch and therefore one relocation per target label. */
> -static struct uasm_label __cpuinitdata labels[5];
> -static struct uasm_reloc __cpuinitdata relocs[5];
> +static struct uasm_label labels[5];
> +static struct uasm_reloc relocs[5];
>  
>  #define cpu_is_r4600_v1_x()	((read_c0_prid() & 0xfffffff0) == 0x00002010)
>  #define cpu_is_r4600_v2_x()	((read_c0_prid() & 0xfffffff0) == 0x00002020)
>  
> -static int pref_bias_clear_store __cpuinitdata;
> -static int pref_bias_copy_load __cpuinitdata;
> -static int pref_bias_copy_store __cpuinitdata;
> +static int pref_bias_clear_store;
> +static int pref_bias_copy_load;
> +static int pref_bias_copy_store;
>  
> -static u32 pref_src_mode __cpuinitdata;
> -static u32 pref_dst_mode __cpuinitdata;
> +static u32 pref_src_mode;
> +static u32 pref_dst_mode;
>  
> -static int clear_word_size __cpuinitdata;
> -static int copy_word_size __cpuinitdata;
> +static int clear_word_size;
> +static int copy_word_size;
>  
> -static int half_clear_loop_size __cpuinitdata;
> -static int half_copy_loop_size __cpuinitdata;
> +static int half_clear_loop_size;
> +static int half_copy_loop_size;
>  
> -static int cache_line_size __cpuinitdata;
> +static int cache_line_size;
>  #define cache_line_mask() (cache_line_size - 1)
>  
> -static inline void __cpuinit
> +static inline void
>  pg_addiu(u32 **buf, unsigned int reg1, unsigned int reg2, unsigned int off)
>  {
>  	if (cpu_has_64bit_gp_regs && DADDI_WAR && r4k_daddiu_bug()) {
> @@ -108,7 +108,7 @@ pg_addiu(u32 **buf, unsigned int reg1, unsigned int reg2, unsigned int off)
>  	}
>  }
>  
> -static void __cpuinit set_prefetch_parameters(void)
> +static void set_prefetch_parameters(void)
>  {
>  	if (cpu_has_64bit_gp_regs || cpu_has_64bit_zero_reg)
>  		clear_word_size = 8;
> @@ -199,7 +199,7 @@ static void __cpuinit set_prefetch_parameters(void)
>  				      4 * copy_word_size));
>  }
>  
> -static void __cpuinit build_clear_store(u32 **buf, int off)
> +static void build_clear_store(u32 **buf, int off)
>  {
>  	if (cpu_has_64bit_gp_regs || cpu_has_64bit_zero_reg) {
>  		uasm_i_sd(buf, ZERO, off, A0);
> @@ -208,7 +208,7 @@ static void __cpuinit build_clear_store(u32 **buf, int off)
>  	}
>  }
>  
> -static inline void __cpuinit build_clear_pref(u32 **buf, int off)
> +static inline void build_clear_pref(u32 **buf, int off)
>  {
>  	if (off & cache_line_mask())
>  		return;
> @@ -240,7 +240,7 @@ extern u32 __clear_page_end;
>  extern u32 __copy_page_start;
>  extern u32 __copy_page_end;
>  
> -void __cpuinit build_clear_page(void)
> +void build_clear_page(void)
>  {
>  	int off;
>  	u32 *buf = &__clear_page_start;
> @@ -333,7 +333,7 @@ void __cpuinit build_clear_page(void)
>  	pr_debug("\t.set pop\n");
>  }
>  
> -static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
> +static void build_copy_load(u32 **buf, int reg, int off)
>  {
>  	if (cpu_has_64bit_gp_regs) {
>  		uasm_i_ld(buf, reg, off, A1);
> @@ -342,7 +342,7 @@ static void __cpuinit build_copy_load(u32 **buf, int reg, int off)
>  	}
>  }
>  
> -static void __cpuinit build_copy_store(u32 **buf, int reg, int off)
> +static void build_copy_store(u32 **buf, int reg, int off)
>  {
>  	if (cpu_has_64bit_gp_regs) {
>  		uasm_i_sd(buf, reg, off, A0);
> @@ -387,7 +387,7 @@ static inline void build_copy_store_pref(u32 **buf, int off)
>  	}
>  }
>  
> -void __cpuinit build_copy_page(void)
> +void build_copy_page(void)
>  {
>  	int off;
>  	u32 *buf = &__copy_page_start;
> diff --git a/arch/mips/mm/sc-ip22.c b/arch/mips/mm/sc-ip22.c
> index c6aaed9..dc7c5a5 100644
> --- a/arch/mips/mm/sc-ip22.c
> +++ b/arch/mips/mm/sc-ip22.c
> @@ -167,7 +167,7 @@ static struct bcache_ops indy_sc_ops = {
>  	.bc_inv = indy_sc_wback_invalidate
>  };
>  
> -void __cpuinit indy_sc_init(void)
> +void indy_sc_init(void)
>  {
>  	if (indy_sc_probe()) {
>  		indy_sc_enable();
> diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
> index df96da7..5d01392 100644
> --- a/arch/mips/mm/sc-mips.c
> +++ b/arch/mips/mm/sc-mips.c
> @@ -132,7 +132,7 @@ static inline int __init mips_sc_probe(void)
>  	return 1;
>  }
>  
> -int __cpuinit mips_sc_init(void)
> +int mips_sc_init(void)
>  {
>  	int found = mips_sc_probe();
>  	if (found) {
> diff --git a/arch/mips/mm/sc-r5k.c b/arch/mips/mm/sc-r5k.c
> index 8bc6772..0216ed6 100644
> --- a/arch/mips/mm/sc-r5k.c
> +++ b/arch/mips/mm/sc-r5k.c
> @@ -98,7 +98,7 @@ static struct bcache_ops r5k_sc_ops = {
>  	.bc_inv = r5k_dma_cache_inv_sc
>  };
>  
> -void __cpuinit r5k_sc_init(void)
> +void r5k_sc_init(void)
>  {
>  	if (r5k_sc_probe()) {
>  		r5k_sc_enable();
> diff --git a/arch/mips/mm/sc-rm7k.c b/arch/mips/mm/sc-rm7k.c
> index 274af3b..aaffbba 100644
> --- a/arch/mips/mm/sc-rm7k.c
> +++ b/arch/mips/mm/sc-rm7k.c
> @@ -104,7 +104,7 @@ static void blast_rm7k_tcache(void)
>  /*
>   * This function is executed in uncached address space.
>   */
> -static __cpuinit void __rm7k_tc_enable(void)
> +static void __rm7k_tc_enable(void)
>  {
>  	int i;
>  
> @@ -117,7 +117,7 @@ static __cpuinit void __rm7k_tc_enable(void)
>  		cache_op(Index_Store_Tag_T, CKSEG0ADDR(i));
>  }
>  
> -static __cpuinit void rm7k_tc_enable(void)
> +static void rm7k_tc_enable(void)
>  {
>  	if (read_c0_config() & RM7K_CONF_TE)
>  		return;
> @@ -130,7 +130,7 @@ static __cpuinit void rm7k_tc_enable(void)
>  /*
>   * This function is executed in uncached address space.
>   */
> -static __cpuinit void __rm7k_sc_enable(void)
> +static void __rm7k_sc_enable(void)
>  {
>  	int i;
>  
> @@ -143,7 +143,7 @@ static __cpuinit void __rm7k_sc_enable(void)
>  		cache_op(Index_Store_Tag_SD, CKSEG0ADDR(i));
>  }
>  
> -static __cpuinit void rm7k_sc_enable(void)
> +static void rm7k_sc_enable(void)
>  {
>  	if (read_c0_config() & RM7K_CONF_SE)
>  		return;
> @@ -184,7 +184,7 @@ static struct bcache_ops rm7k_sc_ops = {
>   * This is a probing function like the one found in c-r4k.c, we look for the
>   * wrap around point with different addresses.
>   */
> -static __cpuinit void __probe_tcache(void)
> +static void __probe_tcache(void)
>  {
>  	unsigned long flags, addr, begin, end, pow2;
>  
> @@ -226,7 +226,7 @@ static __cpuinit void __probe_tcache(void)
>  	local_irq_restore(flags);
>  }
>  
> -void __cpuinit rm7k_sc_init(void)
> +void rm7k_sc_init(void)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  	unsigned int config = read_c0_config();
> diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
> index a63d1ed..9aca109 100644
> --- a/arch/mips/mm/tlb-r3k.c
> +++ b/arch/mips/mm/tlb-r3k.c
> @@ -276,7 +276,7 @@ void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
>  	}
>  }
>  
> -void __cpuinit tlb_init(void)
> +void tlb_init(void)
>  {
>  	local_flush_tlb_all();
>  
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index c643de4..00b26a6 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -389,7 +389,7 @@ int __init has_transparent_hugepage(void)
>  
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE  */
>  
> -static int __cpuinitdata ntlb;
> +static int ntlb;
>  static int __init set_ntlb(char *str)
>  {
>  	get_option(&str, &ntlb);
> @@ -398,7 +398,7 @@ static int __init set_ntlb(char *str)
>  
>  __setup("ntlb=", set_ntlb);
>  
> -void __cpuinit tlb_init(void)
> +void tlb_init(void)
>  {
>  	/*
>  	 * You should never change this register:
> diff --git a/arch/mips/mm/tlb-r8k.c b/arch/mips/mm/tlb-r8k.c
> index 91c2499..6a99733 100644
> --- a/arch/mips/mm/tlb-r8k.c
> +++ b/arch/mips/mm/tlb-r8k.c
> @@ -213,14 +213,14 @@ void __update_tlb(struct vm_area_struct * vma, unsigned long address, pte_t pte)
>  	local_irq_restore(flags);
>  }
>  
> -static void __cpuinit probe_tlb(unsigned long config)
> +static void probe_tlb(unsigned long config)
>  {
>  	struct cpuinfo_mips *c = &current_cpu_data;
>  
>  	c->tlbsize = 3 * 128;		/* 3 sets each 128 entries */
>  }
>  
> -void __cpuinit tlb_init(void)
> +void tlb_init(void)
>  {
>  	unsigned int config = read_c0_config();
>  	unsigned long status;
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index afeef93..17ca17b 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -136,7 +136,7 @@ static int scratchpad_offset(int i)
>   * why; it's not an issue caused by the core RTL.
>   *
>   */
> -static int __cpuinit m4kc_tlbp_war(void)
> +static int m4kc_tlbp_war(void)
>  {
>  	return (current_cpu_data.processor_id & 0xffff00) ==
>  	       (PRID_COMP_MIPS | PRID_IMP_4KC);
> @@ -181,11 +181,9 @@ UASM_L_LA(_large_segbits_fault)
>  UASM_L_LA(_tlb_huge_update)
>  #endif
>  
> -static int __cpuinitdata hazard_instance;
> +static int hazard_instance;
>  
> -static void __cpuinit uasm_bgezl_hazard(u32 **p,
> -					struct uasm_reloc **r,
> -					int instance)
> +static void uasm_bgezl_hazard(u32 **p, struct uasm_reloc **r, int instance)
>  {
>  	switch (instance) {
>  	case 0 ... 7:
> @@ -196,9 +194,7 @@ static void __cpuinit uasm_bgezl_hazard(u32 **p,
>  	}
>  }
>  
> -static void __cpuinit uasm_bgezl_label(struct uasm_label **l,
> -				       u32 **p,
> -				       int instance)
> +static void uasm_bgezl_label(struct uasm_label **l, u32 **p, int instance)
>  {
>  	switch (instance) {
>  	case 0 ... 7:
> @@ -295,17 +291,17 @@ static inline void dump_handler(const char *symbol, const u32 *handler, int coun
>   * We deliberately chose a buffer size of 128, so we won't scribble
>   * over anything important on overflow before we panic.
>   */
> -static u32 tlb_handler[128] __cpuinitdata;
> +static u32 tlb_handler[128];
>  
>  /* simply assume worst case size for labels and relocs */
> -static struct uasm_label labels[128] __cpuinitdata;
> -static struct uasm_reloc relocs[128] __cpuinitdata;
> +static struct uasm_label labels[128];
> +static struct uasm_reloc relocs[128];
>  
> -static int check_for_high_segbits __cpuinitdata;
> +static int check_for_high_segbits;
>  
> -static unsigned int kscratch_used_mask __cpuinitdata;
> +static unsigned int kscratch_used_mask;
>  
> -static int __cpuinit allocate_kscratch(void)
> +static int allocate_kscratch(void)
>  {
>  	int r;
>  	unsigned int a = cpu_data[0].kscratch_mask & ~kscratch_used_mask;
> @@ -322,11 +318,11 @@ static int __cpuinit allocate_kscratch(void)
>  	return r;
>  }
>  
> -static int scratch_reg __cpuinitdata;
> -static int pgd_reg __cpuinitdata;
> +static int scratch_reg;
> +static int pgd_reg;
>  enum vmalloc64_mode {not_refill, refill_scratch, refill_noscratch};
>  
> -static struct work_registers __cpuinit build_get_work_registers(u32 **p)
> +static struct work_registers build_get_work_registers(u32 **p)
>  {
>  	struct work_registers r;
>  
> @@ -382,7 +378,7 @@ static struct work_registers __cpuinit build_get_work_registers(u32 **p)
>  	return r;
>  }
>  
> -static void __cpuinit build_restore_work_registers(u32 **p)
> +static void build_restore_work_registers(u32 **p)
>  {
>  	if (scratch_reg > 0) {
>  		UASM_i_MFC0(p, 1, 31, scratch_reg);
> @@ -407,7 +403,7 @@ extern unsigned long pgd_current[];
>  /*
>   * The R3000 TLB handler is simple.
>   */
> -static void __cpuinit build_r3000_tlb_refill_handler(void)
> +static void build_r3000_tlb_refill_handler(void)
>  {
>  	long pgdc = (long)pgd_current;
>  	u32 *p;
> @@ -452,7 +448,7 @@ static void __cpuinit build_r3000_tlb_refill_handler(void)
>   * other one.To keep things simple, we first assume linear space,
>   * then we relocate it to the final handler layout as needed.
>   */
> -static u32 final_handler[64] __cpuinitdata;
> +static u32 final_handler[64];
>  
>  /*
>   * Hazards
> @@ -476,7 +472,7 @@ static u32 final_handler[64] __cpuinitdata;
>   *
>   * As if we MIPS hackers wouldn't know how to nop pipelines happy ...
>   */
> -static void __cpuinit __maybe_unused build_tlb_probe_entry(u32 **p)
> +static void __maybe_unused build_tlb_probe_entry(u32 **p)
>  {
>  	switch (current_cpu_type()) {
>  	/* Found by experiment: R4600 v2.0/R4700 needs this, too.  */
> @@ -500,9 +496,9 @@ static void __cpuinit __maybe_unused build_tlb_probe_entry(u32 **p)
>   */
>  enum tlb_write_entry { tlb_random, tlb_indexed };
>  
> -static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
> -					 struct uasm_reloc **r,
> -					 enum tlb_write_entry wmode)
> +static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
> +				  struct uasm_reloc **r,
> +				  enum tlb_write_entry wmode)
>  {
>  	void(*tlbw)(u32 **) = NULL;
>  
> @@ -636,8 +632,8 @@ static void __cpuinit build_tlb_write_entry(u32 **p, struct uasm_label **l,
>  	}
>  }
>  
> -static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
> -								  unsigned int reg)
> +static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
> +							unsigned int reg)
>  {
>  	if (cpu_has_rixi) {
>  		UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
> @@ -652,11 +648,9 @@ static __cpuinit __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
>  
>  #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
>  
> -static __cpuinit void build_restore_pagemask(u32 **p,
> -					     struct uasm_reloc **r,
> -					     unsigned int tmp,
> -					     enum label_id lid,
> -					     int restore_scratch)
> +static void build_restore_pagemask(u32 **p, struct uasm_reloc **r,
> +				   unsigned int tmp, enum label_id lid,
> +				   int restore_scratch)
>  {
>  	if (restore_scratch) {
>  		/* Reset default page size */
> @@ -695,12 +689,11 @@ static __cpuinit void build_restore_pagemask(u32 **p,
>  	}
>  }
>  
> -static __cpuinit void build_huge_tlb_write_entry(u32 **p,
> -						 struct uasm_label **l,
> -						 struct uasm_reloc **r,
> -						 unsigned int tmp,
> -						 enum tlb_write_entry wmode,
> -						 int restore_scratch)
> +static void build_huge_tlb_write_entry(u32 **p, struct uasm_label **l,
> +				       struct uasm_reloc **r,
> +				       unsigned int tmp,
> +				       enum tlb_write_entry wmode,
> +				       int restore_scratch)
>  {
>  	/* Set huge page tlb entry size */
>  	uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
> @@ -715,9 +708,9 @@ static __cpuinit void build_huge_tlb_write_entry(u32 **p,
>  /*
>   * Check if Huge PTE is present, if so then jump to LABEL.
>   */
> -static void __cpuinit
> +static void
>  build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int tmp,
> -		unsigned int pmd, int lid)
> +		  unsigned int pmd, int lid)
>  {
>  	UASM_i_LW(p, tmp, 0, pmd);
>  	if (use_bbit_insns()) {
> @@ -728,9 +721,8 @@ build_is_huge_pte(u32 **p, struct uasm_reloc **r, unsigned int tmp,
>  	}
>  }
>  
> -static __cpuinit void build_huge_update_entries(u32 **p,
> -						unsigned int pte,
> -						unsigned int tmp)
> +static void build_huge_update_entries(u32 **p, unsigned int pte,
> +				      unsigned int tmp)
>  {
>  	int small_sequence;
>  
> @@ -760,11 +752,10 @@ static __cpuinit void build_huge_update_entries(u32 **p,
>  	UASM_i_MTC0(p, pte, C0_ENTRYLO1); /* load it */
>  }
>  
> -static __cpuinit void build_huge_handler_tail(u32 **p,
> -					      struct uasm_reloc **r,
> -					      struct uasm_label **l,
> -					      unsigned int pte,
> -					      unsigned int ptr)
> +static void build_huge_handler_tail(u32 **p, struct uasm_reloc **r,
> +				    struct uasm_label **l,
> +				    unsigned int pte,
> +				    unsigned int ptr)
>  {
>  #ifdef CONFIG_SMP
>  	UASM_i_SC(p, pte, 0, ptr);
> @@ -783,7 +774,7 @@ static __cpuinit void build_huge_handler_tail(u32 **p,
>   * TMP and PTR are scratch.
>   * TMP will be clobbered, PTR will hold the pmd entry.
>   */
> -static void __cpuinit
> +static void
>  build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>  		 unsigned int tmp, unsigned int ptr)
>  {
> @@ -875,7 +866,7 @@ build_get_pmde64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   * BVADDR is the faulting address, PTR is scratch.
>   * PTR will hold the pgd for vmalloc.
>   */
> -static void __cpuinit
> +static void
>  build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>  			unsigned int bvaddr, unsigned int ptr,
>  			enum vmalloc64_mode mode)
> @@ -945,7 +936,7 @@ build_get_pgd_vmalloc64(u32 **p, struct uasm_label **l, struct uasm_reloc **r,
>   * TMP and PTR are scratch.
>   * TMP will be clobbered, PTR will hold the pgd entry.
>   */
> -static void __cpuinit __maybe_unused
> +static void __maybe_unused
>  build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
>  {
>  	long pgdc = (long)pgd_current;
> @@ -980,7 +971,7 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
>  
>  #endif /* !CONFIG_64BIT */
>  
> -static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
> +static void build_adjust_context(u32 **p, unsigned int ctx)
>  {
>  	unsigned int shift = 4 - (PTE_T_LOG2 + 1) + PAGE_SHIFT - 12;
>  	unsigned int mask = (PTRS_PER_PTE / 2 - 1) << (PTE_T_LOG2 + 1);
> @@ -1006,7 +997,7 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
>  	uasm_i_andi(p, ctx, ctx, mask);
>  }
>  
> -static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
> +static void build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
>  {
>  	/*
>  	 * Bug workaround for the Nevada. It seems as if under certain
> @@ -1031,8 +1022,7 @@ static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr
>  	UASM_i_ADDU(p, ptr, ptr, tmp); /* add in offset */
>  }
>  
> -static void __cpuinit build_update_entries(u32 **p, unsigned int tmp,
> -					unsigned int ptep)
> +static void build_update_entries(u32 **p, unsigned int tmp, unsigned int ptep)
>  {
>  	/*
>  	 * 64bit address support (36bit on a 32bit CPU) in a 32bit
> @@ -1093,7 +1083,7 @@ struct mips_huge_tlb_info {
>  	int restore_scratch;
>  };
>  
> -static struct mips_huge_tlb_info __cpuinit
> +static struct mips_huge_tlb_info
>  build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>  			       struct uasm_reloc **r, unsigned int tmp,
>  			       unsigned int ptr, int c0_scratch)
> @@ -1271,7 +1261,7 @@ build_fast_tlb_refill_handler (u32 **p, struct uasm_label **l,
>   */
>  #define MIPS64_REFILL_INSNS 32
>  
> -static void __cpuinit build_r4000_tlb_refill_handler(void)
> +static void build_r4000_tlb_refill_handler(void)
>  {
>  	u32 *p = tlb_handler;
>  	struct uasm_label *l = labels;
> @@ -1456,7 +1446,7 @@ u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
>  #ifdef CONFIG_MIPS_PGD_C0_CONTEXT
>  u32 tlbmiss_handler_setup_pgd_array[16] __cacheline_aligned;
>  
> -static void __cpuinit build_r4000_setup_pgd(void)
> +static void build_r4000_setup_pgd(void)
>  {
>  	const int a0 = 4;
>  	const int a1 = 5;
> @@ -1504,7 +1494,7 @@ static void __cpuinit build_r4000_setup_pgd(void)
>  }
>  #endif
>  
> -static void __cpuinit
> +static void
>  iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
>  {
>  #ifdef CONFIG_SMP
> @@ -1524,7 +1514,7 @@ iPTE_LW(u32 **p, unsigned int pte, unsigned int ptr)
>  #endif
>  }
>  
> -static void __cpuinit
> +static void
>  iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
>  	unsigned int mode)
>  {
> @@ -1584,7 +1574,7 @@ iPTE_SW(u32 **p, struct uasm_reloc **r, unsigned int pte, unsigned int ptr,
>   * the page table where this PTE is located, PTE will be re-loaded
>   * with it's original value.
>   */
> -static void __cpuinit
> +static void
>  build_pte_present(u32 **p, struct uasm_reloc **r,
>  		  int pte, int ptr, int scratch, enum label_id lid)
>  {
> @@ -1612,7 +1602,7 @@ build_pte_present(u32 **p, struct uasm_reloc **r,
>  }
>  
>  /* Make PTE valid, store result in PTR. */
> -static void __cpuinit
> +static void
>  build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
>  		 unsigned int ptr)
>  {
> @@ -1625,7 +1615,7 @@ build_make_valid(u32 **p, struct uasm_reloc **r, unsigned int pte,
>   * Check if PTE can be written to, if not branch to LABEL. Regardless
>   * restore PTE with value from PTR when done.
>   */
> -static void __cpuinit
> +static void
>  build_pte_writable(u32 **p, struct uasm_reloc **r,
>  		   unsigned int pte, unsigned int ptr, int scratch,
>  		   enum label_id lid)
> @@ -1645,7 +1635,7 @@ build_pte_writable(u32 **p, struct uasm_reloc **r,
>  /* Make PTE writable, update software status bits as well, then store
>   * at PTR.
>   */
> -static void __cpuinit
> +static void
>  build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
>  		 unsigned int ptr)
>  {
> @@ -1659,7 +1649,7 @@ build_make_write(u32 **p, struct uasm_reloc **r, unsigned int pte,
>   * Check if PTE can be modified, if not branch to LABEL. Regardless
>   * restore PTE with value from PTR when done.
>   */
> -static void __cpuinit
> +static void
>  build_pte_modifiable(u32 **p, struct uasm_reloc **r,
>  		     unsigned int pte, unsigned int ptr, int scratch,
>  		     enum label_id lid)
> @@ -1688,7 +1678,7 @@ build_pte_modifiable(u32 **p, struct uasm_reloc **r,
>   * This places the pte into ENTRYLO0 and writes it with tlbwi.
>   * Then it returns.
>   */
> -static void __cpuinit
> +static void
>  build_r3000_pte_reload_tlbwi(u32 **p, unsigned int pte, unsigned int tmp)
>  {
>  	uasm_i_mtc0(p, pte, C0_ENTRYLO0); /* cp0 delay */
> @@ -1704,7 +1694,7 @@ build_r3000_pte_reload_tlbwi(u32 **p, unsigned int pte, unsigned int tmp)
>   * may have the probe fail bit set as a result of a trap on a
>   * kseg2 access, i.e. without refill.  Then it returns.
>   */
> -static void __cpuinit
> +static void
>  build_r3000_tlb_reload_write(u32 **p, struct uasm_label **l,
>  			     struct uasm_reloc **r, unsigned int pte,
>  			     unsigned int tmp)
> @@ -1722,7 +1712,7 @@ build_r3000_tlb_reload_write(u32 **p, struct uasm_label **l,
>  	uasm_i_rfe(p); /* branch delay */
>  }
>  
> -static void __cpuinit
> +static void
>  build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
>  				   unsigned int ptr)
>  {
> @@ -1742,7 +1732,7 @@ build_r3000_tlbchange_handler_head(u32 **p, unsigned int pte,
>  	uasm_i_tlbp(p); /* load delay */
>  }
>  
> -static void __cpuinit build_r3000_tlb_load_handler(void)
> +static void build_r3000_tlb_load_handler(void)
>  {
>  	u32 *p = handle_tlbl;
>  	struct uasm_label *l = labels;
> @@ -1772,7 +1762,7 @@ static void __cpuinit build_r3000_tlb_load_handler(void)
>  	dump_handler("r3000_tlb_load", handle_tlbl, ARRAY_SIZE(handle_tlbl));
>  }
>  
> -static void __cpuinit build_r3000_tlb_store_handler(void)
> +static void build_r3000_tlb_store_handler(void)
>  {
>  	u32 *p = handle_tlbs;
>  	struct uasm_label *l = labels;
> @@ -1802,7 +1792,7 @@ static void __cpuinit build_r3000_tlb_store_handler(void)
>  	dump_handler("r3000_tlb_store", handle_tlbs, ARRAY_SIZE(handle_tlbs));
>  }
>  
> -static void __cpuinit build_r3000_tlb_modify_handler(void)
> +static void build_r3000_tlb_modify_handler(void)
>  {
>  	u32 *p = handle_tlbm;
>  	struct uasm_label *l = labels;
> @@ -1836,7 +1826,7 @@ static void __cpuinit build_r3000_tlb_modify_handler(void)
>  /*
>   * R4000 style TLB load/store/modify handlers.
>   */
> -static struct work_registers __cpuinit
> +static struct work_registers
>  build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
>  				   struct uasm_reloc **r)
>  {
> @@ -1872,7 +1862,7 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
>  	return wr;
>  }
>  
> -static void __cpuinit
> +static void
>  build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>  				   struct uasm_reloc **r, unsigned int tmp,
>  				   unsigned int ptr)
> @@ -1890,7 +1880,7 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
>  #endif
>  }
>  
> -static void __cpuinit build_r4000_tlb_load_handler(void)
> +static void build_r4000_tlb_load_handler(void)
>  {
>  	u32 *p = handle_tlbl;
>  	struct uasm_label *l = labels;
> @@ -2046,7 +2036,7 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
>  	dump_handler("r4000_tlb_load", handle_tlbl, ARRAY_SIZE(handle_tlbl));
>  }
>  
> -static void __cpuinit build_r4000_tlb_store_handler(void)
> +static void build_r4000_tlb_store_handler(void)
>  {
>  	u32 *p = handle_tlbs;
>  	struct uasm_label *l = labels;
> @@ -2100,7 +2090,7 @@ static void __cpuinit build_r4000_tlb_store_handler(void)
>  	dump_handler("r4000_tlb_store", handle_tlbs, ARRAY_SIZE(handle_tlbs));
>  }
>  
> -static void __cpuinit build_r4000_tlb_modify_handler(void)
> +static void build_r4000_tlb_modify_handler(void)
>  {
>  	u32 *p = handle_tlbm;
>  	struct uasm_label *l = labels;
> @@ -2155,7 +2145,7 @@ static void __cpuinit build_r4000_tlb_modify_handler(void)
>  	dump_handler("r4000_tlb_modify", handle_tlbm, ARRAY_SIZE(handle_tlbm));
>  }
>  
> -void __cpuinit build_tlb_refill_handler(void)
> +void build_tlb_refill_handler(void)
>  {
>  	/*
>  	 * The refill handler is generated per-CPU, multi-node systems
> @@ -2221,7 +2211,7 @@ void __cpuinit build_tlb_refill_handler(void)
>  	}
>  }
>  
> -void __cpuinit flush_tlb_handlers(void)
> +void flush_tlb_handlers(void)
>  {
>  	local_flush_icache_range((unsigned long)handle_tlbl,
>  			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
> diff --git a/arch/mips/mm/uasm-micromips.c b/arch/mips/mm/uasm-micromips.c
> index 162ee6d..060000f 100644
> --- a/arch/mips/mm/uasm-micromips.c
> +++ b/arch/mips/mm/uasm-micromips.c
> @@ -49,7 +49,7 @@
>  
>  #include "uasm.c"
>  
> -static struct insn insn_table_MM[] __uasminitdata = {
> +static struct insn insn_table_MM[] = {
>  	{ insn_addu, M(mm_pool32a_op, 0, 0, 0, 0, mm_addu32_op), RT | RS | RD },
>  	{ insn_addiu, M(mm_addiu32_op, 0, 0, 0, 0, 0), RT | RS | SIMM },
>  	{ insn_and, M(mm_pool32a_op, 0, 0, 0, 0, mm_and_op), RT | RS | RD },
> @@ -118,7 +118,7 @@ static struct insn insn_table_MM[] __uasminitdata = {
>  
>  #undef M
>  
> -static inline __uasminit u32 build_bimm(s32 arg)
> +static inline u32 build_bimm(s32 arg)
>  {
>  	WARN(arg > 0xffff || arg < -0x10000,
>  	     KERN_WARNING "Micro-assembler field overflow\n");
> @@ -128,7 +128,7 @@ static inline __uasminit u32 build_bimm(s32 arg)
>  	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 1) & 0x7fff);
>  }
>  
> -static inline __uasminit u32 build_jimm(u32 arg)
> +static inline u32 build_jimm(u32 arg)
>  {
>  
>  	WARN(arg & ~((JIMM_MASK << 2) | 1),
> @@ -141,7 +141,7 @@ static inline __uasminit u32 build_jimm(u32 arg)
>   * The order of opcode arguments is implicitly left to right,
>   * starting with RS and ending with FUNC or IMM.
>   */
> -static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
> +static void build_insn(u32 **buf, enum opcode opc, ...)
>  {
>  	struct insn *ip = NULL;
>  	unsigned int i;
> @@ -199,7 +199,7 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
>  	(*buf)++;
>  }
>  
> -static inline void __uasminit
> +static inline void
>  __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
>  {
>  	long laddr = (long)lab->addr;
> diff --git a/arch/mips/mm/uasm-mips.c b/arch/mips/mm/uasm-mips.c
> index 5fcdd8f..0c72458 100644
> --- a/arch/mips/mm/uasm-mips.c
> +++ b/arch/mips/mm/uasm-mips.c
> @@ -49,7 +49,7 @@
>  
>  #include "uasm.c"
>  
> -static struct insn insn_table[] __uasminitdata = {
> +static struct insn insn_table[] = {
>  	{ insn_addiu, M(addiu_op, 0, 0, 0, 0, 0), RS | RT | SIMM },
>  	{ insn_addu, M(spec_op, 0, 0, 0, 0, addu_op), RS | RT | RD },
>  	{ insn_andi, M(andi_op, 0, 0, 0, 0, 0), RS | RT | UIMM },
> @@ -119,7 +119,7 @@ static struct insn insn_table[] __uasminitdata = {
>  
>  #undef M
>  
> -static inline __uasminit u32 build_bimm(s32 arg)
> +static inline u32 build_bimm(s32 arg)
>  {
>  	WARN(arg > 0x1ffff || arg < -0x20000,
>  	     KERN_WARNING "Micro-assembler field overflow\n");
> @@ -129,7 +129,7 @@ static inline __uasminit u32 build_bimm(s32 arg)
>  	return ((arg < 0) ? (1 << 15) : 0) | ((arg >> 2) & 0x7fff);
>  }
>  
> -static inline __uasminit u32 build_jimm(u32 arg)
> +static inline u32 build_jimm(u32 arg)
>  {
>  	WARN(arg & ~(JIMM_MASK << 2),
>  	     KERN_WARNING "Micro-assembler field overflow\n");
> @@ -141,7 +141,7 @@ static inline __uasminit u32 build_jimm(u32 arg)
>   * The order of opcode arguments is implicitly left to right,
>   * starting with RS and ending with FUNC or IMM.
>   */
> -static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
> +static void build_insn(u32 **buf, enum opcode opc, ...)
>  {
>  	struct insn *ip = NULL;
>  	unsigned int i;
> @@ -187,7 +187,7 @@ static void __uasminit build_insn(u32 **buf, enum opcode opc, ...)
>  	(*buf)++;
>  }
>  
> -static inline void __uasminit
> +static inline void
>  __resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab)
>  {
>  	long laddr = (long)lab->addr;
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 7eb5e43..b9d14b6 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -63,35 +63,35 @@ struct insn {
>  	enum fields fields;
>  };
>  
> -static inline __uasminit u32 build_rs(u32 arg)
> +static inline u32 build_rs(u32 arg)
>  {
>  	WARN(arg & ~RS_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return (arg & RS_MASK) << RS_SH;
>  }
>  
> -static inline __uasminit u32 build_rt(u32 arg)
> +static inline u32 build_rt(u32 arg)
>  {
>  	WARN(arg & ~RT_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return (arg & RT_MASK) << RT_SH;
>  }
>  
> -static inline __uasminit u32 build_rd(u32 arg)
> +static inline u32 build_rd(u32 arg)
>  {
>  	WARN(arg & ~RD_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return (arg & RD_MASK) << RD_SH;
>  }
>  
> -static inline __uasminit u32 build_re(u32 arg)
> +static inline u32 build_re(u32 arg)
>  {
>  	WARN(arg & ~RE_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return (arg & RE_MASK) << RE_SH;
>  }
>  
> -static inline __uasminit u32 build_simm(s32 arg)
> +static inline u32 build_simm(s32 arg)
>  {
>  	WARN(arg > 0x7fff || arg < -0x8000,
>  	     KERN_WARNING "Micro-assembler field overflow\n");
> @@ -99,14 +99,14 @@ static inline __uasminit u32 build_simm(s32 arg)
>  	return arg & 0xffff;
>  }
>  
> -static inline __uasminit u32 build_uimm(u32 arg)
> +static inline u32 build_uimm(u32 arg)
>  {
>  	WARN(arg & ~IMM_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return arg & IMM_MASK;
>  }
>  
> -static inline __uasminit u32 build_scimm(u32 arg)
> +static inline u32 build_scimm(u32 arg)
>  {
>  	WARN(arg & ~SCIMM_MASK,
>  	     KERN_WARNING "Micro-assembler field overflow\n");
> @@ -114,21 +114,21 @@ static inline __uasminit u32 build_scimm(u32 arg)
>  	return (arg & SCIMM_MASK) << SCIMM_SH;
>  }
>  
> -static inline __uasminit u32 build_func(u32 arg)
> +static inline u32 build_func(u32 arg)
>  {
>  	WARN(arg & ~FUNC_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return arg & FUNC_MASK;
>  }
>  
> -static inline __uasminit u32 build_set(u32 arg)
> +static inline u32 build_set(u32 arg)
>  {
>  	WARN(arg & ~SET_MASK, KERN_WARNING "Micro-assembler field overflow\n");
>  
>  	return arg & SET_MASK;
>  }
>  
> -static void __uasminit build_insn(u32 **buf, enum opcode opc, ...);
> +static void build_insn(u32 **buf, enum opcode opc, ...);
>  
>  #define I_u1u2u3(op)					\
>  Ip_u1u2u3(op)						\
> @@ -286,7 +286,7 @@ I_u3u1u2(_ldx)
>  
>  #ifdef CONFIG_CPU_CAVIUM_OCTEON
>  #include <asm/octeon/octeon.h>
> -void __uasminit ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
> +void ISAFUNC(uasm_i_pref)(u32 **buf, unsigned int a, signed int b,
>  			    unsigned int c)
>  {
>  	if (OCTEON_IS_MODEL(OCTEON_CN63XX_PASS1_X) && a <= 24 && a != 5)
> @@ -304,7 +304,7 @@ I_u2s3u1(_pref)
>  #endif
>  
>  /* Handle labels. */
> -void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
> +void ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, int lid)
>  {
>  	(*lab)->addr = addr;
>  	(*lab)->lab = lid;
> @@ -312,7 +312,7 @@ void __uasminit ISAFUNC(uasm_build_label)(struct uasm_label **lab, u32 *addr, in
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_build_label));
>  
> -int __uasminit ISAFUNC(uasm_in_compat_space_p)(long addr)
> +int ISAFUNC(uasm_in_compat_space_p)(long addr)
>  {
>  	/* Is this address in 32bit compat space? */
>  #ifdef CONFIG_64BIT
> @@ -323,7 +323,7 @@ int __uasminit ISAFUNC(uasm_in_compat_space_p)(long addr)
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_in_compat_space_p));
>  
> -static int __uasminit uasm_rel_highest(long val)
> +static int uasm_rel_highest(long val)
>  {
>  #ifdef CONFIG_64BIT
>  	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
> @@ -332,7 +332,7 @@ static int __uasminit uasm_rel_highest(long val)
>  #endif
>  }
>  
> -static int __uasminit uasm_rel_higher(long val)
> +static int uasm_rel_higher(long val)
>  {
>  #ifdef CONFIG_64BIT
>  	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
> @@ -341,19 +341,19 @@ static int __uasminit uasm_rel_higher(long val)
>  #endif
>  }
>  
> -int __uasminit ISAFUNC(uasm_rel_hi)(long val)
> +int ISAFUNC(uasm_rel_hi)(long val)
>  {
>  	return ((((val + 0x8000L) >> 16) & 0xffff) ^ 0x8000) - 0x8000;
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_hi));
>  
> -int __uasminit ISAFUNC(uasm_rel_lo)(long val)
> +int ISAFUNC(uasm_rel_lo)(long val)
>  {
>  	return ((val & 0xffff) ^ 0x8000) - 0x8000;
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_rel_lo));
>  
> -void __uasminit ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
> +void ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
>  {
>  	if (!ISAFUNC(uasm_in_compat_space_p)(addr)) {
>  		ISAFUNC(uasm_i_lui)(buf, rs, uasm_rel_highest(addr));
> @@ -371,7 +371,7 @@ void __uasminit ISAFUNC(UASM_i_LA_mostly)(u32 **buf, unsigned int rs, long addr)
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA_mostly));
>  
> -void __uasminit ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
> +void ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
>  {
>  	ISAFUNC(UASM_i_LA_mostly)(buf, rs, addr);
>  	if (ISAFUNC(uasm_rel_lo(addr))) {
> @@ -386,8 +386,7 @@ void __uasminit ISAFUNC(UASM_i_LA)(u32 **buf, unsigned int rs, long addr)
>  UASM_EXPORT_SYMBOL(ISAFUNC(UASM_i_LA));
>  
>  /* Handle relocations. */
> -void __uasminit
> -ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
> +void ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
>  {
>  	(*rel)->addr = addr;
>  	(*rel)->type = R_MIPS_PC16;
> @@ -396,11 +395,11 @@ ISAFUNC(uasm_r_mips_pc16)(struct uasm_reloc **rel, u32 *addr, int lid)
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_r_mips_pc16));
>  
> -static inline void __uasminit
> -__resolve_relocs(struct uasm_reloc *rel, struct uasm_label *lab);
> +static inline void __resolve_relocs(struct uasm_reloc *rel,
> +				    struct uasm_label *lab);
>  
> -void __uasminit
> -ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel, struct uasm_label *lab)
> +void ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel,
> +				  struct uasm_label *lab)
>  {
>  	struct uasm_label *l;
>  
> @@ -411,8 +410,8 @@ ISAFUNC(uasm_resolve_relocs)(struct uasm_reloc *rel, struct uasm_label *lab)
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_resolve_relocs));
>  
> -void __uasminit
> -ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end, long off)
> +void ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end,
> +			       long off)
>  {
>  	for (; rel->lab != UASM_LABEL_INVALID; rel++)
>  		if (rel->addr >= first && rel->addr < end)
> @@ -420,8 +419,8 @@ ISAFUNC(uasm_move_relocs)(struct uasm_reloc *rel, u32 *first, u32 *end, long off
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_relocs));
>  
> -void __uasminit
> -ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end, long off)
> +void ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end,
> +			       long off)
>  {
>  	for (; lab->lab != UASM_LABEL_INVALID; lab++)
>  		if (lab->addr >= first && lab->addr < end)
> @@ -429,9 +428,8 @@ ISAFUNC(uasm_move_labels)(struct uasm_label *lab, u32 *first, u32 *end, long off
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_move_labels));
>  
> -void __uasminit
> -ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab, u32 *first,
> -		  u32 *end, u32 *target)
> +void ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab,
> +				u32 *first, u32 *end, u32 *target)
>  {
>  	long off = (long)(target - first);
>  
> @@ -442,7 +440,7 @@ ISAFUNC(uasm_copy_handler)(struct uasm_reloc *rel, struct uasm_label *lab, u32 *
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_copy_handler));
>  
> -int __uasminit ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
> +int ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
>  {
>  	for (; rel->lab != UASM_LABEL_INVALID; rel++) {
>  		if (rel->addr == addr
> @@ -456,83 +454,79 @@ int __uasminit ISAFUNC(uasm_insn_has_bdelay)(struct uasm_reloc *rel, u32 *addr)
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_insn_has_bdelay));
>  
>  /* Convenience functions for labeled branches. */
> -void __uasminit
> -ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_bltz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			   int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bltz)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bltz));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
> +void ISAFUNC(uasm_il_b)(u32 **p, struct uasm_reloc **r, int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_b)(p, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_b));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_beqz)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			   int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_beqz)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqz));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_beqzl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			    int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_beqzl)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_beqzl));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
> -	unsigned int reg2, int lid)
> +void ISAFUNC(uasm_il_bne)(u32 **p, struct uasm_reloc **r, unsigned int reg1,
> +			  unsigned int reg2, int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bne)(p, reg1, reg2, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bne));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_bnez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			   int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bnez)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bnez));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_bgezl)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			    int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bgezl)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgezl));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg, int lid)
> +void ISAFUNC(uasm_il_bgez)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			   int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bgez)(p, reg, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bgez));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> -	      unsigned int bit, int lid)
> +void ISAFUNC(uasm_il_bbit0)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			    unsigned int bit, int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bbit0)(p, reg, bit, 0);
>  }
>  UASM_EXPORT_SYMBOL(ISAFUNC(uasm_il_bbit0));
>  
> -void __uasminit
> -ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> -	      unsigned int bit, int lid)
> +void ISAFUNC(uasm_il_bbit1)(u32 **p, struct uasm_reloc **r, unsigned int reg,
> +			    unsigned int bit, int lid)
>  {
>  	uasm_r_mips_pc16(r, *p, lid);
>  	ISAFUNC(uasm_i_bbit1)(p, reg, bit, 0);
> diff --git a/arch/mips/mti-malta/malta-smtc.c b/arch/mips/mti-malta/malta-smtc.c
> index becbf47..c484990 100644
> --- a/arch/mips/mti-malta/malta-smtc.c
> +++ b/arch/mips/mti-malta/malta-smtc.c
> @@ -32,7 +32,7 @@ static void msmtc_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>  /*
>   * Post-config but pre-boot cleanup entry point
>   */
> -static void __cpuinit msmtc_init_secondary(void)
> +static void msmtc_init_secondary(void)
>  {
>  	int myvpe;
>  
> @@ -53,7 +53,7 @@ static void __cpuinit msmtc_init_secondary(void)
>  /*
>   * Platform "CPU" startup hook
>   */
> -static void __cpuinit msmtc_boot_secondary(int cpu, struct task_struct *idle)
> +static void msmtc_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	smtc_boot_secondary(cpu, idle);
>  }
> @@ -61,7 +61,7 @@ static void __cpuinit msmtc_boot_secondary(int cpu, struct task_struct *idle)
>  /*
>   * SMP initialization finalization entry point
>   */
> -static void __cpuinit msmtc_smp_finish(void)
> +static void msmtc_smp_finish(void)
>  {
>  	smtc_smp_finish();
>  }
> diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
> index 0ad305f..53aad4a 100644
> --- a/arch/mips/mti-malta/malta-time.c
> +++ b/arch/mips/mti-malta/malta-time.c
> @@ -150,7 +150,7 @@ static void __init plat_perf_setup(void)
>  	}
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  #ifdef MSC01E_INT_BASE
>  	if (cpu_has_veic) {
> diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
> index 96b42eb..a43ea3c 100644
> --- a/arch/mips/mti-sead3/sead3-time.c
> +++ b/arch/mips/mti-sead3/sead3-time.c
> @@ -91,7 +91,7 @@ static void __init plat_perf_setup(void)
>  	}
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	if (cpu_has_vint)
>  		set_vi_handler(cp0_compare_irq, mips_timer_dispatch);
> diff --git a/arch/mips/netlogic/common/smp.c b/arch/mips/netlogic/common/smp.c
> index ffba524..c01d554 100644
> --- a/arch/mips/netlogic/common/smp.c
> +++ b/arch/mips/netlogic/common/smp.c
> @@ -116,7 +116,7 @@ void nlm_early_init_secondary(int cpu)
>  /*
>   * Code to run on secondary just after probing the CPU
>   */
> -static void __cpuinit nlm_init_secondary(void)
> +static void nlm_init_secondary(void)
>  {
>  	int hwtid;
>  
> @@ -252,7 +252,7 @@ unsupp:
>  	return 0;
>  }
>  
> -int __cpuinit nlm_wakeup_secondary_cpus(void)
> +int nlm_wakeup_secondary_cpus(void)
>  {
>  	unsigned long reset_vec;
>  	char *reset_data;
> diff --git a/arch/mips/netlogic/common/smpboot.S b/arch/mips/netlogic/common/smpboot.S
> index 0265174..cd06863 100644
> --- a/arch/mips/netlogic/common/smpboot.S
> +++ b/arch/mips/netlogic/common/smpboot.S
> @@ -255,7 +255,6 @@ FEXPORT(xlp_boot_core0_siblings)	/* "Master" cpu starts from here */
>  	nop
>  	/* not reached */
>  
> -	__CPUINIT
>  NESTED(nlm_boot_secondary_cpus, 16, sp)
>  	/* Initialize CP0 Status */
>  	move	t1, zero
> @@ -279,7 +278,6 @@ NESTED(nlm_boot_secondary_cpus, 16, sp)
>  	jr	t0
>  	nop
>  END(nlm_boot_secondary_cpus)
> -	__FINIT
>  
>  /*
>   * In case of RMIboot bootloader which is used on XLR boards, the CPUs
> @@ -287,7 +285,6 @@ END(nlm_boot_secondary_cpus)
>   * This will get them out of the bootloader code and into linux. Needed
>   *  because the bootloader area will be taken and initialized by linux.
>   */
> -	__CPUINIT
>  NESTED(nlm_rmiboot_preboot, 16, sp)
>  	mfc0	t0, $15, 1	/* read ebase */
>  	andi	t0, 0x1f	/* t0 has the processor_id() */
> @@ -324,4 +321,3 @@ NESTED(nlm_rmiboot_preboot, 16, sp)
>  	j	1b
>  	nop
>  END(nlm_rmiboot_preboot)
> -	__FINIT
> diff --git a/arch/mips/netlogic/common/time.c b/arch/mips/netlogic/common/time.c
> index 5c56555..045a396 100644
> --- a/arch/mips/netlogic/common/time.c
> +++ b/arch/mips/netlogic/common/time.c
> @@ -54,7 +54,7 @@
>  #error "Unknown CPU"
>  #endif
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	return IRQ_TIMER;
>  }
> diff --git a/arch/mips/netlogic/xlr/wakeup.c b/arch/mips/netlogic/xlr/wakeup.c
> index 3ebf741..37a4092 100644
> --- a/arch/mips/netlogic/xlr/wakeup.c
> +++ b/arch/mips/netlogic/xlr/wakeup.c
> @@ -49,7 +49,7 @@
>  #include <asm/netlogic/xlr/iomap.h>
>  #include <asm/netlogic/xlr/pic.h>
>  
> -int __cpuinit xlr_wakeup_secondary_cpus(void)
> +int xlr_wakeup_secondary_cpus(void)
>  {
>  	struct nlm_soc_info *nodep;
>  	unsigned int i, j, boot_cpu;
> diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
> index 6eb65e4..2946bdf 100644
> --- a/arch/mips/pci/pci-ip27.c
> +++ b/arch/mips/pci/pci-ip27.c
> @@ -42,7 +42,7 @@ int irq_to_slot[MAX_PCI_BUSSES * MAX_DEVICES_PER_PCIBUS];
>  
>  extern struct pci_ops bridge_pci_ops;
>  
> -int __cpuinit bridge_probe(nasid_t nasid, int widget_id, int masterwid)
> +int bridge_probe(nasid_t nasid, int widget_id, int masterwid)
>  {
>  	unsigned long offset = NODE_OFFSET(nasid);
>  	struct bridge_controller *bc;
> diff --git a/arch/mips/pmcs-msp71xx/msp_smtc.c b/arch/mips/pmcs-msp71xx/msp_smtc.c
> index c8dcc1c..6b5607f 100644
> --- a/arch/mips/pmcs-msp71xx/msp_smtc.c
> +++ b/arch/mips/pmcs-msp71xx/msp_smtc.c
> @@ -33,7 +33,7 @@ static void msp_smtc_send_ipi_mask(const struct cpumask *mask,
>  /*
>   * Post-config but pre-boot cleanup entry point
>   */
> -static void __cpuinit msp_smtc_init_secondary(void)
> +static void msp_smtc_init_secondary(void)
>  {
>  	int myvpe;
>  
> @@ -48,8 +48,7 @@ static void __cpuinit msp_smtc_init_secondary(void)
>  /*
>   * Platform "CPU" startup hook
>   */
> -static void __cpuinit msp_smtc_boot_secondary(int cpu,
> -					struct task_struct *idle)
> +static void msp_smtc_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	smtc_boot_secondary(cpu, idle);
>  }
> @@ -57,7 +56,7 @@ static void __cpuinit msp_smtc_boot_secondary(int cpu,
>  /*
>   * SMP initialization finalization entry point
>   */
> -static void __cpuinit msp_smtc_smp_finish(void)
> +static void msp_smtc_smp_finish(void)
>  {
>  	smtc_smp_finish();
>  }
> diff --git a/arch/mips/pmcs-msp71xx/msp_time.c b/arch/mips/pmcs-msp71xx/msp_time.c
> index 8f12ecc..fea917b 100644
> --- a/arch/mips/pmcs-msp71xx/msp_time.c
> +++ b/arch/mips/pmcs-msp71xx/msp_time.c
> @@ -88,7 +88,7 @@ void __init plat_time_init(void)
>  	mips_hpt_frequency = cpu_rate/2;
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	/* MIPS_MT modes may want timer for second VPE */
>  	if ((get_current_vpe()) && !tim_installed) {
> diff --git a/arch/mips/pnx833x/common/interrupts.c b/arch/mips/pnx833x/common/interrupts.c
> index a4a9059..e460865 100644
> --- a/arch/mips/pnx833x/common/interrupts.c
> +++ b/arch/mips/pnx833x/common/interrupts.c
> @@ -281,7 +281,7 @@ void __init arch_init_irq(void)
>  	write_c0_status(read_c0_status() | IE_IRQ2);
>  }
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	if (cpu_has_vint)
>  		set_vi_handler(cp0_compare_irq, pnx833x_timer_dispatch);
> diff --git a/arch/mips/powertv/time.c b/arch/mips/powertv/time.c
> index 9fd7b67..f38b0d4 100644
> --- a/arch/mips/powertv/time.c
> +++ b/arch/mips/powertv/time.c
> @@ -25,7 +25,7 @@
>  
>  #include "powertv-clock.h"
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	return irq_mips_timer;
>  }
> diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
> index 320b1f1..781b3d1 100644
> --- a/arch/mips/ralink/irq.c
> +++ b/arch/mips/ralink/irq.c
> @@ -73,7 +73,7 @@ static struct irq_chip ralink_intc_irq_chip = {
>  	.irq_mask_ack	= ralink_intc_irq_mask,
>  };
>  
> -unsigned int __cpuinit get_c0_compare_int(void)
> +unsigned int get_c0_compare_int(void)
>  {
>  	return CP0_LEGACY_COMPARE_IRQ;
>  }
> diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
> index d41b1c6..ee736bd 100644
> --- a/arch/mips/sgi-ip27/ip27-init.c
> +++ b/arch/mips/sgi-ip27/ip27-init.c
> @@ -54,7 +54,7 @@ extern void pcibr_setup(cnodeid_t);
>  
>  extern void xtalk_probe_node(cnodeid_t nid);
>  
> -static void __cpuinit per_hub_init(cnodeid_t cnode)
> +static void per_hub_init(cnodeid_t cnode)
>  {
>  	struct hub_data *hub = hub_data(cnode);
>  	nasid_t nasid = COMPACT_TO_NASID_NODEID(cnode);
> @@ -110,7 +110,7 @@ static void __cpuinit per_hub_init(cnodeid_t cnode)
>  	}
>  }
>  
> -void __cpuinit per_cpu_init(void)
> +void per_cpu_init(void)
>  {
>  	int cpu = smp_processor_id();
>  	int slice = LOCAL_HUB_L(PI_CPU_NUM);
> diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
> index f946381..f4ea8aa 100644
> --- a/arch/mips/sgi-ip27/ip27-smp.c
> +++ b/arch/mips/sgi-ip27/ip27-smp.c
> @@ -173,12 +173,12 @@ static void ip27_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>  		ip27_send_ipi_single(i, action);
>  }
>  
> -static void __cpuinit ip27_init_secondary(void)
> +static void ip27_init_secondary(void)
>  {
>  	per_cpu_init();
>  }
>  
> -static void __cpuinit ip27_smp_finish(void)
> +static void ip27_smp_finish(void)
>  {
>  	extern void hub_rt_clock_event_init(void);
>  
> @@ -195,7 +195,7 @@ static void __init ip27_cpus_done(void)
>   * set sp to the kernel stack of the newly created idle process, gp to the proc
>   * struct so that current_thread_info() will work.
>   */
> -static void __cpuinit ip27_boot_secondary(int cpu, struct task_struct *idle)
> +static void ip27_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	unsigned long gp = (unsigned long)task_thread_info(idle);
>  	unsigned long sp = __KSTK_TOS(idle);
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 2e21b76..1d97eab 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -106,7 +106,7 @@ struct irqaction hub_rt_irqaction = {
>  #define NSEC_PER_CYCLE		800
>  #define CYCLES_PER_SEC		(NSEC_PER_SEC / NSEC_PER_CYCLE)
>  
> -void __cpuinit hub_rt_clock_event_init(void)
> +void hub_rt_clock_event_init(void)
>  {
>  	unsigned int cpu = smp_processor_id();
>  	struct clock_event_device *cd = &per_cpu(hub_rt_clockevent, cpu);
> @@ -173,7 +173,7 @@ void __init plat_time_init(void)
>  	hub_rt_clock_event_init();
>  }
>  
> -void __cpuinit cpu_time_init(void)
> +void cpu_time_init(void)
>  {
>  	lboard_t *board;
>  	klcpu_t *cpu;
> @@ -194,7 +194,7 @@ void __cpuinit cpu_time_init(void)
>  	set_c0_status(SRB_TIMOCLK);
>  }
>  
> -void __cpuinit hub_rtc_init(cnodeid_t cnode)
> +void hub_rtc_init(cnodeid_t cnode)
>  {
>  
>  	/*
> diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
> index a4df7d0..d59b820 100644
> --- a/arch/mips/sgi-ip27/ip27-xtalk.c
> +++ b/arch/mips/sgi-ip27/ip27-xtalk.c
> @@ -23,7 +23,7 @@
>  
>  extern int bridge_probe(nasid_t nasid, int widget, int masterwid);
>  
> -static int __cpuinit probe_one_port(nasid_t nasid, int widget, int masterwid)
> +static int probe_one_port(nasid_t nasid, int widget, int masterwid)
>  {
>  	widgetreg_t		widget_id;
>  	xwidget_part_num_t	partnum;
> @@ -47,7 +47,7 @@ static int __cpuinit probe_one_port(nasid_t nasid, int widget, int masterwid)
>  	return 0;
>  }
>  
> -static int __cpuinit xbow_probe(nasid_t nasid)
> +static int xbow_probe(nasid_t nasid)
>  {
>  	lboard_t *brd;
>  	klxbow_t *xbow_p;
> @@ -100,7 +100,7 @@ static int __cpuinit xbow_probe(nasid_t nasid)
>  	return 0;
>  }
>  
> -void __cpuinit xtalk_probe_node(cnodeid_t nid)
> +void xtalk_probe_node(cnodeid_t nid)
>  {
>  	volatile u64		hubreg;
>  	nasid_t			nasid;
> diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
> index de88e22..54e2c4d 100644
> --- a/arch/mips/sibyte/bcm1480/smp.c
> +++ b/arch/mips/sibyte/bcm1480/smp.c
> @@ -60,7 +60,7 @@ static void *mailbox_0_regs[] = {
>  /*
>   * SMP init and finish on secondary CPUs
>   */
> -void __cpuinit bcm1480_smp_init(void)
> +void bcm1480_smp_init(void)
>  {
>  	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
>  		STATUSF_IP1 | STATUSF_IP0;
> @@ -95,7 +95,7 @@ static void bcm1480_send_ipi_mask(const struct cpumask *mask,
>  /*
>   * Code to run on secondary just after probing the CPU
>   */
> -static void __cpuinit bcm1480_init_secondary(void)
> +static void bcm1480_init_secondary(void)
>  {
>  	extern void bcm1480_smp_init(void);
>  
> @@ -106,7 +106,7 @@ static void __cpuinit bcm1480_init_secondary(void)
>   * Do any tidying up before marking online and running the idle
>   * loop
>   */
> -static void __cpuinit bcm1480_smp_finish(void)
> +static void bcm1480_smp_finish(void)
>  {
>  	extern void sb1480_clockevent_init(void);
>  
> @@ -125,7 +125,7 @@ static void bcm1480_cpus_done(void)
>   * Setup the PC, SP, and GP of a secondary processor and start it
>   * running!
>   */
> -static void __cpuinit bcm1480_boot_secondary(int cpu, struct task_struct *idle)
> +static void bcm1480_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	int retval;
>  
> diff --git a/arch/mips/sibyte/sb1250/smp.c b/arch/mips/sibyte/sb1250/smp.c
> index 285cfef..d7b942d 100644
> --- a/arch/mips/sibyte/sb1250/smp.c
> +++ b/arch/mips/sibyte/sb1250/smp.c
> @@ -48,7 +48,7 @@ static void *mailbox_regs[] = {
>  /*
>   * SMP init and finish on secondary CPUs
>   */
> -void __cpuinit sb1250_smp_init(void)
> +void sb1250_smp_init(void)
>  {
>  	unsigned int imask = STATUSF_IP4 | STATUSF_IP3 | STATUSF_IP2 |
>  		STATUSF_IP1 | STATUSF_IP0;
> @@ -83,7 +83,7 @@ static inline void sb1250_send_ipi_mask(const struct cpumask *mask,
>  /*
>   * Code to run on secondary just after probing the CPU
>   */
> -static void __cpuinit sb1250_init_secondary(void)
> +static void sb1250_init_secondary(void)
>  {
>  	extern void sb1250_smp_init(void);
>  
> @@ -94,7 +94,7 @@ static void __cpuinit sb1250_init_secondary(void)
>   * Do any tidying up before marking online and running the idle
>   * loop
>   */
> -static void __cpuinit sb1250_smp_finish(void)
> +static void sb1250_smp_finish(void)
>  {
>  	extern void sb1250_clockevent_init(void);
>  
> @@ -113,7 +113,7 @@ static void sb1250_cpus_done(void)
>   * Setup the PC, SP, and GP of a secondary processor and start it
>   * running!
>   */
> -static void __cpuinit sb1250_boot_secondary(int cpu, struct task_struct *idle)
> +static void sb1250_boot_secondary(int cpu, struct task_struct *idle)
>  {
>  	int retval;
>  
