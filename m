Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 07:05:43 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:61079 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeHTFFivcmLf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 07:05:38 +0200
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7K5555b021216;
        Mon, 20 Aug 2018 14:05:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7K5555b021216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534741506;
        bh=hbciLnwL1dMBpD4IgNwhSBhkiWcIdxbOB0Tbbf/varg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lGaX4UvIIRWxye3ne8Lm+ta9XR66iVXfKM+uNNETv8LKkhqolxh2RAGtxAO1TQYeH
         AR05hGJJrIWpRz/DC6LEd5yqQ/QsuEoMS0fr6gVTg1gGMd0gYBvbRPCE35sGuC5R8V
         GmPUf79BJSMVkBD9basF2/jn72H86S8E+R++0m0HX6ohn91DDoPezTw1a3a3oeAYx3
         d+JVnoNSw7zKZa2B+npq0AhiI5yIWObjDeK6qUz1Gvqd6kjl3Ca5lHYf+KNzuqlYcZ
         4Ude33/DghT7gzI/7HmI5t8X31/53E9GAUE1aO02BpmvxzVH2K5Te5EkqbSQc0vkh+
         gkDucuef8P75g==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id k25-v6so8976527uao.11;
        Sun, 19 Aug 2018 22:05:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlESqi1YA+sYw9QEp7LLbq2YxUCaYqNWPtKLld9bEU7rCnTjSCi3
        GSyrXS+6HUh++1LtRpsWvMRDsexlDGgErq98TAA=
X-Google-Smtp-Source: AA+uWPx0lWT1u3CukVgeTlNb8EEAOy7Pzsi77kW5r9RsrU7fSzIFL1jd1sX2Os6CJpbJd8SKDIe4UQdZxKKDiJJLYZk=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr28686756uac.135.1534741505087;
 Sun, 19 Aug 2018 22:05:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:04:24
 -0700 (PDT)
In-Reply-To: <20180818181017.1246-2-paul.burton@mips.com>
References: <20180818181017.1246-1-paul.burton@mips.com> <20180818181017.1246-2-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 20 Aug 2018 14:04:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
Message-ID: <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kbuild: Allow asm-specific compiler_types.h
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65647
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

Hi Paul,


2018-08-19 3:10 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> We have a need to override the definition of
> barrier_before_unreachable() for MIPS, which means we either need to add
> architecture-specific code into linux/compiler-gcc.h or we need to allow
> the architecture to provide a header that can define the macro before
> the generic definition. The latter seems like the better approach.
>
> A straightforward approach to the per-arch header is to make use of
> asm-generic to provide a default empty header & adjust architectures
> which don't need anything specific to make use of that by adding the
> header to generic-y. Unfortunately this doesn't work so well due to
> commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> cflags using the -include compiler flag.
>
> Because the -include flag is present for all C files we compile, we need
> the architecture-provided header to be present before any C files are
> compiled. If any C files can be compiled prior to the asm-generic header
> wrappers being generated then we hit a build failure due to missing
> header. Such cases do exist - one pointed out by the kbuild test robot
> is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
> of the archprepare target [1].
>
> This leaves us with a few options:
>
>   1) Use generic-y & fix any build failures we find by enforcing
>      ordering such that the asm-generic target occurs before any C
>      compilation, such that linux/compiler_types.h can always include
>      the generated asm-generic wrapper which in turn includes the empty
>      asm-generic header. This would rely on us finding all the
>      problematic cases - I don't know for sure that the ia64 issue is
>      the only one.
>
>   2) Add an actual empty header to each architecture, so that we don't
>      need the generated asm-generic wrapper. This seems messy.
>
>   3) Give up & add #ifdef CONFIG_MIPS or similar to
>      linux/compiler_types.h. This seems messy too.
>
>   4) Include the arch header only when it's actually needed, removing
>      the need for the asm-generic wrapper for all other architectures.
>
> This patch allows us to use approach 4, by including an
> asm/compiler_types.h header using the -include flag in the same way we
> do for linux/compiler_types.h, but only if the header actually exists.


I agree with the approach 4),
but I am of two minds about how to implement it.


I guess the cost of evaluating 'wildcard' for each C file
is unnoticeable level, but I am slightly in favor of
including <asm/compilr_types.h> from <linux/compiler_types.h>
conditionally.

I am not sure about the CONFIG name, but for example, like this.

#ifdef CONFIG_HAVE_ARCH_COMPILER_TYPES
#include <asm/compiler_types.h>
#endif


What do you think?






> [1] https://lists.01.org/pipermail/kbuild-all/2018-August/051175.html
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
>
> ---
> Any thoughts anyone?
>
> This isn't the prettiest it could possibly be but it's a small change &
> clearly shouldn't break anything, which are good qualities for a patch
> fixing build failures that we'd ideally backport as far as 4.16.
>
> Changes in v8:
> - New patch.
>
>  scripts/Makefile.lib | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 1bb594fcfe12..4e7b41ef029b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -151,8 +151,11 @@ __a_flags  = $(call flags,_a_flags)
>  __cpp_flags     = $(call flags,_cpp_flags)
>  endif
>
> +c_includes     = $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/compiler_types.h)
> +c_includes     += $(srctree)/include/linux/compiler_types.h
> +
>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
> -                -include $(srctree)/include/linux/compiler_types.h       \
> +                $(addprefix -include ,$(c_includes))                     \
>                  $(__c_flags) $(modkern_cflags)                           \
>                  $(basename_flags) $(modname_flags)
>
> --
> 2.18.0
>



-- 
Best Regards
Masahiro Yamada
