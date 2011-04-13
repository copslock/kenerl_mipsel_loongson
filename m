Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 18:08:17 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:41953 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491170Ab1DMQIM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2011 18:08:12 +0200
Received: by iwn36 with SMTP id 36so848302iwn.36
        for <linux-mips@linux-mips.org>; Wed, 13 Apr 2011 09:08:06 -0700 (PDT)
Received: by 10.231.65.209 with SMTP id k17mr7966536ibi.127.1302710794226;
        Wed, 13 Apr 2011 09:06:34 -0700 (PDT)
Received: from [10.162.22.222] ([115.119.134.194])
        by mx.google.com with ESMTPS id d9sm522117ibb.36.2011.04.13.09.06.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 09:06:32 -0700 (PDT)
Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
From:   philby john <pjohn@mvista.com>
To:     linux-mips@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 13 Apr 2011 21:37:13 +0530
Message-ID: <1302710833.14458.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.1 (2.32.1-1.fc14) 
Content-Transfer-Encoding: 7bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

From: Philby John <pjohn@mvista.com>
Date: Wed, 13 Apr 2011 20:46:32 +0530
Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section

Some early Octeon bootloaders cannot process PT_NOTE program
headers as reported in numerous sections of the web, here is
an example http://www.spinics.net/lists/mips/msg37799.html
Loading usually fails with such an error ...
Error allocating memory for elf image!

The work around usually is to strip the .notes section by using
such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
It is expected that the vmlinux image got after compilation be
bootable. Add a Kconfig option to ignore the PT_NOTE section.

Signed-off-by: Philby John <pjohn@mvista.com>
---
 arch/mips/cavium-octeon/Kconfig |    8 ++++++++
 arch/mips/kernel/vmlinux.lds.S  |    6 ++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index caae228..ddecee3 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -90,6 +90,14 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
 	help
 	  Lock the kernel's implementation of memcpy() into L2.
 
+config DISABLE_ELF_NOTE_HEADER
+       bool "Disable the creation of the ELF PT_NOTE program header in vmlinux"
+       depends on CPU_CAVIUM_OCTEON
+       help
+         Some early Octeon bootloaders cannot process PT_NOTE program
+         headers.  Select y to omit these headers so that the kernel
+         can be loaded with older bootloaders.
+
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_STATIC
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 832afbb..0536910 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -8,7 +8,9 @@ OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 PHDRS {
 	text PT_LOAD FLAGS(7);	/* RWX */
+#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
 	note PT_NOTE FLAGS(4);	/* R__ */
+#endif
 }
 
 #ifdef CONFIG_32BIT
@@ -62,7 +64,11 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
+#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
 	NOTES :text :note
+#else
+	NOTES :text
+#endif
 	.dummy : { *(.dummy) } :text
 
 	RODATA
-- 
1.7.4
