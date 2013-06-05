Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jun 2013 19:01:50 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52574 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827524Ab3FERBo5ZLzn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jun 2013 19:01:44 +0200
Received: by mail-lb0-f171.google.com with SMTP id v5so2131384lbc.2
        for <linux-mips@linux-mips.org>; Wed, 05 Jun 2013 10:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=2J/Al3G+hBQns3895rd37KNWspkwV0QF1rrp56Rqws0=;
        b=ibAvwy26bEoHXA4+muvFml3OtGXkFig3qkD4MDmlPK+3rF9nbcUWoCe4Xf6+6m3eNF
         DW7nW6pMYH19CM9pxtOiFZQ/hI+haZcSpp+NPsoYux0Y+Uz+HwItg2FPmiF6Gik2wEaS
         WSJVnp83tUl5vweka5k/eJ5dpuNgPHr+kJN8jdJ+Oi3PjLfQnwS3aTDy16f6G8gPrOZA
         M+u5Uo5sa3W/AA4cv+ufpVUE6EE7c6XzSmFdFp7Kf6RToE/AzikCFA4GrHTN8DOd8xHG
         XVoz89T5Jf27g5TJfC6Rtg21QbBdrT6p74G1XnKVPFuyVojyJIMI2a0LB2TczHpvjq64
         VpEA==
X-Received: by 10.112.89.200 with SMTP id bq8mr3842450lbb.104.1370451699170;
        Wed, 05 Jun 2013 10:01:39 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-88-205.pppoe.mtu-net.ru. [91.76.88.205])
        by mx.google.com with ESMTPSA id w8sm7336491lbi.14.2013.06.05.10.01.37
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 05 Jun 2013 10:01:37 -0700 (PDT)
Message-ID: <51AF6EF5.6030801@cogentembedded.com>
Date:   Wed, 05 Jun 2013 21:01:41 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v3] MIPS: micromips: Fix improper definition of ISA exception
 bit.
References: <1370372979-20634-1-git-send-email-Steven.Hill@imgtec.com> <51AF1C0B.6090904@cogentembedded.com> <51AF690B.8020702@gmail.com>
In-Reply-To: <51AF690B.8020702@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkptomO8ZzyM9p/JgUXQI3m6pp5dV+HDh9mA5uGQaSp9Q0T0lqBm+Rm1OT28omct6+M7ag2
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 06/05/2013 08:36 PM, David Daney wrote:

>
>>
>>> The ISA exception bit selects whether exceptions are taken in classic
>>> MIPS or microMIPS mode. This bit is Config3.ISAOnExc and is bit 16. It
>>> It was improperly defined as bits 16 and 17. Fortunately, bit 17 is
>>> read-only and did not effect microMIPS operation. However, detecting
>>> a classic or microMIPS kernel when examining the /proc/cpuinfo file,
>>> the result always showed a microMIPS kernel.
>
> I don't see anything in the patch that would make Classic CPUs be 
> misidentified.  Is the change log still accurate?
>
> ...
>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>> ---
>>>   arch/mips/include/asm/mipsregs.h |    2 +-
>>>   arch/mips/kernel/cpu-probe.c     |    7 ++-----
>>>   arch/mips/mti-malta/malta-init.c |    7 +++++++
>>>   arch/mips/mti-sead3/sead3-init.c |    7 +++++++
>>>   4 files changed, 17 insertions(+), 6 deletions(-)
>>
>> [...]
>>> diff --git a/arch/mips/mti-malta/malta-init.c
>>> b/arch/mips/mti-malta/malta-init.c
>>> index ff8caff..3598f1d 100644
> [...]
>>> --- a/arch/mips/mti-sead3/sead3-init.c
>>> +++ b/arch/mips/mti-sead3/sead3-init.c
>>> @@ -130,6 +130,13 @@ static void __init mips_ejtag_setup(void)
>>>
>>>   void __init prom_init(void)
>>>   {
>>> +#ifdef CONFIG_CPU_MICROMIPS
>>> +    unsigned int config3 = read_c0_config3();
>>> +
>>> +    if (config3 & MIPS_CONF3_ISA)
>>> +        write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
>>> +#endif
>>> +
>>
>>     I see it's repeated twice and enclosed in #ifdef... Couldn't you
>> factor it out in some sort of inline function and put into some header:
>>
>> #ifdef CONFIG_CPU_MICROMIPS
>> static inline void mips_set_config3_isa_oe(void)
>
>
> I don't have a strong opinion about factoring it out like this, but we 
> do, let's give it a better name.  Something like 
> enable_micromips_exception_mode() or similar.  That way we know what 
> it does.

     Yes, the name was only a (bad) example, since I didn't really 
understand what the code was doing.

>
>> {
>>      unsigned int config3 = read_c0_config3();
>>
>>      if (config3 & MIPS_CONF3_ISA)
>>          write_c0_config3(config3 | MIPS_CONF3_ISA_OE);
>> }
>> #else
>> static inline void mips_set_config3_isa_oe(void) {}
>> #endif
>>

WBR, Sergei
