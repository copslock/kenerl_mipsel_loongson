Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2013 22:45:16 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:36768 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815753Ab3KHVpOJIQj- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Nov 2013 22:45:14 +0100
Received: by mail-ie0-f176.google.com with SMTP id x13so1602746ief.21
        for <multiple recipients>; Fri, 08 Nov 2013 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9+ibR8yu17NVlaGwx/7bqhkCKTUqkj8T1JsJZWij8iQ=;
        b=UHXLzXPZdksCbXN878XA+kfjP4OiSNYSca6YNSiy9QdSlB20S2GXJWDzhLFE+qt0GL
         bV+d9qYzl4BHsmS7O3+melm2NvBlhABLzccTMvQIKcr0fg5B8vGn+EBklnSSTyPIx0aw
         HnkkTz+SoB+PLY+O3gt0PnqfUKu4uIIcy2GHDeOr6dAKsYHnjzPDTv9o9ljT4hRJDP+O
         VO7ywkX6PoNbG2jGKG1I11U0GlUWIufV2MIPeV6KwzXT2yME3e9jJ/dgU1OKoIzOmrIG
         65FB/tPKK0H5XxLca5xw5I4Lxh//fDbmzC0u8RYwz/LxvfYmKdPAVDCoWESRNXagMTk3
         P0pw==
X-Received: by 10.43.106.198 with SMTP id dv6mr2942531icc.51.1383947107440;
        Fri, 08 Nov 2013 13:45:07 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id f19sm5152502igz.1.2013.11.08.13.45.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 13:45:06 -0800 (PST)
Message-ID: <527D5B61.7090105@gmail.com>
Date:   Fri, 08 Nov 2013 13:45:05 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nsn.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: fix out-of-bounds array access
References: <1383318364-30312-1-git-send-email-aaro.koskinen@nsn.com>
In-Reply-To: <1383318364-30312-1-git-send-email-aaro.koskinen@nsn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38492
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

On 11/01/2013 08:06 AM, Aaro Koskinen wrote:
> When booting with in-kernel DTBs, the pruning code will enumerate
> interfaces 0-4. However, there is memory reserved only for 4 so some
> other data will get overwritten by cvmx_helper_interface_enumerate().
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>

Thanks for finding this,  tested and ...

Acked-by: David Daney <david.daney@cavium.com>


Ralf:  Please apply.

Aaro: Suggest stable branches that this is a candidate for.

> ---
>
> 	v2: a new patch in the series
>
>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> index d63d20d..0e4b340 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
> @@ -67,7 +67,7 @@ void (*cvmx_override_pko_queue_priority) (int pko_port,
>   void (*cvmx_override_ipd_port_setup) (int ipd_port);
>
>   /* Port count per interface */
> -static int interface_port_count[4] = { 0, 0, 0, 0 };
> +static int interface_port_count[5];
>
>   /* Port last configured link info index by IPD/PKO port */
>   static cvmx_helper_link_info_t
>
