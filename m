Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA59775 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Jun 1998 09:09:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA34732
	for linux-list;
	Tue, 16 Jun 1998 09:08:19 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA12092
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Jun 1998 09:08:16 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id JAA16194
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Jun 1998 09:08:15 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA28860;
	Tue, 16 Jun 1998 12:07:58 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 16 Jun 1998 12:07:58 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Honza Pazdziora <adelton@informatics.muni.cz>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
In-Reply-To: <199806161546.RAA28259@aisa.fi.muni.cz>
Message-ID: <Pine.LNX.3.95.980616120211.26590B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Tue, 16 Jun 1998, Honza Pazdziora wrote:
> > 6. Last, but not least
> > Let us know if it worked!
> Great! It worked. I mean: it worked!

Wuhoo!

> Some comments out of my head:
> The /usr/sbin/timeconfig failed in the menu -- it doesn't seem to be
> present in the installfs -- shall I find and compile it?

I'll fix that right now... thanks.

> I've set up root password in the menu but it wasn't there after
> reboot -- not even /etc/passwd -- I had to boot init=/bin/bash.

Do you mean that /etc/passwd didn't exist at all?

> I had to install gcc from RH 5.0.

Yup. That's because I just forgot to put gcc in there altogether.  That'll
be fixed.

> Mkswap failed with segmantation fault -- shall I send the register
> output? I will try to compile my own, but the machine is slow without
> swap, and I need to compile ssh first to get reasonable remote access.
> Once this is done, we might be able to provide ssh*.mips.rpm, if you
> are interested.

Do you mean that mkswap segfaulted during install, or after?  I'll have a
closer look.  The util-linux we're using is a little old.

> It might be nice to put the notice about this 5.1 on the web, so that
> people are directed to the new stuff -- even this, plain text announce
> and instructions would be nice.

Definitely.  I will do that, although I welcome any help with documenting
this.

We actually already have ssh on ftp.replay.com, IIRC.  I'm in the US
(sigh...) so I can't export it.

If you were interested, you could have a look at getting a util-linux RPM
up to version 2.8.  util-linux is a gross thing.

- Alex
