Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6UKd0b12200
	for linux-mips-outgoing; Mon, 30 Jul 2001 13:39:00 -0700
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6UKcvV12197
	for <linux-mips@oss.sgi.com>; Mon, 30 Jul 2001 13:38:57 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id WAA20442;
	Mon, 30 Jul 2001 22:41:05 +0200 (MET DST)
Date: Mon, 30 Jul 2001 22:41:05 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>,
   Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: [PATCH] wrong use of compute_return_epc() in /mips/kernel/traps.c
In-Reply-To: <07dd01c11934$32334860$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1010730221944.19618C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 30 Jul 2001, Kevin D. Kissell wrote:

> Many years ago, I went to a lot of effort to see to it that
> FP exceptions on the Fairchild Clipper passed enough
> information up through SIGFPE to allow full userland
> emulation or fixup and replay-on-return of the operation
> on floating point faults (entertaining because there was
> a seperate FP PC). And of course no one ever used it!   ;-)

 That's why I took the KISS approach.  Current code is cheap and satisfies
the specs I use, i.e. glibc's info pages.  If anyone needs anything more
one is free to improve handlers. 

> I missed the beginning of this thread, but it looks from the
> patch as if this is really about handling integer overflow
> exceptions, not FP exceptions.  That's unfortunate.

 The patch is about break and trap instruction handlers, indeed. 

> To begin with you are correct in that we should be
> passing the EPC value at the exception (and certainly not
> the result  of invoking compute_return_epc(), much less
> its side effects!), and the state of the BD bit from the
> Cause register, either abstracted into a variable in the
> info structure or as a flat-out copy of the Cause register.

 I don't think passing BD is needed here.  Enough information is
available.  A SIGFPE due to a branch or a jump instruction is impossible. 
Unless you have a chip on fire, in which case problems with signal
handlers are insignificant.

> I would recommend the former as being less of a security
> hole.  Yes, we could blow that off and make the user
> decode for branches himself, but it's tacky. But what's
> more pernicious is the fact that, being an integer exception,
> it could have resulted from an overflow of any of the GPRs,
> including those that will be used by the low-level library
> code dispatching the signal to the user, and in the generated
> code of the user's own signal handler.  If we actually want
> to allow the user to fix the operation and saturate (or whatever)
> the destination register, enough of the trap context needs
> to be passed up to the signal handler *and* back down
> on the signal return to allow that manipulation, followed
> by a resumption of execution at the instruction following
> the one that generated the trap.

 Let's just leave it as an excercise to one writing some emulation code. 
A general-purpose handler in the kernel or libc (which no one will
probably use) is an overkill and by defining own strict coding rules (be
it a calling convention, shadow registers or whatever) one can create
software that suits one's specific needs. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
