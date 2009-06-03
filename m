Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 17:20:31 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:35959 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022343AbZFCQS1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 17:18:27 +0100
Received: by fxm23 with SMTP id 23so114418fxm.0
        for <multiple recipients>; Wed, 03 Jun 2009 09:18:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GMbZlBqYnsxeIszQj9UKwbkVVg8r3DbgUHb0Zdh3VEo=;
        b=VoXBaMf8gm4HY2U+c+vjzEP++BPHCPlCzH8w+IJxAC+TLKKI5/vMk30jCy2qT8GiNs
         Ag0v3T7EREFYauzTnoSyrH5MCtXe/83Pxu6Tl16+0CRS0kTxpea8mjJt2NMqfuicssjQ
         CoOUpyBodADmDm2LaRel85EoInkD90e/P9e+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wd+4FfKXaJEH76Aai8ynmTNJQDi53hOozkdNvuWazRAq7GLvbck6bFmdB2ONeTnzCl
         iCqrM0ACR9iqH+CnfafHcKGjulBU+VEz5IE3OiFAm+a/05+dYi0DO/YBdLS+lL4eM9Or
         DsS2vIlxVkmSb8uFWr8kqUVHDZNTfU9FOTeCQ=
Received: by 10.103.246.1 with SMTP id y1mr733856mur.72.1244045901965;
        Wed, 03 Jun 2009 09:18:21 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id u26sm37723mug.22.2009.06.03.09.18.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 09:18:21 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/5] Alchemy: xxs1500: use linux gpio api.
Date:	Wed,  3 Jun 2009 18:18:07 +0200
Message-Id: <1244045888-16259-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244045888-16259-4-git-send-email-manuel.lauss@gmail.com>
References: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-2-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-3-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-4-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Replace a few GPIO register accesses in the board init code with calls
to the gpio api.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/xxs1500/board_setup.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index a2634fa..4de2d48 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -23,6 +23,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 
@@ -50,6 +51,9 @@ void __init board_setup(void)
 	}
 #endif
 
+	alchemy_gpio1_input_enable();
+	alchemy_gpio2_enable();
+
 	/* Set multiple use pins (UART3/GPIO) to UART (it's used as UART too) */
 	pin_func  = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
 	pin_func |= SYS_PF_UR3;
@@ -65,20 +69,19 @@ void __init board_setup(void)
 	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
 
 #ifdef CONFIG_PCMCIA_XXS1500
-	/* Setup PCMCIA signals */
-	au_writel(0, SYS_PININPUTEN);
-
 	/* GPIO 0, 1, and 4 are inputs */
-	au_writel(1 | (1 << 1) | (1 << 4), SYS_TRIOUTCLR);
+	alchemy_gpio_direction_input(0);
+	alchemy_gpio_direction_input(1);
+	alchemy_gpio_direction_input(4);
 
-	/* Enable GPIO2 if not already enabled */
-	au_writel(1, GPIO2_ENABLE);
 	/* GPIO2 208/9/10/11 are inputs */
-	au_writel((1 << 8) | (1 << 9) | (1 << 10) | (1 << 11), GPIO2_DIR);
+	alchemy_gpio_direction_input(208);
+	alchemy_gpio_direction_input(209);
+	alchemy_gpio_direction_input(210);
+	alchemy_gpio_direction_input(211);
 
 	/* Turn off power */
-	au_writel((au_readl(GPIO2_PINSTATE) & ~(1 << 14)) | (1 << 30),
-		  GPIO2_OUTPUT);
+	alchemy_gpio_direction_output(214, 0);
 #endif
 
 #ifdef CONFIG_PCI
-- 
1.6.3.1
