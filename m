Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 12:53:11 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:57273 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903627Ab2EHKxG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 12:53:06 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 08 May 2012 03:52:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="138150219"
Received: from blue.fi.intel.com ([10.237.72.50])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2012 03:52:57 -0700
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     MTD Maling List <linux-mtd@lists.infradead.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Subject: [PATCH] mtd: xway_nand: add OF dependency
Date:   Tue,  8 May 2012 13:53:56 +0300
Message-Id: <1336474436-9755-1-git-send-email-dedekind1@gmail.com>
X-Mailer: git-send-email 1.7.9.1
X-archive-position: 33187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

xway_nand.c requires OF support - add dependency in Kconfig.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/mtd/nand/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index fd4d064..eacf379 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -569,7 +569,7 @@ config MTD_NAND_FSMC
 
 config MTD_NAND_XWAY
 	tristate "Support for NAND on Lantiq XWAY SoC"
-	depends on LANTIQ && SOC_TYPE_XWAY
+	depends on LANTIQ && SOC_TYPE_XWAY && OF
 	select MTD_NAND_PLATFORM
 	help
 	  Enables support for NAND Flash chips on Lantiq XWAY SoCs. NAND is attached
-- 
1.7.9.1
