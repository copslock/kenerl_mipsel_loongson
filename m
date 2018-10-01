Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 07:50:27 +0200 (CEST)
Received: from conssluserg-06.nifty.com ([210.131.2.91]:61376 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990429AbeJAFuXhX2Ae convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 07:50:23 +0200
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w915nhJL018861;
        Mon, 1 Oct 2018 14:49:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w915nhJL018861
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538372984;
        bh=Qnw6nfv2f5Qfhbl6CcKxxBJpYuyhxpkGAFyiVgJV+BE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X2MVzJlJn2/a1+FprtsEbUVyFee8l4lY0RG8UJgIjEom/1NzC6EUIYq/RS6lHis5c
         jFVdFzePf8tg5WTjx8+xQ2BReCX48uMSMh4ddvoFCJqDjQfxYk3C3n/5zxXkYOMkNp
         CDqz8D4xZUtp2Ii1hmH9UoUMyoMzxh8kXa4MulNqGwTQwblQ/dlHGwTPHYmfQb6Uqq
         dJmpzkfdKV7IzNdeODt9aAzspuAT45rd+0cTC36a+vps8z5nJLm0L6SvsxlQidPoYJ
         RuVXLMikOdN1C/82GeDy0hFBuP3sme/07u2XxBSJdd9UeKoVYFP5jZxFyi+IvJCxl8
         FqaOeD62HAiUQ==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id j14-v6so2680445vke.8;
        Sun, 30 Sep 2018 22:49:43 -0700 (PDT)
X-Gm-Message-State: ABuFfojCzMdqe+o5Y/fZTGXX1NP1ROBI8nUuGKuppADtfXQtfBeR4Tq3
        GtPtn9nxojdzm4ai8MLk9J29iy6oeE4DSv/Cj90=
X-Google-Smtp-Source: ACcGV62iRmxiHkB3QMTJljzoGoephgbyQk5RidQoVpOMzclvUjQgLINmFzCENJujD3tHwm/uyOI4PiPdrnFhgJZdJcU=
X-Received: by 2002:a1f:28e:: with SMTP id 136-v6mr3353329vkc.34.1538372982761;
 Sun, 30 Sep 2018 22:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com> <20180928154150.GA25013@bogus>
In-Reply-To: <20180928154150.GA25013@bogus>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 1 Oct 2018 14:49:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
Message-ID: <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] kbuild: consolidate Devicetree dtb build rules
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        DTML <devicetree@vger.kernel.org>,
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
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-xtensa@linux-xtensa.org, Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66624
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

Hi Rob,


2018年9月29日(土) 0:43 Rob Herring <robh@kernel.org>:

> +#
> ---------------------------------------------------------------------------
> +# Devicetree files
> +
> +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> +dtstree := arch/$(SRCARCH)/boot/dts
> +endif
> +
> +ifneq ($(dtstree),)
> +
> +%.dtb : scripts_dtc

%.dtb: prepare3 prepare


because we need to make sure KERNELRELEASE
is correctly defined before dtbs_install happens.


> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +
> +PHONY += dtbs dtbs_install
> +dtbs: scripts_dtc


dtbs: prepare3 scripts_dtc



> +       $(Q)$(MAKE) $(build)=$(dtstree)
> +
> +dtbs_install: dtbs


Please do not have dtbs_install to depend on dtbs.

No install targets should ever trigger building anything
in the source tree.


For the background, see the commit log of
19514fc665ffbce624785f76ee7ad0ea6378a527




> +       $(Q)$(MAKE) $(dtbinst)=$(dtstree)
> +
> +ifdef CONFIG_OF_EARLY_FLATTREE
> +all: dtbs
> +endif
> +
> +endif
> +
> +PHONY += scripts_dtc
> +scripts_dtc: scripts_basic
> +       $(Q)$(MAKE) $(build)=scripts/dtc
> +
>  #
> ---------------------------------------------------------------------------
>  # Modules
>


-- 
Best Regards
Masahiro Yamada
