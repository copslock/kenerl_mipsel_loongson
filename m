Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jan 2014 18:08:07 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:43328 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827312AbaAERGAL3tKI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jan 2014 18:06:00 +0100
Received: from [2001:470:d4ed:0:ea11:32ff:fea1:831a] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr9B-0006HI-VU; Sun, 05 Jan 2014 18:05:58 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr99-0004Sd-KN; Sun, 05 Jan 2014 18:05:55 +0100
Date:   Sun, 5 Jan 2014 18:05:55 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 11/12] MIPS: Loongson 3: Add CPU hotplug support
Message-ID: <20140105170555.GA14901@ohm.rr44.fr>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-12-git-send-email-chenhc@lemote.com>
 <20140104234459.GA21100@hall.aurel32.net>
 <CAAhV-H7GG2JMyxU242i=tmp=F5Qmgd3DrMjzpnNYWm=rB2b8PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H7GG2JMyxU242i=tmp=F5Qmgd3DrMjzpnNYWm=rB2b8PA@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Jan 05, 2014 at 10:11:24PM +0800, Huacai Chen wrote:
> On Sun, Jan 5, 2014 at 7:44 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
> > On Sun, Dec 15, 2013 at 08:14:35PM +0800, Huacai Chen wrote:
> > > Tips of Loongson's CPU hotplug:
> > > 1, To fully shutdown a core in Loongson 3, the target core should go to
> > >    CKSEG1 and flush all L1 cache entries at first. Then, another core
> > >    (usually Core 0) can safely disable the clock of the target core. So
> > >    play_dead() call loongson3_play_dead() via CKSEG1 (both uncached and
> > >    unmmaped).
> > > 2, The default clocksource of Loongson is MIPS. Since clock source is a
> > >    global device, timekeeping need the CP0' Count registers of each core
> > >    be synchronous. Thus, when a core is up, we use a SMP_ASK_C0COUNT IPI
> > >    to ask Core-0's Count.
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> > > ---
> > >  arch/mips/Kconfig                              |    1 +
> > >  arch/mips/include/asm/mach-loongson/loongson.h |    6 +-
> > >  arch/mips/include/asm/smp.h                    |    1 +
> > >  arch/mips/loongson/loongson-3/irq.c            |   10 ++
> > >  arch/mips/loongson/loongson-3/smp.c            |  168
> > +++++++++++++++++++++++-
> > >  5 files changed, 181 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 2c447a7..ef5fa84 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -276,6 +276,7 @@ config LASAT
> > >  config MACH_LOONGSON
> > >       bool "Loongson family of machines"
> > >       select SYS_SUPPORTS_ZBOOT
> > > +     select SYS_SUPPORTS_HOTPLUG_CPU
> > >       help
> > >         This enables the support of Loongson family of machines.
> > >
> > > diff --git a/arch/mips/include/asm/mach-loongson/loongson.h
> > b/arch/mips/include/asm/mach-loongson/loongson.h
> > > index 40b4892..d4bae71 100644
> > > --- a/arch/mips/include/asm/mach-loongson/loongson.h
> > > +++ b/arch/mips/include/asm/mach-loongson/loongson.h
> > > @@ -247,6 +247,9 @@ static inline void do_perfcnt_IRQ(void)
> > >  #define LOONGSON_PXARB_CFG           LOONGSON_REG(LOONGSON_REGBASE +
> > 0x68)
> > >  #define LOONGSON_PXARB_STATUS
> >  LOONGSON_REG(LOONGSON_REGBASE + 0x6c)
> > >
> > > +/* Chip Config */
> > > +#define LOONGSON_CHIPCFG0            LOONGSON_REG(LOONGSON_REGBASE +
> > 0x80)
> >
> > LOONGSON_REG uses LOONGSON_REG_BASE, which seems to be Loongson-2
> > specific. Here, LOONGSON3_REG should probably be used instead.
> >
> LOONGSON_REG_BASE is used for all Loongson family.

Yes, you explained that in the other patch. Thanks for the explanation,
it makes more sense now.

> > > +
> > >  /* pcimap */
> > >
> > >  #define LOONGSON_PCIMAP_PCIMAP_LO0   0x0000003f
> > > @@ -262,9 +265,6 @@ static inline void do_perfcnt_IRQ(void)
> > >  #ifdef CONFIG_CPU_SUPPORTS_CPUFREQ
> > >  #include <linux/cpufreq.h>
> > >  extern struct cpufreq_frequency_table loongson2_clockmod_table[];
> > > -
> > > -/* Chip Config */
> > > -#define LOONGSON_CHIPCFG0            LOONGSON_REG(LOONGSON_REGBASE +
> > 0x80)
> > >  #endif
> > >
> > >  /*
> > > diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> > > index eb60087..efa02ac 100644
> > > --- a/arch/mips/include/asm/smp.h
> > > +++ b/arch/mips/include/asm/smp.h
> > > @@ -42,6 +42,7 @@ extern int __cpu_logical_map[NR_CPUS];
> > >  #define SMP_ICACHE_FLUSH     0x4
> > >  /* Used by kexec crashdump to save all cpu's state */
> > >  #define SMP_DUMP             0x8
> > > +#define SMP_ASK_C0COUNT              0x10
> > >
> > >  extern volatile cpumask_t cpu_callin_map;
> > >
> > > diff --git a/arch/mips/loongson/loongson-3/irq.c
> > b/arch/mips/loongson/loongson-3/irq.c
> > > index 11467ca..16e88a9 100644
> > > --- a/arch/mips/loongson/loongson-3/irq.c
> > > +++ b/arch/mips/loongson/loongson-3/irq.c
> > > @@ -125,3 +125,13 @@ void __init mach_init_irq(void)
> > >
> > >       set_c0_status(STATUSF_IP2 | STATUSF_IP6);
> > >  }
> > > +
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +
> > > +void fixup_irqs(void)
> > > +{
> > > +     irq_cpu_offline();
> > > +     clear_c0_status(ST0_IM);
> > > +}
> > > +
> > > +#endif
> > > diff --git a/arch/mips/loongson/loongson-3/smp.c
> > b/arch/mips/loongson/loongson-3/smp.c
> > > index 3c52565..8cc5e95 100644
> > > --- a/arch/mips/loongson/loongson-3/smp.c
> > > +++ b/arch/mips/loongson/loongson-3/smp.c
> > > @@ -30,6 +30,9 @@
> > >
> > >  #include "smp.h"
> > >
> > > +DEFINE_PER_CPU(int, cpu_state);
> > > +DEFINE_PER_CPU(uint32_t, core0_c0count);
> > > +
> > >  /* read a 64bit value from ipi register */
> > >  uint64_t loongson3_ipi_read64(void * addr)
> > >  {
> > > @@ -169,8 +172,8 @@ static void loongson3_send_ipi_mask(const struct
> > cpumask *mask, unsigned int act
> > >
> > >  void loongson3_ipi_interrupt(struct pt_regs *regs)
> > >  {
> > > -     int cpu = smp_processor_id();
> > > -     unsigned int action;
> > > +     int i, cpu = smp_processor_id();
> > > +     unsigned int action, c0count;
> > >
> > >       /* Load the ipi register to figure out what we're supposed to do */
> > >       action = loongson3_ipi_read32(ipi_status0_regs[cpu]);
> > > @@ -185,14 +188,24 @@ void loongson3_ipi_interrupt(struct pt_regs *regs)
> > >       if (action & SMP_CALL_FUNCTION) {
> > >               smp_call_function_interrupt();
> > >       }
> > > +
> > > +     if (action & SMP_ASK_C0COUNT) {
> > > +             BUG_ON(cpu != 0);
> > > +             c0count = read_c0_count();
> > > +             for (i=1; i < nr_cpus_loongson; i++)
> > > +                     per_cpu(core0_c0count, i) = c0count;
> > > +     }
> > >  }
> > >
> > > +#define MAX_LOOPS 1000
> > >  /*
> > >   * SMP init and finish on secondary CPUs
> > >   */
> > >  void loongson3_init_secondary(void)
> > >  {
> > >       int i;
> > > +     uint32_t initcount;
> > > +     unsigned int cpu = smp_processor_id();
> > >       unsigned int imask = STATUSF_IP7 | STATUSF_IP6 |
> > >                            STATUSF_IP3 | STATUSF_IP2;
> > >
> > > @@ -202,6 +215,19 @@ void loongson3_init_secondary(void)
> > >       for (i = 0; i < nr_cpus_loongson; i++) {
> > >               loongson3_ipi_write32(0xffffffff, ipi_en0_regs[i]);
> > >       }
> > > +
> > > +     per_cpu(cpu_state, cpu) = CPU_ONLINE;
> > > +
> > > +     i = 0;
> > > +     __get_cpu_var(core0_c0count) = 0;
> > > +     loongson3_send_ipi_single(0, SMP_ASK_C0COUNT);
> > > +     while (!__get_cpu_var(core0_c0count))
> > > +             i++;
> > > +
> > > +     if (i > MAX_LOOPS)
> > > +             i = MAX_LOOPS;
> > > +     initcount = __get_cpu_var(core0_c0count) + i;
> > > +     write_c0_count(initcount);
> > >  }
> > >
> > >  void loongson3_smp_finish(void)
> > > @@ -235,6 +261,8 @@ void __init loongson3_smp_setup(void)
> > >
> > >  void __init loongson3_prepare_cpus(unsigned int max_cpus)
> > >  {
> > > +     init_cpu_present(cpu_possible_mask);
> > > +     per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
> > >  }
> > >
> > >  /*
> > > @@ -268,6 +296,138 @@ void __init loongson3_cpus_done(void)
> > >  {
> > >  }
> > >
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +
> > > +extern void fixup_irqs(void);
> > > +extern void (*flush_cache_all)(void);
> > > +
> > > +static int loongson3_cpu_disable(void)
> > > +{
> > > +     unsigned long flags;
> > > +     unsigned int cpu = smp_processor_id();
> > > +
> > > +     if (cpu == 0)
> > > +             return -EBUSY;
> > > +
> > > +     set_cpu_online(cpu, false);
> > > +     cpu_clear(cpu, cpu_callin_map);
> > > +     local_irq_save(flags);
> > > +     fixup_irqs();
> > > +     local_irq_restore(flags);
> > > +     flush_cache_all();
> > > +     local_flush_tlb_all();
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +
> > > +static void loongson3_cpu_die(unsigned int cpu)
> > > +{
> > > +     while (per_cpu(cpu_state, cpu) != CPU_DEAD)
> > > +             cpu_relax();
> > > +
> > > +     mb();
> > > +}
> > > +
> > > +/* To shutdown a core in Loongson 3, the target core should go to
> > CKSEG1 and
> > > + * flush all L1 entries at first. Then, another core (usually Core 0)
> > can
> > > + * safely disable the clock of the target core. loongson3_play_dead() is
> > > + * called via CKSEG1 (uncached and unmmaped) */
> > > +void loongson3_play_dead(int *state_addr)
> > > +{
> > > +     __asm__ __volatile__(
> > > +             "      .set push                         \n"
> > > +             "      .set noreorder                    \n"
> > > +             "      li $t0, 0x80000000                \n" /* KSEG0 */
> > > +             "      li $t1, 512                       \n" /* num of L1
> > entries */
> >
> > Patch 2 parses the configuration of the caches, shouldn't it be better
> > to use values from there instead of hardcoded entry. Also
> >
> Yes, this should be fixed.
> 
> 
> >
> >
> > > +             "1:    cache 0, 0($t0)                   \n" /* flush L1
> > ICache */
> > > +             "      cache 0, 1($t0)                   \n"
> > > +             "      cache 0, 2($t0)                   \n"
> > > +             "      cache 0, 3($t0)                   \n"
> > > +             "      cache 1, 0($t0)                   \n" /* flush L1
> > DCache */
> > > +             "      cache 1, 1($t0)                   \n"
> > > +             "      cache 1, 2($t0)                   \n"
> > > +             "      cache 1, 3($t0)                   \n"
> > > +             "      addiu $t0, $t0, 0x20              \n"
> > > +             "      bnez  $t1, 1b                     \n"
> > > +             "      addiu $t1, $t1, -1                \n"
> > > +             "      li    $t0, 0x7                    \n" /*
> > *state_addr = CPU_DEAD; */
> > > +             "      sw    $t0, 0($a0)                 \n"
> > > +             "      sync                              \n"
> > > +             "      cache 21, 0($a0)                  \n" /* flush
> > entry of *state_addr */
> > > +             "      .set pop                          \n");
> > > +
> > > +     __asm__ __volatile__(
> > > +             "      .set push                         \n"
> > > +             "      .set noreorder                    \n"
> > > +             "      .set mips64                       \n"
> >
> > This seems to say again that a 32-bit kernel is not possible and that
> > 32-bit kernel should be dropped, and this removed.
> >
> > > +             "      mfc0  $t2, $15, 1                 \n"
> > > +             "      andi  $t2, 0x3ff                  \n"
> > > +             "      dli   $t0, 0x900000003ff01000     \n"
> > > +             "      andi  $t3, $t2, 0x3               \n"
> > > +             "      sll   $t3, 8                      \n"  /* get cpu
> > id */
> > > +             "      or    $t0, $t0, $t3               \n"
> > > +             "      andi  $t1, $t2, 0xc               \n"
> > > +             "      dsll  $t1, 42                     \n"  /* get node
> > id */
> > > +             "      or    $t0, $t0, $t1               \n"
> > > +             "1:    li    $a0, 0x100                  \n"  /* wait for
> > init loop */
> > > +             "2:    bnez  $a0, 2b                     \n"  /* idle loop
> > */
> > > +             "      addiu $a0, -1                     \n"
> >
> > How this idle loop has been calibrated? Why is it needed?
> >
> Just reduce the frequency of mailbox accesses.

Ok, this show that an exact timing is not really needed. Maybe you can
use this explanation as a comment. 

> 
> >
> > > +             "      lw    $v0, 0x20($t0)              \n"  /* get PC
> > via mailbox */
> > > +             "      beqz  $v0, 1b                     \n"
> > > +             "      nop                               \n"
> > > +             "      ld    $sp, 0x28($t0)              \n"  /* get SP
> > via mailbox */
> > > +             "      ld    $gp, 0x30($t0)              \n"  /* get GP
> > via mailbox */
> > > +             "      ld    $a1, 0x38($t0)              \n"
> > > +             "      jr  $v0                           \n"  /* jump to
> > initial PC */
> > > +             "      nop                               \n"
> > > +             "      .set pop                          \n");
> > > +}
> > > +
> > > +void play_dead(void)
> > > +{
> > > +     int *state_addr;
> > > +     unsigned int cpu = smp_processor_id();
> > > +     void (*play_dead_at_ckseg1)(int *);
> > > +
> > > +     idle_task_exit();
> > > +     play_dead_at_ckseg1 = (void *)CKSEG1ADDR((unsigned
> > long)loongson3_play_dead);
> > > +     state_addr = &per_cpu(cpu_state, cpu);
> > > +     mb();
> > > +     play_dead_at_ckseg1(state_addr);
> > > +}
> > > +
> > > +#define CPU_POST_DEAD_FROZEN (CPU_POST_DEAD | CPU_TASKS_FROZEN)
> > > +static int loongson3_cpu_callback(struct notifier_block *nfb,
> > > +     unsigned long action, void *hcpu)
> > > +{
> > > +     unsigned int cpu = (unsigned long)hcpu;
> > > +
> > > +     switch (action) {
> > > +     case CPU_POST_DEAD:
> > > +     case CPU_POST_DEAD_FROZEN:
> > > +             printk(KERN_INFO "Disable clock for CPU#%d\n", cpu);
> > > +             LOONGSON_CHIPCFG0 &= ~(1 << (12 + cpu));
> > > +             break;
> > > +     case CPU_UP_PREPARE:
> > > +     case CPU_UP_PREPARE_FROZEN:
> > > +             printk(KERN_INFO "Enable clock for CPU#%d\n", cpu);
> > > +             LOONGSON_CHIPCFG0 |= 1 << (12 + cpu);
> > > +             break;
> > > +     }
> > > +
> > > +     return NOTIFY_OK;
> > > +}
> > > +
> > > +static int register_loongson3_notifier(void)
> > > +{
> > > +     hotcpu_notifier(loongson3_cpu_callback, 0);
> > > +     return 0;
> > > +}
> > > +early_initcall(register_loongson3_notifier);
> > > +
> > > +#endif
> > > +
> > >  struct plat_smp_ops loongson3_smp_ops = {
> > >       .send_ipi_single = loongson3_send_ipi_single,
> > >       .send_ipi_mask = loongson3_send_ipi_mask,
> > > @@ -277,4 +437,8 @@ struct plat_smp_ops loongson3_smp_ops = {
> > >       .boot_secondary = loongson3_boot_secondary,
> > >       .smp_setup = loongson3_smp_setup,
> > >       .prepare_cpus = loongson3_prepare_cpus,
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +     .cpu_disable = loongson3_cpu_disable,
> > > +     .cpu_die = loongson3_cpu_die,
> > > +#endif
> > >  };
> >
> > This patch should also modify Kconfig to add SYS_SUPPORTS_HOTPLUG_CPU to
> > the LEMOTE_MACH3A machine.
> >
> Yes, this should be moved.

Oops, I have missed that you already does that at the beginning of the
patch. Just ignore my comment, sorry about that.

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
