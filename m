Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 23:09:09 +0200 (CEST)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:43908 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009175AbaIQVJHEwL4l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 23:09:07 +0200
Received: by mail-vc0-f180.google.com with SMTP id hq11so1886640vcb.11
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n29mB824RRBqWHaZtC61AAEWi/XbTLFrEdSSXc2HQA8=;
        b=Rov3ZZkgpCrzpBuzVo3Ph5synPsvFtepTScflvlmXEvubnQjzjCyNKJ/Fm7WAse+XF
         NwVVpynaLgQ2k38ffQ6PhydimcNj1dNG8m8lTfxYd9tpavqWQlUTX4yQO3hV/8/Mv1fi
         PylgwezZKg1EnFw/nBUEr7x/ScOlF1i1ano6tdKSG0TKAkVZGEjhFMg3duULOhDrzjE2
         Cbrd/Af5at364ViAMSFkyO5cN7CZcVQgPeuqMtgDTcIAWQQCQzIljehx+XU48+LbRvYX
         95X+Zg7nIOI6YM546H9Y/seaPJikNfrciKu7Wvb82ijHVaafcnHlIK5PPiOwDGVQthEh
         JNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n29mB824RRBqWHaZtC61AAEWi/XbTLFrEdSSXc2HQA8=;
        b=lZPb5wwLWGYQiZqkgk3E7402MHkJQIeBIFCGto+XN+fBnDJ8buT1sbzmBv6TNVvV03
         Ea6yFYYVjZap7F7O2F9i3BmVTcM9hSGT4wJ3PLd22FZpqlkoF92V/xHjx+FwG+TZ4kxb
         HKvNiSIqjA/dqXQQOoNSqjy+MauIWC74JSVIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n29mB824RRBqWHaZtC61AAEWi/XbTLFrEdSSXc2HQA8=;
        b=SPPIFGSwmpn798DunEc5zqL0Noe5/eWnlcbIu+3DWXGRzkCeNlCkatC7RZe55ACs6k
         aiHqygTM2z50Lq5YGvMcjrRXmlBVc6jT5OKCcIJUjN2mJNH38mvjZ854x+arwOlSdf92
         EwK9Fg+PHXiyGqHtTYbED3eqTFX5hdhzXtskVVWABKuC4C9yAgZvdJBkax9jik1N2Fkd
         9wh1H1JBlBMphWMYmwOgInSXP/cicTjfesPG87Hcv2Sh9kYAwAr5dvw3CiNBLS1pFPsn
         sedVTxXJH1v7jPGACII4yLrsuD3s4mJWy2kKjxMJLZzzn09TOPitKY/tzeCbnadwXerz
         F6+A==
X-Gm-Message-State: ALoCoQnveC1MBNlPMQgcY5gR56x+noj+YA9nxEgUCGGB9iYSWsKR9C982+LVvSpWMPilwD7wLgMk
MIME-Version: 1.0
X-Received: by 10.220.161.136 with SMTP id r8mr5922437vcx.21.1410988140975;
 Wed, 17 Sep 2014 14:09:00 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 14:09:00 -0700 (PDT)
In-Reply-To: <CAL1qeaFt5ZBauD38WMPB7WLkOqkTgtfO-gLKo3of7C_V-53eLA@mail.gmail.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <1410825087-5497-22-git-send-email-abrestic@chromium.org>
        <54195975.1010209@imgtec.com>
        <CAL1qeaFt5ZBauD38WMPB7WLkOqkTgtfO-gLKo3of7C_V-53eLA@mail.gmail.com>
Date:   Wed, 17 Sep 2014 14:09:00 -0700
X-Google-Sender-Auth: RmMubSXw5zTdEhF-IH7GR6meBoI
Message-ID: <CAL1qeaEikmx3bsqNz1bvkhmyPU=GNuSGyMRQvcgxHYb2yj-aog@mail.gmail.com>
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
X-archive-position: 42669
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

On Wed, Sep 17, 2014 at 10:40 AM, Andrew Bresticker
<abrestic@chromium.org> wrote:
> On Wed, Sep 17, 2014 at 2:50 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
>> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>>
>>> The MIPS GIC supports 7 local interrupts, 2 of which are the GIC
>>> local watchdog and count/compare timer.  The remainder are CPU
>>> interrupts which may optionally be re-routed through the GIC.
>>> GIC hardware IRQs 0-6 are now used for local interrupts while
>>> hardware IRQs 7+ are used for external (shared) interrupts.
>>>
>>> Note that the 5 CPU interrupts may not be re-routable through
>>> the GIC.  In that case mapping will fail and the vectors reported
>>> in C0_IntCtl should be used instead.  gic_get_c0_compare_int() and
>>> gic_get_c0_perfcount_int() will return the correct IRQ number to
>>> use for the C0 timer and perfcounter interrupts based on the
>>> routability of those interrupts through the GIC.
>>>
>>> Malta, SEAD-3, and the GIC clockevent driver have been updated
>>> to use local interrupts and the R4K clockevent driver has been
>>> updated to poll for C0 timer interrupts through the GIC when
>>> the GIC is present.
>>>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>
>>> diff --git a/arch/mips/include/asm/mips-boards/maltaint.h
>>> b/arch/mips/include/asm/mips-boards/maltaint.h
>>> index bdd6f39..38b06a0 100644
>>> --- a/arch/mips/include/asm/mips-boards/maltaint.h
>>> +++ b/arch/mips/include/asm/mips-boards/maltaint.h
>>> @@ -10,6 +10,8 @@
>>>   #ifndef _MIPS_MALTAINT_H
>>>   #define _MIPS_MALTAINT_H
>>>   +#include <asm/gic.h>
>>> +
>>
>>
>> nit: I think gic.h should be split to driver/irqchip/irq-mips-gic.h for
>> private definitions and include/linux/irqchip/irq-mips-gic.h for
>> exported/public definitions.
>
> Yup, I was planning on doing this in the next series :).  Malta and
> the clockevent/clocksource driver need to get cleaned up first though,
> so that they don't have to use the private register definitions.
>
>>> diff --git a/drivers/irqchip/irq-mips-gic.c
>>> b/drivers/irqchip/irq-mips-gic.c
>>> index 6682a4e..3abe310 100644
>>> --- a/drivers/irqchip/irq-mips-gic.c
>>> +++ b/drivers/irqchip/irq-mips-gic.c
>
>>> @@ -95,12 +96,39 @@ cycle_t gic_read_compare(void)
>>>   }
>>>   #endif
>>>   +static bool gic_local_irq_is_routable(int intr)
>>> +{
>>> +       u32 vpe_ctl;
>>> +
>>> +       /* All local interrupts are routable in EIC mode. */
>>> +       if (cpu_has_veic)
>>> +               return true;
>>> +
>>> +       GICREAD(GIC_REG(VPE_LOCAL, GIC_VPE_CTL), vpe_ctl);
>>> +       switch (intr) {
>>> +       case GIC_LOCAL_INT_TIMER:
>>> +               return vpe_ctl & GIC_VPE_CTL_TIMER_RTBL_MSK;
>>> +       case GIC_LOCAL_INT_PERFCTR:
>>> +               return vpe_ctl & GIC_VPE_CTL_PERFCNT_RTBL_MSK;
>>> +       case GIC_LOCAL_INT_FDC:
>>> +               return vpe_ctl & GIC_VPE_CTL_FDC_RTBL_MSK;
>>> +       case GIC_LOCAL_INT_SWINT0:
>>> +       case GIC_LOCAL_INT_SWINT1:
>>> +               /*
>>> +                * SWINT{0,1} are not routable in non-EIC mode, regardless
>>> +                * of the setting of SWINT_ROUTABLE.
>>> +                */
>>> +               return false;
>>
>>
>> Hmm AFAIK they are routable. Actually from hard reset they're automatically
>> routed to vpe0 pin 0 which caught me a number of times when trying to use
>> software interrupt on hardware that has GIC. When setting software interrupt
>> I was seeing pin 0 going high too and thought it's a hardware bug for a
>> while.
>
> Interesting, the interAptiv User's Manual I have, in section 9.4.7.1,
> says: "Note that Software Interrupts from the VPE are routed
> internally by the CPU in vectored interrupt mode, and are only routed
> through the GIC when the GIC is in EIC mode, regardless of the
> GIC_VPEi_CTL register."  IIRC, there's a similar statement in the
> proAptiv manual as well.  I didn't play with the SWINT bits myself, so
> I wouldn't be surprised if that's wrong :).
>
>> I think all local interrupts should be masked at GIC initialisation except
>> for timer interrupt. I was preparing a set of patches for GIC but you beat
>> me into it :)
>
> If SWINT gets routed both through the GIC and directly to the CPU,
> then that's probably the best thing to do.  I suspect we'll also want
> to leave the performance counter interrupt unmasked too, since,
> unfortunately, both the HW perf event driver and oprofile do not use
> the percpu IRQ API.

Instead of leaving those two unmasked, perhaps the better thing to do
is to have a separate irq_chip which masks/unmasks on all VPEs.
