Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 04:11:27 +0100 (CET)
Received: from mail-pl0-x243.google.com ([IPv6:2607:f8b0:400e:c01::243]:45327
        "EHLO mail-pl0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeAPDLTaPhNz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 04:11:19 +0100
Received: by mail-pl0-x243.google.com with SMTP id p5so5089731plo.12;
        Mon, 15 Jan 2018 19:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mW0+lGzQK6wicHPE91EDn4KxDqEWEr7EPuzgcVMovkk=;
        b=ph0pm8yJvu/z2R8Mv00t2fo9z6m/5Ftwc7ZDodPQp09bYrBcXCshPcmEwEuSv2bO8z
         S61ICmM0aJy8hdDQ/1K5yhpmMYhbJytEaQFqY4FdhjaWb9esB1xlaAUIS6oqY68SxBy/
         h5Iq0+Fo+rrOwMDTTepDAwasijKwixii/SCH/JPC4cD4UK3uEXG1FQDsNOiLevfppev2
         1bwgrtOQqzfLSGJMP1JoXkYAMKe+WmmGk4/2tNSlK/qQkeJgZSimoQeToAF4XpWFmz3e
         S6fExsETF2aaXjdTOKHGQMnpOCLz/sAfDp+Vn+6DfdxJODHR5D0r+VvT8XVcTg7caGMC
         C5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mW0+lGzQK6wicHPE91EDn4KxDqEWEr7EPuzgcVMovkk=;
        b=r1HYqjaeDCdtEMXf28Gg4SZRruslC+Mtc9K+guPACVoKR9yjaMAxOd1yZ4JlRkSdVi
         NtqvA0xn1R/q4uabHbsfWO03avkcOYbZDDlwAzuQRcA+LmJL2graKaU+U8E4PdvdKJTa
         KI1yG2eLzDIYLNW8gphqvk0MH1Z7gF2oTHSaQdMP7bdcrLHmeT04bHVV743M/Y1bM+5V
         LFwWnQwOyaQIX05RkpkDITsbscasc+snaXEWB0Ru81SQsc9l7hzSSmR+zt0A4XRDi3PZ
         JcjXNb5Cb+nHxDVyxEUJqX06OAbm0+fhcN2vphHNKN2UWSXun+Vk8+u2PRV/nMF0s79U
         SFYg==
X-Gm-Message-State: AKGB3mLgKPOpx44/9PK1a4MTNGZ6GCvPEJ/9j+r4iem0fsVD3Lqr/oNv
        iKPHGOXdnOZJZ0qtS2/c2G46nQ==
X-Google-Smtp-Source: ACJfBoulIf3Hw8rxMzvjNoavm5MJ713DrgU9k8WwPQD+FrLtTLmj+K4ndT+IOtotO0moBGc9P0SS/w==
X-Received: by 10.84.131.79 with SMTP id 73mr37736981pld.405.1516072270901;
        Mon, 15 Jan 2018 19:11:10 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w27sm963558pge.54.2018.01.15.19.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 19:11:10 -0800 (PST)
Subject: Re: [PATCH for-4.15] ssb: Disable PCI host for PCI_DRIVERS_GENERIC
To:     James Hogan <jhogan@kernel.org>, Michael Buesch <m@bues.ch>,
        linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
References: <20180115211714.24009-1-jhogan@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3fcbf2f9-bc54-36a6-51ef-26c070c1aa69@roeck-us.net>
Date:   Mon, 15 Jan 2018 19:11:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180115211714.24009-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 01/15/2018 01:17 PM, James Hogan wrote:
> Since commit d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type
> as generic") changed the default MIPS platform to the "generic"
> platform, which uses PCI_DRIVERS_GENERIC instead of PCI_DRIVERS_LEGACY,
> various files in drivers/ssb/ have failed to build.
> 
> This is particularly due to the existence of struct pci_controller being
> dependent on PCI_DRIVERS_LEGACY since commit c5611df96804 ("MIPS: PCI:
> Introduce CONFIG_PCI_DRIVERS_LEGACY"), so add that dependency to Kconfig
> to prevent these files being built for the "generic" platform including
> all{yes,mod}config builds.
> 
> Fixes: c5611df96804 ("MIPS: PCI: Introduce CONFIG_PCI_DRIVERS_LEGACY")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Michael Buesch <m@bues.ch>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-wireless@vger.kernel.org
> Cc: linux-mips@linux-mips.org

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/ssb/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
> index d8e4219c2324..71c73766ee22 100644
> --- a/drivers/ssb/Kconfig
> +++ b/drivers/ssb/Kconfig
> @@ -32,7 +32,7 @@ config SSB_BLOCKIO
>   
>   config SSB_PCIHOST_POSSIBLE
>   	bool
> -	depends on SSB && (PCI = y || PCI = SSB)
> +	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
>   	default y
>   
>   config SSB_PCIHOST
> 
