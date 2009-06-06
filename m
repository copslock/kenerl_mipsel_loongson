Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 13:11:05 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.158]:11292 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023308AbZFFMKN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 13:10:13 +0100
Received: by fg-out-1718.google.com with SMTP id d23so418212fga.9
        for <multiple recipients>; Sat, 06 Jun 2009 05:10:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GMbZlBqYnsxeIszQj9UKwbkVVg8r3DbgUHb0Zdh3VEo=;
        b=mTLqJ+whHREYdSdJTITsW5ofQuhhWUglUBbrH2vRM8zA5RIncX2cn+vY4furWYAoF1
         kp5Ips8FM2zat8SATt47No19iR/iobnW/FHz4COVkXBNpatoDMbXjDu1k/2vD9QwrT21
         jV57TKR4lGL/hs8GRpFW2vLL12iWeZ/HaCdFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gT/FBfSjmwuy6A/K6bFmx4/FaBUavgOxJChxSNtamuk+wZ9f/KBeUTmErtMh7+Zqyd
         NxhBZmWPlnwsszQPdT/xGi5Oo1V50iQEHm2KhiIL8GXPfOuz/nbNCTDI2v8GLzClJw2+
         3wyL1Z13sIAsaNl/IimVBTYKYDA9dHs/Br+mI=
Received: by 10.86.68.1 with SMTP id q1mr4961786fga.34.1244290212681;
        Sat, 06 Jun 2009 05:10:12 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm4489485fga.11.2009.06.06.05.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 05:10:12 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/5] Alchemy: xxs1500: use linux gpio api.
Date:	Sat,  6 Jun 2009 14:09:57 +0200
Message-Id: <1244290198-27162-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244290198-27162-4-git-send-email-manuel.lauss@gmail.com>
References: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-2-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-3-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-4-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23309
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
