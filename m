Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J20d8d017568
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 19:00:39 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3J20d4B017567
	for linux-mips-outgoing; Thu, 18 Apr 2002 19:00:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mail.matriplex.com (ns1.matriplex.com [208.131.42.8])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3J20S8d017564;
	Thu, 18 Apr 2002 19:00:29 -0700
Received: from mail.matriplex.com (mail.matriplex.com [208.131.42.9])
	by mail.matriplex.com (8.9.2/8.9.2) with ESMTP id TAA41383;
	Thu, 18 Apr 2002 19:01:33 -0700 (PDT)
	(envelope-from rh@matriplex.com)
Date: Thu, 18 Apr 2002 19:01:33 -0700 (PDT)
From: Richard Hodges <rh@matriplex.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Andre.Messerschmidt@infineon.com, linux-mips@oss.sgi.com
Subject: Re: Wait queue problem
In-Reply-To: <20020418181652.A25562@dea.linux-mips.net>
Message-ID: <Pine.BSF.4.10.10204181855170.39815-100000@mail.matriplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> On Wed, Apr 17, 2002 at 12:03:19PM +0200, Andre.Messerschmidt@infineon.com wrote:
> 
> > Does anybody else have problems using wait queues in a 2.4.5 MIPS kernel?
> > When I try to wake up a process from an interrupt it won't start to execute.
> > It always waits for the timeout before resuming work. 
> > In principal my code look like this:
> > 
> > wait_queue_head_t wq;
> > 
> > foo() {
> > init_waitqueue_head(&wq);
> > interruptible_sleep_on_timeout(&wq,10*HZ);
> > }
> > 
> > foo_int() {
> > wake_up_interuptible(&wq);
> > }
> > 
> > Am I missing something? 

On Thu, 18 Apr 2002, Ralf Baechle wrote:
 
> A bad race condition in that code.  If foo_int is called before your process
> had a chance to get to sleep it'll never be woken before the timeout.

That reminds me :-)  

I have looked around for a version of wait_event_interruptible() that
has a timeout (starting my search in sched.h of course).  Before I get
around to writing my own, does anyone have one already?

Thanks,

-Richard
