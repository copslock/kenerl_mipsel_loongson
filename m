Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 15:44:33 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24066 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab2C0Nni (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 15:43:38 +0200
Received: from euspt2 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00LLYQ48JZ@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:22 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J00216Q471V@spt2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:20 +0100 (BST)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 212FB270003; Tue,
 27 Mar 2012 15:46:11 +0200 (CEST)
Date:   Tue, 27 Mar 2012 15:42:34 +0200
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 00/14] DMA-mapping framework redesign preparation
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Message-id: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.9.1
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
X-archive-position: 32777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello everyone,

This is an updated version of the DMA-mapping framework redesign
preparation patches, which resolves issues pointed by Linus:

https://lkml.org/lkml/2012/3/23/305

These patches are the first step to clean up a bit dma-mapping api and
introduce support for architecture specific performance improving hints
in a generic way.

For more information please refer to the thread with the first version
of the patches:

https://lkml.org/lkml/2011/12/23/97


Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Andrzej Pietrasiewicz (8):
  X86 & IA64: adapt for dma_map_ops changes
  MIPS: adapt for dma_map_ops changes
  PowerPC: adapt for dma_map_ops changes
  SPARC: adapt for dma_map_ops changes
  Alpha: adapt for dma_map_ops changes
  SH: adapt for dma_map_ops changes
  Microblaze: adapt for dma_map_ops changes
  Unicore32: adapt for dma_map_ops changes

Marek Szyprowski (6):
  common: dma-mapping: introduce alloc_attrs and free_attrs methods
  Hexagon: adapt for dma_map_ops changes
  common: dma-mapping: remove old alloc_coherent and free_coherent
    methods
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
 arch/ia64/kernel/pci-swiotlb.c            |   14 +++++++++++---
 arch/ia64/sn/pci/pci_dma.c                |    9 +++++----
 arch/microblaze/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/microblaze/kernel/dma.c              |   10 ++++++----
 arch/mips/cavium-octeon/dma-octeon.c      |   12 ++++++------
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
 arch/unicore32/mm/dma-swiotlb.c           |   18 ++++++++++++++++--
 arch/x86/include/asm/dma-mapping.h        |   26 ++++++++++++++++----------
 arch/x86/kernel/amd_gart_64.c             |   11 ++++++-----
 arch/x86/kernel/pci-calgary_64.c          |    9 +++++----
 arch/x86/kernel/pci-dma.c                 |    3 ++-
 arch/x86/kernel/pci-nommu.c               |    6 +++---
 arch/x86/kernel/pci-swiotlb.c             |   17 +++++++++++++----
 arch/x86/xen/pci-swiotlb-xen.c            |    4 ++--
 drivers/iommu/amd_iommu.c                 |   10 ++++++----
 drivers/iommu/intel-iommu.c               |    9 +++++----
 drivers/xen/swiotlb-xen.c                 |    5 +++--
 include/linux/dma-attrs.h                 |    2 ++
 include/linux/dma-mapping.h               |   13 +++++++++----
 include/xen/swiotlb-xen.h                 |    6 ++++--
 45 files changed, 355 insertions(+), 198 deletions(-)

-- 
1.7.1.569.g6f426
