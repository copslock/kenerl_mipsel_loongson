Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MGkI913450
	for linux-mips-outgoing; Tue, 22 Jan 2002 08:46:18 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MGjKP13423;
	Tue, 22 Jan 2002 08:45:20 -0800
Received: from gladsmuir.algor.co.uk.algor.co.uk (IDENT:dom@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0MFiva23526;
	Tue, 22 Jan 2002 15:44:58 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15437.35062.770932.705864@gladsmuir.algor.co.uk>
Date: Tue, 22 Jan 2002 15:44:54 +0000
To: Daniel Jacobowitz <dan@debian.org>
Cc: "Kevin D. Kissell" <kevink@mips.com>, Dominic Sweetman <dom@algor.co.uk>,
   Ralf Baechle <ralf@oss.sgi.com>, Ulrich Drepper <drepper@redhat.com>,
   Mike Uhler <uhler@mips.com>,
   "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
In-Reply-To: <20020122102128.A11455@nevyn.them.org>
References: <m3elkoa5dw.fsf@myware.mynet>
	<20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020119162415.B31028@dea.linux-mips.net>
	<m3d703thl6.fsf@myware.mynet>
	<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
	<15437.14361.918255.115877@gladsmuir.algor.co.uk>
	<002001c1a33e$d9936560$0deca8c0@Ulysses>
	<20020122102128.A11455@nevyn.them.org>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> In any case, that's not the real problem.  Linux user threads do not
> have true separate stacks.  They share their _entire_ address space;
> the stacks are all bounded (default is 2MB) and grouped together at
> the top of the available memory region.

Quite.

A comment by Kevin reminded me of the real constraint (which the
experts probably take for granted): this system is supposed to work on
shared-memory multiprocessors and multithreaded CPUs.

In both cases two or more threads within an address space can be
active simultaneously.  On a multithreaded CPU (in particular) there's
only one TLB, so memory (including any memory specially handled by the
kernel) is all held in common.  The *only* thing available to a user
privilege program which distinguishes the threads is the CPU register
set.

(Well, and the stack, which is a difference inherited from the value
in the stack pointer register.  But the stack pointer is not really
going to help much to return a thread-characteristic pointer or ID.)

So MIPS really do need to figure out which register can be freed up.
Well, at least I know why now.  Hope the rest of you aren't too bored!

Dominic Sweetman
Algorithmics Ltd
http://www.algor.co.uk
