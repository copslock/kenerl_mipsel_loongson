Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:49:47 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994934AbdHRRtgLdmgh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:49:36 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BC342B;
        Fri, 18 Aug 2017 10:49:29 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A376C3F483;
        Fri, 18 Aug 2017 10:49:28 -0700 (PDT)
Subject: Re: [PATCH 00/38] irqchip: mips-gic: Cleanup & optimisation
To:     Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Jason Cooper <jason@lakedaemon.net>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <b01bbb35-938c-360a-4025-53dbec24c411@arm.com>
 <3865163.6ibQ6d6yKY@np-p-burton>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b6b59dc3-0390-1eb8-f30e-c753b462972e@arm.com>
Date:   Fri, 18 Aug 2017 18:49:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <3865163.6ibQ6d6yKY@np-p-burton>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59687
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

On 18/08/17 18:44, Paul Burton wrote:
> Hi Marc,
> 
> On Friday, 18 August 2017 10:28:01 PDT Marc Zyngier wrote:
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
>> I went through the whole series, and didn't spot anything bad (the
>> couple of nits I raised can either be fixed at a later time or as a
>> fixup on top of what you have).
> 
> Thanks :) I appreciate your review. So shall I take that as you'd prefer that 
> I submit separate fixup patches rather than submit a v2?

Just post the fixups on top. Nobody wants a new 38 series in their
Inbox! ;-)

>> Given that this has a number of dependencies (your multicluster series),
>> how do you want to get this merged?
>>
>> Thanks,
>>
>> 	M.
> 
> Ralf mentioned in a meeting yesterday that he was going to speak to Thomas 
> about that, and suggested that perhaps it'd be easiest for him to take it 
> through the MIPS tree. I'm happy either way.
Works for me. In that case, please stick my:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

on these patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
