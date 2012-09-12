Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 19:02:39 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33958 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903349Ab2ILRCG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 19:02:06 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TBqK6-0003K9-1C; Wed, 12 Sep 2012 12:01:58 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 0/2] Add RI and XI bits to MIPS base architecture.
Date:   Wed, 12 Sep 2012 12:01:47 -0500
Message-Id: <1347469309-11468-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 34480
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

This patchset obsoletes the previous patchset with four commits.

Signed-off-by: Steven J. Hill <sjhill@mips.com>

Steven J. Hill (2):
  MIPS: Add base architecture support for RI and XI.
  MIPS: Replace 'kernel_uses_smartmips_rixi' with 'cpu_has_rixi'.

 arch/mips/include/asm/cpu-features.h               |    4 ++--
 arch/mips/include/asm/cpu.h                        |    1 +
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    2 +-
 arch/mips/include/asm/mipsregs.h                   |    1 +
 arch/mips/include/asm/pgtable-bits.h               |   18 +++++++++---------
 arch/mips/include/asm/pgtable.h                    |   12 ++++++------
 arch/mips/kernel/cpu-probe.c                       |    6 +++++-
 arch/mips/mm/cache.c                               |    2 +-
 arch/mips/mm/fault.c                               |    2 +-
 arch/mips/mm/tlb-r4k.c                             |    2 +-
 arch/mips/mm/tlbex.c                               |   14 +++++++-------
 11 files changed, 35 insertions(+), 29 deletions(-)

-- 
1.7.9.5
