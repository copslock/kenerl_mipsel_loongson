Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GNICC13848
	for linux-mips-outgoing; Thu, 16 Aug 2001 16:18:12 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GNI9j13839
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 16:18:10 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GNMnA32710;
	Thu, 16 Aug 2001 16:22:50 -0700
Message-ID: <3B7C5358.59C72108@mvista.com>
Date: Thu, 16 Aug 2001 16:12:24 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <20010816115349.A12153@nevyn.them.org> <3B7C1BB9.7011790E@mvista.com> <01b001c12693$b4920140$0deca8c0@Ulysses> <3B7C3C75.4AB05B13@mvista.com> <20010816153702.A21978@nevyn.them.org>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> 
> On Thu, Aug 16, 2001 at 02:34:45PM -0700, Jun Sun wrote:
> > Yes, that is somewhat the purpose.  Essentially we want to see, at the
> > beginning of a signal handler execution, the process appears to have not used
> > FPU at all.
> 
> Why?
> 
> > This requirement might be a must, because whether clearing current->used_math
> > bit determine which patch we will take in the do_cpu(), when signal handler
> > uses FPU for the first time.  See the code below.
> >
> >         if (current->used_math) {               /* Using the FPU again.  */
> >                 lazy_fpu_switch(last_task_used_math);
> >         } else {                                /* First time FPU user.  */
> >                 init_fpu();
> >                 current->used_math = 1;
> >         }
> >         last_task_used_math = current;
> >
> > Clearly the second path is logically the correct one.
> 
> Not really.  Why should it get a clean set of FP registers?  I think
> the CORRECT thing would actually be for it to have the app's FP
> registers.  Changes should not propogate back to the app, that's all.
> 

Ah, it seems I need to defend an "obvious" point. :-)

I am from the school which view signal handler as an interrupt context to a
normal process.  (In fact, some OSes implement signal handling by using a
separate thread/process).  Under this view, it is natural to provide a fresh
new context when a signal handler starts.

In other words, I am thinking in the following semantics: a signal handler
starting execution is equivalent to another process starting execution with
the same address space, except that the original process won't resume until
the "signal handler process" exits.

Thinking from that, I feel we should clear the current->used_math bit.

I think it is not correct for signal handler to inherit the FPU registers.  If
it wants to check the register values when the signal happens, it should do so
by examing the signal context.

Apparently a well code signal handler does not depend on whether we clear
current->used_math bit or not, because it should always set a FPU register
before it uses it.

Jun

> > BTW, do I see another bug here in do_cpu()?  It seems that before we call
> > init_fpu(), we should check last_task_used_math.  If it is not NULL, we should
> > save the FP state to the last_task_used_math.  Hmm, strange ...
> 
> I thought I got all of these... <sigh>
> 
> --
> Daniel Jacobowitz                           Carnegie Mellon University
> MontaVista Software                         Debian GNU/Linux Developer
