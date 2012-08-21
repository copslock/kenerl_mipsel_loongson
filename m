Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Aug 2012 20:15:20 +0200 (CEST)
Received: from mail-vb0-f49.google.com ([209.85.212.49]:53161 "EHLO
        mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903534Ab2HUSPO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Aug 2012 20:15:14 +0200
Received: by vbbfo1 with SMTP id fo1so119607vbb.36
        for <multiple recipients>; Tue, 21 Aug 2012 11:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WMYZv4FyRJFsEGFv7VN1tev1s+PQk7O5yjYwavL612g=;
        b=JglKWgsdwsrE/lHIfvs62YkIZwLrxLMwUc7FOH/n56JL0Pb5V+z09GxkIziDxkPesm
         pUsAj71ChIs7EX9fhftXx8gHKFxgS/uWbU8B2m06zR0UBSVoTfUI0OqJ7xwEqjDPQNa/
         TEAtdbVzu2wfOjhXGtArK5+vp5OTHgGPw5+BttTy9ELSxHkJIu8NuaDLG9Bdd8kGjx4Q
         w8OO0ZIeIDM90zbGQM6vmDLLSP3OeeVsAdCZTQlcYlgdvJO9vhboG8prwVwRRBZI4vAw
         bZCJoMHQ9gMIpHoW77hKc5Rm/gpUgnPx8fVUsoTsh2gLKiy3PTKsW+HeQMyhyDlwqSof
         P0BQ==
MIME-Version: 1.0
Received: by 10.220.141.208 with SMTP id n16mr14350061vcu.22.1345572907710;
 Tue, 21 Aug 2012 11:15:07 -0700 (PDT)
Received: by 10.220.22.202 with HTTP; Tue, 21 Aug 2012 11:15:07 -0700 (PDT)
In-Reply-To: <20120821170456.GA18994@linux-mips.org>
References: <20120817182931.GA27391@avionic-0098.adnet.avionic-design.de>
        <CAErSpo6xhbpmd-rnLqKp9SuRQCp5a7jUzKhz0n6zGGLNHybWqA@mail.gmail.com>
        <20120817200755.GA16021@avionic-0098.adnet.avionic-design.de>
        <CAErSpo4XX7mQBmJfYWzmXCSDAt4BzZoJV6gU9__409K=fpvC6A@mail.gmail.com>
        <20120817204839.GA2017@avionic-0098.mockup.avionic-design.de>
        <20120817210718.GA14842@avionic-0098.mockup.avionic-design.de>
        <CAErSpo7bwHNUchZHeJByxzhsc0uN7RJMLivBo5FuOJzA0Gz2Jg@mail.gmail.com>
        <20120817213247.GA1056@avionic-0098.mockup.avionic-design.de>
        <20120820053036.GA23166@kroah.com>
        <CAMuHMdWfhATFQrP-ZiMi6Ub3ZbOgUhe7S_fVUzc7zOwDxRNsyw@mail.gmail.com>
        <20120821170456.GA18994@linux-mips.org>
Date:   Tue, 21 Aug 2012 20:15:07 +0200
X-Google-Sender-Auth: yseKwQ2loEuLjJlqeoRx25Ea5Q8
Message-ID: <CAMuHMdVrvT5RCp43bmbd9=MwsqhMWewJm4Xnq0ZMPT7hoEBSng@mail.gmail.com>
Subject: Re: PCI Section mismatch error in linux-next.
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <ddaney.cavm@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 34308
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Ralf,

On Tue, Aug 21, 2012 at 7:04 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> Anyone who disables CONFIG_HOTPLUG in his defconfig files?
>>
>> $ git grep CONFIG_HOTPLUG arch/*/*config
>> arch/frv/defconfig:# CONFIG_HOTPLUG is not set
>> arch/h8300/defconfig:# CONFIG_HOTPLUG is not set
>> arch/um/defconfig:CONFIG_HOTPLUG=y
>> $
>>
>> Yep, (at least --- not all defconfigs are up-to-date) frv and h8300.
>
> Since we started stripping all the defconfigs down grepping through
> arch/*/configs/ doesn't yield much useful information anymore :-(

Sure, but since CONFIG_HOTPLUG=y and CONFIG_EXPERT=n are the
defaults, disabling CONFIG_HOTPLUG should show up in the miniconfig.

> There are currently 8 MIPS default configurations that dondo not enable
> CONFIG_HOTPLUG.  I didn't check other architectures.

Strange, how come I didn't see those?
Ah, wrong file pattern. They're stored in the "configs" subdir, not in "config".
Better list:

$ git grep -w CONFIG_HOTPLUG arch/*/*config*
arch/arm/configs/at91x40_defconfig:# CONFIG_HOTPLUG is not set
arch/arm/configs/bcmring_defconfig:# CONFIG_HOTPLUG is not set
arch/arm/configs/edb7211_defconfig:# CONFIG_HOTPLUG is not set
arch/arm/configs/footbridge_defconfig:# CONFIG_HOTPLUG is not set
arch/arm/configs/fortunet_defconfig:# CONFIG_HOTPLUG is not set
arch/arm/configs/pleb_defconfig:# CONFIG_HOTPLUG is not set
arch/blackfin/configs/IP0X_defconfig:# CONFIG_HOTPLUG is not set
arch/cris/configs/artpec_3_defconfig:# CONFIG_HOTPLUG is not set
arch/cris/configs/etrax-100lx_v2_defconfig:# CONFIG_HOTPLUG is not set
arch/cris/configs/etraxfs_defconfig:# CONFIG_HOTPLUG is not set
arch/frv/defconfig:# CONFIG_HOTPLUG is not set
arch/h8300/defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5208evb_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5249evb_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5272c3_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5275evb_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5307c3_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5407c3_defconfig:# CONFIG_HOTPLUG is not set
arch/m68k/configs/m5475evb_defconfig:# CONFIG_HOTPLUG is not set
arch/microblaze/configs/mmu_defconfig:# CONFIG_HOTPLUG is not set
arch/microblaze/configs/nommu_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/db1000_defconfig:CONFIG_HOTPLUG=y
arch/mips/configs/db1300_defconfig:CONFIG_HOTPLUG=y
arch/mips/configs/db1550_defconfig:CONFIG_HOTPLUG=y
arch/mips/configs/decstation_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/e55_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/ip22_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/ip28_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/jmr3927_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/lasat_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/pnx8550-stb810_defconfig:# CONFIG_HOTPLUG is not set
arch/mips/configs/rbtx49xx_defconfig:# CONFIG_HOTPLUG is not set
arch/mn10300/configs/asb2303_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/85xx/socrates_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/85xx/tqm8540_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/85xx/tqm8541_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/85xx/tqm8555_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/85xx/tqm8560_defconfig:# CONFIG_HOTPLUG is not set
arch/powerpc/configs/mpc866_ads_defconfig:# CONFIG_HOTPLUG is not set
arch/score/configs/spct6600_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/edosk7705_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/se7619_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/se7705_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/se7750_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/se7751_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/se7780_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/secureedge5410_defconfig:# CONFIG_HOTPLUG is not set
arch/sh/configs/shmin_defconfig:# CONFIG_HOTPLUG is not set
arch/um/defconfig:CONFIG_HOTPLUG=y
arch/unicore32/configs/unicore32_defconfig:CONFIG_HOTPLUG=y
arch/xtensa/configs/common_defconfig:# CONFIG_HOTPLUG is not set
arch/xtensa/configs/iss_defconfig:# CONFIG_HOTPLUG is not set
arch/xtensa/configs/s6105_defconfig:# CONFIG_HOTPLUG is not set
$

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
