Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 14:30:37 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:42891 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23053741AbYKCOaf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 14:30:35 +0000
Received: from base (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id A0273386DBBE;
	Mon,  3 Nov 2008 15:30:28 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: fix bit swapping in rb532_set_bit()
Date:	Mon,  3 Nov 2008 15:30:25 +0100
Message-Id: <1225722625-19750-1-git-send-email-n0-1@freewrt.org>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081103142942.GA13461@nuty>
References: <20081103142942.GA13461@nuty>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

The algorithm works unconditionally. If bitval is one, the first line is
a no op and the second line sets the bit at offset position. Vice versa,
if bitval is zero, the first line clears the bit at offset position and
the second line is a no op.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 0e84c8a..ba9a0c4 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -124,8 +124,8 @@ static inline void rb532_set_bit(unsigned bitval,
 	local_irq_save(flags);
 
 	val = readl(ioaddr);
-	val &= ~( ~bitval << offset );   /* unset bit if bitval == 0 */
-	val |=  (  bitval << offset );   /* set bit if bitval == 1 */
+	val &= ~(!bitval << offset);   /* unset bit if bitval == 0 */
+	val |=  (bitval << offset);   /* set bit if bitval == 1 */
 	writel(val, ioaddr);
 
 	local_irq_restore(flags);
-- 
1.5.6.4
