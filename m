Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9UFvNd28881
	for linux-mips-outgoing; Tue, 30 Oct 2001 07:57:23 -0800
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9UFvJ028878
	for <linux-mips@oss.sgi.com>; Tue, 30 Oct 2001 07:57:19 -0800
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f9UFvFW11756;
	Tue, 30 Oct 2001 10:57:15 -0500
Date: Tue, 30 Oct 2001 10:57:14 -0500
From: Jim Paris <jim@jtan.com>
To: Kristof Vanbecelaere <kristof.vanbecelaere@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: cross development tools
Message-ID: <20011030105714.A11683@neurosis.mit.edu>
Reply-To: jim@jtan.com
References: <20011030151936.B1603@Chickadee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030151936.B1603@Chickadee>; from kristof.vanbecelaere@sonycom.com on Tue, Oct 30, 2001 at 03:19:37PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> A while ago H.J. Lu adviced to use -march/-mtune instead of -mcpu
> options. But I wonder which front-end you need to use? It looks like
> gcc-3.0.2 lists the option as a target-specific one but does not
> accept it when you pass it.

I use gcc-3.0.2, which as you say does not support -march, but I found
that with the latest binutils + the new -march/-mipsN patch at
http://sources.redhat.com/ml/binutils/2001-10/msg00526.html
a GCCFLAGS of

     -mips2 -wa,-m4100,--trap

does a good job of letting the compiler generate mips2 while still
letting me use 4100-specific instructions in inline assembly (for
example).

> Also, I notice the compiler in H.J.'s port is something like
> gcc-2.96.something. Assuming this is also the version of the
> cross-compiler, how come I don't see this release on the official gcc
> web page? How do his tools relate to the gcc releases?

I think the general background is something like this:
- GCC released gcc-2.95, so their CVS incremented to 2.96
- RedHat distributed the CVS version of GCC, and called it gcc-2.96
- GCC incremented their CVS version again to 2.97 to attempt to 
  clear up the confusion
- RedHat's version maybe incremented to 2.97 at some point?

RedHat always throws on a ton of patches on top of released stuff,
and H.J. added lots more MIPS-related patches, so his port is basically
a CVS snapshot + tons of general and MIPS-specific patches.

I once went through the trouble of extracting the RPM and building
a .tar.gz that included all of the patches, but it didn't seem to
behave any differently from my point of view than gcc-3.0.2, so I'm
using that instead.  I can send you this .tar.gz if you'd like.

-jim
