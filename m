Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 17:22:22 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:54592 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491168Ab0HRPWR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Aug 2010 17:22:17 +0200
Received: by qwe4 with SMTP id 4so656932qwe.36
        for <multiple recipients>; Wed, 18 Aug 2010 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0XZmn4fu07WnVqtWvtz2aQ3MaSUWN6pYO3VGCUp63hE=;
        b=yIckD3j+LgmUAccT5nqOoV7izZ3aiGEF5cXIhoJFZLdgKJC7JRMlaEL9T9PDA/oDr3
         3jE/CNU/xyKmqbkRj1EumMZ32H2L/JVkqcFHc0bKaBckmgVkiUkqE4M+Qink6r6GnGwB
         9HxKJaMToydF2y4zOER0P9jpEkvdk31hfVnXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dPY1o+aSazBqqzPtINm8BQ1SHXtXv/j7R9ixzTZ0p7j7f4fWbTOYtoCEN8pGbGUlwl
         z7XKPlzptu7UNSfkaoSR244MaOyXzor+DCaO05JULqIdiUx9le2r3juuiGDADFHRoiJV
         zJ59ZVjw830HHU/z83nUCVcS/y7ECtvQe6gik=
MIME-Version: 1.0
Received: by 10.224.19.17 with SMTP id y17mr5450677qaa.374.1282144931569; Wed,
 18 Aug 2010 08:22:11 -0700 (PDT)
Received: by 10.229.20.129 with HTTP; Wed, 18 Aug 2010 08:22:11 -0700 (PDT)
In-Reply-To: <20100818144301.GC2849@linux-mips.org>
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>
        <20100818133336.GA25740@linux-mips.org>
        <AANLkTin8LLH3DkX38B93Ap0mmz4hb9e=cEo9U3ZKmavr@mail.gmail.com>
        <20100818144301.GC2849@linux-mips.org>
Date:   Wed, 18 Aug 2010 20:52:11 +0530
Message-ID: <AANLkTi=zfuEvKCLBj7xuVnjdZXZZ63i2xvVZHKeby+BN@mail.gmail.com>
Subject: Re: kmalloc issue on MIPS target
From:   naveen yadav <yad.naveen@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I understand that that I need to make kmalloc.h in my arch specific
folder. But I could not get answer, what should be appropriate
value of  ARCH_KMALLOC_MINALIGN  is it 32 or 128 ?


Thanks.

On Wed, Aug 18, 2010 at 8:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Aug 18, 2010 at 07:56:16PM +0530, naveen yadav wrote:
>
>> I will give more info.
>>
>> CONFIG_MIPS_L1_CACHE_SHIFT=5
>>
>> CONFIG_DMA_NONCOHERENT=y
>>
>> mips 34kc is processor
>>
>> and File we are using is  arch/mips/include/asm/mach-generic/kmalloc.h
>>
>> #ifndef __ASM_MACH_GENERIC_KMALLOC_H
>> #define __ASM_MACH_GENERIC_KMALLOC_H
>>
>>
>> #ifndef CONFIG_DMA_COHERENT
>> /*
>>  * Total overkill for most systems but need as a safe default.
>>  * Set this one if any device in the system might do non-coherent DMA.
>>  */
>> #define ARCH_KMALLOC_MINALIGN   128
>> #endif
>>
>> #endif /* __ASM_MACH_GENERIC_KMALLOC_H */
>>
>>
>> So shall we make value ARCH_KMALLOC_MINALIGN   from 128 to 32. is
>> there any problem ?
>
> No, that's just what you should do.  You do that by putting a file
> that defines ARCH_KMALLOC_MINALIGN into your platforms's
> arch/mips/include/asm/mach-<yourplatform>/kmalloc.h just like the ip32
> file from your original posting.
>
>  Ralf
>
