Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VLa4Q06199
	for linux-mips-outgoing; Thu, 31 Jan 2002 13:36:04 -0800
Received: from skip-ext.ab.videon.ca (skip-ext.ab.videon.ca [206.75.216.36])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VLZnd06179
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 13:35:49 -0800
Received: (qmail 24951 invoked from network); 31 Jan 2002 20:35:43 -0000
Received: from unknown (HELO wakko.deltatee.com) ([24.86.210.128]) (envelope-sender <jgg@debian.org>)
          by skip-ext.ab.videon.ca (qmail-ldap-1.03) with SMTP
          for <macro@ds2.pg.gda.pl>; 31 Jan 2002 20:35:43 -0000
Received: from localhost
	([127.0.0.1] helo=wakko.deltatee.com ident=jgg)
	by wakko.deltatee.com with smtp (Exim 3.16 #1 (Debian))
	id 16WNvq-0003Yj-00; Thu, 31 Jan 2002 13:35:42 -0700
Date: Thu, 31 Jan 2002 13:35:42 -0700 (MST)
From: Jason Gunthorpe <jgg@debian.org>
X-Sender: jgg@wakko.deltatee.com
Reply-To: Jason Gunthorpe <jgg@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.GSO.3.96.1020131115837.5578A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1020131110531.13418A-100000@wakko.deltatee.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Thu, 31 Jan 2002, Maciej W. Rozycki wrote:

>  Well, other architectures seem to define the macros such that wmb() is a
> pure ordering barrier (to assure strong ordering between writes) and rmb()
> is a flush (since reads are synchronous by their nature this implies all
> other transactions have to be finished before).

Yes, I've noticed the wmb bit, not sure about rmb - it is hard to tell
without knowing the gritty details of the unusual asm ops used :< sparc64 
for instance seems to define them purely as ordering barriers.

A little more qualification would be that:
    write(...,device);   // Disable int
    wmb()
    enable_ints();
Is expected to have a potential spurious interrupt. But, perhaps this is
OK:
    outl(...,device);
    wmb();
    enable_ints();
This is consistant with how the PCI spec discusses ordering/etc and
barriers are frequently used in the PCI drivers. Looking at the i386 code
this is what I would expect to see.

Anyone know for sure?

>  Putting a "sync" before "eret" certainly doesn't work.  The case I've
> identified is mask_and_ack() in an interrupt handler.  It masks an active
> IRQ line in an external controller so that handle_IRQ_event() can unmask

Yeah, Ok, this is fairly normal. You have the unique case were using a
sync will solve your problem. Sync only fixes this if the target address
is in the CPU's system controller, it does not work for, say, PCI devices.

IMHO it is better to manage this sort of flushing explicitly in all
drivers, PCI drivers already do a read from device, drivers for system
controller devices could do that, or use a special sync macro.. That way
it is visible in the code and not relying on an arch/cpu-specific wmb() 
side effect. 

If you are using a UP mips that has strongly ordered blocking reads and
writes I'd think that rmb/wmb should only be asm("":::"memory"). If your
driver needs to do syncs for non-ordering reasons it should be doing
syncs. 

>  Ok, what about assuring a value written to an I/O memory resource has
> actually been commited?  That's what rmb() is for.  Since the CPU is
> strongly-orderes wmb() (a "sync") should be indistinguishable from a
> "nop". 

No, a sync will still empty the write buffer. It may halt the pipeline for
many (~80 perhaps) cycles while posted write data is dumped to the system
controller.

Regrettably, the SysAD bus that alot of mips chips use does not allow a
non-posted write, so in that case 'sync' is not going to commit an I/O
write as you would expect, it just moves it into a write buffer on the
system controller or on a PCI bridge. (This is not what PCI defines for IO
accesses, I don't know of any really elegent way to fix it though..)

I don't think rmb is generaly defined to flush IO writes.. It isn't used
very often at all in the drives/net and drivers/scsi stuff..


>  Hmm, the option seems to exist already, namely CONFIG_NONCOHERENT_IO, but
> is it really worth making the third variation to save a single "nop",
> especially as barriers are relatively rare? I'll do it, if it is.

Er, no, CONFIG_NONCOHERENT_IO is for caches that are not coherent with the
IO subsystem.

Barriers seem to be pretty common in the ISR's for PCI drivers, at least
the ones I've looked at..

While we are on this topic, does anyone know what the correct linux way
to turn off an interrupt at a PCI device is? I've seen this in a few
of the drivers:

    writeb(0,base+INT_ENABLE);
    readb(base+INT_ENABLE);    // Flush the write through the PCI bus
    wmb();
    ints_on();

Or should it be:

    writeb(0,base+INT_ENABLE);
    wmb();
    readb(base+INT_ENABLE);    // Flush the write through the PCI bus
    rmb();
    ints_on();

Which makes more sense..

If the latter is correct then your patch needs to define rmb as:
   'lw $1,KSEG'
   'addiu $0, $1, 0x0000'
Otherwise MIPS chips that do not support blocking uncached memory reads
will not work right. (SR71000 is such a chip)

Thanks,
Jason
