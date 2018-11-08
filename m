Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Nov 2018 17:54:13 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:55432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991062AbeKHQwTPbR-Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Nov 2018 17:52:19 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6A50FAFF4;
        Thu,  8 Nov 2018 16:52:18 +0000 (UTC)
Date:   Thu, 8 Nov 2018 17:52:17 +0100
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, rppt@linux.vnet.ibm.com
Subject: Re: [[PATCH]] mips: Fix switch to NO_BOOTMEM for SGI-IP27/loongons3
 NUMA
Message-Id: <20181108175217.f55065d6115edbafd6aa3487@suse.de>
In-Reply-To: <20181108161823.GB15707@rapoport-lnx>
References: <20181108144428.28149-1-tbogendoerfer@suse.de>
        <20181108161823.GB15707@rapoport-lnx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

On Thu, 8 Nov 2018 18:18:23 +0200
Mike Rapoport <rppt@linux.ibm.com> wrote:

> On Thu, Nov 08, 2018 at 03:44:28PM +0100, Thomas Bogendoerfer wrote:
> > Commit bcec54bf3118 ("mips: switch to NO_BOOTMEM") broke SGI-IP27
> > and NUMA enabled loongson3 by doing memblock_set_current_limit()
> > before max_low_pfn has been evaluated. Both platforms need to do the
> > memblock_set_current_limit() in platform specific code. For
> > consistency the call to memblock_set_current_limit() is moved
> > to the common bootmem_init(), where max_low_pfn is calculated
> > for non NUMA enabled platforms.
> [..]
> 
> As for SGI-IP27, the initialization of max_low_pfn as late as in
> paging_init() seems to be broken because it's value is used in
> arch_mem_init() and in finalize_initrd() anyway.

well, the patch is tested on real hardware and the first caller of
a memblock_alloc* function is in a function called by free_area_init_nodes().

> AFAIU, both platforms set max_low_pfn to last available pfn, so it seems we
> can simply do
> 
> 	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM())
> 
> in the prom_meminit() function for both platforms and drop the loop
> evaluating max_low_pfn in paging_init().

sounds like a better plan. I'll prepare a new patch.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
