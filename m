Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4R351v21155
	for linux-mips-outgoing; Sat, 26 May 2001 20:05:01 -0700
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f4R34vd21148;
	Sat, 26 May 2001 20:04:58 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 3F70D7F4; Sat, 26 May 2001 15:56:51 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CFD74EFD9; Sat, 26 May 2001 15:14:28 +0200 (CEST)
Date: Sat, 26 May 2001 15:14:28 +0200
From: Florian Lohoff <flo@rfc822.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Joe deBlaquiere <jadb@redhat.com>, Jun Sun <jsun@mvista.com>,
   ralf@oss.sgi.com, Pete Popov <ppopov@mvista.com>,
   George Gensure <werkt@csh.rit.edu>, linux-mips@oss.sgi.com,
   "Kevin D. Kissell" <kevink@mips.com>
Subject: Re: MIPS_ATOMIC_SET again (Re: newest kernel
Message-ID: <20010526151427.A611@paradigm.rfc822.org>
References: <3B0C17D9.3060600@redhat.com> <Pine.GSO.3.96.1010524111911.6990A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.GSO.3.96.1010524111911.6990A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, May 24, 2001 at 11:32:29AM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 24, 2001 at 11:32:29AM +0200, Maciej W. Rozycki wrote:
> On Wed, 23 May 2001, Joe deBlaquiere wrote:
> 
> > ll/sc emulation. If somebody wants to make a MIPS I optimized glibc, 
> > then that's fine, but allowing the 'standard' MIPSII glibc to work on 
> > all systems simplifies life ( mine at least ;) ).
> 
>  I have no objections against providing an ll/sc emulation -- I have never
> had and certainly haven't expressed them.  What I insist on is to keep
> ISA-I-compiled glibc not making use of ll/sc.  Anyone feel free to finish
> the emulation we have.
> 
>  Anyway, an ISA-II-compiled glibc won't work on an ISA I system even if
> the ll/sc emulation works.  An ISA II is more than just an addition of the
> ll and sc instructions.  There were also branch likely, trap and
> doubleword coprocessor load instructions added in ISA II.  Do you want to
> emulate these, too? 

Isnt this the reason why Linux/Mips userspace is compiles with ISA I + ll/sc ?

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
