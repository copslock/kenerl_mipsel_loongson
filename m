Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2005 16:50:12 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:59584 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225250AbVAQQuG>;
	Mon, 17 Jan 2005 16:50:06 +0000
Received: MO(mo01)id j0HGo22c008913; Tue, 18 Jan 2005 01:50:02 +0900 (JST)
Received: MDO(mdo00) id j0HGo1La015318; Tue, 18 Jan 2005 01:50:01 +0900 (JST)
Received: 4UMRO01 id j0HGo0mJ008444; Tue, 18 Jan 2005 01:50:01 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Tue, 18 Jan 2005 01:49:58 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6.11-rc1] add local_irq_enable() to cpu_idle()
Message-Id: <20050118014958.1d9e484e.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

We need to add local_irq_enable() to cpu_idle().
Please add this patch to v2.6.

I don't have any information about R3081.
I didn't fix r3081_wait().

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/kernel/cpu-probe.c a/arch/mips/kernel/cpu-probe.c
--- a-orig/arch/mips/kernel/cpu-probe.c	Sun Oct 31 21:49:07 2004
+++ a/arch/mips/kernel/cpu-probe.c	Tue Jan 18 00:26:12 2005
@@ -42,10 +42,12 @@
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | TX39_CONF_HALT);
+	local_irq_enable();
 }
 
 static void r4k_wait(void)
 {
+	local_irq_enable();
 	__asm__(".set\tmips3\n\t"
 		"wait\n\t"
 		".set\tmips0");
@@ -61,6 +63,7 @@
 
 void au1k_wait(void)
 {
+	local_irq_enable();
 #ifdef CONFIG_PM
 	/* using the wait instruction makes CP0 counter unusable */
 	__asm__(".set\tmips3\n\t"
diff -urN -X dontdiff a-orig/arch/mips/kernel/process.c a/arch/mips/kernel/process.c
--- a-orig/arch/mips/kernel/process.c	Sat Jan  8 23:19:16 2005
+++ a/arch/mips/kernel/process.c	Mon Jan 17 21:43:08 2005
@@ -58,6 +58,8 @@
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+			else
+				local_irq_enable();
 		schedule();
 	}
 }
