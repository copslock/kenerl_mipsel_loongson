Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 23:14:29 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:41997 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225201AbUJNWOX>; Thu, 14 Oct 2004 23:14:23 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EF3BDF59BD; Fri, 15 Oct 2004 00:14:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04017-01; Fri, 15 Oct 2004 00:14:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9B6BEF59B9; Fri, 15 Oct 2004 00:14:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9EMESfH016897;
	Fri, 15 Oct 2004 00:14:29 +0200
Date: Thu, 14 Oct 2004 23:14:15 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Manish Lachwani <mlachwani@mvista.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
In-Reply-To: <20041014191754.GB30516@linux-mips.org>
Message-ID: <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Oct 2004, Ralf Baechle wrote:

> > This small patch is required to get PCI working on the Broadcom SWARM 
> > board in 2.6. Without this patch, the PCI bus scan is skipped due to 
> > resource conflict. Tested using the E100 network card
> 
> > -       ioport_resource.end = 0x0000ffff;       /* 32MB reserved by 
> > sb1250 */
> > +       ioport_resource.end = 0xffffffff;       /* 32MB reserved by 
> > sb1250 */
> 
> I'm too lazy to dig up the actual numbers from the BCM1250 manuals but
> it definately does not have 4GB of port address space.

 The doc states low 25 bits are used for I/O addressing, matching the
comment above (surprise!, surprise!), so I guess the constant sought for
the bit mask above is 0x01ffffff.  If that turns out to work, I can apply
an update (can I, Ralf?).

  Maciej
