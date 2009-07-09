Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2009 02:01:04 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:45270 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492562AbZGIAA5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Jul 2009 02:00:57 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.60])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6900ma4025175;
	Wed, 8 Jul 2009 17:00:49 -0700
Received: from mercury.mips.com ([192.168.64.101]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 8 Jul 2009 17:00:48 -0700
Received: from [192.168.65.97] (linux-raghu [192.168.65.97])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id n6900kXa019402;
	Wed, 8 Jul 2009 17:00:47 -0700 (PDT)
From:	Raghu Gandham <raghu@mips.com>
Subject: [PATCH] Fix compile error when SMTC support is enabled
To:	linux-mips@linux-mips.org
Cc:	tanderson@mvista.com, raghu@mips.com
Date:	Wed, 08 Jul 2009 17:00:44 -0700
Message-ID: <20090709000044.26885.95760.stgit@linux-raghu>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Jul 2009 00:00:48.0545 (UTC) FILETIME=[50A96110:01CA0028]
Return-Path: <raghu@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips

Commit fc03bc1715ca0ad4ccfe97aab16bcc9e7129c1a4 breaks when SMTC support is enabled on Malta.
This patch is a fix for that.

Signed-off-by: Raghu Gandham <raghu@mips.com>
---

 arch/mips/mti-malta/malta-int.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index a8756f8..3e0a9b3 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -331,6 +331,7 @@ static struct irqaction irq_call = {
 	.flags		= IRQF_DISABLED|IRQF_PERCPU,
 	.name		= "IPI_call"
 };
+#endif /* CONFIG_MIPS_MT_SMP */
 
 static int gic_resched_int_base;
 static int gic_call_int_base;
@@ -346,7 +347,6 @@ unsigned int plat_ipi_resched_int_xlate(unsigned int cpu)
 {
 	return GIC_RESCHED_INT(cpu);
 }
-#endif /* CONFIG_MIPS_MT_SMP */
 
 static struct irqaction i8259irq = {
 	.handler = no_action,
