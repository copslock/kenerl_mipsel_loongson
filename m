Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:55:51 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:23503 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580939AbYHSNzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:20 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 96548B699; Tue, 19 Aug 2008 22:55:15 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 03/14] TXx9: Add prom_getenv
Date:	Tue, 19 Aug 2008 22:55:07 +0900
Message-Id: <1219154118-21193-3-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add prom_getenv() which can be used for YAMON.  This assumes other
firmware should pass NULL for fw_arg2.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c  |   15 +++++++++++++++
 include/asm-mips/txx9/generic.h |    1 +
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index b75022b..4ccc735 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -211,6 +211,21 @@ char * __init prom_getcmdline(void)
 	return &(arcs_cmdline[0]);
 }
 
+const char *__init prom_getenv(const char *name)
+{
+	const s32 *str = (const s32 *)fw_arg2;
+
+	if (!str)
+		return NULL;
+	/* YAMON style ("name", "value" pairs) */
+	while (str[0] && str[1]) {
+		if (!strcmp((const char *)(unsigned long)str[0], name))
+			return (const char *)(unsigned long)str[1];
+		str += 2;
+	}
+	return NULL;
+}
+
 static void __noreturn txx9_machine_halt(void)
 {
 	local_irq_disable();
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index c9eed7e..0a225bf 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -43,6 +43,7 @@ struct txx9_board_vec {
 extern struct txx9_board_vec *txx9_board_vec;
 extern int (*txx9_irq_dispatch)(int pending);
 char *prom_getcmdline(void);
+const char *prom_getenv(const char *name);
 void txx9_wdt_init(unsigned long base);
 void txx9_spi_init(int busid, unsigned long base, int irq);
 void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
-- 
1.5.6.3
