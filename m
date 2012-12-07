Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:30:34 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60436 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816521Ab2LGFadb3k4p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:30:33 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1TgqW3-0007R1-DC; Thu, 06 Dec 2012 23:30:27 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 0/2] Support ASID size determination at boot time.
Date:   Thu,  6 Dec 2012 23:30:20 -0600
Message-Id: <1354858222-29519-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
X-archive-position: 35236
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

With the release of the new Aptiv cores from MIPS Technologies, Inc.
the ASID size must be determined at boot time and cannot simply be
hardcoded as before. This has been tested on our Malta and SEAD-3
platforms with 1004K, 1074K, M14KEc, proAptiv and interAptiv cores.

Steven J. Hill (2):
  MIPS: Allow ASID size to be determined at boot time.
  MIPS: microMIPS: Support dynamic ASID sizing.

 arch/mips/include/asm/mmu_context.h |   84 ++++++++++++++++++++++-------------
 arch/mips/kernel/genex.S            |    2 +-
 arch/mips/kernel/traps.c            |    6 ++-
 arch/mips/lib/dump_tlb.c            |    5 ++-
 arch/mips/lib/r3k_dump_tlb.c        |    6 +--
 arch/mips/mm/tlb-r3k.c              |   20 ++++-----
 arch/mips/mm/tlb-r4k.c              |    2 +-
 arch/mips/mm/tlb-r8k.c              |    2 +-
 arch/mips/mm/tlbex.c                |   80 +++++++++++++++++++++++++++++++++
 9 files changed, 156 insertions(+), 51 deletions(-)

-- 
1.7.9.5
