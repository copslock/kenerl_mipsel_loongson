Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id WAA50611 for <linux-archive@neteng.engr.sgi.com>; Mon, 28 Sep 1998 22:25:35 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id WAA03130
	for linux-list;
	Mon, 28 Sep 1998 22:24:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id WAA45975
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 28 Sep 1998 22:24:54 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id WAA03552
	for <linux@cthulhu.engr.sgi.com>; Mon, 28 Sep 1998 22:24:53 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id BAA03361;
	Tue, 29 Sep 1998 01:29:33 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Tue, 29 Sep 1998 01:29:33 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Mike Hill <mikehill@hgeng.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Still Installing
In-Reply-To: <60222E63C9F4D011915F00A02435011C27B96E@BART>
Message-ID: <Pine.LNX.3.96.980928233516.30320D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, 28 Sep 1998, Mike Hill wrote:
> Many thanks to Alex deVries for the on-site service call and the loan of
> his hard drive to prove that SGI/Linux will boot on my hardware
> (R4600PC, 32 M RAM, 8-bit graphics).  It was quite a thrill to see the

Please note that such service is available provided you can supply
transportation and dinner :)

> login prompt for the first time.  At the same time Alex was treated
> first hand to some bizarre SGI/Linux behaviour that he's only been able
> to read about until now.

Okay, there are definite differences among Indy's.  I thought they wer
pretty much all the same.  There are two big differences between ours:

- 32 MB appears somehow just not to be enough to operate well.  I don't
know where the memory is actuall ygoing, though.

- There must be two different screen resolutions, since the *exact* same
binaries that displayed beautifully on mine were chopped off on Mike's.
Is ther emore than one version of the newport?

> signal 11.  Instead of partitioning the drive with fx or from within the
> installer, I reran the Linux-installer 0.2 procedure.  After that, the
> Hard Hat installer continued into the package installation.  Many
> packages (including bash) failed to install with the "script execution
> failure" message.  This was also reported by Alexander Ehlert.  The
> installer finished and I had a login prompt, but I couldn't log in.
> I'll download the testinstall-tree and continue with Alexander's
> strategy.

Okay.  So there's a partitioning issue.  I think we knew that.

The script execution thing is, i think, just because the CD you have isn't
quite the latest one.

> Kernel notes:  I also get the truncated screen reported by Jan Chadima
> (and Leon Verrall?); it seems like at least ten lines scrolling out of
> view.  When I can compile a kernel I'll try reducing the screen size in
> bootinfo.h.

This is strange.  This means that different newport graphics cards have
different sizes.


- Alex
