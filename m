Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:11:15 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42543 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025629AbZFARIa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:30 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 70BE0112408F; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: clarify meaning of the magical value in ohci-bcm63xx.c
Date:	Mon,  1 Jun 2009 19:08:13 +0200
Message-Id: <1243876095-8987-8-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

USB maintainer asked for clarification  of the magic value used during
USB init. Be clear about the source of it.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ohci-bcm63xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ohci-bcm63xx.c b/drivers/usb/host/ohci-bcm63xx.c
index d48c8ac..bd66d5a 100644
--- a/drivers/usb/host/ohci-bcm63xx.c
+++ b/drivers/usb/host/ohci-bcm63xx.c
@@ -85,7 +85,9 @@ static int __devinit ohci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
 		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
 		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
-		/* don't ask... */
+		/* the magic value comes for the original vendor BSP
+		 * and is needed for USB to work. Datasheet does not
+		 * help, so the magic value is used as-is. */
 		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
 	} else
 		return 0;
-- 
1.6.0.4
