Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 11:02:54 +0200 (CEST)
Received: from fw-cam.cambridge.arm.com ([193.131.176.3]:411 "EHLO
	fw-cam.cambridge.arm.com") by linux-mips.org with ESMTP
	id <S1122962AbSIPJCx>; Mon, 16 Sep 2002 11:02:53 +0200
Received: by fw-cam.cambridge.arm.com; id KAA07872; Mon, 16 Sep 2002 10:02:41 +0100 (BST)
Received: from unknown(172.16.9.107) by fw-cam.cambridge.arm.com via smap (V5.5)
	id xma007623; Mon, 16 Sep 02 10:02:22 +0100
Date: Mon, 16 Sep 2002 10:02:25 +0100
From: Gareth <g.c.bransby-99@student.lboro.ac.uk>
To: Richard Hodges <rh@matriplex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Cycle counter
Message-Id: <20020916100225.01903423.g.c.bransby-99@student.lboro.ac.uk>
In-Reply-To: <Pine.BSF.4.10.10209130937060.47912-100000@mail.matriplex.com>
References: <20020913172824.5c7ed0a4.g.c.bransby-99@student.lboro.ac.uk>
	<Pine.BSF.4.10.10209130937060.47912-100000@mail.matriplex.com>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <g.c.bransby-99@student.lboro.ac.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 184
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: g.c.bransby-99@student.lboro.ac.uk
Precedence: bulk
X-list: linux-mips

Thanks for the help. This program is not running in linux, it is running as a
single application on the core. The processor is a 4kc. I tried your code and it
works fine. I just deleted your do_something() so the timer starts and stops
immediatly. I get 21 ticks now rather than the 8000 or so I was getting with my
code which is much more realistic.





On Fri, 13 Sep 2002 09:41:27 -0700 (PDT)
Richard Hodges <rh@matriplex.com> wrote:

> On Fri, 13 Sep 2002, Gareth wrote:
> 
> > Another question reagarding the mips malta board. I am wanting to be
> > able to find out how many cycles a certain loop takes to execute. I
> > understand there is a cycle counter built into the processor that I
> > want to use for this. I have a bit of inline assembly to do the job
> > but the results I am getting are not consistent so i think there is
> > probably something wrong with my attempt at the inline assembly. Here
> > is the code :
> 
> >   void al_signal_start(void)
> >   {
> > 	  int zero,temp;
> > 	  __asm__("move $2, $zero");
> > 	  __asm__("nop");
> >           __asm__("mtc0 $2, $9" :  : "r" (temp));
> 
> Is this from user space?  If so, this may fail from user space.  (I sure
> hope it does!)
>  
> > As you can see, main just starts and stops the counter with no
> > instructions in between. I expexcted the cycle count to be zero or
> > close to it because of the instructions required to get the count but
> > this is not the case. I am getting numbers like 8499. Is there just
> > something wrong with my assembly or is there something else I am
> > missing?
> 
> Try something like this:
> 
> #define GET_CLOCK(var){__asm__ volatile("mfc0 %0,$9":"=r"(var));}
> {
> 	unsigned int clock1, clock2;
> 
> 	GET_CLOCK(clock1);
> 	do_something();
> 	GET_CLOCK(clock2);
> 
> 	printf("ticks = %d\n", clock2 - clock1);
> }
> 
> -Richard
> 
> 
> 
