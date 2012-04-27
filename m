Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2012 15:48:27 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:27411 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903618Ab2D0Nrt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Apr 2012 15:47:49 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 27 Apr 2012 06:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="134433552"
Received: from blue.fi.intel.com ([10.237.72.50])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2012 06:47:40 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: [PATCH 2/2] MIPS: bcm63xx: kbuild: remove -Werror
Date:   Fri, 27 Apr 2012 16:48:30 +0300
Message-Id: <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
X-archive-position: 33027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>

I cannot build bcm963xx with the standard Kbuild W=1 switch:

arch/mips/bcm63xx/boards/board_bcm963xx.c: At top level:
arch/mips/bcm63xx/boards/board_bcm963xx.c:647:5: error: no previous prototype for 'bcm63xx_get_fallback_sprom' [-Werror=missing-prototypes]
cc1: all warnings being treated as errors

This patch removes the gcc switch to make W=1 work. Mips is the only
architecture I know which does not build with W=1 and this upsets my aiaiai
scripts. And in general, you never know which warnings newer versions of gcc
will start emiting so having -Werror by default is not the best idea.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 arch/mips/bcm63xx/boards/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/Makefile b/arch/mips/bcm63xx/boards/Makefile
index 9f64fb4..af07c1a 100644
--- a/arch/mips/bcm63xx/boards/Makefile
+++ b/arch/mips/bcm63xx/boards/Makefile
@@ -1,3 +1 @@
 obj-$(CONFIG_BOARD_BCM963XX)		+= board_bcm963xx.o
-
-ccflags-y := -Werror
-- 
1.7.9.1
