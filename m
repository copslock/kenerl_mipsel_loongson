Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0VDJ0x15956
	for linux-mips-outgoing; Thu, 31 Jan 2002 05:19:00 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0VDImd15952
	for <linux-mips@oss.sgi.com>; Thu, 31 Jan 2002 05:18:48 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA08560;
	Thu, 31 Jan 2002 13:17:39 +0100 (MET)
Date: Thu, 31 Jan 2002 13:17:39 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jason Gunthorpe <jgg@debian.org>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.17: An mb() rework
In-Reply-To: <Pine.LNX.3.96.1020130123109.11192A-100000@wakko.deltatee.com>
Message-ID: <Pine.GSO.3.96.1020131115837.5578A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 30 Jan 2002, Jason Gunthorpe wrote:

> I was under the impression that the mb() functions existed to maintain
> order of memory access and were not defined as flushes per say - so is
> the time delay a concern (perhaps sticking a sync before ERET is
> appropriate?)

 Well, other architectures seem to define the macros such that wmb() is a
pure ordering barrier (to assure strong ordering between writes) and rmb()
is a flush (since reads are synchronous by their nature this implies all
other transactions have to be finished before).

 Putting a "sync" before "eret" certainly doesn't work.  The case I've
identified is mask_and_ack() in an interrupt handler.  It masks an active
IRQ line in an external controller so that handle_IRQ_event() can unmask
interrupts in the CPU (this implies mask_and_ack() is synchronous).  But
due to the current lack of proper synchronization, the write isn't
executed until after the __sti() there.  As a result for almost every IRQ
routed through the external controler there is a spurious one signalled
shortly afterwards.  There is still a long path from here to an "eret". 

> I spent some time talking with the Sandcraft people about memory barrier
> issues, and it turns out that at least on the SR71000 (and in most cases
> the RM7K) the order of SysAD transactions will always match the order of
> the instruction stream, but all writes are posted and all reads are split
> - that is the CPU can execute two back to back uncached loads and several
> back to back uncached stores without stalling the pipeline, or getting the
> IO's out of order. Adding sync's and uncached loads only slows things down
> for these chips. 

 Ok, what about assuring a value written to an I/O memory resource has
actually been commited?  That's what rmb() is for.  Since the CPU is
strongly-orderes wmb() (a "sync") should be indistinguishable from a
"nop". 

> I understand this is because the CPUs have a single load/store unit and do
> not do out of order execution. Many older/embedded MIPS designs probably
> have a similar configuration, they could likely also run with out the
> syncs. 

 Putting a wmb() or not should be the matter of requirements of specific
drivers.  Wasting a "nop" (effectively) is surely a justifiable price for
system's consistency.

> So - could you add something like CONFIG_IN_ORDER_IO which would nullify
> the syncs for these processors?

 Hmm, the option seems to exist already, namely CONFIG_NONCOHERENT_IO, but
is it really worth making the third variation to save a single "nop",
especially as barriers are relatively rare? I'll do it, if it is.

> BTW, does anyone know what CONFIG_WB is ment to mean? The CPU has a write
> buffer that does not preserve order? 

 Certain DECstation models have a write-back buffer that needs to be
handled explicitly.  For example rmb() is "1: bc0f 1b" for the R3220 WB
chip.  Wmb() is null, certainly, as the buffer is strongly-ordered.  See
arch/mips/dec/wbflush.c for details.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
