Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Aug 2010 17:08:03 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:37816 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab0H2PHh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Aug 2010 17:07:37 +0200
Received: by mail-wy0-f177.google.com with SMTP id 38so4594674wyb.36
        for <multiple recipients>; Sun, 29 Aug 2010 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:reply-to:content-type
         :content-transfer-encoding:message-id;
        bh=63EI7Sx7MqbPUkLEwwwpbRsgfxy25yvN+PHajAYTzrc=;
        b=Zob0lsECBPqlyokd1Qf9p4iAhBKDyp7ATjjZGXVL+NUURpsthq7RONmyFLvSGTtohu
         75WyIcgcKcygtN5vfZYRBBun6rJ0BDY63iMKxHAKLVICezlwX+YOTdw6QDC4miFtZeqj
         PDaE4/+Py7flGCnMJZqToTa5HwRzEFRzuF+P0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:reply-to
         :content-type:content-transfer-encoding:message-id;
        b=qWZEIVNEBAG9/C7DjXud0yd/yxk1GDI1m1ZWPWppaAy912rB4XXfo8pVrmP6wLnale
         i1+DZZHWWd3H4vwK1r2y86jQiL4cug8rxSQjSnVcsieSLW6Sfsi/gHX44tPOg9ChsFyq
         SQ/vBf0q2oOxaJBhrlF4glwCZFTMbvcoj9zi0=
Received: by 10.216.159.131 with SMTP id s3mr3641133wek.99.1283094457719;
        Sun, 29 Aug 2010 08:07:37 -0700 (PDT)
Received: from lenovo.localnet (129.199.66-86.rev.gaoland.net [86.66.199.129])
        by mx.google.com with ESMTPS id w14sm3823394weq.33.2010.08.29.08.07.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 08:07:37 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Date:   Sun, 29 Aug 2010 17:08:41 +0200
Subject: [PATCH 1/2] AR7: initialize GPIO earlier
MIME-Version: 1.0
X-UID:  185
X-Length: 2250
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Reply-To: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201008291708.42249.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

In order to detect the Titan variant, we must initialize GPIOs earlier since
detection relies on some GPIO values to be set.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
index c32fbb5..f848342 100644
--- a/arch/mips/ar7/gpio.c
+++ b/arch/mips/ar7/gpio.c
@@ -107,7 +107,7 @@ int ar7_gpio_disable(unsigned gpio)
 }
 EXPORT_SYMBOL(ar7_gpio_disable);
 
-static int __init ar7_gpio_init(void)
+int __init ar7_gpio_init(void)
 {
 	int ret;
 
@@ -128,4 +128,3 @@ static int __init ar7_gpio_init(void)
 				ar7_gpio_chip.chip.ngpio);
 	return ret;
 }
-arch_initcall(ar7_gpio_init);
diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 5238579..23818d2 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -246,6 +246,8 @@ void __init prom_init(void)
 	ar7_init_cmdline(fw_arg0, (char **)fw_arg1);
 	ar7_init_env((struct env_var *)fw_arg2);
 	console_config();
+
+	ar7_gpio_init();
 }
 
 #define PORT(offset) (KSEG1ADDR(AR7_REGS_UART0 + (offset * 4)))
diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-
ar7/ar7.h
index 483ffea..ddb413e 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -161,4 +161,6 @@ static inline void ar7_device_off(u32 bit)
 	msleep(20);
 }
 
+int __init ar7_gpio_init(void);
+
 #endif /* __AR7_H__ */
