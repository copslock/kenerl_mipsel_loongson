Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 May 2010 10:39:48 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:65286 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491837Ab0EDIjl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 May 2010 10:39:41 +0200
Received: by wwb39 with SMTP id 39so368395wwb.36
        for <multiple recipients>; Tue, 04 May 2010 01:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:message-id;
        bh=rbjRXH8tZ58nbX53qOfJTQnl2FUfIRwITprd9yxF9kY=;
        b=VaOja2U8OPOyH1wOb7nEDFX5QXFR4JBhz0xXmSHX05iSrJU6Li8uLYlFaeWSiCLXb3
         bCY2taP3DfjqIvKXVaY6GN0nhqRmzgJMjhUkIoxt8hLV7hRco7ywVA0dvs+2oqG3F2iQ
         y0zrSKDRzhKOABuT1HQeOAv0E/AwXCh13MX3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:message-id;
        b=tXoo2ixt1LeZwbbTqo+8ZAE12Nq1fp+gsRFfkmXvvo8YQqAPYYEYGw7VBYl5c9wu2d
         oxGf5UvucL/WAy41zbB9jeNTqdXmIDHKXs9f4YOPpKXfw5YhawV5TOc/3Prt9KFnuGyI
         1sPq3U9j3JvV8s9Ur0WdxL0KY2m6r5z6fHbiE=
Received: by 10.216.89.12 with SMTP id b12mr6793183wef.93.1272962376088;
        Tue, 04 May 2010 01:39:36 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id v59sm1939261wec.3.2010.05.04.01.39.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 01:39:35 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 4 May 2010 10:38:57 +0200
Subject: [PATCH -queue] BCM63xx: avoid namespace clash on GPIO_DIR_{IN,OUT}
MIME-Version: 1.0
X-UID:  59
X-Length: 2594
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201005041038.57783.ffainelli@freebox.fr>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This is too generic a name, so prefix it with BCM63XX_ to avoid potential
namespace clashes when including <asm/gpio.h>.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 315bc7f..f560fe7 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -91,7 +91,7 @@ static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
 
 	spin_lock_irqsave(&bcm63xx_gpio_lock, flags);
 	tmp = bcm_gpio_readl(reg);
-	if (dir == GPIO_DIR_IN)
+	if (dir == BCM63XX_GPIO_DIR_IN)
 		tmp &= ~mask;
 	else
 		tmp |= mask;
@@ -103,14 +103,14 @@ static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
 
 static int bcm63xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 {
-	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_IN);
+	return bcm63xx_gpio_set_direction(chip, gpio, BCM63XX_GPIO_DIR_IN);
 }
 
 static int bcm63xx_gpio_direction_output(struct gpio_chip *chip,
 					 unsigned gpio, int value)
 {
 	bcm63xx_gpio_set(chip, gpio, value);
-	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_OUT);
+	return bcm63xx_gpio_set_direction(chip, gpio, BCM63XX_GPIO_DIR_OUT);
 }
 
 
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
index 43d4da0..3999ec0 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_gpio.h
@@ -20,7 +20,7 @@ static inline unsigned long bcm63xx_gpio_count(void)
 	}
 }
 
-#define GPIO_DIR_OUT	0x0
-#define GPIO_DIR_IN	0x1
+#define BCM63XX_GPIO_DIR_OUT	0x0
+#define BCM63XX_GPIO_DIR_IN	0x1
 
 #endif /* !BCM63XX_GPIO_H */
