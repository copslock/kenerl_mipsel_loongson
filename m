Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:38:01 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44847 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831301AbaA0U2DIVkzt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:28:03 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 52/58] MIPS: malta: spaces.h: Add spaces.h file for Malta (EVA)
Date:   Mon, 27 Jan 2014 20:19:39 +0000
Message-ID: <1390853985-14246-53-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_27_58
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Add a spaces.h file for Malta to override certain memory macros
when operating in EVA mode.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/mach-malta/spaces.h | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-malta/spaces.h

diff --git a/arch/mips/include/asm/mach-malta/spaces.h b/arch/mips/include/asm/mach-malta/spaces.h
new file mode 100644
index 0000000..d7e5497
--- /dev/null
+++ b/arch/mips/include/asm/mach-malta/spaces.h
@@ -0,0 +1,46 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2014 Imagination Technologies Ltd.
+ */
+
+#ifndef _ASM_MALTA_SPACES_H
+#define _ASM_MALTA_SPACES_H
+
+#ifdef CONFIG_EVA
+
+/*
+ * Traditional Malta Board Memory Map for EVA
+ *
+ * 0x00000000 - 0x0fffffff: 1st RAM region, 256MB
+ * 0x10000000 - 0x1bffffff: GIC and CPC Control Registers
+ * 0x1c000000 - 0x1fffffff: I/O And Flash
+ * 0x20000000 - 0x7fffffff: 2nd RAM region, 1.5GB
+ * 0x80000000 - 0xffffffff: Physical memory aliases to 0x0 (2GB)
+ *
+ * The kernel is still located in 0x80000000(kseg0). However,
+ * the physical mask has been shifted to 0x80000000 which exploits the alias
+ * on the Malta board. As a result of which, we override the __pa_symbol
+ * to peform direct mapping from virtual to physical addresses. In other
+ * words, the 0x80000000 virtual address maps to 0x80000000 physical address
+ * which in turn aliases to 0x0. We do this in order to be able to use a flat
+ * 2GB of memory (0x80000000 - 0xffffffff) so we can avoid the I/O hole in
+ * 0x10000000 - 0x1fffffff.
+ * The last 64KB of physical memory are reserved for correct HIGHMEM
+ * macros arithmetics.
+ *
+ */
+
+#define PAGE_OFFSET	_AC(0x0, UL)
+#define PHYS_OFFSET	_AC(0x80000000, UL)
+#define HIGHMEM_START	_AC(0xffff0000, UL)
+
+#define __pa_symbol(x)	(RELOC_HIDE((unsigned long)(x), 0))
+
+#endif /* CONFIG_EVA */
+
+#include <asm/mach-generic/spaces.h>
+
+#endif /* _ASM_MALTA_SPACES_H */
-- 
1.8.5.3
