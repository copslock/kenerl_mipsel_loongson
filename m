Received:  by oss.sgi.com id <S305203AbQDBQt4>;
	Sun, 2 Apr 2000 09:49:56 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53575 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305202AbQDBQtt>;
	Sun, 2 Apr 2000 09:49:49 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA04961; Sun, 2 Apr 2000 09:45:07 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA39017
	for linux-list;
	Sun, 2 Apr 2000 09:41:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA67857
	for <linux@engr.sgi.com>;
	Sun, 2 Apr 2000 09:40:56 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08003
	for <linux@engr.sgi.com>; Sun, 2 Apr 2000 09:40:48 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id AB6377D9; Sun,  2 Apr 2000 18:40:22 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 817A38FC3; Sun,  2 Apr 2000 18:20:04 +0200 (CEST)
Date:   Sun, 2 Apr 2000 18:20:04 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, aj@suse.de
Subject: Re: pause()
Message-ID: <20000402182004.B11880@paradigm.rfc822.org>
References: <20000331151555.A5911@uni-koblenz.de> <20000331195303.B20241@paradigm.rfc822.org> <20000402023425.B829@uni-koblenz.de> <20000402142245.A8504@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000402142245.A8504@uni-koblenz.de>; from Ralf Baechle on Sun, Apr 02, 2000 at 02:22:45PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 02, 2000 at 02:22:45PM +0200, Ralf Baechle wrote:

> The pause fix itself is a new pause(3) function which tries to use pause(2)
> where available.  If that ever fails with ENOSYS then it will switch over
> to the emulation of the pause syscall.  I'll also add the pause(2) syscall
> back to all kernel flavours which will ensure that either a libc or a kernel
> upgrade will fix the pause bug.  This is the fix:

As we are still quiet experimental and nobody else complained about
pause syscall wouldnt it be overkill to do a pause emulation ? Just fix
the kernel and other glibc bugs and document this in the MIPS-FAQ
that people seeing this problem should upgrade to <blafasel>.

> This next libc release fixes all open bugs on my list except maybe a merge
> with all one of the inofficial 2.0.7 releases that have been made by
> non-FSF people.  So if after the release there should still be open bugs,
> please report again.

I have made a glibc 2.0.7 package (debian) from the original slink
debian package + the mips patches - I have problems building without
hacking as binarys like "zic" etc dont work with the old glibc 
installed natively (They are compiled against the fresh glibc 
and run with the old glibc something IIRC so they segfault - Makefile
bugs). This package has not been used by me but other debian people
afaik - Probably they should speak up and report problems/success.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
