Received:  by oss.sgi.com id <S305166AbPLFWZr>;
	Mon, 6 Dec 1999 14:25:47 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:27917 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbPLFWZb>;
	Mon, 6 Dec 1999 14:25:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08152; Mon, 6 Dec 1999 14:32:30 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA15927
	for linux-list;
	Mon, 6 Dec 1999 14:17:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA41959
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 14:17:22 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA03103
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 13:14:38 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFVNv>;
	Mon, 6 Dec 1999 19:13:51 -0200
Date:   Mon, 6 Dec 1999 19:13:51 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Kernel Semaphores
Message-ID: <19991206191351.R765@uni-koblenz.de>
References: <012901bf4029$2e465020$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <012901bf4029$2e465020$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 09:33:38PM +0100, Kevin D. Kissell wrote:

> >> To make it work on 32-bit CPUs, I looked at using
> >> the x386 model, but that one uses interrupt disables
> >> and is intrinsically SMP-unsafe.
> >
> >semaphore-helper.h uses spin_lock_irqsave which is smp-safe.  The way
> >we do things for 64-bit MIPS is just more performant.
> 
> spin_lock_irqsave() in 2.2.12 for MIPS is just a save_and_cli().
> The MIPS spin_lock macros all collapse the lock into nothingness.

Spinlocks are SMP safe; it's just the MIPS implementation which doesn't
get this right so far.

  Ralf
