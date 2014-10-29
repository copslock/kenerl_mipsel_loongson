Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2014 10:05:49 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36570 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011886AbaJ2JFrlrEzu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2014 10:05:47 +0100
Received: by mail-wg0-f41.google.com with SMTP id k14so1355943wgh.14
        for <multiple recipients>; Wed, 29 Oct 2014 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ODMxdDJarNnl5ZVVOOiEkT4PlgeV4ynMIsIIdldr5fI=;
        b=oP0zraiNu31dGikxRDaCwStPigDeiolMf51gy1fSiataRYf0Ekn7YkqFK1AgnwPFGm
         H3WgHNjSAZMeoBZZboQ0e6Yuaa6KnoHj4tJOZQbZQfw4oGujiGLuDg2W1eJ0pRquvSTW
         lRY1yiGCYCzQhR7Am5lvpJCLQsbLFW5To0QGYUwhzW9RkNl9DYQ4PKLB82oWdoWadtz4
         jDbPJs/op4nCQgOoD/s3JXXumsVuTIkpPbXf7Y8Lg2GKtcJaxB42VTv/MiVsaQEyXcSV
         aQTARy7rSDg6WD7ukwZfT3i0K0lzsYt0K6rxkHVOnU+T7tnKGv32NAaEZ3lYLeqP2caC
         QKNw==
X-Received: by 10.194.175.67 with SMTP id by3mr10866413wjc.32.1414573542403;
        Wed, 29 Oct 2014 02:05:42 -0700 (PDT)
Received: from linux-tdhb.lan (static-91-227-21-4.devs.futuro.pl. [91.227.21.4])
        by mx.google.com with ESMTPSA id u2sm4479237wjz.11.2014.10.29.02.05.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Oct 2014 02:05:41 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Use mtd as an alternative way/API to get NVRAM content
Date:   Wed, 29 Oct 2014 10:05:06 +0100
Message-Id: <1414573506-10395-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43694
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
Changes since RFC:
1) Less #ifdef mess
2) Use err = mtd_read(..);
(with these changes all issues reported by Hauke were handled)
3) Clean #include-s

I successfully use this code on ARM for months.
---
 arch/mips/bcm47xx/nvram.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 21712fb..8b64991 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -13,12 +13,10 @@
 
 #include <linux/types.h>
 #include <linux/module.h>
-#include <linux/ssb/ssb.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
-#include <asm/addrspace.h>
+#include <linux/mtd/mtd.h>
 #include <bcm47xx_nvram.h>
-#include <asm/mach-bcm47xx/bcm47xx.h>
 
 static char nvram_buf[NVRAM_SPACE];
 static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
@@ -123,7 +121,43 @@ int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
 
 static int nvram_init(void)
 {
-	/* TODO: Look for MTD "nvram" partition */
+#ifdef CONFIG_MTD
+	struct mtd_info *mtd;
+	struct nvram_header header;
+	size_t bytes_read;
+	int err, i;
+
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
+		err = mtd_read(mtd, from, sizeof(header), &bytes_read,
+			       (uint8_t *)&header);
+		if (!err && header.magic == NVRAM_HEADER) {
+			u8 *dst = (uint8_t *)nvram_buf;
+			size_t len = header.len;
+
+			if (header.len > NVRAM_SPACE) {
+				pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+				       header.len, NVRAM_SPACE);
+				len = NVRAM_SPACE;
+			}
+
+			err = mtd_read(mtd, from, len, &bytes_read, dst);
+			if (err)
+				return err;
+			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
+
+			return 0;
+		}
+	}
+#endif
 
 	return -ENXIO;
 }
-- 
1.8.4.5
