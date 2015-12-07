Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:28:54 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55697 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013003AbbLGW1IW6vqg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:08 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 1F55A1B07; Mon,  7 Dec 2015 23:27:02 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 4C66118FE;
        Mon,  7 Dec 2015 23:26:58 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 07/23] staging: mt29f_spinand: kill unused ecclayout field
Date:   Mon,  7 Dec 2015 23:26:02 +0100
Message-Id: <1449527178-5930-8-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

The spinand_info struct embeds a pointer to an ecclayout definition, but
this field is never used in the mt29f driver.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.h b/drivers/staging/mt29f_spinand/mt29f_spinand.h
index ae62975..457dc7f 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.h
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.h
@@ -78,7 +78,6 @@
 #define BL_ALL_UNLOCKED    0
 
 struct spinand_info {
-	struct nand_ecclayout *ecclayout;
 	struct spi_device *spi;
 	void *priv;
 };
-- 
2.1.4
