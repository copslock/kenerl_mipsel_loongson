Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 22:32:23 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:45956 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903874Ab1KPVcR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Nov 2011 22:32:17 +0100
Received: by ggnb1 with SMTP id b1so240447ggn.36
        for <linux-mips@linux-mips.org>; Wed, 16 Nov 2011 13:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=roUnNzgnGVGUp1xRyhgei733Wc7Apl3oM689quOg67E=;
        b=eke9s63eJHDIZycW+f7ikvEYNbHCHb2Xu9cBENNAwPDpJlz6IBWlkA2WJgqmWPuj5w
         x3keoUgbC6fBUJ6A1cAA==
Received: by 10.42.19.195 with SMTP id d3mr34219909icb.21.1321479130387;
        Wed, 16 Nov 2011 13:32:10 -0800 (PST)
Received: by 10.42.19.195 with SMTP id d3mr34219839icb.21.1321479130103;
        Wed, 16 Nov 2011 13:32:10 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id eh34sm48962473ibb.5.2011.11.16.13.32.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 13:32:09 -0800 (PST)
Date:   Wed, 16 Nov 2011 13:32:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        William Irwin <wli@holomorphy.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] hugetlb: Provide a default HPAGE_SHIFT if
 !CONFIG_HUGETLB_PAGE
In-Reply-To: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <alpine.DEB.2.00.1111161327180.16596@chino.kir.corp.google.com>
References: <1321472611-13283-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13862

On Wed, 16 Nov 2011, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> This is required now to get MIPS kernels to compile with
> !CONFIG_HUGETLB_PAGE.
> 

Why?  Apparently there's some config option you've enabled that is causing 
it to fail but I can't find it.  defconfig works fine on my mips 
crosscompiler and allyesconfig is borked already in other ways.

This is definitely the wrong fix, anyway, and it would require a change to 
arch/mips/include/asm/page.h instead since it's localized to mips, so 
nack.

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  include/linux/hugetlb.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 19644e0..746d543 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -113,6 +113,7 @@ static inline void copy_huge_page(struct page *dst, struct page *src)
>  #ifndef HPAGE_MASK
>  #define HPAGE_MASK	PAGE_MASK		/* Keep the compiler happy */
>  #define HPAGE_SIZE	PAGE_SIZE
> +#define HPAGE_SHIFT	PAGE_SHIFT
>  #endif
>  
>  #endif /* !CONFIG_HUGETLB_PAGE */
