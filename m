Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2K95s221919
	for linux-mips-outgoing; Tue, 20 Mar 2001 01:05:54 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2K95rM21916
	for <linux-mips@oss.sgi.com>; Tue, 20 Mar 2001 01:05:53 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA15851;
	Tue, 20 Mar 2001 01:05:53 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA03412;
	Tue, 20 Mar 2001 01:05:50 -0800 (PST)
Message-ID: <004601c0b11d$86340d20$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kevin D. Kissell" <kevink@mips.com>, "Jun Sun" <jsun@mvista.com>,
   <linux-mips@oss.sgi.com>
References: <3AB68CFC.A2840808@mvista.com> <01e701c0b0d3$3fca8980$0deca8c0@Ulysses>
Subject: Re: gdb 5.0 display arguments problem
Date: Tue, 20 Mar 2001 10:09:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Followups on my own message of last night.

> I had exactly the same problem with earlier versions of gdb (4.18
> if I recall), though for me the problem was invariably provoked by my
> asking "where" on a deeply nested set of stack frames.  I had always
> believed that the problem stemmed from the fact that the compiler,
> when invoked with the options used to build the Linux kernel in any
> case, is under no obligation to preserve the values of its incoming
> arguments past their useful life within the called function.  If the
> arguments are consumed before the next use of the register,
> they are never saved.  So sooner or later, the back trace comes to
> a function for which the argument storage on the stack frame is
> uninitialized garbage.
> 
> That problem should, in theory, be fixable by compiling with
> a set of options that force the arguments to be stored in the
> stack frame.

I've experimented around a bit, and so far, the only way
I can find that ensures that the argument values are preserved
all the way back down a calling chain is to use no "-O" optimisation
whatsoever.  The code us huge and grotesque, but arguments
are systematically saved in the stack frame in their allotted,
caller-allocated slots.  Even then I also need to compile with -g
if I want gdb (native 4.17) to be able to do a correct backtrace
even of user-mode code.

> Yours may well be slightly different, but fatal for the same reason.

Indeed, I wonder if your gdb isn't looking on the stack frame
for an argument that isn't there - and which may never be
there - and finding the value that also happens to be in s4.

> > Does this problem exist in native debugging?
> 
> Yes, but in most cases all you get is a bogus reported argument.

Or a truncated back trace.  In the worst case, you do get a gdb
crash/core dump.

> The problem is that the kgdb "agent" in the kernel is being passed 
> a bogus pointer, and is  dereferencing it mindlessly (and fatally).  
>
> > I assume we can disable gdb to display char strings by default.  
> > Does someone know how to do it?
> 
> I tried fixing it with a hack to the exception handling code,
> inspired by the old Cobalt MIPS kernel code, such that the
> kgdb agent's proxy references could fail in a non-fatal manner.
> I never did get it to work.  It probably would be easy to cripple
> gdb to not automatically dereference pointer arguments, perhaps
> only in remote mode and perhaps only if some magic flag is set.
> But it *is* nice to see the string arguments when they are sane.
> A cleaner approach might be to have the proxy use a high level
> VM routine to check the validity of each address before
> dereferencing, but it's not clear that it's actually safe to invoke
> such routines from the level at which the kgdb proxy is executing.

Another reason to fix things in the gdb proxy/exception code
rather than cripple gdb backtrace is that, even with the backtrace
fixed, the current kgdb situation is such that the slightest typo
at the debugger operator interface can generate a bad address
and blow the system sky high.  It's happened to me on more than
one occasion.  Fortunately, what I was debugging at the time
was readily reproduceable (if not, I would have fixed the kgdb
problem then and there!).

            Regards,

            Kevin K.
