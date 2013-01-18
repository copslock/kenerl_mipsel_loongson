Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2013 19:10:31 +0100 (CET)
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50194 "EHLO
        mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824764Ab3ARSKal9S7y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jan 2013 19:10:30 +0100
Received: by mail-pb0-f41.google.com with SMTP id xa7so2191471pbc.0
        for <multiple recipients>; Fri, 18 Jan 2013 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=u+4lHJt5Nwa1So+AXdCJcNmTySJ5Yv6QwstShCcRNmc=;
        b=N3c6V7uZFpIvZu1BtGLdKAlGP+ggeH7nICD1ByZtdmRvSmPhtwxga2XNwTesZZMe5j
         Vk6A3bruHPaOQBmrkBLh3OrDp4tlGvFw7i5BM7JtX3bAA0r/GzIgIq6pNRD2Tmh4v0fE
         pkBnYP1XIK2oSznph+5zrDlaGzk3qi+x7a+Kjcxul/OA/6OVCNZaWShascoUWdLKgIoI
         CtgRIC7M+lXsYsCm7fgKJA9TVT8KGPegiV34bvC0QJt0GepfNs67WoDyxOxeXj4cHFno
         h+cQqh1PddtS639LuA/xVW029b/nPcUpJjdhkAf5i4MrW8udua7OuS9XUliB0v/HZg68
         gncw==
X-Received: by 10.68.248.70 with SMTP id yk6mr7667661pbc.160.1358532624091;
        Fri, 18 Jan 2013 10:10:24 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pj1sm3467323pbb.71.2013.01.18.10.10.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 18 Jan 2013 10:10:20 -0800 (PST)
Message-ID: <50F9900A.9070804@gmail.com>
Date:   Fri, 18 Jan 2013 10:10:18 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org
Subject: 3.8-rc4 build regression (was: Re: 3.8-rc1 build failure with MIPS/SPARSEMEM)
References: <20121222122757.GB6847@blackmetal.musicnaut.iki.fi> <20121226003434.GA27760@otc-wbsnb-06>
In-Reply-To: <20121226003434.GA27760@otc-wbsnb-06>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Linus, Andrew and Ralf,

3.8 doesn't build on MIPS any more.

Please consider this patch ...

On 12/25/2012 04:34 PM, Kirill A. Shutemov wrote:
> On Sat, Dec 22, 2012 at 02:27:57PM +0200, Aaro Koskinen wrote:
>> Hi,
>>
>> It looks like commit 816422ad76474fed8052b6f7b905a054d082e59a
>> (asm-generic, mm: pgtable: consolidate zero page helpers) broke
>> MIPS/SPARSEMEM build in 3.8-rc1:
>>
>>    CHK     include/generated/uapi/linux/version.h
>>    CHK     include/generated/utsrelease.h
>>    Checking missing-syscalls for N32
>>    CC      arch/mips/kernel/asm-offsets.s
>> In file included from /home/aaro/git/linux/arch/mips/include/asm/pgtable.h:388:0,
>>                   from include/linux/mm.h:44,
>>                   from arch/mips/kernel/asm-offsets.c:14:
>> include/asm-generic/pgtable.h: In function 'my_zero_pfn':
>> include/asm-generic/pgtable.h:462:9: error: implicit declaration of function 'page_to_section' [-Werror=implicit-function-declaration]
>> In file included from arch/mips/kernel/asm-offsets.c:14:0:
>> include/linux/mm.h: At top level:
>> include/linux/mm.h:708:29: error: conflicting types for 'page_to_section'
>> In file included from /home/aaro/git/linux/arch/mips/include/asm/pgtable.h:388:0,
>>                   from include/linux/mm.h:44,
>>                   from arch/mips/kernel/asm-offsets.c:14:
>> include/asm-generic/pgtable.h:462:9: note: previous implicit declaration of 'page_to_section' was here
>> cc1: some warnings being treated as errors
>> make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
>> make: *** [archprepare] Error 2
>
> The patch below works for me. Could you try?
>
>  From a123a406fdc3aee7ca0eae04b6b4a231872dbb51 Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> Date: Wed, 26 Dec 2012 03:19:55 +0300
> Subject: [PATCH] asm-generic, mm: pgtable: convert my_zero_pfn() to macros to
>   fix build
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> On MIPS if SPARSEMEM is enabled we've got this:
>
> In file included from /home/kas/git/public/linux/arch/mips/include/asm/pgtable.h:552,
>                   from include/linux/mm.h:44,
>                   from arch/mips/kernel/asm-offsets.c:14:
> include/asm-generic/pgtable.h: In function ‘my_zero_pfn’:
> include/asm-generic/pgtable.h:466: error: implicit declaration of function ‘page_to_section’
> In file included from arch/mips/kernel/asm-offsets.c:14:
> include/linux/mm.h: At top level:
> include/linux/mm.h:738: error: conflicting types for ‘page_to_section’
> include/asm-generic/pgtable.h:466: note: previous implicit declaration of ‘page_to_section’ was here
>
> Due header files inter-dependencies, the only way I see to fix it is
> convert my_zero_pfn() for __HAVE_COLOR_ZERO_PAGE to macros.
>
> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>

I arrived (independently) at the identical solution.

Acked-by: David Daney <david.daney@cavium.com>


> ---
>   include/asm-generic/pgtable.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 701beab..5cf680a 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -461,10 +461,8 @@ static inline int is_zero_pfn(unsigned long pfn)
>   	return offset_from_zero_pfn <= (zero_page_mask >> PAGE_SHIFT);
>   }
>
> -static inline unsigned long my_zero_pfn(unsigned long addr)
> -{
> -	return page_to_pfn(ZERO_PAGE(addr));
> -}
> +#define my_zero_pfn(addr)	page_to_pfn(ZERO_PAGE(addr))
> +
>   #else
>   static inline int is_zero_pfn(unsigned long pfn)
>   {
>
