Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Feb 2015 17:19:06 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24661 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013226AbbBSQTBj6LCP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Feb 2015 17:19:01 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A4D84687FD5F
        for <linux-mips@linux-mips.org>; Thu, 19 Feb 2015 16:18:51 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 19 Feb
 2015 16:18:54 +0000
Received: from solomon.ba.imgtec.org (10.20.78.13) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 19 Feb
 2015 08:18:51 -0800
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH V4 0/5] Add support for eXtended Physical Addressing.
Date:   Thu, 19 Feb 2015 10:18:49 -0600
Message-ID: <1424362734-30364-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.13]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45861
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

This set of patches adds XPA support for R5 and later cores. This
has been tested on P5600 platforms only. As noted in the main
commit for XPA support, EVA and XPA cannot currently be used at
the same time.

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

Steven J. Hill (5):
  MIPS: Usage and cosmetic cleanups of page table bits.
  MIPS: Rearrange PTE bits into fixed positions.
  MIPS: Add set/clear CP0 macros for PageGrain register
  MIPS: Add support for XPA.
  MIPS: XPA: Add new configuration file.

 arch/mips/Kconfig                       |   35 +++
 arch/mips/configs/maltaup_xpa_defconfig |  440 +++++++++++++++++++++++++++++++
 arch/mips/include/asm/cpu-features.h    |    3 +
 arch/mips/include/asm/cpu.h             |    1 +
 arch/mips/include/asm/mipsregs.h        |    1 +
 arch/mips/include/asm/pgtable-32.h      |   23 +-
 arch/mips/include/asm/pgtable-bits.h    |  180 +++++++------
 arch/mips/include/asm/pgtable.h         |   40 ++-
 arch/mips/kernel/cpu-probe.c            |    6 +-
 arch/mips/kernel/proc.c                 |    1 +
 arch/mips/mm/init.c                     |    7 +-
 arch/mips/mm/tlb-r4k.c                  |   18 +-
 arch/mips/mm/tlbex.c                    |   88 ++++++-
 13 files changed, 705 insertions(+), 138 deletions(-)
 create mode 100644 arch/mips/configs/maltaup_xpa_defconfig

-- 
1.7.10.4
