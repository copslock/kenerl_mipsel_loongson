Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:02:40 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55025 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022859AbZFCOCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:33 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id D9FEA1124092; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 6/8] bcm63xx: add missing null entry in bcm63xx_pcmcia pci device table.
Date:	Wed,  3 Jun 2009 16:02:25 +0200
Message-Id: <1244037747-27144-7-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

The PCI device table in bcm63xx_pcmcia lacks the final null
entry. Spotted by build system when building it as module.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 drivers/pcmcia/bcm63xx_pcmcia.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 6c7f20c..48928b8 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -492,6 +492,8 @@ static struct pci_device_id bcm63xx_cb_table[] = {
 		.class		= PCI_CLASS_BRIDGE_CARDBUS << 8,
 		.class_mask	= ~0,
 	},
+
+	{ },
 };
 
 MODULE_DEVICE_TABLE(pci, bcm63xx_cb_table);
-- 
1.6.0.4
