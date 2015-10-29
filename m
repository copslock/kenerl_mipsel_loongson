Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 23:54:51 +0100 (CET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46239 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011838AbbJ2WytyaJGD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2015 23:54:49 +0100
Received: from localhost.localdomain (85-76-112-16-nat.elisa-mobile.fi [85.76.112.16])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 237E36996E;
        Fri, 30 Oct 2015 00:54:49 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH v2 1/2] MIPS: vmlinux: discard .MIPS.abiflags
Date:   Fri, 30 Oct 2015 00:54:47 +0200
Message-Id: <1446159288-22154-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49773
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

Discard .MIPS.abiflags from vmlinux. It's not needed and will cause
issues e.g. with old OCTEON bootloaders that cannot tolerate
additional program headers.

Before the patch:

$ readelf --program-headers octeon-vmlinux

Elf file type is EXEC (Executable file)
Entry point 0xffffffff815d09d0
There are 3 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  ABIFLAGS       0x00000000005e77f0 0xffffffff816e67f0 0xffffffff816e67f0
                 0x0000000000000018 0x0000000000000018  R      8
  LOAD           0x0000000000001000 0xffffffff81100000 0xffffffff81100000
                 0x0000000000b57f80 0x0000000001b86360  RWE    1000
  NOTE           0x00000000004e02e0 0xffffffff815df2e0 0xffffffff815df2e0
                 0x0000000000000024 0x0000000000000024  R      4

After the patch:

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

Suggested-by: Matthew Fortune <matthew.fortune@imgtec.com>
Suggested-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 07d32a4..06632d6 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -181,6 +181,7 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		/* ABI crap starts here */
+		*(.MIPS.abiflags)
 		*(.MIPS.options)
 		*(.options)
 		*(.pdr)
-- 
2.4.0
