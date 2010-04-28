Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 17:54:46 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44049 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492572Ab0D1Pyl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Apr 2010 17:54:41 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3SFseCF022601;
        Wed, 28 Apr 2010 16:54:40 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3SFsdoA022599;
        Wed, 28 Apr 2010 16:54:39 +0100
Date:   Wed, 28 Apr 2010 16:54:39 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: use bootmem in platform code on MIPS
Message-ID: <20100428155439.GA19468@linux-mips.org>
References: <k2lf861ec6f1004270514k199cace5wafd6dd269ded8911@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k2lf861ec6f1004270514k199cace5wafd6dd269ded8911@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 27, 2010 at 02:14:32PM +0200, Manuel Lauss wrote:

> I'd like to use bootmem to reserve large chunks of RAM (at a particular physical
> address; for Au1200 MAE, CIM and framebuffer, and later Au1300 OpenGL block)
> but it seems that it can't be done:  Doing __alloc_bootmem() in
> plat_mem_setup() is
> too early, while an arch_initcall() is too late because by then the
> slab allocator is
> already up and handing out random addresses and/or refusing allocations larger
> than a few MBytes.

The maximum is actually configurable.  CONFIG_FORCE_MAX_ZONEORDER defaults
to 11 which means with 4kB pages you get 8MB maximum allocation - more for
larger pages.

CONFIG_FORCE_MAX_ZONEORDER is a tradeoff though.  A smaller value will give
slightly better performance and safe a bit of memory but I can't really
quantify these numbers - I assume it's a small difference.

It may actually be preferable to never tell the bootmem allocator about the
memory you need for these devices that is bypass the mm code entirely.

> Is there another callback I could use which would allow me to use bootmem (short
> of abusing plat_smp_setup)?
> 
> Would a separate callback like this be an acceptable solution?

Certainly better than using plat_smp_setup which would require enabling
SMP support for no good reason at all.

I know we will eventually have to add another platform hooks to run after
bootmem_init.  The name of plat_mem_setup() already shows what this hook
originally was meant for but it ended up as the everything-and-the-kitchen-
sink hook for platform-specific early initialization.  I just dislike
conditional hooks.  Let's add a call to a new hook function and fix whatever
breaks or think about what other hooks needs there should be.

  Ralf
