Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Aug 2009 23:51:33 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.146]:22463 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493079AbZHAVv0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 1 Aug 2009 23:51:26 +0200
Received: by ey-out-1920.google.com with SMTP id 13so650314eye.54
        for <multiple recipients>; Sat, 01 Aug 2009 14:51:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-disposition:message-id
         :content-type:content-transfer-encoding;
        bh=z2UsN6GbeVUlW9gocuxZShCBF31gj8f96oapDZWDDe0=;
        b=UMRJ4oGaXu2Momv3SJrbZyi+/JGS90uDutLwvYeuqLT2C/+eOHLyUN3MIJrhIrnufY
         Rhdl5uqv5alAEPNKaV43G5zpddH2cfYwI8eF7Ld/UmnNYobGQS2Nw5y2QSdnqCA2dsMC
         a8uHenahP8MbxvcXLGdIknvtgi/vq0vXSto8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-disposition:message-id:content-type
         :content-transfer-encoding;
        b=mf4mE7SkN9VyLsmUMmwt6U8/+PRDLJ50GcRzVv3vyKYLV/BwIDwzjxaHwvZn25U2VD
         BgI6qDloKgGARCbj7/+QCyebj0fxr39FERUvH73SecX+7VwBTuC3SkW4JwGFzkxEeoN6
         CBgUK4ieCqnDmjOwY/6YIJVrmQ7x4LcEhbJx8=
Received: by 10.210.129.3 with SMTP id b3mr2899251ebd.34.1249163486478;
        Sat, 01 Aug 2009 14:51:26 -0700 (PDT)
Received: from tunnel.evry (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 28sm3891390eye.14.2009.08.01.14.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Aug 2009 14:51:25 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 1 Aug 2009 23:51:20 +0200
Subject: [PATCH] mtx-1: request button GPIO before setting its direction
MIME-Version: 1.0
X-UID:	1099
X-Length: 2416
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Content-Disposition: inline
Message-Id: <200908012351.21059.florian@openwrt.org>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following warning at boot time:
WARNING: at drivers/gpio/gpiolib.c:83 0x8021d5e0()
autorequest GPIO-207
Modules linked in:
Call Trace:[<8011e0ec>] 0x8011e0ec
[<80110a28>] 0x80110a28
[<80110a28>] 0x80110a28
[..snip..]

The current code does not request the GPIO and attempts
to set its direction, which is a violation of the GPIO API.
This patch also unhardcode the GPIO we request and use
the one we defined in the button driver.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/mtx-1/platform.c b/arch/mips/alchemy/mtx-1/platform.c
index 8b5914d..e30e42a 100644
--- a/arch/mips/alchemy/mtx-1/platform.c
+++ b/arch/mips/alchemy/mtx-1/platform.c
@@ -1,7 +1,7 @@
 /*
  * MTX-1 platform devices registration
  *
- * Copyright (C) 2007, Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2007-2009, Florian Fainelli <florian@openwrt.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -142,7 +142,17 @@ static struct __initdata platform_device * mtx1_devs[] = {
 
 static int __init mtx1_register_devices(void)
 {
-	gpio_direction_input(207);
+	int rc;
+
+	rc = gpio_request(mtx1_gpio_button[0].gpio,
+					mtx1_gpio_button[0].desc);
+	if (rc < 0) {
+		printk(KERN_INFO "mtx1: failed to request %d\n",
+					mtx1_gpio_button[0].gpio);
+		goto out;
+	}
+	gpio_direction_input(mtx1_gpio_button[0].gpio);
+out:
 	return platform_add_devices(mtx1_devs, ARRAY_SIZE(mtx1_devs));
 }
 
