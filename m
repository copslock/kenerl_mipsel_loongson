Received:  by oss.sgi.com id <S305201AbQDBQXz>;
	Sun, 2 Apr 2000 09:23:55 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:28468 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305164AbQDBQXs>; Sun, 2 Apr 2000 09:23:48 -0700
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA02233; Sun, 2 Apr 2000 09:27:31 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA03288
	for linux-list;
	Sun, 2 Apr 2000 09:15:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA00062
	for <linux@engr.sgi.com>;
	Sun, 2 Apr 2000 09:15:39 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA07172
	for <linux@engr.sgi.com>; Sun, 2 Apr 2000 09:15:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-2.uni-koblenz.de (cacc-2.uni-koblenz.de [141.26.131.2])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id SAA28055;
	Sun, 2 Apr 2000 18:15:20 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407778AbQDBMWp>;
	Sun, 2 Apr 2000 14:22:45 +0200
Date:   Sun, 2 Apr 2000 14:22:45 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu, aj@suse.de
Subject: Re: pause()
Message-ID: <20000402142245.A8504@uni-koblenz.de>
References: <20000331151555.A5911@uni-koblenz.de> <20000331195303.B20241@paradigm.rfc822.org> <20000402023425.B829@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000402023425.B829@uni-koblenz.de>; from ralf@oss.sgi.com on Sun, Apr 02, 2000 at 02:34:25AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 02, 2000 at 02:34:25AM +0200, Ralf Baechle wrote:

> > On Fri, Mar 31, 2000 at 03:15:55PM +0200, Ralf Baechle wrote:
> > > I just found another brainfart in the libc / kernel interface.  In the
> > > believe libc wouldn't use the pause(2) syscall any longer I removed it.
> > > This makes a number of programs like screen burn all CPU they can get.
> > > I'll provide two fixes, one to libc and a second for the kernel and
> > > either one will be sufficient.
> > 
> > Could this also be the cause of "top" refreshing the screen as fast
> > as it can ? I noticed that when i rebuild the debian procps package
> > and tried top ... It then consumes the cpu it gets ...
> 
> I haven't tried myself but sounds very probable.  The sympthon is that
> an strace will show large numbers of pause(2) syscalls which all return
> with -ENOSYS as error.

Ok, fix implemented and tested.  I made sure that glibc now actually compiles
even with 2.3.99-pre3 headers which stock 2.0 won't on any architecture.  The
full glibc patch is a bit too large to be posted to this list, so I'll just
put it on oss.sgi.com after my arrival in Mountain View so that should be
about Tuesday.

The pause fix itself is a new pause(3) function which tries to use pause(2)
where available.  If that ever fails with ENOSYS then it will switch over
to the emulation of the pause syscall.  I'll also add the pause(2) syscall
back to all kernel flavours which will ensure that either a libc or a kernel
upgrade will fix the pause bug.  This is the fix:

New file glibc/sysdeps/unix/sysv/linux/mips/pause.c:

/* Copyright (C) 1991, 1996, 2000 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with the GNU C Library; see the file COPYING.LIB.  If not,
   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

#include <errno.h>
#include <signal.h>
#include <unistd.h>


/* Suspend the process until a signal arrives.
   This always returns -1 and sets errno to EINTR.  */

extern int __sys_pause(void);

int
__libc_pause (void)
{
  static int must_emulate = 0;

  if (!must_emulate)
    {
      int errno_saved = errno;
      int retval = __sys_pause();

      if (retval >= 0 || errno != ENOSYS)
	return retval;

      __set_errno(errno_saved);
      must_emulate = 1;
    }

  return __sigpause (__sigblock (0), 0);
}
weak_alias (__libc_pause, pause)

Add an entry for pause in sysdeps/unix/sysv/linux/mips/syscalls.list:

s_pause		pause	pause		0	__sys_pause

This next libc release fixes all open bugs on my list except maybe a merge
with all one of the inofficial 2.0.7 releases that have been made by
non-FSF people.  So if after the release there should still be open bugs,
please report again.

  Ralf
