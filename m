Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2012 12:35:45 +0100 (CET)
Received: from mga03.intel.com ([143.182.124.21]:11149 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903567Ab2CILfi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2012 12:35:38 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 09 Mar 2012 03:35:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="116788455"
Received: from blue.fi.intel.com ([10.237.72.50])
  by azsmga001.ch.intel.com with ESMTP; 09 Mar 2012 03:35:30 -0800
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-mips@linux-mips.org
Subject: [PATCH] MIPS: Kbuild: remove -Werror
Date:   Fri,  9 Mar 2012 13:35:47 +0200
Message-Id: <1331292947-14913-1-git-send-email-dedekind1@gmail.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 32625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

MIPS does not build with the standard W=1 Kbuild switch with - tested with
gcc-4.6 by me and gcc-4.5 by John Crispin. The reason is that MIPS adds
-Werror build option.

This patch removes the option to make W=1 work. I do compile-tests for various
architecture before accepting MTD patches and I have scripts which build before
applying the patch, then after, and then compare 2 build logs and report about
new warnings. I use W=1 to see more warnings in the logs diff. And from my
perspective all platforms should build with W=1.

The other way would be to fix all warnings, but there are false positives, and
it is too difficult to maintain the code warning-free, so it is easier to just
remove -Werror.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/mips/Kbuild |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index 7dd65cf..0d37730 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -1,8 +1,3 @@
-# Fail on warnings - also for files referenced in subdirs
-# -Werror can be disabled for specific files using:
-# CFLAGS_<file.o> := -Wno-error
-subdir-ccflags-y := -Werror
-
 # platform specific definitions
 include arch/mips/Kbuild.platforms
 obj-y := $(platform-y)
-- 
1.7.9.1
