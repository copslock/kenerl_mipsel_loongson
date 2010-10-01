Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Oct 2010 22:27:52 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:8581 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492019Ab0JAU1t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Oct 2010 22:27:49 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ca644630000>; Fri, 01 Oct 2010 13:28:19 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:49 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 1 Oct 2010 13:27:49 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o91KRcQm028700;
        Fri, 1 Oct 2010 13:27:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o91KRaUQ028699;
        Fri, 1 Oct 2010 13:27:36 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 0/8] MIPS: Use dma-mapping-common.h and use swiotlb for Octeon (v2).
Date:   Fri,  1 Oct 2010 13:27:26 -0700
Message-Id: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
X-OriginalArrivalTime: 01 Oct 2010 20:27:49.0126 (UTC) FILETIME=[1D6C4A60:01CB61A7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

v2:
 o Eliminated changes to generic swiotlb code.

 o Indirect calls to phys_to_dma() and dma_to_phys() moved to Octeon
   specific code.

 o Clean up platform hook for swiotlb setup.

from v1:

The Octeon family of SOCs support physical memory outside of the
32-bit addressing range.  To support 32-bit devices, we need to use
the swiotlb bounce buffer mechanism.

There are several parts to the patch set.

1 -     Set the proper dma_masks for the octeon_mgmt platform device so
        that it continues to function with the rewritten dma mapping
        code to follow.

2,3,4 - Establish a properly constrained DMA32 zone for Octeon.

5 -     Make some existing functions static inline.

6 -     Convert MIPS to use dma-mapping-common.h

7 -     Get MIPS ready to use swiotlb.

8 -     Rewrite Octeon dma mapping code.

David Daney (8):
  MIPS: Octeon: Set dma_masks for octeon_mgmt device.
  MIPS: Allow MAX_DMA32_PFN to be overridden.
  MIPS: Octeon: Adjust top of DMA32 zone.
  MIPS: Octeon: Select ZONE_DMA32
  MIPS: ip32, ip27, jazz: Make static functions in dma-coherence.h
    inline.
  MIPS: Convert DMA to use dma-mapping-common.h
  MIPS: Add a platform hook for swiotlb setup.
  MIPS: Octeon: Rewrite DMA mapping functions.

 arch/mips/Kconfig                                  |    3 +
 arch/mips/cavium-octeon/Kconfig                    |   12 +
 arch/mips/cavium-octeon/dma-octeon.c               |  581 ++++++++++----------
 arch/mips/cavium-octeon/octeon-platform.c          |    5 +
 arch/mips/include/asm/bootinfo.h                   |   12 +
 arch/mips/include/asm/device.h                     |   15 +-
 arch/mips/include/asm/dma-mapping.h                |   96 ++--
 arch/mips/include/asm/dma.h                        |    3 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    6 +
 .../include/asm/mach-cavium-octeon/dma-coherence.h |   28 +-
 arch/mips/include/asm/mach-generic/dma-coherence.h |    6 -
 arch/mips/include/asm/mach-ip27/dma-coherence.h    |    9 +-
 arch/mips/include/asm/mach-ip32/dma-coherence.h    |   14 +-
 arch/mips/include/asm/mach-jazz/dma-coherence.h    |   11 +-
 .../mips/include/asm/mach-loongson/dma-coherence.h |    6 -
 arch/mips/include/asm/mach-powertv/dma-coherence.h |    6 -
 arch/mips/include/asm/octeon/pci-octeon.h          |   10 +
 arch/mips/kernel/setup.c                           |    1 +
 arch/mips/mm/dma-default.c                         |  165 ++----
 arch/mips/pci/pci-octeon.c                         |   60 ++-
 arch/mips/pci/pcie-octeon.c                        |    5 +
 21 files changed, 551 insertions(+), 503 deletions(-)

-- 
1.7.2.2
