Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2012 19:32:57 +0100 (CET)
Received: from mailout4.w1.samsung.com ([210.118.77.14]:49758 "EHLO
        mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903592Ab2BJScw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2012 19:32:52 +0100
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from euspt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LZ6004RLWUDSW80@mailout4.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 10 Feb 2012 18:32:37 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LZ600EE5WUC1A@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 10 Feb 2012 18:32:37 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 69BA927006A; Fri,
 10 Feb 2012 19:49:47 +0100 (CET)
Date:   Fri, 10 Feb 2012 19:32:17 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PULL REQUEST] DMA-mapping framework redesign preparation patches
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
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
Message-id: <1328898737-15854-1-git-send-email-m.szyprowski@samsung.com>
X-Mailer: git-send-email 1.7.8.3
X-archive-position: 32416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Stephen,

Our patches with DMA-mapping framework redesign proposal have been
hanging for over a month with just a few comments. We would like to go
further in the development, but first I would like to ask You to give
them a try in the linux-next kernel.

For everyone interested in this patch series, here is the relevant
thread: https://lkml.org/lkml/2011/12/23/97

If there are any problems with our git tree, please contact Marek 
Szyprowski <m.szyprowski@samsung.com> or alternatively Kyungmin Park
<kyungmin.park@samsung.com>.

The following changes since commit 62aa2b537c6f5957afd98e29f96897419ed5ebab:

  Linux 3.3-rc2 (2012-01-31 13:31:54 -0800)

are available in the git repository at:
  git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next

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

Marek Szyprowski (5):
      common: dma-mapping: introduce alloc_attrs and free_attrs methods
      common: dma-mapping: remove old alloc_coherent and free_coherent methods
      common: dma-mapping: introduce mmap method
      common: DMA-mapping: add WRITE_COMBINE attribute
      common: DMA-mapping: add NON-CONSISTENT attribute

 Documentation/DMA-attributes.txt          |   19 +++++++++++++++++++
 arch/alpha/include/asm/dma-mapping.h      |   18 ++++++++++++------
 arch/alpha/kernel/pci-noop.c              |   10 ++++++----
 arch/alpha/kernel/pci_iommu.c             |   10 ++++++----
 arch/ia64/hp/common/sba_iommu.c           |   11 ++++++-----
 arch/ia64/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/ia64/kernel/pci-swiotlb.c            |    9 +++++----
 arch/ia64/sn/pci/pci_dma.c                |    9 +++++----
 arch/microblaze/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/microblaze/kernel/dma.c              |   10 ++++++----
 arch/mips/include/asm/dma-mapping.h       |   18 ++++++++++++------
 arch/mips/mm/dma-default.c                |    8 ++++----
 arch/powerpc/include/asm/dma-mapping.h    |   24 ++++++++++++++++--------
 arch/powerpc/kernel/dma-iommu.c           |   10 ++++++----
 arch/powerpc/kernel/dma-swiotlb.c         |    4 ++--
 arch/powerpc/kernel/dma.c                 |   10 ++++++----
 arch/powerpc/kernel/ibmebus.c             |   10 ++++++----
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
 43 files changed, 305 insertions(+), 182 deletions(-)

Best regards
Marek Szyprowski
Samsung Poland R&D Center
