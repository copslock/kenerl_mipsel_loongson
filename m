Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:25:57 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:35414 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025673AbZFARWJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:22:09 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 9023A1124092; Mon,  1 Jun 2009 19:21:58 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 10/10] bcm63xx: clarify meaning of the magical value in ehci-bcm63xx.c
Date:	Mon,  1 Jun 2009 19:21:58 +0200
Message-Id: <1243876918-9905-11-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23139
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
 drivers/usb/host/ehci-bcm63xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-bcm63xx.c b/drivers/usb/host/ehci-bcm63xx.c
index 8a62c0a..5a03fdd 100644
--- a/drivers/usb/host/ehci-bcm63xx.c
+++ b/drivers/usb/host/ehci-bcm63xx.c
@@ -78,7 +78,9 @@ static int __devinit ehci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 	reg |= USBH_PRIV_SWAP_EHCI_ENDN_MASK;
 	bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
 
-	/* don't ask... */
+	/* the magic value comes for the original vendor BSP and is
+	 * needed for USB to work. Datasheet does not help, so the
+	 * magic value is used as-is. */
 	bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
 
 	hcd = usb_create_hcd(&ehci_bcm63xx_hc_driver, &pdev->dev, "bcm63xx");
-- 
1.6.0.4
