Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 18:40:42 +0100 (CET)
Received: from gateway16.websitewelcome.com ([67.18.21.17]:47635 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490956Ab1ADRki (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 18:40:38 +0100
Received: (qmail 9400 invoked from network); 4 Jan 2011 17:40:08 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 4 Jan 2011 17:40:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=M3jXPuBg+a3FaC5cpT/Kx8GY8sKg3FplrHV5uTuBpTZ4qq4JcbcF08F66kQdSPj03pHzI6Q0siChxqSv8AfM44KjG3Hqo+Gn+8JGSi3SELpTTD6F+DifI7GkdbMEcr0n;
Received: from [216.239.45.4] (port=21822 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PaAry-0008N4-Nm; Tue, 04 Jan 2011 11:40:27 -0600
Message-ID: <4D235B8D.2070306@paralogos.com>
Date:   Tue, 04 Jan 2011 09:40:29 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>      <1293470392.27661.202.camel@paanoop1-desktop>   <1293524389.27661.210.camel@paanoop1-desktop>   <4D19A31E.1090905@paralogos.com>        <1293798476.27661.279.camel@paanoop1-desktop>   <4D1EE913.1070203@paralogos.com>        <1294067561.27661.293.camel@paanoop1-desktop>   <4D21F5D3.50604@paralogos.com>  <1294082426.27661.330.camel@paanoop1-desktop>   <4D22D7B3.2050609@paralogos.com> <1294146165.27661.361.camel@paanoop1-desktop>
In-Reply-To: <1294146165.27661.361.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/04/11 05:02, Anoop P A wrote:
> On Tue, 2011-01-04 at 00:17 -0800, Kevin D. Kissell wrote:
>> Those interrupt counters show that IPIs are being taken everywhere,
>> though very few by CPUs 5 and 6.  If I understand the configuration
>> correctly, CPU 4 is a TC in VPE 1, and it's getting a reasonable IPI
> Yes CPU4 is in second VPE
>
>> rate, *if* we're looking at a tickless kernel under low load.  But there
> No it was not the tickless kernel.I had selected 250 MHz timer. can't we
> expect IPI / timer interrupt for all the threads in this case ?.

In that case, you should expect a distribution of timer interrupts that 
favors the low-numbered TCs within the VPE, as you do in VPE0, and a 
distribution of IPIs that is sort-of the inverse, as you do in VPE0.  
But the low counts on VPE1 are indeed suspicious, as you note.

>> may be a clue there to part of your problem.  I have no idea why the
>> behavior would have changed from 2.6.36 to 2.6.37, but it looks as if
>> you're getting your clock interrupts through the MSP CIC interrupt
>> controller on VPE 0.  There's nothing symmetric for VPE1. The Malta
>> example code is perhaps deceptively simple, in that both VPEs have their
>> count/compare indication wired directly to the 2 clock interrupt inputs,
>> so that having both of them running with only a single set of irq state
>> just works.  I don't know whether the MSP CIC timer interrupt is a
> In my case it is separate irq. MSP_INT_VPE1_TIMER (34) and
> MSP_INT_VPE0_TIMER (25) are wired to CIC . CIC interrupt has been
> connected to cpu irq 6.
>
> I can reproduce cpu stall in VSMP mode If I don't setup VPE1 timer
> interrupt . Don't we have support for separate irq in SMTC
> implementation ?..

There are hooks for platform-specific SMTC support, which is implemented 
for the Malta in arch/mips/mti-malta/malta-smtc.c.  See 
msmtc_init_secondary(), for example, where the clock/compare, profile, 
and IPI interrupts are armed for VPE 1, while I/O peripheral interrupts 
are inhibited.

>> gating of the VPE0 count/compare output, or whether it's it's own
>> interval timer, but I suspect that you may need to do some further
>> low-level initialization in the platform-specific code to set up an
>> interrupt on the VPE1 side.  I don't think the snippet you've got below
>> would work as written.
> The routine which I copied works fine for VSMP mode .
>
> / # cat /proc/interrupts
>             CPU0       CPU1
>    0:        187        254            MIPS  IPI_resched
>    1:         77        174            MIPS  IPI_call
>    6:          0          0            MIPS  MSP CIC cascade
>    8:          0          0         MSP_CIC  Softreset button
>    9:          0          0         MSP_CIC  Standby switch
>   21:          0          0         MSP_CIC  MSP PER cascade
>   25:      37077          0         MSP_CIC  timer
>   27:        188          0         MSP_CIC  serial
>   34:          0      36986         MSP_CIC  timer
>
> Do I want to change anything specific for SMTC ? .

If it works (which I doubt), then we can critique stylistic points like 
using

		if ((1==get_current_vpe())

Instead of the more readable and general

		if (get_current_vpe()>  0)


But I think you're generally looking in the wrong place.  Look at the 
Malta code and see what's done where.  The initial SMTC code had a lot 
of Malta assumptions in the main line that I pushed out to platform code 
in later patches.  I can see how things could be made even more modular, 
but for the moment I think it's just that there's some stuff that ought 
to be done in a "msp_smtc.c" file that doesn't exist in 2.6.37.

             Regards,

             Kevin K.
>
>
>> If it's purely an issue with clock distribution on VPE1, then a boot
>> with maxvpes=1 maxtcs=4 should be stable.
> Yes the kernel seems to be stable if I boot with maxvpes=1 maxtcs=4 .
>
>> /K.
>>
>> On 1/3/2011 11:20 AM, Anoop P A wrote:
>>> Hi Kevin,
>>>
>>> On Mon, 2011-01-03 at 08:14 -0800, Kevin D. Kissell wrote:
>>>> The very first SMTC implementations didn't support full kernel-mode
>>>> preemption, which anyway wasn't a priority, given the hardware event
>>>> response support in MIPS MT.  I believe it was later made compatible,
>>>> but it was never extensively exercised.  Since SMTC has fingers in some
>>>> pretty low-level atomicity mechanisms, if a new, parallel set was
>>>> implemented for RCU, I can easily imagine that nobody has yet
>>>> implemented SMTC-ified variants of that set.
>>>>
>>>> Your last statement isn't very clear, though.  Are you saying that if
>>>> you configure for no forced preemption and with TREE_CPU, the 2.6.37
>>>> kernel boots all the way up, or that it simply hangs later?   What's the
>>>> last rev kernel that actually boots all the way up?
>>> I have debugged this a bit more. It seems that kernel getting stalled
>>> while executing on TC's of second VPE .
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=2504 jiffies)
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=10036 jiffies)
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=17568 jiffies)
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=25100 jiffies)
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=32632 jiffies)
>>> INFO: rcu_sched_state detected stalls on CPUs/tasks: { 4 5 6} (detected
>>> by 1, t=40164 jiffies)
>>>
>>> With CONFIG_TREE_CPU we were not hitting this scenario very often.
>>> However with CONFIG_PREEMPT_TREE_CPU stall happens most of the time.
>>>
>>> I presume some issue in my timer setup . I am not seeing timer interrupt
>>> (or IPI interrupt) getting  incremented for VPE1 tcs on a completely
>>> booted 2.6.32-stable kernel.
>>>
>>> / # cat /proc/interrupts
>>>             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5
>>> CPU6
>>>    1:        148      15023      15140      15093       3779          8
>>> 2            MIPS  SMTC_IPI
>>>    6:          0          0          0          0          0          0
>>> 0            MIPS  MSP CIC cascade
>>>    8:          0          0          0          0          0          0
>>> 0         MSP_CIC  Softreset button
>>>    9:          0          0          0          0          0          0
>>> 0         MSP_CIC  Standby switch
>>>   21:          0          0          0          0          0          0
>>> 0         MSP_CIC  MSP PER cascade
>>>   25:      15113        341          4          7          0          0
>>> 0         MSP_CIC  timer
>>>   27:        260          9          0          1          0          0
>>> 0         MSP_CIC  serial
>>>   34:          0          0          0          0          0          0
>>> 0         MSP_CIC  timer
>>>
>>> Can't we use separate timer interrupts for VPE1 and VPE0 in SMTC ?.
>>>
>>> I have tried setting up VPE1 timer from get_co_compare_int as follows
>>>
>>> unsigned int __cpuinit get_c0_compare_int(void)
>>> {
>>> 	if ((1==get_current_vpe())&&  !vpe1_timr_installed){
>>> 	
>>> 	memcpy(&timer_vpe1,&c0_compare_irqaction,sizeof(timer_vpe1));
>>> 	
>>> 	setup_irq(MSP_INT_VPE1_TIMER,&timer_vpe1);
>>>                    vpe1_timr_installed++;
>>>            }
>>>            return (get_current_vpe() ? MSP_INT_VPE1_TIMER :
>>> MSP_INT_VPE0_TIMER);
>>> }
>>>
>>> Thanks
>>> Anoop
