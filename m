Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA97042 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Jun 1998 12:24:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA74042
	for linux-list;
	Wed, 24 Jun 1998 12:23:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA18518
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Jun 1998 12:23:27 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id MAA23161
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Jun 1998 12:23:25 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA23403;
	Wed, 24 Jun 1998 15:22:56 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 24 Jun 1998 15:22:56 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Daniel Veillard <Daniel.Veillard@w3.org>, Bryce <root@zen.ics.uwe.ac.uk>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
In-Reply-To: <19980624090439.B1937@w3.org>
Message-ID: <Pine.LNX.3.95.980624152048.12171G-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright, alright! After just one and a half weeks of complaints, I've
fixed the problem.

Clearly, the installation file system is a mess; I will sort that out for
Alpha 2.

... and I've now rebuilt all the RH 5.1 RPMs with proper dependancies.

- Alex


-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .


On Wed, 24 Jun 1998, Daniel Veillard wrote:

> Date: Wed, 24 Jun 1998 09:04:39 -0400
> From: Daniel Veillard <Daniel.Veillard@w3.org>
> To: Alex deVries <adevries@engsoc.carleton.ca>
> Cc: linux@cthulhu.engr.sgi.com
> Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
> 
>   Alex,
> 
>  while creating the mirror of the distribution at:
> 
>      ftp://rufus.w3.org/linux/SGILinux/redhat-5.1/
> 
> I got the following errors:
> -----
> Failure on 'RETR etc/ioctl.save' command
> Failed to get etc/ioctl.save: 550 etc/ioctl.save: Permission denied.
> Failed to get file 550 etc/ioctl.save: Permission denied.
> -----
> Failure on 'RETR sbin/pam_filter/upperLOWER' command
> Failed to get sbin/pam_filter/upperLOWER: 550 sbin/pam_filter/upperLOWER: Permission denied.
> Failed to get file 550 sbin/pam_filter/upperLOWER: Permission denied.
> -----
> I also noticed a couple of .rpmorig files in /etc :-)
> 
> Daniel
> 
> -- 
> Daniel.Veillard@w3.org | W3C  MIT/LCS  NE43-344  | Today's Bookmarks :
> Tel : +1 617 253 5884  | 545 Technology Square   | Linux, WWW, rpm2html,
> Fax : +1 617 258 5999  | Cambridge, MA 02139 USA | badminton, Kaffe,
> http://www.w3.org/People/W3Cpeople.html#Veillard | HTTP-NG and Amaya.
> 
