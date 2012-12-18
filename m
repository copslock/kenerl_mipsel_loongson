Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2012 19:27:38 +0100 (CET)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:39617 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817293Ab2LRS1bOLoVV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Dec 2012 19:27:31 +0100
Received: by mail-pb0-f54.google.com with SMTP id wz12so629353pbc.41
        for <multiple recipients>; Tue, 18 Dec 2012 10:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=aDsi/h8kZtCk7CsUzkeu4CUYxin+i3YM9zjP/O/udGM=;
        b=BUTH9R/uWU7qAJwg3ldHQl2wXPMSlSbQVKars+bE3hs+xROZSe9RBmRTrNMpPKhCUt
         0FBRM1GXlPJNhU4K33p1bj76L/3sEir4h2PjUpWXosIGVYGkBmZNVZToUynh0MeTVZBu
         vPJESKba9CRqY/QC1liycpWl2H5iT6VgpJjQaj5db5HxcfbGQ0pDG7IUWD6cDDLh6xjr
         xoU8S71HliKmSWGMFL3a3e3EFBnORe967CIcgLSJgOl40370rBe/P345RmfUMxOgE3P/
         oCqQYIQ+U+Nj9iYM0PzxN/cNdzbVQ28lqaD+dlC0BRWwpyW85XpUshNRgVmwYIdXpfpV
         5LoA==
X-Received: by 10.66.86.71 with SMTP id n7mr8903135paz.77.1355855244271;
        Tue, 18 Dec 2012 10:27:24 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ai8sm1547777pbd.14.2012.12.18.10.27.21
        (version=SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 10:27:22 -0800 (PST)
Message-ID: <50D0B588.2070906@gmail.com>
Date:   Tue, 18 Dec 2012 10:27:20 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>, ralf@linux-mips.org
CC:     "Steven J . Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Revert "MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores."
References: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35308
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

On 12/18/2012 01:50 AM, Jayachandran C wrote:
> This reverts commit ff401e52100dcdc85e572d1ad376d3307b3fe28e.
>
> The commit causes a boot-time crash on Netlogic XLP boards. The
> crash is caused by the second part of the patch that changes
> build_get_ptep(), which seems to break mips64 TLB handling on r2
> platforms.
>
> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

Acked-by: David Daney <david.daney@cavium.com>

The offending patch is incorrect and should be reverted.  It uses EXT 
and INS on 64-bit values.

David Daney

> ---
>   arch/mips/mm/tlbex.c |   16 ----------------
>   1 file changed, 16 deletions(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index e085e15..1a17a9b 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -976,13 +976,6 @@ build_get_pgde32(u32 **p, unsigned int tmp, unsigned int ptr)
>   #endif
>   	uasm_i_mfc0(p, tmp, C0_BADVADDR); /* get faulting address */
>   	uasm_i_lw(p, ptr, uasm_rel_lo(pgdc), ptr);
> -
> -	if (cpu_has_mips_r2) {
> -		uasm_i_ext(p, tmp, tmp, PGDIR_SHIFT, (32 - PGDIR_SHIFT));
> -		uasm_i_ins(p, ptr, tmp, PGD_T_LOG2, (32 - PGDIR_SHIFT));
> -		return;
> -	}
> -
>   	uasm_i_srl(p, tmp, tmp, PGDIR_SHIFT); /* get pgd only bits */
>   	uasm_i_sll(p, tmp, tmp, PGD_T_LOG2);
>   	uasm_i_addu(p, ptr, ptr, tmp); /* add in pgd offset */
> @@ -1018,15 +1011,6 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
>
>   static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
>   {
> -	if (cpu_has_mips_r2) {
> -		/* PTE ptr offset is obtained from BadVAddr */
> -		UASM_i_MFC0(p, tmp, C0_BADVADDR);
> -		UASM_i_LW(p, ptr, 0, ptr);
> -		uasm_i_ext(p, tmp, tmp, PAGE_SHIFT+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> -		uasm_i_ins(p, ptr, tmp, PTE_T_LOG2+1, PGDIR_SHIFT-PAGE_SHIFT-1);
> -		return;
> -	}
> -
>   	/*
>   	 * Bug workaround for the Nevada. It seems as if under certain
>   	 * circumstances the move from cp0_context might produce a
>
