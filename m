Received: (from majordomo@localhost)
	by oss.sgi.com (8.9.3/8.9.3) id PAA17039
	for linuxmips-outgoing; Wed, 27 Oct 1999 15:50:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linuxmips@oss.sgi.com using -f
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.9.3/8.9.3) with ESMTP id PAA17034
	for <linuxmips@oss.sgi.com>; Wed, 27 Oct 1999 15:50:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA5130179
	for <linuxmips@oss.sgi.com>; Wed, 27 Oct 1999 15:54:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA63851
	for linux-list;
	Wed, 27 Oct 1999 15:35:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA07889
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 27 Oct 1999 15:35:05 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA5169141
	for <linux@cthulhu.engr.sgi.com>; Wed, 27 Oct 1999 15:35:02 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id D1CDE7F3; Thu, 28 Oct 1999 00:34:59 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 246C7902A; Thu, 28 Oct 1999 00:30:35 +0200 (CEST)
Date: Thu, 28 Oct 1999 00:30:35 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: latest binutils cygnus CVS 991025
Message-ID: <19991028003034.A781@paradigm.rfc822.org>
References: <19991026162026.I1207@paradigm.rfc822.org> <19991027103326.A6252@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <19991027103326.A6252@uni-koblenz.de>; from Ralf Baechle on Wed, Oct 27, 1999 at 10:33:26AM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk

On Wed, Oct 27, 1999 at 10:33:26AM +0200, Ralf Baechle wrote:
> On Tue, Oct 26, 1999 at 04:20:26PM +0200, Florian Lohoff wrote:
> 
> > Hi,
> > does anyone have experiences with the latest (e.g. 991025) binutils from 
> > cygnus CVS ?
> > 
> > I got it build for "mipsel-unknown-linux-gnu" and got a libgmp2
> > build (Which fails with binutils 2.8.1 -> segfault ld)
> 
> Try the following:
> 
>   echo 'main(){}' > test.c
>   gcc -o test test.c -lm -lieee

(root@repeat)/tmp/tt#   echo 'main(){}' > test.c
(root@repeat)/tmp/tt#   gcc -o test test.c -lm -lieee
collect2: ld terminated with signal 11 [Segmentation fault]
(root@repeat)/tmp/tt# ld -v
GNU ld version 2.8.1 (with BFD 2.8.1)

(root@repeat)/tmp/tt# export PATH=/data/devel/binutils-991025/bin/:$PATH
(root@repeat)/tmp/tt#   gcc -o test test.c -lm -lieee
(root@repeat)/tmp/tt# ls -la
total 15
drwxrwxr-x   2 root     root         1024 Oct 27 22:07 .
drwxr-xr-x   6 root     root         2048 Oct 27 22:07 ..
-rwxrwxr-x   1 root     root        12201 Oct 27 22:07 test
-rw-rw-r--   1 root     root            9 Oct 27 22:07 test.c
(root@repeat)/tmp/tt# ./test
(root@repeat)/tmp/tt# ld -v
GNU ld version 2.9.5 (with BFD 2.9.5)

> I hope you got a cronjob to remove core files ;-)

Nope - Dont seem to need it ...

>  - Symbol versioning is broken in the CVS version.  There is no fix yet for
>    this problem.
>  - The CVS gas version has a few problems with weak symbols, aliases and
>    other special cases.  These usually don't show up.  Anyway, the patchkit
>    on oss.sgi.com has all these fixes which haven't made their way into
>    CVS.
> 
> I've spent a tremendous amount of time into tracking down a large number of
> other bugs in binutils; I was able to rebuild entire RH 6.0 with that
> linker.


Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
  ...  The failure can be random; however, when it does occur, it is
  catastrophic and is repeatable  ...             Cisco Field Notice
