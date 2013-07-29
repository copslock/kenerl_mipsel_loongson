Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 13:15:35 +0200 (CEST)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35093 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818993Ab3G2LPXXj2DA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Jul 2013 13:15:23 +0200
Received: by mail-pd0-f177.google.com with SMTP id u11so5331707pdi.22
        for <linux-mips@linux-mips.org>; Mon, 29 Jul 2013 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1EbEhixjRc60zwmHRqZInO8iVp3fu0elb7/i9wPElKg=;
        b=0LsH9/pIgMOTO6nBQaGEzkTa3gJVhSSRCMVgw2vRrCxPflwN3jv26+kqjAZCtEJDXd
         oV1sj67C1PyuF5IO+BnfKWumHNCMjwEq5q/UwPLgwV2DkIVFN9DOC/MuiX3Ce6l2WU6u
         rF8xxz/DZHZ+UbQebQAsbSEi8kc0On+zhPpPl97LrC7qPhQQv8jobAEvlHvwNzSzMcmk
         ZVeNutA2lxJnBodxVMuXRQjYCrusv8j1rspIACaKkfu5w9fkiv2FTYArjvHtZi0wJCUe
         InkazPIf/YUmK8jLGQ1Jx0PUlZb99+iVFzLw6XXOu1KoZMbh+Sw/dtr/ERogoQOdYCcV
         WQjA==
X-Received: by 10.66.179.78 with SMTP id de14mr22717586pac.18.1375096516671;
 Mon, 29 Jul 2013 04:15:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Mon, 29 Jul 2013 04:14:36 -0700 (PDT)
In-Reply-To: <51F6495D.9000008@phrozen.org>
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org>
 <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com> <51F6495D.9000008@phrozen.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 29 Jul 2013 12:14:36 +0100
Message-ID: <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
To:     John Crispin <john@phrozen.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/7/29 John Crispin <john@phrozen.org>:
> Hi Florian,
>
>
>> It is not clear to me whether this secondary cevt is also a r4k-cevt
>> device, or if it is something else? If the IRQ is shared, is there any
>> way to differentiate the ralink cevt from the r4k cevt, such that both
>> could request the same irq with the IRQF_SHARED flag?
>>
>
> IRQF_SHARED | IRQF_TIMER is not allowed as a combination.

Good point, forgot about that. Then how about a way to let a platform
specify its own callback? Pretty much like what is done with the
handle_perf(r2) case?

>
>
>
>> It looks to me like you are moving the irq setup later just to ensure
>> that your ralink clockevent device has been registered before and has
>> set cp0_timer_irq_installed when the set_mode() r4k clockevent device
>> runs, such that it won't register the same IRQ that your platforms
>> uses. If that it the case, cannot you just ensure that you run your
>> cevt device registration before mips_clockevent_init() is called?
>
>
> i dont like relying on the order in which the modules get loaded.

plat_time_init() runs before mips_clockevent_init() and the ordering
is explicit, would not that work for what you are trying to do?

>
> the actual problem is not the irq sharing but that the cevt-r4k registers
> the irq when the cevt is registered and not when it is activated. i believe
> that the patch fixes this problem

Your patch certainly does what you say it does, but that is kind of an
abuse of the set_mode() callback.
-- 
Florian
