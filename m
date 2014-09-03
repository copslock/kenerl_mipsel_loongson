Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 19:14:55 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61691 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008043AbaICROxsKAFb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 19:14:53 +0200
Received: by mail-wi0-f176.google.com with SMTP id bs8so1366845wib.9
        for <linux-mips@linux-mips.org>; Wed, 03 Sep 2014 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=AUT9JlIC5fal3+CWwa9aAjUpWbF7n4R1zEcm7UdnWa0=;
        b=zFcvPlySRbboKrNh709TJ38q6WlWSQC8WUBInyBIVuJbyLvCy1D+jgrvIk0SMccDJy
         0E6o6ZDfn4AOCzZy6a4nlB3Ye8jwlU+gREXnDmvPteFTVO23FkPb4VeVu6i+1Edl+jKx
         IuYpIsjjm2iRi5JIq1hA3A4gkTqzm9tKZpb8xAoyCYnomrvmRM0lELLm5DFt32IPo98E
         hV4qgXb0NF+e1SNwZS3s4ymWB8h26oQFkDb5Jnz2LEjQ7LsM3GuZDPynggLm8EvQlAey
         GKaJMQ38BLjborHjyrozbkJaxTv5m5yEcytgmpEViM2yTZglH+IZ2hE9+fQPrGTCFYNL
         tsVw==
X-Received: by 10.194.186.178 with SMTP id fl18mr48228539wjc.8.1409764488552;
        Wed, 03 Sep 2014 10:14:48 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id fh5sm5766244wib.5.2014.09.03.10.14.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2014 10:14:47 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH][RFC] MIPS: BCM47XX: Use mtd as an alternative way/API to get NVRAM content
Date:   Wed,  3 Sep 2014 19:14:41 +0200
Message-Id: <1409764481-20997-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42378
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

NVRAM can be read using magic memory offset, but after all it's just a
flash partition. On platforms where NVRAM isn't needed early we can get
it using mtd subsystem.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 8ea2116..9ab74db 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -16,6 +16,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
+#include <linux/mtd/mtd.h>
 #include <asm/addrspace.h>
 #include <bcm47xx_nvram.h>
 #include <asm/mach-bcm47xx/bcm47xx.h>
@@ -148,6 +149,13 @@ static int nvram_init_bcma(void)
 
 static int nvram_init(void)
 {
+#ifdef CONFIG_MTD
+	struct mtd_info *mtd;
+	struct nvram_header header;
+	size_t bytes_read;
+	int i;
+#endif
+
 	switch (bcm47xx_bus_type) {
 #ifdef CONFIG_BCM47XX_SSB
 	case BCM47XX_BUS_TYPE_SSB:
@@ -158,6 +166,38 @@ static int nvram_init(void)
 		return nvram_init_bcma();
 #endif
 	}
+
+#ifdef CONFIG_MTD
+	mtd = get_mtd_device_nm("nvram");
+	if (IS_ERR(mtd))
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
+		loff_t from = mtd->size - nvram_sizes[i];
+
+		if (from < 0)
+			continue;
+
+		if (mtd_read(mtd, from, sizeof(header), &bytes_read,
+			     (uint8_t *)&header) < 0)
+			continue;
+		if (header.magic == NVRAM_HEADER) {
+			u8 *dst = (uint8_t *)nvram_buf;
+			size_t len = header.len;
+
+			if (header.len > NVRAM_SPACE) {
+				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+				       header.len, NVRAM_SPACE);
+				len = NVRAM_SPACE;
+			}
+
+			if (mtd_read(mtd, from, len, &bytes_read, dst) < 0)
+				continue;
+			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
+		}
+	}
+#endif
+
 	return -ENXIO;
 }
 
-- 
1.8.4.5
