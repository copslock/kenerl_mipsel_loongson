Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Mar 2016 08:00:05 +0100 (CET)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35392 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006532AbcCHHAEbzqNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Mar 2016 08:00:04 +0100
Received: by mail-lb0-f176.google.com with SMTP id bc4so6935767lbc.2;
        Mon, 07 Mar 2016 23:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bn6QbJsGmHzxwzjSmQUmlEU4a8MBJwMAZOGadIpPHnA=;
        b=aackr9lVApx2BxaRNj8Rh2e/+Lmo77ILgy9iuuSyuRLZ+15uqTXwoIe2Mhg3il8pTU
         nqucSnn7YVjVRKqz9D9SnOVwKmqjaYOSfYekEJXqN9QtKUZ+bSpCYWUjYIvGFOj8Impn
         QTfNEUV9s69iGHTrRZxVWDxAg2A3JBUntsLco2GoYffXGCQOXNKDCvR0zArmsOByX1ue
         Z0OKBaP1YTleGz2Ud8Zhbu2E3R9+V7uJQz0q0f6ia20B2iJzPL57z8ZF5gHY5T4gxE6f
         DB8Fb+KvDzR9CsjXZ4WYJNpE6ITwrrVaq/M5wEGA+ezBVn2HipOUJa0Hl0rrF8icGwLD
         wyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bn6QbJsGmHzxwzjSmQUmlEU4a8MBJwMAZOGadIpPHnA=;
        b=fuBoqTyficwpUym6sF8V8nAQzgnAjONDj3Hfm54bRbTcIGsTiCKfqBq2KPHMSe0sBz
         GrJhcN7oJr3EPWdJE7PqsbmL5QkJsSgmfVw7GLLrUzf5PNQs26/3hyBN8qGLhWJstl6g
         wJL1I2XMHwMrozR80OCLMboR0yWn4DX7Rj+sIoS6woJxVzeSEi0lwqpQ3oCPDayjujq1
         hS1kq5a3Ef+oE5eOdK7/mf3UMaOGpUXXHbMZ7sVqz/JvZZSes24WoJoMwzaac5+tuPSi
         oTYEWhPR91CgsvoZt3lkWd48e1q/IzDMecsldBvLAaG6o8ceSznKjzTBORVfDOx4FS7o
         eNSw==
X-Gm-Message-State: AD7BkJIAkiBA2I2OMoFYgSgwmk2zKIXqEdQsu41LJShRavuOHGyXs1kXUZeusZTj+K1bgw==
X-Received: by 10.25.81.148 with SMTP id f142mr7485296lfb.95.1457420399062;
        Mon, 07 Mar 2016 22:59:59 -0800 (PST)
Received: from linux-samsung.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id n185sm234614lfd.11.2016.03.07.22.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2016 22:59:57 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] bcm47xx_sprom: Fix compilation with ssb/bcma as module
Date:   Tue,  8 Mar 2016 07:59:32 +0100
Message-Id: <1457420372-20584-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52550
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

It was failing due to unknown ssb_arch_register_fallback_sprom or
bcma_arch_register_fallback_sprom with CONFIG_SSB=m or CONFIG_BCMA=m

Fixes: e8a46c88b516 ("MIPS: BCM47xx: Move SPROM driver to drivers/firmware/¨)
Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
Ralf, this is for mips-for-linux-next. If you happen to rebase your tree, you
may squash this one with e8a46c88b516.
Sorry for the problem.
---
 drivers/firmware/broadcom/bcm47xx_sprom.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c b/drivers/firmware/broadcom/bcm47xx_sprom.c
index 5dfd459..c3d1bf2 100644
--- a/drivers/firmware/broadcom/bcm47xx_sprom.c
+++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
@@ -601,7 +601,7 @@ void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
 	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
 }
 
-#if defined(CONFIG_SSB_SPROM)
+#if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
 static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 {
 	char prefix[10];
@@ -624,7 +624,7 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
 }
 #endif
 
-#if defined(CONFIG_BCMA)
+#if IS_BUILTIN(CONFIG_BCMA)
 /*
  * Having many NVRAM entries for PCI devices led to repeating prefixes like
  * pci/1/1/ all the time and wasting flash space. So at some point Broadcom
@@ -719,12 +719,12 @@ int bcm47xx_sprom_register_fallbacks(void)
 	if (bcm47xx_sprom_registered)
 		return 0;
 
-#if defined(CONFIG_SSB_SPROM)
+#if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
 	if (ssb_arch_register_fallback_sprom(&bcm47xx_get_sprom_ssb))
 		pr_warn("Failed to registered ssb SPROM handler\n");
 #endif
 
-#if defined(CONFIG_BCMA)
+#if IS_BUILTIN(CONFIG_BCMA)
 	if (bcma_arch_register_fallback_sprom(&bcm47xx_get_sprom_bcma))
 		pr_warn("Failed to registered bcma SPROM handler\n");
 #endif
-- 
1.8.4.5
