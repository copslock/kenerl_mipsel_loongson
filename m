Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g39Eie8d021365
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 9 Apr 2002 07:44:40 -0700
Received: (from mail@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g39Eie2q021364
	for linux-mips-outgoing; Tue, 9 Apr 2002 07:44:40 -0700
X-Authentication-Warning: oss.sgi.com: mail set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g39EiX8d021360
	for <linux-mips@oss.sgi.com>; Tue, 9 Apr 2002 07:44:34 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA08554;
	Tue, 9 Apr 2002 16:41:36 +0200 (MET DST)
Date: Tue, 9 Apr 2002 16:41:33 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jun Sun <jsun@mvista.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: New style IRQs for DECstation
In-Reply-To: <3CB1E0B2.8020707@mvista.com>
Message-ID: <Pine.GSO.3.96.1020409153428.397F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 8 Apr 2002, Jun Sun wrote:

> Generally interrupt dispatching belongs to machine/board-specific code.  So I 
> think FPU exeption through an interrupt is probably best handled within DEC's 
> code, instead of being generalized to the common code.

 The dispatching of the FPU interrupt for the DECstation is local to
DEC-specific code (note that it's so mainly due to performance reasons
anyway -- there is no problem with making dispatcher's code common with
appropriate backends installed for different IRQ types, like it is already
done in generic controller-based IRQ handling code).  Any other system
using a CPU/FPU in such a configuration has to provide its own dispatcher.
The handler for the FPU interrupt is the very same handler used for the
FPU exception; only a different entry point is used to accomodate the fact
registers are already saved on the stack. 

 And for safety you don't want the FPU exception handler to be enabled for
FPUs that report exceptions via an FPU interrupt.  For such systems a
spurious FPU exception should be treated as a system error.

> In addition, conceptional you might have a system where FPU exception is 
> handled through an interrupt and yet CPU has FPU exception.

 Not quite.  The FPU exception is not maskable, so you can't make a choice
at the run time.  It has to be hardwired. 

> Of course abstraction and generalization can happen later when it becomes 
> obvious.  It is just not obvious, at least to me.

 MIPS_CPU_FPUEX is specific to the CPU not to the system.  IDT R3081 is
another example (mysterious R3400 used in DECstation 5000/240 being the
first one) of a CPU with an integrated FPU unit which is logically
external and uses an interrupt to report FPU exceptions.  And all R2k/R3k
setups using a physically separate FPU deliver FPU exceptions via an
interrupt line.  I can't see a reason why to handle this option in
system-specific code.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
