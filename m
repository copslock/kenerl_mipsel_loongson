Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 00:36:55 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:39951 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006992AbbBYXgxeNaBh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 00:36:53 +0100
Received: by mail-ig0-f177.google.com with SMTP id z20so10279347igj.4;
        Wed, 25 Feb 2015 15:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8XZErQbZPQNZjXCTMdOVb2xcSUCQIq4wFQiT8NxjwwM=;
        b=iAaogRU2fZrtohCOLR4P7ICDp4yEURxYWHEubuiveHe71HSjJ8RvT2bE8IjJpSOaed
         edvsyMlQqWXd6ZG7Vb+FBa9gQMZDxzKFOIKOs4X8yhTC+5yNAfQigcQl1maOhUxD5+hu
         msK3ygdVfJn+2WZMebTSlkJE+b8JgTSIepmE/RwIBP3aa5K50LzR4RoWJQf5G4g66F4s
         y0YM9ZRxW1ZJLDlbGObCDIqwyWkOi+ZAtJMw0VL+pmlUbz33wH61kVo+KS0KEM93XWIs
         fTJrMG9r6qy5tstE3MH9SZ+PbMDmMUamtfF3tZu/c0iT6DS3Wk01wge3T296vVCQpvzo
         r6cg==
X-Received: by 10.43.111.66 with SMTP id en2mr6850578icc.6.1424907408097;
        Wed, 25 Feb 2015 15:36:48 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id f1sm6820771iof.30.2015.02.25.15.36.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 25 Feb 2015 15:36:47 -0800 (PST)
Message-ID: <54EE5C8E.7080501@gmail.com>
Date:   Wed, 25 Feb 2015 15:36:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: mark prom_free_prom_memory() everywhere with __init
References: <1424907064-31621-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1424907064-31621-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45981
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

On 02/25/2015 03:31 PM, Aaro Koskinen wrote:
> Mark prom_free_prom_memory with() everywhere with __init.
>
> On OCTEON the function is non-trivial and we can potentially even
> save some memory.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

OCTEON part:

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/setup.c  | 2 +-
>   arch/mips/lantiq/prom.c          | 2 +-
>   arch/mips/mti-sead3/sead3-init.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index a42110e..d0fa0bc 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -1043,7 +1043,7 @@ int prom_putchar(char c)
>   }
>   EXPORT_SYMBOL(prom_putchar);
>
> -void prom_free_prom_memory(void)
> +void __init prom_free_prom_memory(void)
>   {
>   	if (CAVIUM_OCTEON_DCACHE_PREFETCH_WAR) {
>   		/* Check for presence of Core-14449 fix.  */
> diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
> index 39ab3e7..0db099e 100644
> --- a/arch/mips/lantiq/prom.c
> +++ b/arch/mips/lantiq/prom.c
> @@ -41,7 +41,7 @@ int ltq_soc_type(void)
>   	return soc_info.type;
>   }
>
> -void prom_free_prom_memory(void)
> +void __init prom_free_prom_memory(void)
>   {
>   }
>
> diff --git a/arch/mips/mti-sead3/sead3-init.c b/arch/mips/mti-sead3/sead3-init.c
> index bfbd17b..3572ea3 100644
> --- a/arch/mips/mti-sead3/sead3-init.c
> +++ b/arch/mips/mti-sead3/sead3-init.c
> @@ -147,6 +147,6 @@ void __init prom_init(void)
>   #endif
>   }
>
> -void prom_free_prom_memory(void)
> +void __init prom_free_prom_memory(void)
>   {
>   }
>
