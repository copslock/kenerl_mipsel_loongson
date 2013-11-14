Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2013 17:12:48 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:1073 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835101Ab3KNQMmKmoiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 Nov 2013 17:12:42 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH v2 00/12] Add support for the proAptiv cores
Date:   Thu, 14 Nov 2013 16:12:20 +0000
Message-ID: <1384445552-30573-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_14_16_12_36
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

This is v2 of my previous patchset for adding support for the
proAptiv cores.

v2:
Review comments:
http://www.linux-mips.org/archives/linux-mips/2013-11/msg00067.html
http://www.linux-mips.org/archives/linux-mips/2013-11/msg00065.html

- Split proAptiv support into smaller patches
-- Add TLBINV feature
-- Add Segmentation Control feature
-- Use EHINV for TLB invalidation
-- Add proAptiv processor PRIDs
-- Add support for proAptiv cores
-- Probe for proAptiv cores
- Drop pr_info() from probe functions
- Split TLBINV usage into smaller patches
-- Add function for using the TLBINVF instruction for flushing the TLB
-- Use that function for TLBINVF capable cores to flush the TLB

Leonid Yegoshin (9):
  MIPS: Add missing bits for Config registers
  MIPS: features: Add initial support for TLBINVF capable cores
  MIPS: tlb: Set the EHINV bit for TLBINVF cores when invalidating the
    TLB
  MIPS: Add processor identifiers for the proAptiv processors
  MIPS: Add support for the proAptiv cores
  MIPS: kernel: cpu-probe: Add support for probing proAptiv cores
  MIPS: Add function for flushing the TLB using the TLBINV instruction
  MIPS: mm: Use the TLBINVF instruction to flush the VTLB
  MIPS: Add support for FTLBs

Markos Chandras (1):
  MIPS: mm: Move UNIQUE_ENTRYHI macro to a header file

Steven J. Hill (2):
  MIPS: features: Add initial support for Segmentation Control registers
  MIPS: Add debugfs file to print the segmentation control registers

 arch/mips/include/asm/cpu-features.h |   7 +++
 arch/mips/include/asm/cpu-info.h     |   3 +
 arch/mips/include/asm/cpu-type.h     |   1 +
 arch/mips/include/asm/cpu.h          |   6 +-
 arch/mips/include/asm/mipsregs.h     |  84 +++++++++++++++++++++++++-
 arch/mips/include/asm/page.h         |  25 ++++++++
 arch/mips/include/asm/tlb.h          |   4 ++
 arch/mips/kernel/Makefile            |   1 +
 arch/mips/kernel/cpu-probe.c         |  93 +++++++++++++++++++++++++++--
 arch/mips/kernel/genex.S             |   1 +
 arch/mips/kernel/idle.c              |   1 +
 arch/mips/kernel/segment.c           | 110 +++++++++++++++++++++++++++++++++++
 arch/mips/kernel/spram.c             |   1 +
 arch/mips/kernel/traps.c             |  31 ++++++++++
 arch/mips/mm/c-r4k.c                 |   1 +
 arch/mips/mm/init.c                  |   2 -
 arch/mips/mm/sc-mips.c               |   1 +
 arch/mips/mm/tlb-r4k.c               |  48 ++++++++++-----
 arch/mips/mm/tlbex.c                 |   1 +
 arch/mips/oprofile/common.c          |   1 +
 arch/mips/oprofile/op_model_mipsxx.c |   4 ++
 21 files changed, 399 insertions(+), 27 deletions(-)
 create mode 100644 arch/mips/kernel/segment.c

-- 
1.8.4.3
