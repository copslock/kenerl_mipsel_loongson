Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VMp7211582
	for linux-mips-outgoing; Thu, 31 Jan 2002 14:51:07 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VMopd11578
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 14:50:51 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA08755;
	Thu, 31 Jan 2002 22:50:21 +0100 (MET)
Date: Thu, 31 Jan 2002 22:50:20 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jason Gunthorpe <jgg@debian.org>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.LNX.3.96.1020131110531.13418A-100000@wakko.deltatee.com>
Message-ID: <Pine.GSO.3.96.1020131215446.579H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 31 Jan 2002, Jason Gunthorpe wrote:

> >  Well, other architectures seem to define the macros such that wmb() is a
> > pure ordering barrier (to assure strong ordering between writes) and rmb()
> > is a flush (since reads are synchronous by their nature this implies all
> > other transactions have to be finished before).
> 
> Yes, I've noticed the wmb bit, not sure about rmb - it is hard to tell
> without knowing the gritty details of the unusual asm ops used :< sparc64 
> for instance seems to define them purely as ordering barriers.

 Weird.

> A little more qualification would be that:
>     write(...,device);   // Disable int
>     wmb()
>     enable_ints();
> Is expected to have a potential spurious interrupt. But, perhaps this is

 Of course -- this only assures any write within "enable_ints()" won't
happen before "write(...,device)".  Actual writes may happen much later,
e.g. when conditions on the bus allow. 

> OK:
>     outl(...,device);
>     wmb();
>     enable_ints();
> This is consistant with how the PCI spec discusses ordering/etc and
> barriers are frequently used in the PCI drivers. Looking at the i386 code
> this is what I would expect to see.

 Hmm, the DECstation is not a PCI machine.  And the external interrupt
controller can be treated as a part of the chipset -- writes to it doesn't
go through any kind of an external bus.  It's possible that the chipset
acts as a write-back buffer extension for the CPU's internal buffer.

> >  Putting a "sync" before "eret" certainly doesn't work.  The case I've
> > identified is mask_and_ack() in an interrupt handler.  It masks an active
> > IRQ line in an external controller so that handle_IRQ_event() can unmask
> 
> Yeah, Ok, this is fairly normal. You have the unique case were using a
> sync will solve your problem. Sync only fixes this if the target address
> is in the CPU's system controller, it does not work for, say, PCI devices.

 A "sync" is required since otherwise a write can bypass a read.  For CPUs
for which it doesn't happen, a "sync" is effectively a "nop", so it
doesn't really matter.

 Note that I don't need a "sync" specifically (the code works for me
either way), since for the R4400 a write cannot bypass a read, but it's
still needed for correctness. 

> IMHO it is better to manage this sort of flushing explicitly in all
> drivers, PCI drivers already do a read from device, drivers for system
> controller devices could do that, or use a special sync macro.. That way
> it is visible in the code and not relying on an arch/cpu-specific wmb() 
> side effect. 

 Hmm, wmb() is pretty clearly defined.  The current implementation does
not enforce strict ordering and is thus incorrect.  Note that the R4400
manual explicitly states a cached write can bypass an uncached one, hence
the CPU may exploit weak ordering under certain circumstances.  The "sync" 
instruction was specifically defined to avoid such a risk.

> If you are using a UP mips that has strongly ordered blocking reads and
> writes I'd think that rmb/wmb should only be asm("":::"memory"). If your
> driver needs to do syncs for non-ordering reasons it should be doing
> syncs. 

 Nope, it's not always strongly ordered -- see the R4400 manual.  Also
note that rmb() is defined as asm("lock; addl $0,0(%%esp)":::"memory") for
the i386, to make sure all transactions are completed even in the UP mode,
even though the i386 is strongly ordered.

> No, a sync will still empty the write buffer. It may halt the pipeline for
> many (~80 perhaps) cycles while posted write data is dumped to the system
> controller.

 Then it's an implementation bug.  For a CPU in the UP mode "sync" is only
defined to prevent write and read reordering -- there is nothing about
flushing.

> Regrettably, the SysAD bus that alot of mips chips use does not allow a
> non-posted write, so in that case 'sync' is not going to commit an I/O
> write as you would expect, it just moves it into a write buffer on the
> system controller or on a PCI bridge. (This is not what PCI defines for IO
> accesses, I don't know of any really elegent way to fix it though..)

 That's a correct implementation -- see the "sync" definition.

> I don't think rmb is generaly defined to flush IO writes.. It isn't used
> very often at all in the drives/net and drivers/scsi stuff..

 If a driver doesn't need it then it doesn't use it.  It may be buggy as
well, e.g. due to being i386-centric.

> Er, no, CONFIG_NONCOHERENT_IO is for caches that are not coherent with the
> IO subsystem.

 I haven't investigated the option much, I admit.

> While we are on this topic, does anyone know what the correct linux way
> to turn off an interrupt at a PCI device is? I've seen this in a few
> of the drivers:
> 
>     writeb(0,base+INT_ENABLE);
>     readb(base+INT_ENABLE);    // Flush the write through the PCI bus
>     wmb();
>     ints_on();
> 
> Or should it be:
> 
>     writeb(0,base+INT_ENABLE);
>     wmb();
>     readb(base+INT_ENABLE);    // Flush the write through the PCI bus
>     rmb();
>     ints_on();
> 
> Which makes more sense..

 I would do it as:

	writeb(0,base+INT_ENABLE);
	mb();
	readb(base+INT_ENABLE);	// Flush the write through the PCI bus
	rmb();
	ints_on();

You need an "mb()", since you are changing the access type, so you need to
synchronize both kinds.

> If the latter is correct then your patch needs to define rmb as:
>    'lw $1,KSEG'
>    'addiu $0, $1, 0x0000'
> Otherwise MIPS chips that do not support blocking uncached memory reads
> will not work right. (SR71000 is such a chip)

 I don't understand what the purpose of the above code is, except that it
wastes a cycle.  Please elaborate. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
