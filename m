Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:09:45 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:46493 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23619944AbYKKXJm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:09:42 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 2210938F995C;
	Wed, 12 Nov 2008 00:09:35 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: fix bit swapping in rb532_set_bit()
Date:	Wed, 12 Nov 2008 00:09:30 +0100
Message-Id: <1226444970-29272-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081103150542.GB13461@nuty>
References: <20081103150542.GB13461@nuty>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

This is a simplified version of the original fix, thanks to Atsushi Nemoto for
the hint.

Greetings, Phil

---

The algorithm works unconditionally. If bitval is one, the first line is
a no op and the second line sets the bit at offset position. Vice versa,
if bitval is zero, the first line clears the bit at offset position and
the second line is a no op.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 0e84c8a..e35cb75 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -119,13 +119,11 @@ static inline void rb532_set_bit(unsigned bitval,
 	unsigned long flags;
 	u32 val;
 
-	bitval = !!bitval;              /* map parameter to {0,1} */
-
 	local_irq_save(flags);
 
 	val = readl(ioaddr);
-	val &= ~( ~bitval << offset );   /* unset bit if bitval == 0 */
-	val |=  (  bitval << offset );   /* set bit if bitval == 1 */
+	val &= ~(!bitval << offset);   /* unset bit if bitval == 0 */
+	val |= (!!bitval << offset);   /* set bit if bitval == 1 */
 	writel(val, ioaddr);
 
 	local_irq_restore(flags);
-- 
1.5.6.4
