Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 20:27:54 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.149]:45996 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493309AbZHaS1r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 20:27:47 +0200
Received: by ey-out-1920.google.com with SMTP id 13so845013eye.52
        for <multiple recipients>; Mon, 31 Aug 2009 11:27:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uM6j4q1c8HKu6FD95twFax8wajIcG5CHBs1K+BFNVBw=;
        b=DLogbVCkqQAcZDWHEI4ds8pxHawuY2HXosEo8YmSwe0s+1a7htrgKaefuLxGO8QEhe
         s/JCdI1ZZUnA2aAzOSY9QCX0IUbO9nAvkZa8N7KGN4HM2DsDF6QJ3SDsh+UQVpGLENkm
         j0e6yXMyPOrAS5ZQ7RWmG6bquBtNwOCjnGii0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=gbqwQ5fO620LnmQSP131BT1KMiqQoWMgkSbLby1opBgE3m6CkVuLpArYGpLNsulFUx
         BCLmGIrS1GBaFPfPPJ613d8DwuUSlspNgADoVbyBrBM7bwo2ez9E4J5vsfmfGcWZa/Je
         CqNvdB24Pf6DDzWiIqiPemMeJHgZ7iX83SZzQ=
Received: by 10.210.6.8 with SMTP id 8mr5829278ebf.47.1251743264888;
        Mon, 31 Aug 2009 11:27:44 -0700 (PDT)
Received: from lenovo.localnet (39.87.196-77.rev.gaoland.net [77.196.87.39])
        by mx.google.com with ESMTPS id 5sm39539eyh.2.2009.08.31.11.27.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 11:27:44 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 31 Aug 2009 20:27:39 +0200
Subject: [PATCH 1/2] bcm63xx: fix soft-reset lockup on BCM6345
MIME-Version: 1.0
X-UID:	1318
X-Length: 1573
To:	ralf Baechle <ralf@linux-mips.org>,
	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908312027.41396.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23969
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch fixes a lockup on BCM6345 where setting the
PLL soft reset bit will also lock the other blocks including UART.
Instead of setting only the PLL soft reset bit in the
software reset register, set this bit but do not touch
the others.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index b18a0ca..d005659 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -75,7 +75,9 @@ void bcm63xx_machine_reboot(void)
 		bcm6348_a1_reboot();
 
 	printk(KERN_INFO "triggering watchdog soft-reset...\n");
-	bcm_perf_writel(SYS_PLL_SOFT_RESET, PERF_SYS_PLL_CTL_REG);
+	reg = bcm_perf_readl(PERF_SYS_PLL_CTL_REG);
+	reg |= SYS_PLL_SOFT_RESET;
+	bcm_perf_writel(reg, PERF_SYS_PLL_CTL_REG);
 	while (1)
 		;
 }
