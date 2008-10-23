Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Oct 2008 16:21:46 +0100 (BST)
Received: from xylophone.i-cable.com ([203.83.115.99]:32970 "HELO
	xylophone.i-cable.com") by ftp.linux-mips.org with SMTP
	id S22227029AbYJWPV0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Oct 2008 16:21:26 +0100
Received: (qmail 2790 invoked by uid 508); 23 Oct 2008 15:21:18 -0000
Received: from 203.83.114.122 by xylophone (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7737.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.165884 secs); 23 Oct 2008 15:21:18 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 23 Oct 2008 15:21:17 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id m9NFLFMH021434;
	Thu, 23 Oct 2008 23:21:17 +0800 (CST)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 2/2] added io_map_base to pci_controller on Lemote Loongson 2E box
Date:	Thu, 23 Oct 2008 23:02:22 +0000
Message-Id: <1224802942-5969-2-git-send-email-r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <1224802942-5969-1-git-send-email-r0bertz@gentoo.org>
References: <n>
 <1224802942-5969-1-git-send-email-r0bertz@gentoo.org>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
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
