Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA73731 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 14:23:47 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA56055
	for linux-list;
	Sun, 3 Jan 1999 14:22:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA33221;
	Sun, 3 Jan 1999 14:22:55 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id OAA25109; Sun, 3 Jan 1999 14:22:55 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199901032222.OAA25109@anchor.engr.sgi.com>
Subject: Re: EFS volume descriptors
In-Reply-To: <368FED40.12D7952E@netscape.com> from Mike Shaver at "Jan 3, 99 05:20:48 pm"
To: shaver@netscape.com (Mike Shaver)
Date: Sun, 3 Jan 1999 14:22:55 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote: 
|  Dave Olson wrote:
|  > Nothing is at block 0 of the filesystem.  Historically, back to v6
|  > unix, there were things like badblock tables there, so many filesystems
|  > for unix have simply not used block 0.  efs does not use it.
|  
|  Drat.  So do I need the user to tell me if it's an EFS CD vs. an EFS
|  partition, so that I know to use the voldesc or not?  I guess I could
|  register a second fstype ("efscd" or some such) and make the user use
|  that.

Look at block 0 on the disk ("absolute" block 0), and use the magic 
number to see if it's an sgi volume.  If it is, for each partition
other than 8 and 10, check to see if block 1 is an EFS superblock.
That's the only possible way.  For almost all (but not all!) efs
CD's, there will only be partition 7,8,10, so you can just check
partition 7, if you want to be lazy.

And of course, it's possible to have hybrid iso9660 and sgi/efs CD's
as well, so you might still want to check for iso9660.


Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
