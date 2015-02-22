Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2015 07:36:44 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60491 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006757AbbBVGgmpN4HY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Feb 2015 07:36:42 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1YPQ60-0000CY-9C; Sun, 22 Feb 2015 00:32:52 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH V5 0/3] Add support for eXtended Physical Addressing.
Date:   Sun, 22 Feb 2015 00:36:25 -0600
Message-Id: <1424586988-21544-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45882
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

Changes from V4:
 - Rebased against 'mips-for-linux-next-test' branch.
 - Fix all build breakages from PTE fixed bit positions patch.
 - Make some code be used for R2 or newer cores.

Changes from V3:
 - Rebased against upstream 3.19-rc4 tag.

Changes from V2:
 - Moved HIGHMEM and cache flush fixes to separate patchset.
 - Rebased against 3.19-rc5 tag.

Changes from V1:
 - Remove fixrange_init() revert patch.
 - Remove CCA patch.
 - Remove HEAP/BSS execute bit removal patch.
 - Updated __writex_32bit_c0_register() to use %1 instead of
   the macro variable name.

Steven J. Hill (3):
  MIPS: Rearrange PTE bits into fixed positions.
  MIPS: Add support for XPA.
  MIPS: XPA: Add new configuration file.

 arch/mips/Kconfig                       |   35 +++
 arch/mips/configs/maltaup_xpa_defconfig |  440 +++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-features.h    |    3 +
 arch/mips/include/asm/cpu.h             |    1 +
 arch/mips/include/asm/pgtable-32.h      |   15 +-
 arch/mips/include/asm/pgtable-bits.h    |  102 ++++---
 arch/mips/include/asm/pgtable.h         |   56 ++--
 arch/mips/kernel/cpu-probe.c            |    4 +
 arch/mips/kernel/proc.c                 |    1 +
 arch/mips/mm/init.c                     |    7 +-
 arch/mips/mm/tlb-r4k.c                  |   12 +
 arch/mips/mm/tlbex.c                    |   88 ++++++-
 12 files changed, 674 insertions(+), 90 deletions(-)
 create mode 100644 arch/mips/configs/maltaup_xpa_defconfig

-- 
1.7.10.4
