Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2012 21:10:09 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:42541 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903720Ab2CKUJA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Mar 2012 21:09:00 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 8A8D28F62;
        Sun, 11 Mar 2012 21:09:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zZ3kZcVTQp9V; Sun, 11 Mar 2012 21:08:46 +0100 (CET)
Received: from localhost.localdomain (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 192598F63;
        Sun, 11 Mar 2012 21:08:31 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] bcma: scan for extra address space
Date:   Sun, 11 Mar 2012 21:08:21 +0100
Message-Id: <1331496505-18697-4-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
References: <1331496505-18697-1-git-send-email-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Some cores like the USB core have two address spaces. In the USB host
controller one address space is used for the OHCI and the other for the
EHCI controller interface. The USB controller is the only core I found
with two address spaces. This code is based on the AI scan function
ai_scan() in shared/aiutils.c i the Broadcom SDK.

CC: Rafał Miłecki <zajec5@gmail.com>
CC: linux-wireless@vger.kernel.org
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/scan.c       |   18 +++++++++++++++++-
 include/linux/bcma/bcma.h |    1 +
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/bcma/scan.c b/drivers/bcma/scan.c
index 3a2f672..3c2eeed 100644
--- a/drivers/bcma/scan.c
+++ b/drivers/bcma/scan.c
@@ -286,6 +286,22 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 			return -EILSEQ;
 	}
 
+
+	/* First Slave Address Descriptor should be port 0:
+	 * the main register space for the core
+	 */
+	tmp = bcma_erom_get_addr_desc(bus, eromptr, SCAN_ADDR_TYPE_SLAVE, 0);
+	if (tmp <= 0) {
+		/* Try again to see if it is a bridge */
+		tmp = bcma_erom_get_addr_desc(bus, eromptr,
+					      SCAN_ADDR_TYPE_BRIDGE, 0);
+		if (tmp > 0) {
+			pr_info("found bridge");
+			return -ENXIO;
+		}
+	}
+	core->addr = tmp;
+
 	/* get & parse slave ports */
 	for (i = 0; i < ports[1]; i++) {
 		for (j = 0; ; j++) {
@@ -298,7 +314,7 @@ static int bcma_get_next_core(struct bcma_bus *bus, u32 __iomem **eromptr,
 				break;
 			} else {
 				if (i == 0 && j == 0)
-					core->addr = tmp;
+					core->addr1 = tmp;
 			}
 		}
 	}
diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
index 83c209f..7fe41e1 100644
--- a/include/linux/bcma/bcma.h
+++ b/include/linux/bcma/bcma.h
@@ -138,6 +138,7 @@ struct bcma_device {
 	u8 core_index;
 
 	u32 addr;
+	u32 addr1;
 	u32 wrap;
 
 	void __iomem *io_addr;
-- 
1.7.5.4
