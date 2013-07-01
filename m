Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 12:38:42 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:28067 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822972Ab3GAKik4alwT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jul 2013 12:38:40 +0200
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: boot: compressed: Remove -fstack-protector from CFLAGS
Date:   Mon, 1 Jul 2013 11:38:30 +0100
Message-ID: <1372675110-1301-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_07_01_11_38_34
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37238
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

When building with -fstack-protector, gcc emits the
__stack_chk_guard and __stack_chk_fail symbols to check for
stack stability. These symbols are defined in vmlinux but
the generated vmlinux.bin that is used to create the
compressed vmlinuz image has no symbol table so the linker
can't find these symbols during the final linking phase.
As a result of which, we need either to redefine these symbols
just for the compressed image or drop the -fstack-protector
option when building the compressed image. This patch implements
the latter of two options.

Fixes the following linking problem:

dbg.c:(.text+0x7c): undefined reference to `__stack_chk_guard'
dbg.c:(.text+0x80): undefined reference to `__stack_chk_guard'
dbg.c:(.text+0xd4): undefined reference to `__stack_chk_guard'
dbg.c:(.text+0xec): undefined reference to `__stack_chk_fail'

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
This patch is for the upstream-sfr/mips-for-linux-next tree
---
 arch/mips/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index bbaa1d4..bb1dbf4 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -18,6 +18,8 @@ BOOT_HEAP_SIZE := 0x400000
 # Disable Function Tracer
 KBUILD_CFLAGS := $(shell echo $(KBUILD_CFLAGS) | sed -e "s/-pg//")
 
+KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
+
 KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
 
-- 
1.8.2.1
