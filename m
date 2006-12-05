Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Dec 2006 16:21:09 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:24526 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039016AbWLEQVD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Dec 2006 16:21:03 +0000
Received: from localhost (p2151-ipad26funabasi.chiba.ocn.ne.jp [220.104.88.151])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 075D2BB5B; Wed,  6 Dec 2006 01:20:58 +0900 (JST)
Date:	Wed, 06 Dec 2006 01:20:57 +0900 (JST)
Message-Id: <20061206.012057.119272708.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] genirq: use name instead of typename
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
X-archive-position: 13344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The "typename" field was obsoleted by the "name" field.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index b339798..2fe4c86 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -117,7 +117,7 @@ #else
 		for_each_online_cpu(j)
 			seq_printf(p, "%10u ", kstat_cpu(j).irqs[i]);
 #endif
-		seq_printf(p, " %14s", irq_desc[i].chip->typename);
+		seq_printf(p, " %14s", irq_desc[i].chip->name);
 		seq_printf(p, "  %s", action->name);
 
 		for (action=action->next; action; action = action->next)
