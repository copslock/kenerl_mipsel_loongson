Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 21:18:06 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:30473 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224894AbUJRUR5>; Mon, 18 Oct 2004 21:17:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 181BBF5964; Mon, 18 Oct 2004 22:17:39 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12882-04; Mon, 18 Oct 2004 22:17:38 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B8001E1CAC; Mon, 18 Oct 2004 22:17:38 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9IKHsX8020949;
	Mon, 18 Oct 2004 22:17:55 +0200
Date: Mon, 18 Oct 2004 21:17:43 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH]PCI on SWARM
In-Reply-To: <yq0zn2ks9em.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.58L.0410182042010.12159@blysk.ds.pg.gda.pl>
References: <416DE31E.90509@mvista.com> <20041014191754.GB30516@linux-mips.org>
 <Pine.LNX.4.58L.0410142305380.25607@blysk.ds.pg.gda.pl> <416EFBAB.8050600@mvista.com>
 <Pine.LNX.4.58L.0410142327530.25607@blysk.ds.pg.gda.pl>
 <20041014225553.GA13597@linux-mips.org> <Pine.LNX.4.58L.0410150311370.25607@blysk.ds.pg.gda.pl>
 <yq0zn2ks9em.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2004, Jes Sorensen wrote:

> Maciej>  Tough.  Both the PCI memory and the PCI I/O spaces are mapped
> Maciej> in several areas, depending on the byte lane swapping policy
> Maciej> needed and whether 64-bit addressing is feasible or not.  We'd
> Maciej> need two areas for I/O and four for memory (plus another one
> Maciej> for the 40-bit HT address space).
> 
> Dual address cycles, ie. 64 bit addressing is fscked on the 1250 from
> what I remember. Correct way to work around this is to stick all
> physical memory outside the 32 bit space into ZONE_HIGHMEM - had a
> patch for 2.4, but I lost it ages ago ;-(

 The BCM1250A's PCI is obviously 32-bit only (the host bridge is
explicitly documented not to support DACs), but you need to use 64-bit
addressing to access the whole 4GB range -- the bus is decoded starting
from 0xf800000000 and 0xf900000000, with a different byte lane swapping
policy for each of these areas.  For limited access for 32-bit software,
you can use alternate mappings at 0x40000000 and 0x60000000, but they
provide only 512MB of space each.

 I don't think something like DACs exists for HT.

  Maciej
