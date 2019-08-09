Return-Path: <SRS0=CBkT=WF=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E4CC433FF
	for <linux-mips@archiver.kernel.org>; Fri,  9 Aug 2019 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372B82171F
	for <linux-mips@archiver.kernel.org>; Fri,  9 Aug 2019 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DCezGss2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406704AbfHINw3 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:52:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59464 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfHINw2 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 9 Aug 2019 09:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EreDrMASgymCoOwex2lDSh6PBVp8vwwZo8lBW7Dx+AU=; b=DCezGss28UrQwdHuY2bFdI4p4
        S1IQudbzVnxD+07DxZGKpMaIkZjBN26Cdg8l2/Fs8GMFEeX1pJqh0qZAiUghQaE6El6M1XDplTDve
        EJJcjL9sO79CkY0k30aJUEJAymr58OsH+p8EsukYG7F9sRPnn0G8pCmZVLattID9zhXymV5yWXtFQ
        ciqngFSM0ntk8BRdLo5xQ4zieBSWsCrkihQ+/ft5+CPIVKlVlUX+N97pCSyIU0MATtJ4kwuaN/o18
        WCkKlxmfNm5M1Hch5V2lnDpS3brZehU45KR0NW0dNC4+r+Ph0RyNwH7KE6Q/WHvIQU+odBuHV4vuK
        lstsiJ0Mg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hw5JK-0002PQ-U7; Fri, 09 Aug 2019 13:52:02 +0000
Date:   Fri, 9 Aug 2019 06:52:02 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 0/1] mm/debug: Add tests for architecture exported page
 table helpers
Message-ID: <20190809135202.GN5482@bombadil.infradead.org>
References: <1565335998-22553-1-git-send-email-anshuman.khandual@arm.com>
 <20190809101632.GM5482@bombadil.infradead.org>
 <a5aab7ff-f7fd-9cc1-6e37-e4185eee65ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5aab7ff-f7fd-9cc1-6e37-e4185eee65ac@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, Aug 09, 2019 at 04:05:07PM +0530, Anshuman Khandual wrote:
> On 08/09/2019 03:46 PM, Matthew Wilcox wrote:
> > On Fri, Aug 09, 2019 at 01:03:17PM +0530, Anshuman Khandual wrote:
> >> Should alloc_gigantic_page() be made available as an interface for general
> >> use in the kernel. The test module here uses very similar implementation from
> >> HugeTLB to allocate a PUD aligned memory block. Similar for mm_alloc() which
> >> needs to be exported through a header.
> > 
> > Why are you allocating memory at all instead of just using some
> > known-to-exist PFNs like I suggested?
> 
> We needed PFN to be PUD aligned for pfn_pud() and PMD aligned for mk_pmd().
> Now walking the kernel page table for a known symbol like kernel_init()

I didn't say to walk the kernel page table.  I said to call virt_to_pfn()
for a known symbol like kernel_init().

> as you had suggested earlier we might encounter page table page entries at PMD
> and PUD which might not be PMD or PUD aligned respectively. It seemed to me
> that alignment requirement is applicable only for mk_pmd() and pfn_pud()
> which create large mappings at those levels but that requirement does not
> exist for page table pages pointing to next level. Is not that correct ? Or
> I am missing something here ?

Just clear the bottom bits off the PFN until you get a PMD or PUD aligned
PFN.  It's really not hard.

