Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA285042; Thu, 10 Jul 1997 22:09:12 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA27197 for linux-list; Thu, 10 Jul 1997 22:09:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA27192 for <linux@engr.sgi.com>; Thu, 10 Jul 1997 22:08:58 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA08566
	for <linux@engr.sgi.com>; Thu, 10 Jul 1997 22:08:56 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id AAA24990;
	Fri, 11 Jul 1997 00:08:00 -0500
Date: Fri, 11 Jul 1997 00:08:00 -0500
Message-Id: <199707110508.AAA24990@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com
Subject: Quick shmiq question.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

    Ok, now I need some advice here:  I have this piece of code which
is not cooperating very much.  You can help me to figure out what is
going wrong by taking a quick look at the Xsgi source code.

    On the directory programs/Xserver/hw/sgi, you have to grep for
shmiqInit, once you find it, quickly figure what I am doing
wrong.  And if you have a chance to tell me what the thing with XXX
is, I will be even more happy :-)

cheers,
Miguel.

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/shmiq.h>
#include <sys/stropts.h>
#include <errno.h>

int
mopen (char *file, int flags, int x)
{
	int fd;

	fd = open (file, flags, x);
	if (fd == -1){
		fprintf (stderr, "can't open %s\n", file);
		exit (1);
	}
}

int
main ()
{
	struct shmiqreq s;
	int shmiq, kbd, zero, qcntl;
	int v;
	void *shaddr;
	
	zero = mopen ("/dev/zero", O_RDWR,0);
	shaddr = mmap(0, 16384, PROT_WRITE|PROT_READ, MAP_PRIVATE, zero, 0);

	shmiq = mopen ("/dev/shmiq", O_RDWR|O_EXCL|O_NOCTTY, 3);
	
	qcntl = mopen("/dev/qcntl0", O_RDWR|O_EXCL|O_NOCTTY, 0);
	fcntl(qcntl, F_SETFD, 1);
	
	s.user_vaddr = shaddr;
	s.arg        = 0x00000553; /* XXX, this ought to be sizeof(shmiqSOMETHING) */
	                           /* XXX, figure what this one is */

	/* 0x80085101 is QIOCATTACH */
	v = ioctl (qcntl, 0x80085101, (void *) &s);
	if (v == -1)
		v = errno;
	printf ("map regs: %d/%d\n", v, errno);
	
	kbd   = mopen ("/dev/input/keyboard", O_RDWR|O_NDELAY|O_EXCL|O_NOCTTY, 0);
	
	v = ioctl (kbd, I_PUSH, "keyboard");
	printf ("I_PUSH: %d\n", v);
	v = ioctl (shmiq, I_LINK, kbd);
	printf ("I_LINK: %d\n", v);

	printf ("shmqevent is: %d", sizeof (struct shmqevent));
	while (0){
		
	}
	return 0;
}
