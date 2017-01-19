Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2017 11:06:55 +0100 (CET)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:34564
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993014AbdASKGrevkw0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2017 11:06:47 +0100
Received: by mail-wm0-x243.google.com with SMTP id c85so10780754wmi.1
        for <linux-mips@linux-mips.org>; Thu, 19 Jan 2017 02:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tj5d2XouYLne72FHHi2RCi9x37sURE6kZuCAQYuUZcs=;
        b=SrxvoEuCZeDTL7wFN/Z9zM2ltiso+YTHe0gxl93Fi+dexOsGb3iDMHGUgvfPc1gymP
         u2IrKfqjcwXfc0etUXEvhNRVtBlpPhq2zOl92soP7cVBgy8QKf8wuaFiiYlcwyDli36l
         3gx/nMA22VibcShp/QxVXOo2d5ijGFfPjFiFG7Zd9O0oHvF5DjTFa7vlOJ4lKIipN3xX
         ptbhOI9MchsGDKyJE9hCYPNhXUyMSFCLYQkrIGPc5TCoChnkzYOZm2eVprVaZcXSBis0
         uUAdfQnq3Xki2OHd9Bj/yW/ZlrqQ4UMQh+Ipgl5C4ajIj1XoNVgYnFERLl7hInsT188J
         W0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tj5d2XouYLne72FHHi2RCi9x37sURE6kZuCAQYuUZcs=;
        b=oGuqw/TCwNTqNalLbBYYW5PKf/oNnUyqDCsQeWpCDaysqKeDkP0OLNURQ8kM9D/IBE
         pkd5c+ndfcz+QyPH0v0YTx3E9oKjMTJ9FCEPpMtXQmMZK6BNYm83QpPL2RIogT0aL24i
         4erefxDVhAaq2hdKTO2JAxcMabfFpuYpe0wqvC+z7fjbZWMfMkPI6v0JbIsFJdwtGFGN
         a34YfdUlUiHorjrvODQ6nCbeyRtDVI0+iQsB4mXlkcr3zkKXyJt+9PCsFxlukdJ/E4nD
         vLM0ilA1/bRA03Bg4sVxJSGmPLQxiVbyYIkesUOARocid+YD52Qev5jXdaMAKhq3YWsa
         Fkgw==
X-Gm-Message-State: AIkVDXK0SzR6TdpOMf90DeU53+fBeIri6HAfA943uZMxZB7uuNSdODTAAIWXZ2zPJrJR0A==
X-Received: by 10.28.163.3 with SMTP id m3mr7000298wme.85.1484820402221;
        Thu, 19 Jan 2017 02:06:42 -0800 (PST)
Received: from serveurQA.phonesystems.net ([62.39.136.157])
        by smtp.gmail.com with ESMTPSA id w126sm4611345wmw.0.2017.01.19.02.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jan 2017 02:06:41 -0800 (PST)
From:   Sebastien Decourriere <sebtx452@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-mips@linux-mips.org,
        Sebastien Decourriere <sebtx452@gmail.com>
Subject: [PATCH] mtd: maps: lantiq-flash: Check if the EBU endianness swap is enabled
Date:   Thu, 19 Jan 2017 11:06:55 +0100
Message-Id: <1484820415-12439-1-git-send-email-sebtx452@gmail.com>
X-Mailer: git-send-email 2.1.4
Return-Path: <sebtx452@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebtx452@gmail.com
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

The purpose of this patch is to enable the software address endianness
swapping only when the in SoC EBU endianness swapping is disabled.
To perform this check, I look at Bit 30 of the EBU_CON_0 register.
Actually, the driver expects that the in SoC swapping is disabled.
This is the case with current bootloaders shuch as U-boot.

This applies only to vr9 (xrx200) rev 1.2 and ar10 (xrx300).

I have a router which uses a proprietary bootloader which keeps
the in SoC swapping enabled. The SoC in this router is a vrx200 v1.2.
In this SoC version, I can keep the in SoC swapping without any problem.

This patch replaces my previous broken patch.

Signed-off-by: Sebastien Decourriere <sebtx452@gmail.com>
---
 drivers/mtd/maps/lantiq-flash.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/lantiq-flash.c b/drivers/mtd/maps/lantiq-flash.c
index c8febb3..1cbbdcb 100644
--- a/drivers/mtd/maps/lantiq-flash.c
+++ b/drivers/mtd/maps/lantiq-flash.c
@@ -38,6 +38,8 @@ enum {
 	LTQ_NOR_NORMAL
 };
 
+#define EBU_ENDIAN_SWAP		BIT(30)
+
 struct ltq_mtd {
 	struct resource *res;
 	struct mtd_info *mtd;
@@ -113,6 +115,20 @@ ltq_mtd_probe(struct platform_device *pdev)
 	struct ltq_mtd *ltq_mtd;
 	struct cfi_private *cfi;
 	int err;
+	bool mtd_addr_swap;
+
+	/* If SoC is vr9 >= 1.2 or ar10 and EBU endian swap
+	   is enabled, we don't need to do software address swap */
+	if ( ltq_ebu_r32(LTQ_EBU_BUSCON0) & EBU_ENDIAN_SWAP ) {
+		switch (ltq_soc_type()) {
+			case SOC_TYPE_VR9_2 :
+			case SOC_TYPE_AR10 :
+				mtd_addr_swap = false;
+				break;
+			default :
+				mtd_addr_swap = true;
+		}
+	} else mtd_addr_swap = true;
 
 	if (of_machine_is_compatible("lantiq,falcon") &&
 			(ltq_boot_select() != BS_FLASH)) {
@@ -150,7 +166,10 @@ ltq_mtd_probe(struct platform_device *pdev)
 	ltq_mtd->map->copy_from = ltq_copy_from;
 	ltq_mtd->map->copy_to = ltq_copy_to;
 
-	ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
+	if (mtd_addr_swap)
+		ltq_mtd->map->map_priv_1 = LTQ_NOR_PROBING;
+	else
+		ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
 	ltq_mtd->mtd = do_map_probe("cfi_probe", ltq_mtd->map);
 	ltq_mtd->map->map_priv_1 = LTQ_NOR_NORMAL;
 
@@ -163,8 +182,10 @@ ltq_mtd_probe(struct platform_device *pdev)
 	mtd_set_of_node(ltq_mtd->mtd, pdev->dev.of_node);
 
 	cfi = ltq_mtd->map->fldrv_priv;
-	cfi->addr_unlock1 ^= 1;
-	cfi->addr_unlock2 ^= 1;
+	if (mtd_addr_swap) {
+		cfi->addr_unlock1 ^= 1;
+		cfi->addr_unlock2 ^= 1;
+	}
 
 	err = mtd_device_register(ltq_mtd->mtd, NULL, 0);
 	if (err) {
-- 
2.1.4
