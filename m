Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UIiOR09852
	for linux-mips-outgoing; Mon, 30 Jul 2001 11:44:24 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UIiJV09847
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 11:44:20 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA18909;
	Mon, 30 Jul 2001 20:46:08 +0200 (MET DST)
Date: Mon, 30 Jul 2001 20:46:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>,
   Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
In-Reply-To: <20010724080411.G14821@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.GSO.3.96.1010730202132.18438A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 24 Jul 2001, Thiemo Seufer wrote:

> somebody made wrong assumptions about how compute_return_epc() works.

 It was me, I admit...  Thanks for pointing it out. 

> I've speculated below how the right solution might look, but I
> don't know enough about signal handling to be sure.

 I think the following fix is sufficient -- let's just pass EPC and let
the userland handle it.  You don't normally want a "break" in a branch
delay slot -- such a sequence is of questionable utility.  But if it is to
be handled, the KISS approach gives the userland a chance to handle an
exception gracefully.  One may want to emulate overflows somehow, for
example.  Also the code is shorter. 

 Ralf, please apply it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.5-20010730-break-1
diff -up --recursive --new-file linux.macro/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux.macro/arch/mips/kernel/traps.c	Tue Jul 24 04:26:34 2001
+++ linux/arch/mips/kernel/traps.c	Mon Jul 30 18:26:03 2001
@@ -378,7 +378,7 @@ asmlinkage void do_bp(struct pt_regs *re
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
@@ -418,7 +418,7 @@ asmlinkage void do_tr(struct pt_regs *re
 			info.si_code = FPE_INTOVF;
 		info.si_signo = SIGFPE;
 		info.si_errno = 0;
-		info.si_addr = (void *)compute_return_epc(regs);
+		info.si_addr = (void *)regs->cp0_epc;
 		force_sig_info(SIGFPE, &info, current);
 		break;
 	default:
