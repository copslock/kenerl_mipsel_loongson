Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2010 11:05:36 +0100 (CET)
Received: from gateway05.websitewelcome.com ([69.93.35.13]:47594 "HELO
        gateway05.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492723Ab0K3KFc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Nov 2010 11:05:32 +0100
Received: (qmail 30507 invoked from network); 30 Nov 2010 10:04:22 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway05.websitewelcome.com with SMTP; 30 Nov 2010 10:04:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=NoVqc3mJc/yS2NQDHUTzp9F7wFOfRUki4WyjWGaQuQW/YvV1A7+V39hf12BYIQHjaYXUq5x6dkXmpozdTzc5fddU6Q7qFTQ55Lix0BxB/ibT46/snhpehOHsSjK8exFw;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:1365 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PNN5Q-0002N2-CA; Tue, 30 Nov 2010 04:05:24 -0600
Message-ID: <4CF4CC6B.9090603@paralogos.com>
Date:   Tue, 30 Nov 2010 02:05:31 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>      <20101122034141.GA13138@linux-mips.org> <4CEAE1EE.9020406@paralogos.com>        <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>  <4CEE877C.7020309@paralogos.com>        <AANLkTinUSjvjwHVJoRW-Fr75WDfheq3hSM_hEBMsEUXK@mail.gmail.com>  <4CF46741.9060902@paralogos.com> <AANLkTikb32T_c7iu6aa0mXDDqC4ncsV9iQAqyVKHy1_y@mail.gmail.com>
In-Reply-To: <AANLkTikb32T_c7iu6aa0mXDDqC4ncsV9iQAqyVKHy1_y@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
X-archive-position: 28574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 11/29/2010 7:21 PM, Maksim Rayskiy wrote:
> On Mon, Nov 29, 2010 at 6:53 PM, Kevin D. Kissell <kevink@paralogos.com> wrote:
>> Having done surgery in the past to the ASID management code, this sounds
>> like
>> a much more rational explanation of the observed problem.  Your proposed mod
>> sounds like it might work, but local_flush_tlb_mm() is implemented in terms
>> of
>> drop_mmu_context(), which only does what you want if the CPU executing the
>> code is *not* one of the CPUs participating in the memory map.  Otherwise,
>> instead of clearing the ASID in the table, it allocates a new one.  I have a
>> concern
>> that this may re-randomize things in a way that will solve your problem
>> *most*
>> of the time, but not always.
>>
> Actually, if you call this function late enough, specifically when
> cpu_online(cpu) is 0, it does exactly what I want from it - that is
> clears ASID in the context.

It does exactly what you want when cpumask_test_cpu(cpu, mm_cpumask(mm))
is false, but I don't think that will necessarily be the case when
cpu_online(cpu) is 0.
It's keying off the CPU mask in the mm struct, not the global online
mask.  If those
are actually guaranteed to be in sync, then your hack would be fine.  
I'd just beseech
you to make sure you comment the invocation of drop_mmu_context() is
commented
to the effect that "This needs to be done after the CPU is offline for
the purposes
of a cpumask check on the mm".
> I am calling it from play_dead() which is platform specific, but there
> might be a place for it in platform-independent code as well.
> Another option would be not to use drop_mmu_context() but rather clear
> the context directly, since we know exactly what we want to do at this
> point.
>
>> Now that we have a better understanding of the failure, your initial notion
>> of *not* restarting the ASID sequence on a hotplug insertion doesn't seem
>> as crazy - it's certainly the zen "doing by doing nothing" way to go,
>> without
>> the iterative overhead of walking the full process table.  But as we
>> discussed,
>> it has the downside of requiring new state infrastructure for tracking
>> hotplugs,
>> and we'd want to be sure that it's well behaved in the case where we have a
>> post-initial-boot hotplug event that brings a CPU online that has never been
>> initialized.  To take that tack, we'd need a per-CPU-slot bit which says "I
>> have
>> a valid ASID sequence, thank you", which is checked in per_cpu_trap_init()
>> (or some other appropriate hook), and the ASID "cache" is initialized only
>> if it's needed, which *might* be on a hotplug.
> You are talking about adding this bit to cpuinfo_mips, correct?

That would be a logical place to hang it, though I'm not sure if we keep
volatile data like that in the array these days.  It might need to be
lock protected.

            Regards,

            Kevin K.
