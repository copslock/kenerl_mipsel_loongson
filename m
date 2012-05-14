Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 19:51:48 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:36744 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903706Ab2ENRuu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 19:50:50 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-mtd@lists.infradead.org
Subject: [RESEND PATCH V2 14/17] MTD: MIPS: lantiq: verify that the NOR interface is available on falcon soc
Date:   Mon, 14 May 2012 19:42:40 +0200
Message-Id: <1337017363-14424-14-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.9.1
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
X-archive-position: 33307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

When running on a FALC-ON SoC, we need to check the bootstrap options to see
if NOR is available.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mtd@lists.infradead.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

 drivers/mtd/maps/lantiq-flash.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index aefa111..c03456f 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -19,6 +19,7 @@
 #include <linux/mtd/cfi.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
+#include <linux/of.h>
 
 #include <lantiq_soc.h>
 
@@ -116,6 +117,12 @@ ltq_mtd_probe(struct platform_device *pdev)
 	struct cfi_private *cfi;
 	int err;
 
+	if (of_machine_is_compatible("lantiq,falcon") &&
+			(ltq_boot_select() != BS_FLASH)) {
+		dev_err(&pdev->dev, "invalid bootstrap options\n");
+		return -ENODEV;
+	}
+
 	ltq_mtd = kzalloc(sizeof(struct ltq_mtd), GFP_KERNEL);
 	platform_set_drvdata(pdev, ltq_mtd);
 
-- 
1.7.9.1
