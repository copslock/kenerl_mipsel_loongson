Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 19:56:40 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:2877 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827420Ab3FRR41NBkhN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jun 2013 19:56:27 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 18 Jun 2013 10:47:04 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 18 Jun 2013 10:56:12 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 18 Jun 2013 10:56:12 -0700
Received: from fainelli-desktop.broadcom.com (
 dhcp-lab-brsc-244.bri.broadcom.com [10.178.5.244]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id E0D67F2D72; Tue, 18
 Jun 2013 10:56:10 -0700 (PDT)
From:   "Florian Fainelli" <florian@openwrt.org>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        "Florian Fainelli" <florian@openwrt.org>
Subject: [PATCH 4/7] MIPS: BCM63XX: recognize Cable Modem firmware
 format
Date:   Tue, 18 Jun 2013 18:55:41 +0100
Message-ID: <1371578144-12794-5-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1371578144-12794-1-git-send-email-florian@openwrt.org>
References: <1371578144-12794-1-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
X-WSS-ID: 7DDE42922L834866974-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Add the firmware header format which is used by Broadcom Cable Modem
SoCs such as the BCM3368 SoC. We export the bcm_hcs firmware format
structure because it is used by user-land tools to create firmware
images for these SoCs and will later be used by a corresponding MTD
parser.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c | 14 ++++++++++++--
 include/uapi/linux/Kbuild                 |  1 +
 include/uapi/linux/bcm933xx_hcs.h         | 24 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/bcm933xx_hcs.h

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index a9505c4..46eabb9 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -28,8 +28,12 @@
 #include <bcm63xx_dev_usb_usbd.h>
 #include <board_bcm963xx.h>
 
+#include <uapi/linux/bcm933xx_hcs.h>
+
 #define PFX	"board_bcm963xx: "
 
+#define HCS_OFFSET_128K			0x20000
+
 static struct board_info board;
 
 /*
@@ -722,8 +726,9 @@ void __init board_prom_init(void)
 	unsigned int i;
 	u8 *boot_addr, *cfe;
 	char cfe_version[32];
-	char *board_name;
+	char *board_name = NULL;
 	u32 val;
+	struct bcm_hcs *hcs;
 
 	/* read base address of boot chip select (0)
 	 * 6328/6362 do not have MPI but boot from a fixed address
@@ -747,7 +752,12 @@ void __init board_prom_init(void)
 
 	bcm63xx_nvram_init(boot_addr + BCM963XX_NVRAM_OFFSET);
 
-	board_name = bcm63xx_nvram_get_name();
+	if (BCMCPU_IS_3368()) {
+		hcs = (struct bcm_hcs *)boot_addr;
+		board_name = hcs->filename;
+	} else {
+		board_name = bcm63xx_nvram_get_name();
+	}
 	/* find board by name */
 	for (i = 0; i < ARRAY_SIZE(bcm963xx_boards); i++) {
 		if (strncmp(board_name, bcm963xx_boards[i]->name, 16))
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index ab5d499..ba1c11a 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -62,6 +62,7 @@ header-y += auxvec.h
 header-y += ax25.h
 header-y += b1lli.h
 header-y += baycom.h
+header-y += bcm933xx_hcs.h
 header-y += bfs_fs.h
 header-y += binfmts.h
 header-y += blkpg.h
diff --git a/include/uapi/linux/bcm933xx_hcs.h b/include/uapi/linux/bcm933xx_hcs.h
new file mode 100644
index 0000000..d228218
--- /dev/null
+++ b/include/uapi/linux/bcm933xx_hcs.h
@@ -0,0 +1,24 @@
+/*
+ * Broadcom Cable Modem firmware format
+ */
+
+#ifndef __BCM933XX_HCS_H
+#define __BCM933XX_HCS_H
+
+#include <linux/types.h>
+
+struct bcm_hcs {
+	__u16 magic;
+	__u16 control;
+	__u16 rev_maj;
+	__u16 rev_min;
+	__u32 build_date;
+	__u32 filelen;
+	__u32 ldaddress;
+	char filename[64];
+	__u16 hcs;
+	__u16 her_znaet_chto;
+	__u32 crc;
+};
+
+#endif /* __BCM933XX_HCS */
-- 
1.8.1.2
