Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 16:54:39 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:3281 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038324AbXB1Qyg (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2007 16:54:36 +0000
Received: from localhost (p5152-ipad28funabasi.chiba.ocn.ne.jp [220.107.204.152])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 630BEA6FA; Thu,  1 Mar 2007 01:53:13 +0900 (JST)
Date:	Thu, 01 Mar 2007 01:53:13 +0900 (JST)
Message-Id: <20070301.015313.01916691.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] No need to write c0_compare in plat_timer_setup
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
X-archive-position: 14279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If R4k counter was used for hpt_timer and interrupt source,
c0_hpt_timer_init() initializes the c0_compare register.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/lasat/setup.c                |    1 -
 arch/mips/mips-boards/generic/time.c   |    3 ---
 arch/mips/mips-boards/sim/sim_time.c   |    3 ---
 arch/mips/tx4927/common/tx4927_setup.c |   10 ----------
 arch/mips/tx4938/common/setup.c        |    9 ---------
 5 files changed, 26 deletions(-)

diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
index 14c5516..b27b47c 100644
--- a/arch/mips/lasat/setup.c
+++ b/arch/mips/lasat/setup.c
@@ -116,7 +116,6 @@ static void lasat_time_init(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	write_c0_compare( read_c0_count() + mips_hpt_frequency / HZ);
 	change_c0_status(ST0_IM, IE_IRQ0 | IE_IRQ5);
 }
 
diff --git a/arch/mips/mips-boards/generic/time.c b/arch/mips/mips-boards/generic/time.c
index a3c3a1d..df2a2bd 100644
--- a/arch/mips/mips-boards/generic/time.c
+++ b/arch/mips/mips-boards/generic/time.c
@@ -295,7 +295,4 @@ void __init plat_timer_setup(struct irqa
 	irq_desc[mips_cpu_timer_irq].status |= IRQ_PER_CPU;
 	set_irq_handler(mips_cpu_timer_irq, handle_percpu_irq);
 #endif
-
-        /* to generate the first timer interrupt */
-	write_c0_compare (read_c0_count() + mips_hpt_frequency/HZ);
 }
diff --git a/arch/mips/mips-boards/sim/sim_time.c b/arch/mips/mips-boards/sim/sim_time.c
index 30711d0..d3a21c7 100644
--- a/arch/mips/mips-boards/sim/sim_time.c
+++ b/arch/mips/mips-boards/sim/sim_time.c
@@ -199,7 +199,4 @@ void __init plat_timer_setup(struct irqa
 	irq_desc[mips_cpu_timer_irq].flags |= IRQ_PER_CPU;
 	set_irq_handler(mips_cpu_timer_irq, handle_percpu_irq);
 #endif
-
-	/* to generate the first timer interrupt */
-	write_c0_compare(read_c0_count() + (mips_hpt_frequency/HZ));
 }
diff --git a/arch/mips/tx4927/common/tx4927_setup.c b/arch/mips/tx4927/common/tx4927_setup.c
index 941c441..c8e49fe 100644
--- a/arch/mips/tx4927/common/tx4927_setup.c
+++ b/arch/mips/tx4927/common/tx4927_setup.c
@@ -81,18 +81,8 @@ void __init tx4927_time_init(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	u32 count;
-	u32 c1;
-	u32 c2;
-
 	setup_irq(TX4927_IRQ_CPU_TIMER, irq);
 
-	/* to generate the first timer interrupt */
-	c1 = read_c0_count();
-	count = c1 + (mips_hpt_frequency / HZ);
-	write_c0_compare(count);
-	c2 = read_c0_count();
-
 #ifdef CONFIG_TOSHIBA_RBTX4927
 	{
 		extern void toshiba_rbtx4927_timer_setup(struct irqaction
diff --git a/arch/mips/tx4938/common/setup.c b/arch/mips/tx4938/common/setup.c
index dc87d92..142abf4 100644
--- a/arch/mips/tx4938/common/setup.c
+++ b/arch/mips/tx4938/common/setup.c
@@ -55,14 +55,5 @@ tx4938_time_init(void)
 
 void __init plat_timer_setup(struct irqaction *irq)
 {
-	u32 count;
-	u32 c1;
-	u32 c2;
-
 	setup_irq(TX4938_IRQ_CPU_TIMER, irq);
-
-	c1 = read_c0_count();
-	count = c1 + (mips_hpt_frequency / HZ);
-	write_c0_compare(count);
-	c2 = read_c0_count();
 }
