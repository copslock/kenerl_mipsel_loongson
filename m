Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA3626519 for <linux-archive@neteng.engr.sgi.com>; Sat, 2 May 1998 18:01:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA19363526
	for linux-list;
	Sat, 2 May 1998 17:56:16 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA19568442
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 2 May 1998 17:56:13 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id RAA03877
	for <linux@cthulhu.engr.sgi.com>; Sat, 2 May 1998 17:56:12 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA31104;
	Sat, 2 May 1998 20:56:08 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sat, 2 May 1998 20:56:08 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 updated RPMS for SGI/Linux
In-Reply-To: <19980503010816.49649@uni-koblenz.de>
Message-ID: <Pine.LNX.3.95.980502204018.4130E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 3 May 1998 ralf@uni-koblenz.de wrote:
> On Sat, May 02, 1998 at 03:12:30PM -0400, Alex deVries wrote:
> > May 02  4:00  AdV  Caught up with RedHat updates for 5.0
> Could you also mention that on the news page?  People already believe
> the project is dead because nobody writes stupid web docs ...

Yup, that's done now.

> >    ld.so-1.9.5-2.mipseb.rpm
> No.
> Heavens, I don't know why this thing built at all for you but this package
> neither supports MIPS nor is it required.  The program interpreter (aka

It built badly, but it slipped through the cracks and made it into the
distribution.  I didn't quite know the status of it.  Anyway, this is now
in the trash.

> > The ones I still haven't sorted out are:
> > kaffe
> Afaik kaffee is hairy, because writing a MIPS JIT is required.

Yeah, I don't see this happening any time soon.  Too bad.

> > smbfs
> > util-linux
> > mars-nwe
> > ppp
> > ncpfs
> At least some of these will build if you install Linux 2.0 header files
> and the X stuff of which tarballs are online.  It's one of the cheats I
> never published ...  I'm using the headerfiles of my Cobalt Qube kernel for
> this purpose.  They should have newer kernel source rpms on ftp by now, I
> think.

util-linux definitely needs some fixing, it is such a badly written
package.  The others were things like errors with FD_ZERO and others,
clearly with header files being, er, different than on i386.

This brings up the issue of getting all the kernel fixes back into the
main stream kernel _before_ 2.2 so that things get synched up right.
There's a large amount of comfort for this project to stick with what The
Big Guys (RedHat) are releasing.  Of course we don't know that they'll be
moving to 2.2 when it comes out, but 2.0 is useless for us and 2.1 seems
less likely.  Of course, all this is just guess work, since intelligently
people are avoiding vapourware.  I doubt there's even been an announcement
of Red Hat distributing a 5.1...

In #linux, Alan said that Ralf and DaveM were working on this merge.  I
know that Mike Shaver said he was interested.  All I can say is that I
probably don't have time for it.

Also, for the mipsel packagers out there, could you kindly now use RPM
2.4.109?  There's a source RPM on linus for this. It generates a different
architecture of the packages.  If I had a mipsel machine, I'd do it,
but...

> Definately, the current documentation is pretty much (censored).

Yup.  Oh, god, doing the actual work is so much more fun than updating WWW
pages... *sigh*.

- Alex
