Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 10:21:46 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:22548
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8225227AbTCCKVp>; Mon, 3 Mar 2003 10:21:45 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h23ATX44006663;
	Mon, 3 Mar 2003 19:29:35 +0900
Date: Mon, 3 Mar 2003 19:21:37 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: [patch] simulate_ll and simulate_sc(resend)
Message-Id: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__3_Mar_2003_19:21:37_+0900_08290030"
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__3_Mar_2003_19:21:37_+0900_08290030
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ralf,

I found a bug in simulate_ll and simulate_sc.
The board that uses ll/sc emulation is not started.

When send_sig in these, in order not to operate the value of EPC correctly,
simulate_* happens continuously.

The previous patches were not perfect, I changed more.
Please apply these patches to CVS tree.

Thanks,

Yoichi

--Multipart_Mon__3_Mar_2003_19:21:37_+0900_08290030
Content-Type: text/plain;
 name="llsc-v24-0303.diff"
Content-Disposition: attachment;
 filename="llsc-v24-0303.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Tue Feb 11 07:50:48 2003
+++ linux/arch/mips/kernel/traps.c	Mon Mar  3 17:52:16 2003
@@ -140,6 +140,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 
@@ -172,18 +173,19 @@
 	}
 	if (ll_bit == 0 || ll_task != current) {
 		regs->regs[reg] = 0;
-		goto sig;
 	}
 
-	if (put_user(regs->regs[reg], vaddr))
+	if (put_user(regs->regs[reg], vaddr)) {
 		signal = SIGSEGV;
-	else
+		goto sig;
+	} else
 		regs->regs[reg] = 1;
 
 	compute_return_epc(regs);
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 

--Multipart_Mon__3_Mar_2003_19:21:37_+0900_08290030
Content-Type: text/plain;
 name="llsc-v25-0303.diff"
Content-Disposition: attachment;
 filename="llsc-v25-0303.diff"
Content-Transfer-Encoding: 7bit

diff -aruN --exclude=CVS --exclude=.cvsignore linux.orig/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.orig/arch/mips/kernel/traps.c	Wed Feb 12 13:26:43 2003
+++ linux/arch/mips/kernel/traps.c	Mon Mar  3 17:48:11 2003
@@ -135,6 +135,7 @@
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 
@@ -167,18 +168,19 @@
 	}
 	if (ll_bit == 0 || ll_task != current) {
 		regs->regs[reg] = 0;
-		goto sig;
 	}
 
-	if (put_user(regs->regs[reg], vaddr))
+	if (put_user(regs->regs[reg], vaddr)) {
 		signal = SIGSEGV;
-	else
+		goto sig;
+	} else
 		regs->regs[reg] = 1;
 
 	compute_return_epc(regs);
 	return;
 
 sig:
+	compute_return_epc(regs);
 	send_sig(signal, current, 1);
 }
 

--Multipart_Mon__3_Mar_2003_19:21:37_+0900_08290030--
