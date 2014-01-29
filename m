Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 19:12:23 +0100 (CET)
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56186 "EHLO
        mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827341AbaA2SL7Xu9PE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jan 2014 19:11:59 +0100
Received: by mail-ee0-f46.google.com with SMTP id c13so1085526eek.33
        for <linux-mips@linux-mips.org>; Wed, 29 Jan 2014 10:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JbNtYazkpQw8JdoV0CPCrnZMptc9OiiI84FGOr4wW1Y=;
        b=oOi8unfWA6i0j7Az24hijEedivNED3FSQw0U1Z6ceoJ/B16auy5p8mSXdT1msXP93S
         5H1Kd5h4KscyL5U5u+u1wK31cgdJn/m0CsZx9rWJdxVVNxESCsGL2YQPbap9Ev7CjkfD
         cFJ9fVSgwxd0q841BEsAk3hGhcmDVzWEPxKZKcuylIL7gPICOi5t4Zaz1UeY4brSeYP5
         diVANT0P4Efha8gWJ0REi911il7lcv3/JjLG9BvX89FfBhOhNyfzWXdnCrwvf+tQZpFf
         VsacP6/Aov+7NSWovYxcKiFxjGLN8mDWztI9AFyy6Ducq/EPb0C5XsEFox6v9q5/j/wu
         +YvA==
X-Received: by 10.14.204.9 with SMTP id g9mr4011440eeo.82.1391019113770;
        Wed, 29 Jan 2014 10:11:53 -0800 (PST)
Received: from flagship.roarinelk.net (62-47-46-135.adsl.highway.telekom.at. [62.47.46.135])
        by mx.google.com with ESMTPSA id 8sm6467456eef.1.2014.01.29.10.11.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2014 10:11:52 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH] MIPS: Alchemy: fix DB1100 GPIO registration
Date:   Wed, 29 Jan 2014 19:11:46 +0100
Message-Id: <1391019106-25613-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.3
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

With CONFIG_GPIOLIB=y gpios need to be requested before they can be
modified.  Request the SD carddetect pins, and drop the SPI direction
setup, as the driver does that for us anyway.  This gets rid of a
lot of WARN_ON()s triggered by GPIO core, and restores functionality
of the touschreen controller.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1000.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 11f3ad2..5483906 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -534,13 +534,10 @@ static int __init db1000_dev_init(void)
 		s0 = AU1100_GPIO1_INT;
 		s1 = AU1100_GPIO4_INT;
 
+		gpio_request(19, "sd0_cd");
+		gpio_request(20, "sd1_cd");
 		gpio_direction_input(19);	/* sd0 cd# */
 		gpio_direction_input(20);	/* sd1 cd# */
-		gpio_direction_input(21);	/* touch pendown# */
-		gpio_direction_input(207);	/* SPI MISO */
-		gpio_direction_output(208, 0);	/* SPI MOSI */
-		gpio_direction_output(209, 1);	/* SPI SCK */
-		gpio_direction_output(210, 1);	/* SPI CS# */
 
 		/* spi_gpio on SSI0 pins */
 		pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
-- 
1.8.5.3
