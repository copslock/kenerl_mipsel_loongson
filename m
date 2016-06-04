Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jun 2016 18:17:18 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33807 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041969AbcFDQRRXHdxZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Jun 2016 18:17:17 +0200
Received: by mail-wm0-f67.google.com with SMTP id n184so6105545wmn.1;
        Sat, 04 Jun 2016 09:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTOq78Adg/DhNwVm8tcRp+XlFEvg0cW3jTV6p44NE3g=;
        b=GI0VAVoartvZkBOW1ONzceSkazKdjw/vt1ZnUaemFqCM/YppQtRx75AwsBj2qMbrbE
         C5J7J4h2q7JfbCNsr01amB8BV6SAfKN8WLh12pg/KxpGONi6zAH63gQGJZ5KDAyAI4va
         cvS/0MuqiqWhgFb9ReQ/YY69ETHbUb2TQ1Y4HflfnE8Jc17qRPyz+uLVSP7V79de+B7q
         5W8sCAryhKS0Pg/gQCe/7d9wOpbS9EDhzDt8m20YnBnYKIZFCL0BMlwzGHx9OUM/tx3p
         r/JIV/jTcFZ2Hd5G/wfRdUnT0/XT4Hc6lMAOPYtbPyUD5kmRN486Sd8Lk8c9DhIL8k11
         K1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTOq78Adg/DhNwVm8tcRp+XlFEvg0cW3jTV6p44NE3g=;
        b=Fz/Qo/+B6tRaL0SviKo+qhJTvSCXLLR67ydgxjZFLxLRKRwRXmnsAp/tp3g70NVJHU
         gWg2a6vPgcb7aRy08XaFdNLSVpWMLeHt8C/Cvw6ShRq5C8gDcyYHBqxZjJSwIRp+ZZvH
         XbhCvm5TC/xxQl3WBuj9Ch4brDRNG58dMcv92I2Ni/EkJW3nVz2eXkhJYNi+iNtMDNPJ
         NFsBHiQDaAZpHJ+hrntLT/hlyPWuVdvsFsuaNgkzvFVWm8SuJZgNVUltOhlke39QGirT
         b2Ww0fEjXdvfdr1cDy+BUYikH0mHF08kXf3dJAHqhygEjEVmGoCEQ/UJIZmiTm9tW4Jd
         e+fA==
X-Gm-Message-State: ALyK8tK67ctF3yDkPpaXkkxoIuwlhG2EThJVOvV4rnH2hGbevjPg6rIt590WfrVARkM5/g==
X-Received: by 10.28.143.82 with SMTP id r79mr4290012wmd.40.1465057032036;
        Sat, 04 Jun 2016 09:17:12 -0700 (PDT)
Received: from localhost.localdomain.localdomain (cpc87881-haye27-2-0-cust204.17-4.cable.virginm.net. [82.46.104.205])
        by smtp.gmail.com with ESMTPSA id s1sm7643047wjf.43.2016.06.04.09.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 09:17:10 -0700 (PDT)
From:   =?UTF-8?q?Hugh=20Sipi=C3=A8re?= <hgsipiere@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org,
        =?UTF-8?q?Hugh=20Sipi=C3=A8re?= <hgsipiere@gmail.com>
Subject: [PATCH] drivers: ssb: Change bare unsigned to unsigned int to suit coding style
Date:   Sat,  4 Jun 2016 17:17:01 +0100
Message-Id: <1465057021-10280-1-git-send-email-hgsipiere@gmail.com>
X-Mailer: git-send-email 2.5.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hgsipiere@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hgsipiere@gmail.com
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

These lines just have unsigned gpio rather than unsigned int gpio.
I changed it to suit the coding style. Michael Buesch told me to
send this to the MIPS tree.

Signed-off-by: Hugh Sipière <hgsipiere@gmail.com>
---
 drivers/ssb/driver_gpio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 180e027..796e220 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -23,7 +23,7 @@
  **************************************************/
 
 #if IS_ENABLED(CONFIG_SSB_EMBEDDED)
-static int ssb_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
+static int ssb_gpio_to_irq(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -38,14 +38,14 @@ static int ssb_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
  * ChipCommon
  **************************************************/
 
-static int ssb_gpio_chipco_get_value(struct gpio_chip *chip, unsigned gpio)
+static int ssb_gpio_chipco_get_value(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
 	return !!ssb_chipco_gpio_in(&bus->chipco, 1 << gpio);
 }
 
-static void ssb_gpio_chipco_set_value(struct gpio_chip *chip, unsigned gpio,
+static void ssb_gpio_chipco_set_value(struct gpio_chip *chip, unsigned int gpio,
 				      int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
@@ -54,7 +54,7 @@ static void ssb_gpio_chipco_set_value(struct gpio_chip *chip, unsigned gpio,
 }
 
 static int ssb_gpio_chipco_direction_input(struct gpio_chip *chip,
-					   unsigned gpio)
+					   unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -63,7 +63,7 @@ static int ssb_gpio_chipco_direction_input(struct gpio_chip *chip,
 }
 
 static int ssb_gpio_chipco_direction_output(struct gpio_chip *chip,
-					    unsigned gpio, int value)
+					    unsigned int gpio, int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -72,7 +72,7 @@ static int ssb_gpio_chipco_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
-static int ssb_gpio_chipco_request(struct gpio_chip *chip, unsigned gpio)
+static int ssb_gpio_chipco_request(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -85,7 +85,7 @@ static int ssb_gpio_chipco_request(struct gpio_chip *chip, unsigned gpio)
 	return 0;
 }
 
-static void ssb_gpio_chipco_free(struct gpio_chip *chip, unsigned gpio)
+static void ssb_gpio_chipco_free(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -256,14 +256,14 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 
 #ifdef CONFIG_SSB_DRIVER_EXTIF
 
-static int ssb_gpio_extif_get_value(struct gpio_chip *chip, unsigned gpio)
+static int ssb_gpio_extif_get_value(struct gpio_chip *chip, unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
 	return !!ssb_extif_gpio_in(&bus->extif, 1 << gpio);
 }
 
-static void ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned gpio,
+static void ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned int gpio,
 				     int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
@@ -272,7 +272,7 @@ static void ssb_gpio_extif_set_value(struct gpio_chip *chip, unsigned gpio,
 }
 
 static int ssb_gpio_extif_direction_input(struct gpio_chip *chip,
-					  unsigned gpio)
+					  unsigned int gpio)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
@@ -281,7 +281,7 @@ static int ssb_gpio_extif_direction_input(struct gpio_chip *chip,
 }
 
 static int ssb_gpio_extif_direction_output(struct gpio_chip *chip,
-					   unsigned gpio, int value)
+					   unsigned int gpio, int value)
 {
 	struct ssb_bus *bus = gpiochip_get_data(chip);
 
-- 
2.5.5
