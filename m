Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Oct 2010 03:17:39 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:61560 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab0JJBRg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Oct 2010 03:17:36 +0200
Received: by qyk34 with SMTP id 34so1673951qyk.15
        for <multiple recipients>; Sat, 09 Oct 2010 18:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aloB0mYiTQ5ln7L/NdG/WD9HjgYaVDlGPmSHkZo48UU=;
        b=mTobAH/jH0QhlN+s/qM5WF8iCEi281J7aDaiwjkyIBRwesF+wOh3o3IR478Dq63kpP
         FQYSldVtZlqv9LU4M3fmYjCUICkVOqA2I1G3AQtauAloDyPWmbMFPFeDTnIEutwheX13
         ksth2Fk8v2f/czi5mSTkJyTD4GUc1tKCSWNYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f1I9juQNkPpocgl6RZnJ4FsC/2Z4rNrEZCetNnMbU1Z1GzpjgepcltEleMoPcO3e9+
         Z15XvlyROshVFggmguxU+LhHC4Ms19ahqzGK97qPcjJGiyoRSpOYpRiVmjHhq5mLxxq1
         R561e7oQpKAI0iui7BZveOTQs0LT5ZQt2OZr0=
MIME-Version: 1.0
Received: by 10.224.29.16 with SMTP id o16mr537412qac.319.1286673448296; Sat,
 09 Oct 2010 18:17:28 -0700 (PDT)
Received: by 10.224.47.77 with HTTP; Sat, 9 Oct 2010 18:17:28 -0700 (PDT)
In-Reply-To: <1285964854-28659-7-git-send-email-ddaney@caviumnetworks.com>
References: <1285964854-28659-1-git-send-email-ddaney@caviumnetworks.com>
        <1285964854-28659-7-git-send-email-ddaney@caviumnetworks.com>
Date:   Sat, 9 Oct 2010 18:17:28 -0700
Message-ID: <AANLkTi=iunuoWEd=cB6i5K7Dn0oGCrN4C3-tfqDz6vJZ@mail.gmail.com>
Subject: Re: [PATCH 6/8] MIPS: Convert DMA to use dma-mapping-common.h
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, Oct 1, 2010 at 1:27 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
> index 8da9807..8259966 100644
> --- a/arch/mips/include/asm/mach-generic/dma-coherence.h
> +++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
> @@ -17,12 +17,6 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
>        return virt_to_phys(addr);
>  }
>
> -static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
> -       struct page *page)
> -{
> -       return page_to_phys(page);
> -}
> -

I was attempting to rebase the HIGHMEM DMA patch against mips-queue,
and ran into a problem with this change:

mips_dma_map_sg() and mips_dma_map_page() now assume that it is
possible to convert any "struct page" to a VA, then convert that VA to
a PA.  This is not necessarily true for HIGHMEM pages (it is perfectly
valid for page_address(page) == NULL).  For cases where we are passed
a "struct page" instead of a VA, it is desirable to be able to call
plat_map_dma_mem_page() directly on the struct page.

Since this function is not implemented as a trivial page_to_phys()
wrapper on all MIPS platforms, I believe it would need to be
reinstated in order to support direct page->PA translation.
