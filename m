Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 15:12:45 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:43373
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994002AbeGXNMkIQkyB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 15:12:40 +0200
Received: by mail-io0-x244.google.com with SMTP id y10-v6so3352511ioa.10;
        Tue, 24 Jul 2018 06:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GgwQtccgEz32aiqUtyjX9WDU31Dc9dZljNEGG1zi+f4=;
        b=FGVLTX6eEuo5kNRqa+GlBwUmGMHkeImePkNPwmanK0jSzZ027IXxxQbzEL2rQf24hl
         +MNrd6eJGKMjVWZQJ9D2D0v6fkp1jYLYVqyHlzXckrPbJZzjEcy8JPw1y/hxRrcdeI9O
         DHiyKkQHGoKJZBhtIeANj0ta6Aw8Dj/snSq/xsptdpLZwm0Hfb/YoIfhmh2zU58Ld8aX
         KxMRJ0vcxJKn0dNaOCJcJSnLrim5v1KGr/Vez2oJ83cnlceCsvfkf1vgYEjXIuUHJ44a
         JcQugDgmKfjILOeOao6wuuJJB92UXZqcPRvB54GfwGijE77F/pbZdC0qguQeFiLKg1Ly
         +FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GgwQtccgEz32aiqUtyjX9WDU31Dc9dZljNEGG1zi+f4=;
        b=XRxmRtizgOgnyE3lnfCLTOBBZFK5Yi1kx1VQXP1sBD9viOrceHjg/GmaFhLe2rKsop
         pZVol7Slyit0h5//blSokUKTH2sWNoGEF5DOAkAMynyD2LfKDjkjQHlkzyYgK0Hr/Aa6
         yWGz1Wk6cbonKbB9rnWZd8rF/G1AFARyhlP5+073wU29XlkDhy04e+HwOqKR3ZsCnIos
         GHrvJeL46+/OFEgVxlVDPebjlI74Zmcrf6XenZCOzBQ8k8DB16SogekGl81YMvEnqH2Y
         1I/rDUu3UCvXSlx4a9nfceauYD0BXwnjcjAgrJiCdJBZ9O/3nQSg3baxv5XIZXWwIdkp
         jUqg==
X-Gm-Message-State: AOUpUlFU103+5m7sqkFH45hG+Aro/n2oAeadBsiJbzUPhtw7uuvmpang
        BlmsFu9HYyFlxKhlcP+t/+E=
X-Google-Smtp-Source: AAOMgpeX9gsvEQM+KkHZGYI4TNB0T+vbUvvGngXJaKbo1CoR0EvDQyzaVR/+jMmewKKIlU+7crPGTg==
X-Received: by 2002:a5e:da41:: with SMTP id o1-v6mr13853035iop.81.1532437954340;
        Tue, 24 Jul 2018 06:12:34 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id 82-v6sm1270965itm.2.2018.07.24.06.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:12:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] MIPS: Octeon: Select HAS_RAPIDIO
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
References: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
 <20180724123200.6588-2-alexander.sverdlin@nokia.com>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <98a14d92-ee18-57fd-81d3-f2a313664cdd@gmail.com>
Date:   Tue, 24 Jul 2018 09:12:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724123200.6588-2-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.bou9@gmail.com
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

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>

On 2018-07-24 08:32 AM, Alexander Sverdlin wrote:
> All Octeons starting with Octeon II have RAPIDIO controller which
> can function even with PCI disabled.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>   arch/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b7fa44ddf452..235feb657b0b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -890,6 +890,7 @@ config CAVIUM_OCTEON_SOC
>   	bool "Cavium Networks Octeon SoC based boards"
>   	select CEVT_R4K
>   	select ARCH_HAS_PHYS_TO_DMA
> +	select HAS_RAPIDIO
>   	select PHYS_ADDR_T_64BIT
>   	select SYS_SUPPORTS_64BIT_KERNEL
>   	select SYS_SUPPORTS_BIG_ENDIAN
> 
