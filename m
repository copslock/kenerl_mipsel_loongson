Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Aug 2013 16:56:00 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:2242 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6839078Ab3HUOz6O1x8X (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Aug 2013 16:55:58 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: add uImage build target
Date:   Wed, 21 Aug 2013 15:55:47 +0100
Message-ID: <1377096947-3959-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_21_15_55_53
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Add a uImage build target for MIPS, which builds uImage.gz (a U-Boot
image of vmlinux.bin.gz), and then symlinks it to uImage. This allows
for the use of other compression algorithms in future, and is how a few
other architectures do it.

The load address and entry address are calculated from the address of
the _text and kernel_entry symbols, by running nm on the main vmlinux
(based on arch/mips/lasat/image/Makefile).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Makefile        |  3 ++-
 arch/mips/boot/.gitignore |  1 +
 arch/mips/boot/Makefile   | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index b2be6b8..c4f339e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -284,7 +284,7 @@ vmlinux.64: vmlinux
 all:	$(all-y)
 
 # boot
-vmlinux.bin vmlinux.ecoff vmlinux.srec: $(vmlinux-32) FORCE
+vmlinux.bin vmlinux.ecoff vmlinux.srec uImage: $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) arch/mips/boot/$@
 
 # boot/compressed
@@ -327,6 +327,7 @@ define archhelp
 	echo '  vmlinuz.ecoff        - ECOFF zboot image'
 	echo '  vmlinuz.bin          - Raw binary zboot image'
 	echo '  vmlinuz.srec         - SREC zboot image'
+	echo '  uImage               - U-Boot image (gzip)'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
 endef
diff --git a/arch/mips/boot/.gitignore b/arch/mips/boot/.gitignore
index f210b09..a73d6e2 100644
--- a/arch/mips/boot/.gitignore
+++ b/arch/mips/boot/.gitignore
@@ -4,3 +4,4 @@ vmlinux.*
 zImage
 zImage.tmp
 calc_vmlinuz_load_addr
+uImage
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 851261e..8169d42 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -40,3 +40,18 @@ quiet_cmd_srec = OBJCOPY $@
       cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
 $(obj)/vmlinux.srec: $(VMLINUX) FORCE
 	$(call if_changed,srec)
+
+UIMAGE_LOADADDR  = $(shell $(NM) $(VMLINUX) | grep "\b_text\b"        | cut -f1 -d\ )
+UIMAGE_ENTRYADDR = $(shell $(NM) $(VMLINUX) | grep '\bkernel_entry\b' | cut -f1 -d\ )
+
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+targets += uImage.gz
+$(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,uimage,gzip)
+
+targets += uImage
+$(obj)/uImage: $(obj)/uImage.gz FORCE
+	@ln -sf $(notdir $<) $@
+	@echo '  Image $@ is ready'
-- 
1.8.1.2
