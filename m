Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 23:55:09 +0100 (CET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46240 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011192AbbJ2Wyt4jaKD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 23:54:49 +0100
Received: from localhost.localdomain (85-76-112-16-nat.elisa-mobile.fi [85.76.112.16])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 4D627699AA;
        Fri, 30 Oct 2015 00:54:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH v2 2/2] MIPS: OCTEON: omit ELF NOTE segments
Date:   Fri, 30 Oct 2015 00:54:48 +0200
Message-Id: <1446159288-22154-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1446159288-22154-1-git-send-email-aaro.koskinen@iki.fi>
References: <1446159288-22154-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

From: David Daney <ddaney@caviumnetworks.com>

OCTEON Pre-SDK-1.8.1 bootloaders can not handle PT_NOTE program headers,
so do not emit them.

Before the patch:

$ readelf --program-headers octeon-vmlinux

Elf file type is EXEC (Executable file)
Entry point 0xffffffff815d09d0
There are 2 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000001000 0xffffffff81100000 0xffffffff81100000
                 0x0000000000b57f80 0x0000000001b86360  RWE    1000
  NOTE           0x00000000004e02e0 0xffffffff815df2e0 0xffffffff815df2e0
                 0x0000000000000024 0x0000000000000024  R      4

After the patch:

$ readelf --program-headers octeon-vmlinux

Elf file type is EXEC (Executable file)
Entry point 0xffffffff815d09d0
There are 1 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000001000 0xffffffff81100000 0xffffffff81100000
                 0x0000000000b57f80 0x0000000001b86360  RWE    1000

The patch was tested on DSR-1000N router.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/vmlinux.lds.S | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 06632d6..cce2fcb 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -17,7 +17,9 @@ OUTPUT_ARCH(mips)
 ENTRY(kernel_entry)
 PHDRS {
 	text PT_LOAD FLAGS(7);	/* RWX */
+#ifndef CONFIG_CAVIUM_OCTEON_SOC
 	note PT_NOTE FLAGS(4);	/* R__ */
+#endif /* CAVIUM_OCTEON_SOC */
 }
 
 #ifdef CONFIG_32BIT
@@ -71,7 +73,12 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
-	NOTES :text :note
+#ifdef CONFIG_CAVIUM_OCTEON_SOC
+#define NOTES_HEADER
+#else /* CONFIG_CAVIUM_OCTEON_SOC */
+#define NOTES_HEADER :note
+#endif /* CONFIG_CAVIUM_OCTEON_SOC */
+	NOTES :text NOTES_HEADER
 	.dummy : { *(.dummy) } :text
 
 	_sdata = .;			/* Start of data section */
-- 
2.4.0
