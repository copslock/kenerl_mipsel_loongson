Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA22715 for <linux-archive@neteng.engr.sgi.com>; Thu, 10 Sep 1998 07:56:05 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA86778
	for linux-list;
	Thu, 10 Sep 1998 07:55:12 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA55626
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Sep 1998 07:55:11 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09112
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Sep 1998 07:55:10 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id KAA32730;
	Thu, 10 Sep 1998 10:56:37 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 10 Sep 1998 10:56:37 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: ralf@uni-koblenz.de
cc: Rob Lembree <lembree@sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Success at last...
In-Reply-To: <19980909160300.C423@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.980910105459.31995A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Wed, 9 Sep 1998 ralf@uni-koblenz.de wrote:
> This seems to indicate to me that we should replace the dev directory
> with a script that creates the inodes.  Luckily we already have one which
> is called ``MAKEDEV''.  As we already know the representation of the
> minor / major device number isn't transparent through NFS, so the MAKEDEV
> will have to detect the NFS server's OS and to corrospondingly munge the
> device number used as argument for mkdev in a way that after exporting
> from the NFS server the client sees what he expects to see.  If that is

You're 100% correct, hard coding the device on the fs is a BAD idea.
However, a reasonable way of doing it is to just put the bare devices on
the initrd, and create any additional devices you need.

I'll do this in the next installer.

- Alex
