Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2014 04:06:30 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:55529 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007492AbaH3CFdsdrrE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Aug 2014 04:05:33 +0200
Received: by mail-la0-f44.google.com with SMTP id hz20so3629962lab.31
        for <multiple recipients>; Fri, 29 Aug 2014 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DvEWYWc7/Cvq+cH0/cElhe2rV1W6OvVTDtyCJwBL5EM=;
        b=EviCpaK1I8Uy3dd7BvRq9XmrQ3wHTqFMR7yaWb6H+IuNGCqmpV7aK/NstjhdyhPBRT
         WPZC7KDB5gHlBm0z/Mp6k7O47V1RR2IYzAzEzn0Y7YTsVdX+t1jzy0D29hRxbpnil4Fh
         /Y1JGguPuOT9rLLiBnGb7pSdaCQBkjh+mlzSQnSTQ1Q2uBe6NY0tCuj6klVlGbVpQ6/t
         EdzGBKIztBJl3kXZKW419QAXKHhP2tiP9yED2jIbwYK2iHZkc1OoSum1qjirzH9aDjvn
         ER5bn6WLI5Y2VEgAMKOxjSv0ZPB+4wXbLhQxX6IHiK5maA+IulWdlRbSKdiMQfmovZnu
         /ddA==
X-Received: by 10.152.6.40 with SMTP id x8mr14500826lax.18.1409364328389;
        Fri, 29 Aug 2014 19:05:28 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([188.113.6.134])
        by mx.google.com with ESMTPSA id l10sm2512262lbc.3.2014.08.29.19.05.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2014 19:05:27 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 4/5] MIPS: pci-rt3883: remove odd locking in PCI config space access code
Date:   Sat, 30 Aug 2014 06:06:27 +0400
Message-Id: <1409364388-7108-5-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1409364388-7108-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42340
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
another one here. Local PCI read/write functions are never called
simultaneously, also they do not require synchronization with the PCI
controller ops, since they are used before the controller registration.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Linux MIPS <linux-mips@linux-mips.org>
Cc: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/pci/pci-rt3883.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 72919ae..0bcc0b1 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -61,7 +61,6 @@
 
 struct rt3883_pci_controller {
 	void __iomem *base;
-	spinlock_t lock;
 
 	struct device_node *intc_of_node;
 	struct irq_domain *irq_domain;
@@ -111,10 +110,8 @@ static u32 rt3883_pci_read_cfg32(struct rt3883_pci_controller *rpc,
 
 	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
 
-	spin_lock_irqsave(&rpc->lock, flags);
 	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
 	ret = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
-	spin_unlock_irqrestore(&rpc->lock, flags);
 
 	return ret;
 }
@@ -128,10 +125,8 @@ static void rt3883_pci_write_cfg32(struct rt3883_pci_controller *rpc,
 
 	address = rt3883_pci_get_cfgaddr(bus, slot, func, reg);
 
-	spin_lock_irqsave(&rpc->lock, flags);
 	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
 	rt3883_pci_w32(rpc, val, RT3883_PCI_REG_CFGDATA);
-	spin_unlock_irqrestore(&rpc->lock, flags);
 }
 
 static void rt3883_pci_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -252,10 +247,8 @@ static int rt3883_pci_config_read(struct pci_bus *bus, unsigned int devfn,
 	address = rt3883_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
 					 PCI_FUNC(devfn), where);
 
-	spin_lock_irqsave(&rpc->lock, flags);
 	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
 	data = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
-	spin_unlock_irqrestore(&rpc->lock, flags);
 
 	switch (size) {
 	case 1:
@@ -288,7 +281,6 @@ static int rt3883_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 	address = rt3883_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
 					 PCI_FUNC(devfn), where);
 
-	spin_lock_irqsave(&rpc->lock, flags);
 	rt3883_pci_w32(rpc, address, RT3883_PCI_REG_CFGADDR);
 	data = rt3883_pci_r32(rpc, RT3883_PCI_REG_CFGDATA);
 
@@ -307,7 +299,6 @@ static int rt3883_pci_config_write(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	rt3883_pci_w32(rpc, data, RT3883_PCI_REG_CFGDATA);
-	spin_unlock_irqrestore(&rpc->lock, flags);
 
 	return PCIBIOS_SUCCESSFUL;
 }
-- 
1.8.1.5
