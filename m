Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA87464 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 17:28:53 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA79014
	for linux-list;
	Wed, 17 Jun 1998 17:28:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA46897
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 17:28:19 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id RAA06160
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Jun 1998 17:28:18 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id UAA23017;
	Wed, 17 Jun 1998 20:28:12 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 17 Jun 1998 20:28:12 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Tomi.Leppikangas@oulu.fi
cc: linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
In-Reply-To: <199806162025.XAA28706@ousrvr2.oulu.fi>
Message-ID: <Pine.LNX.3.95.980617202634.8736N-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Tue, 16 Jun 1998, Tomi Leppikangas wrote:
> I tryed to install that new 5.1 redhad tonight, but installation
> stops when selecting partitions, i cant make swap partition,
> and installation wont continue without any swap.
> I partitioned second disk in irix, and in boot linux finds it,
> but both partitions are 'linux native', i cant change them to
> 'linux swap' becouse fdisk segfaults in installation. Should that
> fdisk work? Could that segfault be becouse i have two disks, one 
> id=0 and second id=3.

As mentioned in the isntructions, all the partitioning needs to be done
from Irix.  Yes, we're working on this.

> Any way to install it without swap? Or how to force sdb2
> to be swap partition?

There's a dialog box that asks you if you want to use swap; just say no.
There's swap problems right now.

> In that announcment posting there was 'copy all files from...',
> i just copied "installfs.tgz" and untar it, is all files in that?

Yup.

- Alex
