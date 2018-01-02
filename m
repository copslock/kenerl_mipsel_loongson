Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 11:36:14 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:39833
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbeABKgHJhLM7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 11:36:07 +0100
Received: by mail-qt0-x244.google.com with SMTP id k19so62141207qtj.6
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 02:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=FZKEJWEZS/31LsV1MO1SlEiD7JerUxjnXHXxU3c+zE0=;
        b=b6YNXs5hWyAZW/HzE4futFmtHtipwkKDgY8NwO371+EzdwLxXFVfkKvELjB5gzMe+7
         OZj7yz6V35Ronbc3pm4Fm2HwOXOLLPYW8nRXcxMEHOc/iaunjI++xL4Ib5bp4s0/4KUO
         ScbvNaRRRj32kMYDCIWm/U3zRbV7ghZYe8DkocAsPZ0tRJz55CwExLaScATYsYP8++Sd
         pqcFoqnDgPJy/LqcEAdZRw8csvWJy8bl0XawR1TSw6H4z93We4Dchfv/7COwnT7gBMVQ
         2noSCS2T90x2bJKVxO71LbNGNSg/tIxea9V8tu/9Uu00hBzebgymnYdZdGTl6aHmdMpR
         36/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=FZKEJWEZS/31LsV1MO1SlEiD7JerUxjnXHXxU3c+zE0=;
        b=QzIgHq/VamEVt52C5E2rM2CVyTXFSHtVQisfLaFmPcPt1f4jPt0mkP8DGVOrmi0c3e
         1I71HcipwvtFFLeMfXgKssQSH0KW1lUR8chNZvJfvzGWViu+rpxKLWjzntgxJ/5b+opD
         aNwfm7Lzse/4KrCtaGfXWATaYdZQbgq8r6/4G8fT42Q7u1LGCXLvCDkELb9ErMr6zjuo
         hfFQmXMCPh30P+fMU/Yk7RIu2VFix0swbvKPQ63dz4ONLhGy61FwEBuGMaoW8G6ts+HC
         QMD6aJ7r5Ox9NI4nOjMN30ggzuewfyHkGpunENDBspcWS/vgOJjtBL7k1GT1M0ICiXVp
         Bn6Q==
X-Gm-Message-State: AKGB3mI/+DxCDt7iIg5X5tGbzLKAnHx+A6fzcCwoo1TIG9SDvFrMmPFF
        KxjrLNbsMOwe7jleiQaKquIVtW3BHR3TKIgl5ZY=
X-Google-Smtp-Source: ACJfBovcIUN9JgphyNR92a0KF4abMQTD1ZrolNMfuoz71Mt5pfj7m3gPBn+YaegCIBh70auQ6jrZG4kutsKFZMOoezU=
X-Received: by 10.237.39.155 with SMTP id a27mr59807084qtd.201.1514889361022;
 Tue, 02 Jan 2018 02:36:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.44.66 with HTTP; Tue, 2 Jan 2018 02:36:00 -0800 (PST)
In-Reply-To: <20171229081911.2802-3-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-3-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Jan 2018 11:36:00 +0100
X-Google-Sender-Auth: LtvOVzTrL0jxr1XYjrdfSYbzu7Y
Message-ID: <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
Subject: Re: [PATCH 02/67] alpha: mark jensen as broken
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61819
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

Hi Christoph,

On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> CONFIG_ALPHA_JENSEN has failed to compile since commit aca05038
> ("alpha/dma: use common noop dma ops"), so mark it as broken.

unknown revision or path not in the working tree.
Ah, you dropped the leading "6":
6aca0503847f6329460b15b3ab2b0e30bb752793
is less than 2 years old, though.

>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index b31b974a03cb..e96adcbcab41 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -209,6 +209,7 @@ config ALPHA_EIGER
>
>  config ALPHA_JENSEN
>         bool "Jensen"
> +       depends on BROKEN
>         help
>           DEC PC 150 AXP (aka Jensen): This is a very old Digital system - one
>           of the first-generation Alpha systems. A number of these systems

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
