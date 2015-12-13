Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:52:21 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35515 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013540AbbLMWwSs8Fc9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:52:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=EJJTKb6JA8fZxv0JOfb/4ZLwvEES2/I5jvez/jAvSxc=;
        b=KeOn/Qb7E6wdJro4G6CR1R27ZBJoLkt7AGrV6iJ/sFakISK+49QV/fN/ZJdbWMNenO1F8XA+zaATjv2C8n+yR9pBy8mDMdeLye3FHiI4oftiDqNu/7ak71gvl6YGlVxy6Fwjaj4fITB4Tr4i0iQjF1QuI6dg86Q0VSbH55rt48rjkXkFb6uKWtWlYbny2yNMMgR8fSo84bVBzJV5eUcspxIBq+8bBWPZ8HUewnMfjrIV9p9GLmb85FOVtgVKa/YUr8JHVr3nRO8/KV0ZtaFxWYST66I3UDOr0OVfk0GB313Ojt13uWm4LeT3t+iWJ1ZsehqvoB/RFCF44qRVV8/GPw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44507 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FV2-00049a-P4 (Exim); Sun, 13 Dec 2015 22:52:17 +0000
Subject: [PATCH linux-next v4 10/11] mtd: bcm63xxpart: Move NOR flash layout
 to a separate function
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <566DF43B.5010400@simon.arlott.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <566DF69F.5090700@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:52:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <566DF43B.5010400@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

Move the NOR flash layout to a separate function to allow the NAND flash
layout to be supported.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 drivers/mtd/bcm63xxpart.c | 54 ++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 41aa202..26c38a1 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -124,13 +124,11 @@ static int bcm63xx_read_image_tag(struct mtd_info *master, const char *name,
 	return 1;
 }
 
-static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
-					const struct mtd_partition **pparts,
-					struct mtd_part_parser_data *data)
+static int bcm63xx_parse_cfe_nor_partitions(struct mtd_info *master,
+	const struct mtd_partition **pparts, struct bcm963xx_nvram *nvram)
 {
 	/* CFE, NVRAM and global Linux are always present */
 	int nrparts = 3, curpart = 0;
-	struct bcm963xx_nvram *nvram = NULL;
 	struct bcm_tag *buf = NULL;
 	struct mtd_partition *parts;
 	int ret;
@@ -141,17 +139,6 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	int i;
 	bool rootfs_first = false;
 
-	if (bcm63xx_detect_cfe(master))
-		return -EINVAL;
-
-	nvram = vzalloc(sizeof(*nvram));
-	if (!nvram)
-		return -ENOMEM;
-
-	ret = bcm63xx_read_nvram(master, nvram);
-	if (ret)
-		goto out;
-
 	cfe_erasesize = max_t(uint32_t, master->erasesize,
 			      BCM963XX_CFE_BLOCK_SIZE);
 
@@ -159,12 +146,9 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	nvramlen = nvram->psi_size * SZ_1K;
 	nvramlen = roundup(nvramlen, cfe_erasesize);
 
-	/* Allocate memory for buffer */
 	buf = vmalloc(sizeof(struct bcm_tag));
-	if (!buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!buf)
+		return -ENOMEM;
 
 	/* Get the tag */
 	ret = bcm63xx_read_image_tag(master, "rootfs", cfelen, buf);
@@ -234,7 +218,6 @@ invalid_tag:
 	if (kernellen > 0)
 		nrparts++;
 
-	/* Ask kernel for more memory */
 	parts = kzalloc(sizeof(*parts) * nrparts + 10 * nrparts, GFP_KERNEL);
 	if (!parts) {
 		ret = -ENOMEM;
@@ -292,13 +275,40 @@ invalid_tag:
 	ret = 0;
 
 out:
-	vfree(nvram);
 	vfree(buf);
 
 	if (ret)
 		return ret;
 
 	return nrparts;
+}
+
+static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
+					const struct mtd_partition **pparts,
+					struct mtd_part_parser_data *data)
+{
+	struct bcm963xx_nvram *nvram = NULL;
+	int ret;
+
+	if (bcm63xx_detect_cfe(master))
+		return -EINVAL;
+
+	nvram = vzalloc(sizeof(*nvram));
+	if (!nvram)
+		return -ENOMEM;
+
+	ret = bcm63xx_read_nvram(master, nvram);
+	if (ret)
+		goto out;
+
+	if (!mtd_type_is_nand(master))
+		ret = bcm63xx_parse_cfe_nor_partitions(master, pparts, nvram);
+	else
+		ret = -EINVAL;
+
+out:
+	vfree(nvram);
+	return ret;
 };
 
 static struct mtd_part_parser bcm63xx_cfe_parser = {
-- 
2.1.4

-- 
Simon Arlott
