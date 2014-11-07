Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:47:11 +0100 (CET)
Received: from dotsec.net ([62.75.224.215]:40877 "EHLO styx.dotsec.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012870AbaKGLrKWSVRy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 12:47:10 +0100
Received: from e177050201.adsl.alicedsl.de ([85.177.50.201] helo=localhost.localdomain)
        by styx.dotsec.net with esmtpa (Exim 4.71)
        (envelope-from <albeu@free.fr>)
        id 1Xmhyc-0000ix-Qn; Fri, 07 Nov 2014 12:46:27 +0100
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/2] MIPS: ath79: Use the firmware lib to parse the kernel command line
Date:   Fri,  7 Nov 2014 12:44:35 +0100
Message-Id: <1415360676-28064-1-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
X-SA-Score: -1.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

No need to duplicate code that is available in the firmware library.
It also give us access to the firmware environment which is needed
to read the initrd address and size.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/prom.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index e9cbd7c..80a0bff 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -16,39 +16,13 @@
 
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
+#include <asm/fw/fw.h>
 
 #include "common.h"
 
-static inline int is_valid_ram_addr(void *addr)
-{
-	if (((u32) addr > KSEG0) &&
-	    ((u32) addr < (KSEG0 + ATH79_MEM_SIZE_MAX)))
-		return 1;
-
-	if (((u32) addr > KSEG1) &&
-	    ((u32) addr < (KSEG1 + ATH79_MEM_SIZE_MAX)))
-		return 1;
-
-	return 0;
-}
-
-static __init void ath79_prom_init_cmdline(int argc, char **argv)
-{
-	int i;
-
-	if (!is_valid_ram_addr(argv))
-		return;
-
-	for (i = 0; i < argc; i++)
-		if (is_valid_ram_addr(argv[i])) {
-			strlcat(arcs_cmdline, " ", sizeof(arcs_cmdline));
-			strlcat(arcs_cmdline, argv[i], sizeof(arcs_cmdline));
-		}
-}
-
 void __init prom_init(void)
 {
-	ath79_prom_init_cmdline(fw_arg0, (char **)fw_arg1);
+	fw_init_cmdline();
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.0.0
