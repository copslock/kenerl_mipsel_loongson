Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:43:03 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41234 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491008Ab1EHImd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:33 +0200
Received: by wyb28 with SMTP id 28so4138962wyb.36
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=TCRo4cPwpnvL/NMiAJn7zK1JcabL5AzxEx7rmSYyG7Y=;
        b=sxkry0xVubAq8uNwA6O1MUvW6t30X60Jp8OGaB1sUxLDXOu5LhWs8Oy3YZxTF5Y28y
         pCZUZKjEmd8F88c1R55p4MFONNY4kfT6mWwy/HBjVY/HF2w6RYBFGu+7IpL3LXKbzDdN
         rFp2mezTw2GaVV5wPRf5cXIh3Gfn3cIXQk4RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Q1umOwqIzO0cqpjDR7h/ARd51y65uM7vnNw/POl8Rma39tAo2W5usQDBrFTBWAoGsZ
         fhMRgZxJuKpjhjdGYjgft42jJjZfMSBgZbNwt/+RpK9Bk4uydxv5U8I3LP/jLOC5tg2m
         MMXDQv+or6AK7YOkVUnpktiiIg/tpD7TqtsqE=
Received: by 10.227.199.82 with SMTP id er18mr5852811wbb.63.1304844147570;
        Sun, 08 May 2011 01:42:27 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:27 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/9] MIPS: Alchemy: update inlinable GPIO API
Date:   Sun,  8 May 2011 10:42:13 +0200
Message-Id: <1304844140-3259-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

This fixes a build failure with gpio_keys and CONFIG_GPIOLIB=n (mtx1):
  CC      drivers/input/keyboard/gpio_keys.o
gpio_keys.c: In function 'gpio_keys_report_event':
gpio_keys.c:325:2: error: implicit declaration of function 'gpio_get_value_cansleep'
gpio_keys.c: In function 'gpio_keys_setup_key':
gpio_keys.c:390:3: error: implicit declaration of function 'gpio_set_debounce'

Also add stubs for the other new functions.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Updated version of a patch I submitted a few times earlier.

 arch/mips/include/asm/mach-au1x00/gpio-au1000.h |   51 +++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 62d2f13..8f8c1c5 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -24,6 +24,7 @@
 
 #define MAKE_IRQ(intc, off)	(AU1000_INTC##intc##_INT_BASE + (off))
 
+struct gpio;
 
 static inline int au1000_gpio1_to_irq(int gpio)
 {
@@ -556,6 +557,16 @@ static inline void gpio_set_value(int gpio, int v)
 	alchemy_gpio_set_value(gpio, v);
 }
 
+static inline int gpio_get_value_cansleep(unsigned gpio)
+{
+	return gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value_cansleep(unsigned gpio, int value)
+{
+	gpio_set_value(gpio, value);
+}
+
 static inline int gpio_is_valid(int gpio)
 {
 	return alchemy_gpio_is_valid(gpio);
@@ -581,10 +592,50 @@ static inline int gpio_request(unsigned gpio, const char *label)
 	return 0;
 }
 
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
 static inline void gpio_free(unsigned gpio)
 {
 }
 
+static inline void gpio_free_array(struct gpio *array, size_t num)
+{
+}
+
+static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_export(unsigned gpio, bool direction_may_change)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_export_link(struct device *dev, const char *name,
+				   unsigned gpio)
+{
+	return -ENOSYS;
+}
+
+static inline int gpio_sysfs_set_active_low(unsigned gpio, int value)
+{
+	return -ENOSYS;
+}
+
+static inline void gpio_unexport(unsigned gpio)
+{
+}
+
 #endif	/* !CONFIG_ALCHEMY_GPIO_INDIRECT */
 
 
-- 
1.7.5.rc3
