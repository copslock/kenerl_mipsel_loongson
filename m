Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 15:42:40 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:58588 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904291Ab1KJOme (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 15:42:34 +0100
Message-ID: <4EBBF0DA.3090602@phrozen.org>
Date:   Thu, 10 Nov 2011 16:42:18 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: lantiq: Fix compile error in arch/mips/lantiq/xway/dma.c
References: <1320938762-3472-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1320938762-3472-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 31501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9357

Hi Ralf,

please ignore this patch, i will resend a different version that
replaces module.h with export.h
for all arch/mips/lantiq/ files.

thanks,
John

On 10/11/11 16:26, John Crispin wrote:
> include/export.h needs to be included by arch/mips/lantiq/xway/dma.c.
> Without this include we see the following errors.
>
> arch/mips/lantiq/xway/dma.c:76:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:76:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:76:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:88:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:88:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:88:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:100:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:100:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:100:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:113:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:113:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:113:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:126:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:126:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:126:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:164:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:164:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:164:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:179:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:179:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:179:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:190:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:190:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:190:1: error: parameter names (without types) in function declaration
> arch/mips/lantiq/xway/dma.c:215:1: error: data definition has no type or storage class
> arch/mips/lantiq/xway/dma.c:215:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
> arch/mips/lantiq/xway/dma.c:215:1: error: parameter names (without types) in function declaration
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
>
> ---
>  arch/mips/lantiq/xway/dma.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
> index 4278a45..cbb6ae5 100644
> --- a/arch/mips/lantiq/xway/dma.c
> +++ b/arch/mips/lantiq/xway/dma.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/export.h>
>  
>  #include <lantiq_soc.h>
>  #include <xway_dma.h>
