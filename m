Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:37:11 +0100 (WEST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:50003 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023378AbZFAShF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:37:05 +0100
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 95008D4814D;
	Mon,  1 Jun 2009 20:36:58 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A1FF4D48183;
	Mon,  1 Jun 2009 20:36:56 +0200 (CEST)
Subject: [PATCH 10/10 (v2)] bcm63xx: clarify meaning of the magical value
 in ehci-bcm63xx.c
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
In-Reply-To: <4A2416A4.4070902@ru.mvista.com>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
	 <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
	 <4A2416A4.4070902@ru.mvista.com>
Content-Type: text/plain
Organization: Freebox
Date:	Mon, 01 Jun 2009 20:36:56 +0200
Message-Id: <1243881416.7410.107.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


USB maintainer asked for clarification of the magic value used during
USB init. Be clear about the source of it.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ehci-bcm63xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-bcm63xx.c b/drivers/usb/host/ehci-bcm63xx.c
index 8a62c0a..c2b3e7f 100644
--- a/drivers/usb/host/ehci-bcm63xx.c
+++ b/drivers/usb/host/ehci-bcm63xx.c
@@ -78,7 +78,11 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 	reg |= USBH_PRIV_SWAP_EHCI_ENDN_MASK;
 	bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
 
-	/* don't ask... */
+	/*
+	 * The magic value comes for the original vendor BSP and is
+	 * needed for USB to work. Datasheet does not help, so the
+	 * magic value is used as-is.
+	 */
 	bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
 
 	hcd = usb_create_hcd(&ehci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");
-- 
1.6.0.4
