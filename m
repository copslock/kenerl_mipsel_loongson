Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G3qP210295
	for linux-mips-outgoing; Wed, 15 Aug 2001 20:52:25 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G3qLj10292
	for <linux-mips@oss.sgi.com>; Wed, 15 Aug 2001 20:52:22 -0700
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 16 Aug 2001 03:52:21 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id CC24954C0E; Thu, 16 Aug 2001 12:52:19 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA69632; Thu, 16 Aug 2001 12:52:19 +0900 (JST)
To: wgowcher@yahoo.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20010813173446.61234.qmail@web11901.mail.yahoo.com>
References: <20010809215522.A1958@lucon.org>
	<20010813173446.61234.qmail@web11901.mail.yahoo.com>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Aug_16_12:56:02_2001_518)--"
Content-Transfer-Encoding: 7bit
Message-Id: <20010816125652N.nemoto@toshiba-tops.co.jp>
Date: Thu, 16 Aug 2001 12:56:52 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----Next_Part(Thu_Aug_16_12:56:02_2001_518)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

>>>>> On Mon, 13 Aug 2001 10:34:46 -0700 (PDT), Wayne Gowcher <wgowcher@yahoo.com> said:
wgowcher> a 23 % reduction in the Floating Point Index benchmark

Current CVS kernel uses FPU emulator unconditionally.  If one floating
point intruction causes a 'Unimplemented' exception (denormalized
result, etc.) following floating point instructions are also handle by
FPU emulator (not only the instruction which raise the exception).

I do not know this is really desired behavior, but here is a patch to
change this.  If Unimplemented exception had been occured during the
benchmark, aplying this patch may result better performance.

---
Atsushi Nemoto

----Next_Part(Thu_Aug_16_12:56:02_2001_518)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fpu_emu.patch"

diff -ur linux.sgi/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.sgi/arch/mips/kernel/traps.c	Sun Aug  5 23:39:20 2001
+++ linux/arch/mips/kernel/traps.c	Thu Aug 16 12:20:23 2001
@@ -60,7 +60,7 @@
 extern asmlinkage void handle_mcheck(void);
 extern asmlinkage void handle_reserved(void);
 
-extern int fpu_emulator_cop1Handler(struct pt_regs *);
+extern int fpu_emulator_cop1Handler(struct pt_regs *, int);
 
 char watch_available = 0;
 
@@ -306,7 +306,8 @@
 		save_fp(current);
 	
 		/* Run the emulator */
-		sig = fpu_emulator_cop1Handler(regs);
+		/* Emulate only one insn if we have FPU. */
+		sig = fpu_emulator_cop1Handler(regs, 1);
 
 		/* 
 		 * We can't allow the emulated instruction to leave the
@@ -605,7 +606,7 @@
 			current->used_math = 1;
 		}
 	}
-	sig = fpu_emulator_cop1Handler(regs);
+	sig = fpu_emulator_cop1Handler(regs, 0);
 	last_task_used_math = current;
 	if (sig)
 		force_sig(sig, current);
diff -ur linux.sgi/arch/mips/math-emu/cp1emu.c linux/arch/mips/math-emu/cp1emu.c
--- linux.sgi/arch/mips/math-emu/cp1emu.c	Sun Aug  5 23:39:27 2001
+++ linux/arch/mips/math-emu/cp1emu.c	Thu Aug 16 12:21:07 2001
@@ -1662,7 +1662,7 @@
  * hit a non-fp instruction, or a backward branch.  This cuts down dramatically
  * on the per instruction exception overhead.
  */
-int fpu_emulator_cop1Handler(struct pt_regs *xcp)
+int fpu_emulator_cop1Handler(struct pt_regs *xcp, int maxcount)
 {
 	struct mips_fpu_soft_struct *ctx = &current->thread.fpu.soft;
 	unsigned long oldepc, prevepc;
@@ -1682,6 +1682,8 @@
 			sig = cop1Emulate(xcp, ctx);
 		else
 			xcp->cp0_epc += 4;	/* skip nops */
+		if (maxcount && --maxcount <= 0)
+			break;
 	} while (xcp->cp0_epc > prevepc && sig == 0);
 
 	/* SIGILL indicates a non-fpu instruction */

----Next_Part(Thu_Aug_16_12:56:02_2001_518)----
