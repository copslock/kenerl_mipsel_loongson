Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jul 2011 20:30:47 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56701 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491106Ab1GRSam (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jul 2011 20:30:42 +0200
Received: by fxd20 with SMTP id 20so5090569fxd.36
        for <linux-mips@linux-mips.org>; Mon, 18 Jul 2011 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=wJcpmfDf2Rix9/+K38A30msixHpDw6KfJDIBLng2arg=;
        b=htENL0P3AMXmFwb/Siuxw2kF48zTLruJRWToMX2EhMSPWqa7DuTZe+kfbjcIVhvWeB
         p2k+BzduEu+KE4lQITO9t7nRJUXOjGC5SNmPIDRQ7Sfx8GK4FZbzGWrizR6bEOUAcr6c
         fTkDcYSa85xRDGmKpPv9B86Qyhu17qgzT9YSg=
Received: by 10.223.160.144 with SMTP id n16mr4222284fax.88.1311013836854;
        Mon, 18 Jul 2011 11:30:36 -0700 (PDT)
Received: from localhost.localdomain (188-22-157-220.adsl.highway.telekom.at [188.22.157.220])
        by mx.google.com with ESMTPS id n27sm3126522faa.4.2011.07.18.11.30.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:30:35 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH] MIPS: PCI: add a map_irq callback to struct pci_controller
Date:   Mon, 18 Jul 2011 20:30:30 +0200
Message-Id: <1311013830-9990-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12618

I'm rewriting the Alchemy PCI driver to be a platform driver, and
one thing that bugs me to no end is that for every PCI controller
the same global pcibios_map_irq function is called.
Instead I'd like to pass the per-board pci irq tables through
platform data and provide a per-controller map_irq callback.

This patch adds a maq_irq callback to struct pci_controller,
and uses it if available in pcibios_init().

Run-tested on a DB1500 board.

Comments welcome!

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---

Eventually I'd like to do this also with pcibios_plat_dev_init,
which is unused except on octeon and SSB-bus BCM chips.

 arch/mips/alchemy/common/pci.c                   |    8 ++++++++
 arch/mips/alchemy/devboards/db1x00/board_setup.c |    8 ++++----
 arch/mips/include/asm/pci.h                      |    2 ++
 arch/mips/pci/fixup-au1000.c                     |    4 +---
 arch/mips/pci/pci.c                              |    9 ++++++---
 5 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/mips/alchemy/common/pci.c b/arch/mips/alchemy/common/pci.c
index 7866cf5..e7bd034 100644
--- a/arch/mips/alchemy/common/pci.c
+++ b/arch/mips/alchemy/common/pci.c
@@ -53,10 +53,18 @@ static struct resource pci_mem_resource = {
 
 extern struct pci_ops au1x_pci_ops;
 
+extern char irq_tab_alchemy[][5];
+
+int alchemy_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
+{
+	return irq_tab_alchemy[slot][pin];
+}
+
 static struct pci_controller au1x_controller = {
 	.pci_ops	= &au1x_pci_ops,
 	.io_resource	= &pci_io_resource,
 	.mem_resource	= &pci_mem_resource,
+	.map_irq	= alchemy_pci_map_irq,
 };
 
 #if defined(CONFIG_SOC_AU1500) || defined(CONFIG_SOC_AU1550)
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 5c956fe..8f6b926 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -41,7 +41,7 @@
 #include <prom.h>
 
 #ifdef CONFIG_MIPS_DB1500
-char irq_tab_alchemy[][5] __initdata = {
+char irq_tab_alchemy[][5] = {
 	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - HPT371   */
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
 };
@@ -50,7 +50,7 @@ char irq_tab_alchemy[][5] __initdata = {
 
 
 #ifdef CONFIG_MIPS_DB1550
-char irq_tab_alchemy[][5] __initdata = {
+char irq_tab_alchemy[][5] = {
 	[11] = { -1, AU1550_PCI_INTC, 0xff, 0xff, 0xff }, /* IDSEL 11 - on-board HPT371 */
 	[12] = { -1, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD, AU1550_PCI_INTA }, /* IDSEL 12 - PCI slot 2 (left) */
 	[13] = { -1, AU1550_PCI_INTA, AU1550_PCI_INTB, AU1550_PCI_INTC, AU1550_PCI_INTD }, /* IDSEL 13 - PCI slot 1 (right) */
@@ -59,7 +59,7 @@ char irq_tab_alchemy[][5] __initdata = {
 
 
 #ifdef CONFIG_MIPS_BOSPORUS
-char irq_tab_alchemy[][5] __initdata = {
+char irq_tab_alchemy[][5] = {
 	[11] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 11 - miniPCI  */
 	[12] = { -1, AU1500_PCI_INTA, 0xff, 0xff, 0xff }, /* IDSEL 12 - SN1741   */
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, AU1500_PCI_INTC, AU1500_PCI_INTD }, /* IDSEL 13 - PCI slot */
@@ -91,7 +91,7 @@ const char *get_system_type(void)
 
 
 #ifdef CONFIG_MIPS_MIRAGE
-char irq_tab_alchemy[][5] __initdata = {
+char irq_tab_alchemy[][5] = {
 	[11] = { -1, AU1500_PCI_INTD, 0xff, 0xff, 0xff }, /* IDSEL 11 - SMI VGX */
 	[12] = { -1, 0xff, 0xff, AU1500_PCI_INTC, 0xff }, /* IDSEL 12 - PNX1300 */
 	[13] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff }, /* IDSEL 13 - miniPCI */
diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 576397c..a5d30ef 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -45,6 +45,8 @@ struct pci_controller {
 	   of the PCI controller */
 	int (*get_busno)(void);
 	void (*set_busno)(int busno);
+
+	int (*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
 };
 
 /*
diff --git a/arch/mips/pci/fixup-au1000.c b/arch/mips/pci/fixup-au1000.c
index e2ddfc4..448d8e5 100644
--- a/arch/mips/pci/fixup-au1000.c
+++ b/arch/mips/pci/fixup-au1000.c
@@ -29,11 +29,9 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-extern char irq_tab_alchemy[][5];
-
 int __init pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	return irq_tab_alchemy[slot][pin];
+	return -1;
 }
 
 /* Do platform specific device initialization at pci_enable_device() time */
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 33bba7b..74f62e4 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -154,10 +154,13 @@ static int __init pcibios_init(void)
 	struct pci_controller *hose;
 
 	/* Scan all of the recorded PCI controllers.  */
-	for (hose = hose_head; hose; hose = hose->next)
+	for (hose = hose_head; hose; hose = hose->next) {
 		pcibios_scanbus(hose);
-
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
+		if (hose->map_irq)
+			pci_fixup_irqs(pci_common_swizzle, hose->map_irq);
+		else
+			pci_fixup_irqs(pci_common_swizzle, pcibios_map_irq);
+	}
 
 	pci_initialized = 1;
 
-- 
1.7.6
