Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 19:14:47 +0200 (CEST)
Received: from mail-vc0-f181.google.com ([209.85.220.181]:57968 "EHLO
        mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009158AbaIQROjiSiqT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 19:14:39 +0200
Received: by mail-vc0-f181.google.com with SMTP id ij19so1579367vcb.26
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/AWwzzlpRRUg9trFlHAVOxXAtBG72CkiZ7QYcsX014o=;
        b=YWGuUu5HQuyO+Sf59AkTFKAs6at03C1QOq6hoFBSgZSWE7+tGuAGV9KEAQNhn78eYw
         x+s9IavnR7c5tvmF3daQe3YdR4U2CJoMGdjXPeHVIMz8VXstSh5Mzbw6dK3tlAeZXQbz
         cGdTdkxlcPIPpXNQvXGDU+vqMkQs5DifRCyU9lHmMdytcjl5Nu4nGRMaDkFx9cZ7tIeC
         X3b/t4/FnpfZyQM6WsxYhP9uM9ueNXtFFCJlTRHPeIdbXr+EYUkgexIrtuy49Otg7bTZ
         lExG0gB6aMVeQ/k4pgR0AuO6kUikChePdrn0Uy+Yic0nkdDyx5/O0VwEdi1q2MaZ9O9Q
         1CyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/AWwzzlpRRUg9trFlHAVOxXAtBG72CkiZ7QYcsX014o=;
        b=Pueqme8LJe4tYTDvfNs7cWvU0EP+clVhMQeb5Xpgj3b+MLVpyP/Fj4Cs4TWp+OiYDd
         MC6Z5UCjOO1Ok6FYmv/mPK7qgpeWSDKXCLt6ZyB8AS4aU41YZpyIMjyDw0UMcOt8hYFO
         ZcJd8KfY4CQ5h0lZb0eenTYFrutD07VPR75SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/AWwzzlpRRUg9trFlHAVOxXAtBG72CkiZ7QYcsX014o=;
        b=i2UD/7FXA0kGlKTuSZ3bUdvmmIo5tPZIPEm4NKZPIBr2/LGX8l+GJ+k7wdk7GY2Oq8
         02SYLxfBkxqP0rZfZw06cZJPzdcqk6L5Gxov1pvad2MkhX0VyWoRIyfXQDm7oRfzh9Ss
         XdexEOn0/Ddehwqy4gWhErzbSoyKB1/KPEVWGfV8P7zFAGnEqKip+QUj0ePXDpdQaPwK
         FQwdBzCxL++7ZXjkQ4gbJxRZ4BmlYGJ3MBBWMXAa2fTykp1qw3sjW688Ih7esFg8gr+T
         O/FWva2bMUDAV+bmgaTFC5fl2+PortLiksQl1GGIeEhV3ieteg5oLRxc0tsnzzmlvk5M
         ollA==
X-Gm-Message-State: ALoCoQmoptvo8mVtxu6mb/Fjpc8Un+7/A1w39n6pTmi92ovLXkoG+IWJpWjJPpa7APrJ9F74COPw
MIME-Version: 1.0
X-Received: by 10.220.49.10 with SMTP id t10mr36002040vcf.34.1410974073622;
 Wed, 17 Sep 2014 10:14:33 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 10:14:33 -0700 (PDT)
In-Reply-To: <5419510A.3000300@imgtec.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <1410825087-5497-15-git-send-email-abrestic@chromium.org>
        <5419510A.3000300@imgtec.com>
Date:   Wed, 17 Sep 2014 10:14:33 -0700
X-Google-Sender-Auth: ZLINl_FL1jgkLH9cnC9nizDFL0o
Message-ID: <CAL1qeaHA3q+t53NAAzSuKPj26W4gYoOby8kiGhDNRHg5t8=eGw@mail.gmail.com>
Subject: Re: [PATCH 14/24] irqchip: mips-gic: Implement generic
 irq_ack/irq_eoi callbacks
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Wed, Sep 17, 2014 at 2:14 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> Hi Andrew,
>
>
> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>
>> There's no need for platforms to have their own GIC irq_ack/irq_eoi
>> callbacks.  Move them to the GIC irqchip driver.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>   arch/mips/include/asm/gic.h     |  2 --
>>   arch/mips/mti-malta/malta-int.c | 16 ----------------
>>   arch/mips/mti-sead3/sead3-int.c | 21 ---------------------
>>   drivers/irqchip/irq-mips-gic.c  | 15 ++++++++++++---
>>   4 files changed, 12 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
>> index 022d831..1bf7985 100644
>> --- a/arch/mips/include/asm/gic.h
>> +++ b/arch/mips/include/asm/gic.h
>> @@ -376,7 +376,5 @@ extern void gic_bind_eic_interrupt(int irq, int set);
>>   extern unsigned int gic_get_timer_pending(void);
>>   extern void gic_get_int_mask(unsigned long *dst, const unsigned long
>> *src);
>>   extern unsigned int gic_get_int(void);
>> -extern void gic_irq_ack(struct irq_data *d);
>> -extern void gic_finish_irq(struct irq_data *d);
>>   extern void gic_platform_init(int irqs, struct irq_chip
>> *irq_controller);
>>   #endif /* _ASM_GICREGS_H */
>> diff --git a/arch/mips/mti-malta/malta-int.c
>> b/arch/mips/mti-malta/malta-int.c
>> index 5c31208..b60adfd 100644
>> --- a/arch/mips/mti-malta/malta-int.c
>> +++ b/arch/mips/mti-malta/malta-int.c
>> @@ -715,22 +715,6 @@ int malta_be_handler(struct pt_regs *regs, int
>> is_fixup)
>>         return retval;
>>   }
>>   -void gic_irq_ack(struct irq_data *d)
>> -{
>> -       int irq = (d->irq - gic_irq_base);
>> -
>> -       GIC_CLR_INTR_MASK(irq);
>> -
>> -       if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
>> -               GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
>> -}
>> -
>> -void gic_finish_irq(struct irq_data *d)
>> -{
>> -       /* Enable interrupts. */
>> -       GIC_SET_INTR_MASK(d->irq - gic_irq_base);
>> -}
>> -
>>   void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
>>   {
>>         int i;
>> diff --git a/arch/mips/mti-sead3/sead3-int.c
>> b/arch/mips/mti-sead3/sead3-int.c
>> index 9d5b5bd..03f9865 100644
>> --- a/arch/mips/mti-sead3/sead3-int.c
>> +++ b/arch/mips/mti-sead3/sead3-int.c
>> @@ -85,27 +85,6 @@ void __init arch_init_irq(void)
>>                         ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
>>   }
>>   -void gic_irq_ack(struct irq_data *d)
>> -{
>> -       GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
>> -}
>> -
>> -void gic_finish_irq(struct irq_data *d)
>> -{
>> -       unsigned int irq = (d->irq - gic_irq_base);
>> -       unsigned int i, irq_source;
>> -
>> -       /* Clear edge detectors. */
>> -       for (i = 0; i < gic_shared_intr_map[irq].num_shared_intr; i++) {
>> -               irq_source = gic_shared_intr_map[irq].intr_list[i];
>> -               if (gic_irq_flags[irq_source] & GIC_TRIG_EDGE)
>> -                       GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE),
>> irq_source);
>> -       }
>> -
>> -       /* Enable interrupts. */
>> -       GIC_SET_INTR_MASK(irq);
>> -}
>> -
>>   void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
>>   {
>>         int i;
>> diff --git a/drivers/irqchip/irq-mips-gic.c
>> b/drivers/irqchip/irq-mips-gic.c
>> index 9e9d8b9..0dc2972 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -237,6 +237,15 @@ static void gic_unmask_irq(struct irq_data *d)
>>         GIC_SET_INTR_MASK(d->irq - gic_irq_base);
>>   }
>>   +static void gic_ack_irq(struct irq_data *d)
>> +{
>> +       GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
>> +
>> +       /* Clear edge detector */
>> +       if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
>> +               GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq -
>> gic_irq_base);
>> +}
>> +
>>   #ifdef CONFIG_SMP
>>   static DEFINE_SPINLOCK(gic_lock);
>>   @@ -272,11 +281,11 @@ static int gic_set_affinity(struct irq_data *d,
>> const struct cpumask *cpumask,
>>     static struct irq_chip gic_irq_controller = {
>>         .name                   =       "MIPS GIC",
>> -       .irq_ack                =       gic_irq_ack,
>> +       .irq_ack                =       gic_ack_irq,
>>         .irq_mask               =       gic_mask_irq,
>> -       .irq_mask_ack           =       gic_mask_irq,
>> +       .irq_mask_ack           =       gic_ack_irq,
>>         .irq_unmask             =       gic_unmask_irq,
>> -       .irq_eoi                =       gic_finish_irq,
>> +       .irq_eoi                =       gic_unmask_irq,
>>   #ifdef CONFIG_SMP
>>         .irq_set_affinity       =       gic_set_affinity,
>>   #endif
>
>
> I'm no expert in irq_chip api but I think providing irq_mask_ack and irq_eoi
> makes no sense to GIC and can be removed.

Ok, yeah, I think both irq_mask_ack and irq_eoi can go away here.
