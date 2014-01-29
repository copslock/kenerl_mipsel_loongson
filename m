Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2014 14:31:13 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:63285 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825709AbaA2NbHbC7IT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jan 2014 14:31:07 +0100
Received: by mail-la0-f51.google.com with SMTP id c6so1492543lan.10
        for <linux-mips@linux-mips.org>; Wed, 29 Jan 2014 05:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=giO0HUxUZ+ryV+C08+LTntnHTLhqR25+AqR+chzDrg8=;
        b=PLg26K5vriD8wrC3nbYH4G+IhZLOBLSNkcHYpULEGPPDaFDd4VKW+mxUgduxWfTiPx
         VwkY8KmxO0R8HPU1ywDoK6eB+YoX4+dIMahASBzBKurd7sXqAL2SyMKukX/iQ/HDbUGc
         Dar4oxWRgpBIGwL87/argtebWCuccNBTrvOWVfAch7FeLZZF6yfS7GTxE3bsTt/Y0Plz
         thVwSHPIIgKCCxeE98PmfR/179eolPXB6ZbWYsspDj49Hjp4QweHdXuai7dqDUyAPPGF
         hMKSDnJIvEbYJFm5QDD1jEhM35BcBQMot5IEdMvSyoiznWPeu1wd8VQ1JeBjFkpztX6b
         KvyQ==
X-Gm-Message-State: ALoCoQkZxI3IdnHXxypVYJ20/guP8RSGeIlVIIj5/tEV3zgyzgzelWX9ERRv7xcEg0qOMPBBY2Mn
X-Received: by 10.112.50.15 with SMTP id y15mr64883lbn.74.1391002261912;
        Wed, 29 Jan 2014 05:31:01 -0800 (PST)
Received: from [192.168.2.4] (ppp85-140-128-3.pppoe.mtu-net.ru. [85.140.128.3])
        by mx.google.com with ESMTPSA id j1sm3525138laj.3.2014.01.29.05.31.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:31:00 -0800 (PST)
Message-ID: <52E9029C.80300@cogentembedded.com>
Date:   Wed, 29 Jan 2014 17:31:08 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: mm: c-r4k: Detect instruction cache aliases
References: <1391001009-19580-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1391001009-19580-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 29-01-2014 17:10, Markos Chandras wrote:

> The *Aptiv cores can use the CONF7/IAR bit to detect if the core
> has hardware support to remove instruction cache aliasing.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree
[...]

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 13b549a..e790524 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1110,7 +1110,10 @@ static void probe_pcache(void)
>   	case CPU_PROAPTIV:
>   		if (current_cpu_type() == CPU_74K)
>   			alias_74k_erratum(c);
> -		if ((read_c0_config7() & (1 << 16))) {
> +		if (!(read_c0_config7() & MIPS_CONF7_IAR))
> +			if (c->icache.waysize > PAGE_SIZE)

    Why not fold these to a single *if*?

> +				c->icache.flags |= MIPS_CACHE_ALIASES;
> +		if (read_c0_config7() & MIPS_CONF7_AR) {

    You didn't document this change. Ideally, it should be in a separate patch.

WBR, Sergei
