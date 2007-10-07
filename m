Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2007 20:37:55 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:19618 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20024178AbXJGThq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Oct 2007 20:37:46 +0100
Received: (qmail invoked by alias); 07 Oct 2007 19:37:40 -0000
Received: from p548B21B5.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.33.181]
  by mail.gmx.net (mp056) with SMTP; 07 Oct 2007 21:37:40 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19HcSlVM+5HxdRveiAcSyc09W5Ig8wnXG3QlwWDTX
	olc5qZvLhNukPS
Message-ID: <47093583.6010407@gmx.de>
Date:	Sun, 07 Oct 2007 21:37:39 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: [PATCH] arch/mips/pci/ioc3.c 
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Hi

I tried to use the mainline ioc3 meta driver with my Octane 
and got it working. But i needed to change a dual_irq test,
which i think would not work with ia64.

Maybe this is a solution.

This is a Patch against the MIPS version.

It does the job on my Octane

Signed-off-by: Johannes Dickgreber tanzy@gmx.de
---

Changed:

Ethernet submodule is always submodule NR 0

expected in subdrivers if idd->active[id] is 1
  ioc3_submodules[id] is a valid ioc3_submodule
  In the ethernet submodule
      ioc3_submodules[0]->intr is a valid interrupt routine
  In other submodules, if ioc3_submodules[id]->irq_mask is set
      ioc3_submodules[id]->intr is a valid interrupt routine

kmalloc to kzalloc

all IRQ are cleared in the probe routine

--- linux-2.6.22.6-mips20070902-ip30/arch/mips/pci/ioc3.c	2007-09-12 21:54:59 +0200
+++ linux-octane-2/arch/mips/pci/ioc3.c	2007-10-07 20:34:37 +0200
@@ -26,8 +26,9 @@ static LIST_HEAD(ioc3_devices);
 static int ioc3_counter;
 static DECLARE_RWSEM(ioc3_devices_rwsem);
 
+/* ethernet submodule is always 0 */
+#define ETH_ID 0
 static struct ioc3_submodule *ioc3_submodules[IOC3_MAX_SUBMODULES];
-static struct ioc3_submodule *ioc3_ethernet;
 static DEFINE_RWLOCK(ioc3_submodules_lock);
 
 
@@ -426,30 +427,29 @@ static irqreturn_t ioc3_intr_io(int irq,
 {
 	unsigned long flags;
 	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
-	int handled = 1, id;
+	int handled = 0, id;
 	unsigned int pending;
 
 	read_lock_irqsave(&ioc3_submodules_lock, flags);
-
-	if (!idd->dual_irq && readb(idd->vma->eisr))	/* send Ethernet IRQ to the driver */
-		if (ioc3_ethernet && idd->active[ioc3_ethernet->id] &&
-						 ioc3_ethernet->intr)
-			handled = handled && !ioc3_ethernet->intr(ioc3_ethernet,
-								  idd, 0);
-
-	pending = get_pending_intrs(idd);	/* look at the IO IRQs */
-	for (id = 0; id < IOC3_MAX_SUBMODULES; id++)
-		if (idd->active[id] && ioc3_submodules[id] &&
-		    (pending & ioc3_submodules[id]->irq_mask) &&
-		     ioc3_submodules[id]->intr)
-		{
-			write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IEC);
-			if (!ioc3_submodules[id]->intr(ioc3_submodules[id], idd,
-						       (pending &
-							ioc3_submodules[id]->irq_mask)))
-				pending &=~ ioc3_submodules[id]->irq_mask;
-			write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IES);
-		}
+	/* send Ethernet IRQ to the driver */
+	if (idd->active[ETH_ID] && !idd->dual_irq)
+		if (readl(&idd->vma->eisr))
+			handled = !ioc3_submodules[ETH_ID]->intr(ioc3_submodules[ETH_ID], idd, 0);
+
+	/* look at the IO IRQs */
+	pending = get_pending_intrs(idd);
+	for (id = 1; id < IOC3_MAX_SUBMODULES; id++)
+		if (idd->active[id])
+			if (pending & ioc3_submodules[id]->irq_mask) {
+				write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IEC);
+				if (!ioc3_submodules[id]->intr(ioc3_submodules[id], idd,
+								(pending &
+								ioc3_submodules[id]->irq_mask))) {
+					pending &= ~ioc3_submodules[id]->irq_mask;
+					handled = 1;
+				}	
+				write_ireg(idd, ioc3_submodules[id]->irq_mask, IOC3_W_IES);
+			}
 	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
 
 	if (pending) {
@@ -459,6 +459,7 @@ static irqreturn_t ioc3_intr_io(int irq,
 		write_ireg(idd, pending, IOC3_W_IEC);
 		handled = 1;
 	}
+
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -466,15 +467,13 @@ static irqreturn_t ioc3_intr_eth(int irq
 {
 	unsigned long flags;
 	struct ioc3_driver_data *idd = (struct ioc3_driver_data *)arg;
-	int handled = 1;
-
-	if (!idd->dual_irq)
-		return IRQ_NONE;
+	int handled = 0;
 
 	read_lock_irqsave(&ioc3_submodules_lock, flags);
-	if (ioc3_ethernet && idd->active[ioc3_ethernet->id] && ioc3_ethernet->intr)
-		handled = handled && !ioc3_ethernet->intr(ioc3_ethernet, idd, 0);
+	if (idd->active[ETH_ID] && idd->dual_irq)
+		handled = !ioc3_submodules[ETH_ID]->intr(ioc3_submodules[ETH_ID], idd, 0);
 	read_unlock_irqrestore(&ioc3_submodules_lock, flags);
+
 	return handled ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -524,7 +523,7 @@ void ioc3_gpio(struct ioc3_driver_data *
 static int find_slot(void **tab, int max)
 {
 	int i;
-	for (i = 0; i < max; i++)
+	for (i = 1; i < max; i++)
 		if (!(tab[i]))
 			return i;
 	return -1;
@@ -538,23 +537,26 @@ int ioc3_register_submodule(struct ioc3_
 	unsigned long flags;
 
 	write_lock_irqsave(&ioc3_submodules_lock, flags);
-	alloc_id = find_slot((void **)ioc3_submodules, IOC3_MAX_SUBMODULES);
-	if (alloc_id != -1) {
-		ioc3_submodules[alloc_id] = is;
-		if (is->ethernet) {
-			if (ioc3_ethernet == NULL)
-				ioc3_ethernet = is;
-			else
-				printk(KERN_WARNING
-				       "IOC3 Ethernet module already registered!\n");
-		}
-	}
+	if (is->ethernet)
+		if (ioc3_submodules[ETH_ID] == NULL)
+			alloc_id = ETH_ID;
+		else
+			alloc_id = -2;
+	else
+		alloc_id = find_slot((void **)ioc3_submodules, IOC3_MAX_SUBMODULES);
+		
+	if (alloc_id >= 0)
+		ioc3_submodules[alloc_id] = is;		
 	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
 
 	if (alloc_id == -1) {
 		printk(KERN_WARNING "Increase IOC3_MAX_SUBMODULES!\n");
 		return -ENOMEM;
 	}
+	if (alloc_id == -2) { 
+		printk(KERN_WARNING "IOC3 Ethernet module already registered!\n");
+		return -ENODEV;
+	}
 
 	is->id=alloc_id;
 
@@ -585,8 +587,6 @@ void ioc3_unregister_submodule(struct io
 	else
 		printk(KERN_WARNING "IOC3 submodule %s has wrong ID.\n",
 				    is->name);
-	if (ioc3_ethernet == is)
-		ioc3_ethernet = NULL;
 	write_unlock_irqrestore(&ioc3_submodules_lock, flags);
 
 	/* Remove submodule for each IOC3 */
@@ -670,7 +670,7 @@ static int ioc3_probe(struct pci_dev *pd
 	}
 
 	/* Set up per-IOC3 data */
-	idd = kmalloc(sizeof(struct ioc3_driver_data), GFP_KERNEL);
+	idd = kzalloc(sizeof(struct ioc3_driver_data), GFP_KERNEL);
 	if (!idd) {
 		printk(KERN_WARNING
 		       "%s: Failed to allocate IOC3 data for pci_dev %s.\n",
@@ -678,7 +678,7 @@ static int ioc3_probe(struct pci_dev *pd
 		ret = -ENODEV;
 		goto out_idd;
 	}
-	memset(idd, 0, sizeof(struct ioc3_driver_data));
+
 	spin_lock_init(&idd->ir_lock);
 	spin_lock_init(&idd->gpio_lock);
 	idd->pdev = pdev;
@@ -733,16 +733,18 @@ static int ioc3_probe(struct pci_dev *pd
 	pci_write_config_dword(pdev, PCI_COMMAND,
 			       pcmd | PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
 
+	/* Clear IRQs */
 	write_ireg(idd, ~0, IOC3_W_IEC);
 	writel(~0, &idd->vma->sio_ir);
 
+	writel(0, &idd->vma->emcr);		/* Shutup */
+	writel(0, &idd->vma->eier);		/* Disable interrupts */
+	(void) readl(&idd->vma->eier);		/* Flush */
+
 	/* Set up IRQs */
 	if (idd->class == IOC3_CLASS_BASE_IP30 ||
 	    idd->class == IOC3_CLASS_BASE_IP27) {
 
-		writel(0, &idd->vma->eier);
-		writel(~0, &idd->vma->eisr);
-
 		idd->dual_irq = 1;
 		if (!request_irq(pdev->irq, ioc3_intr_eth, IRQF_SHARED,
 				 "ioc3-eth", (void *)idd)) {
