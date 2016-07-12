Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2016 14:16:41 +0200 (CEST)
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34533 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993489AbcGLMQeX-Xm- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jul 2016 14:16:34 +0200
Received: by mail-wm0-f66.google.com with SMTP id w75so1846667wmd.1
        for <linux-mips@linux-mips.org>; Tue, 12 Jul 2016 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMNDUnitLIl7SMpPJT/jV0OJdnWAP+3SDJ+SuiNbjYI=;
        b=jdB95FvRdCfHu80Ra4P1ZHVMv3uxCYiO32aaHl4SbA1GA9J93r2n7BBnbsU9oiktlw
         0WITI8ixcuIWYFBHdUqa/tmqn2KeI5rieIY1bCMuzju7OBPo1XrnWGgHLNniTSsl9cdr
         nmPeQ6HHvKSYFZ+5RVH6bOlzHbfkGRLtqshe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XMNDUnitLIl7SMpPJT/jV0OJdnWAP+3SDJ+SuiNbjYI=;
        b=TgbpJD4aTwaLW2jqW7279lQKVeLqdjZB36Bey7pTSGX59dudXIbqJmhN9RPb/dS88d
         P/0DdqpzbdXocXWAS2SjrhzXWGbu+tJej7Mzct+fq6HQ689H1DETC2A0OTyCprrxKqxi
         utIW4fpB+SdtLdItBJ0egWxFn/Qf4/TFvSWwQYTXMAx5j7jxcjRhLkq/wu7y7Znpivq9
         GavJl1ojCExb2SkKV0nsYPdq0+hqi3/Dk7dDr8ffCmI7W+WET3zuHWdqSnbUqDA2vVKM
         XxB5zfCAa8IkxjIDV9DRmPDqCBT8zL+2i8bFBlSsMQXsvjvIRgKwZT4+1W01vD8hVn34
         KweQ==
X-Gm-Message-State: ALyK8tLslaQdLA0Bx4RUfdNwvoJrNpFK8wfiqZjd6/R2xd9lOlEnrDIZ/oc89CGXHie6Kw==
X-Received: by 10.28.156.87 with SMTP id f84mr19021943wme.86.1468325788859;
        Tue, 12 Jul 2016 05:16:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56b5:0:ac27:b86c:7764:9429])
        by smtp.gmail.com with ESMTPSA id f196sm28646454wmg.15.2016.07.12.05.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jul 2016 05:16:28 -0700 (PDT)
Date:   Tue, 12 Jul 2016 14:16:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, hch@infradead.org,
        linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 00/44] dma-mapping: Use unsigned long for dma_attrs
Message-ID: <20160712121625.GP23520@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
        linux-rdma@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-sh@vger.kernel.org, hch@infradead.org,
        linux-rockchip@lists.infradead.org, nouveau@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-snps-arc@lists.infradead.org,
        linux-media@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467275019-30789-1-git-send-email-k.kozlowski@samsung.com>
X-Operating-System: Linux phenom 4.6.0-rc5+ 
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <daniel@ffwll.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@ffwll.ch
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

On Thu, Jun 30, 2016 at 10:23:39AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> This is fifth approach for replacing struct dma_attrs with unsigned
> long.
> 
> The main patch (1/44) doing the change is split into many subpatches
> for easier review (2-42).  They should be squashed together when
> applying.

For all the drm driver patches:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Should I pull these in through drm-misc, or do you prefer to merge them
through a special topic branch (with everything else) instead on your own?
-Daniel

> 
> 
> Rebased on v4.7-rc5.
> 
> For easier testing the patchset is available here:
> repo:   https://github.com/krzk/linux
> branch: for-next/dma-attrs-const-v5
> 
> 
> Changes since v4
> ================
> 1. Collect some acks. Still need more.
> 2. Minor fixes pointed by Robin Murphy.
> 3. Applied changes from Bart Van Assche's comment.
> 4. More tests and builds (using https://www.kernel.org/pub/tools/crosstool/).
> 
> 
> Changes since v3
> ================
> 1. Collect some acks.
> 2. Drop wrong patch 1/45 ("powerpc: dma-mapping: Don't hard-code
>    the value of DMA_ATTR_WEAK_ORDERING").
> 3. Minor fix pointed out by Michael Ellerman.
> 
> 
> Changes since v2
> ================
> 1. Follow Christoph Hellwig's comments (don't use BIT add
>    documentation, remove dma_get_attr).
> 
> 
> Rationale
> =========
> The dma-mapping core and the implementations do not change the
> DMA attributes passed by pointer.  Thus the pointer can point to const
> data.  However the attributes do not have to be a bitfield. Instead
> unsigned long will do fine:
> 
> 1. This is just simpler.  Both in terms of reading the code and setting
>    attributes.  Instead of initializing local attributes on the stack
>    and passing pointer to it to dma_set_attr(), just set the bits.
> 
> 2. It brings safeness and checking for const correctness because the
>    attributes are passed by value.
> 
> 
> Best regards,
> Krzysztof
> 
> 
> Krzysztof Kozlowski (44):
>   dma-mapping: Use unsigned long for dma_attrs
>   alpha: dma-mapping: Use unsigned long for dma_attrs
>   arc: dma-mapping: Use unsigned long for dma_attrs
>   ARM: dma-mapping: Use unsigned long for dma_attrs
>   arm64: dma-mapping: Use unsigned long for dma_attrs
>   avr32: dma-mapping: Use unsigned long for dma_attrs
>   blackfin: dma-mapping: Use unsigned long for dma_attrs
>   c6x: dma-mapping: Use unsigned long for dma_attrs
>   cris: dma-mapping: Use unsigned long for dma_attrs
>   frv: dma-mapping: Use unsigned long for dma_attrs
>   drm/exynos: dma-mapping: Use unsigned long for dma_attrs
>   drm/mediatek: dma-mapping: Use unsigned long for dma_attrs
>   drm/msm: dma-mapping: Use unsigned long for dma_attrs
>   drm/nouveau: dma-mapping: Use unsigned long for dma_attrs
>   drm/rockship: dma-mapping: Use unsigned long for dma_attrs
>   infiniband: dma-mapping: Use unsigned long for dma_attrs
>   iommu: dma-mapping: Use unsigned long for dma_attrs
>   [media] dma-mapping: Use unsigned long for dma_attrs
>   xen: dma-mapping: Use unsigned long for dma_attrs
>   swiotlb: dma-mapping: Use unsigned long for dma_attrs
>   powerpc: dma-mapping: Use unsigned long for dma_attrs
>   video: dma-mapping: Use unsigned long for dma_attrs
>   x86: dma-mapping: Use unsigned long for dma_attrs
>   iommu: intel: dma-mapping: Use unsigned long for dma_attrs
>   h8300: dma-mapping: Use unsigned long for dma_attrs
>   hexagon: dma-mapping: Use unsigned long for dma_attrs
>   ia64: dma-mapping: Use unsigned long for dma_attrs
>   m68k: dma-mapping: Use unsigned long for dma_attrs
>   metag: dma-mapping: Use unsigned long for dma_attrs
>   microblaze: dma-mapping: Use unsigned long for dma_attrs
>   mips: dma-mapping: Use unsigned long for dma_attrs
>   mn10300: dma-mapping: Use unsigned long for dma_attrs
>   nios2: dma-mapping: Use unsigned long for dma_attrs
>   openrisc: dma-mapping: Use unsigned long for dma_attrs
>   parisc: dma-mapping: Use unsigned long for dma_attrs
>   misc: mic: dma-mapping: Use unsigned long for dma_attrs
>   s390: dma-mapping: Use unsigned long for dma_attrs
>   sh: dma-mapping: Use unsigned long for dma_attrs
>   sparc: dma-mapping: Use unsigned long for dma_attrs
>   tile: dma-mapping: Use unsigned long for dma_attrs
>   unicore32: dma-mapping: Use unsigned long for dma_attrs
>   xtensa: dma-mapping: Use unsigned long for dma_attrs
>   dma-mapping: Remove dma_get_attr
>   dma-mapping: Document the DMA attributes next to the declaration
> 
>  Documentation/DMA-API.txt                          |  33 +++---
>  Documentation/DMA-attributes.txt                   |   2 +-
>  arch/alpha/include/asm/dma-mapping.h               |   2 -
>  arch/alpha/kernel/pci-noop.c                       |   2 +-
>  arch/alpha/kernel/pci_iommu.c                      |  12 +-
>  arch/arc/mm/dma.c                                  |  12 +-
>  arch/arm/common/dmabounce.c                        |   4 +-
>  arch/arm/include/asm/dma-mapping.h                 |  13 +--
>  arch/arm/include/asm/xen/page-coherent.h           |  16 +--
>  arch/arm/mm/dma-mapping.c                          | 117 +++++++++----------
>  arch/arm/xen/mm.c                                  |   8 +-
>  arch/arm64/mm/dma-mapping.c                        |  66 +++++------
>  arch/avr32/mm/dma-coherent.c                       |  12 +-
>  arch/blackfin/kernel/dma-mapping.c                 |   8 +-
>  arch/c6x/include/asm/dma-mapping.h                 |   4 +-
>  arch/c6x/kernel/dma.c                              |   9 +-
>  arch/c6x/mm/dma-coherent.c                         |   4 +-
>  arch/cris/arch-v32/drivers/pci/dma.c               |   9 +-
>  arch/frv/mb93090-mb00/pci-dma-nommu.c              |   8 +-
>  arch/frv/mb93090-mb00/pci-dma.c                    |   9 +-
>  arch/h8300/kernel/dma.c                            |   8 +-
>  arch/hexagon/include/asm/dma-mapping.h             |   1 -
>  arch/hexagon/kernel/dma.c                          |   8 +-
>  arch/ia64/hp/common/sba_iommu.c                    |  22 ++--
>  arch/ia64/include/asm/machvec.h                    |   1 -
>  arch/ia64/kernel/pci-swiotlb.c                     |   4 +-
>  arch/ia64/sn/pci/pci_dma.c                         |  22 ++--
>  arch/m68k/kernel/dma.c                             |  12 +-
>  arch/metag/kernel/dma.c                            |  16 +--
>  arch/microblaze/include/asm/dma-mapping.h          |   1 -
>  arch/microblaze/kernel/dma.c                       |  12 +-
>  arch/mips/cavium-octeon/dma-octeon.c               |   8 +-
>  arch/mips/loongson64/common/dma-swiotlb.c          |  10 +-
>  arch/mips/mm/dma-default.c                         |  20 ++--
>  arch/mips/netlogic/common/nlm-dma.c                |   4 +-
>  arch/mn10300/mm/dma-alloc.c                        |   8 +-
>  arch/nios2/mm/dma-mapping.c                        |  12 +-
>  arch/openrisc/kernel/dma.c                         |  21 ++--
>  arch/parisc/kernel/pci-dma.c                       |  18 +--
>  arch/powerpc/include/asm/dma-mapping.h             |   7 +-
>  arch/powerpc/include/asm/iommu.h                   |  10 +-
>  arch/powerpc/kernel/dma-iommu.c                    |  12 +-
>  arch/powerpc/kernel/dma.c                          |  18 +--
>  arch/powerpc/kernel/ibmebus.c                      |  12 +-
>  arch/powerpc/kernel/iommu.c                        |  12 +-
>  arch/powerpc/kernel/vio.c                          |  12 +-
>  arch/powerpc/platforms/cell/iommu.c                |  28 ++---
>  arch/powerpc/platforms/pasemi/iommu.c              |   2 +-
>  arch/powerpc/platforms/powernv/npu-dma.c           |   8 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c          |   4 +-
>  arch/powerpc/platforms/powernv/pci.c               |   2 +-
>  arch/powerpc/platforms/powernv/pci.h               |   2 +-
>  arch/powerpc/platforms/ps3/system-bus.c            |  18 +--
>  arch/powerpc/platforms/pseries/iommu.c             |   6 +-
>  arch/powerpc/sysdev/dart_iommu.c                   |   2 +-
>  arch/s390/include/asm/dma-mapping.h                |   1 -
>  arch/s390/pci/pci_dma.c                            |  23 ++--
>  arch/sh/include/asm/dma-mapping.h                  |   4 +-
>  arch/sh/kernel/dma-nommu.c                         |   4 +-
>  arch/sh/mm/consistent.c                            |   4 +-
>  arch/sparc/kernel/iommu.c                          |  12 +-
>  arch/sparc/kernel/ioport.c                         |  24 ++--
>  arch/sparc/kernel/pci_sun4v.c                      |  12 +-
>  arch/tile/kernel/pci-dma.c                         |  28 ++---
>  arch/unicore32/mm/dma-swiotlb.c                    |   4 +-
>  arch/x86/include/asm/dma-mapping.h                 |   5 +-
>  arch/x86/include/asm/swiotlb.h                     |   4 +-
>  arch/x86/include/asm/xen/page-coherent.h           |   9 +-
>  arch/x86/kernel/amd_gart_64.c                      |  20 ++--
>  arch/x86/kernel/pci-calgary_64.c                   |  14 +--
>  arch/x86/kernel/pci-dma.c                          |   4 +-
>  arch/x86/kernel/pci-nommu.c                        |   4 +-
>  arch/x86/kernel/pci-swiotlb.c                      |   4 +-
>  arch/x86/pci/sta2x11-fixup.c                       |   2 +-
>  arch/x86/pci/vmd.c                                 |  16 +--
>  arch/xtensa/kernel/pci-dma.c                       |  12 +-
>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   2 +-
>  drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  12 +-
>  drivers/gpu/drm/exynos/exynos_drm_gem.c            |  20 ++--
>  drivers/gpu/drm/exynos/exynos_drm_gem.h            |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  13 +--
>  drivers/gpu/drm/mediatek/mtk_drm_gem.h             |   2 +-
>  drivers/gpu/drm/msm/msm_drv.c                      |  13 +--
>  .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    |  13 +--
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  17 ++-
>  drivers/gpu/drm/rockchip/rockchip_drm_gem.h        |   2 +-
>  drivers/infiniband/core/umem.c                     |   7 +-
>  drivers/iommu/amd_iommu.c                          |  12 +-
>  drivers/iommu/dma-iommu.c                          |   8 +-
>  drivers/iommu/intel-iommu.c                        |  12 +-
>  drivers/media/platform/sti/bdisp/bdisp-hw.c        |  26 ++---
>  drivers/media/v4l2-core/videobuf2-dma-contig.c     |  30 ++---
>  drivers/media/v4l2-core/videobuf2-dma-sg.c         |  19 +--
>  drivers/misc/mic/host/mic_boot.c                   |  20 ++--
>  drivers/parisc/ccio-dma.c                          |  16 +--
>  drivers/parisc/sba_iommu.c                         |  16 +--
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |  12 +-
>  drivers/video/fbdev/omap2/omapfb/omapfb.h          |   3 +-
>  drivers/xen/swiotlb-xen.c                          |  14 +--
>  include/linux/dma-attrs.h                          |  71 ------------
>  include/linux/dma-iommu.h                          |   6 +-
>  include/linux/dma-mapping.h                        | 128 ++++++++++++++-------
>  include/linux/swiotlb.h                            |  10 +-
>  include/media/videobuf2-dma-contig.h               |   7 +-
>  include/rdma/ib_verbs.h                            |   8 +-
>  include/xen/swiotlb-xen.h                          |  12 +-
>  lib/dma-noop.c                                     |   9 +-
>  lib/swiotlb.c                                      |  13 ++-
>  108 files changed, 689 insertions(+), 789 deletions(-)
>  delete mode 100644 include/linux/dma-attrs.h
> 
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
