Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA121350 for <linux-archive@neteng.engr.sgi.com>; Wed, 13 May 1998 13:40:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA29788
	for linux-list;
	Wed, 13 May 1998 13:37:45 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA52786
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 13 May 1998 13:37:43 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id NAA09928
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 13:37:38 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-05.uni-koblenz.de [141.26.249.5])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id WAA14718
	for <linux@cthulhu.engr.sgi.com>; Wed, 13 May 1998 22:37:32 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id WAA00682;
	Wed, 13 May 1998 22:37:25 +0200
Message-ID: <19980513223725.33155@uni-koblenz.de>
Date: Wed, 13 May 1998 22:37:25 +0200
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
Cc: Alex deVries <adevries@engsoc.carleton.ca>, linux@cthulhu.engr.sgi.com
Subject: Re: Installer changes...
References: <Pine.LNX.3.95.980513003341.15722A-100000@lager.engsoc.carl eton.ca> <3.0.3.32.19980514032548.00730fa8@140.114.98.21>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <3.0.3.32.19980514032548.00730fa8@140.114.98.21>; from Francis M. J. Hsieh on Thu, May 14, 1998 at 03:25:48AM +0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, May 14, 1998 at 03:25:48AM +0800, Francis M. J. Hsieh wrote:

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

Alex already said it, try adding init=/bin/sh to the boot options.

> And I use the kernel in GetingStarted directory, and got panic, too.
> ("should not happened yet")

That was a real bug.  The kernel in GettinStarted in truely ancient.  I
replaced it by vmlinux-2.1.99.

  Ralf
