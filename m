Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA46397 for <linux-archive@neteng.engr.sgi.com>; Sun, 24 May 1998 00:27:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA06831
	for linux-list;
	Sun, 24 May 1998 00:27:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA08165
	for <linux@engr.sgi.com>;
	Sun, 24 May 1998 00:27:08 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: from rufus.w3.org (rufus.w3.org [18.29.0.66]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id AAA04564
	for <linux@engr.sgi.com>; Sun, 24 May 1998 00:27:07 -0700 (PDT)
	mail_from (veillard@rufus.w3.org)
Received: (from veillard@localhost)
	by rufus.w3.org (8.8.7/8.8.7) id DAA11511
	for linux@engr.sgi.com; Sun, 24 May 1998 03:27:06 -0400
Message-ID: <19980524032705.B10127@w3.org>
Date: Sun, 24 May 1998 03:27:05 -0400
From: Daniel.Veillard@w3.org
To: linux@cthulhu.engr.sgi.com
Subject: Added SGIlinux to the RPM database
Reply-To: Daniel.Veillard@w3.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.92.7
Organization: World Wide Web Consortium (W3C)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  Just to inform you that I have just added a mirror of SGIlinux
at ftp://rufus.w3.org/linux/SGILinux/redhat-5.0/ and that the
packages are now indexed in the RPM database at

  http://rufus.w3.org/linux/RPM/SGIlinux/5.0/

 hope it may prove useful,

 Daniel

P.S. 
  I got some real problems with 5 packages in the noarch directory,
  it seems that their content is somewhat garbled, the RPM (4.12)
  library cannot properly read the header, at least on an Intel
  platform:
----------
~/rpm2html -> ./rpm2html config.sgi 
Scanning directory /linux/SGILinux/redhat-5.0/RPMS for RPMs
Invalid package setconsole-1.0-3.noarch.rpm : garbled name
Invalid package rootfiles-1.5-3.noarch.rpm : garbled name
Invalid package pamconfig-0.51-4.noarch.rpm : garbled name
Invalid package nls-1.0-3.noarch.rpm : garbled name
Invalid package mysterious-1.0-3.noarch.rpm : garbled name
~/rpm2html -> 
----------
~/rpm2html -> rpm -qip /linux/SGILinux/redhat-5.0/RPMS/noarch/setconsole-1.0-3.noarch.rpm
Name        :                             Distribution: e for a new
console. The console may be either the local terminal (directly attached
to the system via a video card) or a serial console.
Version     : t                                 Vendor: console. The console may be either the local terminal (directly attached
to the system via a video card) or a serial console.
Release     : c                             Build Date: Mon Mar 13 10:32:06 1995
Install date: (not installed)               Build Host: /systty, and /dev/console for a new
console. The console may be either the local terminal (directly attached
to the system via a video card) or a serial console.
Group       : irectly attached
to the system via a video card) or a serial console.   Source RPM: onsole.8
Size        : 1853058924
Packager    : may be either the local terminal (directly attached
to the system via a video card) or a serial console.
Summary     : 
Description :
y
~/rpm2html -> 
----------

-- 
Daniel.Veillard@w3.org | W3C  MIT/LCS  NE43-344  | Today's Bookmarks :
Tel : +1 617 253 5884  | 545 Technology Square   | Linux, WWW, rpm2html,
Fax : +1 617 258 5999  | Cambridge, MA 02139 USA | badminton, Kaffe,
http://www.w3.org/People/W3Cpeople.html#Veillard | HTTP-NG and Amaya.
