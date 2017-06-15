Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 15:15:40 +0200 (CEST)
Received: from foss.arm.com ([217.140.101.70]:49512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993156AbdFONPbqjnDS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Jun 2017 15:15:31 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA75380D;
        Thu, 15 Jun 2017 06:15:22 -0700 (PDT)
Received: from [10.1.207.16] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242683F581;
        Thu, 15 Jun 2017 06:15:21 -0700 (PDT)
Subject: Re: [PATCH V5 6/9] MIPS: Loongson-3: support irq_set_affinity() in
 i8259 chip
To:     Ralf Baechle <ralf@linux-mips.org>, Huacai Chen <chenhc@lemote.com>
References: <1497492952-23877-1-git-send-email-chenhc@lemote.com>
 <1497493868-2446-1-git-send-email-chenhc@lemote.com>
 <20170615114156.GA4304@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <47616d54-283b-b661-3d10-8693b8251c56@arm.com>
Date:   Thu, 15 Jun 2017 14:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170615114156.GA4304@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58470
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

Thanks Ralf.

On 15/06/17 12:41, Ralf Baechle wrote:
> On Thu, Jun 15, 2017 at 10:31:05AM +0800, Huacai Chen wrote:
> 
>> With this patch we can set irq affinity via procfs, so as to improve
>> network performance.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/irq.h           |  3 ++
>>  arch/mips/loongson64/loongson-3/irq.c | 62 +++++++++++++++++++++++++++--------
>>  drivers/irqchip/irq-i8259.c           |  3 ++
>>  3 files changed, 55 insertions(+), 13 deletions(-)
> 
> You didn't cc the IRQCHIP maintainers:
> 
> IRQCHIP DRIVERS
> M:      Thomas Gleixner <tglx@linutronix.de>
> M:      Jason Cooper <jason@lakedaemon.net>
> M:      Marc Zyngier <marc.zyngier@arm.com>
> L:      linux-kernel@vger.kernel.org
> S:      Maintained
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> T:      git git://git.infradead.org/users/jcooper/linux.git irqchip/core
> F:      Documentation/devicetree/bindings/interrupt-controller/
> F:      drivers/irqchip/
> 
>   Ralf
> 
> 
>> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
>> index ddd1c91..47ff7c6 100644
>> --- a/arch/mips/include/asm/irq.h
>> +++ b/arch/mips/include/asm/irq.h
>> @@ -53,6 +53,7 @@ static inline int irq_canonicalize(int irq)
>>  #define irq_canonicalize(irq) (irq)	/* Sane hardware, sane code ... */
>>  #endif
>>  
>> +struct irq_data;
>>  asmlinkage void plat_irq_dispatch(void);
>>  
>>  extern void do_IRQ(unsigned int irq);
>> @@ -63,6 +64,8 @@ extern void spurious_interrupt(void);
>>  extern int allocate_irqno(void);
>>  extern void alloc_legacy_irqno(void);
>>  extern void free_irqno(unsigned int irq);
>> +extern int plat_set_irq_affinity(struct irq_data *d,
>> +				 const struct cpumask *affinity, bool force);
>>  
>>  /*
>>   * Before R2 the timer and performance counter interrupts were both fixed to
>> diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
>> index 2e6e205..e8b7a47 100644
>> --- a/arch/mips/loongson64/loongson-3/irq.c
>> +++ b/arch/mips/loongson64/loongson-3/irq.c

[...]

Not going to comment on the Loongson-specific code which doesn't make
much sense to me (the patch doesn't explain anything about what it is
actually doing), but...

>> diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
>> index 1aec12c..95d21e3 100644
>> --- a/drivers/irqchip/irq-i8259.c
>> +++ b/drivers/irqchip/irq-i8259.c
>> @@ -46,6 +46,9 @@ static struct irq_chip i8259A_chip = {
>>  	.irq_disable		= disable_8259A_irq,
>>  	.irq_unmask		= enable_8259A_irq,
>>  	.irq_mask_ack		= mask_and_ack_8259A,
>> +#ifdef CONFIG_CPU_LOONGSON3
>> +	.irq_set_affinity	= plat_set_irq_affinity,
>> +#endif
>>  };

... that's a pretty horrible way of hooking up inside a random driver.

Doesn't MIPS have some form of multi-platform kernel? If you need to add
something like this, it'd be better to set it at runtime, once you've
made sure that you're on the relevant HW (and preferably using an accessor).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
