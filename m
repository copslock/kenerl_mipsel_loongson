Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 15:46:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:48325 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039417AbXBRPp5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2007 15:45:57 +0000
Received: from localhost (p2027-ipad11funabasi.chiba.ocn.ne.jp [219.162.37.27])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 29189B7FE; Mon, 19 Feb 2007 00:44:35 +0900 (JST)
Date:	Mon, 19 Feb 2007 00:44:35 +0900 (JST)
Message-Id: <20070219.004435.25910295.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make __declare_dbe_table() static
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make __declare_dbe_table() static and call it explicitly to ensure not
optimized out.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index cfd1785..78a3f75 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -340,7 +340,7 @@ NORET_TYPE void ATTRIB_NORET die(const c
 extern const struct exception_table_entry __start___dbe_table[];
 extern const struct exception_table_entry __stop___dbe_table[];
 
-void __declare_dbe_table(void)
+static void __declare_dbe_table(void)
 {
 	__asm__ __volatile__(
 	".section\t__dbe_table,\"a\"\n\t"
@@ -1576,4 +1576,5 @@ void __init trap_init(void)
 
 	flush_icache_range(ebase, ebase + 0x400);
 	flush_tlb_handlers();
+	__declare_dbe_table();
 }
