Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2016 22:01:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2801 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013234AbcCDVBLcpiFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Mar 2016 22:01:11 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 413151079C137;
        Fri,  4 Mar 2016 21:01:01 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar
 2016 21:01:04 +0000
Received: from [10.20.3.92] (10.20.3.92) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 4 Mar 2016
 13:01:02 -0800
Message-ID: <56D9F78E.6090303@imgtec.com>
Date:   Fri, 4 Mar 2016 13:01:02 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars Persson <lars.persson@axis.com>,
        "stable # v4 . 1+" <stable@vger.kernel.org>, "Steven J. Hill"
        <Steven.Hill@imgtec.com>, David Daney <david.daney@cavium.com>, Huacai Chen
        <chenhc@lemote.com>, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Jerome Marchand <jmarchan@redhat.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [4/4] MIPS: Sync icache & dcache in set_pte_at
References: <1456799879-14711-5-git-send-email-paul.burton@imgtec.com> <56D7A987.5040602@imgtec.com> <20160304103714.GA5576@NP-P-BURTON>
In-Reply-To: <20160304103714.GA5576@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.92]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52455
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

Paul,

On 03/04/2016 02:37 AM, Paul Burton wrote:
> The problem is that there are other code paths which dirty pages (ie.
> call flush_dcache_page), then get as far as set_pte_at *without* calling
> flush_icache_page.

There is no problem with lazy flush of D-cache and PTE update. D-cache 
works in PHYSICAL ADDRESSes and is independent from that is set in PTE 
and TLB. You can even don't flush D-cache during page-fault, keep stuff 
in D-cache and switch any PTE/TLB in any CPU - anything is coherent... 
if we forget for a moment about cache aliasing, non-coherent I-cache and 
DMA.

Cache aliasing is not compatible with SMP (until some public inter-L1 
protocol is changed to accommodate virtual address).

I-cache incoherency is taken into account in flush_icache_page(), 
including a completion of lazy D-cache flush at that point.

DMA ... well it is a complicated issue now but a simplest rule - 
complete all flush before/after DMA and it is done in 
dma_cache_wback_inv/dma_cache_inv (but I intentionally put out of issue 
the speculative access which complicates an issue).

So, you fight a wrong enemy.


>   Again - I included call traces from 2 paths that hit
> this right in the commit message.
>
> So:
>
>    - flush_icache_page isn't always called before we *need* to writeback
>      the page from the dcache. This is demonstrably the case (again, see
>      the commit message), and causes bugs when using UBIFS on boards
>      using the pistachio SoC at least.

You didn't prove that it is because of your model. You referenced to 
flush_icache_page absence in different places but that places don't 
prepare a code page:

     - forking process actually doesn't copy any page but set it 
temporary non-writable, actual copy is done in page fault
     - load_elf_binary doesn't load any code pages and again leaves that 
process to page fault.

>
>    - flush_icache_page is indicated as something that should go away in
>      Documentation/cachetlb.txt. Why do you feel we should make use of
>      it?

I think it is a wrong mark in doc.

I suspect that your problem with UBIFS is because any DMA-ed code page 
should be flushed from DCache during page fault in flush_icache_page. 
Current master branch code does it only if it is "dirty" but I suspect 
that UBIFS may not do it in some place (doesn't mark it as 
"dirty-by-kernel"). Besides that non-DMA-ed pages can be written by 
device driver which has no access to that bit. For this reason in my 
3.10 branch there is a kernel boot parameter option "mips_non_DMA_FS" 
which enforces D-cache flush regardless it is dirty or not.

I again call you to look into 
https://git.linux-mips.org/cgit/yegoshin/mips.git, branch 
android-linux-mti-3.10 to understand that stuff.

- Leonid.
