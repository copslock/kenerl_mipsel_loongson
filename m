Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 12:35:10 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49974 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012210AbcBCLeXOeDbM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 12:34:23 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 89E4614AB1BEA;
        Wed,  3 Feb 2016 11:34:14 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 11:34:16 +0000
Received: from localhost (10.100.200.105) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 11:34:16 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/15] MIPS: Support for generating FIT (.itb) images
Date:   Wed, 3 Feb 2016 11:30:43 +0000
Message-ID: <1454499045-5020-14-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.105]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51674
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

Introduce support for generating Flattened Image Tree images containing
the kernel & platform-specific configuration such as a device tree
binary. The FIT format is supported by U-Boot and has a number of
advantages over the older legacy uImage format:

  - It includes device tree binaries inside the image without embedding
    them directly into the kernel ELF, allowing the bootloader to easily
    find & manipulate the DTB whilst still only requiring a single file
    to be loaded during boot or distributed to users.

  - It allows for an arbitrary number of images & configurations to be
    included in a single file. Once the code for various systems built
    around the MIPS Coherent Processing System architecture (ie.
    Imagination Technologies MIPS cores with optional CM, GIC & CPC) is
    consolidated sufficiently this will allow for a single binary to
    include multiple device trees & boot on multiple boards.

  - It allows for a choice of hash algorithms to verify the contents of
    the image.

  - It allows for cryptographically signed images should that ever be
    desired.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/Makefile          |  6 ++++-
 arch/mips/boot/Makefile     | 61 +++++++++++++++++++++++++++++++++++++++++++++
 arch/mips/boot/skeleton.its | 24 ++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/skeleton.its

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e78d60d..0164428 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -257,7 +257,8 @@ KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
 KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
-		  VMLINUX_ENTRY_ADDRESS=$(entry-y)
+		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
+		  PLATFORM_ITS=$(its-y)
 
 LDFLAGS			+= -m $(ld-emul)
 
@@ -297,6 +298,9 @@ boot-y			+= uImage.gz
 boot-y			+= uImage.lzma
 boot-y			+= uImage.lzo
 endif
+boot-y			+= vmlinux.itb
+boot-y			+= vmlinux.bz2.itb
+boot-y			+= vmlinux.gz.itb
 
 # compressed boot image targets (arch/mips/boot/compressed/)
 bootz-y			:= vmlinuz
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index acb1988..82de53d 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -100,3 +100,64 @@ $(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo FORCE
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
+
+# Split a 64bit address into 2x32bit hex integers
+its_addr = $(shell echo $(1) | sed 's/0x\(........\)\(........\)/0x\1 0x\2/')
+
+its_load_addr := $(call its_addr,$(VMLINUX_LOAD_ADDRESS))
+its_entry_addr := $(call its_addr,$(VMLINUX_ENTRY_ADDRESS))
+
+its_files := $(patsubst %,$(srctree)/arch/mips/%,$(PLATFORM_ITS))
+its_inc := $(patsubst %,/include/ \"%\"\n,$(PLATFORM_ITS))
+
+quiet_cmd_gen-its = ITS     $@
+      cmd_gen-its = sed "s|__VMLINUX__|$(2)|g" $< | \
+		sed "s|__VMLINUX_COMPRESSION__|$(3)|g" | \
+		sed "s|__PLATFORM_INCLUDES__|$(its_inc)|g" | \
+		sed "s|__LOAD_ADDR__|$(its_load_addr)|g" | \
+		sed "s|__ENTRY_ADDR__|$(its_entry_addr)|g" \
+		>$@
+
+quiet_cmd_itb-image = ITB     $@
+      cmd_itb-image = \
+		env PATH="$(objtree)/scripts/dtc:$(PATH)" \
+		$(CONFIG_SHELL) $(MKIMAGE) \
+		-D "-I dts -O dtb -p 500 --include $(srctree)/arch/mips --include $(objtree)/arch/mips" \
+		-f $(3) $@
+
+$(obj)/vmlinux.its: $(srctree)/arch/mips/boot/skeleton.its $(its_files) FORCE
+	$(call if_changed,gen-its,boot/vmlinux.bin,none)
+
+$(obj)/vmlinux.itb: $(obj)/vmlinux.bin $(obj)/vmlinux.its FORCE
+	$(call if_changed,itb-image,none,$(obj)/vmlinux.its)
+
+$(obj)/vmlinux.bz2.its: $(srctree)/arch/mips/boot/skeleton.its $(its_files) FORCE
+	$(call if_changed,gen-its,boot/vmlinux.bin.bz2,bzip2)
+
+$(obj)/vmlinux.bz2.itb: $(obj)/vmlinux.bin.bz2 $(obj)/vmlinux.bz2.its FORCE
+	$(call if_changed,itb-image,bzip2,$(obj)/vmlinux.bz2.its)
+
+$(obj)/vmlinux.gz.its: $(srctree)/arch/mips/boot/skeleton.its $(its_files) FORCE
+	$(call if_changed,gen-its,boot/vmlinux.bin.gz,gzip)
+
+$(obj)/vmlinux.gz.itb: $(obj)/vmlinux.bin.gz $(obj)/vmlinux.gz.its FORCE
+	$(call if_changed,itb-image,gzip,$(obj)/vmlinux.gz.its)
+
+$(obj)/vmlinux.lzma.its: $(srctree)/arch/mips/boot/skeleton.its $(its_files) FORCE
+	$(call if_changed,gen-its,boot/vmlinux.bin.lzma,lzmaip)
+
+$(obj)/vmlinux.lzma.itb: $(obj)/vmlinux.bin.lzma $(obj)/vmlinux.lzma.its FORCE
+	$(call if_changed,itb-image,lzma,$(obj)/vmlinux.lzma.its)
+
+$(obj)/vmlinux.lzo.its: $(srctree)/arch/mips/boot/skeleton.its $(its_files) FORCE
+	$(call if_changed,gen-its,boot/vmlinux.bin.lzo,lzoip)
+
+$(obj)/vmlinux.lzo.itb: $(obj)/vmlinux.bin.lzo $(obj)/vmlinux.lzo.its FORCE
+	$(call if_changed,itb-image,lzo,$(obj)/vmlinux.lzo.its)
diff --git a/arch/mips/boot/skeleton.its b/arch/mips/boot/skeleton.its
new file mode 100644
index 0000000..a49c3d2
--- /dev/null
+++ b/arch/mips/boot/skeleton.its
@@ -0,0 +1,24 @@
+/dts-v1/;
+
+/ {
+	description = "MIPS Linux";
+	#address-cells = <1>;
+
+	images {
+		kernel@0 {
+			description = "Linux";
+			data = /incbin/("__VMLINUX__");
+			type = "kernel";
+			arch = "mips";
+			os = "linux";
+			compression = "__VMLINUX_COMPRESSION__";
+			load = <__LOAD_ADDR__>;
+			entry = <__ENTRY_ADDR__>;
+			hash@1 {
+				algo = "sha1";
+			};
+		};
+	};
+};
+
+__PLATFORM_INCLUDES__
-- 
2.7.0
