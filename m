Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 02:33:53 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:41931
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993107AbeGTAduFXkgx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 02:33:50 +0200
Received: by mail-qt0-x242.google.com with SMTP id e19-v6so8896061qtp.8;
        Thu, 19 Jul 2018 17:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gJjaQCmidxLoGVvn6IwVvpfqGCdJoLW+smhMdPEzz1M=;
        b=dgzajuVyX4NslCyBFR/Il8a73p4aFGNQIXYcn7fC4yRn94geDXSzW+6H/pDzihU9ln
         lr+JwTBuHTiiJlkwX5IHNUVuCIPb2oC9domJ3hmjM8cS2kTYicTgIgS5ehXnlfDePqdo
         n/oiQgBGitkTSFcHVkN3m5WL9cvDPKSmHzCyUPrCqbzC2mtWkLijkNNFY57TuEQ+qler
         /TxM8uuq6SgIoUAB+jaR5t7VhRwqGjXf+lHlr8G7D6j3GTDHPGAmaK1HUKNLzYzOR15S
         wP6AwI3zPhosC+vBdyCYUuQJ2t3x7FTiQblD03HaPv+BqXpqQsn5+e6xuB8S8z4rwOtt
         m2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gJjaQCmidxLoGVvn6IwVvpfqGCdJoLW+smhMdPEzz1M=;
        b=Mn3c9sLeq5IWs5jXcLMTeuw/fYkB8z5O38CBniOB4prc0TUnApwsjJIspKn+mQ1Pvu
         VD12vCOdecc68qSCh1NPd8nMRSEIXtH9ezAtf1yXVC0NYjnpsT38qUS/8jelvcPn8BUr
         rQNMZ6B0bp5j5RE55WjU0eey8Puaoniy8AUJXa4v4PZ/o0qzMv2J1+icjk2v3sZZS4xD
         G5S0T5bSYE4M+DWXwUJiT0WwM15V6Jp6TS9bQzZZD81qq6JxMxml+NvexK75AsPdz24P
         EvAth5sW7po7boT6UnSxIsSupQngESQChJSBpR/dp7BcLv78bbbTOEeVTGWU0+96raRt
         E2iQ==
X-Gm-Message-State: AOUpUlFeQ5fFZK81xswrdboR+NKvvlIKotBAiolEJqZeCMyjHl6NKMrG
        lcUmvO4twCQoM0f0cbaEIGA=
X-Google-Smtp-Source: AAOMgpeywteAB5ett3pUytJwqLKmF23SPfawvMTd6B+gtxFI44XglJeemX1NCNVjrxAFlRmOvpeTNg==
X-Received: by 2002:a0c:c602:: with SMTP id v2-v6mr12944591qvi.31.1532046823884;
        Thu, 19 Jul 2018 17:33:43 -0700 (PDT)
Received: from [10.0.2.15] (CPEac9e17937810-CM64777dd8e660.cpe.net.cable.rogers.com. [99.245.240.231])
        by smtp.gmail.com with ESMTPSA id k5-v6sm273892qke.92.2018.07.19.17.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 17:33:43 -0700 (PDT)
Subject: Re: [PATCH] mips: rapidio: Drop dependency on PCI
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Porter <mporter@kernel.crashing.org>
References: <20180713135132.1066-1-alexander.sverdlin@nokia.com>
From:   Alexandre Bounine <alex.bou9@gmail.com>
Message-ID: <5639e809-6ebe-14a3-d784-26b8df176f23@gmail.com>
Date:   Thu, 19 Jul 2018 20:33:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180713135132.1066-1-alexander.sverdlin@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <alex.bou9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64953
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



On 2018-07-13 09:51 AM, Alexander Sverdlin wrote:
> Cavium Octeon is an example of the SoC where RAPIDIO works without PCI.
> So drop the unnecessary dependency.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>   arch/mips/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 08c10c518f83..ac8a63d02391 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -3117,7 +3117,6 @@ source "drivers/pcmcia/Kconfig"
>   
>   config RAPIDIO
>   	tristate "RapidIO support"
> -	depends on PCI
>   	default n
>   	help
>   	  If you say Y here, the kernel will include drivers and
> 
Please consider using approach similar to config options in arch/powerpc 
branch (search for HAS_RAPIDIO). This will allow better handling of SoC 
configurations, e.g. forcing built-in code instead of building a module.
Also it will keep the same style for supported architectures. ARM uses 
the same as well - patch is on its way.
