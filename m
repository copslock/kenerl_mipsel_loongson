Received:  by oss.sgi.com id <S42227AbQGNALj>;
	Thu, 13 Jul 2000 17:11:39 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:31301 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42205AbQGNAL0>;
	Thu, 13 Jul 2000 17:11:26 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id RAA26370
	for <linux-mips@oss.sgi.com>; Thu, 13 Jul 2000 17:04:05 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA21585; Thu, 13 Jul 2000 19:59:03 -0300
Date:   Thu, 13 Jul 2000 19:59:03 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000713163040.A20683@chem.unr.edu>
Message-ID: <Pine.SGI.4.10.10007131943160.21532-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Thu, 13 Jul 2000, Keith M Wesolowski wrote:
> > However, I am having
> > difficulty on the Indy itself.  NONE of the shared objects that I build on
> > that box can be used by programs on that box.  Yes, I either placed them
> 
> It's not clear why that is. For example, ncurses is a shared library,
> and bash is linked against it. That works fine.

I know, all the other SO's work too, it only seems to affect the ones that
I build, however, I have discovered that some of them do work, but many
don't.

> > I've tried building the XFree 4.0.1 libraries, Lesstiff libraries, and
> > libraries from our own code base.  All breaks the same way.
> 
> I have successfully built XFree on 0.1. It even worked.

Well, that's the status that I'm aiming for!

> > #3 Should I be trying to cross compile the so's them selves instead of
> > native builds?
> 
> If anything that would be worse. It might be faster, though. :)

Agreed, however I'm just looking for a solution.

> > #4 Are you using different flavors of gcc/binutils to do different jobs
> > because of known breakages?
> 
> I'm not because I feel that's a cop-out. If it doesn't work, we need
> to fix it, not just keep using old stuff forever as a band-aid. I
> don't mean offense to anyone; obviously many people need stability
> rather than currency so their take on this will differ from mine; I
> just don't believe that using the old toolchain is the right approach
> in the long run. It's important to get the -current stuff working and
> the only way that will happen is if people find and fix bugs. There
> are already a few waiting for some intrepid volunteer to fix; see the
> 0.2b release notes and various mailing lists. There are known
> breakages with binutils, for all versions I am aware of, and for most
> if not all gcc versions.  However, for shared libraries and dynamic
> linking, the versions included in 0.2b seem to work fine. Ideally the
> new toolchain will have _better_ quality than the old one very soon;
> when that does, everyone can switch and the ancient stuff can finally
> die. In the meantime, consider everything I announce to be of
> experimental quality, in case I haven't been adequately clear thus
> far.

Again, I agree that is the aproach to take in the long run.  However, my
need is very urgent so I need to find something that works however I have
to do it as I'm attempting to meet a corporate deadline for some
development.

> In the meantime, Ralf and a number of others are using egcs 1.0.3a and
> binutils 2.8.1, both with patches. These may be more reliable for you.

I will evaluate these as I evaluate the tools from the SLM 0.2b release as
well.  The catch I have with gcc-2.96 is that I must have the C++
compiler as well.  But again, I'll figure out what works for me and what
doesn't.  Mainly, I needed to clarify that you guys were not doing
anything special with compiler flags, etc...

> Please don't use 0.1 any more. If you want a glibc 2.0 system, use
> Hard Hat or some other "officially sanctioned" distribution. Use 0.2b
> if you want to play with the current stuff.

Well, other than the SO problem, I've had really good luck with that, and
it's really jumpstarted my work quite far.  I've stolen bits and pieces of
what wasn't in there from Hard Hat as needed.  ;-)

I'll be setting up an 0.2b partition soon to evaluate the 2.4.0 kernel and
updated glibc as well at some point.
