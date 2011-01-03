Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2011 17:14:16 +0100 (CET)
Received: from gateway01.websitewelcome.com ([69.93.136.19]:48521 "HELO
        gateway01.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491970Ab1ACQON (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jan 2011 17:14:13 +0100
Received: (qmail 19839 invoked from network); 3 Jan 2011 16:13:46 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 3 Jan 2011 16:13:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=TEbJ4dvO3C7v2obLKNzhwF8Z9O28szgSxyeuhL6T4dZVfW+z0ubieP1OlIM6eKnd5j09RG3J6YnED1kzWiC2eAVIsetn607ReVapGIwvkRXHJ8+91lmiOWPDT0Y8nrN1;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:2988 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PZn2t-0004F3-8J; Mon, 03 Jan 2011 10:14:07 -0600
Message-ID: <4D21F5D3.50604@paralogos.com>
Date:   Mon, 03 Jan 2011 08:14:11 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>         <1293470392.27661.202.camel@paanoop1-desktop>         <1293524389.27661.210.camel@paanoop1-desktop>         <4D19A31E.1090905@paralogos.com>         <1293798476.27661.279.camel@paanoop1-desktop>         <4D1EE913.1070203@paralogos.com> <1294067561.27661.293.camel@paanoop1-desktop>
In-Reply-To: <1294067561.27661.293.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8
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
X-archive-position: 28809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

The very first SMTC implementations didn't support full kernel-mode
preemption, which anyway wasn't a priority, given the hardware event
response support in MIPS MT.  I believe it was later made compatible,
but it was never extensively exercised.  Since SMTC has fingers in some
pretty low-level atomicity mechanisms, if a new, parallel set was
implemented for RCU, I can easily imagine that nobody has yet
implemented SMTC-ified variants of that set.

Your last statement isn't very clear, though.  Are you saying that if
you configure for no forced preemption and with TREE_CPU, the 2.6.37
kernel boots all the way up, or that it simply hangs later?   What's the
last rev kernel that actually boots all the way up?

            Regards,

            Kevin K.

On 1/3/2011 7:12 AM, Anoop P A wrote:
> Hi ,
>
> Following patch restricts TREE_CPU RCU implementation only for !PREEMPT
> SMP kernel.  
> http://git.linux-mips.org/?p=linux.git;a=commit;h=687d7a960aea46e016182c7ce346d62c4dbd0366
>
> CONFIG_TREE_PREEMPT_RCU option seems to be not working for SMTC kernel
> ( which will be only available RCU implementation for SMTC kernel from
> 2.6.37 onwards) .
>
> With no forced preemption and selecting TREE_CPU I am able to boot
> further to the hang that I have reported.
>
> Thanks
> Anoop
>
> On Sat, 2011-01-01 at 00:42 -0800, Kevin D. Kissell wrote:
>> At this point the logical thing to do would seem to look at your kernel
>> image and disassemble smtc_ipi_replay(), which is where the EPC of VPE 0
>> shows the last exception to have been taken.  That's a critical SMTC
>> routine that gets called whenever an xxx_irq_restore() enables
>> interrupts, so that virtual per-TC IPI interrupts that were posted while
>> the TC had interrupts disabled can be handled deterministically.  As I
>> mentioned in an earlier message, there was some cleanup work from David
>> Howell that changed a number of irq management-related function names
>> and prototypes across all architectures, which went into linux-mips.org
>> at very roughly the time of the breakage.  The SMTC overlay over the irq
>> implementation has been pretty robust, but it's written in a perhaps
>> doomed attempt to be both efficient and using a maximum amount of common
>> code with the general case.  A mechanical or semi-mechanical change
>> could conceivably have broken things.
>>
>>             Regards,
>>
>>             Kevin K.
>>
>>
>> On 12/31/2010 4:27 AM, Anoop P A wrote:
>>> Hi ,
>>>
>>> Kernel hangs on stop_machine call. Please find mt reg dump below.
>>> Another important observation is even though 2.6.33 kernel + stackframe
>>> patch well passes calibration hang , I am still unable boot in to a
>>> initramfs root ( verified ramfs working with VSMP). So it looks like
>>> still some issue to fix between 2.6.32 and 2.6.33 .
>>> ######################## Log ###########################
>>>
>>> === MIPS MT State Dump ===
>>> -- Global State --
>>>    MVPControl Passed: 00000005
>>>    MVPControl Read: 00000004
>>>    MVPConf0 : a8008406
>>> -- per-VPE State --
>>>   VPE 0
>>>    VPEControl : 00008000
>>>    VPEConf0 : 800f0003
>>>    VPE0.Status : 11004201
>>>    VPE0.EPC : 8010dc54 smtc_ipi_replay+0xcc/0x108
>>>    VPE0.Cause : 50804000
>>>    VPE0.Config7 : 00010000
>>>   VPE 1
>>>    VPEControl : 00068006
>>>    VPEConf0 : 80cf0003
>>>    VPE1.Status : 11008301
>>>    VPE1.EPC : 801022a0 r4k_wait+0x20/0x40
>>>    VPE1.Cause : 50800000
>>>    VPE1.Config7 : 00010000
>>> -- per-TC State --
>>>   TC 0 (current TC with VPE EPC above)
>>>    TCStatus : 18102000
>>>    TCBind : 00000000
>>>    TCRestart : 803fa19c printk+0xc/0x30
>>>    TCHalt : 00000000
>>>    TCContext : 00000000
>>>   TC 1
>>>    TCStatus : 18902000
>>>    TCBind : 00200000
>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 00140000
>>>   TC 2
>>>    TCStatus : 18902000
>>>    TCBind : 00400000
>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 00280000
>>>   TC 3
>>>    TCStatus : 18902000
>>>    TCBind : 00600000
>>>    TCRestart : 801022a0 r4k_wait+0x20/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 003c0000
>>>   TC 4
>>>    TCStatus : 18902000
>>>    TCBind : 00800001
>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 00500000
>>>   TC 5
>>>    TCStatus : 18902000
>>>    TCBind : 00a00001
>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 00640000
>>>   TC 6
>>>    TCStatus : 18902000
>>>    TCBind : 00c00001
>>>    TCRestart : 8010229c r4k_wait+0x1c/0x40
>>>    TCHalt : 00000000
>>>    TCContext : 00780000
>>> Counter Interrupts taken per CPU (TC)
>>> 0: 0
>>> 1: 0
>>> 2: 0
>>> 3: 0
>>> 4: 0
>>> 5: 0
>>> 6: 0
>>> 7: 0
>>> Self-IPI invocations:
>>> 0: 12
>>> 1: 0
>>> 2: 0
>>> 3: 0
>>> 4: 0
>>> 5: 5
>>> 6: 4
>>> 7: 0
>>> IPIQ[0]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[1]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[2]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[3]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[4]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[5]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[6]: head = 0x0, tail = 0x0, depth = 0
>>> IPIQ[7]: head = 0x0, tail = 0x0, depth = 0
>>> 0 Recoveries of "stolen" FPU
>>> ===========================
>>>
>>> ################################################################
>>>
>>> Thanks
>>> Anoop
>>>
>>> On Tue, 2010-12-28 at 00:43 -0800, Kevin D. Kissell wrote:
>>>> I took a quick look last night, and the only thing that looked vaguely 
>>>> dangerous in changes since the timer changes I alluded to earlier was 
>>>> the global naming cleanup of irq-related function names that David 
>>>> Howell submitted.  The diff didn't look dangerous in itself, but some of 
>>>> the definitions are nested subtly for SMTC to maximize the amount of 
>>>> common code, and I could imagine something getting lost in translation 
>>>> there.  If that were really the problem, it would of course affect much 
>>>> more than just the timer subsystem, but early in the boot process, 
>>>> timers are pretty much the only interrupts that have to be handled 
>>>> correctly.
>>>>
>>>> I'm travelling today, but will take a look at timekeeping_notify() 
>>>> tomorrow or the next day...
>>>>
>>>> /K.
>>>>
>>>> On 12/28/10 12:19 AM, Anoop P A wrote:
>>>>> Hi,
>>>>>
>>>>> I had a glance into the code diff without notice of any suspect-able
>>>>> code .
>>>>> Tracing the hang showed that it is getting hanged in timekeeping_notify
>>>>> function.
>>>>>
>>>>> Thanks,
>>>>> Anoop
>>>>>
>>>>> PS: I may not be available until Thursday
>>>>>
>>>>> On Mon, 2010-12-27 at 22:49 +0530, Anoop P A wrote:
>>>>>> Hi Kevin,
>>>>>>
>>>>>> It is very unlikely that the patch you pointed has any impact on the the
>>>>>> hang I am seeing. The patch you have mentioned got into kernel around
>>>>>> 2.6.32 timeframe. I am able to boot both 2.6.32 and  2.6.33 kernel ( +
>>>>>> stackframe patch) .
>>>>>>
>>>>>> Hi Stuart,
>>>>>>
>>>>>> I haven't got much time to spend on this today.
>>>>>>
>>>>>> I had got 2.6.36-stable(+ stack frame patch) booting last day and I have
>>>>>> observed hang issue with 2.6.37-rc1 ( Same as rc6 and current git head)
>>>>>>
>>>>>> So probably some patches in 2.6.37 branch introduced this hang.
>>>>>>
>>>>>> Hopefully I will get some free slot tomorrow so that I can look into
>>>>>> code diff .
>>>>>>
>>>>>> Thanks
>>>>>> Anoop
>>>>>>
>>>>>> On Mon, 2010-12-27 at 09:49 -0600, STUART VENTERS wrote:
>>>>>>> Kevin,
>>>>>>>
>>>>>>> Outstanding, sometimes it's better to be lucky than good.
>>>>>>>
>>>>>>>
>>>>>>> Anoop,
>>>>>>>
>>>>>>> Maybe we can get lucky again.
>>>>>>>
>>>>>>> If you can isolate the .33 works/.37 works_not bug to a specific pair of versions,
>>>>>>>     I'll be happy to do another diff.
>>>>>>>
>>>>>>>
>>>>>>> Hope you'll have had a good Christmas as well.
>>>>>>>    We've had snow in Alabama since Christmas eve!
>>>>>>>
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Stuart
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Kevin D. Kissell [mailto:kevink@paralogos.com]
>>>>>>> Sent: Friday, December 24, 2010 5:34 PM
>>>>>>> To: Anoop P A
>>>>>>> Cc: STUART VENTERS; Anoop P.A.; linux-mips@linux-mips.org
>>>>>>> Subject: Re: SMTC support status in latest git head.
>>>>>>>
>>>>>>>
>>>>>>> Ah, well, at least we have a stackframe.h fix that preserves David's
>>>>>>> performance tweak for the deeper pipelined processors.  In looking for
>>>>>>> this, I did notice that someone did some modification to the SMTC clock
>>>>>>> tick logic that I was skeptical had ever been tested.  If you've still
>>>>>>> got that kernel binary handy, you might check to see if it boots with
>>>>>>> maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.
>>>>>>>
>>>>>>> Oh, yes, and Merry Christmas one and all!
>>>>>>>
>>>>>>>               Regards,
>>>>>>>
>>>>>>>               Kevin K.
>>>>>>>
>>>>>>> On 12/24/10 8:02 AM, Anoop P A wrote:
>>>>>>>> On Fri, 2010-12-24 at 06:53 -0800, Kevin D. Kissell wrote:
>>>>>>>>> Excellent!  Now, does the attached patch (relative to 2.6.37.11) also
>>>>>>>>> fix things, while preserving the other fixes and performance enhancements?
>>>>>>>>>
>>>>>>>> I have tested that patch with 2.6.37 branch it well passes calibration
>>>>>>>> loop but hangs after switching to mips closource
>>>>>>>>
>>>>>>>> TC 6 going on-line as CPU 6
>>>>>>>> Brought up 7 CPUs
>>>>>>>> bio: create slab<bio-0>   at 0
>>>>>>>> SCSI subsystem initialized
>>>>>>>> Switching to clocksource MIPS
>>>>>>>>
>>>>>>>> I Presume this is a different issue as restoring older file didn't help
>>>>>>>> much to get rid of this hang.
>>>>>>>>
>>>>>>>> diff --git a/arch/mips/include/asm/stackframe.h
>>>>>>>> b/arch/mips/include/asm/stackframe.h
>>>>>>>> index 58730c5..7fc9f10 100644
>>>>>>>> --- a/arch/mips/include/asm/stackframe.h
>>>>>>>> +++ b/arch/mips/include/asm/stackframe.h
>>>>>>>> @@ -195,9 +195,9 @@
>>>>>>>>    		 * to cover the pipeline delay.
>>>>>>>>    		 */
>>>>>>>>    		.set	mips32
>>>>>>>> -		mfc0	v1, CP0_TCSTATUS
>>>>>>>> +		mfc0	v0, CP0_TCSTATUS
>>>>>>>>    		.set	mips0
>>>>>>>> -		LONG_S	v1, PT_TCSTATUS(sp)
>>>>>>>> +		LONG_S	v0, PT_TCSTATUS(sp)
>>>>>>>>    #endif /* CONFIG_MIPS_MT_SMTC */
>>>>>>>>    		LONG_S	$4, PT_R4(sp)
>>>>>>>>    		LONG_S	$5, PT_R5(sp)
>>>>>>>>
>>>>>>>>
>>>>>>>>> /K.
>>>>>>>>>
>>>>>>>>> On 12/24/10 6:39 AM, Anoop P A wrote:
>>>>>>>>>> Hi Kevin, Stuart ,
>>>>>>>>>>
>>>>>>>>>> Woohooo You guys spotted !.
>>>>>>>>>>
>>>>>>>>>>     http://git.linux-mips.org/?p=linux.git;a=commit;h=d5ec6e3c seems to be
>>>>>>>>>> the culprit
>>>>>>>>>>
>>>>>>>>>> Once I restored previous version of stackframe.h 2.6.33-stable started
>>>>>>>>>> booting !.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Anoop
>>>>>>>>>>
>>>>>>>>>> On Fri, 2010-12-24 at 04:32 -0800, Kevin D. Kissell wrote:
>>>>>>>>>>> Thank you, Stuart!  I've spotted some definite breakage to SMTC between
>>>>>>>>>>> those versions.  In arch/mips/include/asm/stackframe.h, someone moved
>>>>>>>>>>> the store of the Status register value in SAVE_SOME (line 169 or 204,
>>>>>>>>>>> depending on the version) from two instructions after the mfc0 to a
>>>>>>>>>>> point after the #ifdef for SMTC, presumably to get better pipelining of
>>>>>>>>>>> the register access.  Unfortunately, the v1 register is also used in the
>>>>>>>>>>> SMTC-specific fragment to save TCStatus, so the Status value gets
>>>>>>>>>>> clobbered before it gets stored.  This will eventually result in the
>>>>>>>>>>> Status register getting a TCStatus value, which has some bits on common,
>>>>>>>>>>> but isn't identical and sooner or later Bad Things will happen.
>>>>>>>>>>>
>>>>>>>>>>> I'm a little surprised this wasn't caught by visual inspection of the patch.
>>>>>>>>>>>
>>>>>>>>>>> Possible solutions would include reverting the store of the CP0_STATUS
>>>>>>>>>>> value to the block above the #ifdef, or, to retain whatever performance
>>>>>>>>>>> advantage was obtained by moving the store downward, to use v0/$2
>>>>>>>>>>> instead of v1/$3, as the staging register for the TCStatus value.  I'd
>>>>>>>>>>> lean toward the second option, but I'm not in a position to test and
>>>>>>>>>>> submit a patch just now.
>>>>>>>>>>>
>>>>>>>>>>>                 Regards,
>>>>>>>>>>>
>>>>>>>>>>>                 Kevin K.
>>>>>>>>>>>
>>>>>>>>>>> On 12/23/10 1:09 PM, STUART VENTERS wrote:
>>>>>>>>>>>> Kevin,
>>>>>>>>>>>>
>>>>>>>>>>>> I'm not sure if it's useful,
>>>>>>>>>>>>        but finally I got the time to look at the two kernel versions Anoop pointed out.
>>>>>>>>>>>>         works   2.6.32-stable with patch 804
>>>>>>>>>>>>         works_not 2.6.33-stable
>>>>>>>>>>>>
>>>>>>>>>>>> greping for files with CONFIG_MIPS_MT_SMTC
>>>>>>>>>>>>        and looking for timer interrupt related stuff found the following differences:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> arch/mips/include/asm/irq.h
>>>>>>>>>>>> arch/mips/kernel/irq.c
>>>>>>>>>>>>       do_IRQ
>>>>>>>>>>>>
>>>>>>>>>>>> arch/mips/include/asm/stackframe.h
>>>>>>>>>>>>       SAVE_SOME SAVE_TEMP get/set_saved_sp
>>>>>>>>>>>>
>>>>>>>>>>>> arch/mips/include/asm/time.h
>>>>>>>>>>>>       clocksource_set_clock
>>>>>>>>>>>>
>>>>>>>>>>>> arch/mips/kernel/process.c
>>>>>>>>>>>>       cpu_idle
>>>>>>>>>>>>
>>>>>>>>>>>> arch/mips/kernel/smtc.c
>>>>>>>>>>>>       __irq_entry
>>>>>>>>>>>>       ipi_decode
>>>>>>>>>>>>           SMTC_CLOCK_TICK
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Enclosed are the two subsets of files for a more expert look.
>>>>>>>>>>>>
>>>>>>>>>>>> I'll try to look in more detail after Christmas.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Cheers,
>>>>>>>>>>>>
>>>>>>>>>>>> Stuart
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>
>
