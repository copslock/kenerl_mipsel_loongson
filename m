Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 07:56:36 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:46693
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeFMFzxiPox0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 07:55:53 +0200
Received: by mail-io0-x243.google.com with SMTP id d22-v6so2142886iof.13;
        Tue, 12 Jun 2018 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vArguN9pDFxaQZ9ltLvl3hoJKc4ozRAk+Pr78v6p+dw=;
        b=sDZ+LFetREzBQQjnYrqZqY+p/kmtOHFVVJtRjNogLntaLkcd1u2F5ZWgZ1y7szK4o8
         sm1HVRkDURz/NNJjGwKb0BG3vLjhdAdowJlK67Shmyuzvsj4RGyY253I6XXXgBmAZrLZ
         rRr6DMfcjTaHehKWNRMljJIh1bRHoUcMrvbSJtoqzqqxGMy8PNLWoFUyXUVUDVqX1N+b
         BH6i+TBQitkTC/yZms9gziNYxABSZ/EXHcUJ0ii3ElSy5MbS79aQ0R1xS+KvxRSlWE9X
         yi8aywnv9/oiJtTAb0elavxcZnGaZmdnu7wS4Un+5pfoUD0+o1bNAY+SXVFDYwUgwGhU
         GaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vArguN9pDFxaQZ9ltLvl3hoJKc4ozRAk+Pr78v6p+dw=;
        b=aIvoUc/1yGdcRNqkixfAn00KPMfTTr+yKjXNRSASi+S2PNd3cMqFVK0GyXDDDbLkU2
         QKikY3ZR+vwqNoJwplAQDKeojuaEWF0MNAh/bmaqh8r1Pn4iWie/gwwRuiB4WEgo7NLv
         GQnjZHOoCUZg8KseNzCg8PRcpes1mcHRAhiKHFcF6BMjVXqyURDrOZehvGk1G2AwUI9b
         xX2Uf5xFVZdhkZt4TUxAUWqPSsQpz5t3oCserOAY/YPhWZtfwlN1fIyp+wbmHeeGAion
         tWFKQCkYzrPxDng0Qf86GBWFAvNYXOocHX5/DNLtseX+zkCZJYZ7Fag/wsrfcLtrbqqk
         vPBg==
X-Gm-Message-State: APt69E18J2zibkfgou+QoBt3RMXKA+CNPHbNP/4SbK4XuZyofC6fdKi6
        JL85o+z+VAGtb5fMlu71rjai9CDcMbzJHQlzMLY=
X-Google-Smtp-Source: ADUXVKJCQTHZHMcWvp5hML6qulsLCFMSBCMg9OkP0lvGQsIJ7v9fX2vDvXqG0GDmvPeKxr+CrfJ9wHyUOL1b5bPDz5I=
X-Received: by 2002:a5e:d60a:: with SMTP id w10-v6mr3460925iom.54.1528869318589;
 Tue, 12 Jun 2018 22:55:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:b88a:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 22:55:17
 -0700 (PDT)
In-Reply-To: <20180612184053.odi5gvvwbqovgvc6@pburton-laptop>
References: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
 <1528797283-16577-2-git-send-email-chenhc@lemote.com> <20180612184053.odi5gvvwbqovgvc6@pburton-laptop>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Wed, 13 Jun 2018 13:55:17 +0800
X-Google-Sender-Auth: U4BHIBSEGDofmnZrYA4QNbATMvc
Message-ID: <CAAhV-H4cyBHscWFzs47Ru9ChrJ-8CCc6pzqAmsqzzDNv1oUB6w@mail.gmail.com>
Subject: Re: [PATCH Resend 2/2] MIPS: mcs lock: implement arch_mcs_spin_lock_contended()
 for Loongson-3
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64252
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

Hi, Paul,

On Wed, Jun 13, 2018 at 2:40 AM, Paul Burton <paul.burton@mips.com> wrote:
> Hi Huacai,
>
> On Tue, Jun 12, 2018 at 05:54:43PM +0800, Huacai Chen wrote:
>> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
>> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
>> has SFB (Store Fill Buffer) and need a mb() after every READ_ONCE().
>
> Why do you need that mb()?
>
> Could you describe what is actually happening with the current code, in
> order to explain what requires the mb() you mention here? What's being
> held in the SFB & why is that problematic?
>
> Most importantly if smp_cond_load_acquire() isn't working as expected on
> Loongson CPUs then fixing that would be a much better path forwards than
> trying to avoid using it.
>
> Could it be that Loongson requires an implementation of
> (smp_)read_barrier_depends()?
Yes, we should fix smp_cond_load_acquire(), not
arch_mcs_spin_lock_contended(). Thank you very much.

>
> Additionally you have "Resend" in the subject of this email, but I don't
> see any previous submissions of this patch - given that commit
> 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire() in MCS spin
> loop") is very recent I doubt there were any. Please try to be factual,
> and if you have 2 patches that are unrelated please send them separately
> rather than as a series.
I send another patch in this series because it is so simple and should
be merged in the previous release, but it is ignored again and again.
In practise, my
single patch in linux-mips usually be ignored (even they are very
simple and well described)....
For example:
https://patchwork.linux-mips.org/patch/17723/
https://patchwork.linux-mips.org/patch/18587/
https://patchwork.linux-mips.org/patch/19184/

Some of them are promised by James to review, but still ignored until now.

Huacai

>
> Thanks,
>     Paul
>
>> This patch introduce a MIPS-specific mcs_spinlock.h and revert to the
>> old implementation of arch_mcs_spin_lock_contended() for Loongson-3.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
>>  arch/mips/include/asm/Kbuild         |  1 -
>>  arch/mips/include/asm/mcs_spinlock.h | 14 ++++++++++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/mips/include/asm/mcs_spinlock.h
>>
>> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
>> index 45d541b..7076627 100644
>> --- a/arch/mips/include/asm/Kbuild
>> +++ b/arch/mips/include/asm/Kbuild
>> @@ -6,7 +6,6 @@ generic-y += emergency-restart.h
>>  generic-y += export.h
>>  generic-y += irq_work.h
>>  generic-y += local64.h
>> -generic-y += mcs_spinlock.h
>>  generic-y += mm-arch-hooks.h
>>  generic-y += parport.h
>>  generic-y += percpu.h
>> diff --git a/arch/mips/include/asm/mcs_spinlock.h b/arch/mips/include/asm/mcs_spinlock.h
>> new file mode 100644
>> index 0000000..063df4e
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mcs_spinlock.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_MCS_LOCK_H
>> +#define __ASM_MCS_LOCK_H
>> +
>> +/* Loongson-3 need a mb() after every READ_ONCE() */
>> +#if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_SMP)
>> +#define arch_mcs_spin_lock_contended(l)                                      \
>> +do {                                                                 \
>> +     while (!(smp_load_acquire(l)))                                  \
>> +             cpu_relax();                                            \
>> +} while (0)
>> +#endif       /* CONFIG_CPU_LOONGSON3 && CONFIG_SMP */
>> +
>> +#endif       /* __ASM_MCS_LOCK_H */
>> --
>> 2.7.0
>>
