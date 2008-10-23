Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 18:08:44 +0100 (BST)
Received: from crux.i-cable.com ([203.83.115.104]:12958 "HELO crux.i-cable.com")
	by ftp.linux-mips.org with SMTP id S22144992AbYJVRIX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2008 18:08:23 +0100
Received: (qmail 9121 invoked by uid 107); 22 Oct 2008 17:08:10 -0000
Received: from 203.83.114.121 by crux (envelope-from <r0bertz@gentoo.org>, uid 104) with qmail-scanner-2.01 
 (clamdscan: 0.93.3/7716. spamassassin: 2.63.  
 Clear:RC:1(203.83.114.121):SA:0(4.6/5.0):. 
 Processed in 6.33387 secs); 22 Oct 2008 17:08:10 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 22 Oct 2008 17:08:04 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9MH7qwV007666;
	Thu, 23 Oct 2008 01:08:03 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] added io_map_base to pci_controller on Lemote 2e box
Date:	Thu, 23 Oct 2008 00:48:59 +0000
Message-Id: <1224722939-18557-2-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
References: <1224722939-18557-1-git-send-email-r0bertz@gentoo.org>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20844
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

---
 arch/mips/lemote/lm2e/pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lemote/lm2e/pci.c b/arch/mips/lemote/lm2e/pci.c
index c1e41f1..dd04957 100644
--- a/arch/mips/lemote/lm2e/pci.c
+++ b/arch/mips/lemote/lm2e/pci.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <asm/mips-boards/bonito64.h>
+#include <asm/lemote/pci.h>
 
 extern struct pci_ops bonito64_pci_ops;
 
@@ -53,6 +54,7 @@ static struct pci_controller  loongson2e_pci_controller = {
 	.mem_resource   = &loongson2e_pci_mem_resource,
 	.mem_offset     = 0x00000000UL,
 	.io_offset      = 0x00000000UL,
+	.io_map_base    = LEMOTE_IO_PORT_BASE,
 };
 
 static void __init ict_pcimap(void)
-- 
1.6.0.2
