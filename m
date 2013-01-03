Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jan 2013 23:38:10 +0100 (CET)
Received: from mail-da0-f47.google.com ([209.85.210.47]:63163 "EHLO
        mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823014Ab3ACWiGYbjmz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jan 2013 23:38:06 +0100
Received: by mail-da0-f47.google.com with SMTP id s35so7170721dak.34
        for <multiple recipients>; Thu, 03 Jan 2013 14:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=sq4HBGXbNAUWQKVXuCpC5tkNnOOoUOZn1GR58x/C1q4=;
        b=mNUO6phBOd4fnnQEWsIqHudGXmBiE04O3tHCtpiBXLh5SFDHVCbZD9jDDZXtgB3PtG
         pAr5HuxSgqetBir0/t2zhxPpcbiThp+R8k7skOlZijkV2d1+4f9WwvehKV/OEolAzulN
         9c8spwwn2iD3v1rYq6vPpi3qVq7aau8y4Q2BfeeEamzawUaddGwfuYamzFcgzYaRuBIb
         fw8M1Qp04dSqjXTC1SmI2/4/je1fW6abNbTGs3iuig7ItqJ4qwGaSv9O72PoBt68TIg4
         oTICy7G/AlOXvhqUZpOBLHIcTDmynMgfSl/UYyEJlBkZ2lQO/FXEH3gQm5jLTK4ml0ao
         MPHA==
X-Received: by 10.66.72.225 with SMTP id g1mr149039326pav.79.1357252679475;
        Thu, 03 Jan 2013 14:37:59 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id t1sm31930503paw.11.2013.01.03.14.37.58
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Jan 2013 14:37:58 -0800 (PST)
Message-ID: <50E60845.9060700@gmail.com>
Date:   Thu, 03 Jan 2013 14:37:57 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        jchandra@broadcom.com
Subject: Re: [PATCH v2] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
References: <1357249536-2308-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1357249536-2308-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35360
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

On 01/03/2013 01:45 PM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> The EXT and INS instructions can be used to decrease code size and
> thus speed up TLB handlers on MIPS32R2 and MIPS64R2 cores.
>
[...]
> @@ -1012,6 +1019,24 @@ static void __cpuinit build_adjust_context(u32 **p, unsigned int ctx)
>
>   static void __cpuinit build_get_ptep(u32 **p, unsigned int tmp, unsigned int ptr)
>   {
> +	if (cpu_has_mips_r2) {
> +		/* PTE ptr offset is obtained from BadVAddr */
> +		UASM_i_MFC0(p, tmp, C0_BADVADDR);
> +		UASM_i_LW(p, ptr, 0, ptr);
> +#ifdef CONFIG_CPU_MIPS64

Is this the right condition?  Is is correct for a 32-bit kernel running 
on a 64-bit CPU?  Will OCTEON be covered? (no, but it should)

> +		uasm_i_dext(p, tmp, tmp, (PAGE_SHIFT + 1),
> +			(PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
> +		uasm_i_dins(p, ptr, tmp, (PTE_T_LOG2 + 1),
> +			(PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
> +#else
> +		uasm_i_ext(p, tmp, tmp, (PAGE_SHIFT + 1),
> +			(PGDIR_SHIFT - PAGE_SHIFT - 1);

Did you even compile this?  It looks like a mismatch in the number of 
'(' and ')'.

> +		uasm_i_ins(p, ptr, tmp, (PTE_T_LOG2 + 1),
> +			(PGDIR_SHIFT - PAGE_SHIFT - 1);
> +#endif
> +		return;
> +	}


Can this whole thing be made more clear by defining UASM_i_EXT(...) that 
does the proper thing for either 32 or 64 bit kernels as the rest of the 
capitolized versions of the macros do?


Is (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1) != (PGDIR_SHIFT - 
PAGE_SHIFT - 1) for any combinations of config options?  Why are they 
different for the two cases?

David Daney
