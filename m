Received:  by oss.sgi.com id <S42276AbQGSSwE>;
	Wed, 19 Jul 2000 11:52:04 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:19782 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42257AbQGSSvj>;
	Wed, 19 Jul 2000 11:51:39 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id LAA26366
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 11:43:43 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id OAA06751; Wed, 19 Jul 2000 14:42:15 -0300
Date:   Wed, 19 Jul 2000 14:42:15 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com, linuxce-devel@linuxce.org
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000719101346.B7480@chem.unr.edu>
Message-ID: <Pine.SGI.4.10.10007191403500.6661-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 19 Jul 2000, Keith M Wesolowski wrote:

> On Wed, Jul 19, 2000 at 11:54:59AM -0300, J. Scott Kasten wrote:
> > However, the problem is that I am having only limited success compiling
> > user space stuff myself on the Indy, be it our own code, or any of the
> > common distribution libs/apps. I cannot compile shared objects of good
> > size and expect apps built from them to work.  Xlibs, lesstif, etc and
> > apps built against them just bus error. However if I go to one of the
> 
> This is interesting. I have seen plenty of problems (with several
> toolchains) building pic objects and then using -static to link. But
> linking against shared objects seems to work fine. I have successfully
> built the X libs (4.0 + Guido's newport patch) with the toolchain
> included in Simple 0.2b, and have run applications linked against
> them. The entire system was built from the same toolchain.

I pulled down 0.2b yesterday an will be giving that a whirl today of
course.  However, yes, this problem is interesting.  I've used GDB just
enough on small apps compiled against xlibs/lesstif (things in the lesstif
test directory) to gather limited info on the problem.  Some calls into
the libraries work, however some fail.  I've not isolated the point of
failure, but when it does, the program counter is way off in impossible
memory, and gdb has lost the program call stack so it cannot tell me where
I am, or how I got there.  This behavior is not random, it appears that
it's exactly reproduceable, so with sufficient effort could presumably be
tracked down.  However, my pressing need is simply to get a tool chain
that works within reason.  Although I'm interested in doing some general
sluthing to do my part to improve the quality of publicly available tools,
unfortunately that's a luxury that must wait a little while when you have
corporate deadlines to meet.
 
> > swapping that out for the 2.2.14 kernel from Simle Linux which runs very
> > stable on that box, but there appears to be a kernel/glibc mismatch at
> > that point because things don't work right after the boot.  Would like to
> 
> Could you explain in greater detail? For example, the userland in
> Simple 0.2b will not work with kernel < 2.3.51, and will give an
> error to that effect if you try to boot it with 2.2.14. This is
> intentional; it seems for some reason that glibc 2.2 userland on a 2.2
> kernel will have, actually, the kind of behaviour you are observing.

Simple 0.1 has run very stable for me (meaning no crashes, lockups,
etc...) using the 2.2.14 kernel.  The only problem I have is building my
own shared objects.  I've beat that system for days on end with large
compiles, heavy NFS traffic, etc. and not had it mis-behave.  

I tried booting the 5.1 install image using the included kernel (2.1.100 I
beleive), but it either hangs after initializing eth0, or panics sometime
there after with a "page fault in irq handler" message.

On a whim, I just plunked down 2.2.14 which I know runs smooth and tried
booting the 5.1 install.  I then get a message "Cannot open initial
console."  Yes, the dev nodes are in place and so forth.  Some time ago, I
had gotten past that, but don't remember how.  Anyway, the result was that
things like fdisk could not write the disk and on and on.  This sounds
like a glibc missmatch.  I could try slipping that in too and see what
happens.

In order to move quickly, I had pulled a few libraries from the 5.1 and
plunked them down under Simple to try some things, having checked
dependencies and so forth of course.  I fully admit that such a move could
indeed be part of my problem.  However it's the libraries that I've
stolen in this fashion that work!  Anyway, point is, I've tried moving to
a more complete distro where things have been uniformly compiled with the
same tool chain to see if the shared object problem goes away.  However,
I've not been successfull in that endeavor either.

> > errors.  Unfortunately, our c++ apps will not compile with g++-2.7.2 even
> > if that did work.
> 
> And unfortunately we still don't have a working c++ compiler for
> 2.96. Hopefully we're close though.

I'd be happy to use different c and c++ compilers, if it worked well.
However, it is of course preferable to remain consistent.  There would
even be an interest in modifying our own C++ code so that templates would
get through g++ 2.7.2 if we had too.  However, it's got to work before we
can make that effort.

> I almost wonder if your hardware is broken somehow, as the system you
> describe is identical in every way to the one I am using to develop
> Simple.

Beleive me, the thought has crossed my mind.  We have 3 identical boxes
that were distributed through our different project teams.  I will
be trying this on one of those minimum as well.


Thanks again for your assistance.

-JSK-
