Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LK12Y10216
	for linux-mips-outgoing; Mon, 21 Jan 2002 12:01:02 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LK0wP10202
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 12:00:59 -0800
Received: from drow by nevyn.them.org with local (Exim 3.33 #1 (Debian))
	id 16Sjew-0006z3-00; Mon, 21 Jan 2002 13:59:10 -0500
Date: Mon, 21 Jan 2002 13:59:10 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121135910.A26790@nevyn.them.org>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	Ulrich Drepper <drepper@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Machida Hiroyuki <machida@sm.sony.co.jp>,
	GNU C Library <libc-alpha@sources.redhat.com>,
	linux-mips@oss.sgi.com
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121105253.B28087@lucon.org>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 21, 2002 at 10:52:53AM -0800, H . J . Lu wrote:
> On Mon, Jan 21, 2002 at 10:36:26AM -0800, Ulrich Drepper wrote:
> > "H . J . Lu" <hjl@lucon.org> writes:
> > 
> > > Ulrich, should applciations have access to thread register directly?
> > 
> > It doesn't matter.  The value isn't changed in the lifetime of a
> > thread.  So the overhead of a syscall wouldn't be too much.  And
> > protection against programs overwriting the register isn't necessary.
> > It's the program's fault if that happens.
> 
> Thq question is if we should reserve $23 outside of glibc. $23 is
> a saved register in the MIPS ABI. It doesn't change across function
> calls. If applications outside of glibc don't need to access the
> thread register directly, that means $23 can be used as a saved
> register. We don't have to change anything when compiling applications.
> We only need to compile glibc with $23 reserved as the thread register.

That's not right.  If it is call-saved in the application, that means
the application can use it.  Main may have to restore it before it
returns to __libc_start_main, but that doesn't do you any good.

It doesn't change across function calls, but it does change inside
function calls.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
