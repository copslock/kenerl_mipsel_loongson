Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 19:38:28 +0100 (WEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:43854 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023398AbZFASiV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 1 Jun 2009 19:38:21 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id CA3F9E0807A;
	Mon,  1 Jun 2009 20:38:16 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id F243DE080FB;
	Mon,  1 Jun 2009 20:38:13 +0200 (CEST)
Subject: [PATCH 07/10 (v2)] bcm63xx: clarify meaning of the magical value
 in ohci-bcm63xx.c
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>
In-Reply-To: <1243876918-9905-8-git-send-email-mbizon@freebox.fr>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
	 <1243876918-9905-8-git-send-email-mbizon@freebox.fr>
Content-Type: text/plain
Organization: Freebox
Date:	Mon, 01 Jun 2009 20:38:13 +0200
Message-Id: <1243881493.7410.109.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23159
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
 drivers/usb/host/ohci-bcm63xx.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ohci-bcm63xx.c b/drivers/usb/host/ohci-bcm63xx.c
index d48c8ac..668808e 100644
--- a/drivers/usb/host/ohci-bcm63xx.c
+++ b/drivers/usb/host/ohci-bcm63xx.c
@@ -85,7 +85,11 @@ static int __devinit ohci_hcd_bcm63xx_drv_probe(struct platform_device *pdev)
 		reg &= ~USBH_PRIV_SWAP_OHCI_ENDN_MASK;
 		reg |= USBH_PRIV_SWAP_OHCI_DATA_MASK;
 		bcm_rset_writel(RSET_USBH_PRIV, reg, USBH_PRIV_SWAP_REG);
-		/* don't ask... */
+		/*
+		 * The magic value comes for the original vendor BSP
+		 * and is needed for USB to work. Datasheet does not
+		 * help, so the magic value is used as-is.
+		 */
 		bcm_rset_writel(RSET_USBH_PRIV, 0x1c0020, USBH_PRIV_TEST_REG);
 	} else
 		return 0;
-- 
1.6.0.4
