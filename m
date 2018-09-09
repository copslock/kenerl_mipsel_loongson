Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 01:28:54 +0200 (CEST)
Received: from conssluserg-03.nifty.com ([210.131.2.82]:56811 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991783AbeIIX2t1jnyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 01:28:49 +0200
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w89NSGFw030096;
        Mon, 10 Sep 2018 08:28:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w89NSGFw030096
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536535697;
        bh=N+5foY4FYhCwfK45DpdtSxm1jxDyDeZh25ehdDTVoeg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=V9S70itt6538cyhhapUYPCVJQig+AEKzm1QicE2IAUz0M+UCxNZSl8dl77dNVrPl1
         BlGIH3BfL4T+sh1DxhkwR9ECgoFOW72LgYb1ftVfPMd8VZsCD81jjTDjZYrg/yaE0Y
         8S1NzLnuEaD4p858c2j8tSn00efty+LakXOik4N5U818lcXCzCFkWMKNXvGkVxwO0S
         N5GlKQvGoWN9SrzT8Wr5rJ3PWMzEaftVTs0/D1ZzjveFkpQ23dHgGay92iNNEva3Ep
         1LncZWDnBNSLXO6W2hO9RvaAoKsH8YAa0H3vgc90L5fu4A1Nl6KZ6iBB4EQUpGs9JJ
         JAlGa3BXKjCtA==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id u11-v6so15896141uan.13;
        Sun, 09 Sep 2018 16:28:17 -0700 (PDT)
X-Gm-Message-State: APzg51APzF4N+OMF/XrkByxMmvO1QgkU9JNNAp4midEpFg/OdZEwjHsQ
        +C1yPn+qE0RzDOV1vLlBOabjadjLzK1w7URaLZc=
X-Google-Smtp-Source: ANB0VdZhyfVKRTJuL747lHRE6ThtXvkb7VoNRzU+D7GFhTtZD4DKFeD/6Cx1uCkPXQzRVSNju31SmBpH5ONrGBlbLGU=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr6238843uag.16.1536535695985;
 Sun, 09 Sep 2018 16:28:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 9 Sep 2018 16:27:35 -0700 (PDT)
In-Reply-To: <20180905235327.5996-7-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org> <20180905235327.5996-7-robh@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 10 Sep 2018 08:27:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
Message-ID: <CAK7LNAS5uEUMDpL8oCJmFWKu1YF8tof5d=2h8jzt-MLHGAEAhg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66166
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

2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
>
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
>
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-mips@linux-mips.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack so I can take the whole series via the DT tree.
>
> v2:
>  - Fix $arch/boot/dts path check for out of tree builds
>  - Fix dtc dependency for building built-in dtbs
>  - Fix microblaze built-in dtb building
>
>  Makefile                          | 32 +++++++++++++++++++++++++++++++
>  arch/arc/Makefile                 |  6 ------
>  arch/arm/Makefile                 | 20 +------------------
>  arch/arm64/Makefile               | 17 +---------------
>  arch/c6x/Makefile                 |  2 --
>  arch/h8300/Makefile               | 11 +----------
>  arch/microblaze/Makefile          |  4 +---
>  arch/microblaze/boot/dts/Makefile |  2 ++
>  arch/mips/Makefile                | 15 +--------------
>  arch/nds32/Makefile               |  2 +-
>  arch/nios2/Makefile               |  7 -------
>  arch/nios2/boot/Makefile          |  4 ----
>  arch/powerpc/Makefile             |  3 ---
>  arch/xtensa/Makefile              | 12 +-----------
>  scripts/Makefile.lib              |  2 +-
>  15 files changed, 42 insertions(+), 97 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2b458801ba74..bc18dbbc16c5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1212,6 +1212,32 @@ kselftest-merge:
>                 $(srctree)/tools/testing/selftests/*/config
>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>
> +# ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree := arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +
> +%.dtb %.dtb.S %.dtb.o: | dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@


Hmm, I was worried about '%.dtb.o: | dtc'
but seems working.

Compiling %.S -> %.o requires objtool for x86,
but x86 does not support DT.

If CONFIG_MODVERSIONS=y, scripts/genksyms/genksyms is required,
%.dtb.S does not contain EXPORT_SYMBOL.


BTW, 'dtc' should be a PHONY target.



-- 
Best Regards
Masahiro Yamada
