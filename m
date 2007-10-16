Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2007 19:17:01 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:33665 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20035949AbXJPSQx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2007 19:16:53 +0100
Received: (qmail invoked by alias); 16 Oct 2007 18:16:47 -0000
Received: from p548B3C7B.dip0.t-ipconnect.de (EHLO racer.localnet) [84.139.60.123]
  by mail.gmx.net (mp010) with SMTP; 16 Oct 2007 20:16:47 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX187APRIejY73MOl3rZRG330NolFxFJDUf3OLiH0ux
	EEpHdhjulhDTsI
Received: by racer.localnet (Postfix, from userid 1001)
	id 27896E168B00; Tue, 16 Oct 2007 20:16:48 +0200 (CEST)
From:	Johannes Dickgreber <tanzy@gmx.de>
To:	linux-mips@linux-mips.org, kumba@gentoo.org
Cc:	Johannes Dickgreber <tanzy@gmx.de>
Subject: [PATCH] Make drivers/sn/ioc3.c usable on Mips
Date:	Tue, 16 Oct 2007 20:16:47 +0200
Message-Id: <11925586073670-git-send-email-tanzy@gmx.de>
X-Mailer: git-send-email 1.5.2.5
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

This makes driver/sn/ioc3.c usable on Mips.

Changes:
	make ethernet subdriver use always slot 0
	changes in test for dual_irq, test active[] first

Only tested on SGI Octane which is out of tree.
Please test on other Arch and machines.
---
 drivers/Makefile     |    2 +-
 drivers/sn/Kconfig   |    6 +--
 drivers/sn/ioc3.c    |  121 ++++++++++++++++++++++++++++++--------------------
 include/linux/ioc3.h |    2 +
 4 files changed, 77 insertions(+), 54 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index f0878b2..c8dba0c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_MMC)		+= mmc/
 obj-$(CONFIG_NEW_LEDS)		+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
-obj-$(CONFIG_SGI_SN)		+= sn/
+obj-$(CONFIG_SGI_IOC3)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
diff --git a/drivers/sn/Kconfig b/drivers/sn/Kconfig
index c66ba9a..3649ad1 100644
--- a/drivers/sn/Kconfig
+++ b/drivers/sn/Kconfig
@@ -2,11 +2,9 @@
 # Miscellaneous SN-specific devices
 #
 
-menu "SN Devices"
-	depends on SGI_SN
-
 config SGI_IOC3
 	tristate "SGI IOC3 Base IO support"
+	depends on PCI && (SGI_SN || SGI_IP30)
 	default m
 	---help---
 	This option enables basic support for the SGI IOC3-based Base IO
@@ -17,5 +15,3 @@ config SGI_IOC3
 	If you have an SGI Altix with an IOC3-based
 	I/O controller or a PCI IOC3 serial card say Y.
 	Otherwise say N.
-
-endmenu
diff --git a/drivers/sn/ioc3.c b/drivers/sn/ioc3.c
index 29fcd6d..c66c866 100644
--- a/drivers/sn/ioc3.c
+++ b/drivers/sn/ioc3.c
@@ -23,8 +23,9 @@ static LIST_HEAD(ioc3_devices);
 static int ioc3_counter;
 static DECLARE_RWSEM(ioc3_devices_rwsem);
 
+/* ethernet submodule is always 0 */
+#define ETH_ID 0
 static struct ioc3_submodule *ioc3_submodules[IOC3_MAX_SUBMODULES];
-static struct ioc3_submodule *ioc3_ethernet;
 static DEFINE_RWLOCK(ioc3_submodules_lock);
 
 /* NIC probing code */
@@ -293,11 +294,13 @@ static void read_nic(struct ioc3_driver_data *idd, unsigned long addr)
 		if(data[i+32] != ' ')
 			part[j++] = data[i+32];
 	part[j] = 0;
-	/* skip Octane power supplies */
-	if(!strncmp(part, "060-0035-", 9))
-		return;
-	if(!strncmp(part, "060-0038-", 9))
+
+	/* skip Octane (IP30) power supplies */
+	if (!(strncmp(part, "060-0035-", 9)) ||
+	    !(strncmp(part, "060-0038-", 9)) ||
+	    !(strncmp(part, "060-0028-", 9)))
 		return;
+
 	strcpy(idd->nic_part, part);
 	/* assemble the serial # */
 	j=0;
@@ -406,32 +409,36 @@ static irqreturn_t ioc3_intr_io(int irq, void *arg)
 	unsigned int pending;
 
 	read_lock_irqsave(&ioc3_submodules_lock, flags);
-
-	if(idd->dual_irq && readb(&idd->vma->eisr)) {
-		/* send Ethernet IRQ to the driver */
-		if(ioc3_ethernet && idd->active[ioc3_ethernet->id] &&
-						ioc3_ethernet->intr) {
-			handled = handled && !ioc3_ethernet->intr(ioc3_ethernet,
-							idd, 0);
-		}
-	}
-	pending = get_pending_intrs(idd);	/* look at the IO IRQs */
-
-	for(id=0;id<IOC3_MAX_SUBMODULES;id++) {
-		if(idd->active[id] && ioc3_submodules[id]
-				&& (pending & ioc3_submodules[id]->irq_mask)
-				&& ioc3_submodules[id]->intr) {
-			write_ireg(idd, ioc3_submodules[id]->irq_mask,
-							IOC3_W_IEC);
-			if(!ioc3_submodules[id]->intr(ioc3_submodules[id],
-				   idd, pending & ioc3_submodules[id]->irq_mask))
-				pending &= ~ioc3_submodules[id]->irq_mask;
-			if (ioc3_submodules[id]->reset_mask)
-				write_ireg(idd, ioc3_submodules[id]->irq_mask,
-							IOC3_W_IES);
+	/* send Ethernet IRQ to the driver */
+	if (idd->active[ETH_ID] && !idd->dual_irq)
+		if (readl(&idd->vma->eisr))
+			handled = !ioc3_submodules[ETH_ID]->
+				    intr(ioc3_submodules[ETH_ID], idd, 0);
+
+	/* look at the IO IRQs */
+	pending = get_pending_intrs(idd);
+	for (id = 1; id < IOC3_MAX_SUBMODULES; id++)
+		if (idd->active[id]) &&
+		    (pending & ioc3_submodules[id]->irq_mask)
+		    {
+				write_ireg(idd, ioc3_submodules[id]->
+					irq_mask, IOC3_W_IEC);
+				if (!ioc3_submodules[id]->
+					intr(ioc3_submodules[id], idd,
+						(pending &
+						ioc3_submodules[id]->irq_mask)))
+					{
+					pending &= ~ioc3_submodules[id]->
+						    irq_mask;
+					handled = 1;
+				}
+				if (ioc3_submodules[id]->reset_mask)
+					write_ireg(idd,
+						ioc3_submodules[id]->irq_mask,
+						IOC3_W_IES);
 		}
-	}
 	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
 	if(pending) {
 		printk(KERN_WARNING
 		  "IOC3: Pending IRQs 0x%08x discarded and disabled\n",pending);
@@ -445,15 +452,13 @@ static irqreturn_t ioc3_intr_eth(int irq, void *arg)
 {
 	unsigned long flags;
 	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
-	int handled = 1;
+	int handled = 0;
 
-	if(!idd->dual_irq)
-		return IRQ_NONE;
 	read_lock_irqsave(&ioc3_submodules_lock, flags);
-	if(ioc3_ethernet && idd->active[ioc3_ethernet->id]
-				&& ioc3_ethernet->intr)
-		handled = handled && !ioc3_ethernet->intr(ioc3_ethernet, idd, 0);
+	if (idd->active[ETH_ID] && idd->dual_irq)
+		handled = !ioc3_submodules[ETH_ID]->intr(ioc3_submodules[ETH_ID], idd, 0);
 	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
 	return handled?IRQ_HANDLED:IRQ_NONE;
 }
 
@@ -475,6 +480,7 @@ void ioc3_disable(struct ioc3_submodule *is,
 	write_ireg(idd, irqs & is->irq_mask, IOC3_W_IEC);
 }
 
+/* SGI SN2 writes to gpcr to set GPIOs to output */
 void ioc3_gpcr_set(struct ioc3_driver_data *idd, unsigned int val)
 {
 	unsigned long flags;
@@ -483,11 +489,23 @@ void ioc3_gpcr_set(struct ioc3_driver_data *idd, unsigned int val)
 	spin_unlock_irqrestore(&idd->gpio_lock, flags);
 }
 
+/* IP27, IP30 writes to gpdr to set GPIOs to 1 */
+void ioc3_gpio(struct ioc3_driver_data *idd, unsigned int mask, unsigned int val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&idd->gpio_lock, flags);
+	idd->gpdr_shadow &= ~mask;
+	idd->gpdr_shadow |= (val & mask);
+	writel(idd->gpdr_shadow, &idd->vma->gpdr);
+	spin_unlock_irqrestore(&idd->gpio_lock, flags);
+}
+
 /* Keep it simple, stupid! */
 static int find_slot(void **tab, int max)
 {
 	int i;
-	for(i=0;i<max;i++)
+	for(i=1;i<max;i++)
 		if(!(tab[i]))
 			return i;
 	return -1;
@@ -501,17 +519,16 @@ int ioc3_register_submodule(struct ioc3_submodule *is)
 	unsigned long flags;
 
 	write_lock_irqsave(&ioc3_submodules_lock, flags);
-	alloc_id = find_slot((void **)ioc3_submodules, IOC3_MAX_SUBMODULES);
-	if(alloc_id != -1) {
+	if (is->ethernet)
+		if (ioc3_submodules[ETH_ID] == NULL)
+			alloc_id = ETH_ID;
+		else
+			alloc_id = -2;
+	else
+		alloc_id = find_slot((void **)ioc3_submodules, IOC3_MAX_SUBMODULES);
+
+	if (alloc_id >= 0)
 		ioc3_submodules[alloc_id] = is;
-		if(is->ethernet) {
-			if(ioc3_ethernet==NULL)
-				ioc3_ethernet=is;
-			else
-				printk(KERN_WARNING
-				  "IOC3 Ethernet module already registered!\n");
-		}
-	}
 	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
 
 	if(alloc_id == -1) {
@@ -519,6 +536,11 @@ int ioc3_register_submodule(struct ioc3_submodule *is)
 		return -ENOMEM;
 	}
 
+	if (alloc_id == -2) {
+		printk(KERN_WARNING "IOC3 Ethernet module already registered!\n");
+		return -ENODEV;
+	}
+
 	is->id=alloc_id;
 
 	/* Initialize submodule for each IOC3 */
@@ -548,8 +570,6 @@ void ioc3_unregister_submodule(struct ioc3_submodule *is)
 	else
 		printk(KERN_WARNING
 			"IOC3 submodule %s has wrong ID.\n",is->name);
-	if(ioc3_ethernet==is)
-		ioc3_ethernet = NULL;
 	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
 
 	/* Remove submodule for each IOC3 */
@@ -817,9 +837,13 @@ MODULE_DEVICE_TABLE(pci, ioc3_id_table);
 /* Module load */
 static int __devinit ioc3_init(void)
 {
+#ifdef CONFIG_IA64_SGI_SN2
 	if (ia64_platform_is("sn2"))
 		return pci_register_driver(&ioc3_driver);
 	return 0;
+#else
+	return pci_register_driver(&ioc3_driver);
+#endif
 }
 
 /* Module unload */
@@ -841,3 +865,4 @@ EXPORT_SYMBOL_GPL(ioc3_ack);
 EXPORT_SYMBOL_GPL(ioc3_gpcr_set);
 EXPORT_SYMBOL_GPL(ioc3_disable);
 EXPORT_SYMBOL_GPL(ioc3_enable);
+EXPORT_SYMBOL_GPL(ioc3_gpio);
diff --git a/include/linux/ioc3.h b/include/linux/ioc3.h
index 38b286e..4499243 100644
--- a/include/linux/ioc3.h
+++ b/include/linux/ioc3.h
@@ -89,5 +89,7 @@ extern void ioc3_disable(struct ioc3_submodule *, struct ioc3_driver_data *, uns
 extern void ioc3_gpcr_set(struct ioc3_driver_data *, unsigned int);
 /* general ireg writer */
 extern void ioc3_write_ireg(struct ioc3_driver_data *idd, uint32_t value, int reg);
+/* atomically sets/clears GPIO bits */
+extern void ioc3_gpio(struct ioc3_driver_data *, unsigned int, unsigned int);
 
 #endif
-- 
1.5.2.5
