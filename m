Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id RAA521170 for <linux-archive@neteng.engr.sgi.com>; Thu, 11 Sep 1997 17:55:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA11038 for linux-list; Thu, 11 Sep 1997 17:55:20 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA11023 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Sep 1997 17:55:18 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA10721; Thu, 11 Sep 1997 17:55:16 -0700
Date: Thu, 11 Sep 1997 17:55:16 -0700
Message-Id: <199709120055.RAA10721@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: Linux/SGI: Xsgi Shmiq/Qcntl
In-Reply-To: <199709110303.WAA25810@athena.nuclecu.unam.mx>
References: <199709110303.WAA25810@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > Hello guys,
 > 
 >     Ok, 120 system calls after the last one, I need some more help.
 > If somebody can quickly look up the IRIX X sources, I would appreciate
 > if you could tell me how a little routine works.
 > 
 >     The source code should be in a directory called:
 > xc/programs/Xserver/hw/sgi 
 > 
 >     The code does an open on /dev/shmiq and then opens: sprintf (buf,
 > "/dev/qcntl%d", mistery_variable) I want to know how it computes
 > mistery_variable.  I am obviously screwing something in the shmiq
 > emulation code. 

	fd = open( SHMIQDEVNAME, O_EXCL | O_RDWR | O_NOCTTY ) ;
	if ( fd < 0 ) {
		perror( "Failed to open shmiq device." ) ;
		return 0 ;
	}

	/* Now open the control character device */
	if ( fstat ( fd, &sb ) < 0 ) {
		perror( "fstat failed -- shmiq not opened." ) ;
		(void) close( fd ) ;
		return 0 ;
	}

	(void) sprintf( cntldev, QCNTLDEVFORMAT, minor( sb.st_rdev ) ) ;

The /dev/qcntl2 device is the control device for minor device 2 as returned
by the clone open of /dev/shmiq.  A clone device returns a different
minor device for each open call; minor device numbers are reused only
after they have been closed.  Similary, /dev/ptc is a clone device for getting
PTYs.
