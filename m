Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 18:49:34 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59174 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdHOQtSD9eOa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 18:49:18 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B137F2B;
        Tue, 15 Aug 2017 09:49:10 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C5A9E3F483;
        Tue, 15 Aug 2017 09:49:09 -0700 (PDT)
Subject: Re: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <deae1e69-010e-474d-9bb6-a4d92c955356@arm.com>
 <1561377.UX34hIl2NL@np-p-burton>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d8ce06f2-4205-91d1-78e8-34ea9c7fe855@arm.com>
Date:   Tue, 15 Aug 2017 17:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1561377.UX34hIl2NL@np-p-burton>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 15/08/17 17:16, Paul Burton wrote:
> Hi Marc,
> 
> On Tuesday, 15 August 2017 03:13:03 PDT Marc Zyngier wrote:
>> Hi Paul,
>>
>> On 13/08/17 05:36, Paul Burton wrote:
>>> This series cleans up the MIPS Global Interrupt Controller (GIC) driver
>>> somewhat. It moves us towards using a header in a similar vein to the
>>> ones we have for the MIPS Coherence Manager (CM) & Cluster Power
>>> Controller (CPC) which allows us to access the GIC outside of the
>>> irqchip driver - something beneficial already for the clocksource &
>>> clock event driver, and which will be beneficial for further drivers
>>> (eg. one for the GIC watchdog timer) and for multi-cluster work. Using
>>> this header is also beneficial for consistency & code-sharing.
>>>
>>> In addition to cleanups the series also optimises the driver in various
>>> ways, including by using a per-CPU variable for pcpu_masks & removing
>>> the need to read the GIC_SH_MASK_* registers when decoding interrupts in
>>> gic_handle_shared_int().
>>>
>>> This series requires my "[PATCH 00/19] MIPS: Initial multi-cluster
>>> support" series to be applied first.
>>
>> I'm not on Cc on this one, so it is a bit hard to see what's going on.
> 
> That other series is only really related insomuch as it adds asm/mips-cps.h 
> which this series makes use of, and changes a couple of lines in irq-mips-
> gic.c which would cause conflicts if this series is applied without the other 
> first.
> 
>> But overall, it is incredibly difficult to follow what is going on here.
>> Everything seems to move around, and while I'm sure that you have
>> something in mind, the mix of fixes+optimizations+new features is a bit
>> hard to swallow (not to mention the VDSO stuff in the middle of what is
>> supposed to be an irqchip series).
> 
> In general the non-irqchip patches preceed the irqchip patch that they enable. 
> For example, the VDSO patch you mention (presumably patch 22 "MIPS: VDSO: Drop 
> git_get_usm_range() usage") is followed immediately by the removal of that 
> function in patch 23 "irqchip: mips-gic: Remove gic_get_usm_range()".
> 
> The issue is that the MIPS GIC irqchip driver currently provides a bunch of 
> functions which have nothing to do with interrupts, and so probably ought to 
> be elsewhere. Moving that code elsewhere involves both adjusting the callers 
> of those functions & then removing them from the irqchip driver, hence the 
> non-irqchip patches followed by the related irqchip patches.
> 
> In general the only things that move are:
> 
>  - The GIC register definitions, to asm/mips-gic.h for reasons described in 
> patch 2.
> 
>  - Functions as I mentioned in the previous paragraph which have nothing to do 
> with the irqchip driver & don't need to be there once we have access to GIC 
> registers elsewhere through asm/mips-gic.h.
> 
>  - A few other bits from linux/irqchip/mips-gic.h just so we can drop that 
> header.
> 
>> Is there any chance you could rework this to have a more logical
>> ordering? Something like fixes first, new features next, and
>> optimizations in the end, organized by domains (arch stuff first, then
>> irqchip, then timer, then userspace)?
> 
> It's already almost grouped like that. We have:
> 
> - Patch 1 is a fix.
> 
> - Patches 2 through 34 are cleanup, though a couple could probably be 
> secondarily considered optimisations too.
> 
> - Patch 35 is an optimisation.
> 
> - Patches 36 through 38 could be considered optimisation or cleanup depending 
> upon the tint of your glasses.
> 
> So I'm not sure what you're asking me to do here - to group them better I 
> could perhaps move patch 35 to the end, but I'm not sure I see how that would 
> make review any easier.

This classification on its own is quite useful. In the future, please
add this kind of thing to the cover letter, it definitely helps.

> 
> I didn't group by domain like you suggest for the reason I mention before - 
> the non-irqchip patches are purely there to enable the following irqchip patch 
> so it made sense to me to group those together. If you really want I could 
> move all the non-irqchip patches to the start & all the irqchip patches to the 
> end, but again I'm not sure I see how that helps - it would just mean that 
> tightly related patches no longer follow one another.
> 
>> Because at the moment, this is a bit overwhelming...
> 
> My intent in splitting this into so many patches, and in grouping together the 
> related non-irqchip & irqchip patches, was to reduce that overwhelming-ness by 
> making each patch pretty readable by itself & perhaps taking into account only 
> a patch or two before it. I guess that didn't work though.. :)
I'll try and review the series with the above in mind. It will hopefully
make things easier.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
