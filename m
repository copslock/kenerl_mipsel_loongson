Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 08:53:42 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:21775
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8226042AbVDTHx0>; Wed, 20 Apr 2005 08:53:26 +0100
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 20 Apr 2005 07:53:25 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id A3B131F2CD;
	Wed, 20 Apr 2005 16:53:21 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8F6E918E0C;
	Wed, 20 Apr 2005 16:53:21 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j3K7rKoj004534;
	Wed, 20 Apr 2005 16:53:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 20 Apr 2005 16:53:20 +0900 (JST)
Message-Id: <20050420.165320.42204293.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: CFC1 instruction in compute_return_epc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 7770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The __compute_return_epc() uses CFC1 instruction but it might cause a
coprocessor unusable exception since the process can lose its fpu
context by preemption.  The coprocessor unusable exception is not
allowed in kernel context.

Here is a patch.  Please review.  Thank you.

--- linux-mips/arch/mips/kernel/branch.c	2004-08-14 19:55:32.000000000 +0900
+++ linux/arch/mips/kernel/branch.c	2005-04-20 16:33:24.662914765 +0900
@@ -12,6 +12,7 @@
 #include <asm/branch.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/fpu.h>
 #include <asm/inst.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -163,8 +164,14 @@
 	case cop1_op:
 		if (!cpu_has_fpu)
 			fcr31 = current->thread.fpu.soft.fcr31;
-		else
-			asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+		else {
+			preempt_disable();
+			if (is_fpu_owner())
+				asm volatile("cfc1\t%0,$31" : "=r" (fcr31));
+			else
+				fcr31 = current->thread.fpu.hard.fcr31;
+			preempt_enable();
+		}
 		bit = (insn.i_format.rt >> 2);
 		bit += (bit != 0);
 		bit += 23;

---
Atsushi Nemoto
