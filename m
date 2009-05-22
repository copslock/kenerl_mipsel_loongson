Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:26:02 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.159]:28727 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022553AbZEVUZG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 21:25:06 +0100
Received: by fg-out-1718.google.com with SMTP id d23so216710fga.9
        for <linux-mips@linux-mips.org>; Fri, 22 May 2009 13:25:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=U8YPYheioI6K8x7dZ7fJEzoza/At6I7gz9stCDokigs=;
        b=AeLRA3fJrId0y46+AuGfjPUX1jfCVH0hd14JoWd3vdfLbl/7KVcxsZBFMjIvSIaTOq
         yc19+dRT+DUxD0OaEj2EPxt1ibCsqECo9WnwDoC8NlynY78HiHfN7sIoqRIR/43D/fiT
         Ptw18PpnpgZIrtKdBKW9ZrknL8sOxJIgmddXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=YyPK+mBbJ+MbNHzaeN7LkX0nTn+p//aTQy22LpMLTTiNJYt9zT4AIpMbMKjrZn+kXu
         EYZclDlbPxIY7cDfz/IQU+yqFxTEqx6pjUEgqvW8/ZOaBrlVEZcia+8Xrgq/XtZSplvu
         g5hI4feNOHYUnkK4Y2ZFLZduPKKXCTZLVBQUU=
Received: by 10.86.33.9 with SMTP id g9mr3405414fgg.66.1243023904919;
        Fri, 22 May 2009 13:25:04 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm1529337fga.11.2009.05.22.13.25.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 13:25:04 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 4/4] Alchemy: xxs1500: use linux gpio api.
Date:	Fri, 22 May 2009 22:24:59 +0200
Message-Id: <1243023899-10343-4-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net>
 <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net>
 <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Remove a few GPIO register accesses in the board init code with calls
to the gpio api.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/xxs1500/board_setup.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index a2634fa..ed7d999 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -23,6 +23,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 
@@ -65,20 +66,21 @@ void __init board_setup(void)
 	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
 
 #ifdef CONFIG_PCMCIA_XXS1500
-	/* Setup PCMCIA signals */
-	au_writel(0, SYS_PININPUTEN);
+	alchemy_gpio2_enable();
 
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
