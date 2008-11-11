Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:16:16 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:44967 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23619955AbYKKXQN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:16:13 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id F052638F995C;
	Wed, 12 Nov 2008 00:16:07 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, florian@openwrt.org
Subject: [PATCH] define io_map_base for rc32434's PCI controller
Date:	Wed, 12 Nov 2008 00:16:04 +0100
Message-Id: <1226445364-5402-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

The code is rather based on trial-and-error than knowledge. Verified Via
Rhine functionality in PIO as well as MMIO mode.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
Tested-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/pci/pci-rc32434.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/pci/pci-rc32434.c b/arch/mips/pci/pci-rc32434.c
index 1c2821e..71f7d27 100644
--- a/arch/mips/pci/pci-rc32434.c
+++ b/arch/mips/pci/pci-rc32434.c
@@ -205,6 +205,8 @@ static int __init rc32434_pcibridge_init(void)
 
 static int __init rc32434_pci_init(void)
 {
+	void __iomem *io_map_base;
+
 	pr_info("PCI: Initializing PCI\n");
 
 	ioport_resource.start = rc32434_res_pci_io1.start;
@@ -212,6 +214,15 @@ static int __init rc32434_pci_init(void)
 
 	rc32434_pcibridge_init();
 
+	io_map_base = ioremap(rc32434_res_pci_io1.start,
+		rc32434_res_pci_io1.end - rc32434_res_pci_io1.start + 1);
+
+	if (!io_map_base)
+		return -ENOMEM;
+
+	rc32434_controller.io_map_base =
+		(unsigned long)io_map_base - rc32434_res_pci_io1.start;
+
 	register_pci_controller(&rc32434_controller);
 	rc32434_sync();
 
-- 
1.5.6.4
