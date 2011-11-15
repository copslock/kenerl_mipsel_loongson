Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 20:54:47 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37809 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903731Ab1KOTyk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 Nov 2011 20:54:40 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pAFJscqH005839;
        Tue, 15 Nov 2011 19:54:38 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pAFJscnn005836;
        Tue, 15 Nov 2011 19:54:38 GMT
Date:   Tue, 15 Nov 2011 19:54:38 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2 01/11] MIPS: BCM63XX: set default pci cache line size.
Message-ID: <20111115195438.GF26141@linux-mips.org>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
 <1320430175-13725-2-git-send-email-mbizon@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320430175-13725-2-git-send-email-mbizon@freebox.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12755

On Fri, Nov 04, 2011 at 07:09:25PM +0100, Maxime Bizon wrote:

> +	pci_cache_line_size = 4;
> +

Presumably because the CPU cache line size is 16 bytes?  On MIPS we don't
set pci_dfl_cache_line_size; a patch (only compile tested) to pick a sane
default is below.

Does this work for you?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/pci/pci.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 41af7fa..8ac0d48 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -4,8 +4,11 @@
  * Free Software Foundation;  either version 2 of the  License, or (at your
  * option) any later version.
  *
- * Copyright (C) 2003, 04 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2003, 04, 11 Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2011 Wind River Systems,
+ *   written by Ralf Baechle (ralf@linux-mips.org)
  */
+#include <linux/bug.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
@@ -14,6 +17,8 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
+#include <asm/cpu-info.h>
+
 /*
  * Indicate whether we respect the PCI setup left by the firmware.
  *
@@ -150,10 +155,32 @@ out:
 	       "Skipping PCI bus scan due to resource conflict\n");
 }
 
+static void __init pcibios_set_cache_line_size(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+	unsigned int lsize;
+
+	/*
+	 * Set PCI cacheline size to that of the highest level in the
+	 * cache hierarchy.
+	 */
+	lsize = c->dcache.linesz;
+	lsize = c->scache.linesz ? : lsize;
+	lsize = c->tcache.linesz ? : lsize;
+
+	BUG_ON(!lsize);
+
+	pci_dfl_cache_line_size = lsize >> 2;
+
+	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+}
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose;
 
+	pcibios_set_cache_line_size();
+
 	/* Scan all of the recorded PCI controllers.  */
 	for (hose = hose_head; hose; hose = hose->next)
 		pcibios_scanbus(hose);
