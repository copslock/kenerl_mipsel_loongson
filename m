Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GLed510480
	for linux-mips-outgoing; Thu, 16 Aug 2001 14:40:39 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GLeXj10477
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 14:40:33 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GLjBA27917;
	Thu, 16 Aug 2001 14:45:11 -0700
Message-ID: <3B7C3C75.4AB05B13@mvista.com>
Date: Thu, 16 Aug 2001 14:34:45 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Daniel Jacobowitz <dan@debian.org>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <20010816115349.A12153@nevyn.them.org> <3B7C1BB9.7011790E@mvista.com> <01b001c12693$b4920140$0deca8c0@Ulysses>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > > current->used_math should never be set to zero in this sort of
> > > situation.  It's not an ownership flag!  It marks whether the FP state
> > > in the thread structure is valid.
> >
> > Daniel, it is funny that I agree with your last statement but cannot agree
> > with your first one.
> >
> > Under the above mentioned situation, after we make the copy of FPU state
> from
> > thread structure to the saved signal context, we need to set used_math bit
> to
> > zero.  This way when the signal handler uses FPU for the first time - if
> it
> > ever uses it -, the normal lazy FPU switch mechanism can kick in smoothly.
> 
> We've had a lot of messages crossing here, but please
> explain yourself here why clearing used_math helps in
> this case.  If, as has been proposed, the current
> thread does not own the FPU, and thus CU1 is not
> enabled, the FPU switch mechanism should kick in
> during the signal handler regardless. The signal
> handler will inherit the thread's FPU state from
> the thread context, and will muck with it, but
> if, as has been noted, the sigcontext has
> been loaded from the thread context before
> the handler is dispatched, and is restored after
> the handler executes, we're fine.  The only thing
> I can see that clearing used_math would achieve
> would be to guarantee the signal handler a virgin
> FPU context.
> 


Yes, that is somewhat the purpose.  Essentially we want to see, at the
beginning of a signal handler execution, the process appears to have not used
FPU at all.

This requirement might be a must, because whether clearing current->used_math
bit determine which patch we will take in the do_cpu(), when signal handler
uses FPU for the first time.  See the code below.

        if (current->used_math) {               /* Using the FPU again.  */
                lazy_fpu_switch(last_task_used_math);
        } else {                                /* First time FPU user.  */
                init_fpu();
                current->used_math = 1;
        }
        last_task_used_math = current;

Clearly the second path is logically the correct one.

BTW, do I see another bug here in do_cpu()?  It seems that before we call
init_fpu(), we should check last_task_used_math.  If it is not NULL, we should
save the FP state to the last_task_used_math.  Hmm, strange ...

Jun
