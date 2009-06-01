Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 18:22:12 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:35395 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025668AbZFARWD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 18:22:03 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id 6FEDC112408D; Mon,  1 Jun 2009 19:21:58 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 04/10] bcm63xx: limit number of usb port to 1.
Date:	Mon,  1 Jun 2009 19:21:52 +0200
Message-Id: <1243876918-9905-5-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
References: <1243876918-9905-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

This patch disables the use of more than one USB port. Hardware has
two ports, but one may be shared with USB slave port.

Until we have this information in the platform data, don't use the
second port.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/usb/host/ohci-bcm63xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ohci-bcm63xx.c b/drivers/usb/host/ohci-bcm63xx.c
index 08807d9..74f432f 100644
--- a/drivers/usb/host/ohci-bcm63xx.c
+++ b/drivers/usb/host/ohci-bcm63xx.c
@@ -20,6 +20,8 @@ static int __devinit ohci_bcm63xx_start(struct usb_hcd *hcd)
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	int ret;
 
+	ohci->num_ports = 1;
+
 	ret = ohci_init(ohci);
 	if (ret < 0)
 		return ret;
-- 
1.6.0.4
