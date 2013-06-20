Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 07:13:55 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:43892 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815759Ab3FTFNyPi4p0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 07:13:54 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1UpXBp-000337-1m; Thu, 20 Jun 2013 00:13:45 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET"
Date:   Thu, 20 Jun 2013 00:13:37 -0500
Message-Id: <1371705218-4570-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
virtual address as an argument and also returns a kernel virtual
address. Using and physical address PHYS_OFFSET is blatantly wrong
for a macro common to multiple platforms.

Change-Id: I19feb1e537c6a517e6b42f3ec6ce746b6a97617e
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mach-ar7/spaces.h  |    7 +++++--
 arch/mips/include/asm/mach-ip28/spaces.h |    9 ++++++---
 arch/mips/include/asm/page.h             |    6 ++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mach-ar7/spaces.h b/arch/mips/include/asm/mach-ar7/spaces.h
index ac28f27..660ab64 100644
--- a/arch/mips/include/asm/mach-ar7/spaces.h
+++ b/arch/mips/include/asm/mach-ar7/spaces.h
@@ -14,8 +14,11 @@
  * This handles the memory map.
  * We handle pages at KSEG0 for kernels with 32 bit address space.
  */
-#define PAGE_OFFSET		0x94000000UL
-#define PHYS_OFFSET		0x14000000UL
+#define PAGE_OFFSET	_AC(0x94000000, UL)
+#define PHYS_OFFSET	_AC(0x14000000, UL)
+
+#define UNCAC_BASE	_AC(0xb4000000, UL)	/* 0xa0000000 + PHYS_OFFSET */
+#define IO_BASE		UNCAC_BASE
 
 #include <asm/mach-generic/spaces.h>
 
diff --git a/arch/mips/include/asm/mach-ip28/spaces.h b/arch/mips/include/asm/mach-ip28/spaces.h
index 5edf05d..5d6a764 100644
--- a/arch/mips/include/asm/mach-ip28/spaces.h
+++ b/arch/mips/include/asm/mach-ip28/spaces.h
@@ -11,11 +11,14 @@
 #ifndef _ASM_MACH_IP28_SPACES_H
 #define _ASM_MACH_IP28_SPACES_H
 
-#define CAC_BASE		0xa800000000000000
+#define CAC_BASE	_AC(0xa800000000000000, UL)
 
-#define HIGHMEM_START		(~0UL)
+#define HIGHMEM_START	(~0UL)
 
-#define PHYS_OFFSET		_AC(0x20000000, UL)
+#define PHYS_OFFSET	_AC(0x20000000, UL)
+
+#define UNCAC_BASE	_AC(0xc0000000, UL)     /* 0xa0000000 + PHYS_OFFSET */
+#define IO_BASE		UNCAC_BASE
 
 #include <asm/mach-generic/spaces.h>
 
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index f59552f..f6be474 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -205,10 +205,8 @@ extern int __virt_addr_valid(const volatile void *kaddr);
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE +	\
-								PHYS_OFFSET)
-#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET -	\
-								PHYS_OFFSET)
+#define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
+#define CAC_ADDR(addr)		((addr) - UNCAC_BASE + PAGE_OFFSET)
 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/getorder.h>
-- 
1.7.2.5
