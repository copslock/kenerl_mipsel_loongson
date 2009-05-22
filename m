Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:25:37 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.157]:5818 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20022552AbZEVUZG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 21:25:06 +0100
Received: by fg-out-1718.google.com with SMTP id d23so216707fga.9
        for <linux-mips@linux-mips.org>; Fri, 22 May 2009 13:25:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jXB/X4zRKo9BHCsZ7SGogQMrtKaOwh4FBYkPycgmR38=;
        b=AHbIREZL4mw5Ec10Iyar8aBunWeYlehMJ9wjJIVpaL9ULwoagPAe4574NeZ78xW8Yt
         vDR4XXaJEtparqmtG2zqXhlAx2mbs7htD+an2M5WbiIMu9GYPLVUuXQuJ9kvu2ZkurMr
         HzQrm4oJzldHZZCmbrtPr/GrY1O5fD8KXPen4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=KbWiMd8pCjdvjrCE+wEVbRuXM5CJsLEBw5+Up3xCqQm5uuOC+ZKGdzt+pYQrSaChxX
         fiCPGOtcGNDmlujgjCVdmg4PM2ff1En6jbtBOMKV8oCSHfCBxMIvmQco/lCBYqwLwdio
         q+Fd5i/gJqQh1OUc9yZ2xmv6pBYZ79GocYBWQ=
Received: by 10.86.51.10 with SMTP id y10mr3425514fgy.51.1243023904284;
        Fri, 22 May 2009 13:25:04 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id e11sm1529337fga.11.2009.05.22.13.25.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 13:25:03 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 3/4] Alchemy: mtx-1: use linux gpio api.
Date:	Fri, 22 May 2009 22:24:58 +0200
Message-Id: <1243023899-10343-3-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net>
References: <1243023899-10343-1-git-send-email-mano@roarinelk.homelinux.net>
 <1243023899-10343-2-git-send-email-mano@roarinelk.homelinux.net>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22930
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
 arch/mips/alchemy/mtx-1/board_setup.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/mips/alchemy/mtx-1/board_setup.c b/arch/mips/alchemy/mtx-1/board_setup.c
index 8ed1ae1..3356a0d 100644
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
+	alchemy_gpio_direction_output(4, 0);
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
