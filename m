Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 09:11:21 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:25364 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133422AbVJUILF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 09:11:05 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 21 Oct 2005 08:12:12 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id CCC6D1FF0A;
	Fri, 21 Oct 2005 17:12:08 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id C0FC11FEF8;
	Fri, 21 Oct 2005 17:12:08 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j9L8C8hO010005;
	Fri, 21 Oct 2005 17:12:08 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 21 Oct 2005 17:12:08 +0900 (JST)
Message-Id: <20051021.171208.55510690.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Call flush_icache_range for handle_tlb[lsm]
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Call flush_icache_range for handle_tlb[lsm].  These flushing were
removed by 452cafe60d0605e9af0c33bbef4f9443776461ea.  This patch add
them again in safe place.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1149,6 +1149,7 @@ static inline void signal32_init(void)
 
 extern void cpu_cache_init(void);
 extern void tlb_init(void);
+extern void flush_tlb_handlers(void);
 
 void __init per_cpu_trap_init(void)
 {
@@ -1356,4 +1357,5 @@ void __init trap_init(void)
 #endif
 
 	flush_icache_range(ebase, ebase + 0x400);
+	flush_tlb_handlers();
 }
diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1804,3 +1804,13 @@ void __init build_tlb_refill_handler(voi
 		}
 	}
 }
+
+void __init flush_tlb_handlers(void)
+{
+	flush_icache_range((unsigned long)handle_tlbl,
+			   (unsigned long)handle_tlbl + sizeof(handle_tlbl));
+	flush_icache_range((unsigned long)handle_tlbs,
+			   (unsigned long)handle_tlbs + sizeof(handle_tlbs));
+	flush_icache_range((unsigned long)handle_tlbm,
+			   (unsigned long)handle_tlbm + sizeof(handle_tlbm));
+}
