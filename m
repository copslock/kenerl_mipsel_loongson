Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2017 14:20:59 +0200 (CEST)
Received: from mail-it0-x243.google.com ([IPv6:2607:f8b0:4001:c0b::243]:33744
        "EHLO mail-it0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991948AbdFIMUtuT3BT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jun 2017 14:20:49 +0200
Received: by mail-it0-x243.google.com with SMTP id l6so5888632iti.0
        for <linux-mips@linux-mips.org>; Fri, 09 Jun 2017 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=U1p0idI0OkA5nNdkhuLOij7RtZTBGGImqiUvCpsPm04=;
        b=V8Sz/eTqnP4PCXV26/K4Fp7+wZUVR55atM7be/PmeOPkbzuTC29Y6l0uVtS9Hud9+N
         HGt/1Z0qZBDs9xvFM0iq8ndX6PvO/d7b+1zkjQ9Guh/sc6yK14+Re6caTBdtS9FLEWZR
         YKJ34LbvooEbopthap4Mj0Qg50PEZItgLRN3OR1h1TCDFJgKLf3WdblL0Mr7c2AVZcIe
         BFNE8xriO50n9ottXzfgkHgXRvl2fMxwxuMxjcY4RUsdvSE6NCbC8svCYqvOgplxV25i
         R+uWOtuFKnCh7RwzKtKILS2qHfHwHj6R34dFvMVXeq4ueRAxr7iKs5ETqFKef3GYBPAo
         C1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=U1p0idI0OkA5nNdkhuLOij7RtZTBGGImqiUvCpsPm04=;
        b=GoiS798Xj8Bf1GCrV26luu6dvwugErooAi8OlsHmgme0nfS1mk3gwGcEtnb+eycXgg
         EEN4efhK4wRn1uqB6nBU+X7SGJJrMcyNF5ZZH3xdshksXDNvK4YVrTRjMEvubVM8QWvt
         t+a7Jk3yTrzKLrtZ1nqvFb1FvRgrOSXiNm0OYSOI6xiC3uSzelSFVwbWL1WJ2cdfNeOH
         NBuBajTFgLVceSGVhbHLrUS+RM8CgO4sFmdRN/d1ky7W2RSJww3Ef6+BMv+sZUUIbplM
         taCWJ3Dv6PYdy3g3QB8DU6KEh1ALbcCChSzWsy2eU8wxZ0KnfKMWHttVBIxxt0ORyzxC
         EYOw==
X-Gm-Message-State: AODbwcChBVk/7CzwvFG6FlEKmnesXcWuzztdHYiVwZ0jGFHjBt6Wd7lI
        c0SRmgGz0zZ32b7Ov+F5D3L8xS1TYA==
X-Received: by 10.36.73.217 with SMTP id e86mr10299499itd.48.1497010844023;
 Fri, 09 Jun 2017 05:20:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.182.84 with HTTP; Fri, 9 Jun 2017 05:20:42 -0700 (PDT)
In-Reply-To: <20170608132609.32662-34-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de> <20170608132609.32662-34-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jun 2017 14:20:42 +0200
X-Google-Sender-Auth: LSb5XPEH4xuawpST0HnKqVqM8Co
Message-ID: <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
Subject: Re: [PATCH 33/44] openrisc: remove arch-specific dma_supported implementation
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        openrisc@lists.librecores.org,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58381
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

On Thu, Jun 8, 2017 at 3:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> This implementation is simply bogus - hexagon only has a simple

openrisc?

> direct mapped DMA implementation and thus doesn't care about the
> address.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/include/asm/dma-mapping.h | 7 -------

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
