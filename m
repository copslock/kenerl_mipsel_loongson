Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2KJUi300884
	for linux-mips-outgoing; Tue, 20 Mar 2001 11:30:44 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2KJUhM00881
	for <linux-mips@oss.sgi.com>; Tue, 20 Mar 2001 11:30:43 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f2KJRT023125;
	Tue, 20 Mar 2001 11:27:30 -0800
Message-ID: <3AB7AEFD.5B773122@mvista.com>
Date: Tue, 20 Mar 2001 11:26:53 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: linux-mips@oss.sgi.com
Subject: Re: gdb 5.0 display arguments problem
References: <3AB68CFC.A2840808@mvista.com> <01e701c0b0d3$3fca8980$0deca8c0@Ulysses> <004601c0b11d$86340d20$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Kevin D. Kissell" wrote:
> 
> > Yours may well be slightly different, but fatal for the same reason.
> 
> Indeed, I wonder if your gdb isn't looking on the stack frame
> for an argument that isn't there - and which may never be
> there - and finding the value that also happens to be in s4.
> 

I think I figured out the reason.  If you take a look of the code segment I
attached in my first posting, you will see that s4 register indeed holds the
value of a1, and presummably remains so for the rest of the function. 
However, the actual assignment of a1 to s4 does not happen until a couple of
instructions later into the function.  So if the breakpoint is set at the
first instruction of the function, gdb would still think (wrongly) s4 holds
the 2nd argument and, even worse, try to dereference it if it is a char*
pointer.

> 
> Another reason to fix things in the gdb proxy/exception code
> rather than cripple gdb backtrace is that, even with the backtrace
> fixed, the current kgdb situation is such that the slightest typo
> at the debugger operator interface can generate a bad address
> and blow the system sky high.  It's happened to me on more than
> one occasion.  Fortunately, what I was debugging at the time
> was readily reproduceable (if not, I would have fixed the kgdb
> problem then and there!).
> 

This sounds pretty cool, but I don't see a clean algorithm.  So in the
exception code you would decide not to crash if 1)kgdb is configured, and 2)
the exception is caused by kgdb code (how?).  Also if you decide not to crash,
what should be reasonable return values?

Disable automatic char * dereferencing is not that bad.  You always have the
option to manually dereference it.  However, I could not find such an option. 
Maybe gdb does not provide that yet.

Jun
