Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA42352 for <linux-archive@neteng.engr.sgi.com>; Sat, 29 May 1999 16:42:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA44289
	for linux-list;
	Sat, 29 May 1999 16:40:23 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA03307
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 May 1999 16:40:20 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA01076
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 May 1999 16:40:18 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA20742
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 May 1999 01:40:14 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.8.7) id RAA01551;
	Sat, 29 May 1999 17:00:58 +0200
Date: Sat, 29 May 1999 17:00:58 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Pete Young <pete@alien.bt.co.uk>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: glib (Was Re: X server update, observations on a successful installation)
Message-ID: <19990529170058.C1517@uni-koblenz.de>
References: <m10nNOH-001kwNC@mail.alien.bt.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <m10nNOH-001kwNC@mail.alien.bt.co.uk>; from Pete Young on Fri, May 28, 1999 at 03:14:23PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, May 28, 1999 at 03:14:23PM +0100, Pete Young wrote:

> > This happens because we use an old version of net-tools in HardHat but
> > use a current kernel.  It's harmless however.  The solution is to
> > upgrade net-tools.
> 
> Pulled down version 1.51 source from our nearest RedHat mirror and built
> it. Still 2 routes to the local subnet. Editing
> /etc/sysconfig/network-scripts/ipup and commenting out the route bit stops
> it, but also removes the route to lo0. Not sure which is worse.

Well, my advice was not complete.  Why upgrading net-tools is necessary you
also have to upgrade /sbin/ifup to a newer version.  The problem's cause is
that Linux 2.2 adds a route to every interface automatically.  The ifup
script then adds another route ...

> On a slightly different note, has anyone succeeded in building glib ?

Me :-)

> I'm attempting to build glib-1.2.1   Compilation keels over in
> testgthread complaining about undefined references to various pthread
> functions:
> 
> gcc -g -O2 -Wall -D_REENTRANT -o .libs/testgthread testgthread.o 
> ../.libs/libglib.so .libs/libgthread.so -Wl,--rpath -Wl,/usr/local/lib
> testgthread.o: In function `new_thread':
> /usr/src/redhat/SOURCES/glib-1.2.1/gthread/testgthread.c:89: undefined reference 
> to `pthread_create'
> testgthread.o: In function `test_private':
> /usr/src/redhat/SOURCES/glib-1.2.1/gthread/testgthread.c:197: undefined 
> reference to `pthread_join'
> .libs/libgthread.so: undefined reference to `pthread_getspecific'
> .libs/libgthread.so: undefined reference to `pthread_key_create'
> .libs/libgthread.so: undefined reference to `pthread_mutex_trylock'
> .libs/libgthread.so: undefined reference to `pthread_cond_timedwait'
> .libs/libgthread.so: undefined reference to `pthread_setspecific'
> collect2: ld returned 1 exit status
> make[2]: *** [testgthread] Error 1
> 
> Any suggestions welcomed. 

The program should be linked against libpthread, so the above link command
lacks the -lpthread option.  The question is now, why.  I think this happens
due to a bug which has been fixed in the meantime.  Please try to upgrade to
the libc from the Redhat 5.2 directory, does rebuilding work them?

  Ralf
