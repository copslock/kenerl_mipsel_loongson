Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8K3wEZ12066
	for linux-mips-outgoing; Wed, 19 Sep 2001 20:58:14 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8K3w6e12062;
	Wed, 19 Sep 2001 20:58:06 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 20 Sep 2001 03:58:06 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 07057B462; Thu, 20 Sep 2001 12:58:05 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA01901; Thu, 20 Sep 2001 12:58:00 +0900 (JST)
Date: Thu, 20 Sep 2001 13:02:48 +0900 (JST)
Message-Id: <20010920.130248.41627158.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: NON FPU cpus (again)
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010920051642.C11714@dea.linux-mips.net>
References: <20010207144857.B24485@paradigm.rfc822.org>
	<20010920.121316.74756227.nemoto@toshiba-tops.co.jp>
	<20010920051642.C11714@dea.linux-mips.net>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Thu, 20 Sep 2001 05:16:43 +0200, Ralf Baechle <ralf@oss.sgi.com> said:
>> BTW, I can not see any point in copying FCR31 to r0.  What is a
>> purpose of the cfc1 instruction?

ralf> On CPUs with imprecise exceptions a FPU exception might still be
ralf> pending and possibly be taken arbitrarily delayed.  The cfc1
ralf> instruction serves as an exception barrier for such exceptions.
ralf> At this time TFP is the only CPU which features imprecise
ralf> exceptions.

I see.  Thanks for your quick answer.


And I wrote wrong thing in my previous mail.  What I wanted to say is:

diff -ur linux.sgi/arch/mips/kernel/process.c linux/arch/mips/kernel/process.c
--- linux.sgi/arch/mips/kernel/process.c	Sun Aug  5 23:39:09 2001
+++ linux/arch/mips/kernel/process.c	Thu Sep 20 12:54:52 2001
@@ -56,8 +56,10 @@
 {
 	/* Forget lazy fpu state */
 	if (last_task_used_math == current) {
-		set_cp0_status(ST0_CU1);
-		__asm__ __volatile__("cfc1\t$0,$31");
+		if (mips_cpu.options & MIPS_CPU_FPU) {
+			set_cp0_status(ST0_CU1);
+			__asm__ __volatile__("cfc1\t$0,$31");
+		}
 		last_task_used_math = NULL;
 	}
 }
@@ -66,8 +68,10 @@
 {
 	/* Forget lazy fpu state */
 	if (last_task_used_math == current) {
-		set_cp0_status(ST0_CU1);
-		__asm__ __volatile__("cfc1\t$0,$31");
+		if (mips_cpu.options & MIPS_CPU_FPU) {
+			set_cp0_status(ST0_CU1);
+			__asm__ __volatile__("cfc1\t$0,$31");
+		}
 		last_task_used_math = NULL;
 	}
 }
---

As Florian Lohoff reported, there are CPUs require this patch.
---
Atsushi Nemoto
