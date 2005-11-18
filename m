Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2005 03:19:43 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:35622 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8134185AbVKRDTY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Nov 2005 03:19:24 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 18 Nov 2005 03:22:46 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 382A92005F;
	Fri, 18 Nov 2005 12:22:43 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 240C82005A;
	Fri, 18 Nov 2005 12:22:43 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAI3MghO052609;
	Fri, 18 Nov 2005 12:22:43 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Fri, 18 Nov 2005 12:22:42 +0900 (JST)
Message-Id: <20051118.122242.07017522.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20051116184201.GJ3229@linux-mips.org>
References: <20051117.011906.25910026.anemo@mba.ocn.ne.jp>
	<20051116184201.GJ3229@linux-mips.org>
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
X-archive-position: 9521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 16 Nov 2005 18:42:01 +0000, Ralf Baechle <ralf@linux-mips.org> said:
>> The CPU can surely exit from the WAIT instruction by interrupt even
>> if interrupts disabled?

ralf> That's implementation dependent behaviour, unfortunately.

Then how about this patch?

By datasheets, MIPS4K?, MIPS5Kc, TX49 (and TX39 using HALT bit instead
of WAIT insn) allow us entering WAIT with interrupt disabled.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index d2ae111..4bdd8c1 100644
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
@@ -112,11 +129,6 @@ static inline void check_wait(void)
 	case CPU_NEVADA:
 	case CPU_RM7000:
 	case CPU_RM9000:
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
