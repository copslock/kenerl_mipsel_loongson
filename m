Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Nov 2010 22:38:27 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:1037 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492155Ab0KLViV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Nov 2010 22:38:21 +0100
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id F245E2436C;
        Fri, 12 Nov 2010 13:37:32 -0800 (PST)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] arch/mips: Use printf extension %pR for struct resource
Date:   Fri, 12 Nov 2010 13:37:52 -0800
Message-Id: <a8e243510ee279b590183aa48f61d7b39cafb37d.1289597644.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.1.g432b3.dirty
In-Reply-To: <cover.1289597644.git.joe@perches.com>
References: <cover.1289597644.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Using %pR standardizes the struct resource output.

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/txx9/generic/pci.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/mips/txx9/generic/pci.c b/arch/mips/txx9/generic/pci.c
index 9a0be81..c609e7b 100644
--- a/arch/mips/txx9/generic/pci.c
+++ b/arch/mips/txx9/generic/pci.c
@@ -213,11 +213,8 @@ txx9_alloc_pci_controller(struct pci_controller *pcic,
 
 	pcic->mem_offset = 0;	/* busaddr == physaddr */
 
-	printk(KERN_INFO "PCI: IO 0x%08llx-0x%08llx MEM 0x%08llx-0x%08llx\n",
-	       (unsigned long long)pcic->mem_resource[1].start,
-	       (unsigned long long)pcic->mem_resource[1].end,
-	       (unsigned long long)pcic->mem_resource[0].start,
-	       (unsigned long long)pcic->mem_resource[0].end);
+	printk(KERN_INFO "PCI: IO %pR MEM %pR\n",
+	       &pcic->mem_resource[1], &pcic->mem_resource[0]);
 
 	/* register_pci_controller() will request MEM resource */
 	release_resource(&pcic->mem_resource[0]);
-- 
1.7.3.1.g432b3.dirty
