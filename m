Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2018 01:22:30 +0200 (CEST)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29203 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994687AbeFTXWYNop33 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Jun 2018 01:22:24 +0200
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w5KNLgmo030165
        for <linux-mips@linux-mips.org>; Thu, 21 Jun 2018 08:21:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w5KNLgmo030165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529536903;
        bh=BvjvEwsCKwteznCw+J7EKVMYt10HGvefYc/aHObNGQA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=1KrV2lRBZYSAMSAdo1pjeJEBopT2ygXvGHz/lF6BQqU7IXwbSRGERKJHhuQt7QoNn
         pvIx5PBMXmimnDgRzFuxTnb1oLaMpjqcLfnQIzGG9hSWhW3c0YtVdxJZVNRx9Py3QU
         NhqscH3BlSy6lAzKFSr/H6zL6u1lzLw0AcED9XaooveWQqf8qFE/49pP19wDFG5Fmn
         vCLuEJkc55u16zHu1uowh8w/h+jj8efTn/dFditWHT1OVjgqyov3MyqT4L3ucGMxLI
         yU6mf7Ejw2Q4i8ae1tsy9EidJp9AoZLTlkatDnjvDQ4HRFY6iKfIq1l6oaJSi1J76+
         NnX58aw4e1P1A==
X-Nifty-SrcIP: [209.85.213.54]
Received: by mail-vk0-f54.google.com with SMTP id b134-v6so752615vke.13
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2018 16:21:43 -0700 (PDT)
X-Gm-Message-State: APt69E3WxAokDHJzGYIfJoqECX+ltUfYnKhgflbngAKsja3tjSbhGfrZ
        G+QSK8JR1c2loYdhEwnzWGNv0rRfMnFXDkIKuPM=
X-Google-Smtp-Source: ADUXVKK8VDo10H+/qDD44PBh51+5R2N1idb5nT+dcqk0wRMp3DXbMsa1hKkUo4LNme8GCn2Rmmgr6AC3X46TaKRT27k=
X-Received: by 2002:a1f:b143:: with SMTP id a64-v6mr13458964vkf.65.1529536902208;
 Wed, 20 Jun 2018 16:21:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:1ec1:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:21:01
 -0700 (PDT)
In-Reply-To: <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
References: <20180616005323.7938-1-paul.burton@mips.com> <20180616005323.7938-2-paul.burton@mips.com>
 <CAK7LNASvCha27kU4ipn23uOpNuxkzJrNzWBwYcxN4n=3xtv8SA@mail.gmail.com> <20180619190225.7eguhiw3ixaiwpgl@pburton-laptop>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Jun 2018 08:21:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRu0p8_8DqEdmUUPfc4gC60SSj90vTpz3iKaiE596-TA@mail.gmail.com>
Message-ID: <CAK7LNAQRu0p8_8DqEdmUUPfc4gC60SSj90vTpz3iKaiE596-TA@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: add macro for controlling warnings to linux/compiler.h
To:     Paul Burton <paul.burton@mips.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Thomas Gleixner <tglx@linutronix.de>,
        Douglas Anderson <dianders@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        He Zhe <zhe.he@windriver.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Khem Raj <raj.khem@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Gideon Israel Dsouza <gidisrael@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64404
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

2018-06-20 4:02 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> Hi Masahiro,
>
> On Wed, Jun 20, 2018 at 02:34:35AM +0900, Masahiro Yamada wrote:
>> 2018-06-16 9:53 GMT+09:00 Paul Burton <paul.burton@mips.com>:
>> > diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> > index f1a7492a5cc8..aba64a2912d8 100644
>> > --- a/include/linux/compiler-gcc.h
>> > +++ b/include/linux/compiler-gcc.h
>> > @@ -347,3 +347,69 @@
>> >  #if GCC_VERSION >= 50100
>> >  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>> >  #endif
>> > +
>> > +/*
>> > + * turn individual warnings and errors on and off locally, depending
>> > + * on version.
>> > + */
>> > +#define __diag_GCC(version, s) __diag_GCC_ ## version(s)
>> > +
>> > +#if GCC_VERSION >= 40600
>> > +#define __diag_str1(s) #s
>> > +#define __diag_str(s) __diag_str1(s)
>> > +#define __diag(s) _Pragma(__diag_str(GCC diagnostic s))
>> > +
>> > +/* compilers before gcc-4.6 do not understand "#pragma GCC diagnostic push" */
>> > +#define __diag_GCC_4_6(s) __diag(s)
>> > +#else
>> > +#define __diag(s)
>> > +#define __diag_GCC_4_6(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 40700
>> > +#define __diag_GCC_4_7(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_4_7(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 40800
>> > +#define __diag_GCC_4_8(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_4_8(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 40900
>> > +#define __diag_GCC_4_9(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_4_9(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 50000
>> > +#define __diag_GCC_5(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_5(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 60000
>> > +#define __diag_GCC_6(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_6(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 70000
>> > +#define __diag_GCC_7(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_7(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 80000
>> > +#define __diag_GCC_8(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_8(s)
>> > +#endif
>> > +
>> > +#if GCC_VERSION >= 90000
>> > +#define __diag_GCC_9(s) __diag(s)
>> > +#else
>> > +#define __diag_GCC_9(s)
>> > +#endif
>>
>>
>> Hmm, we would have to add this for every release.
>
> Well, strictly speaking only ones that we need to modify diags for - ie.
> in this series we could get away with only adding the GCC 8 macro if we
> wanted.
>
>> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> > index 6b79a9bba9a7..313a2ad884e0 100644
>> > --- a/include/linux/compiler_types.h
>> > +++ b/include/linux/compiler_types.h
>> > @@ -271,4 +271,22 @@ struct ftrace_likely_data {
>> >  # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
>> >  #endif
>> >
>> > +#ifndef __diag
>> > +#define __diag(string)
>> > +#endif
>> > +
>> > +#ifndef __diag_GCC
>> > +#define __diag_GCC(string)
>> > +#endif
>>
>> __diag_GCC() takes two arguments,
>> so it should be:
>>
>> #ifndef __diag_GCC
>> #define __diag_GCC(version, s)
>> #endif
>>
>>
>> Otherwise, this would cause warning like this:
>>
>>
>> arch/arm64/kernel/sys.c:40:1: error: macro "__diag_GCC" passed 2
>> arguments, but takes just 1
>>  SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>>  ^~~~~~~~~~
>
> Yes, good catch.
>
>> > +#define __diag_push()  __diag(push)
>> > +#define __diag_pop()   __diag(pop)
>> > +
>> > +#define __diag_ignore(compiler, version, option, comment) \
>> > +       __diag_ ## compiler(version, ignored option)
>> > +#define __diag_warn(compiler, version, option, comment) \
>> > +       __diag_ ## compiler(version, warning option)
>> > +#define __diag_error(compiler, version, option, comment) \
>> > +       __diag_ ## compiler(version, error   option)
>> > +
>>
>> To me, it looks like this is putting GCC/Clang specific things
>> in the common file, <linux/compiler_types.h> .
>>
>> All compilers must use "ignored", "warning", "error",
>> not allowed to use "ignore".
>
> We could move that to linux/compiler-gcc.h pretty easily.
>
>> I also wonder if we could avoid proliferating __diag_GCC_*.
>
> My thought is that it's unlikely we'll ever support enough different
> compilers for it to become problematic to list the ones we modify
> warnings for in linux/compiler_types.h.
>
>> I attached a bit different implementation below.
>>
>> I used -Wno-pragmas to avoid unknown option warnings.
>
> That doesn't seem very clean to me because it will hide typos or other
> mistakes. One advantage of Arnd's patch is that by specifying the
> compiler & version we only attempt to use pragmas that are appropriate
> so we don't need to ignore unknown ones.
>
>> Usage is
>>
>>        __diag_push();
>>        __diag_ignore(-Wattribute-alias,
>>                      "Type aliasing is used to sanitize syscall arguments");
>>               ...
>>        __diag_pop();
>>
>> Comments, ideas are appreciated.
>
> By removing the compiler & version arguments you're enforcing that if we
> ignore a warning for one compiler we must ignore it for all, regardless
> of whether it's problematic. This essentially presumes that warnings
> with the same name will behave the same across compilers, which feels
> worse to me than having users of this explicitly state which compilers
> need the pragmas.



Fair enough.

V2 is good except one nit.
(I left a comment in it)


I can fix it up locally
if it is tedious to re-spin, though.





> Thanks,
>     Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
