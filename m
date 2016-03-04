Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 16:20:39 +0100 (CET)
Received: from bastet.se.axis.com ([195.60.68.11]:47909 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008251AbcCDPUgIv0yU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 16:20:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 56F2518091;
        Fri,  4 Mar 2016 16:20:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id If71zMCsi7dS; Fri,  4 Mar 2016 16:20:29 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
        by bastet.se.axis.com (Postfix) with ESMTP id B28F618093;
        Fri,  4 Mar 2016 16:20:28 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 6FD32153C;
        Fri,  4 Mar 2016 16:20:28 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
        by boulder.se.axis.com (Postfix) with ESMTP id 6355B1185;
        Fri,  4 Mar 2016 16:20:28 +0100 (CET)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
        by seth.se.axis.com (Postfix) with ESMTP id 5F9271046;
        Fri,  4 Mar 2016 16:20:28 +0100 (CET)
Received: from XBOX02.axis.com (10.0.5.16) by XBOX03.axis.com (10.0.5.17) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Fri, 4 Mar 2016 16:20:28 +0100
Received: from XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776]) by
 XBOX02.axis.com ([fe80::50c3:4d2f:4507:7776%22]) with mapi id 15.00.1156.000;
 Fri, 4 Mar 2016 16:20:28 +0100
From:   Lars Persson <lars.persson@axis.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, "linux-mips@linux-mips.org"
        <linux-mips@linux-mips.org>, "stable # v4 . 1+" <stable@vger.kernel.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>, David Daney
        <david.daney@cavium.com>, Huacai Chen <chenhc@lemote.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org"
        <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4/4] MIPS: Sync icache & dcache in set_pte_at
Thread-Topic: [4/4] MIPS: Sync icache & dcache in set_pte_at
Thread-Index: AQHRdPlKWDfurXGSZkq534vFAgyFKZ9JCOsAgABf5gU=
Date:   Fri, 4 Mar 2016 15:20:28 +0000
Message-ID: <795CB2CE-0D93-46EF-9CCF-5E7DC1B43FB0@axis.com>
References: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
 <56D7A987.5040602@imgtec.com>,<20160304103714.GA5576@NP-P-BURTON>
In-Reply-To: <20160304103714.GA5576@NP-P-BURTON>
Accept-Language: en-US
Content-Language: sv-SE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <lars.persson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52449
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars.persson@axis.com
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

Hi Paul

I tested your patch set and compared with our in house tree:

Indeed the vanilla kernel cache handling + the first three patches from your set fails booting from UBIFS. Applying the fourth patch resolves the problem.

Now consider this. Our tree runs with Steven J. Hill's original patch set that fixed HIGHMEM for non-DMA block devices and we can boot ok with UBIFS. The cache flushing happens inside flush_icache_page as on the vanilla kernel.

I would suggest that you take a close look on Steven's old patch set and figure out what he did different. You will hopefully find that we can avoid flushing inside set_pte_at.

BR
 Lars

> 4 mars 2016 kl. 11:37 skrev Paul Burton <paul.burton@imgtec.com>:
> 
> Hi Leonid,
> 
>> On Wed, Mar 02, 2016 at 07:03:35PM -0800, Leonid Yegoshin wrote:
>> Paul Burton wrote:
>>> It is, however, used in such a way by others & seems to me like the only
>>> correct way to implement the lazy cache flushing. The alternative would
>>> be to adjust all generic code to ensure flush_icache_page gets called
>>> before set_pte_at
>> 
>> ... which is an exact case right now.
> 
> No, it isn't. I included call traces for 2 cases where this is not the
> case right in the commit message.
> 
>> Both calls of flush_icache_page() are:
>> 
>> 1) do_swap_page()
>> 
>>        flush_icache_page(vma, page);
>>        if (pte_swp_soft_dirty(orig_pte))
>>                pte = pte_mksoft_dirty(pte);
>>        set_pte_at(mm, address, page_table, pte);
>> ...
>> 
>> 2) do_set_pte()
>> 
>>        flush_icache_page(vma, page);
>>        entry = mk_pte(page, vma->vm_page_prot);
>>        if (write)
>>                entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>>        if (anon) {
>>                inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>>                page_add_new_anon_rmap(page, vma, address);
>>        } else {
>>                inc_mm_counter_fast(vma->vm_mm, MM_FILEPAGES);
>>                page_add_file_rmap(page);
>>        }
>>        set_pte_at(vma->vm_mm, address, pte, entry);
>> 
>>        /* no need to invalidate: a not-present page won't be cached */
>>        update_mmu_cache(vma, address, pte);
>> ....
>> 
>> You should only be sure that flush_icache_page() completes a lazy D-cache
>> flush.
>> 
>> - Leonid.
> 
> Well of course that's fine in those 2 cases. Of course both callers of
> flush_icache_page call flush_icache_page - that's a meaningless
> tautology. You're grepping for the wrong thing.
> 
> The problem is that there are other code paths which dirty pages (ie.
> call flush_dcache_page), then get as far as set_pte_at *without* calling
> flush_icache_page. Again - I included call traces from 2 paths that hit
> this right in the commit message.
> 
> So:
> 
>  - flush_icache_page isn't always called before we *need* to writeback
>    the page from the dcache. This is demonstrably the case (again, see
>    the commit message), and causes bugs when using UBIFS on boards
>    using the pistachio SoC at least.
> 
>  - flush_icache_page is indicated as something that should go away in
>    Documentation/cachetlb.txt. Why do you feel we should make use of
>    it?
> 
>  - Other architectures (at least arm, ia64 & powerpc which may not be
>    an exhaustive list) handle this in set_pte_at too. Doing it in the
>    same way can only be good for consistency.
> 
> So flush_icache_page is insufficient, apparently disliked & not the way
> any other architectures solve the exact same problem (again, because it
> does *not* cover all cases).
> 
> Thanks,
>    Paul
