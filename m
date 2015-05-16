Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 16:35:55 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:27830 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012804AbbEPOeeMBJyL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 16:34:34 +0200
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t4GEYQmJ004206
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 16 May 2015 14:34:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYQLl006423
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sat, 16 May 2015 14:34:26 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t4GEYQRI012230;
        Sat, 16 May 2015 14:34:26 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.159.239.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 May 2015 07:34:25 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: BCM47XX: Fix detecting Microsoft MN-700 & Asus WL500G
Date:   Sat, 16 May 2015 10:33:23 -0400
Message-Id: <1431786833-25487-15-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
References: <1431786833-25487-1-git-send-email-sasha.levin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Rafał Miłecki <zajec5@gmail.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 96f7c21363e0e0d19f3471f54a719ed06d708513 ]

Since the day of adding this code it was broken. We were iterating over
a wrong array and checking for wrong NVRAM entry.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Patchwork: https://patchwork.linux-mips.org/patch/9654/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/bcm47xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index b3ae068..3fd369d 100644
--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -247,8 +247,8 @@ static __init const struct bcm47xx_board_type *bcm47xx_board_get_nvram(void)
 	}
 
 	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardtype", buf2, sizeof(buf2)) >= 0) {
-		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
+	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >= 0) {
+		for (e2 = bcm47xx_board_list_hw_version_num; e2->value1; e2++) {
 			if (!strstarts(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
 				return &e2->board;
-- 
2.1.0
