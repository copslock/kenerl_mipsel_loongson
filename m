Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GNJkk13930
	for linux-mips-outgoing; Thu, 16 Aug 2001 16:19:46 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GNJjj13927
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 16:19:45 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7GNOSA00330;
	Thu, 16 Aug 2001 16:24:28 -0700
Message-ID: <3B7C53BA.24B75620@mvista.com>
Date: Thu, 16 Aug 2001 16:14:02 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   Daniel Jacobowitz <dan@debian.org>
Subject: Re: FP emulator patch
References: <01e801c126a6$ec2a3420$0deca8c0@Ulysses>
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > >
> > >         if (current->used_math) {               /* Using the FPU again.
> > */
> > >                 lazy_fpu_switch(last_task_used_math);
> > >         } else {                                /* First time FPU user.
> > */
> > >                 init_fpu();
> > >                 current->used_math = 1;
> > >         }
> > >         last_task_used_math = current;
> > >
> > > Clearly the second path is logically the correct one.
> >
> > Not really.  See below.
> >
> > > BTW, do I see another bug here in do_cpu()?  It seems that before we
> call
> > > init_fpu(), we should check last_task_used_math.  If it is not NULL, we
> > should
> > > save the FP state to the last_task_used_math.  Hmm, strange ...
> >
> > Strange indeed.  And note that if the code were correct, your
> > surmise about the init_fpu() path being "logically the correct"
> > one would no longer be true - we'd be saving the FPU state of
> > the current process for no good reason.
> 
> And note further that, by forcing current->used_math to
> zero, the old code was in fact driving the signal handler
> needlessly into the broken code...
> 

By not clearing current->used_math bit, you are in fact restoring an FPU
context unnecessarily.

Jun
