Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA15847 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 Aug 1998 10:24:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA25558
	for linux-list;
	Thu, 27 Aug 1998 10:23:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA91057
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Aug 1998 10:23:35 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA06071
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Aug 1998 10:23:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id NAA19838;
	Thu, 27 Aug 1998 13:25:04 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 27 Aug 1998 13:25:04 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Hill <mikehill@hgeng.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installing Rough Hat in South Simcoe County
In-Reply-To: <60222E63C9F4D011915F00A02435011C126379@BART>
Message-ID: <Pine.LNX.3.96.980827131913.10299C-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Mike,

	First off, help is no longer really that far away, as I'll be
moving to Toronto this coming Sunday (near Yonge and Shepherd for the
month of Sept, then Queen's Quay and Yonge thereafter). Finally!


On Thu, 27 Aug 1998, Mike Hill wrote:
> Finally[1] I've got my Indy connected to a Debian 2.0 pentium that has
> the tarball of the dist formerly known as Hard Hat.
> The kernel boots locally *and* with bootp, putting me into the installer
> in either case.  According to the pc's syslog, the Indy successfully
> nfsmounts the installfs directory.  After mounting /dev/sdb1 (without
> checking), the installer fails with this:
> 	Fatal error opening RPM database (I pick "Ok")
> 	install exited abnormally...received signal 11

Some questions to help guide us to the right solution:
- when you log the files beign accessed on the PC's NFS, do you see it
opening anything in /RedHat/base ?  Can you check and see this?
- if you'd like, I can just mail you this CD with Rough Cuts on it, thus
preventing the situation where you're missing a couple of files, etc.
You're also welcome to pick it up.

God, I should really revisit the installer and fix it.

- Alex
