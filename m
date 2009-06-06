Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 13:10:41 +0100 (WEST)
Received: from fg-out-1718.google.com ([72.14.220.154]:11363 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023307AbZFFMKM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 13:10:12 +0100
Received: by fg-out-1718.google.com with SMTP id d23so418210fga.9
        for <multiple recipients>; Sat, 06 Jun 2009 05:10:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vxgL/15RDN066puvrfdcujbHUQPQGHrqlVqafbLdPAc=;
        b=kp3ZtfisoJr+TjM0rPTPR/UPzZdQKzKb6lMVWpQduA/uGJtr2Tl+56WSNnON0s7BBU
         OEwwh8l2OVvAs4BbkS75n/8Yn4eDPq50iaoqwe9LxVk19+5ZQhN5wcrc6kJyoFeyeZfw
         nVYMWzCn3iFDgj0jMrfjUvNsu6bYOAuBn7fz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=k34Rxk0lccPJgL7OGCXi4DVr149CuZSiXus9tGQU7HlHYXWbfpWg5mVlePSazmz5zo
         8RCeEWjhxqCvybpt9JE/0mLqQdBo1bviZcmpbDaXk/xlM3s5+g+NBh5pbKgpa3Bg36Bi
         UT8Gmrg7EmQRACaWDuaKlsx3/tXwsgmno9VT4=
Received: by 10.86.70.3 with SMTP id s3mr4966522fga.16.1244290211895;
        Sat, 06 Jun 2009 05:10:11 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm4489485fga.11.2009.06.06.05.10.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 05:10:11 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/5] Alchemy: mtx-1: use linux gpio api.
Date:	Sat,  6 Jun 2009 14:09:56 +0200
Message-Id: <1244290198-27162-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244290198-27162-3-git-send-email-manuel.lauss@gmail.com>
References: <1244290198-27162-1-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-2-git-send-email-manuel.lauss@gmail.com>
 <1244290198-27162-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23308
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
 arch/mips/alchemy/mtx-1/board_setup.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 8ed1ae1..0b0be03 100644
--- a/arch/mips/alchemy/mtx-1/board_setup.c
+++ b/arch/mips/alchemy/mtx-1/board_setup.c
@@ -28,6 +28,7 @@
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/gpio.h>
 #include <linux/init.h>
 
 #include <asm/mach-au1x00/au1000.h>
@@ -55,10 +56,11 @@ void __init board_setup(void)
 	}
 #endif
 
+	alchemy_gpio2_enable();
+
 #if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	/* Enable USB power switch */
-	au_writel(au_readl(GPIO2_DIR) | 0x10, GPIO2_DIR);
-	au_writel(0x100000, GPIO2_OUTPUT);
+	alchemy_gpio_direction_output(204, 0);
 #endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
 
 #ifdef CONFIG_PCI
@@ -74,14 +76,14 @@ void __init board_setup(void)
 
 	/* Initialize GPIO */
 	au_writel(0xFFFFFFFF, SYS_TRIOUTCLR);
-	au_writel(0x00000001, SYS_OUTPUTCLR); /* set M66EN (PCI 66MHz) to OFF */
-	au_writel(0x00000008, SYS_OUTPUTSET); /* set PCI CLKRUN# to OFF */
-	au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
-	au_writel(0x00000020, SYS_OUTPUTCLR); /* set eth PHY TX_ER to OFF */
+	alchemy_gpio_direction_output(0, 0);	/* set M66EN (PCI 66MHz) to OFF */
+	alchemy_gpio_direction_output(3, 1);	/* set PCI CLKRUN# to OFF */
+	alchemy_gpio_direction_output(1, 1);	/* set EXT_IO3 ON */
+	alchemy_gpio_direction_output(5, 0);	/* set eth PHY TX_ER to OFF */
 
 	/* Enable LED and set it to green */
-	au_writel(au_readl(GPIO2_DIR) | 0x1800, GPIO2_DIR);
-	au_writel(0x18000800, GPIO2_OUTPUT);
+	alchemy_gpio_direction_output(211, 1);	/* green on */
+	alchemy_gpio_direction_output(212, 0);	/* red off */
 
 	board_pci_idsel = mtx1_pci_idsel;
 
@@ -101,10 +103,10 @@ mtx1_pci_idsel(unsigned int devsel, int assert)
 
 	if (assert && devsel != 0)
 		/* Suppress signal to Cardbus */
-		au_writel(0x00000002, SYS_OUTPUTCLR); /* set EXT_IO3 OFF */
+		gpio_set_value(1, 0);	/* set EXT_IO3 OFF */
 	else
-		au_writel(0x00000002, SYS_OUTPUTSET); /* set EXT_IO3 ON */
+		gpio_set_value(1, 1);	/* set EXT_IO3 ON */
+
 	au_sync_udelay(1);
 	return 1;
 }
-
-- 
1.6.3.1
