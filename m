Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:26:11 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47474 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823075AbaABSZwGzdL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:25:52 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id C4628857F;
        Thu,  2 Jan 2014 19:25:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hxImFDrMD4TW; Thu,  2 Jan 2014 19:25:49 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 6BD838F62;
        Thu,  2 Jan 2014 19:25:43 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/4] MIPS: BCM47XX: fix detection for some boards
Date:   Thu,  2 Jan 2014 19:25:36 +0100
Message-Id: <1388687138-8107-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
References: <1388687138-8107-1-git-send-email-hauke@hauke-m.de>
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38842
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

When a nvram reset was performed from CFE, it sometimes does not
contain the productid value in nvram, but it still contains
hardware_version.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/board.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b790bb7..44e0a99 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -56,6 +56,10 @@ struct bcm47xx_board_type_list1 bcm47xx_board_list_machine_name[] __initconst =
 /* hardware_version */
 static const
 struct bcm47xx_board_type_list1 bcm47xx_board_list_hardware_version[] __initconst = {
+	{{BCM47XX_BOARD_ASUS_RTN10U, "Asus RT-N10U"}, "RTN10U"},
+	{{BCM47XX_BOARD_ASUS_RTN12, "Asus RT-N12"}, "RT-N12"},
+	{{BCM47XX_BOARD_ASUS_RTN12D1, "Asus RT-N12D1"}, "RTN12D1"},
+	{{BCM47XX_BOARD_ASUS_RTN12B1, "Asus RT-N12B1"}, "RTN12B1"},
 	{{BCM47XX_BOARD_ASUS_RTN16, "Asus RT-N16"}, "RT-N16-"},
 	{{BCM47XX_BOARD_ASUS_WL320GE, "Asus WL320GE"}, "WL320G-"},
 	{{BCM47XX_BOARD_ASUS_WL330GE, "Asus WL330GE"}, "WL330GE-"},
@@ -179,6 +183,7 @@ struct bcm47xx_board_type_list3 bcm47xx_board_list_board[] __initconst = {
 	{{BCM47XX_BOARD_HUAWEI_E970, "Huawei E970"}, "0x048e", "0x5347", "0x11"},
 	{{BCM47XX_BOARD_PHICOMM_M1, "Phicomm M1"}, "0x0590", "80", "0x1104"},
 	{{BCM47XX_BOARD_ZTE_H218N, "ZTE H218N"}, "0x053d", "1234", "0x1305"},
+	{{BCM47XX_BOARD_NETGEAR_WNR3500L, "Netgear WNR3500L"}, "0x04CF", "3500", "02"},
 	{{BCM47XX_BOARD_BELKIN_F7DXXXX, "Belkin F7Dxxxx"}, "0xa4cf", NULL, "0x1102"},
 	{ {0}, 0},
 };
-- 
1.7.10.4
