Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 15:47:57 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:27411 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903615Ab2D0Nrs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 15:47:48 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 27 Apr 2012 06:47:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="134433536"
Received: from blue.fi.intel.com ([10.237.72.50])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2012 06:47:38 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: [PATCH 1/2] MIPS: Kbuild: remove -Werror
Date:   Fri, 27 Apr 2012 16:48:29 +0300
Message-Id: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

MIPS build fails with the standard W=1 Kbuild switch with because of the
-Werror gcc switch.

This patch removes the gcc switch to make W=1 work. Mips is the only
architecture I know which does not build with W=1 and this upsets my aiaiai
scripts. And in general, you never know which warnings newer versions of gcc
will start emiting so having -Werror by default is not the best idea.

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
