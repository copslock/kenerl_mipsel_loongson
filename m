Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32HmOu20514
	for linux-mips-outgoing; Mon, 2 Apr 2001 10:48:24 -0700
Received: from dea.waldorf-gmbh.de (u-29-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.29])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32Hm7M20491
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 10:48:08 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f32DEPZ10943;
	Mon, 2 Apr 2001 15:14:25 +0200
Date: Mon, 2 Apr 2001 15:14:25 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: Re: Dumb Question on Cross-Development
Message-ID: <20010402151425.A8471@bacchus.dhis.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses>; from kevink@mips.com on Mon, Apr 02, 2001 at 02:24:00PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 02, 2001 at 02:24:00PM +0200, Kevin D. Kissell wrote:

> I've historically done all of my MIPS/Linux development
> native, on Indies, P-5064's, Atlas, and Malta.  But now
> that we seem to be in a situation where the latest, 
> greatest, and most correct compilers are x86 cross-dev
> only.

There is nothing that keeps you from building those compiler as native
compilers also.  Usually I only crosscompile kernels and do all other
work native.

> I've cut over to building kernels on my Athlon box.
> I'd like to start building apps and benchmarks (not 
> necessarily from srpm's).  Plainly, I need a set of
> libraries (naive attempts at cross-compilation of
> user code with the egcs 1.1.2 compiler results in
> complaints about the missing crt1.o), and possibly
> some variant include files.

Which looks like you don't have a glibc package installed.

> Are these packaged somewhere, and is there an FAQ/HowTo on how
> to set them up?

Guess I should occasionally roll an uptodate crosscompiler package ...

> This may have been handled in Ralf's HowTo, but that seems to have
> disappeared from the web.

http://oss.sgi.com/mips/mips-howto.html.  Where are you looking?  It's still
on the web and is also being distributed as part of the LDP project.  Heck,
the HOWTO even seems to ship with a number of Intel distributions, at least
Conectiva 6.0 and Redhat 6.2 seem to include it, even though fairly old
versions.

  Ralf
