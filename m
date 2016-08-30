Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 19:38:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23851 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992307AbcH3Rf1sSG20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 19:35:27 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F97CE747BE9E;
        Tue, 30 Aug 2016 18:35:07 +0100 (IST)
Received: from localhost (10.100.200.118) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 30 Aug
 2016 18:35:10 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 21/26] MIPS: Support generating Flattened Image Trees (.itb)
Date:   Tue, 30 Aug 2016 18:29:24 +0100
Message-ID: <20160830172929.16948-22-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830172929.16948-1-paul.burton@imgtec.com>
References: <20160830172929.16948-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.118]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54862
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

Add support for generating kernel images in the Flattened Image Tree
(.itb) format as supported by U-Boot. This format is essentially a
Flattened Device Tree binary containing images (kernels, DTBs, ramdisks)
and configurations which link those images together. The big advantages
of FIT images over the uImage format are:

  - We can include FDTs in the kernel image in a way that the bootloader
    can extract it & manipulate it before providing it to the kernel.
    Thus we can ship FDTs as part of the kernel giving us the advantages
    of being able to develop & maintain the DT within the kernel tree,
    but also have the benefits of the bootloader being able to
    manipulate the FDT. Example uses for this would be to inject the
    kernel command line into the chosen node, or to fill in the correct
    memory size.

  - We can include multiple configurations in a single kernel image.
    This means that a single FIT image can, given appropriate
    bootloaders, be booted on different boards with the bootloader
    selecting an appropriate configuration & providing the correct FDT
    to the kernel.

  - We can support a multitude of hashes over the data.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/Makefile      |  8 ++++++-
 arch/mips/boot/Makefile | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index efd7a9d..d968ec0 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -266,7 +266,8 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
 KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
-		  VMLINUX_ENTRY_ADDRESS=$(entry-y)
+		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
+		  PLATFORM=$(platform-y)
 
 LDFLAGS			+= -m $(ld-emul)
 
@@ -306,6 +307,11 @@ boot-y			+= uImage.gz
 boot-y			+= uImage.lzma
 boot-y			+= uImage.lzo
 endif
+boot-y			+= vmlinux.itb
+boot-y			+= vmlinux.gz.itb
+boot-y			+= vmlinux.bz2.itb
+boot-y			+= vmlinux.lzma.itb
+boot-y			+= vmlinux.lzo.itb
 
 # compressed boot image targets (arch/mips/boot/compressed/)
 bootz-y			:= vmlinuz
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index acb1988..ed65663 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -100,3 +100,60 @@ $(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
 $(obj)/uImage: $(obj)/uImage.$(suffix-y)
 	@ln -sf $(notdir $<) $@
 	@echo '  Image $@ is ready'
+
+#
+# Flattened Image Tree (.itb) images
+#
+
+targets += vmlinux.itb
+targets += vmlinux.gz.itb
+targets += vmlinux.bz2.itb
+targets += vmlinux.lzma.itb
+targets += vmlinux.lzo.itb
+
+quiet_cmd_cpp_its_S = ITS     $@
+      cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
+			-DVMLINUX_BINARY="\"$(3)\"" \
+			-DVMLINUX_COMPRESSION="\"$(2)\"" \
+			-DVMLINUX_LOAD_ADDRESS=$(VMLINUX_LOAD_ADDRESS) \
+			-DVMLINUX_ENTRY_ADDRESS=$(VMLINUX_ENTRY_ADDRESS)
+
+$(obj)/vmlinux.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
+
+$(obj)/vmlinux.gz.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+	$(call if_changed_dep,cpp_its_S,gzip,vmlinux.bin.gz)
+
+$(obj)/vmlinux.bz2.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+	$(call if_changed_dep,cpp_its_S,bzip2,vmlinux.bin.bz2)
+
+$(obj)/vmlinux.lzma.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+	$(call if_changed_dep,cpp_its_S,lzma,vmlinux.bin.lzma)
+
+$(obj)/vmlinux.lzo.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S FORCE
+	$(call if_changed_dep,cpp_its_S,lzo,vmlinux.bin.lzo)
+
+quiet_cmd_itb-image = ITB     $@
+      cmd_itb-image = \
+		env PATH="$(objtree)/scripts/dtc:$(PATH)" \
+		$(CONFIG_SHELL) $(MKIMAGE) \
+		-D "-I dts -O dtb -p 500 \
+			--include $(objtree)/arch/mips \
+			--warning no-unit_address_vs_reg" \
+		-f $(2) $@
+
+$(obj)/vmlinux.itb: $(obj)/vmlinux.its $(obj)/vmlinux.bin FORCE
+	$(call if_changed,itb-image,$<)
+
+$(obj)/vmlinux.gz.itb: $(obj)/vmlinux.gz.its $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,itb-image,$<)
+
+$(obj)/vmlinux.bz2.itb: $(obj)/vmlinux.bz2.its $(obj)/vmlinux.bin.bz2 FORCE
+	$(call if_changed,itb-image,$<)
+
+$(obj)/vmlinux.lzma.itb: $(obj)/vmlinux.lzma.its $(obj)/vmlinux.bin.lzma FORCE
+	$(call if_changed,itb-image,$<)
+
+$(obj)/vmlinux.lzo.itb: $(obj)/vmlinux.lzo.its $(obj)/vmlinux.bin.lzo FORCE
+	$(call if_changed,itb-image,$<)
-- 
2.9.3
