Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9T6vq424656
	for linux-mips-outgoing; Sun, 28 Oct 2001 22:57:52 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9T6vf024652;
	Sun, 28 Oct 2001 22:57:41 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for [216.32.174.27]) with SMTP; 29 Oct 2001 06:57:41 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 7D737B478; Mon, 29 Oct 2001 15:57:36 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA33211; Mon, 29 Oct 2001 15:57:36 +0900 (JST)
Date: Mon, 29 Oct 2001 16:02:25 +0900 (JST)
Message-Id: <20011029.160225.59648095.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: ajob4me@21cn.com, linux-mips@oss.sgi.com
Subject: Re: Toshiba TX3927 board boot problem.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011026.225806.63990588.nemoto@toshiba-tops.co.jp>
References: <20011026095319.1C4BBB474@topsms.toshiba-tops.co.jp>
	<20011026.225806.63990588.nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Fri, 26 Oct 2001 22:58:06 +0900 (JST), Atsushi Nemoto <nemoto@toshiba-tops.co.jp> said:
nemoto> I have seen TX39 dead on "cfc1" insturuction if STATUS.CU1 bit
nemoto> enabled.  Such codes were in arch/mips/kernel/process.c.

So, please apply this patch to CVS for TX39XX support.

I use CONFIG_CPU_TX39XX in this patch, but I suppose other FPU-less
CPUs may need this also.

Does anybody know how about on other CPUs?

diff -u linux-sgi-cvs/arch/mips/kernel/process.c linux.new/arch/mips/kernel/
--- linux-sgi-cvs/arch/mips/kernel/process.c	Mon Oct 22 10:29:56 2001
+++ linux.new/arch/mips/kernel/process.c	Mon Oct 29 15:49:37 2001
@@ -57,6 +57,12 @@
 {
 	/* Forget lazy fpu state */
 	if (last_task_used_math == current) {
+#ifdef CONFIG_CPU_TX39XX
+		if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+			last_task_used_math = NULL;
+			return;
+		}
+#endif
 		set_cp0_status(ST0_CU1);
 		__asm__ __volatile__("cfc1\t$0,$31");
 		last_task_used_math = NULL;
@@ -67,6 +73,12 @@
 {
 	/* Forget lazy fpu state */
 	if (last_task_used_math == current) {
+#ifdef CONFIG_CPU_TX39XX
+		if (!(mips_cpu.options & MIPS_CPU_FPU)) {
+			last_task_used_math = NULL;
+			return;
+		}
+#endif
 		set_cp0_status(ST0_CU1);
 		__asm__ __volatile__("cfc1\t$0,$31");
 		last_task_used_math = NULL;
---
Atsushi Nemoto
