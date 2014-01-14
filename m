Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 15:23:46 +0100 (CET)
Received: from mail-ea0-f175.google.com ([209.85.215.175]:38063 "EHLO
        mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826363AbaANOXkFRjx4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 15:23:40 +0100
Received: by mail-ea0-f175.google.com with SMTP id z10so3989524ead.34
        for <multiple recipients>; Tue, 14 Jan 2014 06:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bE7WPN/C9nNa8r+2f6+Nf+pXVVQ9c2usCPq66kxg9xs=;
        b=dWcyaP+aSL0k1WTYuN9XbB1O3DAj+mVxEoc/8hogU08oUyoy240s1AObB9iro7719Z
         BdtX8WPixeQ+jJE7uVp+ASnw1Kd8hb2/+vbBkHtOwFbzyM2O+4y9YnA5ux9yGWPiJeo1
         bLlg+ntR+k9gpWufLs0Y+XO3mU8ORme09/F+VjbmKVcCYiLmFM1F/fVAJl2Lm1uLePtv
         ez8kOHvOM9qZekZzkkSqCo0IygxQO7l6eZ8DwtAr1fnA4cWOWZnEsARuwaOZrTUpDbma
         UOaK/edbVnzgmZHf7g6vvuRg8Vkkegei3Kuwd0qWGhqJJzzzADi4YScVLGzfXns9gRDD
         itUw==
X-Received: by 10.15.42.204 with SMTP id u52mr1646376eev.47.1389709414699;
        Tue, 14 Jan 2014 06:23:34 -0800 (PST)
Received: from linux-samsung700g7a.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id j46sm2020445eew.18.2014.01.14.06.23.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2014 06:23:33 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>, Michael Buesch <m@bues.ch>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] ssb: gpio: use #if instead of "if" for IS_ENABLED
Date:   Tue, 14 Jan 2014 15:23:29 +0100
Message-Id: <1389709409-31807-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38977
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

Standard "if" was evaluating to if (0) which still required conditional
code to be correct. It is not, as ssb_gpio_to_irq is not defined.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
John: if you manage to, you should merge (bundle?) this one with
ssb: gpio: add own IRQ domain
(to avoid build breakage during bisection)
---
 drivers/ssb/driver_gpio.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 6c5a97d..ba350d2 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -230,8 +230,9 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_chipco_set_value;
 	chip->direction_input	= ssb_gpio_chipco_direction_input;
 	chip->direction_output	= ssb_gpio_chipco_direction_output;
-	if (IS_ENABLED(CONFIG_SSB_EMBEDDED))
-		chip->to_irq	= ssb_gpio_to_irq;
+#if IS_ENABLED(CONFIG_SSB_EMBEDDED)
+	chip->to_irq		= ssb_gpio_to_irq;
+#endif
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
@@ -422,8 +423,9 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_extif_set_value;
 	chip->direction_input	= ssb_gpio_extif_direction_input;
 	chip->direction_output	= ssb_gpio_extif_direction_output;
-	if (IS_ENABLED(CONFIG_SSB_EMBEDDED))
-		chip->to_irq	= ssb_gpio_to_irq;
+#if IS_ENABLED(CONFIG_SSB_EMBEDDED)
+	chip->to_irq		= ssb_gpio_to_irq;
+#endif
 	chip->ngpio		= 5;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-- 
1.7.10.4
