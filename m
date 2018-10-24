Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 23:26:14 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994577AbeJXV0GskDET (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Oct 2018 23:26:06 +0200
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F6F32084A
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 21:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540416360;
        bh=DrYv3rOz4s3YKUAS25iDFbj9u1gmDS7kDGOLP8aXMPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WFc9fBtW/wQk5rRBn8pd4zZ4GV3BDaqF2IH3xf//pL9gti9zT6wmhauZ04ZVAXXAX
         tEwOtwUKBf3yqR/uZINoF0Q7yqXohdhB5HZrxBB0n6o3r1fLXBC0QLTGFNZeObXs3r
         Pmm6zykqDp7m/QuWcNSZX2FpHTMf09MjtrWfpZfw=
Received: by mail-qk1-f175.google.com with SMTP id v68-v6so4400898qka.2
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 14:26:00 -0700 (PDT)
X-Gm-Message-State: AGRZ1gKhDY2rZgD+v8CpsjIekU5rPcSRJAS9X3/z96V3FYZWLpHBxwh7
        x8RJrsDRUcfXh4P14DyJ4XhVvMwYJYdhEV4enQ==
X-Google-Smtp-Source: AJdET5fLeqEQvAx6hoB3x+b9qFI1ZHrue/yG2wOqJqu736uN/9NeIxzvWV7airWmV10BuVn5dG9cretcBZt5Df4K5Vc=
X-Received: by 2002:ae9:edd8:: with SMTP id c207mr1630980qkg.184.1540416359162;
 Wed, 24 Oct 2018 14:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181024193256.23734-1-f.fainelli@gmail.com> <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <6e647f76-8523-09d3-9b72-d8d8abd213a4@gmail.com>
In-Reply-To: <6e647f76-8523-09d3-9b72-d8d8abd213a4@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Oct 2018 16:25:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKC6+8gobdk1uhMLLdMUHEO8D0c3m6+F_3y3NTU_KidOw@mail.gmail.com>
Message-ID: <CAL_JsqKC6+8gobdk1uhMLLdMUHEO8D0c3m6+F_3y3NTU_KidOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing CONFIG_BLK_DEV_INITRD
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Oct 24, 2018 at 3:01 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 10/24/18 12:55 PM, Rob Herring wrote:
> > On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> Hi all,
> >>
> >> While investigating why ARM64 required a ton of objects to be rebuilt
> >> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> >> because we define __early_init_dt_declare_initrd() differently and we do
> >> that in arch/arm64/include/asm/memory.h which gets included by a fair
> >> amount of other header files, and translation units as well.
> >
> > I scratch my head sometimes as to why some config options rebuild so
> > much stuff. One down, ? to go. :)
> >
>
> This one was by far the most invasive one due to its include chain, but
> yes, there would be many more that could be optimized.
>
> >> Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> >> systems that generate two kernels: one with the initramfs and one
> >> without. buildroot is one of these build systems, OpenWrt is also
> >> another one that does this.
> >>
> >> This patch series proposes adding an empty initrd.h to satisfy the need
> >> for drivers/of/fdt.c to unconditionally include that file, and moves the
> >> custom __early_init_dt_declare_initrd() definition away from
> >> asm/memory.h
> >>
> >> This cuts the number of objects rebuilds from 1920 down to 26, so a
> >> factor 73 approximately.
> >>
> >> Apologies for the long CC list, please let me know how you would go
> >> about merging that and if another approach would be preferable, e.g:
> >> introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> >> something like that.
> >
> > There may be a better way as of 4.20 because bootmem is now gone and
> > only memblock is used. This should unify what each arch needs to do
> > with initrd early. We need the physical address early for memblock
> > reserving. Then later on we need the virtual address to access the
> > initrd. Perhaps we should just change initrd_start and initrd_end to
> > physical addresses (or add 2 new variables would be less invasive and
> > allow for different translation than __va()). The sanity checks and
> > memblock reserve could also perhaps be moved to a common location.
> >
> > Alternatively, given arm64 is the only oddball, I'd be fine with an
> > "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> > __early_init_dt_declare_initrd as long as we have a path to removing
> > it like the above option.
>
> OK, let me cook a patch doing that and meanwhile I will look at how much
> work is involved to implement the above option you outlined, which also
> sounds entirely reasonable.

BTW, I would suspect that initrd_below_start_ok being 1 is not okay
for most arches. I'm not sure how that would work. min_low_pfn is
typically based on the start of memory. arm64 is not even setting it.

Rob

> --
> Florian
