Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 11:07:26 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14027 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025480AbcCaJGTINHXq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Mar 2016 11:06:19 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id DFD7C21F07DDF;
        Thu, 31 Mar 2016 10:06:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:13 +0100
Received: from mredfearn-linux.kl.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 31 Mar 2016 10:06:12 +0100
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <kernel-hardening@lists.openwall.com>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/11] MIPS: Generate relocation table when CONFIG_RELOCATABLE
Date:   Thu, 31 Mar 2016 10:05:35 +0100
Message-ID: <1459415142-3412-5-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
References: <1459415142-3412-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52811
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

Changes in v2: None

 arch/mips/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index fa25d60bc717..8388ef6a0044 100644
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
@@ -313,6 +317,10 @@ rom.bin rom.sw: vmlinux
 		$(bootvars-y) $@
 endif
 
+CMD_RELOCS = arch/mips/boot/tools/relocs
+quiet_cmd_relocs = RELOCS  $<
+      cmd_relocs = $(CMD_RELOCS) $<
+
 #
 # Some machines like the Indy need 32-bit ELF binaries for booting purposes.
 # Other need ECOFF, so we build a 32-bit ELF binary for them which we then
@@ -321,6 +329,11 @@ endif
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
@@ -336,6 +349,9 @@ all:	$(all-y)
 
 # boot
 $(boot-y): $(vmlinux-32) FORCE
+ifeq ($(CONFIG_RELOCATABLE)$(CONFIG_32BIT),yy)
+	$(call cmd,relocs)
+endif
 	$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) \
 		$(bootvars-y) arch/mips/boot/$@
 
-- 
2.5.0
