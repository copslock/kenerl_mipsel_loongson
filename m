Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id TAA344847 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 19:13:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA11560 for linux-list; Wed, 10 Sep 1997 19:12:40 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA11556 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 19:12:38 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA26772 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 19:12:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA11551 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 19:12:35 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id TAA11849
	for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 19:12:34 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id VAA25377;
	Wed, 10 Sep 1997 21:04:06 -0500
Date: Wed, 10 Sep 1997 21:04:06 -0500
Message-Id: <199709110204.VAA25377@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: Linux/SGI: MAP_AUTOGROW, F_ALLOCSP
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello,

   I am running into a new problem: the X server is doing the
following:

	unlink ("/tmp/.Xshmtrans0");
	tfd = open ("/tmp/.Xshmtrans0", O_RDWR | O_CREAT);
	fcntl(tfd, F_SETFD, 1);
	fcntl(tfd, F_SETLKW, type=F_WRLCL, whence=SEEK_SET start=0 len=1)
	read(6, 0x7fff1b04, 4096) = 0;
	fstat(6, 0x7fff18e0) = 0;
	lseek(6, 0, SEEK_SET) = 0
	fcntl(6, F_ALLOCSP, whence=SEEK_SET, start=5224 len=0)
	mmap(0xe800000, 2149480, PROT_WRITE|PROT_READ, MAP_SHARED|MAP_AUTOGROW, 6, 0) = 0xe800000

   OK, my problem right now is that the code is using the MAP_AUTOGROW
flag for mmap.  And the second problem is that I do not understand
what the role for F_ALLOCSP is (thanks to all of you that sent me
information on this flag), but it still does not make sense.

   Regarding F_ALLOCSP: I am ignoring it.

   Regarding mmap (..., MAP_AUTOGROW,...) I have implemented two
solutions: 

	1. The "this does not have a chance of being accepted by the
	   Main Penguin" approach which implemented MAP_AUTOGROW:

		basically: new flag, and an extra if in mm/filemap.c:
	        filemap_nopage () routine.

	   This flag is not even on the opengroup web pages, so it has
           a very little chance of being accepted just for Xsgi's
           sake. 

	2. The "this sucks, but it will get into the main
           kernel real fast": on irix_mmap () if the MAP_AUTOGROW flag
           is set, it will check if the top limit for the mmap is
           bigger that the current file size, if it is it does:
	
		o = sys_lseek (fd, offset + len - 1, SEEK_SET);
		sys_write (fd, "", 1);
		sys_lseek (fd, o, SEEK_SET);

     Any ideas, comments?  I am ready to commit approach (2) ;-)

Cheers,
Miguel.
