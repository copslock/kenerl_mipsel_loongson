Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LJP3104133
	for linux-mips-outgoing; Mon, 21 Jan 2002 11:25:03 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LJOwP04129
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 11:24:58 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id ED129125C0; Mon, 21 Jan 2002 10:24:55 -0800 (PST)
Date: Mon, 21 Jan 2002 10:24:55 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Kevin D. Kissell" <kevink@mips.com>,
   Machida Hiroyuki <machida@sm.sony.co.jp>, drepper@redhat.com,
   GNU C Library <libc-alpha@sources.redhat.com>, linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
Message-ID: <20020121102455.A27606@lucon.org>
References: <003701c1a25f$8abfc120$0deca8c0@Ulysses> <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jan 21, 2002 at 02:56:21PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 21, 2002 at 02:56:21PM +0100, Maciej W. Rozycki wrote:
> 
> > It's a common technique to bind a static register
> > to a global variable.  Linking to libraries with no
> > knowledge of this variable breaks nothing, since
> > by the ABI, all use of "s" registers requires that
> > they be preserved and returned intact to the caller.
> > It seems to me to be quite straightforward to apply
> > this technique to the thread register.  The *only*
> > issue I see is that of performance, and it is by
> > no means clear how severe this would be.
> 
>  The k0/k1 approach is a performance hit as well.  Possibly a worse one,
> as you lose a few cycles unconditionally every exception, while having one
> static register less in the code can be dealt with by a compiler in a more
> flexible way.  
> 
> > In the compiled code that I have examined
> > for compiler efficiency in the past, it's pretty
> > rare that *all* static registers are actually used.
> 
>  Even with one register less there are still eight remaining, indeed.

If people believe it won't be a big problem, we can tell gcc not to use
$23, at least when compiling glibc.  The question is, should $23 be
fixed outside of glibc? Ulrich, should applciations have access to
thread register directly? If not, we may add a switch to tell gcc that
$23 is fixed and compile glibc with it.



H.J.
