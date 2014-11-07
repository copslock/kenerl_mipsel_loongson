Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2014 12:49:00 +0100 (CET)
Received: from dotsec.net ([62.75.224.215]:52980 "EHLO styx.dotsec.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012870AbaKGLs7R2y0h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Nov 2014 12:48:59 +0100
Received: from e177050201.adsl.alicedsl.de ([85.177.50.201] helo=localhost.localdomain)
        by styx.dotsec.net with esmtpa (Exim 4.71)
        (envelope-from <albeu@free.fr>)
        id 1Xmhzp-0000ix-B5; Fri, 07 Nov 2014 12:47:33 +0100
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 2/2] MIPS: ath79: Read the initrd address from the firmware environment
Date:   Fri,  7 Nov 2014 12:44:36 +0100
Message-Id: <1415360676-28064-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1415360676-28064-1-git-send-email-albeu@free.fr>
References: <1415360676-28064-1-git-send-email-albeu@free.fr>
X-SA-Score: -1.0
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43915
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

Allow loading an initrd passed by the firmware.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/prom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index 80a0bff..e1fe630 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/string.h>
+#include <linux/initrd.h>
 
 #include <asm/bootinfo.h>
 #include <asm/addrspace.h>
@@ -23,6 +24,13 @@
 void __init prom_init(void)
 {
 	fw_init_cmdline();
+
+	/* Read the initrd address from the firmware environment */
+	initrd_start = fw_getenvl("initrd_start");
+	if (initrd_start) {
+		initrd_start = KSEG0ADDR(initrd_start);
+		initrd_end = initrd_start + fw_getenvl("initrd_size");
+	}
 }
 
 void __init prom_free_prom_memory(void)
-- 
2.0.0
