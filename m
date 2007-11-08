Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2007 21:09:27 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:16806 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20024998AbXKHVJR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2007 21:09:17 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IqEcn-0000kC-00; Thu, 08 Nov 2007 22:09:17 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id F138CDE005; Thu,  8 Nov 2007 22:09:11 +0100 (CET)
Date:	Thu, 8 Nov 2007 22:09:11 +0100
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] SNI PCIT CPLUS: workaround for messed up PCI irq wiring
Message-ID: <20071108210911.GA19753@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips


SNI PCIT CPLUS: workaround for messed up irq wiring for onboard PCI bus 1 

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

diff --git a/arch/mips/pci/fixup-sni.c b/arch/mips/pci/fixup-sni.c
index a45bedd..5c8a79b 100644
--- a/arch/mips/pci/fixup-sni.c
+++ b/arch/mips/pci/fixup-sni.c
@@ -113,6 +113,16 @@ static char irq_tab_pcit[13][5] __initdata = {
 	{     0,  INTA,  INTB,  INTC,  INTD },	/* Slot 5 */
 };
 
+static char irq_tab_pcit_cplus[13][5] __initdata = {
+	/*       INTA  INTB  INTC  INTD */
+	{     0,     0,     0,     0,     0 },	/* HOST bridge */
+	{     0,  INTB,  INTC,  INTD,  INTA },	/* PCI Slot 9 */
+	{     0,     0,     0,     0,     0 },	/* PCI-EISA */
+	{     0,     0,     0,     0,     0 },	/* Unused */
+	{     0,  INTA,  INTB,  INTC,  INTD },	/* PCI-PCI bridge */
+	{     0,  INTB,  INTC,  INTD,  INTA },	/* fixup */
+};
+
 static inline int is_rm300_revd(void)
 {
 	unsigned char csmsr = *(volatile unsigned char *)PCIMT_CSMSR;
@@ -123,8 +133,19 @@ static inline int is_rm300_revd(void)
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
 	switch (sni_brd_type) {
-	case SNI_BRD_PCI_TOWER:
 	case SNI_BRD_PCI_TOWER_CPLUS:
+		if (slot == 4) {
+			/*
+			 * SNI messed up interrupt wiring for onboard
+			 * PCI bus 1; we need to fix this up here
+			 */
+			while (dev && dev->bus->number != 1)
+				dev = dev->bus->self;
+			if (dev && dev->devfn >= PCI_DEVFN(4, 0))
+				slot = 5;
+		}
+		return irq_tab_pcit_cplus[slot][pin];
+	case SNI_BRD_PCI_TOWER:
 	        return irq_tab_pcit[slot][pin];
 
 	case SNI_BRD_PCI_MTOWER:
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
