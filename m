Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5PBptnC013598
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 25 Jun 2002 04:51:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5PBptqo013597
	for linux-mips-outgoing; Tue, 25 Jun 2002 04:51:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5PBpfnC013593
	for <linux-mips@oss.sgi.com>; Tue, 25 Jun 2002 04:51:42 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA00751;
	Tue, 25 Jun 2002 13:55:23 +0200 (MET DST)
Date: Tue, 25 Jun 2002 13:55:22 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ladislav Michl <ladis@psi.cz>, Ralf Baechle <ralf@uni-koblenz.de>
cc: linux-mips@oss.sgi.com
Subject: Re: DBE/IBE handling incompatibility
In-Reply-To: <20020625003634.GA1917@kopretinka>
Message-ID: <Pine.GSO.3.96.1020625131229.29623A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 25 Jun 2002, Ladislav Michl wrote:

> >  Don't rely in dbe_board_handler and ibe_board_handler -- they are
> > system-specific backends that shouldn't be touched unless you want to
> > handle the exceptions in a system-specific way (e.g. to report ECC errors
> > from a memory controller).
> 
> MC sends an interrupt whenever bus or parity errors occur. In addition, if the
> error happened during a CPU read, it also asserts the bus error pin on the R4K.
> so once one access nonexistent memory on Indy first DBE is generated followed
> by Bus Error interupt (IRQ 6). When GIO status register is cleared inside DBE
> handler, irq is not delivered.

 So you want both a system-specific DBE handler and a DBE detection in a
driver, right?

> > Also expect the handlers to get rewritten so that search_dbe_table() gets 
> > invoked unconditionally, before a system-specific backend.
> 
> i don't want to use these handlers, i'd like to write it mips64 way.

 The MIPS way is the right one and I'll fix MIPS64 as soon as I get it
fixed much enough to boot into the single-user mode on my system.  They
have to be identical, because there are drivers that work both on MIPS and
MIPS64 and expect consistent semantics. 

 A cleanup hook will be provided to let system-specific code do whatever
is needed to discard saved DBE state regardless -- I didn't add it so far
as I haven't managed to get at it yet. 

> > Use get_dbe() from <asm/paccess.h> for reading data with an additional
> > DBE status.  For a simple example see drivers/mtd/devices/ms02-nv.c.  The
> > macro is used in a somewhat more complex way in drivers/tc/tc.c as well --
> > this bit of code fits your situation quite closely (here probing
> > TURBOchannel bus slots).  The macro works in modules as well.
> 
> that does't work. i used folowing pseudocode:
> 
> my_get_dbe()
>   nofault = 1;
>   ret = get_dbe(*val, (unsigned int *) addr);
>   __asm__ __volatile__("nop;nop;nop;nop");
>   nofault = 0;
> 	
> my_do_buserr()
>   save_and_clear_buserr();
>   if (nofault) {
>     nofault = 0;
>     return;
>   }
>   panic();
> 
> when calling my_get_dbe for nonexistent address it enters my_do_buserr
> and returns "somewhere" causing machine to freeze. calling
> save_and_clear_buserr() from board specific DBE handler works as
> expected. is there better solution or i missed anything important?

 Well, that's not the right approach -- you are trying to work around the
current MIPS64 brokenness.  The handler for DBE and IBE in
arch/mips*/kernel/traps.c is intended to look more or less as follows: 

asmlinkage void do_be(struct pt_regs *regs)
{
	unsigned long new_epc;
	unsigned long fixup = 0;
	int data = regs->cp0_cause & 4;

	if (data && !user_mode(regs))
		fixup = search_dbe_table(regs->cp0_epc);

	if (be_board_handler)
		fixup = be_board_handler(regs, fixup);

	if (fixup) {
		new_epc = fixup_exception(dpf_reg, fixup,
					  regs->cp0_epc);
		regs->cp0_epc = new_epc;
		return;
	}

	/*
	 * Assume it would be too dangerous to continue ...
	 */
	printk(KERN_ALERT "%s bus error, epc == %08lx, ra == %08lx\n",
	       data ? "Data" : "Instruction",
	       regs->cp0_epc, regs->regs[31]);
	die_if_kernel("Oops", regs);
	force_sig(SIGBUS, current);
}

 This way, the fixup search is invoked first and a system-specific handler
can judge whether to let the fixup be invoked or a serious failure
happened and the system should act appropriately.  The handler can do
whatever actions are needed (e.g. clear error status data in system
registers, report ECC syndromes, etc.) for the system for both cases.

 I'll code it shortly.  Ralf, I hope it's not too unreasonable.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
