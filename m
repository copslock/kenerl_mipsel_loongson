Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Dec 2015 14:39:33 +0100 (CET)
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35947 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013547AbbLINjUrilv9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Dec 2015 14:39:20 +0100
Received: by lfs39 with SMTP id 39so34582663lfs.3
        for <linux-mips@linux-mips.org>; Wed, 09 Dec 2015 05:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TmM1qu+NHLYWJ5rfma6quL7s2FUxzbq+MdINQI67HO0=;
        b=saQ5PHoB9FtX2DvTFOPMeN9hLfSq35BcTfL9una2REVet4OCPu+L/XBPv0ze8xf9fn
         gJmYk/NmZvYU4RVZV7PpRy3syFctgxifkx7xL8UrWlXa6cESQckbdDy+iOc4eG6ltngH
         GIELljT9Px9wLJfOu9VJ72VkrQmJB/jwFMS3k/+Vg1LAzvK66Sxdflh2qakRfYMGzG1s
         shQwAAny6c+G4TcG+6psxMnzYcttUDlC/V8Llx3lQsZmWp7v6Qx51ODoN3zZBVWeutfs
         bNT2lwADD5h9UvWu0AfjHqskjzLtqNX8+GyWxo7LHlMpgoxjV/zOHks/8r098pvjFDk6
         8zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TmM1qu+NHLYWJ5rfma6quL7s2FUxzbq+MdINQI67HO0=;
        b=fsBgpJW2mP6AamNzxB5pmqZQEZ8Xa7kYbULV3L0FGAwH53AHad96CjAplUCBUxlJxl
         s+TM4MLjOj7GrJuudDQ5AjtoKtpX5DJ8Qe/y8zjcfXAeSc7foL9qOWuyMqRLi5i9ZwBS
         VsclLXztsnMqS5g88V1wUAMFgN/r9ydXqm2HpjYoqd0OI3TJiaMYCH+k6Q3TDtSd5ok0
         VVAco7BC7LP0q/DHbS8cdiVhajFchjIojumfUE8C46QL9CTJTvrVTNkz1ZHGl8qyB12N
         KtdYHVCcqEvkEuVDrcnQResz2kSONnKSGFJO4W4GGrXH4Kr965fOo4GNFN2VDDsBIUFH
         UUug==
X-Gm-Message-State: ALoCoQkFMeQXSN6wACw1HfJfkAObuBtAo52hjgh2lHVcEmJr/CVyuwTgf9T2KluKED8iutyEx60UhQhoGTmPyXkAKOAquXHtJg==
X-Received: by 10.25.152.133 with SMTP id a127mr2278402lfe.152.1449668355281;
        Wed, 09 Dec 2015 05:39:15 -0800 (PST)
Received: from localhost.localdomain ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t82sm1446369lfe.14.2015.12.09.05.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2015 05:39:14 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Michael Welling <mwelling@ieee.org>,
        Markus Pargmann <mpa@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 136/182] MIPS: ar7: use gpiochip data pointer
Date:   Wed,  9 Dec 2015 14:39:11 +0100
Message-Id: <1449668351-4493-1-git-send-email-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.4.3
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

This makes the driver use the data pointer added to the gpio_chip
to store a pointer to the state container instead of relying on
container_of().

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Alban Bedel <albeu@free.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Ralf: please ACK this so I can take it through the GPIO tree.
BTW: would be nice if the MIPS GPIO drivers could move down
to drivers/gpio in the long run.
---
 arch/mips/ar7/gpio.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index f4930456eb8e..0b4485697d10 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -33,8 +33,7 @@ struct ar7_gpio_chip {
 
 static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_in = gpch->regs + AR7_GPIO_INPUT;
 
 	return readl(gpio_in) & (1 << gpio);
@@ -42,8 +41,7 @@ static int ar7_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 
 static int titan_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_in0 = gpch->regs + TITAN_GPIO_INPUT_0;
 	void __iomem *gpio_in1 = gpch->regs + TITAN_GPIO_INPUT_1;
 
@@ -53,8 +51,7 @@ static int titan_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
 static void ar7_gpio_set_value(struct gpio_chip *chip,
 				unsigned gpio, int value)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_out = gpch->regs + AR7_GPIO_OUTPUT;
 	unsigned tmp;
 
@@ -67,8 +64,7 @@ static void ar7_gpio_set_value(struct gpio_chip *chip,
 static void titan_gpio_set_value(struct gpio_chip *chip,
 				unsigned gpio, int value)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_out0 = gpch->regs + TITAN_GPIO_OUTPUT_0;
 	void __iomem *gpio_out1 = gpch->regs + TITAN_GPIO_OUTPUT_1;
 	unsigned tmp;
@@ -81,8 +77,7 @@ static void titan_gpio_set_value(struct gpio_chip *chip,
 
 static int ar7_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_dir = gpch->regs + AR7_GPIO_DIR;
 
 	writel(readl(gpio_dir) | (1 << gpio), gpio_dir);
@@ -92,8 +87,7 @@ static int ar7_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 
 static int titan_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_dir0 = gpch->regs + TITAN_GPIO_DIR_0;
 	void __iomem *gpio_dir1 = gpch->regs + TITAN_GPIO_DIR_1;
 
@@ -108,8 +102,7 @@ static int titan_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 static int ar7_gpio_direction_output(struct gpio_chip *chip,
 					unsigned gpio, int value)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_dir = gpch->regs + AR7_GPIO_DIR;
 
 	ar7_gpio_set_value(chip, gpio, value);
@@ -121,8 +114,7 @@ static int ar7_gpio_direction_output(struct gpio_chip *chip,
 static int titan_gpio_direction_output(struct gpio_chip *chip,
 					unsigned gpio, int value)
 {
-	struct ar7_gpio_chip *gpch =
-				container_of(chip, struct ar7_gpio_chip, chip);
+	struct ar7_gpio_chip *gpch = gpiochip_get_data(chip);
 	void __iomem *gpio_dir0 = gpch->regs + TITAN_GPIO_DIR_0;
 	void __iomem *gpio_dir1 = gpch->regs + TITAN_GPIO_DIR_1;
 
@@ -335,7 +327,7 @@ int __init ar7_gpio_init(void)
 		return -ENOMEM;
 	}
 
-	ret = gpiochip_add(&gpch->chip);
+	ret = gpiochip_add_data(&gpch->chip, gpch);
 	if (ret) {
 		printk(KERN_ERR "%s: failed to add gpiochip\n",
 					gpch->chip.label);
-- 
2.4.3
