Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Oct 2013 14:54:26 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42896 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867713Ab3JAMyXvnBOu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Oct 2013 14:54:23 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r91CsLus013196;
        Tue, 1 Oct 2013 14:54:21 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r91CsLcc013195;
        Tue, 1 Oct 2013 14:54:21 +0200
Date:   Tue, 1 Oct 2013 14:54:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: Re: 74K/1074K support
Message-ID: <20131001125420.GA12616@linux-mips.org>
References: <20130925052715.GB473@linux-mips.org>
 <5249ED1E.4050106@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5249ED1E.4050106@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38083
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

On Mon, Sep 30, 2013 at 02:29:02PM -0700, Leonid Yegoshin wrote:

> On 09/24/2013 10:27 PM, Ralf Baechle wrote:
> >Commit 006a851b10a395955c153a145ad8241494d43688 adds 74K support in c-r4k.c:
> >
> >+static inline void alias_74k_erratum(struct cpuinfo_mips *c)
> >+{
> >+       /*
> >+        * Early versions of the 74K do not update the cache tags on a
> >+        * vtag miss/ptag hit which can occur in the case of KSEG0/KUSEG
> >+        * aliases. In this case it is better to treat the cache as always
> >+        * having aliases.
> >+        */
> >+       if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> >+               c->dcache.flags |= MIPS_CACHE_VTAG;
> >+       if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> >+               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> >+       if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
> >+           ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {
> >+               c->dcache.flags |= MIPS_CACHE_VTAG;
> >+               write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> >+       }
> >+}
> >
> >But MIPS D-caches are never virtually tagged, so there is nothing in
> >the kernel that ever tests the MIPS_CACHE_VTAG flag in a D-cache
> >descriptor.
> >
> >Cargo cult programming at its finest?  Or was MIPS_CACHE_ALIASES what
> >really was meant to be set?
> >
> >   Ralf
> 
> There is a problem on early versions of 74K/1074K which can be effectively cured by setting MIPS_CACHE_VTAG.
> It enforces the needed cache handling.
> I hope it will go away as customers replace RTL for newer versions.
> But I prefer the patch version from Maciej W. Rozycki, it is more clear.

There is nothing in the kernel that _reads_ that flag if it's set in an
I-cache descriptor.  See:

arch/mips/include/asm/cpu-features.h:#define cpu_has_vtag_icache        (cpu_data[0].icache.flags & MIPS_CACHE_VTAG)
arch/mips/include/asm/cpu-info.h:#define MIPS_CACHE_VTAG                0x00000002      /* Virtually tagged cache */
arch/mips/mm/c-octeon.c:                c->icache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-octeon.c:                c->icache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-octeon.c:                c->icache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-r4k.c:                   c->dcache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-r4k.c:                   c->dcache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-r4k.c:                   c->icache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-r4k.c:           c->icache.flags |= MIPS_CACHE_VTAG;
arch/mips/mm/c-r4k.c:          c->icache.flags & MIPS_CACHE_VTAG ? "VIVT" : "VIPT",

There simply is not support whatsoever for virtually tagged D-caches in
the kernel, so setting that flag may feel good - but achieves nothing.
See, the sole test for the MIPS_CACHE_VTAG above tests it in a D-cache
descriptor.  So I'm not sure what the intention is.  Maybe there is some
code that has not yet been merged?

  Ralf
