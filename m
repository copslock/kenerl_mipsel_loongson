Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MDHbZ01349
	for linux-mips-outgoing; Tue, 22 Jan 2002 05:17:37 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MDHRP01345;
	Tue, 22 Jan 2002 05:17:27 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA00009;
	Tue, 22 Jan 2002 04:17:11 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA10358;
	Tue, 22 Jan 2002 04:17:09 -0800 (PST)
Message-ID: <002001c1a33e$d9936560$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Dominic Sweetman" <dom@algor.co.uk>
Cc: "Ralf Baechle" <ralf@oss.sgi.com>, "Ulrich Drepper" <drepper@redhat.com>,
   "Mike Uhler" <uhler@mips.com>,
   "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>,
   "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   "H . J . Lu" <hjl@lucon.org>
References: <m3elkoa5dw.fsf@myware.mynet><20020118101908.C23887@lucon.org><01b801c1a081$3f6518e0$0deca8c0@Ulysses><20020119162415.B31028@dea.linux-mips.net><m3d703thl6.fsf@myware.mynet><01be01c1a2d7$6ec299c0$0deca8c0@Ulysses> <15437.14361.918255.115877@gladsmuir.algor.co.uk>
Subject: Re: thread-ready ABIs
Date: Tue, 22 Jan 2002 13:18:03 +0100
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

> Since nobody seems to be prepared to essay a brief definition of a
> thread register, I'll make one up from first principles and maybe the
> experts will beat it into shape.

Thank you, Dom, for trying to inject some civility into this debate.

> Multiple threads in a Linux process share the same address space: code
> and data.  A thread has its own unique stack, but since (by
> definition) it shares all its data with every other thread it has no
> identity - there is no thread-unique static data.  That means it has
> no handle to acquire and manage any thread-specific variables.
> 
> [Some threads purists would probably maintain that's a Good Thing:
>  threads to them are like electrons to quantum physicists,
>  indistinguishable by definition].
> 
> Linux is not noted for computer science purity; so an OS-maintained
> "thread identity" variable which is cheap to read in user space sounds
> a useful thing to have.
> 
> A patient Linux expert (if any such are reading this list) might like
> to say what value is typically held (a pointer? an index?) and how
> it's used (my money's on "wrapped in an impenetrable macro").
> 
> In a more baroque (synonym for "less backward"?) architecture there
> are usually registers hanging about which no compiler or OS author has
> previously figured out any use for, which can be bent to this purpose.
> Unfortunately, MIPS original architects committed the grave error of
> making all the registers useful.
> 
> I quite like the idea of putting the thread value at a known offset in
> low virtual memory, but I expect the kernel keeps virtual page 0
> invalid to catch null pointers and that instructions start at the
> first boundary which doesn't create cache alias problems...

I think that the problem is complicated by the fact that
there may be a many->many mapping of kernel threads
(and CPUs) to user-land threads.  In that case, no single
low-memory address can be correct for all kernel threads.
However, since every kernel thread should have its own
stack segment, it would appear to me that having a
variable "under" the stack would satisfy the need for
per-kernel-thread storage at a knowable location.
I suspect that there is a second-order problem in that
the base stack address may differ for instances of
the same binary launched under different circumstances.
But I don't think that renders the problem impossible.
One could have a global pointer, resolvable at link
time, which could be set to SP+delta by whatever
we call crt0 these days, and which should provide the
required semantics.  Each user thread startup or 
context switch could follow the global pointer to the 
kernel-thread-specific memory location which 
could be used as the pointer to the user-thread
specific data area.

Even with the double indirection, that strikes me
as far more efficient than performing a system call
on every thread startup to set up a magic value to be 
returned in a k-register (as some have suggested) 
and considerably less messy, technically and commercially, 
than pulling a register out of the ABI and rendering it 
useless for programs which happen not to be executing
the threads library  (as others have proposed).

I await news as to why this is impossible and/or
unacceptable, and I shall endeavor to modify
or withdraw the suggestion accordingly.

            Regards,

            Kevin K.
