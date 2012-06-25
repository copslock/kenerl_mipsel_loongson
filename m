Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2012 21:13:22 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64446 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903737Ab2FYTNP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jun 2012 21:13:15 +0200
Received: by bkwj4 with SMTP id j4so3892387bkw.36
        for <linux-mips@linux-mips.org>; Mon, 25 Jun 2012 12:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=pM3uffMhDuf5tv+T58ZPXidr7r7fP2ONi3UHW6DQ4OY=;
        b=pPmDup5z8ItTd1veYH6UkoW7/lfDw+SwBM7mSCb3HN0Ko0xLgtgmAP4E/ZWJJNW0tL
         cmDykpk/zt32SWFgubov8S34apOG/6zqV/qax04K69VfPx9y1uo29nKI2IbJYXtl85tR
         p27A+u+PUlMzWFFgnV2uuZlkPNWkzY3XJBHmYmixIEhnO2vyv26t6SzBShbDop9rNvAH
         xNwU3KN0AAowXIzdVwXYvergL8Kj5ov46bs1f8M2J1OUv9tijktGHN2pyoMlFslTu73Z
         G+iV8LAl5e5NYcMNS0wVrijdsk5c9ej5iVdZ/zWMb70vPBboUaVL0aom9IpzzmBTgwNw
         mUeA==
Received: by 10.152.111.71 with SMTP id ig7mr13134383lab.28.1340651589418;
        Mon, 25 Jun 2012 12:13:09 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id gt19sm72530794lab.17.2012.06.25.12.13.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 12:13:07 -0700 (PDT)
Message-ID: <4FE8B7EC.7030505@mvista.com>
Date:   Mon, 25 Jun 2012 23:11:40 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v4,1/5] MIPS: Add support for the 1074K core.
References: <1340636959-14526-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1340636959-14526-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnv1y+01mofi3RuohApjn6zaL14sMZMBYNImX4dE3XBNkNtTQmwvK1BTc3To4FEUxRy5XvN
X-archive-position: 33802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 06/25/2012 07:09 PM, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>

> Signed-off-by: Steven J. Hill <sjhill@mips.com>

    Minor nit on code formatting.

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index ce0dbee..b96ebe9 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1040,10 +1040,27 @@ static void __cpuinit probe_pcache(void)
>   	case CPU_R14000:
>   		break;
>
> +	case CPU_74K:
> +		/*
> +		 * Early versions of the 74k do not update
> +		 * the cache tags on a vtag miss/ptag hit
> +		 * which can occur in the case of KSEG0/KUSEG aliases
> +		 * In this case it is better to treat the cache as always
> +		 * having aliases
> +		 */
> +		if ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(2, 4, 0))
> +			c->dcache.flags |= MIPS_CACHE_VTAG;
> +		if ((c->processor_id & 0xff) == PRID_REV_ENCODE_332(2, 4, 0))
> +			write_c0_config6(read_c0_config6() | MIPS_CONF6_SYND);
> +		if (((c->processor_id & 0xff00) == PRID_IMP_1074K) &&
> +		   ((c->processor_id & 0xff) <= PRID_REV_ENCODE_332(1, 1, 0))) {

    Wrong indentation here -- the first ( should be shifted at least one space 
to the right.

WBR, Sergei
