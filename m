Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:51:07 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35432 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013502AbbLMWvFdNAY9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:51:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=HAsHjk8kwqVAxNMxmkJuebN7RC4GAhW2W+mamwPQW3A=;
        b=cO2c2z4t+ZcfCkCIDHtP0lediVR3BagcVMoC80cnM+liL5vr2koCXCkrMJ9T9h4blD4Z1dfrh2PR+tKgbIOTZsW7luSz+Rh6S49LtqEFfoJ9VS73g+9CttiKqFyZDqQ7Bw4Qf5BzjJk4pRiHw0aBrzq+v0qEsqzbyfoiQd1SUcBBYuGv0Q8H2oW30v0t5dy0PoiMPXPtTcJjrqZgf5cQfxmvBcYsG5uPJxSRhlh8JVlCzJ1ELahBx8wL72iYII9VXrHjXFMUQKbHYDN4qahrHxxx5irFt+67OuUIB4baTnIw9CdIhuJtmmUgYFz1Nz9aT1lDc7UW5gXoDwWUiT93tQ==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44503 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FTr-00045N-OY (Exim); Sun, 13 Dec 2015 22:51:04 +0000
Subject: [PATCH linux-next v4 08/11] mtd: bcm63xxpart: Extract read of image
 tag to separate function
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
Message-ID: <566DF656.2020509@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:51:02 +0000
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
X-archive-position: 50580
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

Extract image tag reading and CRC check to a separate function.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 drivers/mtd/bcm63xxpart.c | 62 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index 1eea8b6..eafbf52 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -41,6 +41,10 @@
 #define BCM963XX_CFE_VERSION_OFFSET	0x570
 #define BCM963XX_NVRAM_OFFSET		0x580
 
+/* Ensure strings read from flash structs are null terminated */
+#define STR_NULL_TERMINATE(x) \
+	do { char *_str = (x); _str[sizeof(x) - 1] = 0; } while (0)
+
 static int bcm63xx_detect_cfe(struct mtd_info *master)
 {
 	char buf[9];
@@ -89,6 +93,37 @@ static int bcm63xx_read_nvram(struct mtd_info *master,
 	return 0;
 }
 
+static int bcm63xx_read_image_tag(struct mtd_info *master, const char *name,
+	loff_t tag_offset, struct bcm_tag *buf)
+{
+	int ret;
+	size_t retlen;
+	u32 computed_crc;
+
+	ret = mtd_read(master, tag_offset, sizeof(*buf), &retlen, (void *)buf);
+	if (ret)
+		return ret;
+
+	if (retlen != sizeof(*buf))
+		return -EIO;
+
+	computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
+				offsetof(struct bcm_tag, header_crc));
+	if (computed_crc == buf->header_crc) {
+		STR_NULL_TERMINATE(buf->board_id);
+		STR_NULL_TERMINATE(buf->tag_version);
+
+		pr_info("%s: CFE image tag found at 0x%llx with version %s, board type %s\n",
+			name, tag_offset, buf->tag_version, buf->board_id);
+
+		return 0;
+	}
+
+	pr_warn("%s: CFE image tag at 0x%llx CRC invalid (expected %08x, actual %08x)\n",
+		name, tag_offset, buf->header_crc, computed_crc);
+	return 1;
+}
+
 static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 					const struct mtd_partition **pparts,
 					struct mtd_part_parser_data *data)
@@ -99,13 +134,11 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	struct bcm_tag *buf = NULL;
 	struct mtd_partition *parts;
 	int ret;
-	size_t retlen;
 	unsigned int rootfsaddr, kerneladdr, spareaddr;
 	unsigned int rootfslen, kernellen, sparelen, totallen;
 	unsigned int cfelen, nvramlen;
 	unsigned int cfe_erasesize;
 	int i;
-	u32 computed_crc;
 	bool rootfs_first = false;
 
 	if (bcm63xx_detect_cfe(master))
@@ -134,28 +167,13 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	}
 
 	/* Get the tag */
-	ret = mtd_read(master, cfelen, sizeof(struct bcm_tag), &retlen,
-		       (void *)buf);
-
-	if (retlen != sizeof(struct bcm_tag)) {
-		ret = -EIO;
-		goto out;
-	}
-
-	computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
-				offsetof(struct bcm_tag, header_crc));
-	if (computed_crc == buf->header_crc) {
-		char *boardid = &(buf->board_id[0]);
-		char *tagversion = &(buf->tag_version[0]);
-
+	ret = bcm63xx_read_image_tag(master, "rootfs", cfelen, buf);
+	if (!ret) {
 		sscanf(buf->flash_image_start, "%u", &rootfsaddr);
 		sscanf(buf->kernel_address, "%u", &kerneladdr);
 		sscanf(buf->kernel_length, "%u", &kernellen);
 		sscanf(buf->total_length, "%u", &totallen);
 
-		pr_info("CFE boot tag found with version %s and board type %s\n",
-			tagversion, boardid);
-
 		kerneladdr = kerneladdr - BCM963XX_EXTENDED_SIZE;
 		rootfsaddr = rootfsaddr - BCM963XX_EXTENDED_SIZE;
 		spareaddr = roundup(totallen, master->erasesize) + cfelen;
@@ -169,13 +187,13 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 			rootfsaddr = kerneladdr + kernellen;
 			rootfslen = spareaddr - rootfsaddr;
 		}
-	} else {
-		pr_warn("CFE boot tag CRC invalid (expected %08x, actual %08x)\n",
-			buf->header_crc, computed_crc);
+	} else if (ret > 0) {
 		kernellen = 0;
 		rootfslen = 0;
 		rootfsaddr = 0;
 		spareaddr = cfelen;
+	} else {
+		goto out;
 	}
 	sparelen = master->size - spareaddr - nvramlen;
 
-- 
2.1.4

-- 
Simon Arlott
