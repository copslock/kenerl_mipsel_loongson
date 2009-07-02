Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:46:23 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:35884 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491996AbZGBCqC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 04:46:02 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n622eKX5016281
	for <linux-mips@linux-mips.org>; Wed, 1 Jul 2009 19:40:20 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 1 Jul 2009 19:40:19 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n622eJhb005976;
	Wed, 1 Jul 2009 19:40:19 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH 01/15] Due to some broken bitfiles, we can't trust IntCtl
To:	linux-mips@linux-mips.org
Cc:	chris@mips.com
Date:	Wed, 01 Jul 2009 19:39:54 -0700
Message-ID: <20090702023954.23268.98988.stgit@linux-raghu>
In-Reply-To: <20090702023938.23268.65453.stgit@linux-raghu>
References: <20090702023938.23268.65453.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2009 02:40:20.0038 (UTC) FILETIME=[70D30E60:01C9FABE]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

From: Robin Randhawa <robin@mips.com>

Signed-off-by: Chris Dearman <chris@mips.com>
---

 arch/mips/include/asm/irq.h |    1 +
 arch/mips/kernel/traps.c    |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 09b08d0..ca0b5ed 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -158,6 +158,7 @@ extern void free_irqno(unsigned int irq);
  * IE7.  Since R2 their number has to be read from the c0_intctl register.
  */
 #define CP0_LEGACY_COMPARE_IRQ 7
+#define CP0_LEGACY_PERFCNT_IRQ 7
 
 extern int cp0_compare_irq;
 extern int cp0_perfcount_irq;
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 08f1edf..0b6e328 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1538,7 +1538,11 @@ void __cpuinit per_cpu_trap_init(void)
 	 */
 	if (cpu_has_mips_r2) {
 		cp0_compare_irq = (read_c0_intctl() >> 29) & 7;
+		if (!cp0_compare_irq)
+			cp0_compare_irq = CP0_LEGACY_COMPARE_IRQ;
 		cp0_perfcount_irq = (read_c0_intctl() >> 26) & 7;
+		if (!cp0_perfcount_irq)
+			cp0_perfcount_irq = CP0_LEGACY_PERFCNT_IRQ;
 		if (cp0_perfcount_irq == cp0_compare_irq)
 			cp0_perfcount_irq = -1;
 	} else {
