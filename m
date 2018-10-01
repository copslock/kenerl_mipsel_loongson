Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 16:49:37 +0200 (CEST)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:57813 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994272AbeJAOt1NBfbQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Oct 2018 16:49:27 +0200
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w91Emc5Y020114;
        Mon, 1 Oct 2018 23:48:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w91Emc5Y020114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538405319;
        bh=5xLnjWYlaLHDfQSoDnaw2ichwJ/ivXEr+S7uTOdzoRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ooz8dPb0BRed5QUDq53QAokaJGPIX9D9rN+QsLlMx019h4MVYrueF6bhRvJ5s6tk
         LjISdYLwtp0QF/A9D3n/g4IZp53Wrr9ec26ATLdV4Vvn0eDK5tR9ANGcSgkgfQz70X
         p/OvwPpLbMOMNhzoHgX7ztKauV6vxE8DMyzPEBWsSa2JIAdQkAyt0LQ9naUx86x358
         2g9DSriFxDvYJgxC9jf21OzscNay5Yrjhyw3oNtV4ybcwl8WE2SMELoZ488P2KKWUB
         avKwib11KoW2UxmngNH5UPN2B6GJMsiDPmM1bajxof8ZFZEcXab8akUdARTtat5E0j
         mgMYm4dFgnYcQ==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id j17-v6so4967724uan.5;
        Mon, 01 Oct 2018 07:48:38 -0700 (PDT)
X-Gm-Message-State: ABuFfog9vfU+z4BCckMn2n/p1d+rK7pNo8wz3PEP2UuSoMSflOIRKoOb
        uLR13cb+fI9m9fvjiGSUbCKb5iRaNY/xg/bBrE8=
X-Google-Smtp-Source: ACcGV63Lp5DmcNEdHObPJ9iIFkuC5aeS+D9PUDy+KEQ3Qc97quis/gIiKLMM01moL3IgHngn1YfjSCscCPfngL34bMo=
X-Received: by 2002:a9f:3826:: with SMTP id p35-v6mr1734574uad.42.1538405317121;
 Mon, 01 Oct 2018 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180910150403.19476-1-robh@kernel.org> <20180910150403.19476-7-robh@kernel.org>
 <CAL_Jsq+=VbdcVLiwXbOA5d+R2YY6=2Pw2bQpci-jj-JvereD1A@mail.gmail.com>
 <CAK7LNAQFqhWw+LwDoypGG=OP6tH4qf2tT=LvtchK2GoiNyzDXg@mail.gmail.com>
 <CAMuHMdWEnoh97_jiDWMq=ke4PrhSFbToYnx91CPLBuq3mOGzoQ@mail.gmail.com>
 <CAK7LNATkkOiYPj2RLubcgZ_z59Bhz4GkgWqPMbnaHBk7EisXLg@mail.gmail.com>
 <20180928154150.GA25013@bogus> <CAK7LNATiSbwVfCRNsDOyksfq5wcv0pnNQYnMXdo2yRyE7fcn-Q@mail.gmail.com>
 <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
In-Reply-To: <CAL_JsqLPaX3GB1Esw3DhkQ+2fQLVG8=_UbyJC5RJ-6_s=v288g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 1 Oct 2018 23:48:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASX+2iLbXmpgcsH9agrxkd5xeWbTZdh8hxL+zJm4L11gw@mail.gmail.com>
Message-ID: <CAK7LNASX+2iLbXmpgcsH9agrxkd5xeWbTZdh8hxL+zJm4L11gw@mail.gmail.com>
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
X-archive-position: 66649
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


2018年10月1日(月) 22:26 Rob Herring <robh@kernel.org>:
>
> On Mon, Oct 1, 2018 at 12:49 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Hi Rob,
> >
> >
> > 2018年9月29日(土) 0:43 Rob Herring <robh@kernel.org>:
> >
> > > +#
> > > ---------------------------------------------------------------------------
> > > +# Devicetree files
> > > +
> > > +ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/boot/dts/),)
> > > +dtstree := arch/$(SRCARCH)/boot/dts
> > > +endif
> > > +
> > > +ifneq ($(dtstree),)
> > > +
> > > +%.dtb : scripts_dtc
> >
> > %.dtb: prepare3 prepare
>
> I assume you didn't mean to drop scripts_dtc as that doesn't work.
>
> Why "prepare" here and not on dtbs?


Sorry, my mistake.


%.dtb: prepare3 scripts_dtc

is the correct one.



> > because we need to make sure KERNELRELEASE
> > is correctly defined before dtbs_install happens.
>
> Yes, indeed. With prepare3 added I get:
>
> cp: cannot create regular file
> '/boot/dtbs/4.19.0-rc3-00009-g0afba9b7b2ea-dirty': No such file or
> directory
>
> vs. with it:
>
> cp: cannot create regular file '/boot/dtbs/': Not a directory
>
> >
> >
> > > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> > > +
> > > +PHONY += dtbs dtbs_install
> > > +dtbs: scripts_dtc
> >
> >
> > dtbs: prepare3 scripts_dtc
> >
> >
> >
> > > +       $(Q)$(MAKE) $(build)=$(dtstree)
> > > +
> > > +dtbs_install: dtbs
> >
> >
> > Please do not have dtbs_install to depend on dtbs.
> >
> > No install targets should ever trigger building anything
> > in the source tree.
> >
> >
> > For the background, see the commit log of
> > 19514fc665ffbce624785f76ee7ad0ea6378a527
>
> Okay, thanks.
>
> Rob



-- 
Best Regards
Masahiro Yamada
