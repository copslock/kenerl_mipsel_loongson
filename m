Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2018 04:51:04 +0200 (CEST)
Received: from conssluserg-04.nifty.com ([210.131.2.83]:55803 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990393AbeHUCu70KjAu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2018 04:50:59 +0200
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7L2oTxq019306;
        Tue, 21 Aug 2018 11:50:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7L2oTxq019306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534819830;
        bh=2SnKKCgOxkdWjMCE667kGEvM+4IJy+haEWj5gaMpkP4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=mT88LcgEBvKTBZBElAAzR24aBR2lfKs5C0Y5KTnjr4g/9WrY+SKhFelkV07Msjjhx
         u1vsplU43Q12Ajb2SJpsKEfrPEP0rMsZdT6VZpqtXkwHZ744vEXmSoCQbLqaz99czO
         R1FFNPDjWhuHPpOAiQUsF5VBWurNgW3aaXchS4yyDmCBpOk0EDRjSF9g3lZ+bNxSkv
         3BQA3KWp3VR1OfGdxVqFL7tGgot4GlfYlG2ugV/2fU0b2nCzdbfeK1JE1rUISsHDN+
         YO+niYfPKXCWppwHnGS8C4FZPtFbYiHJAr0b8w7dxXS3QXwVDHhLBzlCMNpE6V+/vV
         CN5KcsTN9e1dQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id l2-v6so689343uaf.11;
        Mon, 20 Aug 2018 19:50:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlE58UlEb7v73fhSv0J+uW66sRZ23SCXAFaco7849BdFT+YzBiaz
        lwDl7Dm/LA0PL15hoJwXl+Ve6VT53t/BTwhNtAk=
X-Google-Smtp-Source: AA+uWPwojYDKQLRCGw0l2JeJoAH5jj/ORDwI25zHA3O7XFy7KuEhoWccv3I2kZd1a9gdPuBQMu0nFs+H9yludInQnMk=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr32207073uag.16.1534819828641;
 Mon, 20 Aug 2018 19:50:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 19:49:48
 -0700 (PDT)
In-Reply-To: <20180820223618.22319-2-paul.burton@mips.com>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com> <20180820223618.22319-2-paul.burton@mips.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 11:49:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
Message-ID: <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] kbuild: Allow arch-specific asm/compiler.h
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
X-archive-position: 65670
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


The code diff looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Just comments in the commit description.   See below.


2018-08-21 7:36 GMT+09:00 Paul Burton <paul.burton@mips.com>:
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


I doubt this statement.

Commit a95b37e20db9 is not the cause of the problem.

include/linux/kconfig.h is also included
by using the -include compiler flag.


See the top-level Makefile.

USERINCLUDE    := \
                -I$(srctree)/arch/$(SRCARCH)/include/uapi \
                -I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
                -I$(srctree)/include/uapi \
                -I$(objtree)/include/generated/uapi \
                -include $(srctree)/include/linux/kconfig.h


So, <linux/compiler_types.h> (then, <asm/compiler.h>)
would be also required for all C files
in the archprepare stage regardless of commit a95b37e20db9.


The change happened in commit 28128c61e08e.



One more thing, you are not touching any makefile in this version.

Maybe, you can prefix the subject with "compiler.h:" or something
instead of "kbuild:".





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
> This patch allows us to use approach 4, by including an asm/compiler.h
> header from linux/compiler_types.h after the inclusion of the
> compiler-specific linux/compiler-*.h header(s). We do this
> conditionally, only when CONFIG_HAVE_ARCH_COMPILER_H is selected, in
> order to avoid the need for asm-generic wrappers & the associated build
> ordering issue described above. The asm/compiler.h header is included
> after the generic linux/compiler-*.h header(s) for consistency with the
> way linux/compiler-intel.h & linux/compiler-clang.h are included after
> the linux/compiler-gcc.h header that they override.
>
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
