Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jul 2018 11:51:57 +0200 (CEST)
Received: from mail.bootlin.com ([62.4.15.54]:59685 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994677AbeGEJqBoafXY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Jul 2018 11:46:01 +0200
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3D4622093A; Thu,  5 Jul 2018 11:45:55 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-39-106.w90-88.abo.wanadoo.fr [90.88.158.106])
        by mail.bootlin.com (Postfix) with ESMTPSA id 63AD020908;
        Thu,  5 Jul 2018 11:45:29 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 21/27] bcma: Allow selection of this driver when COMPILE_TEST=y
Date:   Thu,  5 Jul 2018 11:45:16 +0200
Message-Id: <20180705094522.12138-22-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705094522.12138-1-boris.brezillon@bootlin.com>
References: <20180705094522.12138-1-boris.brezillon@bootlin.com>
Return-Path: <boris.brezillon@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@bootlin.com
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

This allows us to increase compile-test coverage without having to build
a kernel for MIPS.  That's particularly interesting for subsystem
maintainers that want to test as many drivers as possible in a single
build.

We also add a dependency on HAS_IOMEM in BCMA_HOST_SOC to make sure the
driver is not selected when the arch does not implement IO accessors.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/bcma/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
index cb0f1aad20b7..b9558ff20830 100644
--- a/drivers/bcma/Kconfig
+++ b/drivers/bcma/Kconfig
@@ -30,6 +30,7 @@ config BCMA_HOST_PCI
 
 config BCMA_HOST_SOC
 	bool "Support for BCMA in a SoC"
+	depends on HAS_IOMEM
 	help
 	  Host interface for a Broadcom AIX bus directly mapped into
 	  the memory. This only works with the Broadcom SoCs from the
@@ -61,7 +62,7 @@ config BCMA_DRIVER_PCI_HOSTMODE
 
 config BCMA_DRIVER_MIPS
 	bool "BCMA Broadcom MIPS core driver"
-	depends on MIPS
+	depends on MIPS || COMPILE_TEST
 	help
 	  Driver for the Broadcom MIPS core attached to Broadcom specific
 	  Advanced Microcontroller Bus.
-- 
2.14.1
