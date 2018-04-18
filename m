Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2018 03:53:58 +0200 (CEST)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:23727 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994656AbeDRBxuz72LL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2018 03:53:50 +0200
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w3I1r4wh004947;
        Wed, 18 Apr 2018 10:53:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w3I1r4wh004947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1524016385;
        bh=tcGxFhVMGn4vUz1YfYsKeQJe1pGxVU7jPw4aM19uL4I=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gCcW4auCMhBgaOwuIqefHPNdQX8c8G+NYulB32pID8/7m4omXBb7m+U2DaKezDmAt
         rF4/P+T6nON/29xTRDOek76tl2ueweOhZUmP5h5ZrmbSCfkMRDDqN8ygq+BrSJ4qjm
         Lg7L31qHruA63xZ3rIwFt0T62tlec34ThFN49FIFpoh9us870OtSQUsQexmjUVQecf
         saU/PGkHGvCCl96j0umCjeWUF6NUcYGU5d5mkJJKR/fxFliVwtPtm4U+xH9/jN+aZG
         PWZFmDCAPVr4T6tA1lUthfxYEeSCIUKs3COe9mNc26IByvXTaPePaFSwrf/wdx5KKw
         /aConlsSWUqJA==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id d9so99757vka.4;
        Tue, 17 Apr 2018 18:53:05 -0700 (PDT)
X-Gm-Message-State: ALQs6tDjoSA3a+FZtt1g4z1qTHvAnx4D4MJ2AOXXRHzgtqYs0c4zVL75
        5AGF9jRuyRWvqx2VxMx0Dy08t5DS9urq3GXR7d8=
X-Google-Smtp-Source: AIpwx4+24HNJTj44l56THcJNiymJ4YkVkLjkxX6dAQ8eZoK/Z1kmEJweJqS6JRVqp7DgERFd0GduMYrRF1EHxgnD4zM=
X-Received: by 10.31.157.194 with SMTP id g185mr99737vke.11.1524016384200;
 Tue, 17 Apr 2018 18:53:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.85.216 with HTTP; Tue, 17 Apr 2018 18:52:23 -0700 (PDT)
In-Reply-To: <20180417230921.GA29046@saruman>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
 <1523433019-17419-3-git-send-email-matt.redfearn@mips.com> <20180417230921.GA29046@saruman>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Apr 2018 10:52:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLPT4jiPiNJ5aDXg-kR70jN1zZbbLQqyO53DtsEgYVAw@mail.gmail.com>
Message-ID: <CAK7LNASLPT4jiPiNJ5aDXg-kR70jN1zZbbLQqyO53DtsEgYVAw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] MIPS: vmlinuz: Use generic ashldi3
To:     James Hogan <jhogan@kernel.org>
Cc:     Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

2018-04-18 8:09 GMT+09:00 James Hogan <jhogan@kernel.org>:
> On Wed, Apr 11, 2018 at 08:50:18AM +0100, Matt Redfearn wrote:
>> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> index adce180f3ee4..e03f522c33ac 100644
>> --- a/arch/mips/boot/compressed/Makefile
>> +++ b/arch/mips/boot/compressed/Makefile
>> @@ -46,9 +46,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>>
>>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>>
>> -extra-y += ashldi3.c bswapsi.c
>> -$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
>> -$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>> +extra-y += ashldi3.c
>> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
>> +     $(call cmd,shipped)
>> +
>> +extra-y += bswapsi.c
>> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>>       $(call cmd,shipped)
>
> ci20_defconfig:
>
> arch/mips/boot/compressed/ashldi3.c:4:10: fatal error: libgcc.h: No such file or directory
>  #include "libgcc.h"
>            ^~~~~~~~~~
>
> It looks like it had already copied ashldi3.c from arch/mips/lib/ when
> building an older commit, and it hasn't been regenerated from lib/ since
> the Makefile changed, so its still using the old version.
>
> I think it should be using FORCE and if_changed like this:
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index e03f522c33ac..abe77add8789 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -47,12 +47,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>
>  extra-y += ashldi3.c
> -$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
> -       $(call cmd,shipped)
> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c FORCE
> +       $(call if_changed,shipped)
>
>  extra-y += bswapsi.c
> -$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
> -       $(call cmd,shipped)
> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c FORCE
> +       $(call if_changed,shipped)
>
>  targets := $(notdir $(vmlinuzobjs-y))
>
> That resolves the build failures when checking out old -> new without
> cleaning, since the .ashldi3.c.cmd is missing so it gets rebuilt.
>
> It should also resolve issues if the path it copies from is updated in
> future since the .ashldi3.c.cmd will get updated.
>
> If you checkout new -> old without cleaning, the now removed
> arch/mips/lib/ashldi3.c will get added which will trigger regeneration,
> so it won't error.
>
> However if you do new -> old -> new then the .ashldi3.cmd file isn't
> updated while at old, so you get the same error as above. I'm not sure
> there's much we can practically do about that, aside perhaps avoiding
> the issue in future by somehow auto-deleting stale .*.cmd files.
>
> Cc'ing kbuild folk in case they have any bright ideas.



I do not have any idea better than if_changed.




> At least the straightforward old->new upgrade will work with the above
> fixup though. If you're okay with it I'm happy to apply as a fixup.
>






-- 
Best Regards
Masahiro Yamada
