Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Feb 2016 00:11:32 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36546 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012297AbcBVXLakilCQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Feb 2016 00:11:30 +0100
Received: by mail-pa0-f41.google.com with SMTP id yy13so98529011pab.3;
        Mon, 22 Feb 2016 15:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=W7kyYdXPb/jJT509CzOKl0KNhmg9kFXeIKRD5jje3QE=;
        b=Yc7vbpRdPuOllbQtlEQXc8vcEidQNvXS9nr63idmwcPOXf8KednvIAQrQ/ENbHldYj
         PDtgXAuL5FvXcBuFad/yNAgZyflxN3L4qPB+hT8XfTFIpHcvyTVILXnQUL85PPho3db4
         YO93kgCnocgPgxyx9oR06oVsESBNDgTrhnD0+JIRVOmmp5qWR6Q73ggSGW1ALLSoVWFc
         D06zS1cwvqteU7EZkE98kIx+P5KMpKRl81ipiPGugROvyALjIrdiuK9RHtlsKXfwmY80
         7s9/vXEoUKnug2KolCsD26Aw8YMXx/fW6xBIuzDK2kCNNNQK2iAGI1WBmsDZ4G18Bzo/
         Icmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=W7kyYdXPb/jJT509CzOKl0KNhmg9kFXeIKRD5jje3QE=;
        b=ItmtWyvQKfDzFAwjN1rwNGfABfMBsoeghDI/lDikwbMGv7h6EVJfh196Swso2iBdl1
         32qu7QPeDpbnjKgq6iqMOheVKlnVjpS8SPQyHM/lBeyI8LVlCRUYB3za73FANWBA6ppw
         DEhuSPi+imoesd5wXrbvTzHarnnBxILYH9R38L+7HZW7azJ9la66bCJ9g1Ae/TGlsXjf
         NtuPIr3rCkDj4nAj5Hm4kDapcLHRvjl08OHBxfMciYRr2/SL31ai9x0o4zbxhUdU7mIb
         tkuMNJI9z4LuSJenwYTwBBkxs7XmXZNBAiRn7uCJPjrJ0oVdp1bDaujZfDAyFRVFXosw
         Pj7A==
X-Gm-Message-State: AG10YOSFecuJPlM3GQATttiKELTbcN0sLzlmLpzznCugh8X2+9qVabzvXr0uVDMM2ICYyw==
X-Received: by 10.66.159.136 with SMTP id xc8mr41948067pab.71.1456182684675;
        Mon, 22 Feb 2016 15:11:24 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id v29sm39266975pfa.31.2016.02.22.15.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 15:11:23 -0800 (PST)
Subject: Re: [PATCH 2/3] MIPS: OCTEON: device_tree_init: don't fill mac if
 already set
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
References: <1456180788-6803-1-git-send-email-aaro.koskinen@iki.fi>
 <1456180788-6803-3-git-send-email-aaro.koskinen@iki.fi>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56CB954F.1070504@gmail.com>
Date:   Mon, 22 Feb 2016 15:10:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1456180788-6803-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 22/02/16 14:39, Aaro Koskinen wrote:
> Don't fill MAC address if it's already set. This allows DTB to
> override the bootinfo.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index a7d9f07..c5de792 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -525,10 +525,19 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
>  
>  static void __init octeon_fdt_set_mac_addr(int n, u64 *pmac)
>  {
> +	const u8 *old_mac;
> +	int old_len;
>  	u8 new_mac[6];
>  	u64 mac = *pmac;
>  	int r;
>  
> +	old_mac = fdt_getprop(initial_boot_params, n, "local-mac-address",
> +			      &old_len);
> +	if (!old_mac || old_len != 6 || old_mac[0] || old_mac[1] ||
> +					old_mac[2] || old_mac[3] ||
> +					old_mac[4] || old_mac[5])

There is nothing that tells you that these are valid MAC addresses
though, although unlikely, the FW could be handing you bad addresses,
might be better to use is_valid_ether_addr() here?
-- 
Florian
