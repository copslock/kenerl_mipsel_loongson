Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LM4RC15657
	for linux-mips-outgoing; Mon, 21 Jan 2002 14:04:27 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LM4KP15653
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 14:04:20 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA21249;
	Mon, 21 Jan 2002 13:04:09 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id NAA12621;
	Mon, 21 Jan 2002 13:04:06 -0800 (PST)
Message-ID: <012501c1a2bf$4c832180$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Daniel Jacobowitz" <dan@debian.org>, "H . J . Lu" <hjl@lucon.org>
Cc: "Ulrich Drepper" <drepper@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Machida Hiroyuki" <machida@sm.sony.co.jp>,
   "GNU C Library" <libc-alpha@sources.redhat.com>, <linux-mips@oss.sgi.com>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org> <20020121135910.A26790@nevyn.them.org>
Subject: Re: thread-ready ABIs
Date: Mon, 21 Jan 2002 22:04:47 +0100
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

From: "Daniel Jacobowitz" <dan@debian.org>
> On Mon, Jan 21, 2002 at 10:52:53AM -0800, H . J . Lu wrote:
> > On Mon, Jan 21, 2002 at 10:36:26AM -0800, Ulrich Drepper wrote:
> > > "H . J . Lu" <hjl@lucon.org> writes:
> > >
> > > > Ulrich, should applciations have access to thread register directly?
> > >
> > > It doesn't matter.  The value isn't changed in the lifetime of a
> > > thread.  So the overhead of a syscall wouldn't be too much.  And
> > > protection against programs overwriting the register isn't necessary.
> > > It's the program's fault if that happens.
> >
> > Thq question is if we should reserve $23 outside of glibc. $23 is
> > a saved register in the MIPS ABI. It doesn't change across function
> > calls. If applications outside of glibc don't need to access the
> > thread register directly, that means $23 can be used as a saved
> > register. We don't have to change anything when compiling applications.
> > We only need to compile glibc with $23 reserved as the thread register.
>
> That's not right.  If it is call-saved in the application, that means
> the application can use it.  Main may have to restore it before it
> returns to __libc_start_main, but that doesn't do you any good.
>
> It doesn't change across function calls, but it does change inside
> function calls.

You are quite correct, and you have stated the problem very
succinctly.  We cannot, as I had hoped, simply superimpose
a thread pointer on a static register and keep it otherwise
invisible to the code generator.  So it's not the "easy way
out".

That does not necessarily mean that it's the wrong
solution.  As Maciej has pointed out, from the standpoint
of performance, making the kernel do gymnastics to
preserve or set up a "k" register on each trap may
well be worse for overall performance than having
one fewer "s" register.   Stealing the "s" register
would involve a change to the ABI and the compiler,
but would make it invisible to the kernel.  Using
(or abusing) a "k" register would techncially also
require a change to the ABI (though one that would
be more perfectly backward compatible), a smaller
perturbation of the compiler (thread pointer stuff
gets added, but the s-register compliment is unchanged),
and a kernel hack that may or may not conflict with
other people's work (e.g. Sony).  I've been kicking this
around with my colleagues at MIPS, and as I say,
I hope to be back with a semi-official recommendation
shortly.  Meanwhile, I'm very interested in other's views
of the pros, cons, and alternatives.

            Regards,

            Kevin K.
