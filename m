Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Feb 2014 17:48:30 +0100 (CET)
Received: from mail-ea0-f175.google.com ([209.85.215.175]:59728 "EHLO
        mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827441AbaBMQs1tCJXV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Feb 2014 17:48:27 +0100
Received: by mail-ea0-f175.google.com with SMTP id n15so2451493ead.6
        for <multiple recipients>; Thu, 13 Feb 2014 08:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=2241Q3hN//Ib4KNWFLxFCChEzIN9kejc8+eY10/1w6I=;
        b=Gk6awRvQR3dnt0h+VCU3g9mmu0BqGHHPXKQB5LX9eT00as6eoU0TfAwAazWzzYICpn
         B/JFX4Hk5CXsZEoYGc6YdEVMqqTzMSRiXQ2ynskT+pBelzOdnu3RFtJsWo5bngHhHIov
         kV5VZ0tjuRg+OyO75I9AENpVHQilnL3JbemDnI800c/Zs1CC7qfxU1dEelohfosMlhh/
         5TiUKfAJyQnmjoWBDSCM6enE2UaSYUlEFQJGwjNAaKnBarRdJh9pU3bya1kAqh1X9bQg
         7qt+gs25cFMtCyYl0ealgtxHVAEKsYVZIL5JHqmhIJ9+hdBo3uWTY0MXP12CfznlIEbP
         xdkA==
X-Received: by 10.15.10.73 with SMTP id f49mr3213012eet.2.1392310102436;
        Thu, 13 Feb 2014 08:48:22 -0800 (PST)
Received: from linux-x91w.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id y47sm8867153eel.14.2014.02.13.08.48.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2014 08:48:21 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when looking for a pin
Date:   Thu, 13 Feb 2014 17:48:12 +0100
Message-Id: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39298
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

Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
ones too. Example:
gpio23=wombo_reset

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
Preferably this should go as a fix for 3.14. It's really trivial and
allows support for some devices that require reset by GPIO after boot.
---
 arch/mips/bcm47xx/nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
index 6decb27..2bed73a 100644
--- a/arch/mips/bcm47xx/nvram.c
+++ b/arch/mips/bcm47xx/nvram.c
@@ -196,7 +196,7 @@ int bcm47xx_nvram_gpio_pin(const char *name)
 	char nvram_var[10];
 	char buf[30];
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < 32; i++) {
 		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
 		if (err <= 0)
 			continue;
-- 
1.8.4.5
