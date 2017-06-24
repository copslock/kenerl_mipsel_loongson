Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 11:24:06 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:33428
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992028AbdFXJX6esB9A convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Jun 2017 11:23:58 +0200
Received: by mail-it0-x242.google.com with SMTP id x12so8623795itb.0;
        Sat, 24 Jun 2017 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HVRzzzp3Yx4lI7QkPN8rnJ8clwMXp0/xJbBOpFMfXEg=;
        b=lHJtE0jnQe0nCpzYuBLNlhVpBzf0DuwbwuXal5m53e9DHICmFy3dofUfaz2AqS+zww
         LfFKyNcxPz5Jh57gPHbOyyBgLPveNbojRxRY0ZI0PpJ3u7/N7/3xXUvjbsgPrBvzzmr9
         zABW9YKtTQqYY82Tu8sG977QO+f/lXVjsJU29nEhvmG4PMto525WqIJai2gO285yG8Bk
         cMqpKQ3vClZptiXH1/WAyFQin21cHR6rpgaFmG4w93H5XcJaSECWCsAH6yLG56q98cZs
         Vu+LZPRuE4KPGorOHjRl8JIoIS23LwaxL0nH/QahfaZHUfw4Cyk9YYT5w/zUbAGelC9t
         YRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HVRzzzp3Yx4lI7QkPN8rnJ8clwMXp0/xJbBOpFMfXEg=;
        b=KEfXpwjI2YfKN3LZ20fjR9WZRRVIRHK5wKvldd1UmhrtY0E9dT3yo8l6XDj9Y+2Sox
         CbQZutX/oAZ7QznaB1rSydGx/LBKMkPhse14j2uWvV+02GJCwsstMSDEvPfea4FW18kN
         yuQ9wGpZGjuCQCHMWFBC8O8O45Bb1mSFPLvTF6Vl5wtZJ5Wj0qMjn4xLh/SsaEYhOQq4
         sEhTCnK8v/1xUqmuy8BmDIiS/P7RPmPjTuJRyO2w6Sq9jQZDjDq6BxTfLfPYLI1cInMM
         hO+iVl57S/1+gRJufqcEJEFTZHBe1zEboIb+ZUcxyoyCkdsDsTk5QGZ2cK5TBlNJ5hSQ
         ho3g==
X-Gm-Message-State: AKS2vOwgWI/ubydKZyqaSZzmPKIAkKHn6qAduYe/8xvhLX2XJHyBhxFo
        infhIGV3f5b2Elm4IWVZnxjTJBqJHg==
X-Received: by 10.36.219.132 with SMTP id c126mr12129395itg.73.1498296232691;
 Sat, 24 Jun 2017 02:23:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Sat, 24 Jun 2017 02:23:52 -0700 (PDT)
In-Reply-To: <1B97A9D2-5753-4143-AB56-389280FDBA64@imgtec.com>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-10-git-send-email-chenhc@lemote.com> <20170623145453.GB31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com> <1B97A9D2-5753-4143-AB56-389280FDBA64@imgtec.com>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sat, 24 Jun 2017 17:23:52 +0800
X-Google-Sender-Auth: IvocJZptBxdTV3GqIGoBskw4XIw
Message-ID: <CAAhV-H4=D0QqKA=M48e8r+3x2N3SXEDTYLawxU5+sYndJ1fZ9Q@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58789
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

You are right, but it seems like __WEAK_LLSC_MB is already the best
name for this case. Maybe I define a macro named __VERY_WEAK_LLSC_MB
to expand a "sync" on Loongson?

Huacai

On Sat, Jun 24, 2017 at 5:02 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On 24 June 2017 09:55:14 BST, Huacai Chen <chenhc@lemote.com> wrote:
>>Hi, James,
>>
>>smp_mb__before_llsc() can not be used in all cases, e.g., in
>>arch/mips/include/asm/spinlock.h and other similar cases which has a
>>label before ll/lld. So, I think it is better to keep it as is to keep
>>consistency.
>
> I know. I didn't mean use smp_mb_before_llsc directly, i just meant use something similar directly before the ll that would expand to nothing on non loongson kernels and still avoid the mass duplication of inline asm which leads to divergence, bitrot, and maintenance problems.
>
> cheers
> James
>
>>
>>Huacai
>>
>>On Fri, Jun 23, 2017 at 10:54 PM, James Hogan <james.hogan@imgtec.com>
>>wrote:
>>> On Thu, Jun 22, 2017 at 11:06:56PM +0800, Huacai Chen wrote:
>>>> diff --git a/arch/mips/include/asm/atomic.h
>>b/arch/mips/include/asm/atomic.h
>>>> index 0ab176b..e0002c58 100644
>>>> --- a/arch/mips/include/asm/atomic.h
>>>> +++ b/arch/mips/include/asm/atomic.h
>>>> @@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i,
>>atomic_t * v)                          \
>>>>               "       .set    mips0
>> \n"   \
>>>>               : "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)
>>       \
>>>>               : "Ir" (i));
>>       \
>>>> +     } else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
>>       \
>>>> +             int temp;
>>       \
>>>> +
>>       \
>>>> +             do {
>>       \
>>>> +                     __asm__ __volatile__(
>>       \
>>>> +                     "       .set    "MIPS_ISA_LEVEL"
>> \n"   \
>>>> +                     __WEAK_LLSC_MB
>>       \
>>>> +                     "       ll      %0, %1          # atomic_" #op
>>"\n"   \
>>>> +                     "       " #asm_op " %0, %2
>> \n"   \
>>>> +                     "       sc      %0, %1
>> \n"   \
>>>> +                     "       .set    mips0
>> \n"   \
>>>> +                     : "=&r" (temp), "+" GCC_OFF_SMALL_ASM()
>>(v->counter)      \
>>>> +                     : "Ir" (i));
>>       \
>>>> +             } while (unlikely(!temp));
>>       \
>>>
>>> Can loongson use the common versions of all these bits of assembly by
>>> adding a LOONGSON_LLSC_WAR dependent smp_mb__before_llsc()-like macro
>>> before the asm?
>>>
>>> It would save a lot of duplication, avoid potential bitrot and
>>> divergence, and make the patch much easier to review.
>>>
>>> Cheers
>>> James
>
>
> --
> James Hogan
>
