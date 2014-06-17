Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jun 2014 17:29:54 +0200 (CEST)
Received: from mail-wg0-f52.google.com ([74.125.82.52]:44352 "EHLO
        mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861641AbaFQOhaaU2u0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jun 2014 16:37:30 +0200
Received: by mail-wg0-f52.google.com with SMTP id b13so7112803wgh.11
        for <multiple recipients>; Tue, 17 Jun 2014 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=dr7rW/VZSdCnXZvCKZ3PjoELV1R8uUX7nseQ2nJZNYo=;
        b=IMEz2jlcOshfkwb1uk9CYbOFyZpsT+HdsWxZO8JtktjLU1zQcsZaYYehXutsnPVM2H
         2LN9QHWHlnvY9fMdLl9hGsSswSNABBEfu5huE5k4zHxuJ8NXBfNplOgVcyvLr4r0oSrT
         3a1U72T1ClcEidoIpzmZ7I9p28bBxW5kfJ/bb+q86IFQpwi0JduUH2s41muweJhMpy4w
         Z2meBqViqnOhCIGUMtmAHGcAv1kQxbev2SuIFyeypEnRZLnT07+iBKLnkHTJsNUSkKC2
         nZFtqQFfRhkfVxF86Aca3DZxYDGV/n0hgaMWjiozpuxdsY3KcE2wXGGt4+/0mkzk+cHF
         OXmA==
X-Received: by 10.194.238.134 with SMTP id vk6mr4857989wjc.93.1403015839862;
        Tue, 17 Jun 2014 07:37:19 -0700 (PDT)
Received: from linux-tdhb.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by mx.google.com with ESMTPSA id v8sm41510956eep.13.2014.06.17.07.37.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jun 2014 07:37:19 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH 1/2] MIPS: BCM47XX: Move shared symbols to the config BCM47XX
Date:   Tue, 17 Jun 2014 16:36:50 +0200
Message-Id: <1403015811-31537-1-git-send-email-zajec5@gmail.com>
X-Mailer: git-send-email 1.8.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 arch/mips/Kconfig         | 2 ++
 arch/mips/bcm47xx/Kconfig | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7a469ac..28a460a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -130,6 +130,8 @@ config BCM47XX
 	select SYS_SUPPORTS_MIPS16
 	select SYS_HAS_EARLY_PRINTK
 	select USE_GENERIC_EARLY_PRINTK_8250
+	select GPIOLIB
+	select LEDS_GPIO_REGISTER
 	help
 	 Support for BCM47XX based boards
 
diff --git a/arch/mips/bcm47xx/Kconfig b/arch/mips/bcm47xx/Kconfig
index 09cb6f7..0375163 100644
--- a/arch/mips/bcm47xx/Kconfig
+++ b/arch/mips/bcm47xx/Kconfig
@@ -11,8 +11,6 @@ config BCM47XX_SSB
 	select SSB_DRIVER_PCICORE if PCI
 	select SSB_PCICORE_HOSTMODE if PCI
 	select SSB_DRIVER_GPIO
-	select GPIOLIB
-	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for old Broadcom BCM47xx boards with Sonics Silicon Backplane support.
@@ -29,8 +27,6 @@ config BCM47XX_BCMA
 	select BCMA_HOST_PCI if PCI
 	select BCMA_DRIVER_PCI_HOSTMODE if PCI
 	select BCMA_DRIVER_GPIO
-	select GPIOLIB
-	select LEDS_GPIO_REGISTER
 	default y
 	help
 	 Add support for new Broadcom BCM47xx boards with Broadcom specific Advanced Microcontroller Bus.
-- 
1.8.4.5
