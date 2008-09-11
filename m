Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2008 08:29:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:8920 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S32707675AbYIOH3r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2008 08:29:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8BBoGei012309;
	Thu, 11 Sep 2008 13:50:20 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8BBo9ji012308;
	Thu, 11 Sep 2008 13:50:09 +0200
Date:	Thu, 11 Sep 2008 13:50:09 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Jeremy Fitzhardinge <jeremy@goop.org>, Ingo Molnar <mingo@elte.hu>,
	Alex Nixon <alex.nixon@citrix.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	Jeff Dike <jdike@addtoit.com>,
	user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] Globally defining phys_addr_t
Message-ID: <20080911115009.GA6715@linux-mips.org>
References: <48C8D76B.10901@goop.org> <Pine.LNX.4.64.0809111202560.1545@anakin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0809111202560.1545@anakin>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 11, 2008 at 12:03:36PM +0200, Geert Uytterhoeven wrote:

> On Thu, 11 Sep 2008, Jeremy Fitzhardinge wrote:
> > This is a repost of a little 3-patch series which Andrew has been
> > carrying in -mm.  It cleans up the definition of phys_addr_t to make it
> > kernel-wide rather than x86-specific, and fixes up PFN_PHYS() to use it
> > to avoid address truncation.
> > 
> > We currently have a few workarounds for this problem in the tree, but
> > Alex found another bug caused by PFN_PHYS(), so it's probably better if
> > you bring these patches into tip.git for now.
> > 
> > PowerPC also defines a phys_addr_t with the same meaning as x86; the
> > powerpc arch maintainers are happy with these patches.
> 
> If I'm not mistaking, this is also true for some MIPS machines.

Jeremy probably missed it because it's called phys_t on MIPS.  It's usually
the same size as unsigned long but a few of the 32-bit Alchemy SOCs have
peripherals placed outside of the 32-bit physical address space so for
those CONFIG_64BIT_PHYS_ADDR will be defined and phys_t be unsigned long
long and used for some pagetable stuff to map those devices into the 32-bit
virtual address space.

UM uses a phys_t for its pagetables.

A single data type for everybody is enough.  phys_addr_t or phys_t I don't
care; I went for phys_t because it's shorter, less to type.

  Ralf
