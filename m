Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA62802 for <linux-archive@neteng.engr.sgi.com>; Sun, 31 Jan 1999 18:38:24 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA11710
	for linux-list;
	Sun, 31 Jan 1999 18:35:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA11356
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 31 Jan 1999 18:35:39 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA02856
	for <linux@cthulhu.engr.sgi.com>; Sun, 31 Jan 1999 18:35:37 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA19591;
	Sun, 31 Jan 1999 21:37:38 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 31 Jan 1999 21:37:38 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Eric Melville <m_thrope@rigelfore.com>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: sgi linux
In-Reply-To: <36B3CB6B.9B112140@rigelfore.com>
Message-ID: <Pine.LNX.3.96.990131213407.28403D-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I'm cc'ing this to the SGI mailing list.  Eric, you should get yourself on
it.

On Sat, 30 Jan 1999, Eric Melville wrote:
L> hi, i'm following your instructions for linux on an indy... to the
> extent of my knowledge, bootp/tftp/nfs are all working fine... so next
> comes time to boot the sucker. i enter "boot bootp():/vmlinux", and it
> fires up the kernel, claims to mount root fs via nfs, but then it
> stops... it says something like:
> 
> Warning: cannot open initial console
> Kernel panic: try passing "init=" to the kernel

This is one of two things:

- your filesystem isn't exported properly from whatever nefs server you
have, in which case you need to veryify that /dev/console (at least) is
exported properly.

- you're trying to use a serial console, which is currently unsupported.

- Alex
