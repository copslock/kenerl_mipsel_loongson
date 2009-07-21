Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 12:37:57 +0200 (CEST)
Received: from mail-ew0-f215.google.com ([209.85.219.215]:36561 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493044AbZGUKht (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 12:37:49 +0200
Received: by ewy11 with SMTP id 11so3068222ewy.0
        for <multiple recipients>; Tue, 21 Jul 2009 03:37:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O6m2XvcpZhTTR/eJosKRF7I6KITfUB/O7WgDGGbfX68=;
        b=ND1vwzybV6IMYAh83gxC3ilHI9+w2ApsIk3tdMG8fEksyXR5dbqX4RlqEbbCzezEV+
         KmfS/uNYYM5ParueVytaKcbOnYlZfzuo4vLM09nVyBcNzVfkZ+of7JvMVYF71X1Ew0Np
         ZhH2M/n1/4WTeu5Ov0ZoHAhyqv3168nmc4K4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=L2dzYJjyPIjw0Jlz306Pvpm8aJG54FfeOjRLudO14KQSACr0pqLXVxNAGIWnmGHgQ0
         T9W2cVGWn+eE89BrvthWijID2eM3B5mgeqYVZOFBQGxWTzKBsOZDPvV+u3qHStUqPgpc
         1AP9/OvfD9l5Ee81JG3sgqyKxA8yZUoKy0SiQ=
Received: by 10.211.196.3 with SMTP id y3mr6588655ebp.15.1248172663944;
        Tue, 21 Jul 2009 03:37:43 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 5sm1895380eyf.17.2009.07.21.03.37.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Jul 2009 03:37:43 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Tue, 21 Jul 2009 12:37:37 +0200
Subject: [PATCH 1/2] ar7: fix build failures when CONFIG_SERIAL_8250 is not enabled
MIME-Version: 1.0
X-UID:	720
X-Length: 2094
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907211237.39264.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes the following build failure when CONFIG_SERIAL_8250
is not enabled in the kernel configuration:
arch/mips/ar7/built-in.o: In function `ar7_register_devices':
platform.c:(.init.text+0x61c): undefined reference to `early_serial_setup'
platform.c:(.init.text+0x61c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'
platform.c:(.init.text+0x68c): undefined reference to `early_serial_setup'
platform.c:(.init.text+0x68c): relocation truncated to fit: R_MIPS_26 against `early_serial_setup'

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/ar7/platform.c b/arch/mips/ar7/platform.c
index cbe4fa4..d0624d8 100644
--- a/arch/mips/ar7/platform.c
+++ b/arch/mips/ar7/platform.c
@@ -494,8 +494,9 @@ static void __init detect_leds(void)
 static int __init ar7_register_devices(void)
 {
 	int res;
-	static struct uart_port uart_port[2];
 	u16 chip_id;
+#ifdef CONFIG_SERIAL_8250
+	static struct uart_port uart_port[2];
 
 	memset(uart_port, 0, sizeof(struct uart_port) * 2);
 
@@ -526,7 +527,7 @@ static int __init ar7_register_devices(void)
 		if (res)
 			return res;
 	}
-
+#endif /* CONFIG_SERIAL_8250 */
 	res = platform_device_register(&physmap_flash);
 	if (res)
 		return res;
