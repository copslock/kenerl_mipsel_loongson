Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 18:46:28 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33107 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013148AbbELQq1BKfLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 18:46:27 +0200
Received: by wgin8 with SMTP id n8so16710080wgi.0;
        Tue, 12 May 2015 09:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bOGhVRR9SkTKnzhNFzIopSOsvIl5dMuzy6rO34Y4Dic=;
        b=kulowX06R4rLNLQHIrvXRmpuLxLQ8BW/AwXkB002DJ3B842ZGFB6e/USsDBsU7wtw/
         AtBD8bjJfakE4g2dKfaMDHIuokeYkt7NtjRe0uQpxJaXQEYDHgue9iyIWmDRHKW5O4YR
         tQ2paIetJCo62F7mNj8mTfPpOPR9zZ1eBRs42HF2+8w4XoLz/FmZBgG6fxJE3hSh7mwL
         fD7XBXtIoFJc2I+TNhW/D0LOoTXHe8VlWhVDnew+JeE23/uhP+OYDZwzKXUI4yqL3DK+
         ztiSzo7thIgCDKUYVA2/i5DeIK9Qb3cEGeotUvVYmtopbO6HEJk0h01H4WUAA34j3mTd
         P49Q==
X-Received: by 10.194.91.176 with SMTP id cf16mr31222118wjb.141.1431449183892;
        Tue, 12 May 2015 09:46:23 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id lh8sm16616610wjc.23.2015.05.12.09.46.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 09:46:22 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Hante Meuleman <meuleman@broadcom.com>,
        Ian Kent <raven@themaw.net>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM47XX: Make sure NVRAM buffer ends with \0
Date:   Tue, 12 May 2015 18:46:11 +0200
Message-Id: <1431449172-11352-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47348
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

This will simplify reading its contents.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/nvram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index ba632ff..dee1c32 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -98,7 +98,7 @@ found:
 		pr_err("The nvram size accoridng to the header seems to be bigger than the partition on flash\n");
 	if (header->len > NVRAM_SPACE)
 		pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-		       header->len, NVRAM_SPACE);
+		       header->len, NVRAM_SPACE - 1);
 
 	src = (u32 *)header;
 	dst = (u32 *)nvram_buf;
@@ -106,6 +106,7 @@ found:
 		*dst++ = __raw_readl(src++);
 	for (; i < header->len && i < NVRAM_SPACE && i < size; i += 4)
 		*dst++ = readl(src++);
+	nvram_buf[NVRAM_SPACE - 1] = '\0';
 
 	return 0;
 }
@@ -150,10 +151,10 @@ static int nvram_init(void)
 		u8 *dst = (uint8_t *)nvram_buf;
 		size_t len = header.len;
 
-		if (header.len > NVRAM_SPACE) {
+		if (len >= NVRAM_SPACE) {
+			len = NVRAM_SPACE - 1;
 			pr_err("nvram on flash (%i bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
-				header.len, NVRAM_SPACE);
-			len = NVRAM_SPACE;
+				header.len, len);
 		}
 
 		err = mtd_read(mtd, 0, len, &bytes_read, dst);
-- 
1.8.4.5
