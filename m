Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 05:45:24 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:10732 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022049AbXFFEnG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 05:43:06 +0100
Received: (qmail 26319 invoked by uid 511); 6 Jun 2007 04:50:08 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 04:50:08 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH] cheat for support of more than 256MB memory
Date:	Wed,  6 Jun 2007 12:42:39 +0800
Message-Id: <11811049643791-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811049622818-git-send-email-tiansm@lemote.com>
References: <11811049622818-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/kernel/setup.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 4975da0..62ef100 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -509,6 +509,14 @@ static void __init resource_init(void)
 		res->end = end;
 
 		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+#if defined(CONFIG_LEMOTE_FULONG) && defined(CONFIG_64BIT)
+		/* to keep memory continous, we tell system 0x10000000 - 0x20000000 is reserved
+		 * for memory, in fact it is io region, don't occupy it
+		 *
+		 * SPARSEMEM?
+		 */
+		if (boot_mem_map.map[i].type != BOOT_MEM_RESERVED)
+#endif
 		request_resource(&iomem_resource, res);
 
 		/*
-- 
1.5.2.1
