Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2014 11:50:31 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:54086 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007777AbaLJKuOdV4SX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2014 11:50:14 +0100
Received: by mail-wi0-f173.google.com with SMTP id r20so10766320wiv.0
        for <multiple recipients>; Wed, 10 Dec 2014 02:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0FxFyhH3/KW8Ji6rN6EUuroUJlIdP1+8DVG+2AjxJY0=;
        b=Cf5MgOnF4fHUgJVcO2OZl74pir0jPYCCAb11Tf4lQwnsjdHKvM6kzDZK1FDwVY6+WM
         NpHrKn2NPyjlnYWAt8vnhA6IXmaOu0hv9rQZ+sZjzaDMcSIU9/eZKl62jsdzsuGWzatT
         gPP4EwSWA4/ELHWN9OT9R3l4jxe9TD72PWSbAh/DDMDpYZRH1gwVhdKIRryj6DbILqvX
         8kIWjhWaUIWXdac6c7DGS9ILLyiCkpA/8hKnecFqlFZiWFIeH7eHwk6H0jqJDxAalJBi
         I/P1EjNKgSgxulXtlb2Z0Qt1niIHgP57+ynJTuRuf04nr+edE3fPpZeY/1gOdJKxjFCQ
         MFyA==
X-Received: by 10.194.79.226 with SMTP id m2mr5487226wjx.60.1418208609267;
        Wed, 10 Dec 2014 02:50:09 -0800 (PST)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id mc10sm17394697wic.24.2014.12.10.02.50.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Dec 2014 02:50:08 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Paul Walmsley <paul@pwsan.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/3] MIPS: BCM47XX: Use helpers for reading NVRAM content
Date:   Wed, 10 Dec 2014 11:49:53 +0100
Message-Id: <1418208594-16235-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
In-Reply-To: <1418208594-16235-1-git-send-email-zajec5@gmail.com>
References: <1418208594-16235-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44612
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

Also drop some unneeded memset-s.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 9e7c909..a68e5f9 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -93,7 +93,6 @@ static int nvram_find_and_copy(void __iomem *iobase, u32 lim)
 	return -ENXIO;
 
 found:
-
 	if (header->len > size)
 		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
 	if (header->len > NVRAM_SPACE)
@@ -103,10 +102,9 @@ found:
 	src = (u32 *)header;
 	dst = (u32 *)nvram_buf;
 	for (i = 0; i < sizeof(struct nvram_header); i += 4)
-		*dst++ = *src++;
+		*dst++ = __raw_readl(src++);
 	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
-		*dst++ = le32_to_cpu(*src++);
-	memset(dst, 0x0, NVRAM_SPACE - i);
+		*dst++ = readl(src++);
 
 	return 0;
 }
@@ -167,7 +165,6 @@ static int nvram_init(void)
 			err = mtd_read(mtd, from, len, &bytes_read, dst);
 			if (err)
 				return err;
-			memset(dst + bytes_read, 0x0, NVRAM_SPACE - bytes_read);
 
 			return 0;
 		}
-- 
1.8.4.5
