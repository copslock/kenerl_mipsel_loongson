Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LKUgg11142
	for linux-mips-outgoing; Mon, 21 Jan 2002 12:30:42 -0800
Received: from desire.geoffk.org (12-234-190-114.client.attbi.com [12.234.190.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LKUcP11139
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 12:30:38 -0800
Received: (from geoffk@localhost)
	by desire.geoffk.org (8.11.6/8.11.6) id g0LJUUe00748;
	Mon, 21 Jan 2002 11:30:30 -0800
Date: Mon, 21 Jan 2002 11:30:30 -0800
From: Geoff Keating <geoffk@geoffk.org>
Message-Id: <200201211930.g0LJUUe00748@desire.geoffk.org>
To: hjl@lucon.org
CC: drepper@redhat.com, macro@ds2.pg.gda.pl, kevink@mips.com,
   machida@sm.sony.co.jp, libc-alpha@sources.redhat.com,
   linux-mips@oss.sgi.com
In-reply-to: <20020121105253.B28087@lucon.org> (hjl@lucon.org)
Subject: Re: thread-ready ABIs
Reply-to: Geoff Keating <geoffk@redhat.com>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl> <20020121102455.A27606@lucon.org> <m3zo37tutx.fsf@myware.mynet> <20020121105253.B28087@lucon.org>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Date: Mon, 21 Jan 2002 10:52:53 -0800
> From: "H . J . Lu" <hjl@lucon.org>
> Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
>    "Kevin D. Kissell" <kevink@mips.com>,
>    Machida Hiroyuki <machida@sm.sony.co.jp>,
>    GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com

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

This won't work, will it?  We need a register that application code is
not allowed to change ever, not one that is saved and restored.  Even
if the user knows that no glibc routines are called between the save
and the restore, a signal could happen.

-- 
- Geoffrey Keating <geoffk@geoffk.org> <geoffk@redhat.com>
