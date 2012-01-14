Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jan 2012 10:44:33 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:40129 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903565Ab2ANJo0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 Jan 2012 10:44:26 +0100
Received: by eaaa13 with SMTP id a13so501513eaa.36
        for <multiple recipients>; Sat, 14 Jan 2012 01:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=uMh9epn7EGP3HCkoNv1xKq6TJ60k/EEcIOYJV3qxIWY=;
        b=LPAO7Dvkr6vBJxiaFPKyTTyCcyXFCFIx0MNbjU6BhkZcXGWiK3SscOwrdk/DF3DkdO
         tSSlkVPiylyS8QTBys2nHpyEICAWZ1K949fMoOLZGABw+KTrlyBgMSRLEpdIqWGNNPXv
         5O7O+pBldO5GfdmAy9T7sdRt/jo2wDYxuf34o=
Received: by 10.213.108.145 with SMTP id f17mr1219136ebp.1.1326534261369;
        Sat, 14 Jan 2012 01:44:21 -0800 (PST)
Received: from flagship.roarinelk.net (178-191-3-31.adsl.highway.telekom.at. [178.191.3.31])
        by mx.google.com with ESMTPS id x43sm41359382eef.8.2012.01.14.01.44.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Jan 2012 01:44:20 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next] MIPS: Alchemy: update Au1300 inlined GPIO macros
Date:   Sat, 14 Jan 2012 10:44:15 +0100
Message-Id: <1326534255-20073-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.8.3
X-archive-position: 32241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Add a few missing macros for the inlined (!CONFIG_GPIOLIB) GPIO case.
Fixes a build failure in the mmc core due to missing gpio_request_one()
function:
mmc/core/cd-gpio.c: In function 'mmc_cd_gpio_request':
mmc/core/cd-gpio.c:43:2: error: implicit declaration of function 'gpio_request_one' [-Werror=implicit-function-declaration]

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Please fold into patch "MIPS: Alchemy: Au1300-SoC-support" if possible.

 arch/mips/include/asm/mach-au1x00/gpio-au1300.h |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
index 556e1be..fb9975c 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1300.h
@@ -11,6 +11,9 @@
 #include <asm/io.h>
 #include <asm/mach-au1x00/au1000.h>
 
+struct gpio;
+struct gpio_chip;
+
 /* with the current GPIC design, up to 128 GPIOs are possible.
  * The only implementation so far is in the Au1300, which has 75 externally
  * available GPIOs.
@@ -203,7 +206,22 @@ static inline int gpio_request(unsigned int gpio, const char *label)
 	return 0;
 }
 
-static inline void gpio_free(unsigned int gpio)
+static inline int gpio_request_one(unsigned gpio,
+					unsigned long flags, const char *label)
+{
+	return 0;
+}
+
+static inline int gpio_request_array(struct gpio *array, size_t num)
+{
+	return 0;
+}
+
+static inline void gpio_free(unsigned gpio)
+{
+}
+
+static inline void gpio_free_array(struct gpio *array, size_t num)
 {
 }
 
-- 
1.7.8.3
