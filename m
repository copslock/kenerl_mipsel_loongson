Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA37406 for <linux-archive@neteng.engr.sgi.com>; Fri, 12 Jun 1998 20:56:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA38629
	for linux-list;
	Fri, 12 Jun 1998 20:55:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA49771
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 12 Jun 1998 20:55:27 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id UAA06479
	for <linux@cthulhu.engr.sgi.com>; Fri, 12 Jun 1998 20:55:25 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id XAA04345;
	Fri, 12 Jun 1998 23:55:20 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 12 Jun 1998 23:55:20 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: SGI Linux <linux@cthulhu.engr.sgi.com>
cc: ewt@redhat.com
Subject: Very good news with the installer.
Message-ID: <Pine.LNX.3.95.980612233819.12021N-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Perhaps some of you will think: "pfft, it's just an installation tool, and
it is just packaging", but...

The Red Hat installer now works for SGI/Linux.  I'm not saying things are
perfect, but I have gotten the following to work:
- a proper kernel
- a proper root file system that'll work over NFS
- a working init
- a working install
- a working install2
- about 390 binary packages that appear to work

I have taken a new Irix-partitioned drive, booted via bootp/tftp/root nfs
from my i386 linux box, and installed all the RPMs, and gotten the basics
on there.  

A conservative estimate is that this is a 1,000 times better improvement
over the previous system, which was totally horrible.

Now, stuff that is definitely broken in this installation:

- Some of the packages need to be rebuilt because of issues with them
being labelled 'mips' instead of 'mipseb'.  This is good for another
thread.  glibc is the big one, and I'll try to build it over night. 

- There's no fdisk or partitioning working.  You know who you are.  Cough
up the fdisk code, we need it!

- There's no X, yet.

- Some packages do not yet compile or have not yet been packaged or
ported.  The big ones are:
    - XFree86 (shaver's working on this)
    - gnome (this should be possible, just takes more determination)
    - egcs (Ralf's working on packaging it)
    - a lot of little ones like ImageMagick, ppp, ncpfs, sliplogin...

I'm reasonably confident that all these will make it given a bit of time.
A lot of them are trivial to package.

I'm not going to release the whole thing until after I get glibc packaged
properly.  With luck, the whole thing will be packaged by tomorrow
morning.  I was having connection problems to ftp.linux.sgi.com earlier
today, so hopefully I will be able to upload sometime tomorrow (Saturday).
The total distribution is around 250MB.

I am really happy with this.  6 months of pretty hard work (especially
since January) are actually producing something useful.  We've all done
very well.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .
