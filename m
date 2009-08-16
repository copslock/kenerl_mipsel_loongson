Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Aug 2009 00:29:10 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:59861 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493148AbZHPW2l (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Aug 2009 00:28:41 +0200
Received: by ewy12 with SMTP id 12so2258545ewy.0
        for <multiple recipients>; Sun, 16 Aug 2009 15:28:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:date:subject
         :mime-version:x-uid:x-length:to:cc:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9ymzJ8vMW8QIOT9DCBg5i4qS14k6TMsy8kXQnxXpP2M=;
        b=JfXZTwR/AP5JRoMtS0v2xWF/j1atmSJeOAXWOKuQi7xgrTBTUyjbTX+pF/fSuooRdc
         21RxSuruOKwmqTZACYerSzHjjNe3/qj52lvRrzgBM0dZyBYjfcO5Yzekpw3fh45ibo6S
         8pi5l+RjbpkQQI7YakeUX4DeMR1ImGueDmIDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:date:subject:mime-version:x-uid:x-length:to:cc
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=PW7jfb3j1Dvw6Ce99QJ25+wOVQilW6hNfKLPQCpI7OI9YQtm8/2/PzEVVP2+0vB8ha
         dzPWlfIG8J90eshx1NZGa877+Z/p0L1hCYxo2lFniDDh2Fzoc68ERvO9h11yYHtEB5dG
         Pj/jZsviL4UrJj9zqe7wdajdYsDIuEzEjenMA=
Received: by 10.210.136.15 with SMTP id j15mr2373260ebd.68.1250461715565;
        Sun, 16 Aug 2009 15:28:35 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id 5sm8224107eyh.56.2009.08.16.15.28.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 15:28:34 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Mon, 17 Aug 2009 00:28:30 +0200
Subject: [PATCH 2/2] mtx-1: fix build failures when PCI is disabled
MIME-Version: 1.0
X-UID:	1224
X-Length: 1500
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200908170028.32023.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

When PCI is disabled the board_pci_idsel symbol cannot
be resolved since it is declared in arch/mips/pci/pci-au1000.c
which is not compiled.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index cc32c69..c803732 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -85,7 +85,9 @@ void __init board_setup(void)
 	alchemy_gpio_direction_output(211, 1);	/* green on */
 	alchemy_gpio_direction_output(212, 0);	/* red off */
 
+#ifdef CONFIG_PCI
 	board_pci_idsel = mtx1_pci_idsel;
+#endif
 
 	printk(KERN_INFO "4G Systems MTX-1 Board\n");
 }
