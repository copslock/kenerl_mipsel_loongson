Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2012 22:28:19 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:56491 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903404Ab2IEU2L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2012 22:28:11 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1T9MCh-0004QI-Ve; Wed, 05 Sep 2012 15:28:03 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 0/4] Add RI and XI bits to MIPS base architecture.
Date:   Wed,  5 Sep 2012 15:27:54 -0500
Message-Id: <1346876878-25965-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add MIPSr3(TM) base architecture TLB support for Read Inhibit (RI)
and Execute Inhibit (XI) page protection. SmartMIPS cores will not
notice any change in functionality.

Signed-off-by: Steven J. Hill <sjhill@mips.com>

Steven J. Hill (4):
  MIPS: Add base architecture support for RI and XI.
  MIPS: Remove kernel_uses_smartmips_rixi use from arch/mips/mm.
  MIPS: Remove kernel_uses_smartmips_rixi from page table bits.
  MIPS: Remove kernel_uses_smartmips_rixi macro definition.

 arch/mips/include/asm/cpu-features.h               |    7 ++++--
 arch/mips/include/asm/cpu.h                        |    2 ++
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 --
 arch/mips/include/asm/mipsregs.h                   |    1 +
 arch/mips/include/asm/pgtable-bits.h               |   24 ++++++++++++--------
 arch/mips/include/asm/pgtable.h                    |   12 +++++-----
 arch/mips/kernel/cpu-probe.c                       |   12 +++++++++-
 arch/mips/mm/cache.c                               |    2 +-
 arch/mips/mm/fault.c                               |    4 +++-
 arch/mips/mm/tlb-r4k.c                             |    7 ++++--
 arch/mips/mm/tlbex.c                               |   14 ++++++------
 11 files changed, 55 insertions(+), 32 deletions(-)

-- 
1.7.9.5
