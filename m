Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 00:38:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31551 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994887AbdHGWiDnijKI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 00:38:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 31E7D5759DE3D;
        Mon,  7 Aug 2017 23:37:52 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug 2017 23:37:56
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/4] MIPS: Allow platform to specify multiple its.S files
Date:   Mon, 7 Aug 2017 15:37:21 -0700
Message-ID: <20170807223724.19408-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
In-Reply-To: <20170807223724.19408-1-paul.burton@imgtec.com>
References: <20170807223724.19408-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59402
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

In preparation for splitting arch/mips/generic/vmlinux.its.S into
multiple files such that it doesn't become a conflict magnet as boards
are added, allow platforms to specify a list of image tree source files
which will be concatenated to form the final source used to build the
image tree.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/Makefile         |  3 ++-
 arch/mips/boot/Makefile    | 16 +++++++++++-----
 arch/mips/generic/Platform |  2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 876394554274..8b7aefd859cd 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -277,7 +277,8 @@ KBUILD_CPPFLAGS += -DDATAOFFSET=$(if $(dataoffset-y),$(dataoffset-y),0)
 
 bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y) \
 		  VMLINUX_ENTRY_ADDRESS=$(entry-y) \
-		  PLATFORM="$(platform-y)"
+		  PLATFORM="$(platform-y)" \
+		  ITS_INPUTS="$(its-y)"
 ifdef CONFIG_32BIT
 bootvars-y	+= ADDR_BITS=32
 endif
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 145b5ce8eb7e..1bd5c4f00d19 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -118,6 +118,12 @@ ifeq ($(ADDR_BITS),64)
 	itb_addr_cells = 2
 endif
 
+quiet_cmd_its_cat = CAT     $@
+      cmd_its_cat = cat $^ >$@
+
+$(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS))
+	$(call if_changed,its_cat)
+
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
@@ -128,19 +134,19 @@ quiet_cmd_cpp_its_S = ITS     $@
 			-DADDR_BITS=$(ADDR_BITS) \
 			-DADDR_CELLS=$(itb_addr_cells)
 
-$(obj)/vmlinux.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,none,vmlinux.bin)
 
-$(obj)/vmlinux.gz.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.gz.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,gzip,vmlinux.bin.gz)
 
-$(obj)/vmlinux.bz2.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX)  FORCE
+$(obj)/vmlinux.bz2.its: $(obj)/vmlinux.its.S $(VMLINUX)  FORCE
 	$(call if_changed_dep,cpp_its_S,bzip2,vmlinux.bin.bz2)
 
-$(obj)/vmlinux.lzma.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzma.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,lzma,vmlinux.bin.lzma)
 
-$(obj)/vmlinux.lzo.its: $(srctree)/arch/mips/$(PLATFORM)/vmlinux.its.S $(VMLINUX) FORCE
+$(obj)/vmlinux.lzo.its: $(obj)/vmlinux.its.S $(VMLINUX) FORCE
 	$(call if_changed_dep,cpp_its_S,lzo,vmlinux.bin.lzo)
 
 quiet_cmd_itb-image = ITB     $@
diff --git a/arch/mips/generic/Platform b/arch/mips/generic/Platform
index 9a30d69e2281..6f7ce7b0c5e2 100644
--- a/arch/mips/generic/Platform
+++ b/arch/mips/generic/Platform
@@ -12,3 +12,5 @@ platform-$(CONFIG_MIPS_GENERIC)	+= generic/
 cflags-$(CONFIG_MIPS_GENERIC)	+= -I$(srctree)/arch/mips/include/asm/mach-generic
 load-$(CONFIG_MIPS_GENERIC)	+= 0xffffffff80100000
 all-$(CONFIG_MIPS_GENERIC)	:= vmlinux.gz.itb
+
+its-y					:= vmlinux.its.S
-- 
2.14.0
