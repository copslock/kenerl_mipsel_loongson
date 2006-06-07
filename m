Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2006 17:08:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:15078 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134014AbWFGQIH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2006 17:08:07 +0100
Received: from localhost (p3137-ipad208funabasi.chiba.ocn.ne.jp [60.43.104.137])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BBE13881E; Thu,  8 Jun 2006 01:08:03 +0900 (JST)
Date:	Thu, 08 Jun 2006 01:09:01 +0900 (JST)
Message-Id: <20060608.010901.108121387.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051118.122242.07017522.nemoto@toshiba-tops.co.jp>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
	<20051116184201.GJ3229@linux-mips.org>
	<20051118.122242.07017522.nemoto@toshiba-tops.co.jp>
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
X-archive-position: 11691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Nov 2005 12:22:42 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> By datasheets, MIPS4K?, MIPS5Kc, TX49 (and TX39 using HALT bit instead
> of WAIT insn) allow us entering WAIT with interrupt disabled.

Updated against current git tree.


[MIPS] reduce race between cpu_wait() and need_resched() checking

If a thread became runnable between need_resched() and the WAIT
instruction, switching to the thread will delay until a next interrupt.
Some CPUs can execute the WAIT instruction with interrupt disabled, so
we can get rid of this race on them (at least UP case).

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 66e47e7..bc79c5b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -39,16 +39,33 @@ static void r3081_wait(void)
 
 static void r39xx_wait(void)
 {
-	unsigned long cfg = read_c0_conf();
-	write_c0_conf(cfg | TX39_CONF_HALT);
+	local_irq_disable();
+	if (!need_resched())
+		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
+	local_irq_enable();
 }
 
+/*
+ * There is a race when WAIT instruction executed with interrupt
+ * enabled.
+ * But it is implementation-dependent wheter the pipelie restarts when
+ * a non-enabled interrupt is requested.
+ */
 static void r4k_wait(void)
 {
 	__asm__(".set\tmips3\n\t"
 		"wait\n\t"
 		".set\tmips0");
 }
+static void r4k_wait_irqoff(void)
+{
+	local_irq_disable();
+	if (!need_resched())
+		__asm__(".set\tmips3\n\t"
+			"wait\n\t"
+			".set\tmips0");
+	local_irq_enable();
+}
 
 /* The Au1xxx wait is available only if using 32khz counter or
  * external timer source, but specifically not CP0 Counter. */
@@ -111,11 +128,6 @@ static inline void check_wait(void)
 	case CPU_R5000:
 	case CPU_NEVADA:
 	case CPU_RM7000:
-	case CPU_TX49XX:
-	case CPU_4KC:
-	case CPU_4KEC:
-	case CPU_4KSC:
-	case CPU_5KC:
 /*	case CPU_20KC:*/
 	case CPU_24K:
 	case CPU_25KF:
@@ -125,6 +137,14 @@ static inline void check_wait(void)
 		cpu_wait = r4k_wait;
 		printk(" available.\n");
 		break;
+	case CPU_TX49XX:
+	case CPU_4KC:
+	case CPU_4KEC:
+	case CPU_4KSC:
+	case CPU_5KC:
+		cpu_wait = r4k_wait_irqoff;
+		printk(" available.\n");
+		break;
 	case CPU_AU1000:
 	case CPU_AU1100:
 	case CPU_AU1500:
