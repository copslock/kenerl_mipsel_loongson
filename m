Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 17:40:36 +0200 (CEST)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:15471 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041756AbcFBPkcnFc62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 17:40:32 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O85008LKI7CTS10@mailout4.w1.samsung.com>; Thu,
 02 Jun 2016 16:40:25 +0100 (BST)
X-AuditID: cbfec7f4-f796c6d000001486-ad-57505368f426
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id BC.E9.05254.86350575; Thu,
 2 Jun 2016 16:40:24 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O85008BCI6FXK50@eusync1.samsung.com>; Thu,
 02 Jun 2016 16:40:24 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geoff Levand <geoff@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Muli Ben-Yehuda <muli@il.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        discuss@x86-64.org, linux-pci@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [RFC v3 00/45] dma-mapping: Use unsigned long for dma_attrs
Date:   Thu, 02 Jun 2016 17:39:02 +0200
Message-id: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG97//+1Lrmtx0TK4v2Ycm+zCTOdBpji9hMyHZ9YMZThIWh4xK
        b8BIEVtp1PihwoqIvFyLKGsrQqlQlfIqG3RB0htsBQUlGHxFEERoRKgMlBVEqbhvv+c8z8k5
        OTkyrPRSq2T70w4LujR1qoqWk7cWfL3fpuyOiYuYaoqAUy1zDPjqjDTkd3cQYKutpuGd2ctA
        fUktBYFMEwZHZgr0nDeRMFmZh6DKuRMGph4jmMicI2Hh1TiGezOTNJy5XIThdM0QA9nntoNt
        tAvBi0etBDj8UeB58IaBW6KdgHP14TA7k7XY2FmPoaxtK0yUjmEYqLlCwahkwWB7uB7m/wwQ
        cMpax8DLsUiorBhBMCI+oWGivx2Bpa2fhIbhPgrOtHUx0G4VCXBercFQnu0g4WZBgILJP5pp
        CORMUNDrttFQ9dyFIa+uaVFm9YS2OkmCWGxmwOooJGGo8y4BXaU+Gl5I+SRMDb7HIJZnYSi5
        c33xHvNnMZieuAi43OViQCpuRTD3doH6cQ//3FNK8KZWkearS6sR39vXg/m5oBnx92ti+JdF
        4mKpIJ/gPUMSzdv9RpJvsfQzfOB1Al/WkMFbi/sQn9dyG/GNzrUxm/bIt2mE1P0GQfddVKI8
        JSCO0+mzsUdcr8qwEbkhFy2Tcez33OzNcWKJV3B3n9bSuUguU7KXEGeylzNL4gTBDTumUShF
        sxu4xirHx1QYW89xxuEeHDIwe5zz+4IfQ1+w0VxzwUUmxCT7NRf0P6NCrGB/4s7m/v1p3Fdc
        h7eIEtHyMvTZFfSlkJGUrt+XrI1cp1dr9RlpyeuSDmob0NJ3TTejCu8WCbEypPpc4fzm5zgl
        pTboj2olxMmwKkyRvTMmTqnQqI8eE3QHf9dlpAp6Ca2WkapwxQX3ZKySTVYfFg4IQrqg+98l
        ZMtWGdHu+dgSpnCzOeHf6w3aHffMI86r1u4LjeFRdsXGnPWFmgLP9px/PD9oVt+wPIzmlmcF
        j7XkMw8MwaBm8GKUodN23/168JBvVzzqnhlwVRjeJHS2r3Tbpb7kRx0l8t9G+qf/88RHvvvF
        8te123v36a4lPnVvCg+L9qUGfw077l/jlVSkPkUduRbr9OoPm/Cqa1kDAAA=
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

Hi,


This is third approach (complete this time) for replacing struct
dma_attrs with unsigned long.

The main patch (2/45) doing the change is split into many subpatches
for easier review (3-43).  They should be squashed together when
applying.


*Important:* Patchset is *only* build tested on allyesconfigs: ARM,
ARM64, i386, x86_64 and powerpc. Please provide reviewes and tests
for other platforms.

Rebased on next-20160602.

For easier testing the patchset is available here:
repo:   https://github.com/krzk/linux
branch: for-next/dma-attrs-const-v3


I didn't CC all the maintainers... the list is too big.

Changes since v2
================
1. Follow Christoph Hellwig's comments (don't use BIT add
   documentation, remove dma_get_attr).


Rationale
=========
The dma-mapping core and the implementations do not change the
DMA attributes passed by pointer.  Thus the pointer can point to const
data.  However the attributes do not have to be a bitfield. Instead
unsigned long will do fine:

1. This is just simpler.  Both in terms of reading the code and setting
   attributes.  Instead of initializing local attributes on the stack
   and passing pointer to it to dma_set_attr(), just set the bits.

2. It brings safeness and checking for const correctness because the
   attributes are passed by value.


Best regards,
Krzysztof


Krzysztof Kozlowski (45):
  powerpc: dma-mapping: Don't hard-code the value of
    DMA_ATTR_WEAK_ORDERING
  dma-mapping: Use unsigned long for dma_attrs
  alpha: dma-mapping: Use unsigned long for dma_attrs
  arc: dma-mapping: Use unsigned long for dma_attrs
  ARM: dma-mapping: Use unsigned long for dma_attrs
  arm64: dma-mapping: Use unsigned long for dma_attrs
  avr32: dma-mapping: Use unsigned long for dma_attrs
  blackfin: dma-mapping: Use unsigned long for dma_attrs
  c6x: dma-mapping: Use unsigned long for dma_attrs
  cris: dma-mapping: Use unsigned long for dma_attrs
  frv: dma-mapping: Use unsigned long for dma_attrs
  drm/exynos: dma-mapping: Use unsigned long for dma_attrs
  drm/mediatek: dma-mapping: Use unsigned long for dma_attrs
  drm/msm: dma-mapping: Use unsigned long for dma_attrs
  drm/nouveau: dma-mapping: Use unsigned long for dma_attrs
  drm/rockship: dma-mapping: Use unsigned long for dma_attrs
  infiniband: dma-mapping: Use unsigned long for dma_attrs
  iommu: dma-mapping: Use unsigned long for dma_attrs
  [media] dma-mapping: Use unsigned long for dma_attrs
  xen: dma-mapping: Use unsigned long for dma_attrs
  swiotlb: dma-mapping: Use unsigned long for dma_attrs
  powerpc: dma-mapping: Use unsigned long for dma_attrs
  video: dma-mapping: Use unsigned long for dma_attrs
  x86: dma-mapping: Use unsigned long for dma_attrs
  iommu: intel: dma-mapping: Use unsigned long for dma_attrs
  h8300: dma-mapping: Use unsigned long for dma_attrs
  hexagon: dma-mapping: Use unsigned long for dma_attrs
  ia64: dma-mapping: Use unsigned long for dma_attrs
  m68k: dma-mapping: Use unsigned long for dma_attrs
  metag: dma-mapping: Use unsigned long for dma_attrs
  microblaze: dma-mapping: Use unsigned long for dma_attrs
  mips: dma-mapping: Use unsigned long for dma_attrs
  mn10300: dma-mapping: Use unsigned long for dma_attrs
  nios2: dma-mapping: Use unsigned long for dma_attrs
  openrisc: dma-mapping: Use unsigned long for dma_attrs
  parisc: dma-mapping: Use unsigned long for dma_attrs
  misc: mic: dma-mapping: Use unsigned long for dma_attrs
  s390: dma-mapping: Use unsigned long for dma_attrs
  sh: dma-mapping: Use unsigned long for dma_attrs
  sparc: dma-mapping: Use unsigned long for dma_attrs
  tile: dma-mapping: Use unsigned long for dma_attrs
  unicore32: dma-mapping: Use unsigned long for dma_attrs
  xtensa: dma-mapping: Use unsigned long for dma_attrs
  dma-mapping: Remove dma_get_attr
  dma-mapping: Document the DMA attributes right in declaration

 Documentation/DMA-API.txt                          |  33 +++---
 Documentation/DMA-attributes.txt                   |   2 +-
 arch/alpha/include/asm/dma-mapping.h               |   2 -
 arch/alpha/kernel/pci-noop.c                       |   2 +-
 arch/alpha/kernel/pci_iommu.c                      |  12 +-
 arch/arc/mm/dma.c                                  |  12 +-
 arch/arm/common/dmabounce.c                        |   4 +-
 arch/arm/include/asm/dma-mapping.h                 |  13 +--
 arch/arm/include/asm/xen/page-coherent.h           |  16 +--
 arch/arm/mm/dma-mapping.c                          | 117 +++++++++----------
 arch/arm/xen/mm.c                                  |   8 +-
 arch/arm64/mm/dma-mapping.c                        |  67 +++++------
 arch/avr32/mm/dma-coherent.c                       |  12 +-
 arch/blackfin/kernel/dma-mapping.c                 |   8 +-
 arch/c6x/include/asm/dma-mapping.h                 |   4 +-
 arch/c6x/kernel/dma.c                              |   9 +-
 arch/c6x/mm/dma-coherent.c                         |   4 +-
 arch/cris/arch-v32/drivers/pci/dma.c               |   9 +-
 arch/frv/mb93090-mb00/pci-dma-nommu.c              |   8 +-
 arch/frv/mb93090-mb00/pci-dma.c                    |   9 +-
 arch/h8300/kernel/dma.c                            |   8 +-
 arch/hexagon/include/asm/dma-mapping.h             |   1 -
 arch/hexagon/kernel/dma.c                          |   8 +-
 arch/ia64/hp/common/sba_iommu.c                    |  22 ++--
 arch/ia64/include/asm/machvec.h                    |   1 -
 arch/ia64/kernel/pci-swiotlb.c                     |   4 +-
 arch/ia64/sn/pci/pci_dma.c                         |  22 ++--
 arch/m68k/kernel/dma.c                             |  12 +-
 arch/metag/kernel/dma.c                            |  16 +--
 arch/microblaze/include/asm/dma-mapping.h          |   1 -
 arch/microblaze/kernel/dma.c                       |  12 +-
 arch/mips/cavium-octeon/dma-octeon.c               |   8 +-
 arch/mips/loongson64/common/dma-swiotlb.c          |  10 +-
 arch/mips/mm/dma-default.c                         |  20 ++--
 arch/mips/netlogic/common/nlm-dma.c                |   4 +-
 arch/mn10300/mm/dma-alloc.c                        |   8 +-
 arch/nios2/mm/dma-mapping.c                        |  12 +-
 arch/openrisc/kernel/dma.c                         |  21 ++--
 arch/parisc/kernel/pci-dma.c                       |  18 +--
 arch/powerpc/include/asm/dma-mapping.h             |   7 +-
 arch/powerpc/include/asm/iommu.h                   |  10 +-
 arch/powerpc/kernel/dma-iommu.c                    |  12 +-
 arch/powerpc/kernel/dma.c                          |  18 +--
 arch/powerpc/kernel/ibmebus.c                      |  12 +-
 arch/powerpc/kernel/iommu.c                        |  12 +-
 arch/powerpc/kernel/vio.c                          |  12 +-
 arch/powerpc/platforms/cell/iommu.c                |  26 ++---
 arch/powerpc/platforms/pasemi/iommu.c              |   2 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |   8 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |   4 +-
 arch/powerpc/platforms/powernv/pci.c               |   2 +-
 arch/powerpc/platforms/powernv/pci.h               |   2 +-
 arch/powerpc/platforms/ps3/system-bus.c            |  18 +--
 arch/powerpc/platforms/pseries/iommu.c             |   6 +-
 arch/powerpc/sysdev/dart_iommu.c                   |   2 +-
 arch/s390/include/asm/dma-mapping.h                |   1 -
 arch/s390/pci/pci_dma.c                            |  23 ++--
 arch/sh/include/asm/dma-mapping.h                  |   4 +-
 arch/sh/kernel/dma-nommu.c                         |   4 +-
 arch/sh/mm/consistent.c                            |   4 +-
 arch/sparc/kernel/iommu.c                          |  12 +-
 arch/sparc/kernel/ioport.c                         |  24 ++--
 arch/sparc/kernel/pci_sun4v.c                      |  12 +-
 arch/tile/kernel/pci-dma.c                         |  28 ++---
 arch/unicore32/mm/dma-swiotlb.c                    |   4 +-
 arch/x86/include/asm/dma-mapping.h                 |   5 +-
 arch/x86/include/asm/swiotlb.h                     |   4 +-
 arch/x86/include/asm/xen/page-coherent.h           |   9 +-
 arch/x86/kernel/amd_gart_64.c                      |  20 ++--
 arch/x86/kernel/pci-calgary_64.c                   |  14 +--
 arch/x86/kernel/pci-dma.c                          |   4 +-
 arch/x86/kernel/pci-nommu.c                        |   4 +-
 arch/x86/kernel/pci-swiotlb.c                      |   4 +-
 arch/x86/pci/sta2x11-fixup.c                       |   2 +-
 arch/x86/pci/vmd.c                                 |  16 +--
 arch/xtensa/kernel/pci-dma.c                       |  12 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c          |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  12 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c            |  20 ++--
 drivers/gpu/drm/exynos/exynos_drm_gem.h            |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  13 +--
 drivers/gpu/drm/mediatek/mtk_drm_gem.h             |   2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  13 +--
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    |  13 +--
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  17 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h        |   2 +-
 drivers/infiniband/core/umem.c                     |   7 +-
 drivers/iommu/amd_iommu.c                          |  12 +-
 drivers/iommu/dma-iommu.c                          |   8 +-
 drivers/iommu/intel-iommu.c                        |  12 +-
 drivers/media/platform/sti/bdisp/bdisp-hw.c        |  26 ++---
 drivers/media/v4l2-core/videobuf2-dma-contig.c     |  30 ++---
 drivers/media/v4l2-core/videobuf2-dma-sg.c         |  19 +--
 drivers/misc/mic/host/mic_boot.c                   |  20 ++--
 drivers/parisc/ccio-dma.c                          |  16 +--
 drivers/parisc/sba_iommu.c                         |  16 +--
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |  12 +-
 drivers/video/fbdev/omap2/omapfb/omapfb.h          |   3 +-
 drivers/xen/swiotlb-xen.c                          |  14 +--
 include/linux/dma-attrs.h                          |  71 ------------
 include/linux/dma-iommu.h                          |   6 +-
 include/linux/dma-mapping.h                        | 128 ++++++++++++++-------
 include/linux/swiotlb.h                            |  10 +-
 include/media/videobuf2-dma-contig.h               |   7 +-
 include/rdma/ib_verbs.h                            |   8 +-
 include/xen/swiotlb-xen.h                          |  12 +-
 lib/dma-noop.c                                     |   9 +-
 lib/swiotlb.c                                      |  13 ++-
 108 files changed, 689 insertions(+), 788 deletions(-)
 delete mode 100644 include/linux/dma-attrs.h

-- 
1.9.1
