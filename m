Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MMr5Y00797
	for linux-mips-outgoing; Tue, 22 Jan 2002 14:53:05 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MMqvP00790;
	Tue, 22 Jan 2002 14:52:57 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA08470;
	Tue, 22 Jan 2002 13:52:47 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA03753;
	Tue, 22 Jan 2002 13:52:44 -0800 (PST)
Message-ID: <013a01c1a38f$41f96a00$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Tommy S. Christensen" <tommy.christensen@eicon.com>,
   "Dominic Sweetman" <dom@algor.co.uk>
Cc: "Daniel Jacobowitz" <dan@debian.org>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Ulrich Drepper" <drepper@redhat.com>, "Mike Uhler" <uhler@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet>	<20020118101908.C23887@lucon.org>	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>	<20020119162415.B31028@dea.linux-mips.net>	<m3d703thl6.fsf@myware.mynet>	<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>	<15437.14361.918255.115877@gladsmuir.algor.co.uk>	<002001c1a33e$d9936560$0deca8c0@Ulysses>	<20020122102128.A11455@nevyn.them.org> <15437.35062.770932.705864@gladsmuir.algor.co.uk> <3C4DDD24.4A0F24DE@eicon.com>
Subject: Re: thread-ready ABIs
Date: Tue, 22 Jan 2002 22:53:38 +0100
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

"Tommy S. Christensen" <tommy.christensen@eicon.com> wrote:
>

> Dominic Sweetman wrote:
> > 
> > > In any case, that's not the real problem.  Linux user threads do not
> > > have true separate stacks.  They share their _entire_ address space;
> > > the stacks are all bounded (default is 2MB) and grouped together at
> > > the top of the available memory region.
> > 
> > Quite.
> > 
> > A comment by Kevin reminded me of the real constraint (which the
> > experts probably take for granted): this system is supposed to work on
> > shared-memory multiprocessors and multithreaded CPUs.
> > 
> > In both cases two or more threads within an address space can be
> > active simultaneously.  On a multithreaded CPU (in particular) there's
> > only one TLB, so memory (including any memory specially handled by the
> > kernel) is all held in common.  The *only* thing available to a user
> > privilege program which distinguishes the threads is the CPU register
> > set.
> > 
> > (Well, and the stack, which is a difference inherited from the value
> > in the stack pointer register.  But the stack pointer is not really
> > going to help much to return a thread-characteristic pointer or ID.)
> 
> Well, why not use the stack?
> 
> I am not quite familiar with the requirements on this "thread register",
> but couldn't something like this be made to work:
>   #define TID *((sp & ~(STACK_SIZE-1)) + STACK_SIZE - TID_OFFSET)
> 
> It assumes a fixed maximum stack size (and alignment), which it should
> be possible to meet (virtual memory is cheap). The STACK_SIZE could
> probably even be a (process global!) variable if it is not desirable
> to limit this at compile time.

Thanks for writing this up.  I had the same thought over dinner,
but I'm throughly discredited today, and it's better that it came
from someone else.   ;-)

            Regards,

            Kevin K.
