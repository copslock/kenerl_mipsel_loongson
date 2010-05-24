Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 10:38:04 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:56909 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492015Ab0EXIhh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 10:37:37 +0200
Received: by pvg2 with SMTP id 2so212289pvg.36
        for <multiple recipients>; Mon, 24 May 2010 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=8+AeqzQqarO1h4RA3AABrbZg4smy3gQWIQVeN0zlK+0=;
        b=f3BoFiwVypyyJYa5ZIv8uUu6IupWVSc5qq+YpVsHwYLuaB+SB7aZ7gORS1a+nywtqH
         Yq6a9YKAzeJrgyr6as9MF61B50mCz+liCDMdQJMnK7SedxPSYHiXSCNWJrxZZ9DnLSBo
         SwvpKpeI6X7zZlIvjmaNyrA8Rl1cPkR5K3MgY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=KWrS3WPdCMEu7L13TG58AA7cfkAbiAYuPaox93Tuy5wbInW1SPtqmpbQnQeIlolMSj
         wpjeaYwekc57QLbC3iitPJvicw9k96W+pFDN3TpTbZcSXi8meGrd6ZD3XykapyNm+s1o
         54kmPsPZWWd53v8Ao6AeZogv7qlI8kye8lPd8=
Received: by 10.115.84.8 with SMTP id m8mr4595733wal.9.1274690251017;
        Mon, 24 May 2010 01:37:31 -0700 (PDT)
Received: from stratos (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id f11sm36567662wai.11.2010.05.24.01.37.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 01:37:30 -0700 (PDT)
Date:   Mon, 24 May 2010 17:36:24 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: MIPS: AR7/BCM63xx: fix gpio_to_irq() return value
Message-Id: <20100524173624.2d3ffc3d.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

The return value of gpio_to_irq() is not a pointer.
It's integer.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/include/asm/mach-ar7/gpio.h     |    2 +-
 arch/mips/include/asm/mach-bcm63xx/gpio.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ar7/gpio.h b/arch/mips/include/asm/mach-ar7/gpio.h
index 73f9b16..abc317c 100644
--- a/arch/mips/include/asm/mach-ar7/gpio.h
+++ b/arch/mips/include/asm/mach-ar7/gpio.h
@@ -24,7 +24,7 @@
 #define AR7_GPIO_MAX 32
 #define NR_BUILTIN_GPIO AR7_GPIO_MAX
 
-#define gpio_to_irq(gpio)	NULL
+#define gpio_to_irq(gpio)	-1
 
 #define gpio_get_value __gpio_get_value
 #define gpio_set_value __gpio_set_value
diff --git a/arch/mips/include/asm/mach-bcm63xx/gpio.h b/arch/mips/include/asm/mach-bcm63xx/gpio.h
index 7cda8c0..1eb534d 100644
--- a/arch/mips/include/asm/mach-bcm63xx/gpio.h
+++ b/arch/mips/include/asm/mach-bcm63xx/gpio.h
@@ -3,7 +3,7 @@
 
 #include <bcm63xx_gpio.h>
 
-#define gpio_to_irq(gpio)	NULL
+#define gpio_to_irq(gpio)	-1
 
 #define gpio_get_value __gpio_get_value
 #define gpio_set_value __gpio_set_value
-- 
1.7.1
