Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 23:50:14 +0200 (CEST)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:60121 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025895AbaIEVuNMQULv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 23:50:13 +0200
Received: by mail-vc0-f180.google.com with SMTP id lf12so13001410vcb.39
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AY37H12qzMSEqEkJku/c7H5TKcjyR9DGUxV3iwNhvRc=;
        b=Jk3Rc65xOWBcdk4Zxjo6yPJBcPmpBlUc8/ovfS80orWUYkQsNsb0lCC9bXV//llFqo
         p1OcAhURt6rekaYMqwDGHKCBUBBoeajaHJz1Xfx/TvBWvXljxlPUbiCf1T40raKKwkY2
         9D/+Zp19YdPc/d66wSgGMGY1Jjff/OX6ckEiZYNJri+XnX9hh2C12QLniHbMzYttkl5Z
         64ZDe3KpBc+sfRxXI4DFKMy7toSuWPlg9oNtMnF0CR4GgXrMmU2rMYTdcx9n0KqhftYr
         CSuqEGiMSKq6dnIhTxg7In7p+zwBjSlBR4JXKZ5yQTa0GDErG6psZoeZsRv2zMWwm3ag
         I80A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AY37H12qzMSEqEkJku/c7H5TKcjyR9DGUxV3iwNhvRc=;
        b=g1pPwuhSMx/GB9X6V2BSdDqRrVFItjZTEM973UizamSFgCKm1bpYTExnEOIn1k2ODc
         l/p54E6etyW4WfZWHPlhnB1Vre0hvi4lcbx6uXtwN/oHO4wJT+0MW0hpOUdxmP6LI8tM
         iKJ7GdRLf1pnAfiZjqlqIGOHOdyXJdIRrikbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AY37H12qzMSEqEkJku/c7H5TKcjyR9DGUxV3iwNhvRc=;
        b=gtQIeTQoF/v7XMCuM3HtTA4wgsud6omhLKmSjxpbpOqVjwsG+hw0toOzTp2iPf0VbW
         C6GVmojdbOcJxLnqdTZtQvn8uDtvr4wwjWtROqpc/bhm4EeX3+7aTzYzbC5B/cW1m/0S
         QelQZBckR29750BJREMLmG03fsEJjznA4qJ8Nn7NynFYGXiUifwaovXQuUVztzQKn7Om
         EfdCq8lCDp7kYzjnpYGnG5icr8sbZ/tMUgJ2vSkVpMTNxqRslb+p6nfWCCqBpCseQamz
         1w55X1Ax+9CaMShebOQ89/7cbDsAu0GMC+Fuuhvfg+WqBT3UmRrsom5r18Zn+nHjqsMC
         Gx2w==
X-Gm-Message-State: ALoCoQnZhCvj5M0lmtxr97MMmv+LfACBd/XrjAfYZx24Kd3IVfnXN/7I+CF2aoqvmtrs1iVgSJhr
MIME-Version: 1.0
X-Received: by 10.52.146.17 with SMTP id sy17mr10514882vdb.29.1409953802089;
 Fri, 05 Sep 2014 14:50:02 -0700 (PDT)
Received: by 10.52.51.194 with HTTP; Fri, 5 Sep 2014 14:50:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1409052056400.5472@nanos>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
        <1409938218-9026-15-git-send-email-abrestic@chromium.org>
        <alpine.DEB.2.10.1409052056400.5472@nanos>
Date:   Fri, 5 Sep 2014 14:50:02 -0700
X-Google-Sender-Auth: cLF84FfuQD-FvMMBU9HsOpviWVg
Message-ID: <CAL1qeaH5ZQA8Y=n3uVSy9e+vEweCi_RT2s-ZGRfyJTAcbguyoA@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] irqchip: mips-gic: Support local interrupts
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42454
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

On Fri, Sep 5, 2014 at 12:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 5 Sep 2014, Andrew Bresticker wrote:
>>  static void gic_mask_irq(struct irq_data *d)
>>  {
>> -     GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
>> +     unsigned int irq = d->irq - gic_irq_base;
>> +
>> +     if (gic_is_local_irq(irq)) {
>> +             GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_RMASK),
>> +                      1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
>> +     } else {
>> +             GIC_CLR_INTR_MASK(irq);
>> +     }
>>  }
>>
>>  static void gic_unmask_irq(struct irq_data *d)
>>  {
>> -     GIC_SET_INTR_MASK(d->irq - gic_irq_base);
>> +     unsigned int irq = d->irq - gic_irq_base;
>> +
>> +     if (gic_is_local_irq(irq)) {
>> +             GICWRITE(GIC_REG(VPE_LOCAL, GIC_VPE_SMASK),
>> +                      1 << GIC_INTR_BIT(gic_hw_to_local_irq(irq)));
>> +     } else {
>> +             GIC_SET_INTR_MASK(irq);
>> +     }
>
> Why are you adding a conditional in all these functions instead of
> having two interrupt chips with separate callbacks and irqdata?

Ok, I'll use a separate irqchip.

> And looking at GIC_SET_INTR_MASK(irq) makes me shudder even more. The
> whole thing can be replaced with the generic interrupt chip functions.
>
> If you set it up proper, then there is not a single conditional or
> runtime calculation of bitmasks, address offsets etc.

Yes, I'd like to use the generic irqchip library here, but Malta and
SEAD-3 will need to be converted over to using irq domains.  Perhaps
I'll do that first - it should get rid of a lot of the other ugliness
here as well.
