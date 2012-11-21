Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2012 21:35:10 +0100 (CET)
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:38582 "EHLO
        viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828061Ab2KUUfIdC7XE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2012 21:35:08 +0100
Received: by viridian.itc.virginia.edu (Postfix, from userid 1249)
        id C8F0780142; Wed, 21 Nov 2012 15:35:00 -0500 (EST)
From:   Bill Pemberton <wfp5p@virginia.edu>
To:     gregkh@linuxfoundation.org
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 2/9] mips/PCI: Remove CONFIG_HOTPLUG ifdefs
Date:   Wed, 21 Nov 2012 15:34:53 -0500
Message-Id: <1353530100-728-3-git-send-email-wfp5p@virginia.edu>
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
X-archive-position: 35073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wfp5p@virginia.edu
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: linux-mips@linux-mips.org
Cc: devicetree-discuss@lists.ozlabs.org
---
 arch/mips/pci/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 04e35bc..4040416 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,10 +313,8 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
-- 
1.8.0
