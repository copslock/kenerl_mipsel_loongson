Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 11:04:55 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:35041 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133619AbWFWKB2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 11:01:28 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id BA6F9C05F;
	Fri, 23 Jun 2006 12:01:17 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id AF04C1BC084;
	Fri, 23 Jun 2006 12:01:18 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id C23631A18AE;
	Fri, 23 Jun 2006 12:01:18 +0200 (CEST)
Date:	Fri, 23 Jun 2006 12:01:21 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [patch 7/8] au1xxx: compile fixes for OHCI for au1200
Message-ID: <20060623100121.GG31017@domen.ultra.si>
References: <20060623095703.GA30980@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623095703.GA30980@domen.ultra.si>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Compile fixes for au1200 ohci.

First part looks a bit hackish... but it works for me.


Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

Index: linux-mailed/drivers/usb/host/ohci-au1xxx.c
===================================================================
--- linux-mailed.orig/drivers/usb/host/ohci-au1xxx.c
+++ linux-mailed/drivers/usb/host/ohci-au1xxx.c
@@ -101,9 +101,11 @@ static void au1xxx_start_ohc(struct plat
 
 #endif  /* Au1200 */
 
+#ifndef CONFIG_SOC_AU1200
 	/* wait for reset complete (read register twice; see au1500 errata) */
 	while (au_readl(USB_HOST_CONFIG),
 		!(au_readl(USB_HOST_CONFIG) & USBH_ENABLE_RD))
+#endif
 		udelay(1000);
 
 	printk(KERN_DEBUG __FILE__
@@ -157,9 +159,9 @@ static int usb_ohci_au1xxx_probe(const s
 	/* Au1200 AB USB does not support coherent memory */
 	if (!(read_c0_prid() & 0xff)) {
 		pr_info("%s: this is chip revision AB !!\n",
-			dev->dev.name);
+			dev->name);
 		pr_info("%s: update your board or re-configure the kernel\n",
-			dev->dev.name);
+			dev->name);
 		return -ENODEV;
 	}
 #endif
