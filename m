Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 08:25:06 +0200 (CEST)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:46886 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab1HXGYm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 08:24:42 +0200
Received: by yic13 with SMTP id 13so809847yic.36
        for <multiple recipients>; Tue, 23 Aug 2011 23:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oQhGMEtV4oStccPP9ahvbwq6IrsL3qxwSAd2dDHURjc=;
        b=yBg4wEgh25u++1IdHJY8ud12ictw3CDCkeMFiIeuIFr7qsAmt3+ynxUlM+vae5SGi8
         VjZVAbCY5DnBww2Wjb6/WRW4sZOudzoeg/bB9seTTLzLJeNbJm3BnHSHgDFjRH5usVrr
         VFYkO+lAvci4Hx0Y5/J09gYajermEW4n+7G1Q=
Received: by 10.236.23.6 with SMTP id u6mr27871007yhu.20.1314167076865;
        Tue, 23 Aug 2011 23:24:36 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id f4sm1134483yhn.27.2011.08.23.23.24.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 23:24:34 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, ralf@linux-mips.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [RFC PATCH 1/3] MIPS: PCI: Use pci_bus_remove_resources()/pci_bus_add_resource() to set up root resources
Date:   Wed, 24 Aug 2011 14:24:21 +0800
Message-Id: <1314167063-15785-2-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 30962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17578

Use this new style (instead of filling in the pci_bus->resource[] array
directly) to hide some ugly implementation details.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/pci/pci.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 33bba7b..7473214 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -261,6 +261,14 @@ static void pcibios_fixup_device_resources(struct pci_dev *dev,
 	}
 }
 
+static void __devinit
+pcibios_setup_root_resources(struct pci_bus *bus, struct pci_controller *ctrl)
+{
+	pci_bus_remove_resources(bus);
+	pci_bus_add_resource(bus, ctrl->io_resource, 0);
+	pci_bus_add_resource(bus, ctrl->mem_resource, 0);
+}
+
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	/* Propagate hose info into the subordinate devices.  */
@@ -270,8 +278,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	struct pci_dev *dev = bus->self;
 
 	if (!dev) {
-		bus->resource[0] = hose->io_resource;
-		bus->resource[1] = hose->mem_resource;
+		pcibios_setup_root_resources(bus, hose);
 	} else if (pci_probe_only &&
 		   (dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		pci_read_bridge_bases(bus);
-- 
1.7.1
