Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA21092 for <linux-archive@neteng.engr.sgi.com>; Mon, 24 Aug 1998 03:20:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA35983
	for linux-list;
	Mon, 24 Aug 1998 03:20:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA28503
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 24 Aug 1998 03:20:02 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA15713
	for <linux@cthulhu.engr.sgi.com>; Mon, 24 Aug 1998 03:19:59 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id MAA07743;
	Mon, 24 Aug 1998 12:19:32 +0200 (MEST)
Received: by zaphod (SMI-8.6/KO-2.0)
	id MAA28887; Mon, 24 Aug 1998 12:19:30 +0200
Message-ID: <19980824121930.00186@uni-koblenz.de>
Date: Mon, 24 Aug 1998 12:19:30 +0200
From: ralf@uni-koblenz.de
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: Emacs problem
References: <19980823223647.12724@alpha.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <19980823223647.12724@alpha.franken.de>; from Thomas Bogendoerfer on Sun, Aug 23, 1998 at 10:36:47PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Aug 23, 1998 at 10:36:47PM +0200, Thomas Bogendoerfer wrote:

> I've found the cause for the emacs X11 problems. The unexec code of Emacs
> doesn't handle relocations in the .rel.dyn section, because Mips seems to
> be the only platform, which uses such section (sgi and sni, are using
> a different implementation of unexec). This mishandling leads to an emacs
> binary, which has double resolved dynamic relocations (once when dumped,
> twice when executed), which leads to a seg fault. It happens only with
> X11, because the relocations are only for X11 stuff.
> 
> I'll try to fix that, but it would be good to have some documentation about
> the .rel.dyn section, which looks a little bit different than the i386
> .rel.data section). Any pointers other than the bfd source code ?

I think you can find the related ABI documentation on www.mipsabi.org.
What details exactly are you interested in?  I've got a printed copy at
home.

  Ralf
