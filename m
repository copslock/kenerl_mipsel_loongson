Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 19:53:48 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:58869 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491793Ab0FSRxp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 19 Jun 2010 19:53:45 +0200
Received: by wwb13 with SMTP id 13so1744966wwb.36
        for <linux-mips@linux-mips.org>; Sat, 19 Jun 2010 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=xH/LMYpNuqnjZGHcqX7CzT0xfUwBgGWAEq9jznrFcwI=;
        b=Wd62zfxhF3MpHGl1VrVopq1TcSSvkCkcd8T77ngmVyeJTO6ThYI5YSbDkt5CjmHWiy
         wcY6cJrwmpHTKQhzYFWrOkhTUK9VqKwUj1zW1DFvyCSsr45S+HkSRhF7QuNW/+YKWPye
         8Ltp7lCFl5rbOmGLDEvZShkgnrPfgmBeHw5wA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=RaKB5AW0UUI5JTTjUXgLGKL2f6qbH4TS4SV+WTyN5EjZI0R0PlxnSJuYZGOPV2UYL4
         2i//l8oVy+6lw693zJzoow5rOfGF4H1i9cInokCDiDqmdlrwSXRLkO2qwqveMmPei9mp
         sIW9pRm0QthNltJ8fzJyP3qI8hUN6YYnqPWkQ=
MIME-Version: 1.0
Received: by 10.216.91.7 with SMTP id g7mr1246745wef.93.1276970018787; Sat, 19 
        Jun 2010 10:53:38 -0700 (PDT)
Received: by 10.216.48.17 with HTTP; Sat, 19 Jun 2010 10:53:38 -0700 (PDT)
In-Reply-To: <4C1D0189.6050803@metafoo.de>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
        <201006191243.39793.marek.vasut@gmail.com>
        <4C1CC08E.5050009@metafoo.de>
        <201006191604.25329.marek.vasut@gmail.com>
        <4C1D0189.6050803@metafoo.de>
Date:   Sat, 19 Jun 2010 19:53:38 +0200
X-Google-Sender-Auth: _f17mx37Pm0Xnf9P4usEA5Go9gM
Message-ID: <AANLkTim1AEoIAFKq4so7GP6zwxUPJLslWjeIKgNOP8yA@mail.gmail.com>
Subject: Re: [PATCH v2 15/26] RTC: Add JZ4740 RTC driver
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Wan ZongShun <mcuos.com@gmail.com>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 27219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13586

On Sat, Jun 19, 2010 at 19:42, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Marek Vasut wrote:
>> Dne So 19. června 2010 15:05:18 Lars-Peter Clausen napsal(a):
>>> Marek Vasut wrote:
>>>> Dne So 19. června 2010 07:08:20 Lars-Peter Clausen napsal(a):
>>>>> This patch adds support for the RTC unit on JZ4740 SoCs.

>>>>> +static void jz4740_rtc_ctrl_set_bits(struct jz4740_rtc *rtc, uint32_t
>>>>> mask, +    uint32_t val)
>>>>> +{
>>>>> +  unsigned long flags;
>>>>> +  uint32_t ctrl;
>>>>> +
>>>>> +  spin_lock_irqsave(&rtc->lock, flags);
>>>>>
>>>> Can't we use local_irq_save()/local_irq_restore() ?
>>>>
>>> Why would that be preferable? In the non-debug, non-rt case this will
>>> expand to local_irq_{save,restore} anyway, but you'll lose the semantics
>>> of an lock.
>>>
>>
>> I believe on SMP systems, local_irq_save will give you finer locking
>> granularity.
>>
> Hm, not sure about that. But this is on a non SMP system anyway.

If the driver will ever be used on a SMP system, local_irq_save() will
not protect
against concurrent accesses on different CPUs. So it's better to use
spin_lock_irqsave().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
