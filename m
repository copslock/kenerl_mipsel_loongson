Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Mar 2013 19:13:12 +0100 (CET)
Received: from mail-da0-f46.google.com ([209.85.210.46]:56809 "EHLO
        mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824765Ab3CDSNLATFvT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Mar 2013 19:13:11 +0100
Received: by mail-da0-f46.google.com with SMTP id z8so2690190dad.19
        for <multiple recipients>; Mon, 04 Mar 2013 10:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=baO/FyXIcyUKa3fS0KFD57A640/ONwrBRWlcY/VagoY=;
        b=JEgpPRCG51z4SSsfN/U/IsKr/6xz0gIIT4LaJYf7P3NnV/ftYpBMnUsVC/q0+QkGxi
         6SXeCjB6tREGppKOPgKbRZgcTmt0tlVfr8Dn8zClr3JqNRv1jMKgXPXUyS+r3DbbIZ99
         yu0Zn95ayWn0hUJ26x68ehCf2LgY9EKnFf1kraTulLBu7XpzzL/NQd59gbKYSR5BTcD3
         jujO45NK4o6Yz26ghNG3v0YsVhfbO+Q4YWhawXCQiCRTxYdq2TFi6cR2TOpDecmYDGXg
         1OT6WCYC159fxCspU4ofTKpaE4eGbBNzYlkfjs15FFIybbCiOYzWQDCy4AIc78hIVz6x
         W+1g==
X-Received: by 10.68.231.164 with SMTP id th4mr29142660pbc.198.1362420783706;
        Mon, 04 Mar 2013 10:13:03 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id rd1sm23144871pbc.19.2013.03.04.10.13.01
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 04 Mar 2013 10:13:02 -0800 (PST)
Message-ID: <5134E42C.9050509@gmail.com>
Date:   Mon, 04 Mar 2013 10:13:00 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Ben Hutchings <ben@decadent.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: MIPS: Add dependencies for HAVE_ARCH_TRANSPARENT_HUGEPAGE
References: <1362257499.3768.141.camel@deadeye.wl.decadent.org.uk> <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk>
In-Reply-To: <1362370641.3768.291.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35842
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

On 03/03/2013 08:17 PM, Ben Hutchings wrote:
> The MIPS implementation of transparent huge-pages (THP) is 64-bit only,
> and of course also requires that the CPU supports huge-pages.
>
> Currently it's entirely possible to enable THP in other configurations,
> which then fail to build due to pfn_pmd() not being defined.
>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Cc: David Daney <david.daney@cavium.com>

This is correct.

Acked-by: David Daney <david.daney@cavium.com>


> ---
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -19,7 +19,7 @@ config MIPS
>   	select HAVE_KRETPROBES
>   	select HAVE_DEBUG_KMEMLEAK
>   	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
> -	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
> +	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
>   	select RTC_LIB if !MACH_LOONGSON
>   	select GENERIC_ATOMIC64 if !64BIT
>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>
