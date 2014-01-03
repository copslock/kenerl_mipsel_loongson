Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 20:42:37 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:53495 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825736AbaACTmPY8Vi4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 20:42:15 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0EFD2857F;
        Fri,  3 Jan 2014 20:42:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z+NcyxA6NWPn; Fri,  3 Jan 2014 20:42:12 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id E262C8F61;
        Fri,  3 Jan 2014 20:42:08 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 2/3] MIPS: BCM47XX: add board detection for Linksys WRT54GS V1
Date:   Fri,  3 Jan 2014 20:41:59 +0100
Message-Id: <1388778120-24880-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
References: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38863
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

This adds board detection for Linksys WRT54GS V1.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c                          |    1 +
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index a456b04..40a9ac2 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -175,6 +175,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
 	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
+	{{BCM47XX_BOARD_LINKSYS_WRT54GSV1, "Linksys WRT54GS V1"}, "0x0101", "42", "0x10"},
 	{ {0}, 0},
 };
 
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
index 00867dd..40005fb 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_board.h
@@ -66,6 +66,7 @@ enum bcm47xx_board {
 	BCM47XX_BOARD_LINKSYS_WRT310NV1,
 	BCM47XX_BOARD_LINKSYS_WRT310NV2,
 	BCM47XX_BOARD_LINKSYS_WRT54G3GV2,
+	BCM47XX_BOARD_LINKSYS_WRT54GSV1,
 	BCM47XX_BOARD_LINKSYS_WRT610NV1,
 	BCM47XX_BOARD_LINKSYS_WRT610NV2,
 	BCM47XX_BOARD_LINKSYS_WRTSL54GS,
-- 
1.7.10.4
