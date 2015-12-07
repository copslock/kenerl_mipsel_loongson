Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:30:05 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:55820 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013306AbbLGW1VB-yXg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:27:21 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 5AA001C18; Mon,  7 Dec 2015 23:27:13 +0100 (CET)
Received: from localhost.localdomain (unknown [37.160.132.173])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 8C2741943;
        Mon,  7 Dec 2015 23:27:10 +0100 (CET)
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
Subject: [PATCH 11/23] mtd: add mtd_eccpos(), mtd_oobfree() and mtd_eccbytes() helper functions
Date:   Mon,  7 Dec 2015 23:26:06 +0100
Message-Id: <1449527178-5930-12-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50390
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

In order to make the ecclayout definition completely dynamic we need to
rework the way these different ECC layouts are defined and iterated.

Create the mtd_eccpos(), mtd_oobfree() and mtd_eccbytes() helpers to hide
ecclayout definition internals to their users.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/mtd/mtd.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 9cf13c4..25e3d0f 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -253,6 +253,38 @@ struct mtd_info {
 	int usecount;
 };
 
+static inline int mtd_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	if (eccbyte >= mtd->ecclayout->eccbytes)
+		return -ERANGE;
+
+	return mtd->ecclayout->eccpos[eccbyte];
+}
+
+static inline int mtd_oobfree(struct mtd_info *mtd, int section,
+			      struct nand_oobfree *oobfree)
+{
+	memset(oobfree, 0, sizeof(*oobfree));
+
+	if (!mtd->ecclayout)
+		return -ENOTSUPP;
+
+	if (section >= MTD_MAX_OOBFREE_ENTRIES_LARGE)
+		return -ERANGE;
+
+	*oobfree = mtd->ecclayout->oobfree[section];
+
+	return 0;
+}
+
+static inline int mtd_eccbytes(struct mtd_info *mtd)
+{
+	return mtd->ecclayout ? mtd->ecclayout->eccbytes : 0;
+}
+
 static inline void mtd_set_of_node(struct mtd_info *mtd,
 				   struct device_node *np)
 {
-- 
2.1.4
