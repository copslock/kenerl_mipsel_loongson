Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Feb 2011 15:58:32 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:64306 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491758Ab1BVO62 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Feb 2011 15:58:28 +0100
Received: by fxm16 with SMTP id 16so3820519fxm.36
        for <multiple recipients>; Tue, 22 Feb 2011 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=fuvGP94NaRfSwHiZtYBZMpJYZHLZxuKdiqZNeFBe1XY=;
        b=SMr+2u1n1N8kSYcaCseEPwMXKKdHSHCPGU3THcvlgjFd9B0TnNRu3xpfOoFCcYuCoN
         SBfFC/DRdKpGUGdCfQCiIcuSU0H6TYWXITRp6rS+GSjpLrHYQVc+QDvAOTiIfmGQkdxs
         0+aOcVjTcSdOLx5nq8a316openwRx5LpVFC6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ff9rLV+cRMh5lqLOLWcNZSk6RtLXfHMW4zwvIF3ndy+WRpNg9M0ADJd8n6eHYSpH/V
         AhC/igoBIrLzHo0WHH69X2swWKUYzw/kMR4qbAqtDWEw/OhOWLDAbvIovnXkqC9wJUkw
         8M1b1RrcBQkOC4rddOrpXgphNY9s7vN3eIDCY=
Received: by 10.223.61.133 with SMTP id t5mr123499fah.103.1298386703297;
        Tue, 22 Feb 2011 06:58:23 -0800 (PST)
Received: from localhost.localdomain ([59.160.135.215])
        by mx.google.com with ESMTPS id n3sm3067021faa.29.2011.02.22.06.58.20
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 06:58:22 -0800 (PST)
From:   "Anoop P.A" <anoop.pa@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     Anoop P A <anoop.pa@gmail.com>
Subject: [PATCH] MSP82XX pci support. Add pci fixup entries for MSP82XX Acadia board.
Date:   Tue, 22 Feb 2011 20:51:28 +0530
Message-Id: <1298388088-11338-1-git-send-email-anoop.pa@gmail.com>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

From: Anoop P A <anoop.pa@gmail.com>


Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pci/fixup-pmcmsp.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/mips/pci/fixup-pmcmsp.c b/arch/mips/pci/fixup-pmcmsp.c
index 65735b1..6569e70 100644
--- a/arch/mips/pci/fixup-pmcmsp.c
+++ b/arch/mips/pci/fixup-pmcmsp.c
@@ -122,6 +122,45 @@ static char irq_tab[][5] __initdata = {
 	{0,     0,      0,      0,      0 }     /* 21 (AD[31]): Unused */
 };
 
+#elif defined(CONFIG_PMC_MSP82XX_ACADIA)
+
+/* Acadia Board IRQ wiring to PCI slots */
+static char irq_tab[][5] __initdata = {
+	/*INTA	INTB	INTC	INTD */
+	{0,	0,	0,	0,	0 },	/*	(AD[0]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[1]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[2]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[3]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[4]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[5]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[6]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[7]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[8]): Unused */
+	{0,	0,	0,	0,	0 },	/*	(AD[9]): Unused */
+	{0,	0,	0,	0,	0 },	/*	0 (AD[10]): Unused */
+	{0,	0,	0,	0,	0 },	/*	1 (AD[11]): Unused */
+	{0,	0,	0,	0,	0 },	/*	2 (AD[12]): Unused */
+	{0,	0,	0,	0,	0 },	/*	3 (AD[13]): Unused */
+	{0,	0,	0,	0,	0 },	/*	4 (AD[14]): Unused */
+	{0,	0,	0,	0,	0 },	/*	5 (AD[15]): Unused */
+	{0,	0,	0,	0,	0 },	/*	6 (AD[16]): Unused */
+	{0,	0,	0,	0,	0 },	/*	7 (AD[17]): Unused */
+	{0,	0,	0,	0,	0 },	/*	8 (AD[18]): Unused */
+	{0,	0,	0,	0,	0 },	/*	9 (AD[19]): Unused */
+	{0,	0,	0,	0,	0 },	/*	10 (AD[20]): Unused */
+	{0,	0,	0,	0,	0 },	/*	11 (AD[21]): Unused */
+	{0,	0,	0,	0,	0 },	/*	12 (AD[22]): Unused */
+	{0,	0,	0,	0,	0 },	/*	13 (AD[23]): Unused */
+	{0,	0,	0,	0,	0 },	/*	14 (AD[24]): Unused */
+	{0,	0,	0,	0,	0 },	/*	15 (AD[25]): Unused */
+	{0,	0,	0,	0,	0 },	/*	16 (AD[26]): Unused */
+	{0,	0,	0,	0,	0 },	/*	17 (AD[27]): Unused */
+	{0,	IRQ5,	IRQ5,	0,	0 },	/*	18 (AD[28]): slot 0 */
+	{0,	0,	0,	0,	0 },	/*	19 (AD[29]): Unused */
+	{0,	IRQ4,	IRQ4,	0,	0 },	/*	20 (AD[30]): slot 1*/
+	{0,	0,	0,	0,	0 },	/*	21 (AD[31]): Unused */
+};
+
 #else
 
 /* Unknown board -- don't assign any IRQs */
@@ -204,9 +243,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
  ****************************************************************************/
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-#if !defined(CONFIG_PMC_MSP7120_GW) && !defined(CONFIG_PMC_MSP7120_EVAL)
-	printk(KERN_WARNING "PCI: unknown board, no PCI IRQs assigned.\n");
-#endif
 	printk(KERN_WARNING "PCI: irq_tab returned %d for slot=%d pin=%d\n",
 		irq_tab[slot][pin], slot, pin);
 
-- 
1.7.0.4
