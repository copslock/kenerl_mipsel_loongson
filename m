Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 08:25:59 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:41141 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491946Ab1HXGYt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 08:24:49 +0200
Received: by ywp17 with SMTP id 17so803583ywp.36
        for <multiple recipients>; Tue, 23 Aug 2011 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kSLj+2a2G+UNERFa3vpKoXszqM6KdTNyMF8C3mMs7xg=;
        b=GIj3ecC7zMxhDeCnnhZo4Ru/sI48eYvvRSCrEOx4ty9+4Q2gfdBlXMMYDsLqi2CkgQ
         vkKG/CruWPQoiO8yo4XFuTmfmw+XCpSH0K7N8HYEaszJVNKWBvvWsBsdeWBOg6H/ygG+
         W5vaWatoHlFD5qGCc7SzrDJRKIL1yaTSPawZc=
Received: by 10.236.176.39 with SMTP id a27mr27321322yhm.37.1314167083862;
        Tue, 23 Aug 2011 23:24:43 -0700 (PDT)
Received: from localhost.localdomain ([210.13.118.102])
        by mx.google.com with ESMTPS id f4sm1134483yhn.27.2011.08.23.23.24.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 23 Aug 2011 23:24:43 -0700 (PDT)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     jbarnes@virtuousgeek.org, ralf@linux-mips.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, eyal@mips.com, zenon@mips.com,
        dengcheng.zhu@gmail.com
Subject: [RFC PATCH 3/3] MIPS: PCI: Pass controller's resources to pci_create_bus() in pcibios_scanbus()
Date:   Wed, 24 Aug 2011 14:24:23 +0800
Message-Id: <1314167063-15785-4-git-send-email-dengcheng.zhu@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1314167063-15785-1-git-send-email-dengcheng.zhu@gmail.com>
X-archive-position: 30964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17581

Use the new interface of pci_create_bus() so that system controller's
resources are added to the root bus upon bus creation, thereby avoiding
conflicts with PCI quirks before pcibios_fixup_bus() gets the chance to do
right things in pci_scan_child_bus().

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
---
 arch/mips/pci/pci.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 7473214..a5ff6bc 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -76,11 +76,41 @@ pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
+static struct pci_bus_resource *
+controller_resources(const struct pci_controller *ctrl)
+{
+	struct pci_bus_resource *mem_res, *io_res;
+
+	mem_res = kzalloc(sizeof(struct pci_bus_resource), GFP_KERNEL);
+	if (!mem_res)
+		goto err_out;
+
+	mem_res->res = ctrl->mem_resource;
+	mem_res->flags = 0;
+	INIT_LIST_HEAD(&mem_res->list);
+
+	io_res = kzalloc(sizeof(struct pci_bus_resource), GFP_KERNEL);
+	if (!io_res) {
+		kfree(mem_res);
+		goto err_out;
+	}
+
+	io_res->res = ctrl->io_resource;
+	io_res->flags = 0;
+	list_add(&io_res->list, &mem_res->list);
+
+	return mem_res;
+err_out:
+	printk(KERN_ERR "Can't allocate PCI bus resource.\n");
+	return NULL;
+}
+
 static void __devinit pcibios_scanbus(struct pci_controller *hose)
 {
 	static int next_busno;
 	static int need_domain_info;
 	struct pci_bus *bus;
+	struct pci_bus_resource *bus_res;
 
 	if (!hose->iommu)
 		PCI_DMA_BUS_IS_PHYS = 1;
@@ -88,7 +118,13 @@ static void __devinit pcibios_scanbus(struct pci_controller *hose)
 	if (hose->get_busno && pci_probe_only)
 		next_busno = (*hose->get_busno)();
 
-	bus = pci_scan_bus(next_busno, hose->pci_ops, hose);
+	bus_res = controller_resources(hose);
+	bus = pci_create_bus(NULL, next_busno, hose->pci_ops, hose, bus_res);
+	if (bus) {
+		bus->subordinate = pci_scan_child_bus(bus);
+		pci_bus_add_devices(bus);
+	}
+
 	hose->bus = bus;
 
 	need_domain_info = need_domain_info || hose->index;
-- 
1.7.1
