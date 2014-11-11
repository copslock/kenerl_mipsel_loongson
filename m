Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 12:02:56 +0100 (CET)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:63663 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013353AbaKKLCyFzUS9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 12:02:54 +0100
Received: by mail-ig0-f173.google.com with SMTP id r10so764830igi.6
        for <multiple recipients>; Tue, 11 Nov 2014 03:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=z/OjHcTl4EP9tvIaqS7EDSD9K+3yJjrU7Fxv9mIHahk=;
        b=SQ6CdGDJ99JWxLDqqZJYL3HEcMeW0s34u4AxjrWzIzgq3J+pYtNoW5FxVoHBtGFdn+
         47rwNzZyKJaKazID+RTKviwznqxllWuszIqa0mLjA+LpMHAzbinj7Mz35EPO/yfL4tns
         Lt7cSTLLIryfHmVWlbR4MH6VJztpF+7lSmR7vxOaWiuWHb1b1ZqySp44bKO+FEwPzyyR
         1rAM6VMHRsH0uxFMaWguK4bdAxBMZbYUOwxApwAFvQNiXR0kKCm/teR+hKFZAkzRPoTT
         sB9UY/HaENvoRKHyW0EF1nDu+NfWO5BFKa8UXYWlAxUvg2XD4qXGU924qOdGLAOaiLQV
         8mQg==
MIME-Version: 1.0
X-Received: by 10.107.36.136 with SMTP id k130mr38996613iok.4.1415703768189;
 Tue, 11 Nov 2014 03:02:48 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Tue, 11 Nov 2014 03:02:48 -0800 (PST)
In-Reply-To: <20141111105748.GK27259@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
        <20141111105748.GK27259@linux-mips.org>
Date:   Tue, 11 Nov 2014 19:02:48 +0800
X-Google-Sender-Auth: M_QuEguyfxnq3-p8mEvj26yTTLM
Message-ID: <CAAhV-H7H+7TYyvbecaS6C1NEq7DEnjez2Z_eHnpix0+m_5FDoA@mail.gmail.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for Loongson-3
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-pm@vger.kernel.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43990
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

Hi, Ralf,

Loops_per_jiffy is set on startup and doesn't change later. It reflect
the maximum value frequency, but for CPU hotplug, a new online CPU may
not run at the maximum frequency (remain the old value before it is
offline).

Huacai

On Tue, Nov 11, 2014 at 6:57 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 04, 2014 at 02:18:48PM +0800, Huacai Chen wrote:
>
>> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>> index c94c4e9..01d676a 100644
>> --- a/arch/mips/kernel/smp.c
>> +++ b/arch/mips/kernel/smp.c
>> @@ -136,7 +136,8 @@ asmlinkage void start_secondary(void)
>>       calibrate_delay();
>>       preempt_disable();
>>       cpu = smp_processor_id();
>> -     cpu_data[cpu].udelay_val = loops_per_jiffy;
>> +     if (!cpu_data[cpu].udelay_val)
>> +             cpu_data[cpu].udelay_val = loops_per_jiffy;
>
> Why this?  Is the idea that the value of loops_per_jiffy which was set
> on bootup may no longer match the actual clock frequency?
>
>   Ralf
>
