Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f780jnj23384
	for linux-mips-outgoing; Tue, 7 Aug 2001 17:45:49 -0700
Received: from thor ([207.246.91.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f780jlV23381
	for <linux-mips@oss.sgi.com>; Tue, 7 Aug 2001 17:45:47 -0700
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA20847; Tue, 7 Aug 2001 20:45:17 -0400
Date: Tue, 7 Aug 2001 20:45:17 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Brandon Barker <bebarker@meginc.com>
cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
In-Reply-To: <01080623471400.01828@linux>
Message-ID: <Pine.SGI.4.33.0108072030380.20792-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Well, it's kind of both.  The R4000 and up are 64 bit CPU's capable of
running either 32 or 64 bit code.  The MIPS address space is a little
wierd such that you can kinda munge 32 and 64 bit code togeather under the
right circumstances.

Some of the old hands here could tell you better how Irix behaves on those
boxes.  I know you can compile code with 64 bit int and pointers and it
will run on those boxes under Irix, but there is a little more to it than
that.

Yes, gcc works under Irix.  I think most of Reputable's Indy's have Irix
6.2 loaded on them, which is probably the minimum you would want to run
gcc under.  You will have to download the IDF and IDL from SGI (about
500MB worth of stuff) to make gcc work.  It relies on having the official
Irix /usr/include, compiler libraries, and the navtive Irix
assembler/linker.  I've used the gcc-2.95.2 found on SGI's freeware site.
It seems quite solid.  The only caveat to using gcc with Irix is that gcc
and the native compiler differ in how they pass data structures as
arguments to functions, or as return values.  I'm not talking about
pointers to structs, but actual structs as the targets.  Code that does
that will break.  Thankfully, that's rare, but there are a few stdlib
cases such as semiphore operations.

I've used both linux and Irix on the Indy.  Quite frankly, I would
consider getting a second HD if cheep enough so that you could keep both
around.  (Note: don't put 2 high RPM drives in the Indy, or we are talking
melt down of your pretty blue toy...)

I've found much to like in Irix in addition to the flexibility of Linux.

On Mon, 6 Aug 2001, Brandon Barker wrote:

> I will be purchasing 2 SGI Indy R5000 models from reputable.com, and was
> curious if these are 64 bit systems or 32 bit systems (for that matter, are
> all/any Indys 32 or 64 bit systems).  My guess is 64 because I wiould think
> IRIX has been 64 for quite some time, but was curious.  I use Linux on x86
> but will probably use IRIX for a few weeks on the Indy's until I become
> familiar enough with the machines to try installing Linux.  BTW, does gcc
> work on IRIX?
>
> Thanks for the info,
> Brandon Barker
>
