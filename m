Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2014 17:49:37 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52764 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825900AbaCBQtfUEvfB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Mar 2014 17:49:35 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id DAE067E2E;
        Sun,  2 Mar 2014 17:49:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MpWoNRdfPJLY; Sun,  2 Mar 2014 17:49:32 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id F1B9B7E25;
        Sun,  2 Mar 2014 17:49:31 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/4] MIPS: BCM47XX: detect some more Linksys devices
Date:   Sun,  2 Mar 2014 17:49:26 +0100
Message-Id: <1393778969-21066-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

The Linksys WRT54G/GS/GL family uses the same boardtype numbers, and
the same gpio configuration. The boardtype numbers are changing with
the hardware versions, but these hardware numbers are different or each
model.
Detect them all as one device, this also worked in OpenWrt.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c                          |    4 +++-
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index cdd8246..1913fa2 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -176,7 +176,9 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
-	{{BCM47XX_BOARD_LINKSYS_WRT54GSV1, "Linksys WRT54GS V1"}, "0x0101", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0101", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0467", "42", "0x10"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54G, "Linksys WRT54G/GS/GL"}, "0x0708", "42", "0x10"},
 	{ {0}, NULL},
 };
 
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 40005fb..a564a9f 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -66,7 +66,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT310NV1,
 	BCM47XX_BOARD_LINKSYS_WRT310NV2,
 	BCM47XX_BOARD_LINKSYS_WRT54G3GV2,
-	BCM47XX_BOARD_LINKSYS_WRT54GSV1,
+	BCM47XX_BOARD_LINKSYS_WRT54G,
 	BCM47XX_BOARD_LINKSYS_WRT610NV1,
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
-- 
1.7.10.4
