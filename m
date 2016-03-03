Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2016 04:03:45 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37330 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013049AbcCCDDogQhoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2016 04:03:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 002A811F74392;
        Thu,  3 Mar 2016 03:03:37 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 3 Mar
 2016 03:03:38 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Wed, 2 Mar 2016
 19:03:36 -0800
Message-ID: <56D7A987.5040602@imgtec.com>
Date:   Wed, 2 Mar 2016 19:03:35 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Lars Persson <lars.persson@axis.com>,
        "stable # v4 . 1+" <stable@vger.kernel.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "David Daney" <david.daney@cavium.com>,
        Huacai Chen <chenhc@lemote.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4/4] MIPS: Sync icache & dcache in set_pte_at
References: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Paul Burton wrote:

> It is, however, used in such a way by others & seems to me like the only
> correct way to implement the lazy cache flushing. The alternative would
> be to adjust all generic code to ensure flush_icache_page gets called
> before set_pte_at

... which is an exact case right now. Both calls of flush_icache_page() are:

1) do_swap_page()

         flush_icache_page(vma, page);
         if (pte_swp_soft_dirty(orig_pte))
                 pte = pte_mksoft_dirty(pte);
         set_pte_at(mm, address, page_table, pte);
...

2) do_set_pte()

         flush_icache_page(vma, page);
         entry = mk_pte(page, vma->vm_page_prot);
         if (write)
                 entry = maybe_mkwrite(pte_mkdirty(entry), vma);
         if (anon) {
                 inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
                 page_add_new_anon_rmap(page, vma, address);
         } else {
                 inc_mm_counter_fast(vma->vm_mm, MM_FILEPAGES);
                 page_add_file_rmap(page);
         }
         set_pte_at(vma->vm_mm, address, pte, entry);

         /* no need to invalidate: a not-present page won't be cached */
         update_mmu_cache(vma, address, pte);
....

You should only be sure that flush_icache_page() completes a lazy 
D-cache flush.

- Leonid.
