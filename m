Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2018 23:48:23 +0200 (CEST)
Received: from mail-lf1-x144.google.com ([IPv6:2a00:1450:4864:20::144]:45850
        "EHLO mail-lf1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993981AbeI1VsSQ8aRA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2018 23:48:18 +0200
Received: by mail-lf1-x144.google.com with SMTP id m80-v6so6014225lfi.12;
        Fri, 28 Sep 2018 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXMoAqM9r4NaN21CI8lgLEpYGKDp9ejOhdEFf2jry4k=;
        b=UDrVigNGakKD4/2ayNH5DDSzkxezOVk6v4KNgh99OUp4Ey+DhEWAKsHFrIzeshiNa1
         89uN7ISSKS7pimmnagJ4p0dJKw5q4p6J2wOmXNAzPsmQCSCd03/d78gLjAWB5E2+E79L
         UQExrPfpvDt9eOVnf4bqr2UQOm9sNn1qe5haYv6SNvka16x+i4NBgIj+nKC5fB88DUV2
         F6wZrS2q3nLt93ZyPAaygxWOiu8elavHK2N8BZzO8J3vMxj7U5fSJnE4bfy+5uTJNfFt
         w8UdcGXEZN8f8+EvlAvjWHd/vUyIDrcxRodv/gdcYvf4FRgLNd18/m+vi2giAPx7YsLm
         S+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXMoAqM9r4NaN21CI8lgLEpYGKDp9ejOhdEFf2jry4k=;
        b=UbQT//OZchVJsoVwPYmGHQRV4Y4eh+jYdwPSF7qQhwMKPkc+MPiEGLTWOzUXYJGpDx
         O+3UZu4ru4K/tnBIEGTuAfUymxmsjrTG46BkYKPw27K7Ev+fKzBSpDOtT5FaEQ/ieioD
         PgkzpIE0Oyw/pS0BDCRnhMZ/IFck8t68LhPqkXdGQqiNSyaOJLPc/xeqX9vE22hUt7Aw
         +qYDq12sucvghjG+gbNBnxIsjQu/zmCIIkVqgX1tEvfSreLhWiz5+zYDD2VmihdQuaL9
         fhZdtmlINus7AsvQJbA3HK0O6VNBg6PkbWsY7l7e3cS/ehlvxxs1Xsjudfnw8JSdSbg3
         PbRQ==
X-Gm-Message-State: ABuFfogZKQ7C72DqIcqkC+ZQQKyD0R89MEcGGSjYgYaWCBQJeZXLDFsV
        RdP1Q12+0smbrSy4I3XgkUda2xyn/ZPUjdqTE6U=
X-Google-Smtp-Source: ACcGV62Rps4gGqqHgUTqH4D7uYfGbRQseCkclr7u4Y/WS5FoeKHU1tao+6bHcVO0XYrHUaPL7BqNM5lr3+7xzMGBJ1Y=
X-Received: by 2002:a19:e44b:: with SMTP id b72-v6mr251910lfh.77.1538171292608;
 Fri, 28 Sep 2018 14:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
 <1537367527-20773-7-git-send-email-jim2101024@gmail.com> <20180926220703.4ocppooccuot55i5@pburton-laptop>
In-Reply-To: <20180926220703.4ocppooccuot55i5@pburton-laptop>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 28 Sep 2018 17:48:00 -0400
Message-ID: <CANCKTBs--M6FHHp4YMcTGox+OeKanz2-QJ8-1_R99XHq2iR37g@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] MIPS: BMIPS: add dma remap for BrcmSTB PCIe
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jim2101024@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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

On Wed, Sep 26, 2018 at 6:07 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Jim,
>
> On Wed, Sep 19, 2018 at 10:32:01AM -0400, Jim Quinlan wrote:
> > The design of the Broadcom PCIe RC controller requires us to remap its
> > DMA addresses for inbound traffic.  We do this by modifying the
> > definitions of __phys_to_dma() and __dma_to_phys().
> >
> > In arch/mips/bmips/dma.c, these functions are already in use to remap
> > DMA addresses for the 338x SOC chips.  We leave this code alone -- and
> > give its mapping priority -- but if it is not in use, the PCIe DMA
> > mapping is in effect.
> >
> > One might think that the two DMA remapping systems of dma.c could be
> > combined, but they cannot: one governs only DMA addresses for the PCIe
> > controller of BrcmSTB ARM/ARM64/MIPs chips, while the other governs
> > the PCIe controller *and* other peripherals for only MIPs 338x
> > chips.
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  arch/mips/bmips/dma.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
>
> Please copy me/linux-mips on the whole series next time - I seem to have
> only received patches 6, 8 & 9 which means I have no idea whether they
> have dependencies & if so whether those dependencies have been accepted
> or rejected. I also have no clue whether these patches make sense to
> take through the MIPS tree or if it would make more sense for someone
> else to take them with acks.
Hi Paul,
I had problem with the first time I sent this out and someone said I
should reduce me email list so I used the "git email --cc_cmd
get_mainters.pl".  I'll switch back to an aggregate email list.

>
> > diff --git a/arch/mips/bmips/dma.c b/arch/mips/bmips/dma.c
> > index 3d13c77..292994f 100644
> > --- a/arch/mips/bmips/dma.c
> > +++ b/arch/mips/bmips/dma.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <asm/bmips.h>
> > +#include <soc/brcmstb/common.h>
> >
> >  /*
> >   * BCM338x has configurable address translation windows which allow the
> > @@ -44,6 +45,10 @@ dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t pa)
> >  {
> >       struct bmips_dma_range *r;
> >
> > +#ifdef CONFIG_PCIE_BRCMSTB
> > +     if (!bmips_dma_ranges)
> > +             return brcm_phys_to_dma(dev, pa);
> > +#endif
> >       for (r = bmips_dma_ranges; r && r->size; r++) {
> >               if (pa >= r->child_addr &&
> >                   pa < (r->child_addr + r->size))
>
> I can't tell because I presume brcm_phys_to_dma() is added in one of
> those patches I wasn't copied on, but perhaps you could avoid the #ifdef
> by just returning brcm_phys_to_dma(dev, pa) after the loop?

Yes, will rectify in next version.

>
> > @@ -56,6 +61,10 @@ phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dma_addr)
> >  {
> >       struct bmips_dma_range *r;
> >
> > +#ifdef CONFIG_PCIE_BRCMSTB
> > +     if (!bmips_dma_ranges)
> > +             return (unsigned long)brcm_dma_to_phys(dev, dma_addr);
> > +#endif
> >       for (r = bmips_dma_ranges; r && r->size; r++) {
> >               if (dma_addr >= r->parent_addr &&
> >                   dma_addr < (r->parent_addr + r->size))
>
> And similar here.
>
Okay, thanks,
Jim
> Thanks,
>     Paul
