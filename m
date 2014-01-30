Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jan 2014 18:33:12 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:37748 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823073AbaA3RdKw5Azx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Jan 2014 18:33:10 +0100
Received: by mail-lb0-f181.google.com with SMTP id z5so2741878lbh.40
        for <linux-mips@linux-mips.org>; Thu, 30 Jan 2014 09:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=nMfO52c6ZOJ1/GsbdJnPxXGKef3ECR64B8snMcRC/1I=;
        b=Px62+/zl/9hXBA10WA8EJU6hGUD4wVcceVpKbpxRyFaii7oG2rIr6RPe+e77WEPq9p
         1+O1PsRebth+x0GJxNV7jQG2qQqxxiGgkaJrdoKXjGjH41lb7RcZjL5fLTFZ6WVQyi2w
         LqRlfidaHBvjMbnrwXHP7NYf+9jh3N9KEf3LkH50HouLHlPRMyqFcXmjMoXRbEuJWuuW
         PNObs77C+tsHAwNSnTJRNAmy2Rj7zjrBjtWaNR4Ez05CAkiMqv29HAUICDNZP0T0oAlS
         t7BLGC2UP/g5YbwMICFoHyFEeUOparFHvij5VMvefzvoPRv5X7yLcULH6tqobMd5zyT4
         ihXA==
X-Gm-Message-State: ALoCoQnLjWIAjocYwl/V+rojVCk4YenK63OewS4vH+6N343IP8hLyDi40KnYiKQ/gwc8Rk2tvd1L
X-Received: by 10.112.172.69 with SMTP id ba5mr1519178lbc.55.1391103185273;
        Thu, 30 Jan 2014 09:33:05 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp85-140-129-34.pppoe.mtu-net.ru. [85.140.129.34])
        by mx.google.com with ESMTPSA id rt7sm7299922lbb.0.2014.01.30.09.33.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 09:33:04 -0800 (PST)
Message-ID: <52EA9AEB.5090606@cogentembedded.com>
Date:   Thu, 30 Jan 2014 21:33:15 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: mm: c-r4k: Detect instruction cache aliases
References: <52E93795.8000205@imgtec.com> <1391102489-1403-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1391102489-1403-1-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39196
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

On 01/30/2014 08:21 PM, Markos Chandras wrote:

> The *Aptiv cores can use the CONF7/IAR bit to detect if the core
> has hardware support to remove instruction cache aliasing.

> This also defines the CONF7/AR bit in order to avoid using
> the '16' magic number.

> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
[...]

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index 13b549a..8017f6e 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -1110,7 +1110,10 @@ static void probe_pcache(void)
>   	case CPU_PROAPTIV:
>   		if (current_cpu_type() == CPU_74K)
>   			alias_74k_erratum(c);
> -		if ((read_c0_config7() & (1 << 16))) {
> +		if (!(read_c0_config7() & MIPS_CONF7_IAR) &&
> +		    (c->icache.waysize > PAGE_SIZE))
> +				c->icache.flags |= MIPS_CACHE_ALIASES;

     Sigh, you forgot to "outdent" this statement by a tab... :-(

WBR, Sergei
