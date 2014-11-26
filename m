Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Nov 2014 01:51:48 +0100 (CET)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35915 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007130AbaKZAvbzfRfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Nov 2014 01:51:31 +0100
Received: by mail-pd0-f174.google.com with SMTP id w10so1635684pde.19
        for <linux-mips@linux-mips.org>; Tue, 25 Nov 2014 16:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DbnDKCXnJHDB5GQi/YlTq3vonc2nEm+FUCdH4fkSu1w=;
        b=hVJ6nxpYzdZ81c0ajvf6/1xRMDLmYGvlpcUe2I15YM/fdPsmBDY5LUTbMlvew0gTHu
         pFHAmiThJzBcKcLQHlm1rmYK1LsmlRBAvXooqUZNN0ELdzbpRbIPb1815uw1aNaecdqZ
         /06dSYEa9N9BJBcZNo5Rf6Z+Mf4bz8x13w7DiJZm/NjpicAVc1C+1f95yNFzILdaAaBZ
         TfHSL5ouyx0nWIgiz5q3Rso5eTlFWx5szTCXt97nGv7S7xm48g4/f6TGbQnNUgXQ338/
         y2Uk08IifWi8C6uaxMvdo4DEb7asz389eCm3i6fg3gq2u/jzPwFVOwbroVDko1JcD0VM
         Zsww==
X-Received: by 10.68.131.3 with SMTP id oi3mr47441647pbb.27.1416963085319;
        Tue, 25 Nov 2014 16:51:25 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id bj11sm2614439pdb.1.2014.11.25.16.51.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 16:51:24 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org,
        arnd@arndb.de, linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com
Cc:     grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on MIPS
Date:   Tue, 25 Nov 2014 16:49:46 -0800
Message-Id: <1416962994-27095-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44454
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

Now that the driver doesn't use any ARM-specific headers, it is safe
to build on MIPS or with COMPILE_TEST.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/power/reset/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index f65ff49..0379846 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -39,14 +39,13 @@ config POWER_RESET_AXXIA
 	  Say Y if you have an Axxia family SoC.
 
 config POWER_RESET_BRCMSTB
-	bool "Broadcom STB reset driver" if COMPILE_TEST
-	depends on ARM
+	bool "Broadcom STB reset driver"
+	depends on ARM || MIPS || COMPILE_TEST
 	default ARCH_BRCMSTB
 	help
-	  This driver provides restart support for ARM-based Broadcom STB
-	  boards.
+	  This driver provides restart support for Broadcom STB boards.
 
-	  Say Y here if you have an ARM-based Broadcom STB board and you wish
+	  Say Y here if you have a Broadcom STB board and you wish
 	  to have restart support.
 
 config POWER_RESET_GPIO
-- 
2.1.0
