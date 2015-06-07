Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2015 13:27:03 +0200 (CEST)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:36684 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006510AbbFGL1BkwDyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2015 13:27:01 +0200
Received: by wgbgq6 with SMTP id gq6so83721026wgb.3;
        Sun, 07 Jun 2015 04:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=HiRZRv8rXLrFCv35sHYuYxCtaRFRfcHP5S2HD5HO44k=;
        b=UqIs3PNhSy0Tm8/wT05lh6Obaf7bGHbQStUrm9L9tMFUGSnwox2sOAwRkGr//0iHOB
         sdppMDEzDY8ZS4NKp6qF1bN3YYCXaDfCZermoJeHDfcdWALBIUG5HJnmDU17l/3SFLh4
         qCPqzEOXIe2NlDOxUgohSbydnUdgWngok8NFGB8ePSdCswbLVR/qUQ0xz9lDbybriPpB
         TKTi+Urubypk43Y58NjOFvrzbGCvt6tvpeYbv1tKsYbLq1xRFnAwRmNsANuKETtmW4Xa
         2w+jwfHEsVqaA8SYBcqWfh6QPFfVlU9dkfztdbr+0WCwib8AFm7IOeo2GX8IQRfqJbJC
         fu2w==
X-Received: by 10.194.118.167 with SMTP id kn7mr21935101wjb.113.1433676416529;
        Sun, 07 Jun 2015 04:26:56 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id m10sm3259739wib.17.2015.06.07.04.26.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 04:26:55 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] MIPS: BCM47XX: Don't select BCMA_HOST_PCI
Date:   Sun,  7 Jun 2015 13:26:44 +0200
Message-Id: <1433676404-18577-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47898
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

SoC may have non-Broadcom PCI device attached or one may want to use
totally different PCI driver.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index fc21d36..51ed599 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -25,7 +25,6 @@ config BCM47XX_BCMA
 	select BCMA
 	select BCMA_HOST_SOC
 	select BCMA_DRIVER_MIPS
-	select BCMA_HOST_PCI if PCI
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
 	default y
-- 
1.8.4.5
