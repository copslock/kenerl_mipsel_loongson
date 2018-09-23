Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Sep 2018 12:32:48 +0200 (CEST)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:54923 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeIWKckjNpQ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 Sep 2018 12:32:40 +0200
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w8NAVtQw030453;
        Sun, 23 Sep 2018 19:31:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w8NAVtQw030453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537698716;
        bh=sPmhyrc6mKSYCiXyM3hiinn4c+Ysm7ufqvHC63hOpCM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZzhuBOxDINiY3QzHKXPruG3DyaNK4A8Kcau4NK5lX2cf2/yxCmhjgvez7GWfDm92D
         dXGulvNXjjccNJ2E3bbjMhLn8iLILlS8Ypm0GGXMGyBVmRJ39M+Ee8VgD/ZYEre28+
         pdcjDsYBR97cyWQNaQki9dNqNu3xyAzGKqG8tRWoTqFIF5yz+U0f+WmTuGwfjGpftx
         RY984/PL/teRX7SDTX/UKby1j8+kDhpldeRmY1Mk9ilHc6dudrCv0OULSY+0uuOnp3
         aA/1XNufgP/pc/F3/BJYEyov+YLTXM3jI9ZOncExvYDu81MsGKqbvtP4uKREvvuzGU
         FtCoaXCGGjQvw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id w8-v6so6846161vsl.4;
        Sun, 23 Sep 2018 03:31:55 -0700 (PDT)
X-Gm-Message-State: APzg51CKnEjbVB+ROIjt4YM+rTyfARJTN7aWQqMgEiPI82/Bqgx+JNUQ
        ns7JkdUlrYHtK3gDO6c5Amf3FJllPq06rEri9xU=
X-Google-Smtp-Source: ANB0VdbLl/e1DgeRnzFsB+/1XuQjAx4zIp+iZ6A7uhkvjFYbPSupkT/aiHGK3tXFYDWtTLAMiDzVLFCOTEvPPMu5SUI=
X-Received: by 2002:a67:e09d:: with SMTP id f29-v6mr1260499vsl.181.1537698714732;
 Sun, 23 Sep 2018 03:31:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Sun, 23 Sep 2018 03:31:14
 -0700 (PDT)
In-Reply-To: <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com> <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 23 Sep 2018 06:31:14 -0400
X-Gmail-Original-Message-ID: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
Message-ID: <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66492
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

2018-09-13 11:51 GMT-04:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Yamada-san,
>
> On Wed, Sep 12, 2018 at 3:02 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-09-12 0:40 GMT+09:00 Rob Herring <robh@kernel.org>:
>> > On Mon, Sep 10, 2018 at 10:04 AM Rob Herring <robh@kernel.org> wrote:
>> >> There is nothing arch specific about building dtb files other than their
>> >> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> >> The dependencies and supported targets are all slightly different.
>> >> Also, a cross-compiler for each arch is needed, but really the host
>> >> compiler preprocessor is perfectly fine for building dtbs. Move the
>> >> build rules to a common location and remove the arch specific ones. This
>> >> is done in a single step to avoid warnings about overriding rules.
>> >>
>> >> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> >> These pull in several dependencies some of which need a target compiler
>> >> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> >> All that is really needed is dtc, so adjust the dependencies to only be
>> >> dtc.
>> >>
>> >> This change enables support 'dtbs_install' on some arches which were
>> >> missing the target.
>> >
>> > [...]
>> >
>> >> @@ -1215,6 +1215,33 @@ kselftest-merge:
>> >>                 $(srctree)/tools/testing/selftests/*/config
>> >>         +$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
>> >>
>> >> +# ---------------------------------------------------------------------------
>> >> +# Devicetree files
>> >> +
>> >> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
>> >> +dtstree := arch/$(SRCARCH)/boot/dts
>> >> +endif
>> >> +
>> >> +ifdef CONFIG_OF_EARLY_FLATTREE
>> >
>> > This can be true when dtstree is unset. So this line should be this
>> > instead to fix the 0-day reported error:
>> >
>> > ifneq ($(dtstree),)
>> >
>> >> +
>> >> +%.dtb : scripts_dtc
>> >> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>> >> +
>> >> +PHONY += dtbs dtbs_install
>> >> +dtbs: scripts_dtc
>> >> +       $(Q)$(MAKE) $(build)=$(dtstree)
>> >> +
>> >> +dtbs_install: dtbs
>> >> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
>> >> +
>> >> +all: dtbs
>> >> +
>> >> +endif
>>
>>
>> Ah, right.
>> Even x86 can enable OF and OF_UNITTEST.
>>
>>
>>
>> Another solution might be,
>> guard it by 'depends on ARCH_SUPPORTS_OF'.
>>
>>
>>
>> This is actually what ACPI does.
>>
>> menuconfig ACPI
>>         bool "ACPI (Advanced Configuration and Power Interface) Support"
>>         depends on ARCH_SUPPORTS_ACPI
>>          ...
>
> ACPI is a real platform feature, as it depends on firmware.
>
> CONFIG_OF can be enabled, and DT overlays can be loaded, on any platform,
> even if it has ACPI ;-)
>

OK, understood.

Thanks!



-- 
Best Regards
Masahiro Yamada
