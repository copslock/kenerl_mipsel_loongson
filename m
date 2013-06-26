Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 23:41:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49876 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831610Ab3FZVlhq2CtG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Jun 2013 23:41:37 +0200
Date:   Wed, 26 Jun 2013 22:41:37 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
In-Reply-To: <51CB3B04.1070903@imgtec.com>
Message-ID: <alpine.LFD.2.03.1306262233250.32101@linux-mips.org>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com> <20130626145234.GB7171@linux-mips.org> <gjxqcs1k6ixh0k608l2d5c4p.1372261412004@email.android.com> <20130626162302.GE7171@linux-mips.org> <nh7ue18fnbn1tbs2wsphlis9.1372265400519@email.android.com>
 <20130626175015.GH7171@linux-mips.org> <51CB3B04.1070903@imgtec.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37153
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

Ralf,

On Wed, 26 Jun 2013, Leonid Yegoshin wrote:

> > > EVA has actually INCREASE in user address space - I right now run system
> > > with 2GB phys memory and 3GB of user virtual memory address space. Work in
> > > progress is to verify that GLIBC accepts addresses above 2GB.
> > I took the 0x40000000 for a KSEG0-equivalent because you previously
> > mentioned the value of 0x80000000.
> 
> I wrote about kernel address layout. With EVA a user address layout is a
> different beast.
> In EVA, user may have access, say [0x00000000 - 0xBFFFFFFF] through TLB and
> kernel may have access, say [0x00000000 - 0xDFFFFFFF] unmapped. But segment
> shifts are applied to each KSEG.
> 
> > > Yes, it is all about increasing phys and user memory and avoiding 64bits.
> > > Many solutions dont justify 64bit chip (chip space increase, performance
> > > degradation and increase in DMA addresses for devices).
> > Fair enough - but in the end the increasing size of metadata and pagetables
> > which has to reside in lowmem will become the next bottleneck and highmem
> > I/O performance has never been great, is on most kernel developers shit list
> > and performance optimizations for highmem are getting killed whenever they
> > are getting into the way.
> 
> EVA doesn't use HIGHMEM. Kernel has a direct access to all memory in, say 3GB
> (3.5GB?).
> Malta model gives only 2GB because of PCI bridge loop problem.

 To complete the image, there is a set of new memory access instructions 
added (including but not limited to CACHE) that in the kernel mode 
separates accesses to the user space from accesses to the kernel space, 
i.e. the same virtual address can map differently depending on which 
instruction set it is used with.  I encourage you to have at least a skim 
over the most recent set of MIPS architecture manuals publicly available 
where it all is documented.

  Maciej
