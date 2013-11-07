Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Nov 2013 18:10:03 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43745 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817088Ab3KGRJ56jUUf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 7 Nov 2013 18:09:57 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 0/6] Add support for the proAptiv core
Date:   Thu, 7 Nov 2013 17:08:34 +0000
Message-ID: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_11_07_17_09_52
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38478
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

The following patchset adds support for the proAptiv core.

The proAptiv Multiprocessing System is a power efficient multi-core
microprocessor for use in system-on-chip (SoC) applications.
The proAptiv Multiprocessing System combines a deep pipeline
with multi-issue out of order execution for improved computational
throughput. The proAptiv Multiprocessing System can contain one to
six MIPS32r3 proAptiv cores, system level coherence
manager with L2 cache, optional coherent I/O port, and optional
floating point unit.

http://www.imgtec.com/mips/mips-proaptiv.asp

Leonid Yegoshin (4):
  MIPS: Add missing bits for Config registers
  MIPS: Add support for the proAptiv cores
  MIPS: mm: Use the TLBINVF instruction to flush the VTLB
  MIPS: Add support for FTLBs

Markos Chandras (1):
  MIPS: mm: Move UNIQUE_ENTRYHI macro to a header file

Steven J. Hill (1):
  MIPS: Add debugfs file to print the segmentation control registers

 arch/mips/include/asm/cpu-features.h |   7 +++
 arch/mips/include/asm/cpu-info.h     |   3 +
 arch/mips/include/asm/cpu-type.h     |   1 +
 arch/mips/include/asm/cpu.h          |   6 +-
 arch/mips/include/asm/mipsregs.h     |  84 +++++++++++++++++++++++++-
 arch/mips/include/asm/page.h         |  25 ++++++++
 arch/mips/include/asm/tlb.h          |   4 ++
 arch/mips/kernel/Makefile            |   1 +
 arch/mips/kernel/cpu-probe.c         | 101 ++++++++++++++++++++++++++++++--
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
 arch/mips/oprofile/op_model_mipsxx.c |   4 ++
 20 files changed, 406 insertions(+), 27 deletions(-)
 create mode 100644 arch/mips/kernel/segment.c

-- 
1.8.4
