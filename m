Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA2512340 for <linux-archive@neteng.engr.sgi.com>; Sat, 25 Apr 1998 18:51:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA16533848
	for linux-list;
	Sat, 25 Apr 1998 18:49:00 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA15520695
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 25 Apr 1998 18:48:58 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id SAA26479
	for <linux@cthulhu.engr.sgi.com>; Sat, 25 Apr 1998 18:48:57 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-25.uni-koblenz.de [141.26.249.25])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA01049
	for <linux@cthulhu.engr.sgi.com>; Sun, 26 Apr 1998 03:48:54 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA10898;
	Sun, 26 Apr 1998 03:48:39 +0200
Message-ID: <19980426034839.39956@uni-koblenz.de>
Date: Sun, 26 Apr 1998 03:48:39 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: gcc RPM missing crtbegin.o
References: <Pine.LNX.3.95.980425195431.4684A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <Pine.LNX.3.95.980425195431.4684A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Apr 25, 1998 at 08:01:33PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Apr 25, 1998 at 08:01:33PM -0400, Alex deVries wrote:

> Hm. I've re-installed gcc from the RPM that's in the mustang directory on
> linus (2.7.2-1, build date is Dec 4 03:23:00).  "Yipee", says I, "I can
> now become an productive member of society". 
> 
> But, the gcc RPM doesn't have crtbegin.o, which is a bit odd.  It's not
> the end of the world, I snarfed it from the cross compiling RPM for i386.
> Was there a reason it wasn't included? 

It's spelled ``bug''.  This has been reported before and I'm shure I've
uploaded the apropriate fixes in form of new patch sets, source and binary
rpms.

>Clickety<

[ralf@lappi ralf]$ ssh -C -l ralf linus.linux.sgi.com
Enter passphrase for RSA key 'root@rio': 
Last login: Thu Apr 23 08:28:04 1998 from vulcan.ko.ivm.net
Welcome to linus.linux.sgi.com !

This machine serves as:
        o A  repository for SGI/Linux source code          /src/cvs
        o A  web server for SGI/Linux (www.linux.sgi.com)  /src/web
        o An ftp server for SGI/Linux (ftp.linux.sgi.com)  /src/ftp

Please, use the /src and /work directories for storing big stuff
Home dirs are on / and it fills quite fast.

Shell access to core developers and contributors via ssh only.
Happy hacking!

                        ariel@sgi.com   Jul, 1997
ralf@linus:ralf# locate gcc-2.7.2 | fgrep -e -3 | fgrep .rpm
/src/ftp/pub/redhat/redhat-5.0/RPMS/mips/gcc-2.7.2-3.mips.rpm
/src/ftp/pub/redhat/redhat-5.0/RPMS/mipsel/gcc-2.7.2-3.mipsel.rpm
/src/ftp/pub/redhat/redhat-5.0/SRPMS/gcc-2.7.2-3.src.rpm

ralf@linus:ralf#

Easy, isn't it?

> I'm having some really wonky behaviour on my filesystem with .72; files
> are disappearing off my filesystem left right and center.  For instance,
> crtbegin.o has been on the system since I first got the machine last fall.
> e2fsck's always come back clean. Now that I got my compiler working, I'm
> running .1.91 again.

I've fixed *shitloads* of bugs since .72, not too mention a dramatic increase
in performance.  You're right, filesystems on Indys (not other MIPS boxes)
had the problem of a certain ``volatilibility'', but that's gone for me.
If somebody still sees fs corruption on Indys running 2.1.91, please report.

> I also upgraded to the glibc 2.0.7 RPMs, which seems to have messed up
> tcsh.  It'd be real nice to get gdb and/or strace working to debug things
> like this.

Strace is working.  See the CVS.

There is no glibc 2.0.7.

  Ralf
