Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GMl9E12810
	for linux-mips-outgoing; Thu, 16 Aug 2001 15:47:09 -0700
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GMl7j12806
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 15:47:07 -0700
Received: from nevyn.them.org (gateway-1237.mvista.com [12.44.186.158]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA28006
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 15:46:50 -0700 (PDT)
	mail_from (drow@crack.them.org)
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15XVl8-0005kH-00; Thu, 16 Aug 2001 15:37:02 -0700
Date: Thu, 16 Aug 2001 15:37:02 -0700
From: Daniel Jacobowitz <dan@debian.org>
To: Jun Sun <jsun@mvista.com>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: FP emulator patch
Message-ID: <20010816153702.A21978@nevyn.them.org>
References: <018201c12680$8f13e680$0deca8c0@Ulysses> <20010816115349.A12153@nevyn.them.org> <3B7C1BB9.7011790E@mvista.com> <01b001c12693$b4920140$0deca8c0@Ulysses> <3B7C3C75.4AB05B13@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3B7C3C75.4AB05B13@mvista.com>; from jsun@mvista.com on Thu, Aug 16, 2001 at 02:34:45PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 16, 2001 at 02:34:45PM -0700, Jun Sun wrote:
> Yes, that is somewhat the purpose.  Essentially we want to see, at the
> beginning of a signal handler execution, the process appears to have not used
> FPU at all.

Why?

> This requirement might be a must, because whether clearing current->used_math
> bit determine which patch we will take in the do_cpu(), when signal handler
> uses FPU for the first time.  See the code below.
> 
>         if (current->used_math) {               /* Using the FPU again.  */
>                 lazy_fpu_switch(last_task_used_math);
>         } else {                                /* First time FPU user.  */
>                 init_fpu();
>                 current->used_math = 1;
>         }
>         last_task_used_math = current;
> 
> Clearly the second path is logically the correct one.

Not really.  Why should it get a clean set of FP registers?  I think
the CORRECT thing would actually be for it to have the app's FP
registers.  Changes should not propogate back to the app, that's all.

> BTW, do I see another bug here in do_cpu()?  It seems that before we call
> init_fpu(), we should check last_task_used_math.  If it is not NULL, we should
> save the FP state to the last_task_used_math.  Hmm, strange ...

I thought I got all of these... <sigh>

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
