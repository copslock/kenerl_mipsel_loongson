Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 13:48:14 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:27850 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022530AbXJ2NsF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2007 13:48:05 +0000
Received: from localhost (p8060-ipad401funabasi.chiba.ocn.ne.jp [123.217.242.60])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 53CA19B2E; Mon, 29 Oct 2007 22:46:43 +0900 (JST)
Date:	Mon, 29 Oct 2007 22:48:41 +0900 (JST)
Message-Id: <20071029.224841.18284310.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Add __cpuinit for some cevt-r4k functions
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17284
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index a59f67f..e62bc87 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -133,7 +133,7 @@ static void mips_broadcast(cpumask_t mask)
 		smtc_send_ipi(cpu, SMTC_CLOCK_TICK, 0);
 }
 
-static void setup_smtc_dummy_clockevent_device(void)
+static void __cpuinit setup_smtc_dummy_clockevent_device(void)
 {
 	//uint64_t mips_freq = mips_hpt_^frequency;
 	unsigned int cpu = smp_processor_id();
@@ -172,12 +172,12 @@ static void mips_event_handler(struct clock_event_device *dev)
 /*
  * FIXME: This doesn't hold for the relocated E9000 compare interrupt.
  */
-static int c0_compare_int_pending(void)
+static int __cpuinit c0_compare_int_pending(void)
 {
 	return (read_c0_cause() >> cp0_compare_irq) & 0x100;
 }
 
-static int c0_compare_int_usable(void)
+static int __cpuinit c0_compare_int_usable(void)
 {
 	unsigned int delta;
 	unsigned int cnt;
