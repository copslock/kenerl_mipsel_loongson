Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jan 2014 09:56:06 +0100 (CET)
Received: from mail-ea0-f178.google.com ([209.85.215.178]:36272 "EHLO
        mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825722AbaACIzoSo0ud (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jan 2014 09:55:44 +0100
Received: by mail-ea0-f178.google.com with SMTP id d10so6564634eaj.23
        for <multiple recipients>; Fri, 03 Jan 2014 00:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FgDZX0n2eNGKRWpmLZwneHQ8UeZqvOhBj/5swbjEbTg=;
        b=Num+Za21jhKCfbleDA6m8p33+c557xjQZcHA+iOSQfqIRRz7Fsy3zT9F4ZvWgmg7V1
         uJkfVbmMYD/0RMYZ/45XS41DhzpTA2Ns8ZUwpxLq7ONxY8PnvJqlo8Y21+V/Yq75av2h
         gUFndq5Izl75mfDI6znBFbp3ZpAbQKkDnKxmQkR18z788ptd3AFziZHGE4teh2AJwavR
         CUNAY+mnIcs0fu0Zu7mB0wQGhXA/whUWp+OwYdMHGPTZpl2y5hXR6m76CNQ4K+X4HYp1
         sv/bDqa03pywrG9ULNOCKefLWWZz+wM2XxUVKezAJBurTfKoN5kiBME7aTZwmj/H9Qpq
         S+Iw==
X-Received: by 10.14.53.14 with SMTP id f14mr583977eec.105.1388739339062;
        Fri, 03 Jan 2014 00:55:39 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id o1sm143102647eea.10.2014.01.03.00.55.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2014 00:55:38 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 2/2] MIPS: BCM47XX: Enable buttons support on SSB
Date:   Fri,  3 Jan 2014 09:55:30 +0100
Message-Id: <1388739330-420-2-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1388739330-420-1-git-send-email-zajec5@gmail.com>
References: <1388739330-420-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38861
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

This is supported since implementing IRQ domain in ssb.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/bcm47xx/buttons.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/mips/bcm47xx/buttons.c b/arch/mips/bcm47xx/buttons.c
index 51815ba..872c62e 100644
--- a/arch/mips/bcm47xx/buttons.c
+++ b/arch/mips/bcm47xx/buttons.c
@@ -3,7 +3,6 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/interrupt.h>
-#include <linux/ssb/ssb_embedded.h>
 #include <bcm47xx_board.h>
 #include <bcm47xx.h>
 
@@ -359,13 +358,6 @@ int __init bcm47xx_buttons_register(void)
 	enum bcm47xx_board board = bcm47xx_board_get();
 	int err;
 
-#ifdef CONFIG_BCM47XX_SSB
-	if (bcm47xx_bus_type == BCM47XX_BUS_TYPE_SSB) {
-		pr_debug("Buttons on SSB are not supported yet.\n");
-		return -ENOTSUPP;
-	}
-#endif
-
 	switch (board) {
 	case BCM47XX_BOARD_ASUS_RTN12:
 		err = bcm47xx_copy_bdata(bcm47xx_buttons_asus_rtn12);
-- 
1.7.10.4
