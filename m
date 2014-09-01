Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2014 18:09:04 +0200 (CEST)
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59294 "EHLO
        mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007822AbaIAQJD0ZeDP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2014 18:09:03 +0200
Received: by mail-wi0-f178.google.com with SMTP id r20so6382642wiv.11
        for <multiple recipients>; Mon, 01 Sep 2014 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2pbGr71SDWdB1b80/2LhAeRx1m7+jEBw+tuA328iR7Q=;
        b=j1HjvWbX4rGov+7qpIgVLe71gjRaNdz0CVYU+6eK+6Lb48ig5umKdyPKVzfbAa81QH
         MVWlKeBnBsdBmhhSiOPqHnouB1Z7PDv6CBbhr+eTWLlLPRZHXT1zmDqJUeaQunZ1b0lC
         broEx+8GxZrO6423r7/4sd9P9JK7hETDJ2zmVESuqAw2G/Rsl/5VGd21XzTo2JdYSD9L
         sptnLpBGiSH6Y6i3DxEfVT4gZkVUQWzSwrcTZlAAU5JSMtkpe54X7Q32/aOsDLNGRyTu
         9qeY0Ab0CcVkajJ11DMRcivRzo+17kdp3O00ieiTs91sjAKnjNrOigYOR8+FV5p2PvCr
         Wusg==
X-Received: by 10.194.77.243 with SMTP id v19mr32765231wjw.18.1409587738079;
        Mon, 01 Sep 2014 09:08:58 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id hm5sm3120912wjb.2.2014.09.01.09.08.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Sep 2014 09:08:57 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR in nvram
Date:   Mon,  1 Sep 2014 18:08:50 +0200
Message-Id: <1409587730-18849-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42361
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

We should be using ioremap_nocache helper which handles remaps in a
smarter way.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2bed73a..2f0a646 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -23,13 +23,13 @@
 static char nvram_buf[NVRAM_SPACE];
 static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 
-static u32 find_nvram_size(u32 end)
+static u32 find_nvram_size(void __iomem *end)
 {
 	struct nvram_header *header;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-		header = (struct nvram_header *)KSEG1ADDR(end - nvram_sizes[i]);
+		header = (struct nvram_header *)(end - nvram_sizes[i]);
 		if (header->magic == NVRAM_HEADER)
 			return nvram_sizes[i];
 	}
@@ -38,7 +38,7 @@ static u32 find_nvram_size(u32 end)
 }
 
 /* Probe for NVRAM header */
-static int nvram_find_and_copy(u32 base, u32 lim)
+static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 {
 	struct nvram_header *header;
 	int i;
@@ -46,27 +46,31 @@ static int nvram_find_and_copy(u32 base, u32 lim)
 	u32 *src, *dst;
 	u32 size;
 
+	if (nvram_buf[0]) {
+		pr_warn("nvram already initialized\n");
+		return -EEXIST;
+	}
+
 	/* TODO: when nvram is on nand flash check for bad blocks first. */
 	off = FLASH_MIN;
 	while (off <= lim) {
 		/* Windowed flash access */
-		size = find_nvram_size(base + off);
+		size = find_nvram_size(iobase + off);
 		if (size) {
-			header = (struct nvram_header *)KSEG1ADDR(base + off -
-								  size);
+			header = (struct nvram_header *)(iobase + off - size);
 			goto found;
 		}
 		off <<= 1;
 	}
 
 	/* Try embedded NVRAM at 4 KB and 1 KB as last resorts */
-	header = (struct nvram_header *) KSEG1ADDR(base + 4096);
+	header = (struct nvram_header *)(iobase + 4096);
 	if (header->magic == NVRAM_HEADER) {
 		size = NVRAM_SPACE;
 		goto found;
 	}
 
-	header = (struct nvram_header *) KSEG1ADDR(base + 1024);
+	header = (struct nvram_header *)(iobase + 1024);
 	if (header->magic == NVRAM_HEADER) {
 		size = NVRAM_SPACE;
 		goto found;
@@ -94,6 +98,17 @@ found:
 	return 0;
 }
 
+static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
+{
+	void __iomem *iobase;
+
+	iobase = ioremap_nocache(base, lim);
+	if (!iobase)
+		return -ENOMEM;
+
+	return nvram_find_and_copy(iobase, lim);
+}
+
 #ifdef CONFIG_BCM47XX_SSB
 static int nvram_init_ssb(void)
 {
@@ -109,7 +124,7 @@ static int nvram_init_ssb(void)
 		return -ENXIO;
 	}
 
-	return nvram_find_and_copy(base, lim);
+	return bcm47xx_nvram_init_from_mem(base, lim);
 }
 #endif
 
@@ -139,7 +154,7 @@ static int nvram_init_bcma(void)
 		return -ENXIO;
 	}
 
-	return nvram_find_and_copy(base, lim);
+	return bcm47xx_nvram_init_from_mem(base, lim);
 }
 #endif
 
-- 
1.8.4.5
