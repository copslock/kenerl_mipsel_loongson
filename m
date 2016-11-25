Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Nov 2016 13:36:32 +0100 (CET)
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:37919 "EHLO
        lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbcKYMgZ2wAFu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Nov 2016 13:36:25 +0100
Received: from localhost.localdomain ([83.160.161.190])
        by smtp-cloud2.xs4all.net with ESMTP
        id CCcJ1u00E46mmVf01CcKM3; Fri, 25 Nov 2016 13:36:20 +0100
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ZBOOT: Don't use $(LINUXINCLUDE) twice
Date:   Fri, 25 Nov 2016 13:36:18 +0100
Message-Id: <1480077378-2440-1-git-send-email-pebolle@tiscali.nl>
X-Mailer: git-send-email 2.7.4
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

The make variables KBUILD_CFLAGS and KBUILD_AFLAGS both contain
$(LINUXINCLUDE). But the build already picks up $(LINUXINCLUDE) from
scripts/Makefile.lib. The net effect is that the (long) list of include
directories is used twice.

This is harmless but pointless. So stop using $(LINUXINCLUDE) twice.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Build tested only!

 arch/mips/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 011b14512c05..41564a4db6f7 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -22,10 +22,10 @@ KBUILD_CFLAGS := $(shell echo $(KBUILD_CFLAGS) | sed -e "s/-pg//")
 
 KBUILD_CFLAGS := $(filter-out -fstack-protector, $(KBUILD_CFLAGS))
 
-KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
+KBUILD_CFLAGS := $(KBUILD_CFLAGS) -D__KERNEL__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
 
-KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
+KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
-- 
2.7.4
