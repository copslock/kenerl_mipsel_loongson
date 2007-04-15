Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Apr 2007 16:29:36 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:12249 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022642AbXDOP1Z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 15 Apr 2007 16:27:25 +0100
Received: (qmail 19488 invoked by uid 511); 15 Apr 2007 15:28:06 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.197)
  by lemote.com with SMTP; 15 Apr 2007 15:28:06 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 12/16] cheat for support of more than 256MB memory
Date:	Sun, 15 Apr 2007 23:26:01 +0800
Message-Id: <1176650766685-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11766507663039-git-send-email-tiansm@lemote.com>
References: <11766507651736-git-send-email-tiansm@lemote.com> <11766507661317-git-send-email-tiansm@lemote.com> <11766507661726-git-send-email-tiansm@lemote.com> <11766507662638-git-send-email-tiansm@lemote.com> <11766507661133-git-send-email-tiansm@lemote.com> <11766507661526-git-send-email-tiansm@lemote.com> <11766507662650-git-send-email-tiansm@lemote.com> <11766507661684-git-send-email-tiansm@lemote.com> <117665076617-git-send-email-tiansm@lemote.com> <1176650766907-git-send-email-tiansm@lemote.com> <11766507663301-git-send-email-tiansm@lemote.com> <11766507663039-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14848
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
1.4.4.1
