Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6O64Hl18403
	for linux-mips-outgoing; Mon, 23 Jul 2001 23:04:17 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6O64FO18400
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 23:04:15 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id IAA61301
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 08:04:13 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15OvIh-0002Qb-00
	for <linux-mips@oss.sgi.com>; Tue, 24 Jul 2001 08:04:11 +0200
Date: Tue, 24 Jul 2001 08:04:11 +0200
To: linux-mips@oss.sgi.com
Subject: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
Message-ID: <20010724080411.G14821@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

somebody made wrong assumptions about how compute_return_epc() works.
It does not return the epc but stores it in the register struct.
Return value is -EFAULT or zero.

I've speculated below how the right solution might look, but I
don't know enough about signal handling to be sure.


Thiemo


diff -BurPX /bigdisk/src/dontdiff linux-orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux-orig/arch/mips/kernel/traps.c	Sat Jul 14 18:49:46 2001
+++ linux/arch/mips/kernel/traps.c	Sun Jul 22 08:44:57 2001
@@ -378,8 +378,11 @@
 		else
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
-		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_errno = compute_return_epc(regs);
+		if (info.si_errno)
+			info.si_addr = NULL;
+		else
+			info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
@@ -418,8 +421,11 @@
 		else
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
-		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_errno = compute_return_epc(regs);
+		if (info.si_errno)
+			info.si_addr = NULL;
+		else
+			info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
