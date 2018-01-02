Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 13:02:14 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:40321
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeABMCFlnd-a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 13:02:05 +0100
Received: by mail-wm0-x241.google.com with SMTP id f206so60417872wmf.5
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NTaP5TE/IZt0fsupM4Ew9Fvyxf2H6a2+3VLLHVAt/XU=;
        b=SHjVN9fQeREkyrkx6sRtghKXB4dYP2X3uFdVpkPLXOcc5Vf9NZbJjK9xIDF+CD3suX
         bZzTjI2QhoSLRYpOo4DJFJLa/UC3pTkslneI8GVKpWqubmBtIOHRh20VPgFb2/oWeuEV
         uFKN5mEwXSWq+JhXMNK36w0Nxo4xWVHHELHb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NTaP5TE/IZt0fsupM4Ew9Fvyxf2H6a2+3VLLHVAt/XU=;
        b=pADiNBsUviCZz4Es7oKKsiJPBsQHXTJcPR2v+r6NHq3ySWCPvann35FQ0WxIRhjrHD
         R3fK8mGRFv7+5vWdHxHybNiYIs3pM1z/fvFYQf83t4IKvhRl4CJ2CX5ZPRA5kltR/Vnu
         +jfplcXFHSh4J10Gtq8qX/CbJVSzxoUF1BZAbCehsMw5rKyOl5J+oYEopC/jTJHA24kR
         dORp/UjooFom5OC6HpMkFaXrYgunvGyu9Z9mmCZuegcWv4IcV7mjugIXUCrr9FTJvpnh
         xoAeyJHaVr1j7PXIPrfWDhFrg2wiZAyKzTOy+Fzq9gqOpPWXAoplN3GpPm2C4CQEnZrQ
         b+Ag==
X-Gm-Message-State: AKGB3mLxHqFZQTpgbZcfR8bwjn0HskgV0N4AkcWAEFzmw5uk/c5gMiFg
        YqpYZP2aXn48qlQ9LhMaQmcAh0O1RU4=
X-Google-Smtp-Source: ACJfBoslAkUp7qg5sUzjii3YEoJSIcjJtvnllL+HFOoJ3QgIndO918IaE8w7EHP4k0lMAWWC4uyovw==
X-Received: by 10.80.212.27 with SMTP id t27mr60634317edh.89.1514894520086;
        Tue, 02 Jan 2018 04:02:00 -0800 (PST)
Received: from [192.168.0.20] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id x5sm34055255eda.8.2018.01.02.04.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 04:01:59 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Add efuse driver for Ingenic JZ4780 SoC
To:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20171228212954.2922-1-malat@debian.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <828981e5-c23c-8dc4-55e4-23b65b33908b@linaro.org>
Date:   Tue, 2 Jan 2018 12:01:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171228212954.2922-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <srinivas.kandagatla@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srinivas.kandagatla@linaro.org
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



On 28/12/17 21:29, Mathieu Malaterre wrote:
> This patchset bring support for read-only access to the JZ4780 efuse as found
> on MIPS Creator CI20.
> 
> To keep the driver as simple as possible, it was not possible to re-use most of
> the nvmem core functionalities. This driver is not compatible with the original
Can you explain a bit more on not able to re-use nvmem core?

If you are referring to adding nvmem cell entires in sysfs, This should 
probably go in to nvmem core, rather that in individual providers.
This is one of the feature my todo list, will try to come up with some 
thing soon.

thanks,
srini

> efuse driver as found in the custom linux kernel from upstream (1), in
> particular it does not expose to the users neither:
> `/sys/devices/platform/*/chip_id` nor `/sys/devices/platform/*/user_id`.
> 

> The goal of this driver is to provide access to the MAC address to the dm9000
> driver.
> 
> (1) https://github.com/ZubairLK/CI20_linux/commit/6efd4ffca7dcfaff0794ab60cd6922ce96c60419
> 
> Changes in v2:
> Properly handle offset and byte value from the main entry point.
> Also add a commit message in patch #2.
> 
> Mathieu Malaterre (1):
>    dts: Probe efuse for CI20
> 
> PrasannaKumar Muralidharan (1):
>    nvmem: add driver for JZ4780 efuse
> 
>   .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
>   .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
>   MAINTAINERS                                        |   5 +
>   arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
>   arch/mips/configs/ci20_defconfig                   |   2 +
>   drivers/nvmem/Kconfig                              |  10 +
>   drivers/nvmem/Makefile                             |   2 +
>   drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
>   8 files changed, 385 insertions(+), 12 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>   create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>   create mode 100644 drivers/nvmem/jz4780-efuse.c
> 
