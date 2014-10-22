Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 22:42:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41219 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012171AbaJVUmKhGcQJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 22:42:10 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s9MKg9CG017586;
        Wed, 22 Oct 2014 22:42:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s9MKg9G6017585;
        Wed, 22 Oct 2014 22:42:09 +0200
Date:   Wed, 22 Oct 2014 22:42:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
Message-ID: <20141022204209.GE12502@linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org>
 <5447EFB5.4090009@gmail.com>
 <20141022190515.GC12502@linux-mips.org>
 <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Oct 22, 2014 at 08:19:07PM +0100, Maciej W. Rozycki wrote:

> > > Another reason is that the protocol between the bootloader and the kernel
> > > varies by platform.  So you would have to have several different entry
> > > points, one for each booting protocol.
> > > 
> > > I am not sure how the bootloaders would know which entry point to use.
> > 
> > That's where I foresaw the needs for the ISA style platform probe right
> > at the kernel entry point before fanning out to a platform-specific
> > entry point.
> > 
> > Since we already support compressed kernels I'm wondering if relocation
> > might also be performed by the compression wrapper along with the
> > hardware probe.  That would leave the vmlinux itself untouched and
> > the wrapper could be installed on the target.
> 
>  Wouldn't it make sense to make a unified kernel virtually mapped?  That 
> would avoid the issue with RAM being present at different locations across 
> systems and also if big pages were used, that I believe are available 
> almost universally across the MIPS family, any performance hit would be 
> minimal.  There would be hardly any increase in the binary image size too.  
> Run-time mappings such as `kmalloc' or `ioremap' could continue using 
> unmapped segments.

I think some MIPS III CPUs were restricted to just 4MB max. page size.
NEC VR4xxx I think.  Still a pair would map 8MB which on the affected
small memory systems should suffice.  16MB, 64MB are more typical sizes.

R3000 is a different kettle.  To 4k or not to 4k is not a question ;-)

Now mapping the kernel alone wouldn't solve the security issue mentioned
by David.  The image would still lie around in KSEG0 / XKPHYS for whatever
wants to run over so that should ideally also be a flexible address.

Otoh the mapped kernel certainly would have the lowest size overhead.
I have faint memories of restrictions for TLB instructions or was it
TLB exception handlers into mapped space, would have to do some rtfming
on that topic.

Years ago I did test the impact of one less available TLB entry with
lmbench; the loss was around 2%.  That was on a CPU with 64 entries.

  Ralf
