Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 06:59:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46854 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491125Ab0EYE7x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 May 2010 06:59:53 +0200
Date:   Tue, 25 May 2010 05:59:53 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
cc:     linux-mips <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: RE: Kernel unaligned access
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404E2D356@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
Message-ID: <alpine.LFD.2.00.1005250540160.4344@eddie.linux-mips.org>
References: <20100524173624.2d3ffc3d.yuasa@linux-mips.org> <A7DEA48C84FD0B48AAAE33F328C0201404E2D299@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca> <alpine.LFD.2.00.1005250413430.4344@eddie.linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404E2D356@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 24 May 2010, Anoop P.A. wrote:

> Thanks for your reply but unfortunately we are not in a position to
> upgrade the kernel. It will be great if you can give me some pointers to
> debug the issue.

 Well, you are on your own then.

 Pointers?  Well, first despite the confusing message it's not an 
alignment error.  The Linux kernel does not try to be particularly precise 
here and hardware does not always help either (the RM9000 isn't a MIPS64 
architecture processor, is it?).  Anyway, BadVAddr is 0x9a5d9c1483fa8a60, 
which clearly indicates this is a reference to an address outside the 
defined address space.  I don't know off the head how many physical 
address bits the RM9000 implements, but the typical number is 40 and the 
extreme one is 44.  Masking out the XKPHYS cache coherence mode and 
(optimistically) 44 address bits we are still left with 
0x025d900000000000.  These bits in the address are what the CPU complains 
about.

 Second, the address looks remarkably similar to the value in $lo, that is 
0x025d9c1482fa8a60.  Go calculate the difference!  That's probably an 
index to an array of some sort that went out of limits.

 The rest you need to figure out yourself.  It might be easier if you 
disable the unaligned access emulator altogether (#ifdef it out or 
whatever) and let the kernel throw an error straight away.  It might be 
that you're getting a nested fault.  That's what the decoded value of EPC 
being do_ade+0x1c4/0x470 actually suggests.

 Good luck!

  Maciej
