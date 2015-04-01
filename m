Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 08:24:06 +0200 (CEST)
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34928 "EHLO
        mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014449AbbDAGXh2Gs0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 08:23:37 +0200
Received: by widdi4 with SMTP id di4so33030032wid.0;
        Tue, 31 Mar 2015 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s7eMcvUMEHRLxzZ8wRzmaRkrz43bQ4tHJ+md1j3shro=;
        b=qOtMia48xODOV5eDaHztq7fCfmu70f9XxddVaIerfu2hKoasqpzmAl6NpgeEdCjiDL
         KJzvCAHJy65OlTfKeUcrupUDieqhqnJ/J0gFCQqlbuqujKB6+dTeWBWqGwTkhdMlXjiP
         pS/JC46B0C/rgdDyfQMcQHHQHNVUTZvr1KnZlOxZGZLYxYt0MjehFh+uvUtruZ/jTfSz
         91SL4+f8R/apczFmCPGr+ynDJPl4WaZsbYFmJHxMe084sKcO5Bqkg5b2gabZCCsY4p4z
         i+qverl80u2+L8k0xsue0JtS6Zrjnqlz1kHhUBAqxWUFZdezMNZvQCRx8xs/MgF1bv1B
         YdzA==
X-Received: by 10.180.94.199 with SMTP id de7mr11990947wib.53.1427869413371;
        Tue, 31 Mar 2015 23:23:33 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id dm6sm1588096wib.22.2015.03.31.23.23.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 23:23:32 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM47XX: Don't try guessing NVRAM size on MTD partition
Date:   Wed,  1 Apr 2015 08:23:05 +0200
Message-Id: <1427869385-23333-3-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46678
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

When dealing with whole flash content (bcm47xx_nvram_init_from_mem) we
need to find NVRAM start trying various partition sizes (nvram_sizes).
This is not needed when using MTD as we have direct partition access.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2ac7482..ba632ff 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -139,36 +139,28 @@ static int nvram_init(void)
 	struct mtd_info *mtd;
 	struct nvram_header header;
 	size_t bytes_read;
-	int err, i;
+	int err;
 
 	mtd = get_mtd_device_nm("nvram");
 	if (IS_ERR(mtd))
 		return -ENODEV;
 
-	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-		loff_t from = mtd->size - nvram_sizes[i];
-
-		if (from < 0)
-			continue;
-
-		err = mtd_read(mtd, from, sizeof(header), &bytes_read,
-			       (uint8_t *)&header);
-		if (!err && header.magic == NVRAM_MAGIC) {
-			u8 *dst = (uint8_t *)nvram_buf;
-			size_t len = header.len;
+	err = mtd_read(mtd, 0, sizeof(header), &bytes_read, (uint8_t *)&header);
+	if (!err && header.magic == NVRAM_MAGIC) {
+		u8 *dst = (uint8_t *)nvram_buf;
+		size_t len = header.len;
 
-			if (header.len > NVRAM_SPACE) {
-				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-				       header.len, NVRAM_SPACE);
-				len = NVRAM_SPACE;
-			}
+		if (header.len > NVRAM_SPACE) {
+			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+				header.len, NVRAM_SPACE);
+			len = NVRAM_SPACE;
+		}
 
-			err = mtd_read(mtd, from, len, &bytes_read, dst);
-			if (err)
-				return err;
+		err = mtd_read(mtd, 0, len, &bytes_read, dst);
+		if (err)
+			return err;
 
-			return 0;
-		}
+		return 0;
 	}
 #endif
 
-- 
1.8.4.5
