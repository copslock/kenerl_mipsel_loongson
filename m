Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA02209 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 May 1999 07:22:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA84857
	for linux-list;
	Fri, 28 May 1999 07:20:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA45051
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 May 1999 07:20:22 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from mail.alien.bt.co.uk (orb.alien.bt.co.uk [132.146.196.84]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id HAA06330
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 May 1999 07:20:20 -0700 (PDT)
	mail_from (pete@alien.bt.co.uk)
Received: from cornfed(really [132.146.196.81]) by mail.alien.bt.co.uk
	via sendmail with smtp
	id <m10nNOH-001kwNC@mail.alien.bt.co.uk>
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 May 1999 15:13:41 +0100 (BST)
	(Smail-3.2 1996-Jul-4 #3 built 1998-May-29)
Message-Id: <m10nNOH-001kwNC@mail.alien.bt.co.uk>
Date: Fri, 28 May 1999 15:14:23 +0100 (BST)
From: Pete Young <pete@alien.bt.co.uk>
Reply-To: Pete Young <pete@alien.bt.co.uk>
Subject: glib (Was Re: X server update, observations on a successful installation)
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: OZ92zxoMe6kxbLZdIJO73Q==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 i86pc i386 
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> This happens because we use an old version of net-tools in HardHat but
> use a current kernel.  It's harmless however.  The solution is to
> upgrade net-tools.

Pulled down version 1.51 source from our nearest RedHat mirror and
built it. Still 2 routes to the local subnet. Editing
/etc/sysconfig/network-scripts/ipup and commenting out the route bit
stops it, but also removes the route to lo0. Not sure which is worse.

> The Indy hardware doesn't have a frame buffer which makes writing an
> X server more difficult.  The X clients are working fine however.

Thanks for the info. I look forward to the completion of the Xserver.

On a slightly different note, has anyone succeeded in building glib ?

I'm attempting to build glib-1.2.1   Compilation keels over in
testgthread complaining about undefined references to various pthread
functions:

gcc -g -O2 -Wall -D_REENTRANT -o .libs/testgthread testgthread.o 
../.libs/libglib.so .libs/libgthread.so -Wl,--rpath -Wl,/usr/local/lib
testgthread.o: In function `new_thread':
/usr/src/redhat/SOURCES/glib-1.2.1/gthread/testgthread.c:89: undefined reference 
to `pthread_create'
testgthread.o: In function `test_private':
/usr/src/redhat/SOURCES/glib-1.2.1/gthread/testgthread.c:197: undefined 
reference to `pthread_join'
.libs/libgthread.so: undefined reference to `pthread_getspecific'
.libs/libgthread.so: undefined reference to `pthread_key_create'
.libs/libgthread.so: undefined reference to `pthread_mutex_trylock'
.libs/libgthread.so: undefined reference to `pthread_cond_timedwait'
.libs/libgthread.so: undefined reference to `pthread_setspecific'
collect2: ld returned 1 exit status
make[2]: *** [testgthread] Error 1

Any suggestions welcomed. 

Kind regards,

Pete

  ____________________________________________________________________
  Pete Young          pete@alien.bt.co.uk        Phone +44 1473 642740
      "Just another crouton, floating on the bouillabaisse of life"
