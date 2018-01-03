Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2018 21:04:31 +0100 (CET)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38451 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbeACUEUR5PKa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2018 21:04:20 +0100
Received: by mail-ot0-f195.google.com with SMTP id h2so83803oti.5;
        Wed, 03 Jan 2018 12:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6UZvK6oWf/eqtH2dNayaEtvdNX29AtkFxJeEVpCdvA=;
        b=jFsDu8qpUcVQ0/3psRhsg7J3WuqG7VGgoQncY0yxuApke3Zx3uv3bah2TH9ed0CGir
         EFKKLkz1oWLc6iIh/hZuOEAbcB+P7xfeGLP8n5K8AWDUdaD/eJ/RYeh4fbLqLNamVESs
         PspmKxJ4OInnos87TGslCVHhHpSkZw12Ric+0R+91sK4zH/1nPqsr52mTUfUnhR57IR6
         0ngRWPY8mHrMXsL9q/XrAI7eM81WlJvJwB4qYl7XgImmXOBFHqaMazTRIHnbTYkIUTDq
         vof7QZLXTV24zSY9hWD0G1BjMVoTGXbPY3g6iAN3mjO6a4899THXpy8rOwkAC/pceZVV
         UanA==
X-Gm-Message-State: AKGB3mJwXyTuhimPbz/O4Zh9B2GIcFVsdqJnWrU9Wox2pDTgbrM6uVPC
        vSDPcDjHbzakdh/R3NGEQw==
X-Google-Smtp-Source: ACJfBosofqf1CEm1/H2kbvq3VU8AKCj4arroJIqEdGWfuEzhrYrSkKQydh0iiesay4EdzoyZsW2EPA==
X-Received: by 10.157.66.182 with SMTP id r51mr1669937ote.32.1515009854429;
        Wed, 03 Jan 2018 12:04:14 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id n13sm723581ota.70.2018.01.03.12.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 12:04:13 -0800 (PST)
Date:   Wed, 3 Jan 2018 14:04:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 2/2] dts: Probe efuse for CI20
Message-ID: <20180103200413.cpv6wxeeumaw62l5@rob-hp-laptop>
References: <20171228212954.2922-1-malat@debian.org>
 <20171228212954.2922-3-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228212954.2922-3-malat@debian.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Thu, Dec 28, 2017 at 10:29:53PM +0100, Mathieu Malaterre wrote:
> MIPS Creator CI20 comes with JZ4780 SoC. Provides access to the efuse block
> using jz4780 efuse driver.
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/mips/configs/ci20_defconfig | 2 ++

Your subject indicates this is a dts patch which it is not.

>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
> index b5f4ad8f2c45..62c63617e97a 100644
> --- a/arch/mips/configs/ci20_defconfig
> +++ b/arch/mips/configs/ci20_defconfig
> @@ -171,3 +171,5 @@ CONFIG_STACKTRACE=y
>  # CONFIG_FTRACE is not set
>  CONFIG_CMDLINE_BOOL=y
>  CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
> +CONFIG_NVMEM=y
> +CONFIG_JZ4780_EFUSE=y
> -- 
> 2.11.0
> 
