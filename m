Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2008 17:44:54 +0100 (BST)
Received: from mgw2.diku.dk ([130.225.96.92]:56248 "EHLO mgw2.diku.dk")
	by ftp.linux-mips.org with ESMTP id S28575441AbYGVQov (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2008 17:44:51 +0100
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 35EB519BB88;
	Tue, 22 Jul 2008 18:44:50 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26238-17; Tue, 22 Jul 2008 18:44:49 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 0719E19BB53;
	Tue, 22 Jul 2008 18:44:49 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4BBFE6DFAB3; Tue, 22 Jul 2008 18:42:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3767)
	id E1B334F9F95; Tue, 22 Jul 2008 18:44:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id E0C4C4F9F94;
	Tue, 22 Jul 2008 18:44:48 +0200 (CEST)
Date:	Tue, 22 Jul 2008 18:44:48 +0200 (CEST)
From:	Julia Lawall <julia@diku.dk>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] : Add local_irq_restore in error handling code
Message-ID: <Pine.LNX.4.64.0807221844250.2670@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: amavisd-new at diku.dk
Return-Path: <julia@diku.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julia@diku.dk
Precedence: bulk
X-list: linux-mips

From: Julia Lawall <julia@diku.dk>

There is a call to local_irq_restore in the normal exit case, so it would
seem that there should be one on an error return as well.

The semantic patch that makes this change is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression l;
expression E,E1,E2;
@@

local_irq_save(l);
... when != local_irq_restore(l)
    when != spin_unlock_irqrestore(E,l)
    when any
    when strict
(
if (...) { ... when != local_irq_restore(l)
               when != spin_unlock_irqrestore(E1,l)
+   local_irq_restore(l);
    return ...;
}
|
if (...)
+   {local_irq_restore(l);
    return ...;
+   }
|
spin_unlock_irqrestore(E2,l);
|
local_irq_restore(l);
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/mips/mm/tlb-r3k.c        |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index a782549..7d7e822 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -247,6 +247,7 @@ void __init add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
 		w = read_c0_wired();
 		write_c0_wired(w + 1);
 		if (read_c0_wired() != w + 1) {
+			local_irq_restore(flags);
 			printk("[tlbwired] No WIRED reg?\n");
 			return;
 		}
