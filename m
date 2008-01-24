Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2008 17:01:01 +0000 (GMT)
Received: from smtp06.mtu.ru ([62.5.255.53]:65530 "EHLO smtp06.mtu.ru")
	by ftp.linux-mips.org with ESMTP id S20037147AbYAXQxM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Jan 2008 16:53:12 +0000
Received: from smtp06.mtu.ru (localhost [127.0.0.1])
	by smtp06.mtu.ru (Postfix) with ESMTP id 469558FF14D;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
Received: from localhost.localdomain (ppp85-140-77-152.pppoe.mtu-net.ru [85.140.77.152])
	by smtp06.mtu.ru (Postfix) with ESMTP id 23BCE8FF0F8;
	Thu, 24 Jan 2008 19:53:03 +0300 (MSK)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] [MIPS] Malta, Atlas: move an extern function declaration to the header file
Date:	Thu, 24 Jan 2008 19:52:53 +0300
Message-Id: <1201193577-4261-14-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
In-Reply-To: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
References: <1201193577-4261-1-git-send-email-dmitri.vorobiev@gmail.com>
X-DCC-STREAM-Metrics: smtp06.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

This was compile-tested using default configs for the boards
affected by this change.

This patch does not introduce any functional changes.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
---
 arch/mips/mips-boards/atlas/atlas_setup.c |    4 ----
 arch/mips/mips-boards/malta/malta_setup.c |    4 ----
 include/asm-mips/mips-boards/generic.h    |    4 ++++
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mips-boards/atlas/atlas_setup.c b/arch/mips/mips-boards/atlas/atlas_setup.c
index 5ce8004..5c50080 100644
--- a/arch/mips/mips-boards/atlas/atlas_setup.c
+++ b/arch/mips/mips-boards/atlas/atlas_setup.c
@@ -34,10 +34,6 @@
 #include <asm/time.h>
 #include <asm/traps.h>
 
-#ifdef CONFIG_KGDB
-extern void kgdb_config(void);
-#endif
-
 static void __init serial_init(void);
 
 const char *get_system_type(void)
diff --git a/arch/mips/mips-boards/malta/malta_setup.c b/arch/mips/mips-boards/malta/malta_setup.c
index 3e2de0b..8dacb6a 100644
--- a/arch/mips/mips-boards/malta/malta_setup.c
+++ b/arch/mips/mips-boards/malta/malta_setup.c
@@ -35,10 +35,6 @@
 #include <linux/console.h>
 #endif
 
-#ifdef CONFIG_KGDB
-extern void kgdb_config(void);
-#endif
-
 struct resource standard_io_resources[] = {
 	{
 		.name = "dma1",
diff --git a/include/asm-mips/mips-boards/generic.h b/include/asm-mips/mips-boards/generic.h
index 2ca6bda..1c39d33 100644
--- a/include/asm-mips/mips-boards/generic.h
+++ b/include/asm-mips/mips-boards/generic.h
@@ -105,4 +105,8 @@ extern void mips_pcibios_init(void);
 #define mips_pcibios_init() do { } while (0)
 #endif
 
+#ifdef CONFIG_KGDB
+extern void kgdb_config(void);
+#endif
+
 #endif  /* __ASM_MIPS_BOARDS_GENERIC_H */
-- 
1.5.3
