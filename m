Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1ILjVv11345
	for linux-mips-outgoing; Mon, 18 Feb 2002 13:45:31 -0800
Received: from desire.geoffk.org (12-234-190-114.client.attbi.com [12.234.190.114])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1ILjS911338
	for <linux-mips@oss.sgi.com>; Mon, 18 Feb 2002 13:45:28 -0800
Received: (from geoffk@localhost)
	by desire.geoffk.org (8.11.6/8.11.6) id g1IKjM702963;
	Mon, 18 Feb 2002 12:45:22 -0800
Date: Mon, 18 Feb 2002 12:45:22 -0800
From: Geoff Keating <geoffk@geoffk.org>
Message-Id: <200202182045.g1IKjM702963@desire.geoffk.org>
To: moshier@moshier.net
CC: fxzhang@ict.ac.cn, linux-mips@oss.sgi.com, libc-alpha@sources.redhat.com
In-reply-to: <Pine.LNX.4.44.0202181521340.25641-100000@moshier.net> (message
	from Stephen L Moshier on Mon, 18 Feb 2002 15:23:34 -0500 (EST))
Subject: Re: math broken on mips
Reply-to: Geoff Keating <geoffk@redhat.com>
References:  <Pine.LNX.4.44.0202181521340.25641-100000@moshier.net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Date: Mon, 18 Feb 2002 15:23:34 -0500 (EST)
> From: Stephen L Moshier <moshier@moshier.net>

> On Mon, 18 Feb 2002, Geoff Keating wrote:
> 
> > ... actually, C99 seems to imply that all supported rounding
> > precisions should work for the math library
> 
> Could you point out specifically where it says that?

It would have to specifically say that it doesn't, and I can't find
that.  For example, in s. 7.12.1 para 4, it says that HUGE_VAL is
a guaranteed result only in the default rounding mode.  

Appendix F says, in s. F.9 para 10, "Whether the [elementary]
functions honour the rounding direction mode is
implementation-defined." but this doesn't allow the functions to
produce invalid results, just to ignore the mode and use some other
mode instead.  A good math library should honour the current rounding
mode, as this is what is most useful.

-- 
- Geoffrey Keating <geoffk@geoffk.org> <geoffk@redhat.com>
