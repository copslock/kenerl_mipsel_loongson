Received:  by oss.sgi.com id <S42271AbQGSQFN>;
	Wed, 19 Jul 2000 09:05:13 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:59480 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42274AbQGSQEx>;
	Wed, 19 Jul 2000 09:04:53 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id IAA03561
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 08:56:57 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA06447; Wed, 19 Jul 2000 11:54:59 -0300
Date:   Wed, 19 Jul 2000 11:54:59 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc:     linux-mips@oss.sgi.com, linuxce-devel@linuxce.org
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <Pine.GSO.3.96.1000719160110.21239D-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.SGI.4.10.10007191041270.6330-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Wed, 19 Jul 2000, Maciej W. Rozycki wrote:
> I have binutils 2.10 and gcc 2.95.2 which appear to be stable, i.e. I
> haven't observed any problems recently.  I may publish patches if anyone
> is interested.  I may see if I can arrange to publish RPM packages as
> well.

Please do.  There's many of us that would be interested.  I for one am
having zero success.

I'm cross posting this from the SGI list to the linuxce list because even
though one is big endian and the other is little endian, we all still use
the same tools, and I simply need help or suggestions here regardless of
the source.

The short explination of what I'm doing is that I work for a company that
wishes to use NEC vr or QED mips processors in some products using linux
as the "embedded OS".  I put quoates on that because our product
environment is much fuller than the traditional embedded environment, to
the point that we actually need a full blown *nix running under the hood.
We plan to run the embedded processors big endian.  We are using some SGI
Indy boxes as development/eval stations at the moment as we evaluate
porting our code base.  The nice thing about the Indy is that the linux
port and user land stuff is still all compiled 32 bit R3000 style, meaning
that its binary compatible with our embedded systems, but a hell of a lot
nicer to work on.  We already know that user space binaries that run on
the Indy work identically within our embeded environment.  That much is
cool.

However, the problem is that I am having only limited success compiling
user space stuff myself on the Indy, be it our own code, or any of the
common distribution libs/apps. I cannot compile shared objects of good
size and expect apps built from them to work.  Xlibs, lesstif, etc and
apps built against them just bus error. However if I go to one of the
sites and tear open a prebuilt rpm for xlibs, or what ever, I can build
against that and get an app to work just fine, but I cannot build the
libraries themselves.  I've tried every version of gcc/egcs/binutils
that's supposed to work, and in every combination.  However, I'm just not
able to duplicate the kind of success that others appear to be having.  
Smaller things usually work.  I've gotten sources from CVS, applied
patches, even tried cross compiling, all to no avail.  Unfortunately, it's
critical that I be able to build things like that.

Anyone that's having good success, please give me some info on what your
build system/process looks like.  I'm completely clueless why I'm not
having the level of success that others appear to be having.

Started with Simple Linux 0.1, glibc-2.0.6, kernel 2.2.14, egcs-1.1.2,
binutils 2.9.5, on Indy 128M ram, R4400SC 200MHz, XL-24.  Have tried the
"manhattan" or "hard hat 5.1" SGI distro, but have never been able to get
that to install.  The 2.1.100 kernel included panics on the Indy due to
page faults in an interupt handler (says so on the screen dump).  Tried
swapping that out for the 2.2.14 kernel from Simle Linux which runs very
stable on that box, but there appears to be a kernel/glibc mismatch at
that point because things don't work right after the boot.  Would like to
try the debian distro, but cannot find a big endian root image to install
with, the site with the eb pacakages seems to be down, and cannot find the
userland utility to unpack the .deb files, so this one is out completely
at the moment.

Have tried native compiles with binutils 2.8.1, egcs-1.0.2, gcc-2.7.2. The
gcc-2.7.2/bin-2.8.1 combo was the closest that I've come.  Was able to
comple lesstif against Xlibs stolen from Hard Hat 5.1 distro and the
programs in the test directory all seemed to work. However, could not get
libs built from XFree86 4.0.1 or CVS to work.  Builds, but everything bus
errors.  Unfortunately, our c++ apps will not compile with g++-2.7.2 even
if that did work.

To clarify, I have no interest in the XServer, just the xlibs so I can
throw output out over the network.

Have also tried cross compiling using binutils 2.8.1 and egcs-1.0.3a on
an x86 box, but still same results.  Little things work, big things just
bus error.

Thanks for any sugestions.  I'm certainly stumped at this point.
