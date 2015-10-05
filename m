Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2015 11:54:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63091 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009490AbbJEJw7LFqd5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Oct 2015 11:52:59 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 962F09023657F
        for <linux-mips@linux-mips.org>; Mon,  5 Oct 2015 10:52:51 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 5 Oct 2015 10:52:53 +0100
Received: from mredfearn-linux.le.imgtec.org (192.168.154.117) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 5 Oct 2015 10:52:52 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [RFC PATCH 4/7] MIPS: Generate relocation table when CONFIG_RELOCATABLE
Date:   Mon, 5 Oct 2015 10:52:28 +0100
Message-ID: <1444038751-25105-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
References: <1444038751-25105-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.117]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49428
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

When CONFIG_RELOCATABLE is enabled (added in later patch)
add --emit-relocs to vmlinux LDFLAGS so that the elf
contains relocation information.

Run the previously added relocation tool to append the
relocation table to the binary image.

Space for the table is reserved in the linker script
by a previous commit

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/Makefile      |  4 ++++
 arch/mips/boot/Makefile | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9371ea0adb88..fd28b0965c42 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -96,6 +96,10 @@ LDFLAGS_vmlinux			+= -G 0 -static -n -nostdlib
 KBUILD_AFLAGS_MODULE		+= -mlong-calls
 KBUILD_CFLAGS_MODULE		+= -mlong-calls
 
+ifeq ($(CONFIG_RELOCATABLE),y)
+LDFLAGS_vmlinux			+= --emit-relocs
+endif
+
 #
 # pass -msoft-float to GAS if it supports it.  However on newer binutils
 # (specifically newer than 2.24.51.20140728) we then also need to explicitly
diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index fb5bfaec55ac..127705bb43a8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -36,10 +36,29 @@ $(obj)/vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX) FORCE
 	$(call if_changed,ecoff)
 
 targets += vmlinux.bin
+ifneq ($(CONFIG_RELOCATABLE),y)
 quiet_cmd_bin = OBJCOPY $@
       cmd_bin = $(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $@
 $(obj)/vmlinux.bin: $(VMLINUX) FORCE
 	$(call if_changed,bin)
+else
+# For relocatable kernel, Generate a relocation table that is appended to the image
+
+CMD_RELOCS = arch/mips/boot/tools/relocs
+quiet_cmd_relocs = RELOCS  $@
+      cmd_relocs = $(CMD_RELOCS) $< > $@
+$(obj)/vmlinux.relocs: $(VMLINUX) FORCE
+	$(call if_changed,relocs)
+
+OBJCOPYFLAGS_vmlinux.img := -O binary $(strip-flags)
+$(obj)/vmlinux.img: $(VMLINUX) FORCE
+	$(call if_changed,objcopy)
+
+quiet_cmd_bin = BIN     $@
+      cmd_bin = cat $^ > $@
+$(obj)/vmlinux.bin: $(obj)/vmlinux.img $(obj)/vmlinux.relocs
+	$(call if_changed,bin)
+endif
 
 targets += vmlinux.srec
 quiet_cmd_srec = OBJCOPY $@
-- 
2.1.4
