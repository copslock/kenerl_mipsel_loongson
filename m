Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA01411 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Jun 1998 06:05:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA43638
	for linux-list;
	Wed, 24 Jun 1998 06:04:50 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA08718
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 24 Jun 1998 06:04:48 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: from rufus.w3.org (rufus.w3.org [18.29.0.66]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id GAA06597
	for <linux@cthulhu.engr.sgi.com>; Wed, 24 Jun 1998 06:04:47 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: (from veillard@localhost)
	by rufus.w3.org (8.8.7/8.8.7) id JAA02732;
	Wed, 24 Jun 1998 09:04:39 -0400
Message-ID: <19980624090439.B1937@w3.org>
Date: Wed, 24 Jun 1998 09:04:39 -0400
From: Daniel Veillard <Daniel.Veillard@w3.org>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
Reply-To: Daniel.Veillard@w3.org
References: <199806161546.RAA28259@aisa.fi.muni.cz> <Pine.LNX.3.95.980616120211.26590B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.92.10i
In-Reply-To: <Pine.LNX.3.95.980616120211.26590B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Tue, Jun 16, 1998 at 12:07:58PM -0400
Organization: World Wide Web Consortium (W3C)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  Alex,

 while creating the mirror of the distribution at:

     ftp://rufus.w3.org/linux/SGILinux/redhat-5.1/

I got the following errors:
-----
Failure on 'RETR etc/ioctl.save' command
Failed to get etc/ioctl.save: 550 etc/ioctl.save: Permission denied.
Failed to get file 550 etc/ioctl.save: Permission denied.
-----
Failure on 'RETR sbin/pam_filter/upperLOWER' command
Failed to get sbin/pam_filter/upperLOWER: 550 sbin/pam_filter/upperLOWER: Permission denied.
Failed to get file 550 sbin/pam_filter/upperLOWER: Permission denied.
-----
I also noticed a couple of .rpmorig files in /etc :-)

Daniel

-- 
Daniel.Veillard@w3.org | W3C  MIT/LCS  NE43-344  | Today's Bookmarks :
Tel : +1 617 253 5884  | 545 Technology Square   | Linux, WWW, rpm2html,
Fax : +1 617 258 5999  | Cambridge, MA 02139 USA | badminton, Kaffe,
http://www.w3.org/People/W3Cpeople.html#Veillard | HTTP-NG and Amaya.
