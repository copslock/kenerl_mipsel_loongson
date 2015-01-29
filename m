Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 11:38:54 +0100 (CET)
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35555 "EHLO
        mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011293AbbA2KiwXOXCg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 11:38:52 +0100
Received: by mail-lb0-f169.google.com with SMTP id f15so26572938lbj.0
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 02:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Yg31nd+721ujoEFFIobBIWx/aeVIVO4aZBvE7TfwHHQ=;
        b=hGjiKbmNJFGBEQVp+UU21KWDRfZGBzcKAEJSgt1MTj1OY5epQR2p61OdsN1B8ZssM3
         R9CSS5OGaxE+IH1xj4doWM9tx8JVF5TsT7/2K55i+wjiJ1kyrgTyA/Baj2yxr74GPheH
         INSRnSKGVe4ylI5nyMZVknR8/67VdL+zEWff2wl/ITx6xfdEmmWXpp2hu2HD1budVZXq
         8mhF8DvCirCz/X31wfPLXSJP26Sta4P5zrrOBRPQC9s63LKxuto2RgeX3E/UBfxcYFc1
         KvxOJUX/L1g7a555DA0AVMuxrd7Ug1FOdElokFfdwSmOZjwjajWzRYaZPvQ83RE4ylp+
         ZcTA==
X-Gm-Message-State: ALoCoQk2p/BLWSue99Snx70I+odfmvS9TXSp9Lwr9yfK9dExWs4RExQuDDy6NmFP8Qt2btrroEyk
X-Received: by 10.152.3.195 with SMTP id e3mr13569444lae.8.1422527926911;
        Thu, 29 Jan 2015 02:38:46 -0800 (PST)
Received: from [192.168.3.68] (ppp83-237-255-144.pppoe.mtu-net.ru. [83.237.255.144])
        by mx.google.com with ESMTPSA id w3sm2027609lag.35.2015.01.29.02.38.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2015 02:38:45 -0800 (PST)
Message-ID: <54CA0DB4.6000006@cogentembedded.com>
Date:   Thu, 29 Jan 2015 13:38:44 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: preset loops_per_jiffy based on CPU
 clock
References: <1422525243-1756-1-git-send-email-manuel.lauss@gmail.com> <1422525243-1756-2-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1422525243-1756-2-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45522
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

On 1/29/2015 12:54 PM, Manuel Lauss wrote:

> This was lost during the rewrite of clock framework support.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
>   arch/mips/alchemy/common/clock.c | 6 ++++++
>   arch/mips/alchemy/common/setup.c | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
> index 428c9f0..680fbb6 100644
> --- a/arch/mips/alchemy/common/clock.c
> +++ b/arch/mips/alchemy/common/clock.c
> @@ -133,6 +133,12 @@ static unsigned long alchemy_clk_cpu_recalc(struct clk_hw *hw,
>   	return t;
>   }
>
> +void __init alchemy_set_lpj(void)
> +{
> +	preset_lpj = alchemy_clk_cpu_recalc(NULL, ALCHEMY_ROOTCLK_RATE);
> +	preset_lpj = preset_lpj / 2 / HZ;

    How about "preset_lpj /= 2 * HZ;"?

[...]
> diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
> index 4e72daf..2902138 100644
> --- a/arch/mips/alchemy/common/setup.c
> +++ b/arch/mips/alchemy/common/setup.c
> @@ -34,10 +34,12 @@
>   #include <au1000.h>
>
>   extern void __init board_setup(void);
> -extern void set_cpuspec(void);

    Not documented in the change-log?

> +extern void __init alchemy_set_lpj(void);
>
>   void __init plat_mem_setup(void)
>   {
> +	alchemy_set_lpj();
> +
[...]

WBR, Sergei
