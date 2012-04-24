Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 01:27:31 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:35924 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903766Ab2DXX1P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2012 01:27:15 +0200
Received: by pbbrq13 with SMTP id rq13so735393pbb.36
        for <multiple recipients>; Tue, 24 Apr 2012 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SXviY1N3tuuHuWTq9GDaVxWoQI8R7ejIkuXAntOsgcs=;
        b=KMyKCWhsCBD3gBbNnLHGjkB2rvAkdIP6kqbighSBSlPsfl/yhPxMcku8cxIi3jc305
         9en6Z3KVC2shjAUsq01mgKgJ1a6sGLNz/2Sank+9kslksr6UbU5x0xW3ld4hxsqc2Hu4
         EVZI9L8OYNVBt/MgH1BuniiNNhFhKuS3tQftL8vEUwwQNYU6tz+iO4Ug/YWostQJzr7S
         SHrZq9Ez54LF7qXlsKMvWcrTuT5Hf0RO2MSqsMEULku1kWO7uqmkfn+EslURAgzSqMEb
         Y3CYaLhocr7FDCOf+iGsXgUibezTmoWU++suKNWsA8N5ThfrQ3YJ8hfb1yvO2ADslTfk
         GHHA==
Received: by 10.68.129.9 with SMTP id ns9mr1963027pbb.104.1335310028372;
        Tue, 24 Apr 2012 16:27:08 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id qk5sm1204853pbc.45.2012.04.24.16.27.06
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 16:27:06 -0700 (PDT)
Message-ID: <4F9736C9.8020003@gmail.com>
Date:   Tue, 24 Apr 2012 16:27:05 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: Add support for transparent huge page
References: <CAJd=RBAXc+QSX+xnJ2W9vVwK64Etrzrr=iBqPkJXNvYgwujQ_Q@mail.gmail.com>
In-Reply-To: <CAJd=RBAXc+QSX+xnJ2W9vVwK64Etrzrr=iBqPkJXNvYgwujQ_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/26/2011 06:35 AM, Hillf Danton wrote:
> This patchset adds THP support for MIPS.
>
> Two page-table-entry bits, namely huge and splitting, are required by THP.
> The huge bit is already defined and used for huge TLB, THP simply uses it.
>
> For the splitting bit, the present bit is selected, since for regular pmd
> entry pmd_present() is defined to be not directly related to the bit. If this
> selection is not sane, this work as a whole is a mess. So selected then the
> current work of huge TLB could also be used for THP, see next patch.
>
> Other pmd mangling primitives are added in a straight manner, and they are
> confined to a single file, asm/thp.h.
>
>
> Signed-off-by: Hillf Danton<dhillf@gmail.com>
> ---
>
> --- a/arch/mips/include/asm/pgtable-bits.h	Thu Nov 24 21:16:22 2011
> +++ b/arch/mips/include/asm/pgtable-bits.h	Sat Nov 26 20:49:31 2011
> @@ -94,7 +94,7 @@
>   /* set:pagecache unset:swap */
>   #define _PAGE_FILE		(_PAGE_MODIFIED)
>
> -#ifdef CONFIG_HUGETLB_PAGE
> +#if defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE)
>   /* huge tlb page */
>   #define _PAGE_HUGE_SHIFT	(_PAGE_MODIFIED_SHIFT + 1)
>   #define _PAGE_HUGE		(1<<  _PAGE_HUGE_SHIFT)
> --- a/arch/mips/include/asm/pgtable.h	Thu Nov 24 21:17:38 2011
> +++ b/arch/mips/include/asm/pgtable.h	Sat Nov 26 20:50:52 2011
> @@ -394,6 +394,9 @@ static inline int io_remap_pfn_range(str
>   		remap_pfn_range(vma, vaddr, pfn, size, prot)
>   #endif
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#include<asm/thp.h>
> +#endif
>   #include<asm-generic/pgtable.h>
>
>   /*
> --- /dev/null	Sat Nov 26 21:04:52 2011
> +++ b/arch/mips/include/asm/thp.h	Sat Nov 26 21:02:52 2011
> @@ -0,0 +1,167 @@
> +#ifndef _ASM_PGTABLE_THP_H
> +#define _ASM_PGTABLE_THP_H
> +/*
> + * pmd primitives for transparent huge page
> + *
> + * Copyright (C) 2011 David Daney

I'm not sure where that copyright came from.


Other than that, these seem plausible.

David Daney
