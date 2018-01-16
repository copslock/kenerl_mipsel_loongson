Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 04:10:50 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:45322
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeAPDKjnDr2z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 04:10:39 +0100
Received: by mail-pl0-x242.google.com with SMTP id p5so5088661plo.12;
        Mon, 15 Jan 2018 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CJhbew8hQEm7cMsSKvUxmuBdyoEjoh5xlCffVNEUDIc=;
        b=GD6cPom01kc6nOhQ5kDU/Qw57VIVMbSYf3EuVOno+AOlZfsMLhEQR6dGy+8RP0wxsJ
         Ad4KUqIvrTSDQBnFZbcoo0zHXdR/Ao50SOXTFXv+hP1UpOdnprIObs6KUdXhYVFEp0bP
         dz2NkUTJ1jxTHn5VoGpvxzzkoX/gtg8giwdqLmz31AK5HyQrB3PkDpPHZJ2uFwzmPMhn
         tHMlMzTFS0pSJKGUIi2WfJPG7J33uIWaNWrGMHOZ+y0HklVFwn0UhQeQ04lX/cosejqU
         ezOSvbc71F9+F4mtymALzx4f2DtueIekaG7fwDCk5UjgsViTjfv190QzLHMFucGXlUrI
         Xllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CJhbew8hQEm7cMsSKvUxmuBdyoEjoh5xlCffVNEUDIc=;
        b=I8uT1PGaiY62xgNaYnZ5PWFlDdLlc5MfYZFMv0oYXyx8rpkEjmDQmxpzswfr/iPLyk
         RSOaYeAW1BeICsSg69d7qN07PQBaTgJZ3lnLbI9dQae7lC4XRj9f3o5zcAR1SDOjMsqz
         WQAR1qq+OJjY/YfZGA66Xd2/Ml6Yd2sEnE1zphg0LiVRXRY3oqgQpKSTp7Hbm3Cd31Bh
         yASN/Rku+3WSJaAD09tBwomn+o3nPG5eA7fmHBsYpz2vP6g79+izAO9+UpylLu1jA6IT
         Lyxsy3yhGeTx01K/OTWNYfyzi802BI6D4eZfjqhaqfDSp7v/16oZ6WDVTB4SA9HvuqiT
         KwAQ==
X-Gm-Message-State: AKGB3mJWyuo/wnjZSo3NTiLtcLSN4B5axawltASc9y1pD2i+Ox5tGpdU
        TBOHyj70ILyO1oW1CCoskE8=
X-Google-Smtp-Source: ACJfBovGV3I7z//HY0JOMpbfKKNvuX4VOTosZkmxnEdwcrltqLHV5HksSLHqlkHBvwfCqFSrq94NMA==
X-Received: by 10.84.248.151 with SMTP id q23mr26034711pll.274.1516072233229;
        Mon, 15 Jan 2018 19:10:33 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 15sm1159119pfi.97.2018.01.15.19.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 19:10:32 -0800 (PST)
Subject: Re: [PATCH for-4.15] MIPS: Fix undefined reference to
 physical_memsize
To:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     John Crispin <john@phrozen.org>, Hauke Mehrtens <hauke@hauke-m.de>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>
References: <20180115205435.8745-1-jhogan@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <dcf989dc-9956-cdfe-c096-3438acfc41b3@roeck-us.net>
Date:   Mon, 15 Jan 2018 19:10:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180115205435.8745-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62152
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

On 01/15/2018 12:54 PM, James Hogan wrote:
> Since commit d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type
> as generic") switched the default platform to the "generic" platform,
> allmodconfig has been failing with the following linker error (among
> other errors):
> 
> arch/mips/kernel/vpe-mt.o In function `vpe_run':
> (.text+0x59c): undefined reference to `physical_memsize'
> 
> The Lantiq platform already worked around the same issue in commit
> 9050d50e2244 ("MIPS: lantiq: Set physical_memsize") by declaring
> physical_memsize with the initial value of 0 (on the assumption that the
> actual memory size will be hard-coded in the loaded VPE firmware), and
> the Malta platform already provided physical_memsize.
> 
> Since all other platforms will fail to link with the VPE loader enabled,
> only allow Lantiq and Malta platforms to enable it, by way of a
> SYS_SUPPORTS_VPE_LOADER which is selected by those two platforms and
> which MIPS_VPE_LOADER depends on. SYS_SUPPORTS_MULTITHREADING is now a
> dependency of SYS_SUPPORTS_VPE_LOADER so that Kconfig emits a warning if
> SYS_SUPPORTS_VPE_LOADER is selected without SYS_SUPPORTS_MULTITHREADING.
> 
> Fixes: d41e6858ba58 ("MIPS: Kconfig: Set default MIPS system type as generic")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: John Crispin <john@phrozen.org>
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Matt Redfearn <matt.redfearn@imgtec.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-mips@linux-mips.org

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/mips/Kconfig | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 659e0079487f..8e0b3702f1c0 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -390,6 +390,7 @@ config LANTIQ
>   	select SYS_SUPPORTS_32BIT_KERNEL
>   	select SYS_SUPPORTS_MIPS16
>   	select SYS_SUPPORTS_MULTITHREADING
> +	select SYS_SUPPORTS_VPE_LOADER
>   	select SYS_HAS_EARLY_PRINTK
>   	select GPIOLIB
>   	select SWAP_IO_SPACE
> @@ -517,6 +518,7 @@ config MIPS_MALTA
>   	select SYS_SUPPORTS_MIPS16
>   	select SYS_SUPPORTS_MULTITHREADING
>   	select SYS_SUPPORTS_SMARTMIPS
> +	select SYS_SUPPORTS_VPE_LOADER
>   	select SYS_SUPPORTS_ZBOOT
>   	select SYS_SUPPORTS_RELOCATABLE
>   	select USE_OF
> @@ -2282,9 +2284,16 @@ config MIPSR2_TO_R6_EMULATOR
>   	  The only reason this is a build-time option is to save ~14K from the
>   	  final kernel image.
>   
> +config SYS_SUPPORTS_VPE_LOADER
> +	bool
> +	depends on SYS_SUPPORTS_MULTITHREADING
> +	help
> +	  Indicates that the platform supports the VPE loader, and provides
> +	  physical_memsize.
> +
>   config MIPS_VPE_LOADER
>   	bool "VPE loader support."
> -	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
> +	depends on SYS_SUPPORTS_VPE_LOADER && MODULES
>   	select CPU_MIPSR2_IRQ_VI
>   	select CPU_MIPSR2_IRQ_EI
>   	select MIPS_MT
> 
