Received:  by oss.sgi.com id <S42241AbQGMXbJ>;
	Thu, 13 Jul 2000 16:31:09 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:3344 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42205AbQGMXaw>;
	Thu, 13 Jul 2000 16:30:52 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id QAA21486;
	Thu, 13 Jul 2000 16:30:40 -0700
Date:   Thu, 13 Jul 2000 16:30:40 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000713163040.A20683@chem.unr.edu>
References: <20000713001601.A27565@foobazco.org> <Pine.SGI.4.10.10007131037590.20247-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10007131037590.20247-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Thu, Jul 13, 2000 at 10:58:48AM -0300
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 13, 2000 at 10:58:48AM -0300, J. Scott Kasten wrote:

> already verified that the binaries are portable.)  However, I am having
> difficulty on the Indy itself.  NONE of the shared objects that I build on
> that box can be used by programs on that box.  Yes, I either placed them

It's not clear why that is. For example, ncurses is a shared library,
and bash is linked against it. That works fine.

> I've tried building the XFree 4.0.1 libraries, Lesstiff libraries, and
> libraries from our own code base.  All breaks the same way.

I have successfully built XFree on 0.1. It even worked.

> #2 Are there specific compiler flags/phases that should/shouldn't be used
> with MIPS arch so's that are different than what I'd normally do under
> Linux?

No.

> #3 Should I be trying to cross compile the so's them selves instead of
> native builds?

If anything that would be worse. It might be faster, though. :)

> #4 Are you using different flavors of gcc/binutils to do different jobs
> because of known breakages?

I'm not because I feel that's a cop-out. If it doesn't work, we need
to fix it, not just keep using old stuff forever as a band-aid. I
don't mean offense to anyone; obviously many people need stability
rather than currency so their take on this will differ from mine; I
just don't believe that using the old toolchain is the right approach
in the long run. It's important to get the -current stuff working and
the only way that will happen is if people find and fix bugs. There
are already a few waiting for some intrepid volunteer to fix; see the
0.2b release notes and various mailing lists. There are known
breakages with binutils, for all versions I am aware of, and for most
if not all gcc versions.  However, for shared libraries and dynamic
linking, the versions included in 0.2b seem to work fine. Ideally the
new toolchain will have _better_ quality than the old one very soon;
when that does, everyone can switch and the ancient stuff can finally
die. In the meantime, consider everything I announce to be of
experimental quality, in case I haven't been adequately clear thus
far.

In the meantime, Ralf and a number of others are using egcs 1.0.3a and
binutils 2.8.1, both with patches. These may be more reliable for you.

> Any tips appreciated here.  In the mean, I'm going to start playing with
> flags.

Please don't use 0.1 any more. If you want a glibc 2.0 system, use
Hard Hat or some other "officially sanctioned" distribution. Use 0.2b
if you want to play with the current stuff.

Sorry for any confusion.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
