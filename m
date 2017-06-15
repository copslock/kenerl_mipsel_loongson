Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2017 17:39:43 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:33039
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994768AbdFOPjaK4cNx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2017 17:39:30 +0200
Received: by mail-it0-x244.google.com with SMTP id l6so2286205iti.0;
        Thu, 15 Jun 2017 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JNrEgg2cxvgprkYoQnsSepUZS+rgCTz7JGF9uQ+/kIM=;
        b=Bfnv00dofhLOF7X9CNaIOddsOSu1ba9njuZRqqJ+98n723Zp6OCC0c2z3P/+oqqiyA
         rVWW+N36V2oxaDkL8uw7EZflWZgcOMmcSFGyHbTkcW4DcqxMyHDxHbEmFbNFije38uMp
         MYQP5hJxNSkrS/qbbum9QrTfOsNTgdlRb/R4dqHFvCUm+krw8VdtJqXgCV9k6HgTQ3L3
         v1bM0grIxxDR7lHhtHCj3hlvjX465H+1Yu47BYnuw47AJTChOC7fXmvFL2NTuZ6nKaPY
         VGdwj3KkdWMq1lIUFpXpsX169I5xHOkx0kQOF8iClVSZnALsEubOPmsZ72GF9O7k2jyC
         dLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JNrEgg2cxvgprkYoQnsSepUZS+rgCTz7JGF9uQ+/kIM=;
        b=N7AU3yN8NOO4TxW/UiQf+lsvODLm/COxICE4wNnftBcwCynP0LzUoTgqxC6oCaWUNu
         YnLaOoUtwR5rcXo+tCovGbUSFIRVOdub9HG4I23jlyvbZr57cVRI9dYN/NBB4dxiIQwQ
         qkGRBmSUsqbPa22vOT88JPGenhW6zN8meWnsY3EqgahzMYBfOM6mUMgUQEgLJ4hTHVxW
         lN2qe+sg26V4imf7KXaBySqV79uDAtI3fngJhylY7UFcFEZ5I/ijfjLdwiUTgFI9Si0K
         wizr0LSvtu5D7IqhQ9/ikgcSoAuAjPzKshnTJJtZ1Imd8BhzNigLhzbfl9eMGIFrIQ5I
         xXBg==
X-Gm-Message-State: AKS2vOySgQza8C9jwJk9cMX2RuiZNZX9VTEghWdadLjzPEHBua4rBycj
        amFKEAIJhIpjR6bLVwMtstpH+Fz9aA==
X-Received: by 10.36.87.147 with SMTP id u141mr5917172ita.72.1497541164249;
 Thu, 15 Jun 2017 08:39:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Thu, 15 Jun 2017 08:39:23 -0700 (PDT)
In-Reply-To: <47616d54-283b-b661-3d10-8693b8251c56@arm.com>
References: <1497492952-23877-1-git-send-email-chenhc@lemote.com>
 <1497493868-2446-1-git-send-email-chenhc@lemote.com> <20170615114156.GA4304@linux-mips.org>
 <47616d54-283b-b661-3d10-8693b8251c56@arm.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Thu, 15 Jun 2017 23:39:23 +0800
X-Google-Sender-Auth: FhR_X6ESzZMmqVfZnurcqVa8B70
Message-ID: <CAAhV-H4DH+UScmye6s5CYPWmofDxhvyzRvO6eASLLaE6jAgqRQ@mail.gmail.com>
Subject: Re: [PATCH V5 6/9] MIPS: Loongson-3: support irq_set_affinity() in
 i8259 chip
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

OK, I'll update my patch and set it at runtime.

Huacai

On Thu, Jun 15, 2017 at 9:15 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Thanks Ralf.
>
> On 15/06/17 12:41, Ralf Baechle wrote:
>> On Thu, Jun 15, 2017 at 10:31:05AM +0800, Huacai Chen wrote:
>>
>>> With this patch we can set irq affinity via procfs, so as to improve
>>> network performance.
>>>
>>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>>> ---
>>>  arch/mips/include/asm/irq.h           |  3 ++
>>>  arch/mips/loongson64/loongson-3/irq.c | 62 +++++++++++++++++++++++++++--------
>>>  drivers/irqchip/irq-i8259.c           |  3 ++
>>>  3 files changed, 55 insertions(+), 13 deletions(-)
>>
>> You didn't cc the IRQCHIP maintainers:
>>
>> IRQCHIP DRIVERS
>> M:      Thomas Gleixner <tglx@linutronix.de>
>> M:      Jason Cooper <jason@lakedaemon.net>
>> M:      Marc Zyngier <marc.zyngier@arm.com>
>> L:      linux-kernel@vger.kernel.org
>> S:      Maintained
>> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
>> T:      git git://git.infradead.org/users/jcooper/linux.git irqchip/core
>> F:      Documentation/devicetree/bindings/interrupt-controller/
>> F:      drivers/irqchip/
>>
>>   Ralf
>>
>>
>>> diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
>>> index ddd1c91..47ff7c6 100644
>>> --- a/arch/mips/include/asm/irq.h
>>> +++ b/arch/mips/include/asm/irq.h
>>> @@ -53,6 +53,7 @@ static inline int irq_canonicalize(int irq)
>>>  #define irq_canonicalize(irq) (irq) /* Sane hardware, sane code ... */
>>>  #endif
>>>
>>> +struct irq_data;
>>>  asmlinkage void plat_irq_dispatch(void);
>>>
>>>  extern void do_IRQ(unsigned int irq);
>>> @@ -63,6 +64,8 @@ extern void spurious_interrupt(void);
>>>  extern int allocate_irqno(void);
>>>  extern void alloc_legacy_irqno(void);
>>>  extern void free_irqno(unsigned int irq);
>>> +extern int plat_set_irq_affinity(struct irq_data *d,
>>> +                             const struct cpumask *affinity, bool force);
>>>
>>>  /*
>>>   * Before R2 the timer and performance counter interrupts were both fixed to
>>> diff --git a/arch/mips/loongson64/loongson-3/irq.c b/arch/mips/loongson64/loongson-3/irq.c
>>> index 2e6e205..e8b7a47 100644
>>> --- a/arch/mips/loongson64/loongson-3/irq.c
>>> +++ b/arch/mips/loongson64/loongson-3/irq.c
>
> [...]
>
> Not going to comment on the Loongson-specific code which doesn't make
> much sense to me (the patch doesn't explain anything about what it is
> actually doing), but...
>
>>> diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
>>> index 1aec12c..95d21e3 100644
>>> --- a/drivers/irqchip/irq-i8259.c
>>> +++ b/drivers/irqchip/irq-i8259.c
>>> @@ -46,6 +46,9 @@ static struct irq_chip i8259A_chip = {
>>>      .irq_disable            = disable_8259A_irq,
>>>      .irq_unmask             = enable_8259A_irq,
>>>      .irq_mask_ack           = mask_and_ack_8259A,
>>> +#ifdef CONFIG_CPU_LOONGSON3
>>> +    .irq_set_affinity       = plat_set_irq_affinity,
>>> +#endif
>>>  };
>
> ... that's a pretty horrible way of hooking up inside a random driver.
>
> Doesn't MIPS have some form of multi-platform kernel? If you need to add
> something like this, it'd be better to set it at runtime, once you've
> made sure that you're on the relevant HW (and preferably using an accessor).
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>
