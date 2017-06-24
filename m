Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 10:55:28 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:33361
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdFXIzV2Paha (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 10:55:21 +0200
Received: by mail-it0-x242.google.com with SMTP id x12so8587043itb.0;
        Sat, 24 Jun 2017 01:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Tyw1GNwxmuhgQLR3hRbD5Dc8ie1JG+xEyCtJHZ8EN00=;
        b=NcwytqOkx/dtQ4cT4w4dhNh9cpBdHipU40iUCKTTbnBvIZ68wMyhoCpi8PsggwIaNn
         FiFXyJxth06g4uP8JJ3cXSzAziRuS9g6imEXMFbVehC/FmsVarO+MD7vWRJV+Zhd9pVx
         iSGpf0ftSzxyf0qvks9TW/wVUp2Nd/PD5jKlL4zPL5xXp7pC++sERGMFz+4CeoLImClw
         FOraRab5D9WCXYO8YP784CVtBDSdhYkzAOabBlfcC9L+W26agcTMIl6ZnpPjsDPS7u93
         nggQQA73D/7uimocsPuKFgPjLJev1uRyJyFqA6yR3Tnobv8qSxPY6TfZ6WMcH9BFzj7n
         HHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Tyw1GNwxmuhgQLR3hRbD5Dc8ie1JG+xEyCtJHZ8EN00=;
        b=Nd2GC14rIHR9KFJSpbE6Ap56zP+zjiPYCkjdDRCB8Wec+Gdjupif54UbYnEVc2d6PT
         Kl/kB192nc3Sbol4LRikNImLAcQ9LVgtC8Wp/z43+K6xs0kQwzK0wtkwanLDiDOff4iB
         zbGg0kui8hGMuO0OyFrh5bnhWDX58Tw/C234ZujgUMGoIMe24sK+71k/1HdxU51cA279
         8a0McNuczorqe0kdbvb/t08LIim0pEVAKAvPo4xIgxsmLUOLl3V3cpGn802Er/sS7EhP
         GebhJF4aHTVsN1zdva+wcYp30MycIKL4ZpANdUzUf2/Oqe3Dm04BrUtdhJAO/94yTBIa
         kUOg==
X-Gm-Message-State: AKS2vOw8/Xhpw9Nxsj5yAMP5L1/UlcoHb1y4bJvCWHUBc+M+E02gBg1I
        h9eq6u7kEk7MHKNi9btxSGmJRK2VWQ==
X-Received: by 10.36.219.132 with SMTP id c126mr12058075itg.73.1498294515618;
 Sat, 24 Jun 2017 01:55:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.144.85 with HTTP; Sat, 24 Jun 2017 01:55:14 -0700 (PDT)
In-Reply-To: <20170623145453.GB31455@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-10-git-send-email-chenhc@lemote.com> <20170623145453.GB31455@jhogan-linux.le.imgtec.org>
From:   Huacai Chen <chenhc@lemote.com>
Date:   Sat, 24 Jun 2017 16:55:14 +0800
X-Google-Sender-Auth: Xy2RIltSKO8bax8I1DVXhg3n4ac
Message-ID: <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58785
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

Hi, James,

smp_mb__before_llsc() can not be used in all cases, e.g., in
arch/mips/include/asm/spinlock.h and other similar cases which has a
label before ll/lld. So, I think it is better to keep it as is to keep
consistency.

Huacai

On Fri, Jun 23, 2017 at 10:54 PM, James Hogan <james.hogan@imgtec.com> wrote:
> On Thu, Jun 22, 2017 at 11:06:56PM +0800, Huacai Chen wrote:
>> diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
>> index 0ab176b..e0002c58 100644
>> --- a/arch/mips/include/asm/atomic.h
>> +++ b/arch/mips/include/asm/atomic.h
>> @@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i, atomic_t * v)                          \
>>               "       .set    mips0                                   \n"   \
>>               : "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)          \
>>               : "Ir" (i));                                                  \
>> +     } else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {                   \
>> +             int temp;                                                     \
>> +                                                                           \
>> +             do {                                                          \
>> +                     __asm__ __volatile__(                                 \
>> +                     "       .set    "MIPS_ISA_LEVEL"                \n"   \
>> +                     __WEAK_LLSC_MB                                        \
>> +                     "       ll      %0, %1          # atomic_" #op "\n"   \
>> +                     "       " #asm_op " %0, %2                      \n"   \
>> +                     "       sc      %0, %1                          \n"   \
>> +                     "       .set    mips0                           \n"   \
>> +                     : "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)      \
>> +                     : "Ir" (i));                                          \
>> +             } while (unlikely(!temp));                                    \
>
> Can loongson use the common versions of all these bits of assembly by
> adding a LOONGSON_LLSC_WAR dependent smp_mb__before_llsc()-like macro
> before the asm?
>
> It would save a lot of duplication, avoid potential bitrot and
> divergence, and make the patch much easier to review.
>
> Cheers
> James
