Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N0DPO02793
	for linux-mips-outgoing; Tue, 22 Jan 2002 16:13:25 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N0DJP02790;
	Tue, 22 Jan 2002 16:13:19 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id PAA09873;
	Tue, 22 Jan 2002 15:13:09 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id PAA07612;
	Tue, 22 Jan 2002 15:13:04 -0800 (PST)
Message-ID: <016801c1a39a$7b2ca8e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kevin D. Kissell" <kevink@mips.com>,
   "Tommy S. Christensen" <tommy.christensen@eicon.com>,
   "Dominic Sweetman" <dom@algor.co.uk>
Cc: "Daniel Jacobowitz" <dan@debian.org>, "Ralf Baechle" <ralf@oss.sgi.com>,
   "Ulrich Drepper" <drepper@redhat.com>, "Mike Uhler" <uhler@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet>	<20020118101908.C23887@lucon.org>	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>	<20020119162415.B31028@dea.linux-mips.net>	<m3d703thl6.fsf@myware.mynet>	<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>	<15437.14361.918255.115877@gladsmuir.algor.co.uk>	<002001c1a33e$d9936560$0deca8c0@Ulysses>	<20020122102128.A11455@nevyn.them.org> <15437.35062.770932.705864@gladsmuir.algor.co.uk> <3C4DDD24.4A0F24DE@eicon.com> <013a01c1a38f$41f96a00$0deca8c0@Ulysses>
Subject: Re: thread-ready ABIs
Date: Wed, 23 Jan 2002 00:13:56 +0100
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

> > Well, why not use the stack?
> >
> > I am not quite familiar with the requirements on this "thread register",
> > but couldn't something like this be made to work:
> >   #define TID *((sp & ~(STACK_SIZE-1)) + STACK_SIZE - TID_OFFSET)
> >
> > It assumes a fixed maximum stack size (and alignment), which it should
> > be possible to meet (virtual memory is cheap). The STACK_SIZE could
> > probably even be a (process global!) variable if it is not desirable
> > to limit this at compile time.
>
> Thanks for writing this up.  I had the same thought over dinner,
> but I'm throughly discredited today, and it's better that it came
> from someone else.   ;-)

That having been said, I don't think this scheme
will really work. Programs do build themselves
temporary stacks in the heap from time to time.
Signal stacks come to mind.

            Regards,

            Kevin K.
