Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Sep 2008 14:24:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42718 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031457AbYIANWq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Sep 2008 14:22:46 +0100
Received: from localhost.localdomain (p5198-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E65BFB532; Mon,  1 Sep 2008 22:22:39 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 6/6] TXx9: Implement prom_free_prom_memory
Date:	Mon,  1 Sep 2008 22:22:41 +0900
Message-Id: <1220275361-5001-6-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 8731e16..419f574 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -28,6 +28,7 @@
 #include <asm/time.h>
 #include <asm/reboot.h>
 #include <asm/r4kcache.h>
+#include <asm/sections.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9tmr.h>
@@ -393,6 +394,11 @@ void __init prom_init(void)
 
 void __init prom_free_prom_memory(void)
 {
+	unsigned long saddr = PAGE_SIZE;
+	unsigned long eaddr = __pa_symbol(&_text);
+
+	if (saddr < eaddr)
+		free_init_pages("prom memory", saddr, eaddr);
 }
 
 const char *get_system_type(void)
-- 
1.5.6.3
