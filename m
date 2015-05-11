Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 20:01:23 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027484AbbEKRz4Xlbri (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:56 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA6AEBBE;
        Mon, 11 May 2015 17:55:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 27/72] MIPS: BCM47XX: Fix detecting Microsoft MN-700 & Asus WL500G
Date:   Mon, 11 May 2015 10:54:33 -0700
Message-Id: <20150511175437.924074869@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Rafał Miłecki <zajec5@gmail.com>

Commit 96f7c21363e0e0d19f3471f54a719ed06d708513 upstream.

Since the day of adding this code it was broken. We were iterating over
a wrong array and checking for wrong NVRAM entry.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Patchwork: https://patchwork.linux-mips.org/patch/9654/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/bcm47xx/board.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/bcm47xx/board.c
+++ b/arch/mips/bcm47xx/board.c
@@ -247,8 +247,8 @@ static __init const struct bcm47xx_board
 	}
 
 	if (bcm47xx_nvram_getenv("hardware_version", buf1, sizeof(buf1)) >= 0 &&
-	    bcm47xx_nvram_getenv("boardtype", buf2, sizeof(buf2)) >= 0) {
-		for (e2 = bcm47xx_board_list_boot_hw; e2->value1; e2++) {
+	    bcm47xx_nvram_getenv("boardnum", buf2, sizeof(buf2)) >= 0) {
+		for (e2 = bcm47xx_board_list_hw_version_num; e2->value1; e2++) {
 			if (!strstarts(buf1, e2->value1) &&
 			    !strcmp(buf2, e2->value2))
 				return &e2->board;
