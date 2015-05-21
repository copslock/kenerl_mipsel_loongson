Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 15:27:36 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:65449 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006621AbbEUN1dnJwoi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 15:27:33 +0200
X-IronPort-AV: E=Sophos;i="5.13,469,1427785200"; 
   d="scan'208";a="65454954"
Received: from irvexchcas06.broadcom.com (HELO IRVEXCHCAS06.corp.ad.broadcom.com) ([10.9.208.53])
  by mail-gw2-out.broadcom.com with ESMTP; 21 May 2015 06:37:59 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Thu, 21 May 2015 06:27:25 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Thu, 21 May 2015 06:27:25 -0700
Received: from bld-bun-01.bun.broadcom.com (unknown [10.176.128.83])    by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8046F40FE5;  Thu, 21 May
 2015 06:25:41 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)   id
 E36DBB0517B; Thu, 21 May 2015 15:27:24 +0200 (CEST)
From:   Arend van Spriel <arend@broadcom.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Hante Meuleman <meuleman@broadcom.com>,
        Arend van Spriel <arend@broadcom.com>
Subject: [PATCH V2] mips: bcm47xx: allow retrieval of complete nvram contents
Date:   Thu, 21 May 2015 15:27:23 +0200
Message-ID: <1432214843-16057-1-git-send-email-arend@broadcom.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

From: Hante Meuleman <meuleman@broadcom.com>

Host platforms such as routers supported by OpenWrt can
support NVRAM reading directly from internal NVRAM store.
The brcmfmac for one requires the complete nvram contents
to select what needs to be sent to wireless device.

Reviewed-by: Arend Van Spriel <arend@broadcom.com>
Reviewed-by: Franky (Zhenhui) Lin <frankyl@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieterpg@broadcom.com>
Reviewed-by: Daniel (Deognyoun) Kim <dekim@broadcom.com>
Signed-off-by: Hante Meuleman <meuleman@broadcom.com>
Signed-off-by: Arend van Spriel <arend@broadcom.com>
---
Change log:
-----------
V2:	- correct header length for nvram_find_and_copy().
	- get rid of 'NVRAM_SPACE - 2' magic.
---
 arch/mips/bcm47xx/nvram.c     | 61 ++++++++++++++++++++++++++++++++-----------
 include/linux/bcm47xx_nvram.h | 15 +++++++++++
 2 files changed, 61 insertions(+), 15 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 95d028c..f4f62d3 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -94,17 +94,22 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 	return -ENXIO;
 
 found:
-	if (header->len > size)
-		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
-	if (header->len > NVRAM_SPACE)
-		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-		       header->len, NVRAM_SPACE - 1);
-
 	src = (u32 *)header;
 	dst = (u32 *)nvram_buf;
 	for (i = 0; i < sizeof(struct nvram_header); i += 4)
 		*dst++ = __raw_readl(src++);
-	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
+	header = (struct nvram_header *)nvram_buf;
+	if (header->len > size) {
+		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
+		header->len = size;
+	}
+	if (header->len >= NVRAM_SPACE) {
+		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+		       header->len, NVRAM_SPACE - 1);
+		header->len = NVRAM_SPACE - 1;
+	}
+	/* proceed reading data after header */
+	for (; i < header->len; i += 4)
 		*dst++ = readl(src++);
 	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
@@ -139,6 +144,7 @@ static int nvram_init(void)
 #ifdef CONFIG_MTD
 	struct mtd_info *mtd;
 	struct nvram_header header;
+	struct nvram_header *pheader;
 	size_t bytes_read;
 	int err;
 
@@ -147,20 +153,21 @@ static int nvram_init(void)
 		return -ENODEV;
 
 	err = mtd_read(mtd, 0, sizeof(header), &bytes_read, (uint8_t *)&header);
-	if (!err && header.magic == NVRAM_MAGIC) {
-		u8 *dst = (uint8_t *)nvram_buf;
-		size_t len = header.len;
-
-		if (len >= NVRAM_SPACE) {
-			len = NVRAM_SPACE - 1;
+	if (!err && header.magic == NVRAM_MAGIC &&
+	    header.len > sizeof(header)) {
+		if (header.len >= NVRAM_SPACE) {
 			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-				header.len, len);
+				header.len, NVRAM_SPACE);
+			header.len = NVRAM_SPACE - 1;
 		}
 
-		err = mtd_read(mtd, 0, len, &bytes_read, dst);
+		err = mtd_read(mtd, 0, header.len, &bytes_read,
+			       (u8 *)nvram_buf);
 		if (err)
 			return err;
 
+		pheader = (struct nvram_header *)nvram_buf;
+		pheader->len = header.len;
 		return 0;
 	}
 #endif
@@ -219,3 +226,27 @@ int bcm47xx_nvram_gpio_pin(const char *name)
 	return -ENOENT;
 }
 EXPORT_SYMBOL(bcm47xx_nvram_gpio_pin);
+
+char *bcm47xx_nvram_get_contents(size_t *nvram_size)
+{
+	int err;
+	char *nvram;
+	struct nvram_header *header;
+
+	if (!nvram_buf[0]) {
+		err = nvram_init();
+		if (err)
+			return NULL;
+	}
+
+	header = (struct nvram_header *)nvram_buf;
+	*nvram_size = header->len - sizeof(struct nvram_header);
+	nvram = vmalloc(*nvram_size);
+	if (!nvram)
+		return NULL;
+	memcpy(nvram, &nvram_buf[sizeof(struct nvram_header)], *nvram_size);
+
+	return nvram;
+}
+EXPORT_SYMBOL(bcm47xx_nvram_get_contents);
+
diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
index b12b07e..c73927c 100644
--- a/include/linux/bcm47xx_nvram.h
+++ b/include/linux/bcm47xx_nvram.h
@@ -10,11 +10,17 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/vmalloc.h>
 
 #ifdef CONFIG_BCM47XX
 int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
 int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
 int bcm47xx_nvram_gpio_pin(const char *name);
+char *bcm47xx_nvram_get_contents(size_t *val_len);
+static inline void bcm47xx_nvram_release_contents(char *nvram)
+{
+	vfree(nvram);
+};
 #else
 static inline int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 {
@@ -29,6 +35,15 @@ static inline int bcm47xx_nvram_gpio_pin(const char *name)
 {
 	return -ENOTSUPP;
 };
+
+static inline char *bcm47xx_nvram_get_contents(size_t *val_len)
+{
+	return NULL;
+};
+
+static inline void bcm47xx_nvram_release_contents(char *nvram)
+{
+};
 #endif
 
 #endif /* __BCM47XX_NVRAM_H */
-- 
1.9.1
