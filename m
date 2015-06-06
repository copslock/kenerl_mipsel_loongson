Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2015 23:16:40 +0200 (CEST)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35413 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007464AbbFFVQicMu32 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2015 23:16:38 +0200
Received: by wiga1 with SMTP id a1so50601113wig.0;
        Sat, 06 Jun 2015 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=h7KytBhKQyE3pgLUAM+A8xfqlPP62SY9YcCpuPHORuo=;
        b=HOfp1swcIsOVt9YFEzs9Ucg++1WkJyePlwrDKS7LjjzEon+6eCtYCkVKeHI2bH80Yp
         DqijXRCePaqi9p1axa+c3mEdgGiuUWtrPYySGSWKKX6Ok5fo0cSILY0gkjaiQYCfP8tU
         bmIaKnc0/ZDw28tl+exd+5DXiukjNRkCSL386yYQ6gkIOaqL6ap4axKg8UFHys42L3L+
         UY98OyAH0UOTS1ZlPz2c83a1rbnzQlMASlqhfWSFSegTETn4lSCFTOhleAzUXtCCEoHH
         iTYs74OkKmT08XD2oXKFAEs0gney+zBZegXNaGueVAG6n9GGtUWZT3ps8950bDnUR3qJ
         p5jQ==
X-Received: by 10.194.220.100 with SMTP id pv4mr18413445wjc.71.1433625393263;
        Sat, 06 Jun 2015 14:16:33 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id f8sm924944wiy.7.2015.06.06.14.16.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 14:16:32 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Arend van Spriel <arend@broadcom.com>,
        Hante Meuleman <meuleman@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Add helper variable for storing NVRAM length
Date:   Sat,  6 Jun 2015 23:16:23 +0200
Message-Id: <1433625383-31120-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47894
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

This simplifies code just a bit (also maybe makes it a bit more
intuitive?) and will allow us to stop storing header. Right now we copy
whole NVRAM including its header to the internal buffer. It is not
needed to store a header as we don't access all these details like CRC,
flags, etc. The next improvement that should follow is copying only the
real contents.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
V2: Extend patch description.
---
 arch/mips/bcm47xx/nvram.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2ed762e..9ccdce8 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -35,6 +35,7 @@ struct nvram_header {
 };
 
 static char nvram_buf[NVRAM_SPACE];
+static size_t nvram_len;
 static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 
 static u32 find_nvram_size(void __iomem *end)
@@ -60,7 +61,7 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 	u32 *src, *dst;
 	u32 size;
 
-	if (nvram_buf[0]) {
+	if (nvram_len) {
 		pr_warn("nvram already initialized\n");
 		return -EEXIST;
 	}
@@ -99,17 +100,18 @@ found:
 	for (i = 0; i < sizeof(struct nvram_header); i += 4)
 		*dst++ = __raw_readl(src++);
 	header = (struct nvram_header *)nvram_buf;
-	if (header->len > size) {
+	nvram_len = header->len;
+	if (nvram_len > size) {
 		pr_err("The nvram size according to the header seems to be bigger than the partition on flash\n");
-		header->len = size;
+		nvram_len = size;
 	}
-	if (header->len >= NVRAM_SPACE) {
+	if (nvram_len >= NVRAM_SPACE) {
 		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 		       header->len, NVRAM_SPACE - 1);
-		header->len = NVRAM_SPACE - 1;
+		nvram_len = NVRAM_SPACE - 1;
 	}
 	/* proceed reading data after header */
-	for (; i < header->len; i += 4)
+	for (; i < nvram_len; i += 4)
 		*dst++ = readl(src++);
 	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
@@ -144,7 +146,6 @@ static int nvram_init(void)
 #ifdef CONFIG_MTD
 	struct mtd_info *mtd;
 	struct nvram_header header;
-	struct nvram_header *pheader;
 	size_t bytes_read;
 	int err;
 
@@ -155,20 +156,16 @@ static int nvram_init(void)
 	err = mtd_read(mtd, 0, sizeof(header), &bytes_read, (uint8_t *)&header);
 	if (!err && header.magic == NVRAM_MAGIC &&
 	    header.len > sizeof(header)) {
-		if (header.len >= NVRAM_SPACE) {
+		nvram_len = header.len;
+		if (nvram_len >= NVRAM_SPACE) {
 			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 				header.len, NVRAM_SPACE);
-			header.len = NVRAM_SPACE - 1;
+			nvram_len = NVRAM_SPACE - 1;
 		}
 
-		err = mtd_read(mtd, 0, header.len, &bytes_read,
+		err = mtd_read(mtd, 0, nvram_len, &nvram_len,
 			       (u8 *)nvram_buf);
-		if (err)
-			return err;
-
-		pheader = (struct nvram_header *)nvram_buf;
-		pheader->len = header.len;
-		return 0;
+		return err;
 	}
 #endif
 
@@ -183,7 +180,7 @@ int bcm47xx_nvram_getenv(const char *name, char *val, size_t val_len)
 	if (!name)
 		return -EINVAL;
 
-	if (!nvram_buf[0]) {
+	if (!nvram_len) {
 		err = nvram_init();
 		if (err)
 			return err;
@@ -231,16 +228,14 @@ char *bcm47xx_nvram_get_contents(size_t *nvram_size)
 {
 	int err;
 	char *nvram;
-	struct nvram_header *header;
 
-	if (!nvram_buf[0]) {
+	if (!nvram_len) {
 		err = nvram_init();
 		if (err)
 			return NULL;
 	}
 
-	header = (struct nvram_header *)nvram_buf;
-	*nvram_size = header->len - sizeof(struct nvram_header);
+	*nvram_size = nvram_len - sizeof(struct nvram_header);
 	nvram = vmalloc(*nvram_size);
 	if (!nvram)
 		return NULL;
-- 
1.8.4.5
