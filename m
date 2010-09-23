Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2010 00:38:57 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5473 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491144Ab0IWWib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Sep 2010 00:38:31 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c9bd7060000>; Thu, 23 Sep 2010 15:39:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:29 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 23 Sep 2010 15:38:29 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o8NMcOAZ024742;
        Thu, 23 Sep 2010 15:38:24 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o8NMcOGp024741;
        Thu, 23 Sep 2010 15:38:24 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/9] MIPS: Octeon: Set dma_masks for octeon_mgmt device.
Date:   Thu, 23 Sep 2010 15:38:08 -0700
Message-Id: <1285281496-24696-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
References: <1285281496-24696-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 23 Sep 2010 22:38:29.0549 (UTC) FILETIME=[0B5FE5D0:01CB5B70]
X-archive-position: 27806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18812

This allows follow-on patches to dma mapping functions to work with
the octeon mgmt device..

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/octeon-platform.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 62ac30e..c32d40d 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
@@ -301,6 +302,10 @@ static int __init octeon_mgmt_device_init(void)
 			ret = -ENOMEM;
 			goto out;
 		}
+		/* No DMA restrictions */
+		pd->dev.coherent_dma_mask = DMA_BIT_MASK(64);
+		pd->dev.dma_mask = &pd->dev.coherent_dma_mask;
+
 		switch (port) {
 		case 0:
 			mgmt_port_resource.start = OCTEON_IRQ_MII0;
-- 
1.7.2.2
