Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Nov 2014 02:06:51 +0100 (CET)
Received: from mail-pd0-f177.google.com ([209.85.192.177]:50955 "EHLO
        mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012450AbaKBBFDEM384 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Nov 2014 02:05:03 +0100
Received: by mail-pd0-f177.google.com with SMTP id v10so9372805pde.22
        for <multiple recipients>; Sat, 01 Nov 2014 18:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tjPEmFBZBdGRQMyHVqR7Wa//Jjkmh7h5mvBYaufuTYI=;
        b=IFNlCAg38v34G5n4BEhvFN8qIlz3Mw3giX3OLaYnhkXrrvvMe/ad3go0Tm+cyfr6Zr
         0GS7IR/e4WBJ2iDTTeOvM+1b2DTpPaJEUbyQKli4bFKtWhgMfyttM1U1zH4ZchtzMfF2
         EkF5IXopYIkHM/m5rKDY1XtzHiT2xWuo9NBHiS0/kMK2Gl8AdQXbjk7QNMPY0tObyJu9
         +9/YsG6z6ynEF+oNZi+xz6NBRFQo9gqbAE8Efi9fEhIVdoy9nhN1GPDgADOkOkl65NIm
         iyskkRmWu9784vymxmAC2oFi/jX5TnixKB9UnA3a7DvGCeOkE9NveqZYf4zHWqD2mldW
         CQBA==
X-Received: by 10.66.65.137 with SMTP id x9mr34206845pas.0.1414890296993;
        Sat, 01 Nov 2014 18:04:56 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id f7sm13488343pdj.15.2014.11.01.18.04.55
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Nov 2014 18:04:56 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org
Cc:     linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V3 07/14] irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
Date:   Sat,  1 Nov 2014 18:03:54 -0700
Message-Id: <1414890241-9938-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

This can compile for MIPS (or anything else) now.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b21f12f..09c79d1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
 
 config BRCMSTB_L2_IRQ
 	bool
-	depends on ARM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
-- 
2.1.1
