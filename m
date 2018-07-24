Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 15:12:25 +0200 (CEST)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:34771
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994002AbeGXNMVfyx9B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2018 15:12:21 +0200
Received: by mail-io0-x244.google.com with SMTP id l7-v6so3360920ioj.1;
        Tue, 24 Jul 2018 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8UIwKo3vKu34kwq38jTrg/7yVc2pABmsTxvJtRzXveo=;
        b=jCEGxpO0GlNOS1vR/jKZqK+wPOG409bYqubTA9ZXDj6vbU7jmmY8BKmQJykScHprDL
         0P0BIIMom03JpKJ25MSJ1isnoquHF8wVffClLw06SzHLVFvRtLh0KAhGyd1e4AdwlM5q
         afbXSzQp2J38Wd08g9IvT9SRitsv3fktofVJ7WMlYpjusRxlo+m/phAMCq4qKWdIQP6J
         V+qmZ40EkbhH5kn/7PQPBHtY0PSJhq5E9FnQIEratoPiwbBgAvIYAGuzqLMvizHfiZAU
         kXiDUCU4U2bt5cXU8kat0CgQdSyY2xrDWgnzyUBdAjQWTCNJZuGcDzlXJvHBLXMrne2N
         SVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8UIwKo3vKu34kwq38jTrg/7yVc2pABmsTxvJtRzXveo=;
        b=T1jUrga7lUW4e+1+RwCJbj/RwXrRlq7q7goi8slzR5GzwiZ3/NukM1KYAYdjuXyO14
         vucYFPEKLh4xUDfAlK6n84Rbbqe3bNoxRvd4adQS2Q6qGcYdhRTE+2RnMioPOLuSpZsR
         AgGA+DQmwdVRR1DQgzNlCCWNdrnEm0DTRR2U+4a3xgnZ4Fqkmb4XSuQu0NJIY3iHuWBW
         XiB3k0l0sIbdNbUrws0hE9h8b0jRavHf2bqgoseVPi4TFAscqaPL9jh0X0q8CFQl9Efp
         C5PLXCi34MpbCIhpXSz105j29jLw8QacmMWSjwwOQNyZ+SOnJhA5iPbl3IsD/9xyX/fh
         m8pA==
X-Gm-Message-State: AOUpUlFvPoWzKPq9SMDRVFm3LN5zHFrkBKBtXTOX8G9ThPcZYGsHvyjV
        Z0vg5nmD43+algRU/cCf/YY=
X-Google-Smtp-Source: AAOMgpfP4GYha/VGjZoGk4RUOMvkhkuEDtMOx2veKDawzN21GctPTlCZThqD6KQWIwDQlq1SW8d6Ig==
X-Received: by 2002:a6b:e913:: with SMTP id u19-v6mr13829627iof.38.1532437935249;
        Tue, 24 Jul 2018 06:12:15 -0700 (PDT)
Received: from [10.0.2.15] ([72.138.96.106])
        by smtp.gmail.com with ESMTPSA id z71-v6sm9037035ioz.34.2018.07.24.06.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 06:12:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] MIPS: Introduce HAS_RAPIDIO Kconfig option
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
References: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
From:   Alex Bounine <alex.bou9@gmail.com>
Message-ID: <46c35e1a-15df-f4e1-ae9e-cb87ffed9a7b@gmail.com>
Date:   Tue, 24 Jul 2018 09:12:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724123200.6588-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65080
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


On 2018-07-24 08:31 AM, Alexander Sverdlin wrote:
> Introduce the same option as PPC and ARM already have because
> RAPIDIO can function in the absence of PCI.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>   arch/mips/Kconfig | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a6ce5087b729..b7fa44ddf452 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3104,10 +3104,13 @@ config ZONE_DMA32
>   
>   source "drivers/pcmcia/Kconfig"
>   
> +config HAS_RAPIDIO
> +	bool
> +	default n
> +
>   config RAPIDIO
>   	tristate "RapidIO support"
> -	depends on PCI
> -	default n
> +	depends on HAS_RAPIDIO || PCI
>   	help
>   	  If you say Y here, the kernel will include drivers and
>   	  infrastructure code to support RapidIO interconnect devices.
> 
