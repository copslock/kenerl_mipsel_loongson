Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 11:02:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51740 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993038AbcKJKCZASHhQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2016 11:02:25 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2915E65103EC5;
        Thu, 10 Nov 2016 10:02:16 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 10 Nov 2016 10:02:18 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: Use Makefile.postlink to insert relocations into vmlinux
Date:   Thu, 10 Nov 2016 10:02:13 +0000
Message-ID: <1478772133-32081-1-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When relocatable support for MIPS was merged, there was no support for
an architecture to add a postlink step for vmlinux. This meant that only
invoking a target within the boot directory, such as uImage, caused the
relocations to be inserted into vmlinux. Building just the vmlinux
target would result in a relocatable kernel with no relocation
information present.

Commit fbe6e37dab97 ("kbuild: add arch specific post-link Makefile")
recified this situation, so MIPS can now define a postlink step to add
relocation information into vmlinux, and remove the additional steps
tacked onto boot targets.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/Makefile          | 12 ------------
 arch/mips/Makefile.postlink | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)
 create mode 100644 arch/mips/Makefile.postlink

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 1a6bac7b076f..fb7664c31259 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -327,10 +327,6 @@ rom.bin rom.sw: vmlinux
 		$(bootvars-y) $@
 endif
 
-CMD_RELOCS = arch/mips/boot/tools/relocs
-quiet_cmd_relocs = RELOCS  $<
-      cmd_relocs = $(CMD_RELOCS) $<
-
 #
 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
@@ -339,11 +335,6 @@ quiet_cmd_relocs = RELOCS  $<
 quiet_cmd_32 = OBJCOPY $@
 	cmd_32 = $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.32: vmlinux
-ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_64BIT),yy)
-# Currently, objcopy fails to handle the relocations in the elf64
-# So the relocs tool must be run here to remove them first
-	$(call cmd,relocs)
-endif
 	$(call cmd,32)
 
 #
@@ -359,9 +350,6 @@ all:	$(all-y)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE
-ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_32BIT),yy)
-	$(call cmd,relocs)
-endif
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
 		$(bootvars-y) arch/mips/boot/$@
 
diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
new file mode 100644
index 000000000000..b0ddf0701a31
--- /dev/null
+++ b/arch/mips/Makefile.postlink
@@ -0,0 +1,35 @@
+# ===========================================================================
+# Post-link MIPS pass
+# ===========================================================================
+#
+# 1. Insert relocations into vmlinux
+
+PHONY := __archpost
+__archpost:
+
+include include/config/auto.conf
+include scripts/Kbuild.include
+
+CMD_RELOCS = arch/mips/boot/tools/relocs
+quiet_cmd_relocs = RELOCS $@
+      cmd_relocs = $(CMD_RELOCS) $@
+
+# `@true` prevents complaint when there is nothing to be done
+
+vmlinux: FORCE
+	@true
+ifeq ($(CONFIG_RELOCATABLE),y)
+	$(call if_changed,relocs)
+endif
+
+%.ko: FORCE
+	@true
+
+clean:
+	@true
+
+PHONY += FORCE clean
+
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.7.4
