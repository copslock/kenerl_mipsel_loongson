Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Aug 2017 01:17:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49253 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995123AbdHGXRLjA4VI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Aug 2017 01:17:11 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 76FD0CD512A27;
        Tue,  8 Aug 2017 00:17:00 +0100 (IST)
Received: from localhost (10.20.1.88) by HHMAIL01.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 8 Aug 2017 00:17:05
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS: Set ISA bit in entry-y for microMIPS kernels
Date:   Mon, 7 Aug 2017 16:16:47 -0700
Message-ID: <20170807231647.19551-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59414
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

When building a kernel for the microMIPS ISA, ensure that the ISA bit
(ie. bit 0) in the entry address is set. Otherwise we may include an
entry address in images which bootloaders will jump to as MIPS32 code.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

I originally tried using "objdump -f" to obtain the entry address, which
works for microMIPS but it always outputs a 32 bit address for a 32 bit
ELF whilst nm will sign extend to 64 bit. That matters for systems where
we might want to run a MIPS32 kernel on a MIPS64 CPU & load it with a
MIPS64 bootloader, which would then jump to a non-canonical
(non-sign-extended) address.

This works in all cases as it only changes the behaviour for microMIPS
kernels, but isn't the prettiest solution. A possible alternative would
be to write a custom tool to just extract, sign extend & print the entry
point of an ELF executable. I'm open to feedback if that would be
preferred.
---
 arch/mips/Makefile | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 876394554274..d78d615cd395 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -242,8 +242,21 @@ include arch/mips/Kbuild.platforms
 ifdef CONFIG_PHYSICAL_START
 load-y					= $(CONFIG_PHYSICAL_START)
 endif
-entry-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
+
+entry-noisa-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
 					| grep "\bkernel_entry\b" | cut -f1 -d \ )
+ifdef CONFIG_CPU_MICROMIPS
+  #
+  # Set the ISA bit, since the kernel_entry symbol in the ELF will have it
+  # clear which would lead to images containing addresses which bootloaders may
+  # jump to as MIPS32 code.
+  #
+  entry-y = $(patsubst %0,%1,$(patsubst %2,%3,$(patsubst %4,%5, \
+              $(patsubst %6,%7,$(patsubst %8,%9,$(patsubst %a,%b, \
+              $(patsubst %c,%d,$(patsubst %e,%f,$(entry-noisa-y)))))))))
+else
+  entry-y = $(entry-noisa-y)
+endif
 
 cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
-- 
2.14.0
