Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2009 00:28:45 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:50342 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492954AbZHPW2i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2009 00:28:38 +0200
Received: by ewy12 with SMTP id 12so2258487ewy.0
        for <multiple recipients>; Sun, 16 Aug 2009 15:28:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BkBGvb0+pg0vVjQJw5BH6bokqCEP31dS2q5+Ck2d6O8=;
        b=X/wq7I7Ca3tjveaEWPdm7aRgr9Gl3hRwlCWw1SIG6SXU7Hm5ltl4ob3wFEmVB/Z0hp
         LkWLvV2JUlpAZuQGr2aLL7KUMtSW43idzG+tcA2e4Ey2Rwdk5j6wSa0b7lTKE1RgrwH4
         7je/fTr3YPnANhhYZTcFeYUbDRVM0Y0xHaVXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=xjWBrDuAGDlADPzC4w5FuP5E2U7dBhWs5gYed2vrZv0hk3aUc4iIBHumzvnOBAbWSi
         YffrRbkldOo//5uPyLcRZHygvDcBrI/WnWwMD31lxhQSURUNd2YMpsVqN/yS9pphlES2
         2bkcpBgSZtWEQf8+gZOMoI2KG5kGloM09NNp0=
Received: by 10.211.152.7 with SMTP id e7mr438511ebo.3.1250461711087;
        Sun, 16 Aug 2009 15:28:31 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 10sm6410197eyz.51.2009.08.16.15.28.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 15:28:30 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 17 Aug 2009 00:28:24 +0200
Subject: [PATCH 1/2] au1000: fix build failure for db1x00 configured for Au1100 SoC
MIME-Version: 1.0
X-UID:	1223
X-Length: 2089
To:	ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908170028.27210.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch should apply to both -master and -queue. Thanks !
--
From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 1/2] au1000: fix build failure for db1x00 configured for Au1100 SoC

This patch fixes the following warning, which becomes an error due to
-Werror to be turned on:
  CC      arch/mips/alchemy/common/gpiolib-au1000.o
cc1: warnings being treated as errors
arch/mips/alchemy/common/gpiolib-au1000.c: In function 'au1100_gpio2_to_irq':
/home/florian/dev/kernel/linux-queue/arch/mips/include/asm/mach-au1x00/gpio-au1000.h:107: warning: control reaches end of non-void function
 
Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
index 127d4ed..4d54d40 100644
--- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
@@ -104,6 +104,8 @@ static inline int au1100_gpio2_to_irq(int gpio)
 
 	if ((gpio >= 8) && (gpio <= 15))
 		return MAKE_IRQ(0, 29);		/* shared GPIO208_215 */
+
+	return -ENXIO;
 }
 
 #ifdef CONFIG_SOC_AU1100
