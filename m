Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Mar 2003 20:36:13 +0000 (GMT)
Received: from p508B7DCA.dip.t-dialin.net ([IPv6:::ffff:80.139.125.202]:11195
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTCDUgM>; Tue, 4 Mar 2003 20:36:12 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h24Ka5U17927;
	Tue, 4 Mar 2003 21:36:05 +0100
Date: Tue, 4 Mar 2003 21:36:05 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] simulate_ll and simulate_sc(resend)
Message-ID: <20030304213605.A17855@linux-mips.org>
References: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030303192137.34d21352.yoichi_yuasa@montavista.co.jp>; from yoichi_yuasa@montavista.co.jp on Mon, Mar 03, 2003 at 07:21:37PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 03, 2003 at 07:21:37PM +0900, Yoichi Yuasa wrote:

> I found a bug in simulate_ll and simulate_sc.
> The board that uses ll/sc emulation is not started.
> 
> When send_sig in these, in order not to operate the value of EPC correctly,
> simulate_* happens continuously.
> 
> The previous patches were not perfect, I changed more.
> Please apply these patches to CVS tree.

As previously mentioned there were some problems with your fix, so I
wrote an alternative fix which is attached below.  It's untested because
I don't have any ll/sc-less test platform.

  Ralf

Index: arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.99.2.41
diff -u -r1.99.2.41 traps.c
--- arch/mips/kernel/traps.c	10 Feb 2003 22:50:48 -0000	1.99.2.41
+++ arch/mips/kernel/traps.c	4 Mar 2003 20:32:10 -0000
@@ -134,13 +134,14 @@
 		ll_bit = 0;
 	}
 	ll_task = current;
+
 	regs->regs[(opcode & RT) >> 16] = value;
 
 	compute_return_epc(regs);
 	return;
 
 sig:
-	send_sig(signal, current, 1);
+	force_sig(signal, current);
 }
 
 static inline void simulate_sc(struct pt_regs *regs, unsigned int opcode)
@@ -172,19 +173,21 @@
 	}
 	if (ll_bit == 0 || ll_task != current) {
 		regs->regs[reg] = 0;
-		goto sig;
+		return;
 	}
 
-	if (put_user(regs->regs[reg], vaddr))
+	if (put_user(regs->regs[reg], vaddr)) {
 		signal = SIGSEGV;
-	else
-		regs->regs[reg] = 1;
+		goto sig;
+	}
+
+	regs->regs[reg] = 1;
 
 	compute_return_epc(regs);
 	return;
 
 sig:
-	send_sig(signal, current, 1);
+	force_sig(signal, current);
 }
 
 /*
