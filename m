Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0LEvUM28239
	for linux-mips-outgoing; Mon, 21 Jan 2002 06:57:30 -0800
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0LEvMP28235
	for <linux-mips@oss.sgi.com>; Mon, 21 Jan 2002 06:57:22 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA24506;
	Mon, 21 Jan 2002 14:56:22 +0100 (MET)
Date: Mon, 21 Jan 2002 14:56:21 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Kevin D. Kissell" <kevink@mips.com>
cc: "H . J . Lu" <hjl@lucon.org>, Machida Hiroyuki <machida@sm.sony.co.jp>,
   drepper@redhat.com, GNU C Library <libc-alpha@sources.redhat.com>,
   linux-mips@oss.sgi.com
Subject: Re: thread-ready ABIs
In-Reply-To: <003701c1a25f$8abfc120$0deca8c0@Ulysses>
Message-ID: <Pine.GSO.3.96.1020121144413.22392C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 21 Jan 2002, Kevin D. Kissell wrote:

> If anything, assuming that k0 or k1 are sane in
> compiler-generated code is more of a violation
> of the ABI than imposing an optional use of s7.
> Sony's use in libraries is somewhat less intrusive.

 Hmm, it's a glibc/kernel internal implementation detail.  I don't think
this is an ABI violation, as from a program's point of view k0/k1 are
still "undefined -- do not use".

> It's a common technique to bind a static register
> to a global variable.  Linking to libraries with no
> knowledge of this variable breaks nothing, since
> by the ABI, all use of "s" registers requires that
> they be preserved and returned intact to the caller.
> It seems to me to be quite straightforward to apply
> this technique to the thread register.  The *only*
> issue I see is that of performance, and it is by
> no means clear how severe this would be.

 The k0/k1 approach is a performance hit as well.  Possibly a worse one,
as you lose a few cycles unconditionally every exception, while having one
static register less in the code can be dealt with by a compiler in a more
flexible way.  

> In the compiled code that I have examined
> for compiler efficiency in the past, it's pretty
> rare that *all* static registers are actually used.

 Even with one register less there are still eight remaining, indeed.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
