Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB2GR4101721
	for linux-mips-outgoing; Sun, 2 Dec 2001 08:27:04 -0800
Received: from deneb.localdomain (ga-cmng-u1-c3b-97.cmngga.adelphia.net [24.53.98.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB2GQxo01717
	for <linux-mips@oss.sgi.com>; Sun, 2 Dec 2001 08:26:59 -0800
Received: (from msalter@localhost)
	by deneb.localdomain (8.11.6/8.11.6) id fB2FQwF07112;
	Sun, 2 Dec 2001 10:26:58 -0500
Date: Sun, 2 Dec 2001 10:26:58 -0500
Message-Id: <200112021526.fB2FQwF07112@deneb.localdomain>
X-Authentication-Warning: deneb.localdomain: msalter set sender to msalter@redhat.com using -f
From: Mark Salter <msalter@redhat.com>
To: linux-mips@oss.sgi.com
Subject: another math emulation patch
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I found another math emulation problem. The code that was failing
looked like this:

   bc1f  1f
    nop
   ...
 1:
   jr ra
    move v0,v1

When the bc1f is emulated and the branch is taken, mips_dsemul gets called
to emulate the delay slot insn. Before calling mips_dsemul, the branch
emulation code sets CAUSEF_BD. mips_dsemul checks for nop and bails out
early instead of going through the process of executing the insn. The
loop in fpu_emulator_cop1Handler will call cop1Emulate with the BD flag
set and epc pointing to the "jr ra" insn. cop1Emulate sees the BD flag
and calculates the continue PC based on the jr insn target address.
cop1Emulate then bails out because the move in the jr delay slot is not
a cop1 insn. This results in the program being restarted at the "jr ra"
target address and the move in the jr delay slot being ignored. This
only happens when a nop is in the cop1 branch delay slot because ds_emul
will have the cpu execute other insns and that will clear the BD flag.

The following patch fixes the problem by clearing the BD flag when ds_emul
returns directly in the case of a nop. 

--Mark

Index: cp1emu.c
===================================================================
RCS file: /cvs/linux/arch/mips/math-emu/cp1emu.c,v
retrieving revision 1.13
diff -u -p -5 -c -r1.13 cp1emu.c
cvs server: conflicting specifications of output style
*** cp1emu.c	2001/10/13 12:30:27	1.13
--- cp1emu.c	2001/11/30 23:15:33
*************** mips_dsemul(struct pt_regs *regs, mips_i
*** 788,797 ****
--- 788,798 ----
  	mips_instruction forcetrap;
  	extern asmlinkage void handle_dsemulret(void);
  
  	if (ir == 0) {		/* a nop is easy */
  		regs->cp0_epc = VA_TO_REG(cpc);
+ 		regs->cp0_cause &= ~CAUSEF_BD;
  		return 0;
  	}
  #ifdef DSEMUL_TRACE
  	printk("desemul %p %p\n", REG_TO_VA(regs->cp0_epc), cpc);
  #endif
