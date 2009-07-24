Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jul 2009 13:18:26 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.145]:54757 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492212AbZGXLSU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Jul 2009 13:18:20 +0200
Received: by ey-out-1920.google.com with SMTP id 13so372905eye.54
        for <multiple recipients>; Fri, 24 Jul 2009 04:18:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=gW8xZseDWqicA1EdninbI15ajKFMvYZ9VRBsjilvfg0=;
        b=UejrehriyZZ36ybMX1Asm8ejymCsOM2w8iY+xWEas3lWx7C43aoulhmxC8Ez+2fGYf
         TsoBxSmfR86e9tsXvKDtcPqs3DRRVogQyA/0d4quRBWTrU2sDS5H1eW6re7yx1M1jX8g
         0lVob/7L871XULXgAQhqzDWVWvkZp4hcLpZ74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=pkpViJHzuUNU8fri7QRGKO3icPW38uRe/5SSJWEEpxNTrFfPEi+K7iPOewFRHAm4IM
         5FgDEujbgfJfVNMeZ9vbwDmR8VlszmMDhZC+YSMXj6C44DMzgWzszdsbJPp8XGJGuIt1
         52w3eFt6ee3btzomDTdYRjYKDb4IXpnvxb31o=
Received: by 10.210.58.13 with SMTP id g13mr4066063eba.99.1248434299567;
        Fri, 24 Jul 2009 04:18:19 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm666097eyh.28.2009.07.24.04.18.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 04:18:19 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Fri, 24 Jul 2009 13:18:16 +0200
Subject: [PATCH 1/3] ar7: use DMA_BIT_MASK(nn) instead of deprecated DMA_nnBIT_MASK
MIME-Version: 1.0
X-UID:	771
X-Length: 1893
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907241318.16925.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Replaced use of DMA_nnBIT_MASK by DMA_BIT_MASK(nn).

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index d0624d8..21d43f2 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -242,13 +242,13 @@ static struct platform_device physmap_flash = {
 	.num_resources = 1,
 };
 
-static u64 cpmac_dma_mask = DMA_32BIT_MASK;
+static u64 cpmac_dma_mask = DMA_BIT_MASK(32);
 static struct platform_device cpmac_low = {
 	.id = 0,
 	.name = "cpmac",
 	.dev = {
 		.dma_mask = &cpmac_dma_mask,
-		.coherent_dma_mask = DMA_32BIT_MASK,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &cpmac_low_data,
 	},
 	.resource = cpmac_low_res,
@@ -260,7 +260,7 @@ static struct platform_device cpmac_high = {
 	.name = "cpmac",
 	.dev = {
 		.dma_mask = &cpmac_dma_mask,
-		.coherent_dma_mask = DMA_32BIT_MASK,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
 		.platform_data = &cpmac_high_data,
 	},
 	.resource = cpmac_high_res,
