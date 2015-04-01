Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 16:01:17 +0200 (CEST)
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35592 "EHLO
        mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008305AbbDAOBLsZUqf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 16:01:11 +0200
Received: by wgdm6 with SMTP id m6so54467331wgd.2;
        Wed, 01 Apr 2015 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=5nfHYJpLzIL6/gQciv/Bf1UjbCKbXFspe0Mptscm2Ww=;
        b=ns8hk8anpAZG+tzTjEZwur9ZdK54GVUwurj4Lo1vZ2xy4+my51t8YfsGJeticXDF5o
         L/e2ClvzdjdDC1FQaVwbN344FXGJe0z84ZiaEVtUPGSCxPG89AgmFvGTd3CzXnDr/hVj
         WKdJN/w3rfvEb2bYQHcws6U1anxh/n3VLWg0mDtDigOidJm7whvqLSWX1yMZ2Zcq8O3q
         hWH79EsjNWQxUepDrX0QFKUiS0AgGr+L8K/wNT+kHmAUawRoNP1epkO2X2mmh+Vm1PJC
         AVVZmA9JWSqLgglcez5whvle4+2lN0ymAZLhBxHDD3F0M71FS4bcEF1LQuSQWT78/zuV
         8CUg==
X-Received: by 10.180.35.97 with SMTP id g1mr15154503wij.17.1427896867636;
        Wed, 01 Apr 2015 07:01:07 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id hw7sm2838413wjb.24.2015.04.01.07.01.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 07:01:06 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Fix detecting Microsoft MN-700 & Asus WL500G
Date:   Wed,  1 Apr 2015 16:01:02 +0200
Message-Id: <1427896862-24752-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

Since the day of adding this code it was broken. We were iterating over
a wrong array and checking for wrong NVRAM entry.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm47xx/board.c b/arch/mips/bcm47xx/board.c
index d4a5a51..4016481 100644
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
1.8.4.5
