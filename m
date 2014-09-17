Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 19:40:11 +0200 (CEST)
Received: from mail-vc0-f179.google.com ([209.85.220.179]:47100 "EHLO
        mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009150AbaIQRkJO0paI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 19:40:09 +0200
Received: by mail-vc0-f179.google.com with SMTP id id10so748314vcb.10
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jgQqzFvNVjjYrmmFUVTFWm7vFv4KxvtBIFM/x/PU4UQ=;
        b=AWAkp/wJzj36I1UTyu0+izh16bNV/7EmHGT/LmKneaiJEWdzautjOELSPwbgM1XRs3
         7Ws7PrKSODrixTFgI7qD5+GdEAXRS6mN6m5G4oVj3uSZg4SFgxEWpF8mahDv/kZvgVGx
         BBvxDzJ6ql4Pz9ydDVnWsOJHUgIFR2o0MQTEykhz18R2jX36IhEOZ0OT7JzJM2rxHAMS
         Q+lZNCPis5l4hyUvfQE0XuS40Cy509wCVkorlxfdNu3ldZDJsu9ctFK/V27iLh2JPjWs
         FVpuok4wmJQGjdDu9rKlQsJf5E3VTR8NTvUH8Xb3RnexTPQHFZ1fo0tlESl6fYggGqVG
         2Eew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jgQqzFvNVjjYrmmFUVTFWm7vFv4KxvtBIFM/x/PU4UQ=;
        b=Yni9U/uEU3yp4BIvDT1b/qAmwp2WBcSW2RJsjtPZKYY5tNKtkNdXut5NnEFrrmchPQ
         lk6TLLTAKrMNLrX/748iKvKm7NMYQ/sytorfE6LZRpVud2cJ7RFffq3sEruaYw5I5S+E
         n8DkqyreWdVC5pg3j8mIKE0aF9BODKhLJn63s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jgQqzFvNVjjYrmmFUVTFWm7vFv4KxvtBIFM/x/PU4UQ=;
        b=dj5eusvb7JJbjYw3By+PUZioz+mGGa/Aufyvom76Wtr0xS+2tf3hdLDHyzf0VfK/Rm
         CH4R+YZ0szPfPqSXaDjAKem8WDy0wYD3vTG3JOkBdveXBaPRmPl5HfBjm6hHeeEgYtSe
         QPA9yWxQIe8tK2Ak+rUSAKUI5qq54/+HgbxuyP/EopkGSa5yvXfNbyroNKnM5HX3Hj28
         9kOqZdPZkgdI1uti+Xuu1Xoht7HSOSeMVh7AglBdCPCTOMUc0l6GXbNfmCG6sa5MybA/
         MMRtKsxCBtZJ9wqDorNCFRioEqp55bdYXkG7mv2L8mnY4qSAEsfkwPmsF+5a/OKu1QD8
         Z9hQ==
X-Gm-Message-State: ALoCoQkqjrFKp3lEZssq66YEmWSe3uJwWPwomVtmVZsUYVJma/hC+hR9rCKIPLE3ZnjNxc4NNTqs
MIME-Version: 1.0
X-Received: by 10.52.128.104 with SMTP id nn8mr1168341vdb.50.1410975603045;
 Wed, 17 Sep 2014 10:40:03 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 10:40:02 -0700 (PDT)
In-Reply-To: <54195975.1010209@imgtec.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <1410825087-5497-22-git-send-email-abrestic@chromium.org>
        <54195975.1010209@imgtec.com>
Date:   Wed, 17 Sep 2014 10:40:02 -0700
X-Google-Sender-Auth: 23Y8LOLMb5TtCUbOUG-4AZ-IQ8c
Message-ID: <CAL1qeaFt5ZBauD38WMPB7WLkOqkTgtfO-gLKo3of7C_V-53eLA@mail.gmail.com>
Subject: Re: [PATCH 21/24] irqchip: mips-gic: Support local interrupts
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
X-archive-position: 42667
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

On Wed, Sep 17, 2014 at 2:50 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>
>> The MIPS GIC supports 7 local interrupts, 2 of which are the GIC
>> local watchdog and count/compare timer.  The remainder are CPU
>> interrupts which may optionally be re-routed through the GIC.
>> GIC hardware IRQs 0-6 are now used for local interrupts while
>> hardware IRQs 7+ are used for external (shared) interrupts.
>>
>> Note that the 5 CPU interrupts may not be re-routable through
>> the GIC.  In that case mapping will fail and the vectors reported
>> in C0_IntCtl should be used instead.  gic_get_c0_compare_int() and
>> gic_get_c0_perfcount_int() will return the correct IRQ number to
>> use for the C0 timer and perfcounter interrupts based on the
>> routability of those interrupts through the GIC.
>>
>> Malta, SEAD-3, and the GIC clockevent driver have been updated
>> to use local interrupts and the R4K clockevent driver has been
>> updated to poll for C0 timer interrupts through the GIC when
>> the GIC is present.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>

>> diff --git a/arch/mips/include/asm/mips-boards/maltaint.h
>> b/arch/mips/include/asm/mips-boards/maltaint.h
>> index bdd6f39..38b06a0 100644
>> --- a/arch/mips/include/asm/mips-boards/maltaint.h
>> +++ b/arch/mips/include/asm/mips-boards/maltaint.h
>> @@ -10,6 +10,8 @@
>>   #ifndef _MIPS_MALTAINT_H
>>   #define _MIPS_MALTAINT_H
>>   +#include <asm/gic.h>
>> +
>
>
> nit: I think gic.h should be split to driver/irqchip/irq-mips-gic.h for
> private definitions and include/linux/irqchip/irq-mips-gic.h for
> exported/public definitions.

Yup, I was planning on doing this in the next series :).  Malta and
the clockevent/clocksource driver need to get cleaned up first though,
so that they don't have to use the private register definitions.

>> diff --git a/drivers/irqchip/irq-mips-gic.c
>> b/drivers/irqchip/irq-mips-gic.c
>> index 6682a4e..3abe310 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c

>> @@ -95,12 +96,39 @@ cycle_t gic_read_compare(void)
>>   }
>>   #endif
>>   +static bool gic_local_irq_is_routable(int intr)
>> +{
>> +       u32 vpe_ctl;
>> +
>> +       /* All local interrupts are routable in EIC mode. */
>> +       if (cpu_has_veic)
>> +               return true;
>> +
>> +       GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_CTL), vpe_ctl);
>> +       switch (intr) {
>> +       case GIC_LOCAL_INT_TIMER:
>> +               return vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK;
>> +       case GIC_LOCAL_INT_PERFCTR:
>> +               return vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK;
>> +       case GIC_LOCAL_INT_FDC:
>> +               return vpe_ctl & GIC_VPE_CTL_FDC_RTBL_MSK;
>> +       case GIC_LOCAL_INT_SWINT0:
>> +       case GIC_LOCAL_INT_SWINT1:
>> +               /*
>> +                * SWINT{0,1} are not routable in non-EIC mode, regardless
>> +                * of the setting of SWINT_ROUTABLE.
>> +                */
>> +               return false;
>
>
> Hmm AFAIK they are routable. Actually from hard reset they're automatically
> routed to vpe0 pin 0 which caught me a number of times when trying to use
> software interrupt on hardware that has GIC. When setting software interrupt
> I was seeing pin 0 going high too and thought it's a hardware bug for a
> while.

Interesting, the interAptiv User's Manual I have, in section 9.4.7.1,
says: "Note that Software Interrupts from the VPE are routed
internally by the CPU in vectored interrupt mode, and are only routed
through the GIC when the GIC is in EIC mode, regardless of the
GIC_VPEi_CTL register."  IIRC, there's a similar statement in the
proAptiv manual as well.  I didn't play with the SWINT bits myself, so
I wouldn't be surprised if that's wrong :).

> I think all local interrupts should be masked at GIC initialisation except
> for timer interrupt. I was preparing a set of patches for GIC but you beat
> me into it :)

If SWINT gets routed both through the GIC and directly to the CPU,
then that's probably the best thing to do.  I suspect we'll also want
to leave the performance counter interrupt unmasked too, since,
unfortunately, both the HW perf event driver and oprofile do not use
the percpu IRQ API.

>> @@ -341,12 +342,54 @@ static struct irq_chip gic_edge_irq_controller = {
>>   #endif
>>   };
>>   +static unsigned int gic_get_local_int(void)
>> +{
>> +       unsigned long pending, masked;
>> +
>> +       GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_PEND), pending);
>> +       GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_MASK), masked);
>> +
>> +       bitmap_and(&pending, &pending, &masked, GIC_NUM_LOCAL_INTRS);
>> +
>> +       return find_first_bit(&pending, GIC_NUM_LOCAL_INTRS);
>> +}
>> +
>> +static void gic_mask_local_irq(struct irq_data *d)
>> +{
>> +       int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
>> +
>> +       GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK), 1 << intr);
>> +}
>> +
>> +static void gic_unmask_local_irq(struct irq_data *d)
>> +{
>> +       int intr = GIC_HWIRQ_TO_LOCAL(d->hwirq);
>> +
>> +       GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK), 1 << intr);
>> +}
>> +
>> +static struct irq_chip gic_local_irq_controller = {
>> +       .name                   =       "MIPS GIC Local",
>> +       .irq_ack                =       gic_mask_local_irq,
>> +       .irq_mask               =       gic_mask_local_irq,
>> +       .irq_mask_ack           =       gic_mask_local_irq,
>> +       .irq_unmask             =       gic_unmask_local_irq,
>> +       .irq_eoi                =       gic_unmask_local_irq,
>> +};
>> +
>
>
> again I don't think irq_ack, irq_mask_ack and irq_eoi are needed.

Yup, will do.
