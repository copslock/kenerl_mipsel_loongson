Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA46659 for <linux-archive@neteng.engr.sgi.com>; Sat, 11 Jul 1998 19:14:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA78530
	for linux-list;
	Sat, 11 Jul 1998 19:13:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA48028
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 11 Jul 1998 19:13:10 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: from rufus.w3.org (rufus.w3.org [18.29.0.66]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA14190
	for <linux@cthulhu.engr.sgi.com>; Sat, 11 Jul 1998 10:43:33 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: (from veillard@localhost)
	by rufus.w3.org (8.8.7/8.8.7) id NAA07990
	for linux@cthulhu.engr.sgi.com; Sat, 11 Jul 1998 13:43:29 -0400
Message-ID: <19980711134329.B7620@w3.org>
Date: Sat, 11 Jul 1998 13:43:29 -0400
From: Daniel Veillard <Daniel.Veillard@w3.org>
To: linux@cthulhu.engr.sgi.com
Subject: Is SGILinux-5.0 obsolete ?
Reply-To: Daniel.Veillard@w3.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93
Organization: World Wide Web Consortium (W3C)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

 I now have both SGILinux-5.0 and SGILinux-5.1 archived on rufus.w3.org
and my feeling is that the 5.0 packages don't need anymore public exposure
(plus there are a couple of broken RPM in the 5.0 distrib).
 So I'm thinking about removing the 5.0 distrib from the mirrors, HTML output
and rpmfind database. 
 Opinions ?
 Also I may be able to grab and reinstall an old Indy at the end of the month,
but it has only a 1 Gig internal HD with a single IRIX partition, I'm not sure
I will be able to grab an external drive. In such a situation is it possible
to install SGILinux ? My limited understanding of the situation is that the
ROM loader only understand Irix partition format and then to load the kernel
one need to keep it in such a partition, in that case it seems I will have
a hard time without using a second drive for Linux install, right ?

 Daniel

-- 
Daniel.Veillard@w3.org | W3C  MIT/LCS  NE43-344  | Today's Bookmarks :
Tel : +1 617 253 5884  | 545 Technology Square   | Linux, WWW, rpm2html,
Fax : +1 617 258 5999  | Cambridge, MA 02139 USA | badminton, Kaffe,
http://www.w3.org/People/W3Cpeople.html#Veillard | HTTP-NG and Amaya.
