Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2010 23:48:14 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:44301 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491155Ab0JaWsG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 31 Oct 2010 23:48:06 +0100
Received: by wwb39 with SMTP id 39so4838687wwb.24
        for <multiple recipients>; Sun, 31 Oct 2010 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=fjFvypjGlzWMuoRDt9MCoyOYjvVjnmOPz1NBIDFKOdI=;
        b=b0xJ/V+MIGKbEjFG8G8whg7wbRV5jfzK+c7L3eP4INYTgl+wwzO+RMNW3CrH7z+70K
         xzfDTjfUxcAr6NQbnQl6OPlOQ+4eD3mhvomiCr00ePrX+SYKHSMH2wyMc8WYMIOr12JT
         Nz8g6Q07SwqXWhXVuBmBLWUjel8vBq2OaHd3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=dblAtK5GXBzacPSptLHtb+1kCmnwqipJDBhnpY532pjgETwKMqoMzUEcfCToRTlalX
         Zt+kd8KZXI1GD1CQQWkX1Fxld9rrnxWAe0Ch2Ecl8coQOv4NNWtocyyIu6Jlkja64sR1
         JE0YzM4Zgbz5hfSrDZ7uipkgdcDy3S3NROXsE=
Received: by 10.216.231.82 with SMTP id k60mr8256194weq.64.1288565280518;
        Sun, 31 Oct 2010 15:48:00 -0700 (PDT)
Received: from localhost.localdomain (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id x59sm3405068weq.38.2010.10.31.15.47.58
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 15:47:59 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] AR7: fix double ar7_gpio_init declaration
Date:   Sun, 31 Oct 2010 23:49:57 +0100
Message-Id: <1288565398-30300-1-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
Return-Path: <>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <florian@openwrt.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>

diff --git a/arch/mips/include/asm/mach-ar7/ar7.h b/arch/mips/include/asm/mach-ar7/ar7.h
index 7919d76..31c7ff5 100644
--- a/arch/mips/include/asm/mach-ar7/ar7.h
+++ b/arch/mips/include/asm/mach-ar7/ar7.h
@@ -202,6 +202,4 @@ static inline void ar7_device_off(u32 bit)
 
 int __init ar7_gpio_init(void);
 
-int __init ar7_gpio_init(void);
-
 #endif /* __AR7_H__ */
-- 
1.7.2.3
