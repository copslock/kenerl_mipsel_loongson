Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2KMCDU04120
	for linux-mips-outgoing; Tue, 20 Mar 2001 14:12:13 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2KMCCM04117
	for <linux-mips@oss.sgi.com>; Tue, 20 Mar 2001 14:12:12 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA23304;
	Tue, 20 Mar 2001 14:12:12 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA28544;
	Tue, 20 Mar 2001 14:12:09 -0800 (PST)
Message-ID: <002d01c0b18b$5f512da0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jun Sun" <jsun@mvista.com>
Cc: <linux-mips@oss.sgi.com>
References: <3AB68CFC.A2840808@mvista.com> <01e701c0b0d3$3fca8980$0deca8c0@Ulysses> <004601c0b11d$86340d20$0deca8c0@Ulysses> <3AB7AEFD.5B773122@mvista.com>
Subject: Re: gdb 5.0 display arguments problem
Date: Tue, 20 Mar 2001 23:16:02 +0100
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

> "Kevin D. Kissell" wrote:
> >
> > > Yours may well be slightly different, but fatal for the same reason.
> >
> > Indeed, I wonder if your gdb isn't looking on the stack frame
> > for an argument that isn't there - and which may never be
> > there - and finding the value that also happens to be in s4.
> >
>
> I think I figured out the reason.  If you take a look of the code segment
I
> attached in my first posting, you will see that s4 register indeed holds
the
> value of a1, and presummably remains so for the rest of the function.
> However, the actual assignment of a1 to s4 does not happen until a couple
of
> instructions later into the function.  So if the breakpoint is set at the
> first instruction of the function, gdb would still think (wrongly) s4
holds
> the 2nd argument and, even worse, try to dereference it if it is a char*
> pointer.

It's not unusual to need to step one line to "see" arguments
correctly.  A pity about the pointer dereference.  ;-)

> > Another reason to fix things in the gdb proxy/exception code
> > rather than cripple gdb backtrace is that, even with the backtrace
> > fixed, the current kgdb situation is such that the slightest typo
> > at the debugger operator interface can generate a bad address
> > and blow the system sky high.  It's happened to me on more than
> > one occasion.  Fortunately, what I was debugging at the time
> > was readily reproduceable (if not, I would have fixed the kgdb
> > problem then and there!).
> >
>
> This sounds pretty cool, but I don't see a clean algorithm.  So in the
> exception code you would decide not to crash if 1)kgdb is configured, and
2)
> the exception is caused by kgdb code (how?).  Also if you decide not to
crash,
> what should be reasonable return values?

There are a number of possible ways of going about it.  One is
to set some kind of flag during the kgdb proxy access, which
is tested by the page fault code.  That's the stuff that's derived
from Cobalt code and that is partly in place in some existing
kernel gdb support ("debugmem_got_flt", etc.).  I have not seen
it work correcly, and isn't SMP safe.  Another scheme, which is
actually a bit cleaner, would be to check explicitly for the faulting
address to be that of the kgdb proxy load.  In any case, once the
case has been identified, one tweaks the EPC value to return to
something other than a repeat of the bad dereference, and returns
zero or an error value to gdb - the protocol and message formats
are described in comments in gdb-stub.c.

> Disable automatic char * dereferencing is not that bad.  You always have
the
 > option to manually dereference it.  However, I could not find such an
option.
> Maybe gdb does not provide that yet.

And even if it did, accidentally trying to dump "0x8021f34" would
blow you out of the water.  It's the kernel proxy code that really needs
to be fixed.

            Kevin K.
