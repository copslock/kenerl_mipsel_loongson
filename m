Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 15:26:06 +0100 (CET)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:64568 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492074Ab1ADO0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 15:26:01 +0100
Received: by vws5 with SMTP id 5so5634747vws.36
        for <linux-mips@linux-mips.org>; Tue, 04 Jan 2011 06:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=FNuPM+W3f5t+KfgQqzstaQ7meROJMZZgtYi3a7wgzG4=;
        b=MNF8M8KXa+6jNUHik+kq/fIcbXeLECXvHhM6HVp3jRecqCyILHkXlyDH1k87Ja4RLX
         r5WQ967s7algFflTI+rlVAr4FGbcKa1fS8mmONcUuns2hkiQwUbtHqOjmreN6QULFjj4
         Bur7UACaHO5hdcv68h1YFSl8LFjVqfe/kaBCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=MTEiivBOBdXwFcARh3xe8aGacye+psN3rcF+57Xx7Hfqyp/QUa8pDhGm2loJ92TWbv
         9QisVx2B46mU87jKk6x0Rwnp7TqApwlZujLcF4wxdcVmtW557TX3bzY3UOcTJ+nUmRyW
         y9TqzJRhW5GdzDVOzCIqvQoGtupqk1C0d0zpM=
Received: by 10.220.190.2 with SMTP id dg2mr6755851vcb.156.1294151154366;
        Tue, 04 Jan 2011 06:25:54 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id e18sm8102512vbm.15.2011.01.04.06.25.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 06:25:52 -0800 (PST)
Subject: Re: SMTC support status in latest git head.
From:   Anoop P A <anoop.pa@gmail.com>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
In-Reply-To: <1294146165.27661.361.camel@paanoop1-desktop>
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
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 04 Jan 2011 20:07:02 +0530
Message-ID: <1294151822.27661.375.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Kevin,

the stackframe patch that you have suggested had some side effects I was
unable execute init. When I changed some thing like below it started
working .Could you kindly review it ?.

diff --git a/arch/mips/include/asm/stackframe.h
b/arch/mips/include/asm/stackframe.h
index 58730c5..da786ed 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -181,14 +181,6 @@
 #endif
 		LONG_S	k0, PT_R29(sp)
 		LONG_S	$3, PT_R3(sp)
-		/*
-		 * You might think that you don't need to save $0,
-		 * but the FPU emulator and gdb remote debug stub
-		 * need it to operate correctly
-		 */
-		LONG_S	$0, PT_R0(sp)
-		mfc0	v1, CP0_STATUS
-		LONG_S	$2, PT_R2(sp)
 #ifdef CONFIG_MIPS_MT_SMTC
 		/*
 		 * Ideally, these instructions would be shuffled in
@@ -199,6 +191,14 @@
 		.set	mips0
 		LONG_S	v1, PT_TCSTATUS(sp)
 #endif /* CONFIG_MIPS_MT_SMTC */
+		/*
+		 * You might think that you don't need to save $0,
+		 * but the FPU emulator and gdb remote debug stub
+		 * need it to operate correctly
+		 */
+		LONG_S	$0, PT_R0(sp)
+		mfc0	v1, CP0_STATUS
+		LONG_S	$2, PT_R2(sp)
 		LONG_S	$4, PT_R4(sp)
 		LONG_S	$5, PT_R5(sp)
 		LONG_S	v1, PT_STATUS(sp)

Linux-2.6.37-rc7 boots all the way if I specify maxvpes=1 in command
line.

/ # cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
CPU6
  1:        249     218024     218286     218263     218235     218208
218179            MIPS  SMTC_IPI
  6:          0          0          0          0          0          0
0            MIPS  MSP CIC cascade
  8:          0          0          0          0          0          0
0         MSP_CIC  Softreset button
  9:          0          0          0          0          0          0
0         MSP_CIC  Standby switch
 21:          0          0          0          0          0          0
0         MSP_CIC  MSP PER cascade
 25:     218128        711         11          0          0          0
0         MSP_CIC  timer
 27:        341         22          0          0          2          0
6         MSP_CIC  serial

ERR:          0
/ # uname -a
Linux (none) 2.6.37-rc7-pmc-00001-g9cff2d6-dirty #289 SMP PREEMPT Tue
Jan 4 19:48:31 IST 2011 mips GNU/Linux

So clock setup / distribution on VPE1 is some thing need fix.

Thanks
Anoop


On Tue, 2011-01-04 at 18:32 +0530, Anoop P A wrote:
> On Tue, 2011-01-04 at 00:17 -0800, Kevin D. Kissell wrote:
> > Those interrupt counters show that IPIs are being taken everywhere,
> > though very few by CPUs 5 and 6.  If I understand the configuration
> > correctly, CPU 4 is a TC in VPE 1, and it's getting a reasonable IPI
> Yes CPU4 is in second VPE
> 
> > rate, *if* we're looking at a tickless kernel under low load.  But there
> No it was not the tickless kernel.I had selected 250 MHz timer. can't we
> expect IPI / timer interrupt for all the threads in this case ?.
> 
> > may be a clue there to part of your problem.  I have no idea why the
> > behavior would have changed from 2.6.36 to 2.6.37, but it looks as if
> > you're getting your clock interrupts through the MSP CIC interrupt
> > controller on VPE 0.  There's nothing symmetric for VPE1. The Malta
> > example code is perhaps deceptively simple, in that both VPEs have their
> > count/compare indication wired directly to the 2 clock interrupt inputs,
> > so that having both of them running with only a single set of irq state
> > just works.  I don't know whether the MSP CIC timer interrupt is a
> 
> In my case it is separate irq. MSP_INT_VPE1_TIMER (34) and  
> MSP_INT_VPE0_TIMER (25) are wired to CIC . CIC interrupt has been
> connected to cpu irq 6. 
> 
> I can reproduce cpu stall in VSMP mode If I don't setup VPE1 timer
> interrupt . Don't we have support for separate irq in SMTC
> implementation ?..
> 
> > gating of the VPE0 count/compare output, or whether it's it's own
> > interval timer, but I suspect that you may need to do some further
> > low-level initialization in the platform-specific code to set up an
> > interrupt on the VPE1 side.  I don't think the snippet you've got below
> > would work as written.
> 
> The routine which I copied works fine for VSMP mode . 
> 
> / # cat /proc/interrupts
>            CPU0       CPU1
>   0:        187        254            MIPS  IPI_resched
>   1:         77        174            MIPS  IPI_call
>   6:          0          0            MIPS  MSP CIC cascade
>   8:          0          0         MSP_CIC  Softreset button
>   9:          0          0         MSP_CIC  Standby switch
>  21:          0          0         MSP_CIC  MSP PER cascade
>  25:      37077          0         MSP_CIC  timer
>  27:        188          0         MSP_CIC  serial
>  34:          0      36986         MSP_CIC  timer
> 
> Do I want to change anything specific for SMTC ? .  
> 
> > 
> > If it's purely an issue with clock distribution on VPE1, then a boot
> > with maxvpes=1 maxtcs=4 should be stable.
> 
> Yes the kernel seems to be stable if I boot with maxvpes=1 maxtcs=4 .
> 
> > 
> > /K.
> > 
> > On 1/3/2011 11:20 AM, Anoop P A wrote:
> > > Hi Kevin,
> > >
> > > On Mon, 2011-01-03 at 08:14 -0800, Kevin D. Kissell wrote:
> > >> The very first SMTC implementations didn't support full kernel-mode
> > >> preemption, which anyway wasn't a priority, given the hardware event
> > >> response support in MIPS MT.  I believe it was later made compatible,
> > >> but it was never extensively exercised.  Since SMTC has fingers in some
> > >> pretty low-level atomicity mechanisms, if a new, parallel set was
> > >> implemented for RCU, I can easily imagine that nobody has yet
> > >> implemented SMTC-ified variants of that set.
> > >>
> > >> Your last statement isn't very clear, though.  Are you saying that if
> > >> you configure for no forced preemption and with TREE_CPU, the 2.6.37
> > >> kernel boots all the way up, or that it simply hangs later?   What's the
> > >> last rev kernel that actually boots all the way up?
> > > I have debugged this a bit more. It seems that kernel getting stalled
> > > while executing on TC's of second VPE . 
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=2504 jiffies)
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=10036 jiffies)
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=17568 jiffies)
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=25100 jiffies)
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=32632 jiffies)
> > > INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
> > > by 1, t=40164 jiffies)
> > >
> > > With CONFIG_TREE_CPU we were not hitting this scenario very often.
> > > However with CONFIG_PREEMPT_TREE_CPU stall happens most of the time.
> > >
> > > I presume some issue in my timer setup . I am not seeing timer interrupt
> > > (or IPI interrupt) getting  incremented for VPE1 tcs on a completely
> > > booted 2.6.32-stable kernel.
> > >
> > > / # cat /proc/interrupts
> > >            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
> > > CPU6
> > >   1:        148      15023      15140      15093       3779          8
> > > 2            MIPS  SMTC_IPI
> > >   6:          0          0          0          0          0          0
> > > 0            MIPS  MSP CIC cascade
> > >   8:          0          0          0          0          0          0
> > > 0         MSP_CIC  Softreset button
> > >   9:          0          0          0          0          0          0
> > > 0         MSP_CIC  Standby switch
> > >  21:          0          0          0          0          0          0
> > > 0         MSP_CIC  MSP PER cascade
> > >  25:      15113        341          4          7          0          0
> > > 0         MSP_CIC  timer
> > >  27:        260          9          0          1          0          0
> > > 0         MSP_CIC  serial
> > >  34:          0          0          0          0          0          0
> > > 0         MSP_CIC  timer
> > >
> > > Can't we use separate timer interrupts for VPE1 and VPE0 in SMTC ?. 
> > >
> > > I have tried setting up VPE1 timer from get_co_compare_int as follows
> > >
> > > unsigned int __cpuinit get_c0_compare_int(void)
> > > {
> > > 	if ((1==get_current_vpe()) && !vpe1_timr_installed){
> > > 	
> > > 	memcpy(&timer_vpe1,&c0_compare_irqaction,sizeof(timer_vpe1));
> > > 	
> > > 	setup_irq(MSP_INT_VPE1_TIMER, &timer_vpe1);
> > >                   vpe1_timr_installed++;
> > >           }
> > >           return (get_current_vpe() ? MSP_INT_VPE1_TIMER :
> > > MSP_INT_VPE0_TIMER);
> > > }
> > >
> > > Thanks
> > > Anoop
> > >
> > >>             Regards,
> > >>
> > >>             Kevin K.
> > >>
> > >> On 1/3/2011 7:12 AM, Anoop P A wrote:
> > >>> Hi ,
> > >>>
> > >>> Following patch restricts TREE_CPU RCU implementation only for !PREEMPT
> > >>> SMP kernel.  
> > >>> http://git.linux-mips.org/?p=linux.git;a=commit;h=687d7a960aea46e016182c7ce346d62c4dbd0366
> > >>>
> > >>> CONFIG_TREE_PREEMPT_RCU option seems to be not working for SMTC kernel
> > >>> ( which will be only available RCU implementation for SMTC kernel from
> > >>> 2.6.37 onwards) .
> > >>>
> > >>> With no forced preemption and selecting TREE_CPU I am able to boot
> > >>> further to the hang that I have reported.
> > >>>
> > >>> Thanks
> > >>> Anoop
> > >>>
> > >>> On Sat, 2011-01-01 at 00:42 -0800, Kevin D. Kissell wrote:
> > >>>> At this point the logical thing to do would seem to look at your kernel
> > >>>> image and disassemble smtc_ipi_replay(), which is where the EPC of VPE 0
> > >>>> shows the last exception to have been taken.  That's a critical SMTC
> > >>>> routine that gets called whenever an xxx_irq_restore() enables
> > >>>> interrupts, so that virtual per-TC IPI interrupts that were posted while
> > >>>> the TC had interrupts disabled can be handled deterministically.  As I
> > >>>> mentioned in an earlier message, there was some cleanup work from David
> > >>>> Howell that changed a number of irq management-related function names
> > >>>> and prototypes across all architectures, which went into linux-mips.org
> > >>>> at very roughly the time of the breakage.  The SMTC overlay over the irq
> > >>>> implementation has been pretty robust, but it's written in a perhaps
> > >>>> doomed attempt to be both efficient and using a maximum amount of common
> > >>>> code with the general case.  A mechanical or semi-mechanical change
> > >>>> could conceivably have broken things.
> > >>>>
> > >>>>             Regards,
> > >>>>
> > >>>>             Kevin K.
> > >>>>
> > >>>>
> > >>>> On 12/31/2010 4:27 AM, Anoop P A wrote:
> > >>>>> Hi ,
> > >>>>>
> > >>>>> Kernel hangs on stop_machine call. Please find mt reg dump below.
> > >>>>> Another important observation is even though 2.6.33 kernel + stackframe
> > >>>>> patch well passes calibration hang , I am still unable boot in to a
> > >>>>> initramfs root ( verified ramfs working with VSMP). So it looks like
> > >>>>> still some issue to fix between 2.6.32 and 2.6.33 .
> > >>>>> ######################## Log ###########################
> > >>>>>
> > >>>>> === MIPS MT State Dump ===
> > >>>>> -- Global State --
> > >>>>>    MVPControl Passed: 00000005
> > >>>>>    MVPControl Read: 00000004
> > >>>>>    MVPConf0 : a8008406
> > >>>>> -- per-VPE State --
> > >>>>>   VPE 0
> > >>>>>    VPEControl : 00008000
> > >>>>>    VPEConf0 : 800f0003
> > >>>>>    VPE0.Status : 11004201
> > >>>>>    VPE0.EPC : 8010dc54 smtc_ipi_replay+0xcc/0x108
> > >>>>>    VPE0.Cause : 50804000
> > >>>>>    VPE0.Config7 : 00010000
> > >>>>>   VPE 1
> > >>>>>    VPEControl : 00068006
> > >>>>>    VPEConf0 : 80cf0003
> > >>>>>    VPE1.Status : 11008301
> > >>>>>    VPE1.EPC : 801022a0 r4k_wait+0x20/0x40
> > >>>>>    VPE1.Cause : 50800000
> > >>>>>    VPE1.Config7 : 00010000
> > >>>>> -- per-TC State --
> > >>>>>   TC 0 (current TC with VPE EPC above)
> > >>>>>    TCStatus : 18102000
> > >>>>>    TCBind : 00000000
> > >>>>>    TCRestart : 803fa19c printk+0xc/0x30
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00000000
> > >>>>>   TC 1
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00200000
> > >>>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00140000
> > >>>>>   TC 2
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00400000
> > >>>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00280000
> > >>>>>   TC 3
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00600000
> > >>>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 003c0000
> > >>>>>   TC 4
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00800001
> > >>>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00500000
> > >>>>>   TC 5
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00a00001
> > >>>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00640000
> > >>>>>   TC 6
> > >>>>>    TCStatus : 18902000
> > >>>>>    TCBind : 00c00001
> > >>>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
> > >>>>>    TCHalt : 00000000
> > >>>>>    TCContext : 00780000
> > >>>>> Counter Interrupts taken per CPU (TC)
> > >>>>> 0: 0
> > >>>>> 1: 0
> > >>>>> 2: 0
> > >>>>> 3: 0
> > >>>>> 4: 0
> > >>>>> 5: 0
> > >>>>> 6: 0
> > >>>>> 7: 0
> > >>>>> Self-IPI invocations:
> > >>>>> 0: 12
> > >>>>> 1: 0
> > >>>>> 2: 0
> > >>>>> 3: 0
> > >>>>> 4: 0
> > >>>>> 5: 5
> > >>>>> 6: 4
> > >>>>> 7: 0
> > >>>>> IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
> > >>>>> 0 Recoveries of "stolen" FPU
> > >>>>> ===========================
> > >>>>>
> > >>>>> ################################################################
> > >>>>>
> > >>>>> Thanks
> > >>>>> Anoop
> > >>>>>
> > >>>>> On Tue, 2010-12-28 at 00:43 -0800, Kevin D. Kissell wrote:
> > >>>>>> I took a quick look last night, and the only thing that looked vaguely 
> > >>>>>> dangerous in changes since the timer changes I alluded to earlier was 
> > >>>>>> the global naming cleanup of irq-related function names that David 
> > >>>>>> Howell submitted.  The diff didn't look dangerous in itself, but some of 
> > >>>>>> the definitions are nested subtly for SMTC to maximize the amount of 
> > >>>>>> common code, and I could imagine something getting lost in translation 
> > >>>>>> there.  If that were really the problem, it would of course affect much 
> > >>>>>> more than just the timer subsystem, but early in the boot process, 
> > >>>>>> timers are pretty much the only interrupts that have to be handled 
> > >>>>>> correctly.
> > >>>>>>
> > >>>>>> I'm travelling today, but will take a look at timekeeping_notify() 
> > >>>>>> tomorrow or the next day...
> > >>>>>>
> > >>>>>> /K.
> > >>>>>>
> > >>>>>> On 12/28/10 12:19 AM, Anoop P A wrote:
> > >>>>>>> Hi,
> > >>>>>>>
> > >>>>>>> I had a glance into the code diff without notice of any suspect-able
> > >>>>>>> code .
> > >>>>>>> Tracing the hang showed that it is getting hanged in timekeeping_notify
> > >>>>>>> function.
> > >>>>>>>
> > >>>>>>> Thanks,
> > >>>>>>> Anoop
> > >>>>>>>
> > >>>>>>> PS: I may not be available until Thursday
> > >>>>>>>
> > >>>>>>> On Mon, 2010-12-27 at 22:49 +0530, Anoop P A wrote:
> > >>>>>>>> Hi Kevin,
> > >>>>>>>>
> > >>>>>>>> It is very unlikely that the patch you pointed has any impact on the the
> > >>>>>>>> hang I am seeing. The patch you have mentioned got into kernel around
> > >>>>>>>> 2.6.32 timeframe. I am able to boot both 2.6.32 and  2.6.33 kernel ( +
> > >>>>>>>> stackframe patch) .
> > >>>>>>>>
> > >>>>>>>> Hi Stuart,
> > >>>>>>>>
> > >>>>>>>> I haven't got much time to spend on this today.
> > >>>>>>>>
> > >>>>>>>> I had got 2.6.36-stable(+ stack frame patch) booting last day and I have
> > >>>>>>>> observed hang issue with 2.6.37-rc1 ( Same as rc6 and current git head)
> > >>>>>>>>
> > >>>>>>>> So probably some patches in 2.6.37 branch introduced this hang.
> > >>>>>>>>
> > >>>>>>>> Hopefully I will get some free slot tomorrow so that I can look into
> > >>>>>>>> code diff .
> > >>>>>>>>
> > >>>>>>>> Thanks
> > >>>>>>>> Anoop
> > >>>>>>>>
> > >>>>>>>> On Mon, 2010-12-27 at 09:49 -0600, STUART VENTERS wrote:
> > >>>>>>>>> Kevin,
> > >>>>>>>>>
> > >>>>>>>>> Outstanding, sometimes it's better to be lucky than good.
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Anoop,
> > >>>>>>>>>
> > >>>>>>>>> Maybe we can get lucky again.
> > >>>>>>>>>
> > >>>>>>>>> If you can isolate the .33 works/.37 works_not bug to a specific pair of versions,
> > >>>>>>>>>     I'll be happy to do another diff.
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Hope you'll have had a good Christmas as well.
> > >>>>>>>>>    We've had snow in Alabama since Christmas eve!
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Regards,
> > >>>>>>>>>
> > >>>>>>>>> Stuart
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> -----Original Message-----
> > >>>>>>>>> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
> > >>>>>>>>> Sent: Friday, December 24, 2010 5:34 PM
> > >>>>>>>>> To: Anoop P A
> > >>>>>>>>> Cc: STUART VENTERS; Anoop P.A.; linux-mips@linux-mips.org
> > >>>>>>>>> Subject: Re: SMTC support status in latest git head.
> > >>>>>>>>>
> > >>>>>>>>>
> > >>>>>>>>> Ah, well, at least we have a stackframe.h fix that preserves David's
> > >>>>>>>>> performance tweak for the deeper pipelined processors.  In looking for
> > >>>>>>>>> this, I did notice that someone did some modification to the SMTC clock
> > >>>>>>>>> tick logic that I was skeptical had ever been tested.  If you've still
> > >>>>>>>>> got that kernel binary handy, you might check to see if it boots with
> > >>>>>>>>> maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.
> > >>>>>>>>>
> > >>>>>>>>> Oh, yes, and Merry Christmas one and all!
> > >>>>>>>>>
> > >>>>>>>>>               Regards,
> > >>>>>>>>>
> > >>>>>>>>>               Kevin K.
> > >>>>>>>>>
> > >>>>>>>>> On 12/24/10 8:02 AM, Anoop P A wrote:
> > >>>>>>>>>> On Fri, 2010-12-24 at 06:53 -0800, Kevin D. Kissell wrote:
> > >>>>>>>>>>> Excellent!  Now, does the attached patch (relative to 2.6.37.11) also
> > >>>>>>>>>>> fix things, while preserving the other fixes and performance enhancements?
> > >>>>>>>>>>>
> > >>>>>>>>>> I have tested that patch with 2.6.37 branch it well passes calibration
> > >>>>>>>>>> loop but hangs after switching to mips closource
> > >>>>>>>>>>
> > >>>>>>>>>> TC 6 going on-line as CPU 6
> > >>>>>>>>>> Brought up 7 CPUs
> > >>>>>>>>>> bio: create slab<bio-0>   at 0
> > >>>>>>>>>> SCSI subsystem initialized
> > >>>>>>>>>> Switching to clocksource MIPS
> > >>>>>>>>>>
> > >>>>>>>>>> I Presume this is a different issue as restoring older file didn't help
> > >>>>>>>>>> much to get rid of this hang.
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/arch/mips/include/asm/stackframe.h
> > >>>>>>>>>> b/arch/mips/include/asm/stackframe.h
> > >>>>>>>>>> index 58730c5..7fc9f10 100644
> > >>>>>>>>>> --- a/arch/mips/include/asm/stackframe.h
> > >>>>>>>>>> +++ b/arch/mips/include/asm/stackframe.h
> > >>>>>>>>>> @@ -195,9 +195,9 @@
> > >>>>>>>>>>    		 * to cover the pipeline delay.
> > >>>>>>>>>>    		 */
> > >>>>>>>>>>    		.set	mips32
> > >>>>>>>>>> -		mfc0	v1, CP0_TCSTATUS
> > >>>>>>>>>> +		mfc0	v0, CP0_TCSTATUS
> > >>>>>>>>>>    		.set	mips0
> > >>>>>>>>>> -		LONG_S	v1, PT_TCSTATUS(sp)
> > >>>>>>>>>> +		LONG_S	v0, PT_TCSTATUS(sp)
> > >>>>>>>>>>    #endif /* CONFIG_MIPS_MT_SMTC */
> > >>>>>>>>>>    		LONG_S	$4, PT_R4(sp)
> > >>>>>>>>>>    		LONG_S	$5, PT_R5(sp)
> > >>>>>>>>>>
> > >>>>>>>>>>
> > >>>>>>>>>>> /K.
> > >>>>>>>>>>>
> > >>>>>>>>>>> On 12/24/10 6:39 AM, Anoop P A wrote:
> > >>>>>>>>>>>> Hi Kevin, Stuart ,
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Woohooo You guys spotted !.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>>     http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
> > >>>>>>>>>>>> the culprit
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Once I restored previous version of stackframe.h 2.6.33-stable started
> > >>>>>>>>>>>> booting !.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Thanks,
> > >>>>>>>>>>>> Anoop
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
> > >>>>>>>>>>>>> Thank you, Stuart!  I've spotted some definite breakage to SMTC between
> > >>>>>>>>>>>>> those versions.  In arch/mips/include/asm/stackframe.h, someone moved
> > >>>>>>>>>>>>> the store of the Status register value in SAVE_SOME (line 169 or 204,
> > >>>>>>>>>>>>> depending on the version) from two instructions after the mfc0 to a
> > >>>>>>>>>>>>> point after the #ifdef for SMTC, presumably to get better pipelining of
> > >>>>>>>>>>>>> the register access.  Unfortunately, the v1 register is also used in the
> > >>>>>>>>>>>>> SMTC-specific fragment to save TCStatus, so the Status value gets
> > >>>>>>>>>>>>> clobbered before it gets stored.  This will eventually result in the
> > >>>>>>>>>>>>> Status register getting a TCStatus value, which has some bits on common,
> > >>>>>>>>>>>>> but isn't identical and sooner or later Bad Things will happen.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> I'm a little surprised this wasn't caught by visual inspection of the patch.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Possible solutions would include reverting the store of the CP0_STATUS
> > >>>>>>>>>>>>> value to the block above the #ifdef, or, to retain whatever performance
> > >>>>>>>>>>>>> advantage was obtained by moving the store downward, to use v0/$2
> > >>>>>>>>>>>>> instead of v1/$3, as the staging register for the TCStatus value.  I'd
> > >>>>>>>>>>>>> lean toward the second option, but I'm not in a position to test and
> > >>>>>>>>>>>>> submit a patch just now.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>                 Regards,
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>>                 Kevin K.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> On 12/23/10 1:09 PM, STUART VENTERS wrote:
> > >>>>>>>>>>>>>> Kevin,
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> I'm not sure if it's useful,
> > >>>>>>>>>>>>>>        but finally I got the time to look at the two kernel versions Anoop pointed out.
> > >>>>>>>>>>>>>>         works   2.6.32-stable with patch 804
> > >>>>>>>>>>>>>>         works_not 2.6.33-stable
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> greping for files with CONFIG_MIPS_MT_SMTC
> > >>>>>>>>>>>>>>        and looking for timer interrupt related stuff found the following differences:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> arch/mips/include/asm/irq.h
> > >>>>>>>>>>>>>> arch/mips/kernel/irq.c
> > >>>>>>>>>>>>>>       do_IRQ
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> arch/mips/include/asm/stackframe.h
> > >>>>>>>>>>>>>>       SAVE_SOME SAVE_TEMP get/set_saved_sp
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> arch/mips/include/asm/time.h
> > >>>>>>>>>>>>>>       clocksource_set_clock
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> arch/mips/kernel/process.c
> > >>>>>>>>>>>>>>       cpu_idle
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> arch/mips/kernel/smtc.c
> > >>>>>>>>>>>>>>       __irq_entry
> > >>>>>>>>>>>>>>       ipi_decode
> > >>>>>>>>>>>>>>           SMTC_CLOCK_TICK
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Enclosed are the two subsets of files for a more expert look.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> I'll try to look in more detail after Christmas.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Cheers,
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> Stuart
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>
> > >
> > 
> 
