Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA18901 for <linux-archive@neteng.engr.sgi.com>; Mon, 8 Sep 1997 10:55:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA06129 for linux-list; Mon, 8 Sep 1997 10:55:16 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA06111 for <linux@cthulhu.engr.sgi.com>; Mon, 8 Sep 1997 10:55:13 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id KAA27906; Mon, 8 Sep 1997 10:55:12 -0700
Date: Mon, 8 Sep 1997 10:55:12 -0700
Message-Id: <199709081755.KAA27906@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@fir.engr.sgi.com
Subject: Re: IRIX emulation, getting there.
In-Reply-To: <199709050350.WAA03387@athena.nuclecu.unam.mx>
References: <199709050350.WAA03387@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > This is my next show stopper:
 > 
 >    There is a misterious fcntl call in the IRIX Xsgi server:
 > it is called with the F_ALLOCSP flag, what is this flag used for in
 > the X server setup code?  
...

     This fcntl() sets the size of a file, and assures that
the underlying storage is really assigned.  From fcntl(2):

     F_FREESP  Alter storage space associated with a section of	the ordinary
	       file fildes.  The section is specified by a variable of data
	       type struct flock pointed to by the third argument arg.	The
	       data type struct	flock is defined in the	<fcntl.h> header file
	       [see fcntl(5)] and contains the following members:  l_whence is
	       0, 1, or	2 to indicate that the relative	offset l_start will be
	       measured	from the start of the file, the	current	position, or
	       the end of the file, respectively.  l_start is the offset from
	       the position specified in l_whence.  l_len is the size of the
	       section.	 An l_len of 0 frees up	to the end of the file;	in
	       this case, the end of file (i.e., file size) is set to the
	       beginning of the	section	freed.	Any data previously written
	       into this section is no longer accessible.  If the section
	       specified is beyond the current end of file, the	file is	grown
	       and filled with zeroes.	The l_len field	is currently ignored,
	       and should be set to 0.

     F_ALLOCSP This command is identical to F_FREESP.
