Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 07:15:04 +0100 (CET)
Received: from dev.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:51857
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992078AbdBGGOLZGcWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 07:14:11 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 37B1D34169B;
        Tue,  7 Feb 2017 06:14:05 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 02/12] MIPS: IP27: Add pcibr.h header for IP27
Date:   Tue,  7 Feb 2017 01:13:46 -0500
Message-Id: <20170207061356.8270-3-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170207061356.8270-1-kumba@gentoo.org>
References: <20170207061356.8270-1-kumba@gentoo.org>
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56676
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

Add a new header 'pcibr.h' to arch/mips/include/asm/mach-ip27 which
contains IP27-specific definitions for the BRIDGE ASIC used to connect
PCI devices to the Crosstalk bus.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/include/asm/mach-ip27/pcibr.h | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/mips/include/asm/mach-ip27/pcibr.h b/arch/mips/include/asm/mach-ip27/pcibr.h
new file mode 100644
index 000000000000..6664843c30f9
--- /dev/null
+++ b/arch/mips/include/asm/mach-ip27/pcibr.h
@@ -0,0 +1,50 @@
+/*
+ * Definitions for PCI bridges in IP27.  Derived from pcibr.h in the
+ * IP30 port.
+ *
+ * Copyright (C) 2004-2007 Stanislaw Skowronek <skylark@unaligned.org>
+ * Copyright (C) 2015-2016 Joshua Kinard <kumba@gentoo.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef __ASM_MACH_IP27_PCIBR_H
+#define __ASM_MACH_IP27_PCIBR_H
+
+#include <asm/pci/bridge.h>
+#include <asm/mach-ip27/irq.h>
+
+/* Xtalk */
+#define PCIBR_OFFSET_MEM	0x200000
+#define PCIBR_OFFSET_IO		0xa00000
+#define PCIBR_OFFSET_END	0xc00000
+
+/*
+ * This is how XIO sees HUB's PI_INT_PEND_MOD register.
+ */
+#define PCIBR_XIO_SEES_HUB	0x01800090
+
+/*
+ * Max # of PCI buses we can handle; ie, max #PCI bridges.
+ */
+#define PCIBR_MAX_NUM_PCIBUS	40
+
+/*
+ * Max # of PCI devices (like scsi controllers) we handle on a bus.
+ */
+#define PCIBR_MAX_DEV_PCIBUS	8
+
+/*
+ * Used by ip27-bridge.c and ip27-irq.c.
+ */
+#define PCIBR_MAX_BUS_X_DEV	(PCIBR_MAX_NUM_PCIBUS * PCIBR_MAX_DEV_PCIBUS)
+extern struct bridge_controller *irq_to_bridge[PCIBR_MAX_BUS_X_DEV];
+extern u32 irq_to_slot[PCIBR_MAX_BUS_X_DEV];
+
+/* XXX: Temporary until IP27 "mega update". */
+extern int request_bridge_irq(struct bridge_controller *bc);
+
+#endif /* __ASM_MACH_IP27_PCIBR_H */
+
-- 
2.11.1
