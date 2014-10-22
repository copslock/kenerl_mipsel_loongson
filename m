Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 21:19:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40837 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012161AbaJVTTIC5iXq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 21:19:08 +0200
Date:   Wed, 22 Oct 2014 20:19:07 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Single MIPS kernel
In-Reply-To: <20141022190515.GC12502@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1410222010280.21390@eddie.linux-mips.org>
References: <20141022083437.GB18581@linux-mips.org> <5447EFB5.4090009@gmail.com> <20141022190515.GC12502@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 22 Oct 2014, Ralf Baechle wrote:

> > Another reason is that the protocol between the bootloader and the kernel
> > varies by platform.  So you would have to have several different entry
> > points, one for each booting protocol.
> > 
> > I am not sure how the bootloaders would know which entry point to use.
> 
> That's where I foresaw the needs for the ISA style platform probe right
> at the kernel entry point before fanning out to a platform-specific
> entry point.
> 
> Since we already support compressed kernels I'm wondering if relocation
> might also be performed by the compression wrapper along with the
> hardware probe.  That would leave the vmlinux itself untouched and
> the wrapper could be installed on the target.

 Wouldn't it make sense to make a unified kernel virtually mapped?  That 
would avoid the issue with RAM being present at different locations across 
systems and also if big pages were used, that I believe are available 
almost universally across the MIPS family, any performance hit would be 
minimal.  There would be hardly any increase in the binary image size too.  
Run-time mappings such as `kmalloc' or `ioremap' could continue using 
unmapped segments.

 Thoughts?

  Maciej
