Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2016 22:32:28 +0200 (CEST)
Received: from mail5.windriver.com ([192.103.53.11]:33298 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992492AbcHOUbfHsKGS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2016 22:31:35 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u7FKVR1k030459
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 15 Aug 2016 13:31:28 -0700
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.248.2; Mon, 15 Aug 2016 13:31:26 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4/4] mips: lantiq: make xrx200_phy_fw explicitly non-modular
Date:   Mon, 15 Aug 2016 16:30:55 -0400
Message-ID: <20160815203055.20541-5-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160815203055.20541-1-paul.gortmaker@windriver.com>
References: <20160815203055.20541-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

The Kconfig currently controlling compilation of this code is:

arch/mips/lantiq/Kconfig:config XRX200_PHY_FW
arch/mips/lantiq/Kconfig:       bool "XRX200 PHY firmware loader"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

Since module_platform_driver() uses the same init level priority as
builtin_platform_driver() the init ordering remains unchanged with
this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We also delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We don't replace module.h with init.h since the file doesn't need that.

Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/lantiq/xway/xrx200_phy_fw.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/lantiq/xway/xrx200_phy_fw.c b/arch/mips/lantiq/xway/xrx200_phy_fw.c
index 71e518c1e7e7..f0a0f2d431b2 100644
--- a/arch/mips/lantiq/xway/xrx200_phy_fw.c
+++ b/arch/mips/lantiq/xway/xrx200_phy_fw.c
@@ -1,4 +1,7 @@
 /*
+ * Lantiq XRX200 PHY Firmware Loader
+ * Author: John Crispin
+ *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License version 2 as published
  *  by the Free Software Foundation.
@@ -8,7 +11,6 @@
 
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/of_platform.h>
 
@@ -100,7 +102,6 @@ static const struct of_device_id xway_phy_match[] = {
 	{ .compatible = "lantiq,phy-xrx200" },
 	{},
 };
-MODULE_DEVICE_TABLE(of, xway_phy_match);
 
 static struct platform_driver xway_phy_driver = {
 	.probe = xway_phy_fw_probe,
@@ -109,9 +110,4 @@ static struct platform_driver xway_phy_driver = {
 		.of_match_table = xway_phy_match,
 	},
 };
-
-module_platform_driver(xway_phy_driver);
-
-MODULE_AUTHOR("John Crispin <john@phrozen.org>");
-MODULE_DESCRIPTION("Lantiq XRX200 PHY Firmware Loader");
-MODULE_LICENSE("GPL");
+builtin_platform_driver(xway_phy_driver);
-- 
2.8.4
