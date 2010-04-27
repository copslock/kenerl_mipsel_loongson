Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 01:06:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57574 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492697Ab0D0XGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 01:06:00 +0200
Date:   Wed, 28 Apr 2010 00:06:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
cc:     wuzhangjin@gmail.com, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
In-Reply-To: <4BD5CB08.7010907@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.1004272354430.31578@eddie.linux-mips.org>
References: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>        <1271135034.25797.41.camel@falcon> <20100413073435.GA6371@alpha.franken.de>     <20100413171610.GA16578@linux-mips.org> <1271232185.25872.142.camel@falcon>
 <4BD5CB08.7010907@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 26 Apr 2010, David Daney wrote:

> > If using CKSEG0 as the ebase, CKSEG0 is defined as 0xffffffff80000000,
> > then we get the address: 0x97ffffff80000100, is this address ok?
> 
> I don't think so.  We should fix TO_UNCAC() so that it works with CKSEG0
> addresses.  It should be at physical address 0.  So
> TO_UNCAC(0xffffffff80000000), should yield 0x9000000000000000

 A 0xffffffff80000000 -> 0xffffffffa0000000 translation would make more 
sense IMHO.  Of course the use of XKPHYS addresses rather than CKSEG ones 
is preferable for 64-bit kernels in the first place, but then if the 
compatibility address space has been chosen for some reason (perhaps a 
virtual address stored in a structure defined by a peripheral is limited 
to 32 bits; I've seen such cases in DMA descriptor rings for example (not 
that code doing such things couldn't be converted to use cookies of some 
sort)), then I think it'll be safer to stick to the space.

  Maciej
