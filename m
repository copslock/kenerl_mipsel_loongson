Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2011 10:16:39 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:44034 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491004Ab1CAJQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2011 10:16:35 +0100
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 9F3ADC38;
        Tue,  1 Mar 2011 10:16:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id skVypyW5XrdL; Tue,  1 Mar 2011 10:16:29 +0100 (CET)
Received: from [192.168.123.148] (e177168005.adsl.alicedsl.de [85.177.168.5])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id AC66FC37;
        Tue,  1 Mar 2011 10:16:28 +0100 (CET)
Message-ID: <4D6CB9C4.8000609@metafoo.de>
Date:   Tue, 01 Mar 2011 10:17:56 +0100
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20101226 Icedove/3.0.11
MIME-Version: 1.0
To:     Maurus Cuelenaere <mcuelenaere@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Jz4740: Add HAVE_CLK
References: <4d6c2da3.cc7e0e0a.2116.ffffde18@mx.google.com>
In-Reply-To: <4d6c2da3.cc7e0e0a.2116.ffffde18@mx.google.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

On 03/01/2011 12:20 AM, Maurus Cuelenaere wrote:
> Jz4740 supports the clock framework but doesn't have HAVE_CLK defined, so define
> it!
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  arch/mips/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index f5ecc05..6199128 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -208,6 +208,7 @@ config MACH_JZ4740
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SYS_HAS_EARLY_PRINTK
>  	select HAVE_PWM
> +	select HAVE_CLK
>  
>  config LASAT
>  	bool "LASAT Networks platforms"
