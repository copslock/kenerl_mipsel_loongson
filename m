Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2012 08:25:05 +0100 (CET)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:60591 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903601Ab2CTHY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2012 08:24:57 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1600EZT9X76R40@mailout3.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 20 Mar 2012 07:24:43 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M16007EE9XAS4@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 20 Mar 2012 07:24:47 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 5AD4D270051; Tue,
 20 Mar 2012 08:38:41 +0100 (CET)
Date:   Tue, 20 Mar 2012 08:24:43 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [GIT PULL] DMA-mapping framework updates for 3.4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 32732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Linus,

Please pull the dma-mapping framework updates for v3.4 since commit
c16fa4f2ad19908a47c63d8fa436a1178438c7e7:

  Linux 3.3

with the top-most commit e749a9f707f1102735e02338fa564be86be3bb69

  common: DMA-mapping: add NON-CONSISTENT attribute

from the git repository at:

  git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next

Those patches introduce a new alloc method (with support for memory
attributes) in dma_map_ops structure, which will later replace
dma_alloc_coherent and dma_alloc_writecombine functions.

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center

Patch summary:

Andrzej Pietrasiewicz (9):
      X86: adapt for dma_map_ops changes
      MIPS: adapt for dma_map_ops changes
      PowerPC: adapt for dma_map_ops changes
      IA64: adapt for dma_map_ops changes
      SPARC: adapt for dma_map_ops changes
      Alpha: adapt for dma_map_ops changes
      SH: adapt for dma_map_ops changes
      Microblaze: adapt for dma_map_ops changes
      Unicore32: adapt for dma_map_ops changes

Marek Szyprowski (6):
      common: dma-mapping: introduce alloc_attrs and free_attrs methods
      Hexagon: adapt for dma_map_ops changes
      common: dma-mapping: remove old alloc_coherent and free_coherent methods
      common: dma-mapping: introduce mmap method
      common: DMA-mapping: add WRITE_COMBINE attribute
      common: DMA-mapping: add NON-CONSISTENT attribute

 Documentation/DMA-attributes.txt          |   19 +++++++++++++++++++
 arch/alpha/include/asm/dma-mapping.h      |   18 ++++++++++++------
 arch/alpha/kernel/pci-noop.c              |   10 ++++++----
 arch/alpha/kernel/pci_iommu.c             |   10 ++++++----
 arch/hexagon/include/asm/dma-mapping.h    |   18 ++++++++++++------
 arch/hexagon/kernel/dma.c                 |    9 +++++----
 arch/ia64/hp/common/sba_iommu.c           |   11 ++++++-----
 arch/ia64/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/ia64/kernel/pci-swiotlb.c            |    9 +++++----
 arch/ia64/sn/pci/pci_dma.c                |    9 +++++----
 arch/microblaze/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/microblaze/kernel/dma.c              |   10 ++++++----
 arch/mips/cavium-octeon/dma-octeon.c      |   16 ++++++++--------
 arch/mips/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/mips/mm/dma-default.c                |    8 ++++----
 arch/powerpc/include/asm/dma-mapping.h    |   24 ++++++++++++++++--------
 arch/powerpc/kernel/dma-iommu.c           |   10 ++++++----
 arch/powerpc/kernel/dma-swiotlb.c         |    4 ++--
 arch/powerpc/kernel/dma.c                 |   10 ++++++----
 arch/powerpc/kernel/ibmebus.c             |   10 ++++++----
 arch/powerpc/kernel/vio.c                 |   14 ++++++++------
 arch/powerpc/platforms/cell/iommu.c       |   16 +++++++++-------
 arch/powerpc/platforms/ps3/system-bus.c   |   13 +++++++------
 arch/sh/include/asm/dma-mapping.h         |   28 ++++++++++++++++++----------
 arch/sh/kernel/dma-nommu.c                |    4 ++--
 arch/sh/mm/consistent.c                   |    6 ++++--
 arch/sparc/include/asm/dma-mapping.h      |   18 ++++++++++++------
 arch/sparc/kernel/iommu.c                 |   10 ++++++----
 arch/sparc/kernel/ioport.c                |   18 ++++++++++--------
 arch/sparc/kernel/pci_sun4v.c             |    9 +++++----
 arch/unicore32/include/asm/dma-mapping.h  |   18 ++++++++++++------
 arch/unicore32/mm/dma-swiotlb.c           |    4 ++--
 arch/x86/include/asm/dma-mapping.h        |   26 ++++++++++++++++----------
 arch/x86/kernel/amd_gart_64.c             |   11 ++++++-----
 arch/x86/kernel/pci-calgary_64.c          |    9 +++++----
 arch/x86/kernel/pci-dma.c                 |    3 ++-
 arch/x86/kernel/pci-nommu.c               |    6 +++---
 arch/x86/kernel/pci-swiotlb.c             |   12 +++++++-----
 arch/x86/xen/pci-swiotlb-xen.c            |    4 ++--
 drivers/iommu/amd_iommu.c                 |   10 ++++++----
 drivers/iommu/intel-iommu.c               |    9 +++++----
 drivers/xen/swiotlb-xen.c                 |    5 +++--
 include/linux/dma-attrs.h                 |    2 ++
 include/linux/dma-mapping.h               |   13 +++++++++----
 include/linux/swiotlb.h                   |    6 ++++--
 include/xen/swiotlb-xen.h                 |    6 ++++--
 lib/swiotlb.c                             |    5 +++--
 47 files changed, 338 insertions(+), 206 deletions(-)
