Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 19:15:51 +0200 (CEST)
Received: from mail-vc0-f182.google.com ([209.85.220.182]:52140 "EHLO
        mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009160AbaIQRPsmrVAr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 19:15:48 +0200
Received: by mail-vc0-f182.google.com with SMTP id le20so1602660vcb.13
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rDVQtr6WGZcLjnDGoZY45R0Tx5v0+f1BoPvh7rHop9I=;
        b=Pn0Rw+UOsdLVbV3cSGaL9E3KqFSH/dldjGbRDFpxalJ00E5yg149SCrIek/7z7q4rg
         teEsMhHhNiyayJOHrHq88avrsQ202h1o5DZS/QLXcFYmaRkSvjshSAv1xzPBxVCuxABJ
         3nL1lfltAvjAi2WaooiyOkzM9vp8vWRqxIaghY7y3aHEhFtBWoshNynDzMc0CjHCBdcY
         HAEpwhICi7H3TC4sjA+0UbUH72NWApeJsXbUBof21tYzJQfTY6/+y9OYGuA0lUGDwqg5
         gjOT5x32wkArqcb6bvTnRWA8Du8iIALoxzLoFcitDY/0CnSCp3HQ7vZ0u9LTSWV/HzNQ
         jmhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rDVQtr6WGZcLjnDGoZY45R0Tx5v0+f1BoPvh7rHop9I=;
        b=X0ASTaVQW9cRnSp+T5mCVkel8u4i774YVuM6T7cfmw2pCcowzEqW9CtF4eXV1owIZy
         MtjG2QqfOOxBeNDcXvykmWXXEe/GxuwSGGITR6DcCBAio9DSjsy4FadAtKpceNU6G3iT
         lXzviINmbDFvc4TWOlNm0mAH7cBMMhr8NpY9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rDVQtr6WGZcLjnDGoZY45R0Tx5v0+f1BoPvh7rHop9I=;
        b=O+Y7ArjB5JU+i3VX9i4Z/a5VIdYlAm5FPNgTFxyhEv7v/76dsCvOsK7KeN3oQQHcX8
         Q3Geq16e1uNkRgRPLdeAs6hUoDS5mNoEw4pwTGCTKQWMXJKzg5jPmIRXQBSkxxJsE5ky
         MOZAf6gvNyYa1FyVI2DYYtBeo3XA9OZ+Dp3BdmI2rUKs0nTSmGuauLYc7POm48CDOWQW
         xs1l8Q0lezIqPTGcCAzKOSznkSJX93veNaviRSvycD+LBcRmheo7f/IJtMMWZe7fNPqP
         5Lcj1nbKW1KYHdI0NXxzOLG/1X3I5xiH1AGXTpluCVifyKVdanpUt9oCXeUh7Zx5PNFY
         NuTg==
X-Gm-Message-State: ALoCoQmdlvSiT/o6DFAcWuJSXFyVbPEHvRxL1UWyu4BRCX1v9MzM8kHOQvSVB8r79jbnliU7Imj7
MIME-Version: 1.0
X-Received: by 10.53.6.132 with SMTP id cu4mr1564801vdd.62.1410974142699; Wed,
 17 Sep 2014 10:15:42 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 10:15:42 -0700 (PDT)
In-Reply-To: <5419535C.9060802@imgtec.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <1410825087-5497-21-git-send-email-abrestic@chromium.org>
        <5419535C.9060802@imgtec.com>
Date:   Wed, 17 Sep 2014 10:15:42 -0700
X-Google-Sender-Auth: WN0DayVUoIyKXM2-60GE3urvhEo
Message-ID: <CAL1qeaG8YoksatuKE--GALFnNkgrVJo8ayZMnfAFqrneRC=sAg@mail.gmail.com>
Subject: Re: [PATCH 20/24] irqchip: mips-gic: Use separate edge/level irq_chips
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
X-archive-position: 42666
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

On Wed, Sep 17, 2014 at 2:24 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>
>> GIC edge-triggered interrupts must be acknowledged by clearing the edge
>> detector via a write to GIC_SH_WEDGE.  Create a separate edge-triggered
>> irq_chip with the appropriate irq_ack() callback.  This also allows us
>> to get rid of gic_irq_flags.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>   arch/mips/include/asm/gic.h    |  1 -
>>   drivers/irqchip/irq-mips-gic.c | 38
>> ++++++++++++++++++++++++--------------
>>   2 files changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
>> index 8d1e457..f245395 100644
>> --- a/arch/mips/include/asm/gic.h
>> +++ b/arch/mips/include/asm/gic.h
>> @@ -345,7 +345,6 @@
>>   extern unsigned int gic_present;
>>   extern unsigned int gic_frequency;
>>   extern unsigned long _gic_base;
>> -extern unsigned int gic_irq_flags[];
>>   extern unsigned int gic_cpu_pin;
>>     extern void gic_init(unsigned long gic_base_addr,
>> diff --git a/drivers/irqchip/irq-mips-gic.c
>> b/drivers/irqchip/irq-mips-gic.c
>> index c9ba102..6682a4e 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -24,7 +24,6 @@
>>   unsigned int gic_frequency;
>>   unsigned int gic_present;
>>   unsigned long _gic_base;
>> -unsigned int gic_irq_flags[GIC_NUM_INTRS];
>>   unsigned int gic_cpu_pin;
>>     struct gic_pcpu_mask {
>> @@ -44,6 +43,7 @@ static struct gic_pending_regs pending_regs[NR_CPUS];
>>   static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
>>   static struct irq_domain *gic_irq_domain;
>>   static int gic_shared_intrs;
>> +static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
>>     static void __gic_irq_dispatch(void);
>>   @@ -228,11 +228,7 @@ static void gic_ack_irq(struct irq_data *d)
>>   {
>>         unsigned int irq = d->hwirq;
>>   -     GIC_CLR_INTR_MASK(irq);
>> -
>> -       /* Clear edge detector */
>> -       if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
>> -               GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
>> +       GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
>>   }
>>     static int gic_set_type(struct irq_data *d, unsigned int type)
>> @@ -275,11 +271,13 @@ static int gic_set_type(struct irq_data *d, unsigned
>> int type)
>>         }
>>         if (is_edge) {
>> -               gic_irq_flags[irq] |= GIC_TRIG_EDGE;
>> -               __irq_set_handler_locked(d->irq, handle_edge_irq);
>> +               __irq_set_chip_handler_name_locked(d->irq,
>> +
>> &gic_edge_irq_controller,
>> +                                                  handle_edge_irq, NULL);
>>         } else {
>> -               gic_irq_flags[irq] &= ~GIC_TRIG_EDGE;
>> -               __irq_set_handler_locked(d->irq, handle_level_irq);
>> +               __irq_set_chip_handler_name_locked(d->irq,
>> +
>> &gic_level_irq_controller,
>> +                                                  handle_level_irq,
>> NULL);
>>         }
>>         return 0;
>> @@ -318,11 +316,23 @@ static int gic_set_affinity(struct irq_data *d,
>> const struct cpumask *cpumask,
>>   }
>>   #endif
>>   -static struct irq_chip gic_irq_controller = {
>> +static struct irq_chip gic_level_irq_controller = {
>> +       .name                   =       "MIPS GIC",
>> +       .irq_ack                =       gic_mask_irq,
>> +       .irq_mask               =       gic_mask_irq,
>> +       .irq_mask_ack           =       gic_mask_irq,
>> +       .irq_unmask             =       gic_unmask_irq,
>> +       .irq_eoi                =       gic_unmask_irq,
>> +       .irq_set_type           =       gic_set_type,
>> +#ifdef CONFIG_SMP
>> +       .irq_set_affinity       =       gic_set_affinity,
>> +#endif
>> +};
>> +
>
>
> I don't think there's a need to provide irq_ack, irq_mask_ack and irq_eoi
> here.
>
>> +static struct irq_chip gic_edge_irq_controller = {
>>         .name                   =       "MIPS GIC",
>>         .irq_ack                =       gic_ack_irq,
>>         .irq_mask               =       gic_mask_irq,
>> -       .irq_mask_ack           =       gic_ack_irq,
>>         .irq_unmask             =       gic_unmask_irq,
>>         .irq_eoi                =       gic_unmask_irq,
>>         .irq_set_type           =       gic_set_type,
>
>
> irq_eoi can be removed from here as well.

Right, I'll fix up both of these.
