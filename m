Received:  by oss.sgi.com id <S42372AbQFVHWC>;
	Thu, 22 Jun 2000 00:22:02 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:1315 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42190AbQFVHVq>;
	Thu, 22 Jun 2000 00:21:46 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA14576
	for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 00:16:49 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id AAA23418 for <linux-mips@oss.sgi.com>; Thu, 22 Jun 2000 00:21:15 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA61388
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 22 Jun 2000 00:19:09 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: from piglet.twiddle.net (piglet.twiddle.net [207.104.6.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA01307
	for <linux@cthulhu.engr.sgi.com>; Thu, 22 Jun 2000 00:19:08 -0700 (PDT)
	mail_from (rth@piglet.twiddle.net)
Received: (from rth@localhost)
	by piglet.twiddle.net (8.9.3/8.9.3) id AAA29561;
	Thu, 22 Jun 2000 00:19:16 -0700
Date:   Thu, 22 Jun 2000 00:19:16 -0700
From:   Richard Henderson <rth@twiddle.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Linux/MIPS Development <linux@cthulhu.engr.sgi.com>
Subject: Re: Proposal: non-PC ISA bus support
Message-ID: <20000622001916.A29550@twiddle.net>
References: <20000621165744.C28857@twiddle.net> <Pine.GSO.4.10.10006220828350.27193-100000@dandelion.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.10.10006220828350.27193-100000@dandelion.sonytel.be>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jun 22, 2000 at 08:45:47AM +0200, Geert Uytterhoeven wrote:
> But with ioremap() you cannot specify where it has to be mapped, right? So
> you're still stuck with an offset.

Huh?  Who cares where it's mapped.  "Some unused space."
A pointer is a pointer.

In my case there is a direct correlation between the "base address"
and the "ioremaped address" -- the addition of a constant.  That's
the win for using 64-bit pointers.  ;-)

> > the ISA bus is contained within exactly one PCI hose.
> 
> Which is not the case on some boxes :-(

The only machines I knew about that had this were the DEC NUMA
machines.  What does your bus configuration look like?


r~
