Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1KBEWI09159
	for linux-mips-outgoing; Wed, 20 Feb 2002 03:14:32 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1KBEN909156
	for <linux-mips@oss.sgi.com>; Wed, 20 Feb 2002 03:14:23 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA11758;
	Wed, 20 Feb 2002 02:14:08 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA17723;
	Wed, 20 Feb 2002 02:14:06 -0800 (PST)
Message-ID: <006001c1b9f7$7da1c920$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>, "Jun Sun" <jsun@mvista.com>
Cc: "Greg Lindahl" <lindahl@conservativecomputer.com>,
   <linux-mips@oss.sgi.com>
References: <3C6C6ACF.CAD2FFC@mvista.com> <20020215031118.B21011@dea.linux-mips.net> <20020214232030.A3601@mvista.com> <20020215003037.A3670@mvista.com> <002b01c1b607$6afbd5c0$10eca8c0@grendel> <20020219140514.C25739@mvista.com> <00af01c1b9a2$c0d6d5f0$10eca8c0@grendel> <20020219171238.E25739@mvista.com> <20020219222835.A4195@wumpus.skymv.com> <20020219202434.F25739@mvista.com> <20020219233222.A22099@nevyn.them.org>
Subject: Re: FPU emulator unsafe for SMP?
Date: Wed, 20 Feb 2002 11:14:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> On Tue, Feb 19, 2002 at 08:24:34PM -0800, Jun Sun wrote:
> > On Tue, Feb 19, 2002 at 10:28:35PM -0500, Greg Lindahl wrote:
> > > 
> > > Alpha seems to always save the fpu state (the comments say that gcc
> > > always generates code that uses it in every user process.)
> > 
> > I think the comment might be an execuse. :-)  Never heard of gcc
> > generating unnecessary floating point code.

It ain't gcc, it's glibc.  And it ain't just on the Alpha, just about
every MIPS process has FP state, even those who do not
declare a single FP variable.  However that's not a real
justification for whether or not one does lazy FPU context
management.  See below...

> I have :)  It may do memory moves in them, for instance.  Not sure if
> that makes sense on Alpha.

It probably does on one implementation or another.
We used the same trick back in the 1980's in libc
for the Fairchild Clipper, since it allowed better
parallelism between address computation and
memory operations.  Not only for memory moves,
but string operations!

> > > I suspect that the optimization of not saving the fpu state for a
> > > process that doesn't use the fpu is the most critical optimization.
> > > And that you do already.

Let me rephrase that - the advantage is of not saving *or restoring*
the FPU state for a process that isn't using the FPU *in its current
time slice*.

> > If you do use floating point, I think it is pretty common to have
> > only process that uses fpu and runs for very long.  In that case,
> > leaving FPU owned by the process also saves quite a bit.

One cannot make design decisions based on what one
"thinks is pretty common".   Binding threads to CPUs
(CPU affinity) is almost always more efficient when
the behavior of the workload looks like batch FORTRAN
processing.   It's when one gets a mix of computational
and interactive jobs that it often creates unfortunate
artifacts, and thus must be handled with care.

> Not true.  For instance, on a processor with hardware FPU, setjmp()
> will save FPU registers.  That means most processes will actually end
> up taking the FPU at least once.

Almost all MIPS/Linux threads, from init() onward, have FPU state, 
due to setjmp(), printf() (which uses the FP registers even
if one does not specify a floating point data item or format), etc.

> The general approach in Linux is to disable lazy switching on SMP.  I'm
> 95% sure that PowerPC does that.

Has anyone ever measured the performance impact of
lazy FPU context switching on MIPS?   It's one of those
ideas that was trendy in the 1980's, but I recall that when
we implemented it  for SVR2 on the Fairchild Clipper 
(which had only 16 FP registers), the measured improvement 
on average context switch time was tiny - a percent or so.
We left it in, because it worked and it *was* an improvement,
but we would never have gone through the hassle had we
known how little it would buy us.

It occurs to me that we can to some degree "split
the difference" on FPU context management for
SMP if we *always* save the FPU state when a
thread switches out, but preserve the logic that
schedules threads with CU1 inhibited so that the
context is only *loaded* if the thread executes
FP instructions.  That would save about half of
the context switch overhead for non-FP-intensive
threads, while eliminating the migration problem.

            Regards,

            Kevin K.
