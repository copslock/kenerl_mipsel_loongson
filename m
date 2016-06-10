Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 12:12:19 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46998 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27035543AbcFJKMR1rW-Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 12:12:17 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8J00BRQWCAN340@mailout1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 10 Jun 2016 11:12:10 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-40-575a9279a61e
Received: from eusync4.samsung.com ( [203.254.199.214])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 51.43.04866.9729A575; Fri,
 10 Jun 2016 11:12:09 +0100 (BST)
Received: from AMDC2174.DIGITAL.local ([106.120.53.17])
 by eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0O8J00MI3WC5KUB0@eusync4.samsung.com>; Fri,
 10 Jun 2016 11:12:09 +0100 (BST)
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@infradead.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
        linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v4 00/44] dma-mapping: Use unsigned long for dma_attrs
Date:   Fri, 10 Jun 2016 12:11:17 +0200
Message-id: <1465553521-27303-1-git-send-email-k.kozlowski@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRWyybcRjG/b9D+ynNvtTpi4ksXWSJxGl28Q47JGK+ZRdcTDqyZIpvCKVr
        S3CDYcSh6zBjStjqOGVrLTMRMswxDRsxGcaQkWgQYiQOm05293ve35M8Fy+Fi3oIZyo+ScUp
        kqSJYp6AGD8ZnvFIL42QeI81B4C2o40H7yo7SJje2+KBds2EYFzzCoO6Pn/YWPeBzYVBBIaV
        GRKe9Zn4MFitwaD5TTsO9U90BIyot0nYyu3iwXbBJglT3VoeNK3qcSh++/405nxB8Ot7PgGa
        56V8qNY9JWB5bBIDU+0wD371lxCws/QHB019Dg6VE70YaI/Kccib12PQYtLz4XD/hITHub6w
        r1aTkDXaTMJ+Zxl204391h7Kfny5wGeNze5sl2EDY0cqDwn2c4seY9c/fcDZxaJhjDXqMtmy
        2SbEjub9JtiJynrEDmxPE6y6sxWxuwbX0HMRgoAYLjE+lVN4XY8UxBlXhPK5sLTj5QoiCxVf
        LUTWFENfYWYNO/wzdmQmf3TwLCyiGxBzfOBciASnnI0xJdp50iJ4tC9jbNL9K9nTHkzrWjdu
        KeF0rTVTszSOWYQdfYsZyG5HhYiiCNqN6WmIsJyFdDDzdWAVnY25MqNDZaQG2dQhq1bkwKVE
        y5VRsbLLnkqpTJmSFOsZnSwzoLOf7nWhhiG/fkRTSGwrvNcdLhGR0lRluqwfMRQutheCOkIi
        EsZI0zM4RfIDRUoip+xH5ylC7CSs6t66K6JjpSougePknOK/xShr5ywkUvVexIIflevLK4IK
        JG2EyzUnL1uzqypt1+TorRqIaorPDHOZCxTzSyLvhzw8slmsChGkKakLpZHsnTqNIZSv3/SP
        fm1OCbebatwMOAnihlpcjHJJUMKN4r2goti4DGGvudY92jU/WHUg96m5HWL+6fei8VLxgtkh
        cBa3OhYTyjipjzuuUEr/AgxF34TPAgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54012
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


This is fourth approach for replacing struct dma_attrs with unsigned
long.

The main patch (1/44) doing the change is split into many subpatches
for easier review (2-42).  They should be squashed together when
applying.


*Important:* Patchset is tested on my ARM platforms and *only* build
tested on allyesconfigs: ARM, ARM64, i386, x86_64 and powerpc.
Please kindly provide reviewes and tests for other platforms.

Rebased on next-20160607.

For easier testing the patchset is available here:
repo:   https://github.com/krzk/linux
branch: for-next/dma-attrs-const-v4


Changes since v3
================
1. Collect some acks.
2. Drop wrong patch 1/45 ("powerpc: dma-mapping: Don't hard-code
   the value of DMA_ATTR_WEAK_ORDERING").
3. Minor fix pointed out by Michael Ellerman.


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


Krzysztof Kozlowski (44):
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
  dma-mapping: Document the DMA attributes next to the declaration

 Documentation/DMA-API.txt                          |  33 +++---
 Documentation/DMA-attributes.txt                   |   2 +-
 arch/alpha/include/asm/dma-mapping.h               |   2 -
 arch/alpha/kernel/pci-noop.c                       |   2 +-
 arch/alpha/kernel/pci_iommu.c                      |  12 +-
 arch/arc/mm/dma.c                                  |  12 +-
 arch/arm/common/dmabounce.c                        |   4 +-
 arch/arm/include/asm/dma-mapping.h                 |  13 +--
 arch/arm/include/asm/xen/page-coherent.h           |  16 +--
 arch/arm/mm/dma-mapping.c                          | 121 ++++++++++---------
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
 arch/powerpc/platforms/cell/iommu.c                |  28 ++---
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
 include/linux/dma-attrs.h                          |  72 ------------
 include/linux/dma-iommu.h                          |   6 +-
 include/linux/dma-mapping.h                        | 128 ++++++++++++++-------
 include/linux/swiotlb.h                            |  10 +-
 include/media/videobuf2-dma-contig.h               |   7 +-
 include/rdma/ib_verbs.h                            |   8 +-
 include/xen/swiotlb-xen.h                          |  12 +-
 lib/dma-noop.c                                     |   9 +-
 lib/swiotlb.c                                      |  13 ++-
 108 files changed, 691 insertions(+), 793 deletions(-)
 delete mode 100644 include/linux/dma-attrs.h

-- 
1.9.1
