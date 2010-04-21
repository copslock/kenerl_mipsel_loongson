Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Apr 2010 20:57:13 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:34120 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491891Ab0DUS5J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Apr 2010 20:57:09 +0200
Received: id: bigeasy by Chamillionaire.breakpoint.cc with local
        (easymta 1.00 BETA 1)
        id 1O4f6i-00020o-Jq; Wed, 21 Apr 2010 20:57:08 +0200
Date:   Wed, 21 Apr 2010 20:57:08 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] mips/sb1250: include correct header, remove a warning
Message-ID: <20100421185708.GB7708@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Key-Id: FE3F4706
X-Key-Fingerprint: FFDA BBBB 3563 1B27 75C9  925B 98D5 5C1C FE3F 4706
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <sebastian@breakpoint.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
Precedence: bulk
X-list: linux-mips

| arch/mips/pci/pci-sb1250.c: In function sb1250_pcibios_init:
| arch/mips/pci/pci-sb1250.c:257: warning: assignment makes integer from pointer without a cast
| arch/mips/pci/pci-sb1250.c:285: error: MAX_NR_CONSOLES undeclared (first use in this function)
| arch/mips/pci/pci-sb1250.c:285: error: (Each undeclared identifier is reported only once
| arch/mips/pci/pci-sb1250.c:285: error: for each function it appears in.)

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/mips/pci/pci-sb1250.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pci/pci-sb1250.c b/arch/mips/pci/pci-sb1250.c
index ada24e6..1711e8e 100644
--- a/arch/mips/pci/pci-sb1250.c
+++ b/arch/mips/pci/pci-sb1250.c
@@ -37,6 +37,7 @@
 #include <linux/mm.h>
 #include <linux/console.h>
 #include <linux/tty.h>
+#include <linux/vt.h>
 
 #include <asm/io.h>
 
@@ -254,7 +255,7 @@ static int __init sb1250_pcibios_init(void)
 	 * XXX ehs: Should this happen in PCI Device mode?
 	 */
 	io_map_base = ioremap(A_PHYS_LDTPCI_IO_MATCH_BYTES, 1024 * 1024);
-	sb1250_controller.io_map_base = io_map_base;
+	sb1250_controller.io_map_base = (unsigned long)io_map_base;
 	set_io_port_base((unsigned long)io_map_base);
 
 #ifdef CONFIG_SIBYTE_HAS_LDT
-- 
1.6.6.1
