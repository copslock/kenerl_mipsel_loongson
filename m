Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA113754 for <linux-archive@neteng.engr.sgi.com>; Wed, 13 May 1998 12:49:36 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA28203
	for linux-list;
	Wed, 13 May 1998 12:48:49 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA33371
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 13 May 1998 12:48:47 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id MAA19274
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 12:48:46 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id PAA16040;
	Wed, 13 May 1998 15:47:57 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 13 May 1998 15:47:57 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installer changes...
In-Reply-To: <3.0.3.32.19980514032548.00730fa8@140.114.98.21>
Message-ID: <Pine.LNX.3.95.980513154459.9017D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 14 May 1998, Francis M. J. Hsieh wrote:
> I'm sorry if this was discussed in the maillist.
> Should there be /etc dirctory after I cpio into my partition? I can't
> find /etc in my linux partition under installer prompt.

There should be a /etc in the ext2 file system after you run the
installer.  As far as I know, there is no way to read an ext2 partition
from within Irix.

But it sounds like you're having problems even booting up...

> [deleted]
> sgiseeq.c: David S. Miller (dm@engr.sgi.com)
> eth0: SGI Seeq8003 blah:blah:blah:blah
> Partition check
>    blah....
>    blah....
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 32k freed
> Warning: unable to open an initial console.
> kernel panic: No init found. Try passing init= optional to kernel.
> [halt]

Hm.  You might want to run it with 'init=/bin/sh' to skip init.

> And I use the kernel in GetingStarted directory, and got panic, too.
> ("should not happened yet")

I don't know about that.  That is Ralf's department.

- Alex
