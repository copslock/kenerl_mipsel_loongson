Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Aug 2013 17:47:56 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:47284 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824926Ab3H3PnzEnklB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Aug 2013 17:43:55 +0200
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH v2 3/3] MIPS: add uImage build target
Date:   Fri, 30 Aug 2013 16:42:42 +0100
Message-ID: <1377877362-15650-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
References: <1377877362-15650-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_30_16_43_07
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37722
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

It's enabled conditionally on load-y >= 0xffffffff80000000 which
hopefully allows 64bit kernels to also work as long as the load and
entry address can be represented by the 32bit addresses in the U-Boot
image format.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/Makefile        |  6 ++++++
 arch/mips/boot/.gitignore |  1 +
 arch/mips/boot/Makefile   | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 62311c7..3aedc86 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -267,6 +267,10 @@ drivers-$(CONFIG_PM)	+= arch/mips/power/
 boot-y			:= vmlinux.bin
 boot-y			+= vmlinux.ecoff
 boot-y			+= vmlinux.srec
+ifeq ($(shell expr $(load-y) \< 0xffffffff80000000 2> /dev/null), 0)
+boot-y			+= uImage
+boot-y			+= uImage.gz
+endif
 
 # compressed boot image targets (arch/mips/boot/compressed/)
 bootz-y			:= vmlinuz
@@ -345,6 +349,8 @@ define archhelp
 	echo '  vmlinuz.ecoff        - ECOFF zboot image'
 	echo '  vmlinuz.bin          - Raw binary zboot image'
 	echo '  vmlinuz.srec         - SREC zboot image'
+	echo '  uImage               - U-Boot image'
+	echo '  uImage.gz            - U-Boot image (gzip)'
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
index 851261e..1466c00 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -40,3 +40,18 @@ quiet_cmd_srec = OBJCOPY $@
       cmd_srec = $(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $@
 $(obj)/vmlinux.srec: $(VMLINUX) FORCE
 	$(call if_changed,srec)
+
+UIMAGE_LOADADDR  = $(VMLINUX_LOAD_ADDRESS)
+UIMAGE_ENTRYADDR = $(VMLINUX_ENTRY_ADDRESS)
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
