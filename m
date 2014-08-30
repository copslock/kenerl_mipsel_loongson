Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:06:14 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:64820 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007491AbaH3CFbzr3sn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:31 +0200
Received: by mail-lb0-f172.google.com with SMTP id 10so3481714lbg.17
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/g1hx9L+XZGG9j6vBmEon4Swtzd8a2o5JEM2tTYxMsU=;
        b=B+Hjp118EucSLLS4b3VM2Q+s7ayG+RaotrdNBdO7z3R7jvvefp2eMLxogWcEVKJWnz
         m5xiXc3Cx1REkgIzBIb2qAFniakOFrMLKRBow+6vl33SW1Si9HREtWhvb41s4yPt96u9
         7MrshCG9U0hyDMZ1P/bU4JSltvs/L2vO8fg06/R3pHxWC2SVNZrFfO27+2iEEdVif1++
         QaPoo4APmr2fSbK6VGSFLH14Z6Rly4RvU5DmK3lrkZnXTvfmA3tyK7xpuXJzOWc88Qth
         cqmKLQ5W319ug7G1iCdHu6N9XiTQ1EUSLL4/Gr9x1N0oHQQyl4UcI33bhB2HAnTUQy4T
         3Y9Q==
X-Received: by 10.152.25.136 with SMTP id c8mr14953580lag.64.1409364326433;
        Fri, 29 Aug 2014 19:05:26 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:25 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 3/5] MIPS: pci-ar7{1x,24}x: remove odd locking in PCI config space access code
Date:   Sat, 30 Aug 2014 06:06:26 +0400
Message-Id: <1409364388-7108-4-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Caller (generic PCI code) already do proper locking so no need to add
another one here.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Cc: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-ar71xx.c | 13 -------------
 arch/mips/pci/pci-ar724x.c | 23 -----------------------
 2 files changed, 36 deletions(-)

diff --git a/arch/mips/pci/pci-ar71xx.c b/arch/mips/pci/pci-ar71xx.c
index d471a26..2b534ae 100644
--- a/arch/mips/pci/pci-ar71xx.c
+++ b/arch/mips/pci/pci-ar71xx.c
@@ -50,7 +50,6 @@
 
 struct ar71xx_pci_controller {
 	void __iomem *cfg_base;
-	spinlock_t lock;
 	int irq;
 	int irq_base;
 	struct pci_controller pci_ctrl;
@@ -182,7 +181,6 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 {
 	struct ar71xx_pci_controller *apc = pci_bus_to_ar71xx_controller(bus);
 	void __iomem *base = apc->cfg_base;
-	unsigned long flags;
 	u32 data;
 	int err;
 	int ret;
@@ -190,8 +188,6 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	ret = PCIBIOS_SUCCESSFUL;
 	data = ~0;
 
-	spin_lock_irqsave(&apc->lock, flags);
-
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
 				     AR71XX_PCI_CFG_CMD_READ);
 	if (err)
@@ -199,8 +195,6 @@ static int ar71xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		data = __raw_readl(base + AR71XX_PCI_REG_CFG_RDDATA);
 
-	spin_unlock_irqrestore(&apc->lock, flags);
-
 	*value = (data >> (8 * (where & 3))) & ar71xx_pci_read_mask[size & 7];
 
 	return ret;
@@ -211,15 +205,12 @@ static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 {
 	struct ar71xx_pci_controller *apc = pci_bus_to_ar71xx_controller(bus);
 	void __iomem *base = apc->cfg_base;
-	unsigned long flags;
 	int err;
 	int ret;
 
 	value = value << (8 * (where & 3));
 	ret = PCIBIOS_SUCCESSFUL;
 
-	spin_lock_irqsave(&apc->lock, flags);
-
 	err = ar71xx_pci_set_cfgaddr(bus, devfn, where, size,
 				     AR71XX_PCI_CFG_CMD_WRITE);
 	if (err)
@@ -227,8 +218,6 @@ static int ar71xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	else
 		__raw_writel(value, base + AR71XX_PCI_REG_CFG_WRDATA);
 
-	spin_unlock_irqrestore(&apc->lock, flags);
-
 	return ret;
 }
 
@@ -360,8 +349,6 @@ static int ar71xx_pci_probe(struct platform_device *pdev)
 	if (!apc)
 		return -ENOMEM;
 
-	spin_lock_init(&apc->lock);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
 	apc->cfg_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(apc->cfg_base))
diff --git a/arch/mips/pci/pci-ar724x.c b/arch/mips/pci/pci-ar724x.c
index 785b265..b7a6fcb 100644
--- a/arch/mips/pci/pci-ar724x.c
+++ b/arch/mips/pci/pci-ar724x.c
@@ -9,7 +9,6 @@
  *  by the Free Software Foundation.
  */
 
-#include <linux/spinlock.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/module.h>
@@ -48,8 +47,6 @@ struct ar724x_pci_controller {
 	bool bar0_is_cached;
 	u32  bar0_value;
 
-	spinlock_t lock;
-
 	struct pci_controller pci_controller;
 	struct resource io_res;
 	struct resource mem_res;
@@ -75,7 +72,6 @@ pci_bus_to_ar724x_controller(struct pci_bus *bus)
 static int ar724x_pci_local_write(struct ar724x_pci_controller *apc,
 				  int where, int size, u32 value)
 {
-	unsigned long flags;
 	void __iomem *base;
 	u32 data;
 	int s;
@@ -86,8 +82,6 @@ static int ar724x_pci_local_write(struct ar724x_pci_controller *apc,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	base = apc->crp_base;
-
-	spin_lock_irqsave(&apc->lock, flags);
 	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
@@ -105,14 +99,12 @@ static int ar724x_pci_local_write(struct ar724x_pci_controller *apc,
 		data = value;
 		break;
 	default:
-		spin_unlock_irqrestore(&apc->lock, flags);
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
 	__raw_writel(data, base + (where & ~3));
 	/* flush write */
 	__raw_readl(base + (where & ~3));
-	spin_unlock_irqrestore(&apc->lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -121,7 +113,6 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 			    int size, uint32_t *value)
 {
 	struct ar724x_pci_controller *apc;
-	unsigned long flags;
 	void __iomem *base;
 	u32 data;
 
@@ -133,8 +124,6 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	base = apc->devcfg_base;
-
-	spin_lock_irqsave(&apc->lock, flags);
 	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
@@ -153,13 +142,9 @@ static int ar724x_pci_read(struct pci_bus *bus, unsigned int devfn, int where,
 	case 4:
 		break;
 	default:
-		spin_unlock_irqrestore(&apc->lock, flags);
-
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
-	spin_unlock_irqrestore(&apc->lock, flags);
-
 	if (where == PCI_BASE_ADDRESS_0 && size == 4 &&
 	    apc->bar0_is_cached) {
 		/* use the cached value */
@@ -175,7 +160,6 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			     int size, uint32_t value)
 {
 	struct ar724x_pci_controller *apc;
-	unsigned long flags;
 	void __iomem *base;
 	u32 data;
 	int s;
@@ -209,8 +193,6 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 	}
 
 	base = apc->devcfg_base;
-
-	spin_lock_irqsave(&apc->lock, flags);
 	data = __raw_readl(base + (where & ~3));
 
 	switch (size) {
@@ -228,15 +210,12 @@ static int ar724x_pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 		data = value;
 		break;
 	default:
-		spin_unlock_irqrestore(&apc->lock, flags);
-
 		return PCIBIOS_BAD_REGISTER_NUMBER;
 	}
 
 	__raw_writel(data, base + (where & ~3));
 	/* flush write */
 	__raw_readl(base + (where & ~3));
-	spin_unlock_irqrestore(&apc->lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -380,8 +359,6 @@ static int ar724x_pci_probe(struct platform_device *pdev)
 	if (apc->irq < 0)
 		return -EINVAL;
 
-	spin_lock_init(&apc->lock);
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_IO, "io_base");
 	if (!res)
 		return -EINVAL;
-- 
1.8.1.5
