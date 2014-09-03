Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Sep 2014 22:51:22 +0200 (CEST)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33578 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007452AbaICUvUnvhW3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Sep 2014 22:51:20 +0200
Received: by mail-wi0-f181.google.com with SMTP id e4so10626054wiv.2
        for <multiple recipients>; Wed, 03 Sep 2014 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3H3yVQUvZExRlh0KpMYURYD30pUlPKE8IqtFmCdltPY=;
        b=UNyrtJTTrFUpdvYr77K4pjwBDL6RQMtR0ZfnSTzW/krbGsPwCNnMUecCq0s+speJaV
         oxrIcrtS8vuWogENakXsb24dcWQtamhG1P+KfT1EjnP4tkPhhihZLCklHlko5CaGHyCJ
         Lra91raHksXtPFGAe4lmqaEFOk+z0+ccS04zs4TTpW6T+P9ZHgoiCQ3qL1rjqdBUYxzS
         UvZXvBDKt7nZK4/6jWR36sdAGPOwBxx2ERK1MPhxRUo2UK/Z0wpS+zAlWkyWqK2PoAz1
         rcPp8hv/T6K/CPRIGYHqElhetk5fby20iO3OX7O4kjONPk3DqAUXpRi/A3vaX7cJA2fR
         qBdg==
X-Received: by 10.180.87.231 with SMTP id bb7mr95246wib.63.1409777475395;
        Wed, 03 Sep 2014 13:51:15 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id z5sm6312448wib.20.2014.09.03.13.51.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Sep 2014 13:51:14 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2] MIPS: BCM47XX: Get rid of calls to KSEG1ADDR
Date:   Wed,  3 Sep 2014 22:51:06 +0200
Message-Id: <1409777466-28496-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1409587730-18849-1-git-send-email-zajec5@gmail.com>
References: <1409587730-18849-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42383
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
V2: Use __iomem for *header
    iounmap when initialization is done
    Thanks Hauke!
---
 arch/mips/bcm47xx/nvram.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 2bed73a..e07976b 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -23,13 +23,13 @@
 static char nvram_buf[NVRAM_SPACE];
 static const u32 nvram_sizes[] = {0x8000, 0xF000, 0x10000};
 
-static u32 find_nvram_size(u32 end)
+static u32 find_nvram_size(void __iomem *end)
 {
-	struct nvram_header *header;
+	struct nvram_header __iomem *header;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvram_sizes); i++) {
-		header = (struct nvram_header *)KSEG1ADDR(end - nvram_sizes[i]);
+		header = (struct nvram_header *)(end - nvram_sizes[i]);
 		if (header->magic == NVRAM_HEADER)
 			return nvram_sizes[i];
 	}
@@ -38,35 +38,39 @@ static u32 find_nvram_size(u32 end)
 }
 
 /* Probe for NVRAM header */
-static int nvram_find_and_copy(u32 base, u32 lim)
+static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 {
-	struct nvram_header *header;
+	struct nvram_header __iomem *header;
 	int i;
 	u32 off;
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
@@ -94,6 +98,22 @@ found:
 	return 0;
 }
 
+static int bcm47xx_nvram_init_from_mem(u32 base, u32 lim)
+{
+	void __iomem *iobase;
+	int err;
+
+	iobase = ioremap_nocache(base, lim);
+	if (!iobase)
+		return -ENOMEM;
+
+	err = nvram_find_and_copy(iobase, lim);
+
+	iounmap(iobase);
+
+	return err;
+}
+
 #ifdef CONFIG_BCM47XX_SSB
 static int nvram_init_ssb(void)
 {
@@ -109,7 +129,7 @@ static int nvram_init_ssb(void)
 		return -ENXIO;
 	}
 
-	return nvram_find_and_copy(base, lim);
+	return bcm47xx_nvram_init_from_mem(base, lim);
 }
 #endif
 
@@ -139,7 +159,7 @@ static int nvram_init_bcma(void)
 		return -ENXIO;
 	}
 
-	return nvram_find_and_copy(base, lim);
+	return bcm47xx_nvram_init_from_mem(base, lim);
 }
 #endif
 
-- 
1.8.4.5
