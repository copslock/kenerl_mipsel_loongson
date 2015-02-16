Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Feb 2015 16:13:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61492 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012833AbbBPPNZmdZSh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Feb 2015 16:13:25 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 89AD784D3BFD0
        for <linux-mips@linux-mips.org>; Mon, 16 Feb 2015 15:13:17 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 16 Feb 2015 15:13:19 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 16 Feb 2015 15:13:18 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH] MIPS: boot: Provide more uImage options
Date:   Mon, 16 Feb 2015 15:13:11 +0000
Message-ID: <1424099591-27197-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45827
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

Allow more compression algorithms as well as uncompressed uImage.bin
to be generated. An uncompressed image might be useful to rule out
problems in the decompression code in the bootloader or even speed
up the boot process at the expense of a bigger uImage file.

Cc: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/Makefile      |  8 ++++++++
 arch/mips/boot/Makefile | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 0fcf7e0f4295..7109c40ee860 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -289,7 +289,11 @@ boot-y			+= vmlinux.ecoff
 boot-y			+= vmlinux.srec
 ifeq ($(shell expr $(load-y) \< 0xffffffff80000000 2> /dev/null), 0)
 boot-y			+= uImage
+boot-y			+= uImage.bin
+boot-y			+= uImage.bz2
 boot-y			+= uImage.gz
+boot-y			+= uImage.lzma
+boot-y			+= uImage.lzo
 endif
 
 # compressed boot image targets (arch/mips/boot/compressed/)
@@ -388,7 +392,11 @@ define archhelp
 	echo '  vmlinuz.bin          - Raw binary zboot image'
 	echo '  vmlinuz.srec         - SREC zboot image'
 	echo '  uImage               - U-Boot image'
+	echo '  uImage.bin           - U-Boot image (uncompressed)'
+	echo '  uImage.bz2           - U-Boot image (bz2)'
 	echo '  uImage.gz            - U-Boot image (gzip)'
+	echo '  uImage.lzma          - U-Boot image (lzma)'
+	echo '  uImage.lzo           - U-Boot image (lzo)'
 	echo '  dtbs                 - Device-tree blobs for enabled boards'
 	echo
 	echo '  These will be default as appropriate for a configured platform.'
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1466c0026093..acb1988f354e 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -23,6 +23,12 @@ strip-flags   := $(addprefix --remove-section=,$(drop-sections))
 
 hostprogs-y := elf2ecoff
 
+suffix-y			:= bin
+suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
+suffix-$(CONFIG_KERNEL_GZIP)	:= gz
+suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
+suffix-$(CONFIG_KERNEL_LZO)	:= lzo
+
 targets := vmlinux.ecoff
 quiet_cmd_ecoff = ECOFF	  $@
       cmd_ecoff = $(obj)/elf2ecoff $(VMLINUX) $@ $(e2eflag)
@@ -44,14 +50,53 @@ $(obj)/vmlinux.srec: $(VMLINUX) FORCE
 UIMAGE_LOADADDR  = $(VMLINUX_LOAD_ADDRESS)
 UIMAGE_ENTRYADDR = $(VMLINUX_ENTRY_ADDRESS)
 
+#
+# Compressed vmlinux images
+#
+
+extra-y += vmlinux.bin.bz2
+extra-y += vmlinux.bin.gz
+extra-y += vmlinux.bin.lzma
+extra-y += vmlinux.bin.lzo
+
+$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,bzip2)
+
 $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
 
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,lzma)
+
+$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,lzo)
+
+#
+# Compressed u-boot images
+#
+
+targets += uImage
+targets += uImage.bin
+targets += uImage.bz2
 targets += uImage.gz
+targets += uImage.lzma
+targets += uImage.lzo
+
+$(obj)/uImage.bin: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,uimage,none)
+
+$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2 FORCE
+	$(call if_changed,uimage,bzip2)
+
 $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
 	$(call if_changed,uimage,gzip)
 
-targets += uImage
-$(obj)/uImage: $(obj)/uImage.gz FORCE
+$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma FORCE
+	$(call if_changed,uimage,lzma)
+
+$(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
+	$(call if_changed,uimage,lzo)
+
+$(obj)/uImage: $(obj)/uImage.$(suffix-y)
 	@ln -sf $(notdir $<) $@
 	@echo '  Image $@ is ready'
-- 
2.3.0
