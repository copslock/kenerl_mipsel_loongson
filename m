Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 17:19:42 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57234 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022336AbZFCQS0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 17:18:26 +0100
Received: by bwz25 with SMTP id 25so113501bwz.0
        for <multiple recipients>; Wed, 03 Jun 2009 09:18:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=68HdVqHCweH5OHusGpsypOFc+VyItaGmh2LCyMy10xc=;
        b=janmorfPRato0LHcRcGkNq63m/0yA764iNADxR9K6XpQq6yGrexOLKkhERek+mmoYQ
         B3WTYnEHzp5hPgar3eqn01l9xwDH78Ol9I/MsU1nn/4IzfZ3JGtVQCHM8WW6T03lSfYf
         REQ7gDd8U1RjNt600l8cvYwI99oJRFVyn+ku0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=shIyO30afbA56l6IRUkaPJ8lYflBWrwJH6Npl4gmbvFmMWzWbMmfrw2N6VXnOV+izx
         tmur3gGXU+r7T7TKa9GPYwaz3wAZYa+pdnwrWo5VY3ekC8iMM/lU1iuxYCb0rlISLOOU
         78SGJQMDIRQXCj1EEEsx2tM9So70RdVVF55bE=
Received: by 10.103.226.10 with SMTP id d10mr749918mur.35.1244045900618;
        Wed, 03 Jun 2009 09:18:20 -0700 (PDT)
Received: from localhost.localdomain (p5496DB58.dip.t-dialin.net [84.150.219.88])
        by mx.google.com with ESMTPS id u26sm37723mug.22.2009.06.03.09.18.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 09:18:20 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/5] Alchemy: mtx-1: use linux gpio api.
Date:	Wed,  3 Jun 2009 18:18:06 +0200
Message-Id: <1244045888-16259-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244045888-16259-3-git-send-email-manuel.lauss@gmail.com>
References: <1244045888-16259-1-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-2-git-send-email-manuel.lauss@gmail.com>
 <1244045888-16259-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23224
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
