Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2015 21:06:37 +0100 (CET)
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33605 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011500AbbKDUGfv8sWt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2015 21:06:35 +0100
Received: by lfbf136 with SMTP id f136so47586849lfb.0
        for <linux-mips@linux-mips.org>; Wed, 04 Nov 2015 12:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=IWIw28zkizcPeYsFtMegb0d5MjLd6Zll/nSfMewGBtY=;
        b=EaBpoRdIiFv6kK/yjNvQ/UpFhM4RrHMhdap60q5eh6nb8gsIBtzapvliZXT8qTxUe6
         0TxMAUfAnSuSHrv2XoExBcgm21ADbVy2gqoCMDJIwL4Btu2VU0WdzA7VchEQVqE5Un3R
         DDQZFlvMVQCyhGgGFtpkut+BfGXm9TIh9rxlJRohidgKrx1gN0h0ubi/COyWg4iv8VXK
         jqNlkm56+bI+3xNz68/Nt4Z4U+L90RFaHKe1myGyOIASRSeCIKmmGfMVuJl6/q3WWTon
         DG/XAhT3lvFa/9tbC8zlTbHQtsp43gSLwf+NzxEdCDEsu5PuoQpkrYx6hLSPD+gXLfGX
         Ph2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=IWIw28zkizcPeYsFtMegb0d5MjLd6Zll/nSfMewGBtY=;
        b=TOI5W2eeJln/XJ/3pX6PmU0Y4qByhIS94THDm017b/4YImW7Kr6pNxjnKhfynJtIK9
         IXd4snRRIUTP4z+WZVxDHlhnEgoSUtrUmfQ2bUQH6GdT3b3qDhnhKMT28V4lGcicLm0L
         L3BQhhDRt6aWNSjrx/bsZczgUY71zgdlk6wPInXDgZnwmkjn8+1fXI6L+oml23kGbZe/
         UZ2bd2JY1dEv+/C9iwCPt7t/Y54NAWwrqD0JKpchY5XeVtkUdmnmOMSlAvhhv1o7h3ig
         ZIj5i6UA0bXkrXAxgNwpfo8dl+3tjhWKWXpH0PNP/d4TutkNObx/+zBoEfbnmIiQT9Nz
         rTbQ==
X-Gm-Message-State: ALoCoQlOaksoyIv/TzzjWDwGRs1WJCUp1WqT+AS2cnahrR/PCBjU4yjjBLPX3mxCIxr4uOC4eBUc
X-Received: by 10.25.28.131 with SMTP id c125mr679565lfc.99.1446667590326;
        Wed, 04 Nov 2015 12:06:30 -0800 (PST)
Received: from [192.168.4.126] ([31.173.80.130])
        by smtp.gmail.com with ESMTPSA id r77sm5899205lfr.30.2015.11.04.12.06.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2015 12:06:29 -0800 (PST)
Subject: Re: [PATCH 4/4] arch: mips: lantiq: disable xbar fpi burst mode
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1446639256-22526-1-git-send-email-blogic@openwrt.org>
 <1446639256-22526-4-git-send-email-blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <563A6545.6000704@cogentembedded.com>
Date:   Wed, 4 Nov 2015 23:06:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1446639256-22526-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49842
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

On 11/4/2015 3:14 PM, John Crispin wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/lantiq/xway/sysctrl.c |   41 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index 2b15491..9147c4b 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
[...]
> @@ -179,6 +187,16 @@ static void pci_ext_disable(struct clk *clk)
>   	ltq_cgu_w32((1 << 31) | (1 << 30), pcicr);
>   }
>
> +static void xbar_fpi_burst_disable(void)
> +{
> +	u32 reg;
> +
> +	/* bit 1 as 1 --burst; bit 1 as 0 -- single */
> +	reg = xbar_r32(XBAR_ALWAYS_LAST);
> +	reg &= ~XBAR_FPI_BURST_EN;
> +	xbar_w32(reg, XBAR_ALWAYS_LAST);
> +}
> +
>   /* enable a clockout source */
>   static int clkout_enable(struct clk *clk)
>   {
> @@ -328,6 +346,26 @@ void __init ltq_soc_init(void)
>   	if (!pmu_membase || !ltq_cgu_membase || !ltq_ebu_membase)
>   		panic("Failed to remap core resources");
>
> +

    Why two empty lines?

> +	if (of_machine_is_compatible("lantiq,vr9")) {
> +		struct resource res_xbar;
> +		struct device_node *np_xbar =
> +		of_find_compatible_node(NULL, NULL,
> +			"lantiq,xbar-xway");

    This needs to be indented more to the right and empty line needs to be 
added afterwards.

> +		if (!np_xbar)
> +			panic("Failed to load xbar nodes from devicetree");
> +		if (of_address_to_resource(np_pmu, 0, &res_xbar))
> +			panic("Failed to get xbar resources");
> +		if (request_mem_region(res_xbar.start, resource_size(&res_xbar),
> +			res_xbar.name) < 0)
> +			panic("Failed to get xbar resources");
> +
> +		ltq_xbar_membase = ioremap_nocache(res_xbar.start,
> +		resource_size(&res_xbar));

    This line needs to be indented more to the right.

[...]

MBR, Sergei
