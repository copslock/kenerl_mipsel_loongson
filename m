Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4R359x21185
	for linux-mips-outgoing; Sat, 26 May 2001 20:05:09 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4R34vd21147;
	Sat, 26 May 2001 20:04:58 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 587177F6; Sat, 26 May 2001 15:56:51 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 00718EFDB; Sat, 26 May 2001 15:15:50 +0200 (CEST)
Date: Sat, 26 May 2001 15:15:50 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Joe deBlaquiere <jadb@redhat.com>
Cc: Jun Sun <jsun@mvista.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010526151550.B611@paradigm.rfc822.org>
References: <Pine.GSO.3.96.1010523152429.5196A-100000@delta.ds2.pg.gda.pl> <3B0BF7F8.3050306@redhat.com> <3B0C0475.B9ACE682@mvista.com> <20010523205412.A10981@paradigm.rfc822.org> <20010523205552.B10981@paradigm.rfc822.org> <3B0C17D9.3060600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3B0C17D9.3060600@redhat.com>; from jadb@redhat.com on Wed, May 23, 2001 at 03:04:41PM -0500
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 23, 2001 at 03:04:41PM -0500, Joe deBlaquiere wrote:
> The thing I don't understand is how glibc is going to cleanly decide at 
> runtime which code to use. It's relatively easy to do something like 
> that in the kernel, but I can't come up with an elegant solution to make 
> such a choice at runtime in glibc.

Export the existance of ll/sc via /proc/cpuinfo or whatever.

> Assuming that we're moving forward (as Kevin points out) the percentage 
> of systems without ll/sc is going down. While these systems don't have 
> much CPU power to spare, we should make the baseline implementation have 
> ll/sc emulation. If somebody wants to make a MIPS I optimized glibc, 
> then that's fine, but allowing the 'standard' MIPSII glibc to work on 
> all systems simplifies life ( mine at least ;) ).

I dont think this is true necessarly - There are still people building
embedded x86 systems based on 386 cores. Look at the vr41xx systems - They
do also lack the ll/sc afaik. This is nowadays the most commonly
used embedded/pda cpu.

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
