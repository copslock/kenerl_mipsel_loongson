Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA351332 for <linux-archive@neteng.engr.sgi.com>; Thu, 14 May 1998 08:14:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA72084
	for linux-list;
	Thu, 14 May 1998 08:13:49 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA80898
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 14 May 1998 08:13:47 -0700 (PDT)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id IAA04709
	for <linux@cthulhu.engr.sgi.com>; Thu, 14 May 1998 08:13:46 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id LAA13555;
	Thu, 14 May 1998 11:13:41 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 14 May 1998 11:13:41 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alistair Lambie <alambie@wellington.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Installer changes...
In-Reply-To: <355AD84E.F197D39E@wellington.sgi.com>
Message-ID: <Pine.LNX.3.95.980514111211.11757A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Thu, 14 May 1998, Alistair Lambie wrote:
> It stops right at the file /dev/need_disks_created.  There are a bunch
> of errors before this.  The /dev/need_disks_created file does not seem
> to get written to disk correctly....the e2fsck cleans it up by the looks
> of things.  I guess there is something about the cpio that the installer
> doesn't like.

Wow.  I really messed it up badly somehow.

I suspect it's having a problem writing a file that's 0 bytes long.  Let
me repackage it, and make the file 1 byte.

As we speak, I'm debugging the initrd stuff in the kernel to sort out why
initial ramdisks don't get loaded.

- Alex
