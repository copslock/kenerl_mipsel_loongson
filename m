Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LK5fU10354
	for linux-mips-outgoing; Mon, 21 Jan 2002 12:05:41 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LK5bP10350
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 12:05:37 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 1858C125C0; Mon, 21 Jan 2002 11:05:34 -0800 (PST)
Date: Mon, 21 Jan 2002 11:05:33 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121110533.B28350@lucon.org>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org> <20020121135910.A26790@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121135910.A26790@nevyn.them.org>; from dan@debian.org on Mon, Jan 21, 2002 at 01:59:10PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 21, 2002 at 01:59:10PM -0500, Daniel Jacobowitz wrote:
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

What is wrong about using a thread register as long as it contains
the right value when it is accessed as a thread pointer? If
applications don't have access to the thread pointer, I don't see the
problem using the thread register.


H.J.
