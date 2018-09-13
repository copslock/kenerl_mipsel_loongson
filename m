Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Sep 2018 17:52:18 +0200 (CEST)
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44314 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994074AbeIMPwPM7U4R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Sep 2018 17:52:15 +0200
Received: by mail-ua1-f65.google.com with SMTP id m11-v6so5058419uao.11;
        Thu, 13 Sep 2018 08:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wicypxViE8mY/8NOavSFvHsNXSuFZqLcaT4oAzQEvKE=;
        b=dWxWHnbIKpoWSv5HG56kkOMsCvC5zFnA7yX66vbHDhMDPJI8360/TstbWpZ3wclYKT
         dERgW8NdRBDIkRdMTufTnxHlL4UTLAuyKQaZxhucgxvZnehHH1BHzcUyMd60/LEgyLiS
         wdCftK53lgxCDzVOoK14WOON2OT9Og9unuSko4VAstndSyRxqZ61UsQ2y9odI2rxGiIY
         +Uk8sZewQ78qcZhQHCqyTU3+E6zfWDtqqQ7CBd+ZYTq27286fVLsegnBuQC9dpWPckL4
         BlHgdeFvI0ENDEsPG9WgiLYm96sAN1abPSz7fqhJ556ajD2lOZ0JYCpAoPko6t73rX1f
         Uf0w==
X-Gm-Message-State: APzg51CLwJ50qQJPJncTplq4sS8Rrflnaj9U+0uZ7YzdrCx67/ciJZVS
        az2st/S62PmbiKow9J1CiAvq4LP93mxVpCFr9qY=
X-Google-Smtp-Source: ANB0VdY53mIbH7fZWB8C3+UdHhzYwf41w9YhNWlQ7u40qeqj8HtNsfvdp0qnCV9E5PlAhnDsujMEiWq8B1cZdD95OCo=
X-Received: by 2002:a67:6908:: with SMTP id e8-v6mr2868548vsc.21.1536853928110;
 Thu, 13 Sep 2018 08:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com> <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
In-Reply-To: <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Sep 2018 17:51:55 +0200
Message-ID: <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>, ley.foon.tan@intel.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Yamada-san,

On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
> >> There is nothing arch specific about building dtb files other than their
> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> >> The dependencies and supported targets are all slightly different.
> >> Also, a cross-compiler for each arch is needed, but really the host
> >> compiler preprocessor is perfectly fine for building dtbs. Move the
> >> build rules to a common location and remove the arch specific ones. This
> >> is done in a single step to avoid warnings about overriding rules.
> >>
> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> >> These pull in several dependencies some of which need a target compiler
> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> >> All that is really needed is dtc, so adjust the dependencies to only be
> >> dtc.
> >>
> >> This change enables support 'dtbs_install' on some arches which were
> >> missing the target.
> >
> > [...]
> >
> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
> >>                 $(srctree)/tools/testing/selftests/*/config
> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
> >>
> >> +# ---------------------------------------------------------------------------
> >> +# Devicetree files
> >> +
> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> >> +dtstree := arch/$(SRCARCH)/boot/dts
> >> +endif
> >> +
> >> +ifdef CONFIG_OF_EARLY_FLATTREE
> >
> > This can be true when dtstree is unset. So this line should be this
> > instead to fix the 0-day reported error:
> >
> > ifneq ($(dtstree),)
> >
> >> +
> >> +%.dtb : scripts_dtc
> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >> +
> >> +PHONY += dtbs dtbs_install
> >> +dtbs: scripts_dtc
> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
> >> +
> >> +dtbs_install: dtbs
> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> >> +
> >> +all: dtbs
> >> +
> >> +endif
>
>
> Ah, right.
> Even x86 can enable OF and OF_UNITTEST.
>
>
>
> Another solution might be,
> guard it by 'depends on ARCH_SUPPORTS_OF'.
>
>
>
> This is actually what ACPI does.
>
> menuconfig ACPI
>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>         depends on ARCH_SUPPORTS_ACPI
>          ...

ACPI is a real platform feature, as it depends on firmware.

CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
even if it has ACPI ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
