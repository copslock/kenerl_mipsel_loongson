Received:  by oss.sgi.com id <S553729AbQKOUSJ>;
	Wed, 15 Nov 2000 12:18:09 -0800
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:42712 "EHLO
        delta.ds2.pg.gda.pl") by oss.sgi.com with ESMTP id <S553682AbQKOURz>;
	Wed, 15 Nov 2000 12:17:55 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA16627;
	Wed, 15 Nov 2000 21:17:35 +0100 (MET)
Date:   Wed, 15 Nov 2000 21:17:35 +0100 (MET)
From:   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
cc:     Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com,
        Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Build failure for R3000 DECstation
In-Reply-To: <XFMail.001115204613.Harald.Koerfgen@home.ivm.de>
Message-ID: <Pine.GSO.3.96.1001115210032.5687K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, 15 Nov 2000, Harald Koerfgen wrote:

> On 15-Nov-00 Jun Sun wrote:
> [R3000 UP userland spinlocks]
> > In fact, I don't think you can perform automic operation ONLY based on
> > the knowledge whether a context switch has happened during a specified
> > period.  (It should be interesting to see if we can actually "prove"
> > it.)
> 
> I doubt this as well, although I'd love to be proven wrong.

 Well, on UP the only events that can break atomicity are exceptions (here
I treat interrupts as exceptions as well) and DMA accesses.  I don't think
we do DMA to user space, so this should not be a problem.  So if we can
detect an exception occured we may assume an operation failed and retry. 
It's not a problem for an exception handler to clobber k0 or k1 upon exit. 

 Unfortunately we cannot use this implementation in the userland or we
risk problems when running on SMP systems -- an ISA-I user binary might
very well be run on an ISA-II (or higher) SMP system.  But we can use it
in the kernel, for sysmips() and everything else.  All we have to be
careful about is not to allow DMA accesses to spinlocks.  I don't think
this is a problem in reality. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
