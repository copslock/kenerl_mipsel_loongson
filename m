Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 10:07:24 +0100 (CET)
Received: from mail-iw0-f193.google.com ([209.85.214.193]:43813 "EHLO
        mail-iw0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493339Ab1AQJHV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 10:07:21 +0100
Received: by iwn2 with SMTP id 2so1878430iwn.0
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 01:07:19 -0800 (PST)
Received: by 10.42.240.2 with SMTP id ky2mr4080157icb.460.1295255239080;
        Mon, 17 Jan 2011 01:07:19 -0800 (PST)
Received: from localhost.localdomain (fidelio.qi-hardware.com [213.239.211.82])
        by mx.google.com with ESMTPS id d21sm3867202ibg.3.2011.01.17.01.07.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 01:07:17 -0800 (PST)
From:   Xiangfu Liu <xiangfu@sharism.cc>
To:     linux-mips@linux-mips.org
Cc:     ravenexp@gmail.com, lars@metafoo.de,
        Xiangfu Liu <xiangfu@sharism.cc>
Subject: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
Date:   Mon, 17 Jan 2011 17:07:04 +0800
Message-Id: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
X-Mailer: git-send-email 1.7.0.4
Return-Path: <xiangfu@sharism.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu@sharism.cc
Precedence: bulk
X-list: linux-mips

Requires mkimage tool from u-boot-tools.
Uses gzip compression by default.

Signed-off-by: Xiangfu Liu <xiangfu@sharism.cc>
Acked-by: Sergey Kvachonok <ravenexp@gmail.com>
---
 arch/mips/Makefile               |    6 ++++++
 arch/mips/boot/u-boot/.gitignore |    2 ++
 arch/mips/boot/u-boot/Makefile   |   15 +++++++++++++++
 3 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 arch/mips/boot/u-boot/.gitignore
 create mode 100644 arch/mips/boot/u-boot/Makefile

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 7c1102e..8d1f9fc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -280,6 +280,11 @@ vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
 	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
 	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
 
+# u-boot
+uImage: vmlinux.bin FORCE
+	$(Q)$(MAKE) $(build)=arch/mips/boot/u-boot \
+	  VMLINUX=$(vmlinux-32) VMLINUXBIN=arch/mips/boot/vmlinux.bin \
+	  VMLINUX_LOAD_ADDRESS=$(load-y) arch/mips/boot/u-boot/$@
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
@@ -313,6 +318,7 @@ define archhelp
 	echo '  vmlinuz.ecoff        - ECOFF zboot image'
 	echo '  vmlinuz.bin          - Raw binary zboot image'
 	echo '  vmlinuz.srec         - SREC zboot image'
+	echo '  uImage               - U-boot image (gzip)'
 	echo
 	echo '  These will be default as apropriate for a configured platform.'
 endef
diff --git a/arch/mips/boot/u-boot/.gitignore b/arch/mips/boot/u-boot/.gitignore
new file mode 100644
index 0000000..1080c94
--- /dev/null
+++ b/arch/mips/boot/u-boot/.gitignore
@@ -0,0 +1,2 @@
+vmlinux.bin.gz
+uImage
diff --git a/arch/mips/boot/u-boot/Makefile b/arch/mips/boot/u-boot/Makefile
new file mode 100644
index 0000000..318dc50
--- /dev/null
+++ b/arch/mips/boot/u-boot/Makefile
@@ -0,0 +1,15 @@
+targets += vmlinux.bin.gz
+quiet_cmd_gzip = GZIP $@
+cmd_gzip = gzip -c9 $(VMLINUXBIN) $(obj)/vmlinux.bin.gz
+$(obj)/vmlinux.bin.gz: $(obj)/../vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+MKIMAGE = mkimage
+
+targets += uImage
+quiet_cmd_uImage = MKIMAGE $@
+cmd_uImage = $(MKIMAGE) -A mips -O linux -T kernel -C gzip -a $(VMLINUX_LOAD_ADDRESS) \
+-e 0x$(shell $(NM) $(VMLINUX) | grep ' kernel_entry' | cut -f1 -d ' ') \
+-n MIPS -d $(obj)/vmlinux.bin.gz $(obj)/uImage
+$(obj)/uImage: $(obj)/vmlinux.bin.gz FORCE
+	$(call if_changed,uImage)
-- 
1.7.0.4
