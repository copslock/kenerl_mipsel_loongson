Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 12:50:55 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39830 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27012290AbaJ3LuliSjud (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 12:50:41 +0100
Received: by mail-wg0-f41.google.com with SMTP id k14so4048466wgh.14
        for <multiple recipients>; Thu, 30 Oct 2014 04:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=7NK3Jwgi/lppl/3zJfftUOVW00RMwnsxDyZj1xVR9AA=;
        b=wwp9QclUd9/ZO6qyo+rFEBTU+fWHluxclkzT9D/O5ozAnsYsAItnf9OltAjoXWpCAv
         l2rqoAIzp2kzmjuPg8KxlAGS8crZlGwVEps+i6QOYoRfPq71jfcjU+MB4C1fiHjJk1pV
         LJA2YgoL0tcOVNEJjlzfYxWwBUZwOLX2lFiskL7soQoLLYnobFIqOvTelFoLHYjRcynF
         EyTiOOy4XrpmXv05FpSOuA4NWSl+R/k3bESJpL99M9aQleKft8Rl8RDhu3e5ZoN6lK5D
         M5wa4IwPyY/PtaT5y8H9wOO+aPevI7f6giDzgD6LNg6i/CuqyigcLh6BnOO6YeRbOMuP
         RYgA==
X-Received: by 10.194.185.115 with SMTP id fb19mr2345196wjc.121.1414669819775;
        Thu, 30 Oct 2014 04:50:19 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id gg18sm8741433wic.21.2014.10.30.04.50.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 04:50:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Clean up nvram header
Date:   Thu, 30 Oct 2014 12:50:03 +0100
Message-Id: <1414669803-15280-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43778
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

1) Move private defines to the .c file
2) Move SPROM helper to the sprom.c
3) Drop unused code
4) Rename magic to the NVRAM_MAGIC
5) Add const to the char pointer we never modify

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
This is based on top of
[PATCH] MIPS: BCM47XX: Use mtd as an alternative way/API to get NVRAM content
---
 arch/mips/bcm47xx/nvram.c                          | 23 ++++++++++----
 arch/mips/bcm47xx/sprom.c                          | 14 +++++++++
 arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h | 35 +---------------------
 3 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 8b64991..c5c381c 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -18,6 +18,19 @@
 #include <linux/mtd/mtd.h>
 #include <bcm47xx_nvram.h>
 
+#define NVRAM_MAGIC		0x48534C46	/* 'FLSH' */
+#define NVRAM_SPACE		0x8000
+
+#define FLASH_MIN		0x00020000	/* Minimum flash size */
+
+struct nvram_header {
+	u32 magic;
+	u32 len;
+	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
+	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
+	u32 config_ncdl;	/* ncdl values for memc */
+};
+
 static char nvram_buf[NVRAM_SPACE];
 static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 
@@ -28,7 +41,7 @@ static u32 find_nvram_size(void __iomem *end)
 
 	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
 		header = (struct nvram_header *)(end - nvram_sizes[i]);
-		if (header->magic == NVRAM_HEADER)
+		if (header->magic == NVRAM_MAGIC)
 			return nvram_sizes[i];
 	}
 
@@ -63,13 +76,13 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 
 	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
 	header = (struct nvram_header *)(iobase + 4096);
-	if (header->magic == NVRAM_HEADER) {
+	if (header->magic == NVRAM_MAGIC) {
 		size = NVRAM_SPACE;
 		goto found;
 	}
 
 	header = (struct nvram_header *)(iobase + 1024);
-	if (header->magic == NVRAM_HEADER) {
+	if (header->magic == NVRAM_MAGIC) {
 		size = NVRAM_SPACE;
 		goto found;
 	}
@@ -139,7 +152,7 @@ static int nvram_init(void)
 
 		err = mtd_read(mtd, from, sizeof(header), &bytes_read,
 			       (uint8_t *)&header);
-		if (!err && header.magic == NVRAM_HEADER) {
+		if (!err && header.magic == NVRAM_MAGIC) {
 			u8 *dst = (uint8_t *)nvram_buf;
 			size_t len = header.len;
 
@@ -162,7 +175,7 @@ static int nvram_init(void)
 	return -ENXIO;
 }
 
-int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len)
+int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 {
 	char *var, *value, *end, *eq;
 	int err;
diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
index e772e77..2eff7fe 100644
--- a/arch/mips/bcm47xx/sprom.c
+++ b/arch/mips/bcm47xx/sprom.c
@@ -136,6 +136,20 @@ static void nvram_read_leddc(const char *prefix, const char *name,
 	*leddc_off_time = (val >> 16) & 0xff;
 }
 
+static void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
+{
+	if (strchr(buf, ':'))
+		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
+			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
+			&macaddr[5]);
+	else if (strchr(buf, '-'))
+		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
+			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
+			&macaddr[5]);
+	else
+		pr_warn("Can not parse mac address: %s\n", buf);
+}
+
 static void nvram_read_macaddr(const char *prefix, const char *name,
 			       u8 val[6], bool fallback)
 {
diff --git a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
index 676be22..ee59ffe 100644
--- a/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
+++ b/arch/mips/include/asm/mach-bcm47xx/bcm47xx_nvram.h
@@ -14,41 +14,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 
-struct nvram_header {
-	u32 magic;
-	u32 len;
-	u32 crc_ver_init;	/* 0:7 crc, 8:15 ver, 16:31 sdram_init */
-	u32 config_refresh;	/* 0:15 sdram_config, 16:31 sdram_refresh */
-	u32 config_ncdl;	/* ncdl values for memc */
-};
-
-#define NVRAM_HEADER		0x48534C46	/* 'FLSH' */
-#define NVRAM_VERSION		1
-#define NVRAM_HEADER_SIZE	20
-#define NVRAM_SPACE		0x8000
-
-#define FLASH_MIN		0x00020000	/* Minimum flash size */
-
-#define NVRAM_MAX_VALUE_LEN 255
-#define NVRAM_MAX_PARAM_LEN 64
-
 int bcm47xx_nvram_init_from_mem(u32 base, u32 lim);
-extern int bcm47xx_nvram_getenv(char *name, char *val, size_t val_len);
-
-static inline void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
-{
-	if (strchr(buf, ':'))
-		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &macaddr[0],
-			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
-			&macaddr[5]);
-	else if (strchr(buf, '-'))
-		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx", &macaddr[0],
-			&macaddr[1], &macaddr[2], &macaddr[3], &macaddr[4],
-			&macaddr[5]);
-	else
-		printk(KERN_WARNING "Can not parse mac address: %s\n", buf);
-}
-
+int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len);
 int bcm47xx_nvram_gpio_pin(const char *name);
 
 #endif /* __BCM47XX_NVRAM_H */
-- 
1.8.4.5
