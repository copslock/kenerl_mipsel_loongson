Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 15:16:35 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36817 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007025AbbIINQdYckRi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Sep 2015 15:16:33 +0200
Received: by oibi136 with SMTP id i136so5114415oib.3;
        Wed, 09 Sep 2015 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z0+099ekiHJ7DHBKcFesbW1tRmmJKR9RrvuEj+YBDC4=;
        b=PqxA0strBtuOm0aJ4SUb9S9a+z/S9IHo8hbRVZQloH2lDPTy72ntD5WylUB4ES6o6+
         xPKOvhW9wAtFc0I8Un+3Ln/6aa0ePE+5EfV2hxKE+wSPfcOs/h5Gxj4swGic2fJCottq
         K26y14hLrdIrUcWUsJIVPAa2D6ak8bH9YkIcLwv92zO/Kng7gYq84WoYCFgMzWVkgnCY
         zN43IaMCNjiqbo90yJ41lDprI58b22lm2V0rB4lJRGqtO4WpUg51FHYDBOzrtAQERoRl
         5OR0LeYiTwiAxsE5DwwhzqNY1ZrAH7ZNUcf3wuvhvoAGBboY7ULTKCUR1vjG0haJYfNb
         6/Fw==
X-Received: by 10.202.197.151 with SMTP id v145mr25600045oif.88.1441804587320;
 Wed, 09 Sep 2015 06:16:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.198.12 with HTTP; Wed, 9 Sep 2015 06:16:07 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.20.1509071700480.10227@eddie.linux-mips.org>
References: <1441640982-17547-1-git-send-email-yszhou4tech@gmail.com> <alpine.LFD.2.20.1509071700480.10227@eddie.linux-mips.org>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Wed, 9 Sep 2015 21:16:07 +0800
Message-ID: <CAECwjAjrPKc+UuV5oqWbV_9AAKbW_u+NGiB+O+WKQEU6UKw5mw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: UAPI: Ignore __arch_swab{16,32,64} when using MIPS16
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

On 8 September 2015 at 00:07, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Mon, 7 Sep 2015, Yousong Zhou wrote:
>
>> diff --git a/arch/mips/include/uapi/asm/swab.h b/arch/mips/include/uapi/asm/swab.h
>> index 8f2d184..8b9a390 100644
>> --- a/arch/mips/include/uapi/asm/swab.h
>> +++ b/arch/mips/include/uapi/asm/swab.h
>> @@ -8,6 +8,11 @@
>>  #ifndef _ASM_SWAB_H
>>  #define _ASM_SWAB_H
>>
>> +/*
>> + * Enable the optimized version only when compiling without MIPS16.
>> + */
>> +#ifndef __mips16
>> +
>>  #include <linux/compiler.h>
>>  #include <linux/types.h>
>>
>> @@ -66,4 +71,5 @@ static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
>>  #define __arch_swab64 __arch_swab64
>>  #endif /* __mips64 */
>>  #endif /* MIPS R2 or newer or Loongson 3A */
>> +#endif /* ifndef __mips16 */
>>  #endif /* _ASM_SWAB_H */
>
>  I think it will best go with the main #if which checks the conditions
> that have to be met for this optimisation to be possible; there is no gain
> from nesting the conditions here.
>

Yes, you are right, and I should not wrap that __SWAB_64_THRU_32__
inside the #if check.

>  Also you need a second patch paired with this to undo your previous
> `nomips16' change which will be no longer needed (and in the case of the
> `.set' part not wanted either).

Wow, I did not know that my previous patch was merged, also into all
those stable branches, and some with kind minor modifications...  Is
it the case that I only need to firstly revert that commit in
mips-upstream-sfr/mips-for-linux-next, then followed by refreshed
version of this one?

Regards,

               yousong
