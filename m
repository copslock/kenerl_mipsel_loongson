Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2K0EFQ13333
	for linux-mips-outgoing; Mon, 19 Mar 2001 16:14:15 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2K0EEM13330
	for <linux-mips@oss.sgi.com>; Mon, 19 Mar 2001 16:14:14 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id QAA12375;
	Mon, 19 Mar 2001 16:14:14 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id QAA21348;
	Mon, 19 Mar 2001 16:14:11 -0800 (PST)
Message-ID: <01e701c0b0d3$3fca8980$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>, <linux-mips@oss.sgi.com>
References: <3AB68CFC.A2840808@mvista.com>
Subject: Re: gdb 5.0 display arguments problem
Date: Tue, 20 Mar 2001 01:18:02 +0100
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

> I am using gdb 5.0 client to debug kernel, and found a bug in gdb 5.0 when
it
> trys to display an function argument.
...
> For whatever reason gdb client on the host side apparently thinks the
second
> arg is stored in register s4.  When the breakpoint is hit, gdb tries to
> display the value of s4 (which is 0x4 in this case).  Since the type of
this
> argument is char *, gdb further tries to read the content at 0x4 which
causes
> kernel panic.
>
> I believe I have seen this problem before (and in most case the symptom is
> wrong argument values instead of kernel panic).  Does someone have an idea
how
> to fix it or work around it?

I had exactly the same problem with earlier versions of gdb (4.18
if I recall), though for me the problem was invariably provoked by my
asking "where" on a deeply nested set of stack frames.  I had always
believed that the problem stemmed from the fact that the compiler,
when invoked with the options used to build the Linux kernel in any
case, is under no obligation to preserve the values of its incoming
arguments past their useful life within the called function.  If the
arguments are consumed before the next use of the register,
they are never saved.  So sooner or later, the back trace comes to
a function for which the argument storage on the stack frame is
uninitialized garbage.

That problem should, in theory, be fixable by compiling with
a set of options that force the arguments to be stored in the
stack frame.  Yours may well be slightly different, but fatal
for the same reason.

> Does this problem exist in native debugging?

Yes, but in that case all you get is a bogus reported argument.
The problem is that the kgdb "agent" in the kernel is being passed
a bogus pointer, and is dereferencing it mindlessly (and fatally).

> I assume we can disable gdb to display char strings by default.  Does
someone
> know how to do it?

I tried fixing it with a hack to the exception handling code,
inspired by the old Cobalt MIPS kernel code, such that the
kgdb agent's proxy references could fail in a non-fatal manner.
I never did get it to work.  It probably would be easy to cripple
gdb to not automatically dereference pointer arguments, perhaps
only in remote mode and perhaps only if some magic flag is set.
But it *is* nice to see the string arguments when they are sane.
A cleaner approach might be to have the proxy use a high level
VM routine to check the validity of each address before
dereferencing, but it's not clear that it's actually safe to invoke
such routines from the level at which the kgdb proxy is executing.

            Kevin K.
