Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 14:31:08 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:49111 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903633Ab2EQMbE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 May 2012 14:31:04 +0200
Message-ID: <4FB4EF81.10005@phrozen.org>
Date:   Thu, 17 May 2012 14:30:57 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dczhu@mips.com>
CC:     linux-mips@linux-mips.org, kevink@paralogos.com
Subject: Re: [PATCH v2 1/2] MIPS: fix/enrich 34K APRP (APSP) functionalities
References: <1337244680-29968-1-git-send-email-dczhu@mips.com> <1337244680-29968-2-git-send-email-dczhu@mips.com>
In-Reply-To: <1337244680-29968-2-git-send-email-dczhu@mips.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ce30e2f..8205afe 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1925,7 +1925,7 @@ config MIPS_MT_FPAFF
>  
>  config MIPS_VPE_LOADER
>  	bool "VPE loader support."
> -	depends on SYS_SUPPORTS_MULTITHREADING
> +	depends on SYS_SUPPORTS_MULTITHREADING && MIPS_MALTA

This would lead to the second user of the API having to patch this piece
of code to make it work.

You could introduce a ARCH_HAS_APRP which any platform can then select ?

I think it would also make sense to split changes to generic and malta
code into separate patches if that is possible.

Thanks,
John
