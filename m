Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 02:35:20 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:34720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991126AbdJaBfN4EMTt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Oct 2017 02:35:13 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C885A80D;
        Mon, 30 Oct 2017 18:35:06 -0700 (PDT)
Received: from zomby-woof (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 011EC3F3E1;
        Mon, 30 Oct 2017 18:35:04 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] irqchip: mips-gic: Use irq_cpu_online to (un)mask all-VP(E) IRQs
In-Reply-To: <20171030163616.tsti7thormxlnxuo@pburton-laptop> (Paul Burton's
        message of "Mon, 30 Oct 2017 09:36:16 -0700")
Organization: ARM Ltd
References: <20171025233730.22225-1-paul.burton@mips.com>
        <20171025233730.22225-3-paul.burton@mips.com> <86mv495alz.fsf@arm.com>
        <20171030163616.tsti7thormxlnxuo@pburton-laptop>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Tue, 31 Oct 2017 01:35:02 +0000
Message-ID: <867evc5cc9.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60596
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

On Mon, Oct 30 2017 at  9:36:16 am GMT, Paul Burton <paul.burton@mips.com> wrote:
> Hi Marc,
>
> On Mon, Oct 30, 2017 at 08:00:08AM +0000, Marc Zyngier wrote:
>> >  static int __init gic_of_init(struct device_node *node,
>> >  			      struct device_node *parent)
>> > @@ -768,6 +806,8 @@ static int __init gic_of_init(struct device_node *node,
>> >  		}
>> >  	}
>> >  
>> > -	return 0;
>> > +	return cpuhp_setup_state(CPUHP_AP_IRQ_GIC_STARTING,
>> > +				 "irqchip/mips/gic:starting",
>> > +				 gic_cpu_startup, NULL);
>> 
>> I'm wondering about this. CPUHP_AP_IRQ_GIC_STARTING is a symbol that is
>> used on ARM platforms. You're very welcome to use it (as long as nobody
>> builds a system with both an ARM GIC and a MIPS GIC...), but I'm a bit
>> worried that we could end-up breaking things if one of us decides to
>> reorder it in enum cpuhp_state.
>> 
>> The safest option would be for you to add your own state value, which
>> would allow the two architecture to evolve independently.
>
> I had figured that if something like that ever happens it'd be easy to split
> into 2 states at that point, but sure - I'm happy to add a MIPS-specific state
> now to avoid anyone needing to worry about it.

That would be my preferred option.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
