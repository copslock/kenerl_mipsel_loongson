Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Jun 2018 09:55:31 +0200 (CEST)
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31809 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeFBHzW2DD75 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Jun 2018 09:55:22 +0200
Received: from mail-ua0-f173.google.com (mail-ua0-f173.google.com [209.85.217.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w527sT1u009595;
        Sat, 2 Jun 2018 16:54:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w527sT1u009595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1527926070;
        bh=5A9S+PR/n9S7v5bfEEHf0oEK5Kh+aYqMilWTOt+7sF8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=J52rK8m9cdX8L3T6SaiwOtEolCK5yLYzgi2GY9qEPIbeRmSfwnG+AcC3qre1lFtj9
         wOqWSt2SV132aOLOz/gv9LHV20SLzW06+YkZstLKFdhhcW5H1fIyY+kFNvqbJGNqkG
         ONU4+QGPzpJ8mWN9/DgWJoRkcV3cFdqS9gjbZ0fOxPmk5TpW2NPunK5/1QEtbmw4Bv
         EwsIYtOir7la4ZaEHawdHHJHeJ6dZlO3sUSSlpT7ySXroUvYYFioVX3bNsyIkdJfPo
         zujeJPLpEl3qfMyMaOCJzqjhNb3KXuvQf/dagi0VskhTehHVS2ApJNj4YZRamJufMo
         PEKrwrguqopzA==
X-Nifty-SrcIP: [209.85.217.173]
Received: by mail-ua0-f173.google.com with SMTP id x18-v6so12137911uaj.9;
        Sat, 02 Jun 2018 00:54:30 -0700 (PDT)
X-Gm-Message-State: APt69E2dIyeBm4XNZTupwPbKHUeqJ+rrl2iNzjaV4eSAV1L5Iclx3R/2
        W62RGeQw42PwPWH3PgYT4JMql7vKkqvJBJSB/Gs=
X-Google-Smtp-Source: ADUXVKI9GFXAKRVBIZwN+ouIczzzu2aLW8l3jReoTQLLx1EjNM4YR8kFxZ8mqkmUBN/ODoPHlT6VcZsJc79IoZL84xA=
X-Received: by 2002:ab0:5061:: with SMTP id z30-v6mr5577236uaz.82.1527926068831;
 Sat, 02 Jun 2018 00:54:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 2 Jun 2018 00:53:48 -0700 (PDT)
In-Reply-To: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 2 Jun 2018 16:53:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGYhAGbHbVzb+bbnpOsh2Vvt-C0cYpzu55b0PS-Oqc4Q@mail.gmail.com>
Message-ID: <CAK7LNASGYhAGbHbVzb+bbnpOsh2Vvt-C0cYpzu55b0PS-Oqc4Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        linux-parisc@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64148
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

2018-05-31 5:48 GMT+09:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> By default, sparse assumes a 64bit machine when compiled on x86-64
> and 32bit when compiled on anything else.
>
> This can of course create all sort of problems for the other archs, like
> issuing false warnings ('shift too big (32) for type unsigned long'), or
> worse, failing to emit legitimate warnings.
>
> Fix this by adding the -m32/-m64 flag, depending on CONFIG_64BIT,
> to CHECKFLAGS in the main Makefile (and so for all archs).
> Also, remove the now unneeded -m32/-m64 in arch specific Makefiles.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---

Fixed CHEKCFLAGS -> CHECKFLAGS
and applied to linux-kbuild.  Thanks!



>  Makefile             | 3 +++
>  arch/alpha/Makefile  | 2 +-
>  arch/arm/Makefile    | 2 +-
>  arch/arm64/Makefile  | 2 +-
>  arch/ia64/Makefile   | 2 +-
>  arch/mips/Makefile   | 3 ---
>  arch/parisc/Makefile | 2 +-
>  arch/sparc/Makefile  | 2 +-
>  arch/x86/Makefile    | 2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6c6610913..18379987c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -881,6 +881,9 @@ endif
>  # insure the checker run with the right endianness
>  CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
>
> +# the checker needs the correct machine size
> +CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)
> +
>  # Default kernel image to build when no specific target is given.
>  # KBUILD_IMAGE may be overruled on the command line or
>  # set in the environment
> diff --git a/arch/alpha/Makefile b/arch/alpha/Makefile
> index 2cc3cc519..c5ec8c09c 100644
> --- a/arch/alpha/Makefile
> +++ b/arch/alpha/Makefile
> @@ -11,7 +11,7 @@
>  NM := $(NM) -B
>
>  LDFLAGS_vmlinux        := -static -N #-relax
> -CHECKFLAGS     += -D__alpha__ -m64
> +CHECKFLAGS     += -D__alpha__
>  cflags-y       := -pipe -mno-fp-regs -ffixed-8
>  cflags-y       += $(call cc-option, -fno-jump-tables)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e4e537f27..f32a5468d 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -135,7 +135,7 @@ endif
>  KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
>  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
>
> -CHECKFLAGS     += -D__arm__ -m32
> +CHECKFLAGS     += -D__arm__
>
>  #Default value
>  head-y         := arch/arm/kernel/head$(MMUEXT).o
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 87f7d2f9f..3c353b471 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -78,7 +78,7 @@ LDFLAGS               += -maarch64linux
>  UTS_MACHINE    := aarch64
>  endif
>
> -CHECKFLAGS     += -D__aarch64__ -m64
> +CHECKFLAGS     += -D__aarch64__
>
>  ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
>  KBUILD_LDFLAGS_MODULE  += -T $(srctree)/arch/arm64/kernel/module.lds
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index 2dd7f519a..45f59808b 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -18,7 +18,7 @@ READELF := $(CROSS_COMPILE)readelf
>
>  export AWK
>
> -CHECKFLAGS     += -m64 -D__ia64=1 -D__ia64__=1 -D_LP64 -D__LP64__
> +CHECKFLAGS     += -D__ia64=1 -D__ia64__=1 -D_LP64 -D__LP64__
>
>  OBJCOPYFLAGS   := --strip-all
>  LDFLAGS_vmlinux        := -static
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 5e9fce076..e2122cca4 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -309,9 +309,6 @@ ifdef CONFIG_MIPS
>  CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
>         egrep -vw '__GNUC_(|MINOR_|PATCHLEVEL_)_' | \
>         sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
> -ifdef CONFIG_64BIT
> -CHECKFLAGS             += -m64
> -endif
>  endif
>
>  OBJCOPYFLAGS           += --remove-section=.reginfo
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 348ae4779..714284ea6 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -28,7 +28,7 @@ export LIBGCC
>
>  ifdef CONFIG_64BIT
>  UTS_MACHINE    := parisc64
> -CHECKFLAGS     += -D__LP64__=1 -m64
> +CHECKFLAGS     += -D__LP64__=1
>  CC_ARCHES      = hppa64
>  LD_BFD         := elf64-hppa-linux
>  else # 32-bit
> diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> index edac927e4..966a13d2b 100644
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -39,7 +39,7 @@ else
>  # sparc64
>  #
>
> -CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
> +CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__
>  LDFLAGS       := -m elf64_sparc
>  export BITS   := 64
>  UTS_MACHINE   := sparc64
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 60135cbd9..f0a6ea224 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -94,7 +94,7 @@ ifeq ($(CONFIG_X86_32),y)
>  else
>          BITS := 64
>          UTS_MACHINE := x86_64
> -        CHECKFLAGS += -D__x86_64__ -m64
> +        CHECKFLAGS += -D__x86_64__
>
>          biarch := -m64
>          KBUILD_AFLAGS += -m64
> --
> 2.17.0
>



-- 
Best Regards
Masahiro Yamada
