Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA86092 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Jun 1999 15:14:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA01051
	for linux-list;
	Thu, 10 Jun 1999 15:11:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA27019
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Jun 1999 15:11:36 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: from calypso (dialup88-11-4.swipnet.se [130.244.88.164]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03385
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Jun 1999 15:11:27 -0700 (PDT)
	mail_from (ulfc@thepuffingroup.com)
Received: by calypso (Linux Smail3.2.0.101 #1)
	id m10sDXD-003Ln3C; Fri, 11 Jun 1999 00:42:55 +0200 (CEST)
Date: Fri, 11 Jun 1999 00:42:55 +0200
From: Ulf Carlsson <ulfc@thepuffingroup.com>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: CVS problem
Message-ID: <19990611004255.B19664@thepuffingroup.com>
Mail-Followup-To: Linux SGI <linux@cthulhu.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I have had problems with the CVS server at linus.linux.sgi.com now for some
time:

	$ export CVS_RSH=ssh
	$ export CVSROOT="linus.linux.sgi.com:/src/cvs"
	$ cvs commit tm-linux.h
	bash: cvs: command not found
	cvs [commit aborted]: end of file from server (consult above message if any)

It looks like /usr/local/bin/cvs isn't in the path or something. Can someone
please confirm this problem or fix it?

- Ulf
