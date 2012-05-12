Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 14:10:05 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:65075 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903566Ab2ELMJ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 12 May 2012 14:09:57 +0200
Received: by lbbgg6 with SMTP id gg6so3074414lbb.36
        for <linux-mips@linux-mips.org>; Sat, 12 May 2012 05:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=4UfmxfsCDPLrsmkxEqA1Oqm7ASmetjSNmmK5IRtF5/I=;
        b=eHJJ6+cozbYl0OtpuEcsSTuXvqo1w4j+GhbiLDCZ5sVDmuLjEvAFziItjMozMSDnOM
         O55xsHPeAOtEH9XjOTMPukYEoT+4OMVDdR4BPQkZl3ByRByrWURNFycqNiGOmnJSWakA
         aJVtbd482DyeD4s/rWSCJG5ltZyHnOeaxOni//dkLciSFiLwXELDGfM+sTV4anqSB5DH
         +oa8BHciBOPq9yvGB072zwWdHRvNaefPzzQaBzmyIihGxsCoqoO0hLDyMZPcdEOD4J3e
         jKLjJyH1+xFu/I9cBw2Dvtx1QIBzw7xr7Me7+fu/QHClyQY5O4SWNMlRaDls/ylO6JGT
         ztBg==
Received: by 10.112.36.34 with SMTP id n2mr681465lbj.62.1336824590850;
        Sat, 12 May 2012 05:09:50 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-100-34.pppoe.mtu-net.ru. [91.79.100.34])
        by mx.google.com with ESMTPS id o2sm15709178lbd.7.2012.05.12.05.09.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 May 2012 05:09:48 -0700 (PDT)
Message-ID: <4FAE52F4.6020301@mvista.com>
Date:   Sat, 12 May 2012 16:09:24 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v2,1/5] MIPS: Add support for the 1074K core.
References: <1336684439-25109-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1336684439-25109-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmLd3rBYY/Txk9Wjm+iX1MnzRvjccux4F0BO1DY5H+GgNAIjryZShBQpIFXeOJ698B6q8X3
X-archive-position: 33286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 11-05-2012 1:13, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> This patch adds support for detecting and using 1074K cores.

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
[...]

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index bda8eb2..c646a79 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -977,7 +977,7 @@ static void __cpuinit probe_pcache(void)
>   			c->icache.linesz = 2<<  lsize;
>   		else
>   			c->icache.linesz = lsize;
> -		c->icache.sets = 64<<  ((config1>>  22)&  7);
> +		c->icache.sets = 32<<  (((config1>>  22) + 1)&  7);
>   		c->icache.ways = 1 + ((config1>>  16)&  7);
>
>   		icache_size = c->icache.sets *
> @@ -997,7 +997,7 @@ static void __cpuinit probe_pcache(void)
>   			c->dcache.linesz = 2<<  lsize;
>   		else
>   			c->dcache.linesz= lsize;
> -		c->dcache.sets = 64<<  ((config1>>  13)&  7);
> +		c->dcache.sets = 32<<  (((config1>>  13) + 1)&  7);
>   		c->dcache.ways = 1 + ((config1>>  7)&  7);

    Are these related changes? They seem common, no 1074K specific...

> @@ -1051,9 +1051,26 @@ static void __cpuinit probe_pcache(void)
>   	case CPU_R14000:
>   		break;
>
> +	case CPU_74K:
> +		/*
> +		 * Early versions of the 74k do not update

    Early versions of 74K and 1074K? Shouldn't this be a sperate patch?

> +		 * the cache tags on a vtag miss/ptag hit
> +		 * which can occur in the case of KSEG0/KUSEG aliases
> +		 * In this case it is better to treat the cache as always
> +		 * having aliases
> +		 */
> +		if ((c->processor_id&  0xff)<= PRID_REV_ENCODE_332(2, 4, 0))
> +			c->dcache.flags |= MIPS_CACHE_VTAG;
> +		if ((c->processor_id&  0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> +			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +		if (((c->processor_id&  0xff00) == PRID_IMP_1074K)&&
> +		   ((c->processor_id&  0xff)<= PRID_REV_ENCODE_332(1, 1, 0))) {
> +			c->dcache.flags |= MIPS_CACHE_VTAG;
> +			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +		}
> +		/* fall through */
>   	case CPU_24K:
>   	case CPU_34K:
> -	case CPU_74K:
>   	case CPU_1004K:
>   		if ((read_c0_config7()&  (1<<  16))) {
>   			/* effectively physically indexed dcache,
> diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
> index 54759f1..53bbe55 100644
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -330,12 +330,6 @@ static int __init mipsxx_init(void)
>   		break;
>
>   	case CPU_1004K:
> -#if 0
> -		/* FIXME: report as 34K for now */
> -		op_model_mipsxx_ops.cpu_type = "mips/1004K";
> -		break;
> -#endif
> -

    Unrelated change.

WBR, Sergei
