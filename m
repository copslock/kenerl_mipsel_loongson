Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 13:58:10 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:53999 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490979Ab1AEM6H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jan 2011 13:58:07 +0100
Received: by qyk27 with SMTP id 27so17921867qyk.15
        for <linux-mips@linux-mips.org>; Wed, 05 Jan 2011 04:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer;
        bh=Mrfhkv6WpyKQg5S9CWaJmkXATOdV/n53Q+DBfOmOqZE=;
        b=rXMl2If0xWpVbYH0qCVXgJoIP+4w4m3mOayZkiLfKydf5oUEYntg5F69oEFEmDxW0l
         peoLsrEleEcwdQfr2Rq8QbtJ+jtR5fyX/gncOU0NBU+HZCnrOYEARiyQDePFa6WODeWb
         pYgJLwAdPjbZ/LtJzDAdnCV0/yZOB78mk2tOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer;
        b=TgDeu6YBLu57guBicMuj7kNkRINQ01WJk5YIFqGHP/TgIljDKagnEH4sC0d+iPw00e
         D4rUaWZFRmjVos/o9uzouOvHMyp5zPoKeQjd/Bdn6AzFYhvrw6v83binelkhf+jBTglR
         rvJoX1IYCKbpN6lYqBuRYgfS3CbkoufKGv+kw=
Received: by 10.224.11.130 with SMTP id t2mr6237478qat.231.1294232277081;
        Wed, 05 Jan 2011 04:57:57 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id q12sm13543818qcu.30.2011.01.05.04.57.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 Jan 2011 04:57:53 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <4D235B8D.2070306@paralogos.com>
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>
         <1293470392.27661.202.camel@paanoop1-desktop>
         <1293524389.27661.210.camel@paanoop1-desktop>
         <4D19A31E.1090905@paralogos.com>
         <1293798476.27661.279.camel@paanoop1-desktop>
         <4D1EE913.1070203@paralogos.com>
         <1294067561.27661.293.camel@paanoop1-desktop>
         <4D21F5D3.50604@paralogos.com>
         <1294082426.27661.330.camel@paanoop1-desktop>
         <4D22D7B3.2050609@paralogos.com>
         <1294146165.27661.361.camel@paanoop1-desktop>
         <4D235B8D.2070306@paralogos.com>
Content-Type: multipart/mixed; boundary="=-Qqs3Zx4HpWKhg0KdYC5/"
Date:   Wed, 05 Jan 2011 18:39:17 +0530
Message-ID: <1294232957.27661.389.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips


--=-Qqs3Zx4HpWKhg0KdYC5/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-01-04 at 09:40 -0800, Kevin D. Kissell wrote:
> On 01/04/11 05:02, Anoop P A wrote:
> > On Tue, 2011-01-04 at 00:17 -0800, Kevin D. Kissell wrote:
> >> Those interrupt counters show that IPIs are being taken everywhere,
> >> though very few by CPUs 5 and 6.  If I understand the configuration
> >> correctly, CPU 4 is a TC in VPE 1, and it's getting a reasonable IPI
> > Yes CPU4 is in second VPE
> >
> >> rate, *if* we're looking at a tickless kernel under low load.  But there
> > No it was not the tickless kernel.I had selected 250 MHz timer. can't we
> > expect IPI / timer interrupt for all the threads in this case ?.
> 
> In that case, you should expect a distribution of timer interrupts that 
> favors the low-numbered TCs within the VPE, as you do in VPE0, and a 
> distribution of IPIs that is sort-of the inverse, as you do in VPE0.  
> But the low counts on VPE1 are indeed suspicious, as you note.
> 
> >> may be a clue there to part of your problem.  I have no idea why the
> >> behavior would have changed from 2.6.36 to 2.6.37, but it looks as if
> >> you're getting your clock interrupts through the MSP CIC interrupt
> >> controller on VPE 0.  There's nothing symmetric for VPE1. The Malta
> >> example code is perhaps deceptively simple, in that both VPEs have their
> >> count/compare indication wired directly to the 2 clock interrupt inputs,
> >> so that having both of them running with only a single set of irq state
> >> just works.  I don't know whether the MSP CIC timer interrupt is a
> > In my case it is separate irq. MSP_INT_VPE1_TIMER (34) and
> > MSP_INT_VPE0_TIMER (25) are wired to CIC . CIC interrupt has been
> > connected to cpu irq 6.
> >
> > I can reproduce cpu stall in VSMP mode If I don't setup VPE1 timer
> > interrupt . Don't we have support for separate irq in SMTC
> > implementation ?..
> 
> There are hooks for platform-specific SMTC support, which is implemented 
> for the Malta in arch/mips/mti-malta/malta-smtc.c.  See 
> msmtc_init_secondary(), for example, where the clock/compare, profile, 
> and IPI interrupts are armed for VPE 1, while I/O peripheral interrupts 
> are inhibited.
> 
> >> gating of the VPE0 count/compare output, or whether it's it's own
> >> interval timer, but I suspect that you may need to do some further
> >> low-level initialization in the platform-specific code to set up an
> >> interrupt on the VPE1 side.  I don't think the snippet you've got below
> >> would work as written.
> > The routine which I copied works fine for VSMP mode .
> >
> > / # cat /proc/interrupts
> >             CPU0       CPU1
> >    0:        187        254            MIPS  IPI_resched
> >    1:         77        174            MIPS  IPI_call
> >    6:          0          0            MIPS  MSP CIC cascade
> >    8:          0          0         MSP_CIC  Softreset button
> >    9:          0          0         MSP_CIC  Standby switch
> >   21:          0          0         MSP_CIC  MSP PER cascade
> >   25:      37077          0         MSP_CIC  timer
> >   27:        188          0         MSP_CIC  serial
> >   34:          0      36986         MSP_CIC  timer
> >
> > Do I want to change anything specific for SMTC ? .
> 
> If it works (which I doubt), then we can critique stylistic points like 
> using
> 
> 		if ((1==get_current_vpe())
> 
> Instead of the more readable and general
> 
> 		if (get_current_vpe()>  0)
> 
> 
> But I think you're generally looking in the wrong place.  Look at the 
> Malta code and see what's done where.  The initial SMTC code had a lot 
> of Malta assumptions in the main line that I pushed out to platform code 
> in later patches.  I can see how things could be made even more modular, 
> but for the moment I think it's just that there's some stuff that ought 
> to be done in a "msp_smtc.c" file that doesn't exist in 2.6.37.
Yes , I am doing similar stuff in msp_smtc.c . Attaching code for your
reference. I am not seeing a VPE1 timer interrupt.

> 
>              Regards,
> 
>              Kevin K.
> >
> >
> >> If it's purely an issue with clock distribution on VPE1, then a boot
> >> with maxvpes=1 maxtcs=4 should be stable.
> > Yes the kernel seems to be stable if I boot with maxvpes=1 maxtcs=4 .
> >
> >> /K.
> >>
> >> On 1/3/2011 11:20 AM, Anoop P A wrote:
> >>> Hi Kevin,
> >>>
> >>> On Mon, 2011-01-03 at 08:14 -0800, Kevin D. Kissell wrote:
> >>>> The very first SMTC implementations didn't support full kernel-mode
> >>>> preemption, which anyway wasn't a priority, given the hardware event
> >>>> response support in MIPS MT.  I believe it was later made compatible,
> >>>> but it was never extensively exercised.  Since SMTC has fingers in some
> >>>> pretty low-level atomicity mechanisms, if a new, parallel set was
> >>>> implemented for RCU, I can easily imagine that nobody has yet
> >>>> implemented SMTC-ified variants of that set.
> >>>>
> >>>> Your last statement isn't very clear, though.  Are you saying that if
> >>>> you configure for no forced preemption and with TREE_CPU, the 2.6.37
> >>>> kernel boots all the way up, or that it simply hangs later?   What's the
> >>>> last rev kernel that actually boots all the way up?
> >>> I have debugged this a bit more. It seems that kernel getting stalled
> >>> while executing on TC's of second VPE .
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=2504 jiffies)
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=10036 jiffies)
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=17568 jiffies)
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=25100 jiffies)
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=32632 jiffies)
> >>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> >>> by 1, t=40164 jiffies)
> >>>
> >>> With CONFIG_TREE_CPU we were not hitting this scenario very often.
> >>> However with CONFIG_PREEMPT_TREE_CPU stall happens most of the time.
> >>>
> >>> I presume some issue in my timer setup . I am not seeing timer interrupt
> >>> (or IPI interrupt) getting  incremented for VPE1 tcs on a completely
> >>> booted 2.6.32-stable kernel.
> >>>
> >>> / # cat /proc/interrupts
> >>>             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> >>> CPU6
> >>>    1:        148      15023      15140      15093       3779          8
> >>> 2            MIPS  SMTC_IPI
> >>>    6:          0          0          0          0          0          0
> >>> 0            MIPS  MSP CIC cascade
> >>>    8:          0          0          0          0          0          0
> >>> 0         MSP_CIC  Softreset button
> >>>    9:          0          0          0          0          0          0
> >>> 0         MSP_CIC  Standby switch
> >>>   21:          0          0          0          0          0          0
> >>> 0         MSP_CIC  MSP PER cascade
> >>>   25:      15113        341          4          7          0          0
> >>> 0         MSP_CIC  timer
> >>>   27:        260          9          0          1          0          0
> >>> 0         MSP_CIC  serial
> >>>   34:          0          0          0          0          0          0
> >>> 0         MSP_CIC  timer
> >>>
> >>> Can't we use separate timer interrupts for VPE1 and VPE0 in SMTC ?.
> >>>
> >>> I have tried setting up VPE1 timer from get_co_compare_int as follows
> >>>
> >>> unsigned int __cpuinit get_c0_compare_int(void)
> >>> {
> >>> 	if ((1==get_current_vpe())&&  !vpe1_timr_installed){
> >>> 	
> >>> 	memcpy(&timer_vpe1,&c0_compare_irqaction,sizeof(timer_vpe1));
> >>> 	
> >>> 	setup_irq(MSP_INT_VPE1_TIMER,&timer_vpe1);
> >>>                    vpe1_timr_installed++;
> >>>            }
> >>>            return (get_current_vpe() ? MSP_INT_VPE1_TIMER :
> >>> MSP_INT_VPE0_TIMER);
> >>> }
> >>>
> >>> Thanks
> >>> Anoop
> 


--=-Qqs3Zx4HpWKhg0KdYC5/
Content-Disposition: attachment; filename="msp_smtc.c"
Content-Type: text/x-csrc; name="msp_smtc.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/*
 * MSP71xx Platform-specific hooks for SMP operation.
 * Started from malta-smtc.c.
 */
#include <linux/irq.h>
#include <linux/init.h>
#include <linux/sched.h>

#include <asm/mipsregs.h>
#include <asm/mipsmtregs.h>
#include <asm/smtc.h>
#include <asm/smtc_ipi.h>

/* VPE/SMP Prototype implements platform interfaces directly */

/*
 * Cause the specified action to be performed on a targeted "CPU"
 */

static void msp_smtc_send_ipi_single(int cpu, unsigned int action)
{
	/* "CPU" may be TC of same VPE, VPE of same CPU, or different CPU */
	smtc_send_ipi(cpu, LINUX_SMP_IPI, action);
}

static void msp_smtc_send_ipi_mask(const struct cpumask *mask, unsigned int action)
{
	unsigned int i;

	for_each_cpu(i, mask)
		msp_smtc_send_ipi_single(i, action);
}

/*
 * Post-config but pre-boot cleanup entry point
 */
static int prev_vpe;
static void __cpuinit msp_smtc_init_secondary(void)
{
	void smtc_init_secondary(void);
	int myvpe;

	myvpe = read_c0_tcbind() & TCBIND_CURVPE;
	/* Change status register when we switch to new VPE*/
	if ((myvpe != prev_vpe) && (myvpe > 0)) {
		change_c0_status(ST0_IM, STATUSF_IP0 | STATUSF_IP1 |
					 STATUSF_IP6 | STATUSF_IP7);
	}
	prev_vpe = myvpe;
	
	smtc_init_secondary();
}

/*
 * Platform "CPU" startup hook
 */
static void __cpuinit msp_smtc_boot_secondary(int cpu, struct task_struct *idle)
{
	
	smtc_boot_secondary(cpu, idle);
}

/*
 * SMP initialization finalization entry point
 */
static void __cpuinit msp_smtc_smp_finish(void)
{
	smtc_smp_finish();
}

/*
 * Hook for after all CPUs are online
 */

static void msp_smtc_cpus_done(void)
{
}

/*
 * Platform SMP pre-initialization
 *
 * As noted above, we can assume a single CPU for now
 * but it may be multithreaded.
 */

static void __init msp_smtc_smp_setup(void)
{
	/*
	 * we won't get the definitive value until
	 * we've run smtc_prepare_cpus later, but
	 */
	if (read_c0_config3() & (1 << 2))
	smp_num_siblings = smtc_build_cpu_map(0);
}

static void __init msp_smtc_prepare_cpus(unsigned int max_cpus)
{
	smtc_prepare_cpus(max_cpus);
}

struct plat_smp_ops msp_smtc_smp_ops = {
	.send_ipi_single	= msp_smtc_send_ipi_single,
	.send_ipi_mask		= msp_smtc_send_ipi_mask,
	.init_secondary		= msp_smtc_init_secondary,
	.smp_finish		= msp_smtc_smp_finish,
	.cpus_done		= msp_smtc_cpus_done,
	.boot_secondary		= msp_smtc_boot_secondary,
	.smp_setup		= msp_smtc_smp_setup,
	.prepare_cpus		= msp_smtc_prepare_cpus,
};

#if 0
/* TODO */
#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
/*
 * IRQ affinity hook
 */


int plat_set_irq_affinity(unsigned int irq, const struct cpumask *affinity)
{
	cpumask_t tmask;
	int cpu = 0;
	void smtc_set_irq_affinity(unsigned int irq, cpumask_t aff);

	cpumask_copy(&tmask, affinity);
	for_each_cpu(cpu, affinity) {
		if ((cpu_data[cpu].vpe_id != 0) || !cpu_online(cpu))
			cpu_clear(cpu, tmask);
	}
	cpumask_copy(irq_desc[irq].affinity, &tmask);

	if (cpus_empty(tmask))
		/*
		 * We could restore a default mask here, but the
		 * runtime code can anyway deal with the null set
		 */
		printk(KERN_WARNING
			"IRQ affinity leaves no legal CPU for IRQ %d\n", irq);

	/* Do any generic SMTC IRQ affinity setup */
	smtc_set_irq_affinity(irq, tmask);

	return 0;
}
#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
#endif

--=-Qqs3Zx4HpWKhg0KdYC5/--
