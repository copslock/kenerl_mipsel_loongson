Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MMhMH00475
	for linux-mips-outgoing; Tue, 22 Jan 2002 14:43:22 -0800
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MMhFP00470
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 14:43:16 -0800
Received: (qmail 15099 invoked from network); 22 Jan 2002 21:43:12 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 22 Jan 2002 21:43:12 -0000
Received: from eicon.com ([172.16.2.227])
          by idanshub.i-data.com (Lotus Domino Release 5.0.8)
          with ESMTP id 2002012222431045:20862 ;
          Tue, 22 Jan 2002 22:43:10 +0100 
Message-ID: <3C4DDD24.4A0F24DE@eicon.com>
Date: Tue, 22 Jan 2002 22:44:04 +0100
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dominic Sweetman <dom@algor.co.uk>
CC: Daniel Jacobowitz <dan@debian.org>, "Kevin D. Kissell" <kevink@mips.com>,
   Ralf Baechle <ralf@oss.sgi.com>, Ulrich Drepper <drepper@redhat.com>,
   Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
References: <m3elkoa5dw.fsf@myware.mynet>
		<20020118101908.C23887@lucon.org>
		<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
		<20020119162415.B31028@dea.linux-mips.net>
		<m3d703thl6.fsf@myware.mynet>
		<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
		<15437.14361.918255.115877@gladsmuir.algor.co.uk>
		<002001c1a33e$d9936560$0deca8c0@Ulysses>
		<20020122102128.A11455@nevyn.them.org> <15437.35062.770932.705864@gladsmuir.algor.co.uk>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 22-01-2002 22:43:11,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 22-01-2002
 22:43:12,
	Serialize complete at 22-01-2002 22:43:12
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Dominic Sweetman wrote:
> 
> > In any case, that's not the real problem.  Linux user threads do not
> > have true separate stacks.  They share their _entire_ address space;
> > the stacks are all bounded (default is 2MB) and grouped together at
> > the top of the available memory region.
> 
> Quite.
> 
> A comment by Kevin reminded me of the real constraint (which the
> experts probably take for granted): this system is supposed to work on
> shared-memory multiprocessors and multithreaded CPUs.
> 
> In both cases two or more threads within an address space can be
> active simultaneously.  On a multithreaded CPU (in particular) there's
> only one TLB, so memory (including any memory specially handled by the
> kernel) is all held in common.  The *only* thing available to a user
> privilege program which distinguishes the threads is the CPU register
> set.
> 
> (Well, and the stack, which is a difference inherited from the value
> in the stack pointer register.  But the stack pointer is not really
> going to help much to return a thread-characteristic pointer or ID.)

Well, why not use the stack?

I am not quite familiar with the requirements on this "thread register",
but couldn't something like this be made to work:
  #define TID *((sp & ~(STACK_SIZE-1)) + STACK_SIZE - TID_OFFSET)

It assumes a fixed maximum stack size (and alignment), which it should
be possible to meet (virtual memory is cheap). The STACK_SIZE could
probably even be a (process global!) variable if it is not desirable
to limit this at compile time.

  -Tommy
