Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA74545 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Jun 1999 12:45:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA03108
	for linux-list;
	Thu, 17 Jun 1999 12:44:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA99380
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Jun 1999 12:44:16 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA08067
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Jun 1999 12:44:14 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id OAA02702;
	Thu, 17 Jun 1999 14:43:51 -0500
Date: Thu, 17 Jun 1999 14:54:06 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Mike Hill <mikehill@hgeng.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Booting an Indigo2
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC07EA0E@BART>
Message-ID: <Pine.LNX.3.96.990617144843.17965A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 17 Jun 1999, Mike Hill wrote:
> Sorry, this looks familiar.  Here's what I get in my serial console:
> 
[lots of stuff that looks OK clipped]
> Root-NFS: Server returned error -13 while mounting /usr/src/installfs
> VFS: Unable to mount root fs via NFS, trying floppy.

This is the only problem, which points back to an error on the NFS server
that is giving out the root filesystem.  I get a similar error on my
Indigo2 at home, but not on the one I have in my office.  I am planning on
upgrading my home bootp/root NFS server to see if that makes it go away.
I haven't found any details on the specific NFS errors though, so I can't
intepret it for you.

[more stuff clipped]

> My external hard drive doesn't seem to be detected (but that's okay, IRIX
> doesn't like it either).

This is on my todo list.  The SCSI driver only detects one (the internal)
controller.  This is fine and dandy on the Indy 'cause it only has one
SCSI controller.  The Indigo2 has two, so the driver needs to be modified
to detect (and access) the second one.  I plan on doing this as soon as I
get my home box up and running.

-Andrew
