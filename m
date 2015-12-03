Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:09:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35737 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012364AbbLCKIbZb5bZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:31 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E7C6FA9C9123B
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:23 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:25 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:24 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 4/9] MIPS: Generate relocation table when CONFIG_RELOCATABLE
Date:   Thu, 3 Dec 2015 10:08:12 +0000
Message-ID: <1449137297-30464-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50309
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

When CONFIG_RELOCATABLE is enabled (added in later patch) add
--emit-relocs to vmlinux LDFLAGS so that fully linked vmlinux contains
relocation information.

Run the previously added relocs tool to fill in the .data.relocs section
of vmlinux with a table of relocations. The relocs tool will also remove
(mark as 0 length) the relocation sections added to vmlinux.

When vmlinux is passed to the boot makefile for conversion into a boot
image the now empty relocation sections will be removed and the
populated relocation table will be included in the binary image.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 33fbfd276671..5a01a9e21274 100644
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
@@ -319,6 +323,10 @@ rom.bin rom.sw: vmlinux
 		$(bootvars-y) $@
 endif
 
+CMD_RELOCS = arch/mips/boot/tools/relocs
+quiet_cmd_relocs = RELOCS  $<
+      cmd_relocs = $(CMD_RELOCS) $<
+
 #
 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
@@ -327,6 +335,11 @@ endif
 quiet_cmd_32 = OBJCOPY $@
 	cmd_32 = $(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
 vmlinux.32: vmlinux
+ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_64BIT),yy)
+# Currently, objcopy fails to handle the relocations in the elf64
+# So the relocs tool must be run here to remove them first
+	$(call cmd,relocs)
+endif
 	$(call cmd,32)
 
 #
@@ -342,6 +355,9 @@ all:	$(all-y)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE
+ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_32BIT),yy)
+	$(call cmd,relocs)
+endif
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
 		$(bootvars-y) arch/mips/boot/$@
 
-- 
2.1.4
