Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jan 2016 19:57:14 +0100 (CET)
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35431 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010090AbcAFS4UR1ZaQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Jan 2016 19:56:20 +0100
Received: by mail-pf0-f172.google.com with SMTP id 78so246505977pfw.2
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sYUXb9vPJ+r6TiUdi+YCNXYYc6kDpfQ6xLLRLn9MPm4=;
        b=boMiAzI/Iqh34M8HKS88rCFnrs8OWn/XIGwbExB4CCxe+ITS8aRP+0ZlVas4zNAASB
         VCMn/UNPWbgDbvk73ja9eqxr/4mpMzId+E0jD6Aki/zMehr8p3mT5lMb+sgfkSyPXevD
         kegPDghN+EIW0gO93hwMnxgcKXdCOj4EcpApoF4bKyfrEG+R2mdxkvsE0j8N3JFqftne
         GXKKFtncO21KPVU/sevqno3HS4sKkn8QBRx0KUdWsZDJBjmTBQkyha8HsfkT23Vxo6ad
         5zjysaJSRM2mIXEhfU7/s9u/6/th8EUCXMmTN7PRaYzSE1d4wCMA+jRYuUvz3GU5os34
         9SGQ==
X-Received: by 10.98.72.199 with SMTP id q68mr145147175pfi.140.1452106574464;
        Wed, 06 Jan 2016 10:56:14 -0800 (PST)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id u67sm137196864pfa.84.2016.01.06.10.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 10:56:13 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     linux-mips@linux-mips.org, gregory.0xf0@gmail.com,
        jaedon.shin@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/3] gpio: brcmstb: Allow building driver for BMIPS_GENERIC
Date:   Wed,  6 Jan 2016 10:55:23 -0800
Message-Id: <1452106523-11556-4-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
References: <1452106523-11556-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

BMIPS_GENERIC (arch/mips/bmips) is the Kconfig symbol associated with
Broadcom MIPS-based STB chips. Since this driver is perfectly usable on
these platforms as well, allow using it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b60f40a423f3..cb212ebb39ff 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -134,8 +134,8 @@ config GPIO_BCM_KONA
 
 config GPIO_BRCMSTB
 	tristate "BRCMSTB GPIO support"
-	default y if ARCH_BRCMSTB
-	depends on OF_GPIO && (ARCH_BRCMSTB || COMPILE_TEST)
+	default y if (ARCH_BRCMSTB || BMIPS_GENERIC)
+	depends on OF_GPIO && (ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST)
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.1.0
