Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA73585 for <linux-archive@neteng.engr.sgi.com>; Sun, 3 Jan 1999 14:17:48 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA94801
	for linux-list;
	Sun, 3 Jan 1999 14:16:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from anchor.engr.sgi.com (anchor.engr.sgi.com [150.166.49.42])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA88663;
	Sun, 3 Jan 1999 14:16:32 -0800 (PST)
	mail_from (olson@anchor.engr.sgi.com)
Received: (from olson@localhost) by anchor.engr.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) id OAA36969; Sun, 3 Jan 1999 14:16:31 -0800 (PST)
From: olson@anchor.engr.sgi.com (Dave Olson)
Message-Id: <199901032216.OAA36969@anchor.engr.sgi.com>
Subject: Re: EFS volume descriptors
In-Reply-To: <368E66DC.15C986F2@netscape.com> from Mike Shaver at "Jan 2, 99 01:35:08 pm"
To: shaver@netscape.com (Mike Shaver)
Date: Sun, 3 Jan 1999 14:16:31 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
Organization: Silicon Graphics, Inc.  Mt. View, CA
X-Mailer: ELM [version 2.4ME+ PL35 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote: 
|  On an EFS CDROM, there's a volume descriptor at block 0.  On an EFS
|  partition, there's a superblock at block 1.  I'd like my all-new code to
|  handle both cases, so I'm wondering what's at block 0 of an EFS
|  partition.  Is it something that I can reliably check to see if I'm
|  mounting a partition or CD?

Nothing is at block 0 of the filesystem.  Historically, back to v6
unix, there were things like badblock tables there, so many filesystems
for unix have simply not used block 0.  efs does not use it.

Dave Olson, Silicon Graphics
http://reality.sgi.com/olson   olson@sgi.com
