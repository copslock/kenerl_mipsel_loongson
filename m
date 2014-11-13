Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 16:53:30 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:38132 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013631AbaKMPwTsorEK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 16:52:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1Xowgu-0007pf-7s; Thu, 13 Nov 2014 09:52:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V2 0/8] Add support for eXtended Physical Addressing.
Date:   Thu, 13 Nov 2014 09:51:56 -0600
Message-Id: <1415893924-36351-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This set of patches adds XPA support for R5 and later cores. This
has been tested on P5600 platforms only. As noted in the main
commit for XPA support, EVA and XPA cannot currently be used at
the same time.

Changes from V1:
 - Remove fixrange_init() revert patch.
 - Remove CCA patch.
 - Remove HEAP/BSS execute bit removal patch.
 - Updated __writex_32bit_c0_register() to use %1 instead of
   the macro variable name.

Leonid Yegoshin (2):
  MIPS: HIGHMEM fixes for cache aliasing and non-DMA I/O.
  MIPS: Rearrange PTE bits into fixed positions for MIPS R2.

Steven J. Hill (6):
  MIPS: Add CP0 macros for extended EntryLo registers
  MIPS: Fix address type used for early memory detection.
  MIPS: Cosmetic cleanups of page table headers.
  MIPS: Add MFHC0 and MTHC0 instructions to uasm.
  MIPS: Add support for XPA.
  MIPS: XPA: Add new configuration file.

 arch/mips/Kconfig                       |   35 ++++++
 arch/mips/configs/maltaup_xpa_defconfig |  195 +++++++++++++++++++++++++++++++
 arch/mips/include/asm/cacheflush.h      |    3 +-
 arch/mips/include/asm/cpu-features.h    |    9 ++
 arch/mips/include/asm/cpu.h             |    1 +
 arch/mips/include/asm/fixmap.h          |   14 ++-
 arch/mips/include/asm/highmem.h         |   44 ++++++-
 arch/mips/include/asm/mipsregs.h        |   40 +++++++
 arch/mips/include/asm/page.h            |    5 +-
 arch/mips/include/asm/pgtable-32.h      |  109 ++++++++---------
 arch/mips/include/asm/pgtable-bits.h    |  142 +++++++++++++++++++---
 arch/mips/include/asm/pgtable.h         |   42 +++----
 arch/mips/include/asm/uasm.h            |    2 +
 arch/mips/include/uapi/asm/inst.h       |    7 +-
 arch/mips/kernel/cpu-probe.c            |    8 ++
 arch/mips/kernel/proc.c                 |    1 +
 arch/mips/kernel/setup.c                |    2 +-
 arch/mips/mm/c-r4k.c                    |   40 ++++++-
 arch/mips/mm/cache.c                    |   83 +++++++++----
 arch/mips/mm/highmem.c                  |   46 +++-----
 arch/mips/mm/init.c                     |   42 ++++---
 arch/mips/mm/sc-mips.c                  |    1 +
 arch/mips/mm/tlb-r4k.c                  |   12 ++
 arch/mips/mm/tlbex.c                    |   88 +++++++++++---
 arch/mips/mm/uasm-mips.c                |    2 +
 arch/mips/mm/uasm.c                     |   14 ++-
 26 files changed, 797 insertions(+), 190 deletions(-)
 create mode 100644 arch/mips/configs/maltaup_xpa_defconfig

-- 
1.7.10.4
