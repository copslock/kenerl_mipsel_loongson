Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 15:20:25 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42493 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992437AbcJaOUT3mNMV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 15:20:19 +0100
Received: from mfilter1-d.gandi.net (mfilter1-d.gandi.net [217.70.178.130])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 3921BA8115;
        Mon, 31 Oct 2016 15:20:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter1-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter1-d.gandi.net (mfilter1-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id UeJai8-8wAg3; Mon, 31 Oct 2016 15:20:17 +0100 (CET)
X-Originating-IP: 82.170.150.80
Received: from starbug-2.treewalker.org (82-170-150-80.ip.open.net [82.170.150.80])
        (Authenticated sender: relay@treewalker.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2CFDBA80C4;
        Mon, 31 Oct 2016 15:20:17 +0100 (CET)
Received: from hyperion.local.treewalker.org (hyperion.local.treewalker.org [192.168.0.43])
        by starbug-2.treewalker.org (Postfix) with ESMTP id 95691EB7CF;
        Mon, 31 Oct 2016 15:20:16 +0100 (CET)
From:   Maarten ter Huurne <maarten@treewalker.org>
To:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] MIPS: zboot: Add "uzImage.bin" target
Date:   Mon, 31 Oct 2016 15:19:55 +0100
Message-Id: <1477923595-12033-1-git-send-email-maarten@treewalker.org>
X-Mailer: git-send-email 2.6.6
Return-Path: <maarten@treewalker.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maarten@treewalker.org
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

uzImage.bin is vmlinuz.bin wrapped in a legacy U-Boot image. Since
the extraction code is inside the image, it does not depend on the
boot loader to extract the kernel.

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
---
 arch/mips/Makefile                 | 4 ++++
 arch/mips/boot/compressed/Makefile | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index fbf40d3..c004da4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -320,6 +320,9 @@ bootz-y			:= vmlinuz
 bootz-y			+= vmlinuz.bin
 bootz-y			+= vmlinuz.ecoff
 bootz-y			+= vmlinuz.srec
+ifeq ($(shell expr $(zload-y) \< 0xffffffff80000000 2> /dev/null), 0)
+bootz-y			+= uzImage.bin
+endif
 
 ifdef CONFIG_LASAT
 rom.bin rom.sw: vmlinux
@@ -433,6 +436,7 @@ define archhelp
 	echo '  uImage.gz            - U-Boot image (gzip)'
 	echo '  uImage.lzma          - U-Boot image (lzma)'
 	echo '  uImage.lzo           - U-Boot image (lzo)'
+	echo '  uzImage.bin          - U-Boot image (self-extracting)'
 	echo '  dtbs                 - Device-tree blobs for enabled boards'
 	echo '  dtbs_install         - Install dtbs to $(INSTALL_DTBS_PATH)'
 	echo
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index 90aca95..011b145 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -84,6 +84,7 @@ else
 VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
 		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
 endif
+UIMAGE_LOADADDR = $(VMLINUZ_LOAD_ADDRESS)
 
 vmlinuzobjs-y += $(obj)/piggy.o
 
@@ -129,4 +130,7 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec
 vmlinuz.srec: vmlinuz
 	$(call cmd,objcopy)
 
+uzImage.bin: vmlinuz.bin FORCE
+	$(call if_changed,uimage,none)
+
 clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
-- 
2.6.6
