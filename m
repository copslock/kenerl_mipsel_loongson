Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 11:02:29 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:33541
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdFXJCWF49ya convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Jun 2017 11:02:22 +0200
Received: by mail-wr0-x241.google.com with SMTP id x23so18024582wrb.0
        for <linux-mips@linux-mips.org>; Sat, 24 Jun 2017 02:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=pL2yaJdW1nhuvoi98YtHj2CSlbsS01Ypy7XMmxioRUs=;
        b=efKkVKzq9j0wj7YfIvL3LcCCyCNbvduHOeIBQr+ipsRQLd9P1YCcND+g2bo8SmGRhS
         hGF3dl+fXTrFgfCVqhvyNYHikIe30qrOjoHTsKc5TfZEPWqBIoejkhITvQMYOje4OPBj
         DGM0muwtSgL+9f4YKA7ci7z8Tv2+U8e0bYbWeoThpskmeHKXRHgkxmZVxt3znwVp+Lq8
         JImHbIqsvEPUqvhUNGli8XqkK7RMHwwm3f57ATPvzvwgUQeCR0xCfRuaNpBYw30SNMWm
         AEhi10f9lZ8dubXpJ/6t/gUeExKCYNsFbO7rldLwsr53Ke3tsJd6ZSDlLuw7QY3ALLo+
         mSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=pL2yaJdW1nhuvoi98YtHj2CSlbsS01Ypy7XMmxioRUs=;
        b=fqpB5AkGAvlvfkC0YcjyH2p/tFfLSLlJZdKTc6yhI6+EFBcvU/vRObrFFdtmM0s5+r
         cyDAXNmTYbBj+VC+EYDw/kJSD+qJthP7n8b8UPJUvsibrvbmhXEJGfW9KqEVtSF/4RMo
         DS7TH+eevK1EGqkGmY6N9vxIZn1cYJmWM8G0mxTSlBNCTV4sU0YPHzi+Yd0FUQeKOSVY
         Dd6IyVKqQvVza3OK9ydgqi+nzGn9qceAFaTMvVG4xlHtvX9e8TtUJvo0bRSV4kMOJ8ac
         O2z79lawgE0OiLxQBQJpMWAl9IgptBGk/6IDrlhwFqZRglV9rWVTRpzk5j5WibPx0TUN
         wLgg==
X-Gm-Message-State: AKS2vOxCMM01x8Qqp2ZlLyxSN6e9zkyCx+usqF0QBml2Ir1LWgsNQMPx
        yq10UD+QqBR/3Bwlcy4=
X-Received: by 10.28.126.133 with SMTP id z127mr7728840wmc.46.1498294936337;
        Sat, 24 Jun 2017 02:02:16 -0700 (PDT)
Received: from android-f8911984c6e3e13 (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id p141sm3117884wmb.28.2017.06.24.02.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 02:02:15 -0700 (PDT)
Date:   Sat, 24 Jun 2017 10:02:14 +0100
In-Reply-To: <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com> <1498144016-9111-10-git-send-email-chenhc@lemote.com> <20170623145453.GB31455@jhogan-linux.le.imgtec.org> <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH V7 9/9] MIPS: Loongson: Introduce and use LOONGSON_LLSC_WAR
To:     linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
From:   James Hogan <james.hogan@imgtec.com>
Message-ID: <1B97A9D2-5753-4143-AB56-389280FDBA64@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 24 June 2017 09:55:14 BST, Huacai Chen <chenhc@lemote.com> wrote:
>Hi, James,
>
>smp_mb__before_llsc() can not be used in all cases, e.g., in
>arch/mips/include/asm/spinlock.h and other similar cases which has a
>label before ll/lld. So, I think it is better to keep it as is to keep
>consistency.

I know. I didn't mean use smp_mb_before_llsc directly, i just meant use something similar directly before the ll that would expand to nothing on non loongson kernels and still avoid the mass duplication of inline asm which leads to divergence, bitrot, and maintenance problems.

cheers
James

>
>Huacai
>
>On Fri, Jun 23, 2017 at 10:54 PM, James Hogan <james.hogan@imgtec.com>
>wrote:
>> On Thu, Jun 22, 2017 at 11:06:56PM +0800, Huacai Chen wrote:
>>> diff --git a/arch/mips/include/asm/atomic.h
>b/arch/mips/include/asm/atomic.h
>>> index 0ab176b..e0002c58 100644
>>> --- a/arch/mips/include/asm/atomic.h
>>> +++ b/arch/mips/include/asm/atomic.h
>>> @@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i,
>atomic_t * v)                          \
>>>               "       .set    mips0                                 
> \n"   \
>>>               : "=&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)  
>       \
>>>               : "Ir" (i));                                          
>       \
>>> +     } else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {           
>       \
>>> +             int temp;                                             
>       \
>>> +                                                                   
>       \
>>> +             do {                                                  
>       \
>>> +                     __asm__ __volatile__(                         
>       \
>>> +                     "       .set    "MIPS_ISA_LEVEL"              
> \n"   \
>>> +                     __WEAK_LLSC_MB                                
>       \
>>> +                     "       ll      %0, %1          # atomic_" #op
>"\n"   \
>>> +                     "       " #asm_op " %0, %2                    
> \n"   \
>>> +                     "       sc      %0, %1                        
> \n"   \
>>> +                     "       .set    mips0                         
> \n"   \
>>> +                     : "=&r" (temp), "+" GCC_OFF_SMALL_ASM()
>(v->counter)      \
>>> +                     : "Ir" (i));                                  
>       \
>>> +             } while (unlikely(!temp));                            
>       \
>>
>> Can loongson use the common versions of all these bits of assembly by
>> adding a LOONGSON_LLSC_WAR dependent smp_mb__before_llsc()-like macro
>> before the asm?
>>
>> It would save a lot of duplication, avoid potential bitrot and
>> divergence, and make the patch much easier to review.
>>
>> Cheers
>> James


--
James Hogan
