Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 00:38:34 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5471 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab0IWWib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 00:38:31 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bd7050000>; Thu, 23 Sep 2010 15:39:01 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:29 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NMcNL9024738;
        Thu, 23 Sep 2010 15:38:23 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NMcIXL024737;
        Thu, 23 Sep 2010 15:38:18 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/9] MIPS: Use dma-mapping-common.h and use swiotlb for Octeon.
Date:   Thu, 23 Sep 2010 15:38:07 -0700
Message-Id: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Sep 2010 22:38:29.0221 (UTC) FILETIME=[0B2DD950:01CB5B70]
X-archive-position: 27805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18806

The Octeon family of SOCs support physical memory outside of the
32-bit addressing range.  To support 32-bit devices, we need to use
the swiotlb bounce buffer mechanism.

There are several parts to the patch set.

1 -     Set the proper dma_masks for the octeon_mgmt platform device so
        that it continues to function with the rewritten dma mapping
        code to follow.

2,3,4 - Establish a properly constrained DMA32 zone for Octeon.

5 -     Convert MIPS to use dma-mapping-common.h

6,7 -   Trivial swiotlb changes.

8 -     Get MIPS ready to use swiotlb.

9 -     Rewrite Octeon dma mapping code.

Since the only non-MIPS parts of this patch set are trivial changes to
swiotlb, I would suggest that they could all be merged via Ralf's tree
if deemed acceptable.

David Daney (9):
  MIPS: Octeon: Set dma_masks for octeon_mgmt device.
  MIPS: Allow MAX_DMA32_PFN to be overridden.
  MIPS: Octeon: Adjust top of DMA32 zone.
  MIPS: Octeon: Select ZONE_DMA32
  MIPS: Convert DMA to use dma-mapping-common.h
  swiotlb: Declare swiotlb_init_with_default_size()
  swiotlb: Make bounce buffer bounds non-static.
  MIPS: Add a platform hook for swiotlb setup.
  MIPS: Octeon: Rewrite DMA mapping functions.

 arch/mips/Kconfig                                  |    3 +
 arch/mips/cavium-octeon/Kconfig                    |   12 +
 arch/mips/cavium-octeon/dma-octeon.c               |  529 +++++++++-----------
 arch/mips/cavium-octeon/octeon-platform.c          |    5 +
 arch/mips/include/asm/bootinfo.h                   |    5 +
 arch/mips/include/asm/device.h                     |   15 +-
 arch/mips/include/asm/dma-mapping.h                |  125 ++++--
 arch/mips/include/asm/dma.h                        |    3 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    6 +
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   19 +-
 arch/mips/include/asm/octeon/pci-octeon.h          |   10 +
 arch/mips/kernel/setup.c                           |    5 +
 arch/mips/mm/dma-default.c                         |  179 +++----
 arch/mips/pci/pci-octeon.c                         |   60 ++-
 arch/mips/pci/pcie-octeon.c                        |    5 +
 include/linux/swiotlb.h                            |    7 +
 lib/swiotlb.c                                      |   62 ++--
 17 files changed, 571 insertions(+), 479 deletions(-)

-- 
1.7.2.2
