Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA55009 for <linux-archive@neteng.engr.sgi.com>; Sun, 12 Jul 1998 03:13:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA12519
	for linux-list;
	Sun, 12 Jul 1998 03:13:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA55020
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 12 Jul 1998 03:13:01 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de ([141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA28601
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 02:16:57 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-02.uni-koblenz.de [141.26.249.2])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id KAA02767
	for <linux@cthulhu.engr.sgi.com>; Sun, 12 Jul 1998 10:48:06 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id KAA17158;
	Sun, 12 Jul 1998 10:44:55 +0200
Message-ID: <19980712104454.Q10756@uni-koblenz.de>
Date: Sun, 12 Jul 1998 10:44:54 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: volume header fs...
References: <Pine.LNX.3.95.980711182315.8181A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980711182315.8181A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Sat, Jul 11, 1998 at 06:24:09PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 11, 1998 at 06:24:09PM -0400, Alex deVries wrote:

> What is on a volume header file system?  Is it EFS or something else?

The ``MIPS disk volume header'' used by IRIX machines provides only a
very simple filesystem.  Names are limited to 8 characters, files cannot
be fragmented etc.  The later property implies makes it somewhat tricky to
implement a writeable filesystem for this volumeheader.

> I was thinking about writing such a driver so we could easily put Linux
> kernels there. 

Better write tools analog to dvhtool and fx that can be operated from
command line.  They're easier to implement.

The actual boot loader best goes into something like sash that is small,
resides in the volume header knows how to read ext2 or whatever filesystems.
Libext2 is your friend.

Which reminds me, the SGI people have been discussing long time ago whether
to contribute SGI's sash sources such that writing a Linux sash would be
easier.  Has this discussion ever come to an actual conclusion and if so,
what?

  Ralf
