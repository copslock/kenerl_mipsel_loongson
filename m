Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA10169 for <linux-archive@neteng.engr.sgi.com>; Sun, 13 Jun 1999 14:05:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA45515
	for linux-list;
	Sun, 13 Jun 1999 14:03:53 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA21857
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 13 Jun 1999 14:03:47 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02164
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Jun 1999 14:03:45 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA20299
	for <linux@cthulhu.engr.sgi.com>; Sun, 13 Jun 1999 23:03:39 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id WAA12376
	for linux@cthulhu.engr.sgi.com; Sun, 13 Jun 1999 22:25:20 +0200
Date: Sun, 13 Jun 1999 22:25:19 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: CVS problem
Message-ID: <19990613222519.A12274@uni-koblenz.de>
References: <19990611004255.B19664@thepuffingroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990611004255.B19664@thepuffingroup.com>; from Ulf Carlsson on Fri, Jun 11, 1999 at 12:42:55AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 11, 1999 at 12:42:55AM +0200, Ulf Carlsson wrote:

> I have had problems with the CVS server at linus.linux.sgi.com now for some
> time:
> 
> 	$ export CVS_RSH=ssh
> 	$ export CVSROOT="linus.linux.sgi.com:/src/cvs"
> 	$ cvs commit tm-linux.h
> 	bash: cvs: command not found
> 	cvs [commit aborted]: end of file from server (consult above message if any)
> 
> It looks like /usr/local/bin/cvs isn't in the path or something. Can someone
> please confirm this problem or fix it?

Sorry, I broke it when cleaning the shell initialization files.  It
seems that when logging on over ssh /usr/freeware/bin/bash will
ignore all startup files, therefore $PATH will not be initialized.
Glued by initializing them in /etc/defaults/login.

  Ralf
