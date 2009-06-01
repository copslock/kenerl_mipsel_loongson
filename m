Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:10:51 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:42552 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025631AbZFARIc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:08:32 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 7EA6D1124093; Mon,  1 Jun 2009 19:08:15 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH] bcm63xx: don't set bus type in ehci-bcm63xx.c
Date:	Mon,  1 Jun 2009 19:08:15 +0200
Message-Id: <1243876095-8987-10-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
References: <1243876095-8987-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

The platform code already sets the bus type, so don't do it.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ehci-bcm63xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-bcm63xx.c b/drivers/usb/host/ehci-bcm63xx.c
index 0aba0f9..8a62c0a 100644
--- a/drivers/usb/host/ehci-bcm63xx.c
+++ b/drivers/usb/host/ehci-bcm63xx.c
@@ -145,7 +145,6 @@ static struct platform_driver ehci_hcd_bcm63xx_driver = {
 	.driver		= {
 		.name	= "bcm63xx_ehci",
 		.owner	= THIS_MODULE,
-		.bus	= &platform_bus_type
 	},
 };
 
-- 
1.6.0.4
