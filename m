Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LJwvs10055
	for linux-mips-outgoing; Mon, 21 Jan 2002 11:58:57 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LJwsP10048
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 11:58:54 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 06BDE125C0; Mon, 21 Jan 2002 10:58:50 -0800 (PST)
Date: Mon, 21 Jan 2002 10:58:50 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121105850.A28350@lucon.org>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121105253.B28087@lucon.org>; from hjl@lucon.org on Mon, Jan 21, 2002 at 10:52:53AM -0800
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

In another word, is a thread register purely a convention within glibc
as long as it doesn't change when entering glibc?



H.J.
