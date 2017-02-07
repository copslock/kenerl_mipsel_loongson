Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:15:51 +0100 (CET)
Received: from smtp.gentoo.org ([140.211.166.183]:34048 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992160AbdBGGOMvkC7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Feb 2017 07:14:12 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 6E8383416A3;
        Tue,  7 Feb 2017 06:14:06 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Stanislaw Skowronek <skylark@unaligned.org>
Subject: [PATCH 04/12] MIPS: PCI: Add BRIDGE 'pre_enable' hook
Date:   Tue,  7 Feb 2017 01:13:48 -0500
Message-Id: <20170207061356.8270-5-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Add a hook for a 'pre_enable' function in struct pci_controller in
arch/mips/include/asm/pci.h and arch/mips/pci/pci-legacy.c.  This is
used to do any needed housekeeping on the BRIDGE/XBRIDGE ASICs prior
to PCI detection, such setting up DevIO windows or applying any known
BRIDGE WARs.  This change originates from the earliest days of the
IP30 patchset by Stanislaw Skowronek.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Cc: Stanislaw Skowronek <skylark@unaligned.org>
---
 arch/mips/include/asm/pci.h |  3 +++
 arch/mips/pci/pci-legacy.c  | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 30d1129d8624..0f1e381a79e3 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -48,6 +48,9 @@ struct pci_controller {
 	unsigned int need_domain_info;
 #endif
 
+	/* BRIDGE/XBRIDGE may need to config things before bringup */
+	int (*pre_enable)(struct pci_controller *, struct pci_dev *, int);
+
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
 	int (*get_busno)(void);
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index 98f36ed8f7da..68268bbb15b8 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2003, 04, 11 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 2011 Wind River Systems,
  *   written by Ralf Baechle (ralf@linux-mips.org)
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@unaligned.org>
  */
 #include <linux/bug.h>
 #include <linux/kernel.h>
@@ -232,6 +233,7 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 	u16 cmd, old_cmd;
 	int idx;
 	struct resource *r;
+	struct pci_controller *hose = (struct pci_controller *)dev->sysdata;
 
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 	old_cmd = cmd;
@@ -240,6 +242,15 @@ static int pcibios_enable_resources(struct pci_dev *dev, int mask)
 		if (!(mask & (1 << idx)))
 			continue;
 
+		/*
+		 * Some devices, like BRIDGE/XBRIDGE, may need to do a little
+		 * housekeeping prior to the generic code setting up the PCI
+		 * resources.
+		 */
+		if (hose->pre_enable)
+			if (hose->pre_enable(hose, dev, idx) < 0)
+				return -EINVAL;
+
 		r = &dev->resource[idx];
 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
 			continue;
-- 
2.11.1
