Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Dec 2015 23:49:30 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:35401 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013502AbbLMWt3Tuor9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 13 Dec 2015 23:49:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=GyerTdue5vlobALSSD5L+4NrKxyLZnwcn5tW6hYp+8k=;
        b=TT4CpF/VSOhzUNyXaJW25FiKmrZAmZ/Yb65zrCt3UaDffbyPAtpNjBSC7MVKXUlPBP9Ksd4VM1UXFTqeE5GMaBH+pVhr0QHxihBPEDDTDzKrZ9sit2gtvwG6UBTP9Sw+G6BtIY71v9m4ezVNIiaXNLaCkwdG5NCQTlWvBJEGnYFEM1Yi/bz5C4dG3DVsNAVqvS6xb9ne6zu1ACpvnBFaPi8pLctBehnQgaOppeAcg2wm5JueMF0O6e4oJdA7SU4pVeEg0vhc3iInada77jsztg3pdUL5Z8GuSxCItIp6l6mlKlPwTqXg9obVCvyHu64iORQ5+uMssU+mzwkkPPUPew==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44500 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a8FSK-0003yh-06 (Exim); Sun, 13 Dec 2015 22:49:28 +0000
Subject: [PATCH linux-next v4 06/11] mtd: bcm63xxpart: Remove dependency on
 mach-bcm63xx
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
Message-ID: <566DF5F6.6070901@simon.arlott.org.uk>
Date:   Sun, 13 Dec 2015 22:49:26 +0000
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
X-archive-position: 50578
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

Read nvram directly from flash instead of using the in-memory copy that
mach-bcm63xx has, to remove the dependency on mach-bcm63xx and allow the
parser to work on bmips too.

Rename remaining BCM63XX defines to BCM963XX as these are properties of
the flash layout on the board.

BCM963XX_DEFAULT_PSI_SIZE changes from SZ_64K to 64 because it will be
multiplied by SZ_1K later on.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
v4: New patch.

 drivers/mtd/Kconfig       |  2 +-
 drivers/mtd/bcm63xxpart.c | 72 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 42cc953..e83a279 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -142,7 +142,7 @@ config MTD_AR7_PARTS
 
 config MTD_BCM63XX_PARTS
 	tristate "BCM63XX CFE partitioning support"
-	depends on BCM63XX
+	depends on BCM63XX || BMIPS_GENERIC || COMPILE_TEST
 	select CRC32
 	help
 	  This provides partions parsing for BCM63xx devices with CFE
diff --git a/drivers/mtd/bcm63xxpart.c b/drivers/mtd/bcm63xxpart.c
index cec3188..1eea8b6 100644
--- a/drivers/mtd/bcm63xxpart.c
+++ b/drivers/mtd/bcm63xxpart.c
@@ -24,6 +24,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bcm963xx_nvram.h>
 #include <linux/bcm963xx_tag.h>
 #include <linux/crc32.h>
 #include <linux/module.h>
@@ -34,12 +35,11 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
-#include <asm/mach-bcm63xx/bcm63xx_nvram.h>
-#include <asm/mach-bcm63xx/board_bcm963xx.h>
+#define BCM963XX_CFE_BLOCK_SIZE		SZ_64K	/* always at least 64KiB */
 
-#define BCM63XX_CFE_BLOCK_SIZE	SZ_64K		/* always at least 64KiB */
-
-#define BCM63XX_CFE_MAGIC_OFFSET 0x4e0
+#define BCM963XX_CFE_MAGIC_OFFSET	0x4e0
+#define BCM963XX_CFE_VERSION_OFFSET	0x570
+#define BCM963XX_NVRAM_OFFSET		0x580
 
 static int bcm63xx_detect_cfe(struct mtd_info *master)
 {
@@ -58,20 +58,45 @@ static int bcm63xx_detect_cfe(struct mtd_info *master)
 		return 0;
 
 	/* very old CFE's do not have the cfe-v string, so check for magic */
-	ret = mtd_read(master, BCM63XX_CFE_MAGIC_OFFSET, 8, &retlen,
+	ret = mtd_read(master, BCM963XX_CFE_MAGIC_OFFSET, 8, &retlen,
 		       (void *)buf);
 	buf[retlen] = 0;
 
 	return strncmp("CFE1CFE1", buf, 8);
 }
 
+static int bcm63xx_read_nvram(struct mtd_info *master,
+	struct bcm963xx_nvram *nvram)
+{
+	u32 actual_crc, expected_crc;
+	size_t retlen;
+	int ret;
+
+	/* extract nvram data */
+	ret = mtd_read(master, BCM963XX_NVRAM_OFFSET, BCM963XX_NVRAM_V5_SIZE,
+			&retlen, (void *)nvram);
+	if (ret)
+		return ret;
+
+	ret = bcm963xx_nvram_checksum(nvram, &expected_crc, &actual_crc);
+	if (ret)
+		pr_warn("nvram checksum failed, contents may be invalid (expected %08x, got %08x)\n",
+			expected_crc, actual_crc);
+
+	if (!nvram->psi_size)
+		nvram->psi_size = BCM963XX_DEFAULT_PSI_SIZE;
+
+	return 0;
+}
+
 static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 					const struct mtd_partition **pparts,
 					struct mtd_part_parser_data *data)
 {
 	/* CFE, NVRAM and global Linux are always present */
 	int nrparts = 3, curpart = 0;
-	struct bcm_tag *buf;
+	struct bcm963xx_nvram *nvram = NULL;
+	struct bcm_tag *buf = NULL;
 	struct mtd_partition *parts;
 	int ret;
 	size_t retlen;
@@ -86,25 +111,35 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	if (bcm63xx_detect_cfe(master))
 		return -EINVAL;
 
+	nvram = vzalloc(sizeof(*nvram));
+	if (!nvram)
+		return -ENOMEM;
+
+	ret = bcm63xx_read_nvram(master, nvram);
+	if (ret)
+		goto out;
+
 	cfe_erasesize = max_t(uint32_t, master->erasesize,
-			      BCM63XX_CFE_BLOCK_SIZE);
+			      BCM963XX_CFE_BLOCK_SIZE);
 
 	cfelen = cfe_erasesize;
-	nvramlen = bcm63xx_nvram_get_psi_size() * SZ_1K;
+	nvramlen = nvram->psi_size * SZ_1K;
 	nvramlen = roundup(nvramlen, cfe_erasesize);
 
 	/* Allocate memory for buffer */
 	buf = vmalloc(sizeof(struct bcm_tag));
-	if (!buf)
-		return -ENOMEM;
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	/* Get the tag */
 	ret = mtd_read(master, cfelen, sizeof(struct bcm_tag), &retlen,
 		       (void *)buf);
 
 	if (retlen != sizeof(struct bcm_tag)) {
-		vfree(buf);
-		return -EIO;
+		ret = -EIO;
+		goto out;
 	}
 
 	computed_crc = crc32_le(IMAGETAG_CRC_START, (u8 *)buf,
@@ -154,8 +189,8 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 	/* Ask kernel for more memory */
 	parts = kzalloc(sizeof(*parts) * nrparts + 10 * nrparts, GFP_KERNEL);
 	if (!parts) {
-		vfree(buf);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	/* Start building partition list */
@@ -206,8 +241,15 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
 		sparelen);
 
 	*pparts = parts;
+	ret = 0;
+
+out:
+	vfree(nvram);
 	vfree(buf);
 
+	if (ret)
+		return ret;
+
 	return nrparts;
 };
 
-- 
2.1.4

-- 
Simon Arlott
