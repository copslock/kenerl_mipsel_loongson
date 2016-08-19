Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 19:16:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:17291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992500AbcHSRQr585tr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 19:16:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 82DEBA2C12AF5;
        Fri, 19 Aug 2016 18:16:28 +0100 (IST)
Received: from localhost (10.100.200.126) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 19 Aug
 2016 18:16:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Use objdump -f to find kernel entry point
Date:   Fri, 19 Aug 2016 18:16:14 +0100
Message-ID: <20160819171614.28813-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When using nm to find the address of the kernel_entry symbol, the
microMIPS ISA bit is not set for microMIPS kernels. This means that the
entry address reported for the kernel is one that is treated as MIPS32
code, which causes problems if it is placed into an image such as a
uImage or FIT image from which the bootloader will read the entry
address & branch to it as non-microMIPS code.

Fix this by instead using the objdump tool to determine the kernel entry
address instead. We already pass $(OBJDUMP) around the kernel makefiles,
and it reports the entry address with the microMIPS ISA bit intact.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index efd7a9d..9bf611d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -232,8 +232,9 @@ include arch/mips/Kbuild.platforms
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
 endif
-entry-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
-					| grep "\bkernel_entry\b" | cut -f1 -d \ )
+entry-y				= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
+					| grep "^start address " \
+					| cut -f3 -d \ )
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
-- 
2.9.3
