Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 12:12:36 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:46455 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491161Ab0GNKMc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jul 2010 12:12:32 +0200
Received: by iwn40 with SMTP id 40so7875527iwn.36
        for <linux-mips@linux-mips.org>; Wed, 14 Jul 2010 03:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LvEsJMwqbSTcg/hnFK5oDwPF2gJXX9w+PijR5kBwJTU=;
        b=C7SVrSQXwEH5WRq/mmO6GLW0tRCZ9l3lFGASTSSkZ+HubpY39mLQ6oqcD6bff1zcZx
         4N7M079WoPGyZIjscJTCAVDXrQvkFUWNucQfASykNOt4eRhfko4XOaPlJAIeBPyyDNmQ
         48sGU4wOlQycOvVinOPJOei3TlwKHdYTHPFg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=n1QTzl6g6pRtcJIX97+69PvVUNusfBuN5g2RD7eSwIVO8wOk8k4NAK+kaVA0+Q6aMX
         3qqWUk/mlfXptSYUBZPtP+WlEt5f6fznHglhRaNOSRvGCynxNXyzj7FI9mGrcPyuyoQc
         SYKhvCnSi5TgPFhXpEKmV+HIppVSlZ1d+vPzc=
MIME-Version: 1.0
Received: by 10.231.182.204 with SMTP id cd12mr5558026ibb.101.1279102351400; 
        Wed, 14 Jul 2010 03:12:31 -0700 (PDT)
Received: by 10.231.182.207 with HTTP; Wed, 14 Jul 2010 03:12:31 -0700 (PDT)
In-Reply-To: <1279101547-14498-1-git-send-email-wg@grandegger.com>
References: <1279101547-14498-1-git-send-email-wg@grandegger.com>
Date:   Wed, 14 Jul 2010 12:12:31 +0200
Message-ID: <AANLkTilE6ss4qBk43Dml6SLwUrzawAVtcMw69RrMT4RF@mail.gmail.com>
Subject: Re: [PATCH] mips/alchemy: add basic support for the GPR board
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Jul 14, 2010 at 11:59 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> From: Wolfgang Grandegger <wg@denx.de>
>
> This patch adds basic support for the General Purpose Router (GPR)
> board from Trapeze ITS.
>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> ---
>  arch/mips/Makefile                         |    6 +
>  arch/mips/alchemy/Kconfig                  |    9 +
>  arch/mips/alchemy/gpr/Makefile             |   11 +
>  arch/mips/alchemy/gpr/board_setup.c        |   97 ++
>  arch/mips/alchemy/gpr/init.c               |   63 +
>  arch/mips/alchemy/gpr/platform.c           |  185 +++
>  arch/mips/configs/gpr_defconfig            | 2062 ++++++++++++++++++++++++++++
>  arch/mips/include/asm/mach-au1x00/au1000.h |    2 +
>  8 files changed, 2435 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/alchemy/gpr/Makefile
>  create mode 100644 arch/mips/alchemy/gpr/board_setup.c
>  create mode 100644 arch/mips/alchemy/gpr/init.c
>  create mode 100644 arch/mips/alchemy/gpr/platform.c
>  create mode 100644 arch/mips/configs/gpr_defconfig
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 0b9c01a..6b81b9f 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -325,6 +325,12 @@ load-$(CONFIG_MIPS_MTX1)   += 0xffffffff80100000
>  libs-$(CONFIG_MIPS_XXS1500)    += arch/mips/alchemy/xxs1500/
>  load-$(CONFIG_MIPS_XXS1500)    += 0xffffffff80100000
>
> +#
> +# Trapeze ITS GRP board
> +#
> +libs-$(CONFIG_MIPS_GPR)                += arch/mips/alchemy/gpr/
> +load-$(CONFIG_MIPS_GPR)                += 0xffffffff80100000
> +

Have a look at the current mips-queue tree: theres a new way to hook up
boards with Platform files.


> --- a/arch/mips/include/asm/mach-au1x00/au1000.h
> +++ b/arch/mips/include/asm/mach-au1x00/au1000.h
> @@ -994,6 +994,8 @@ enum soc_au1200_ints {
>
>  #ifdef CONFIG_SOC_AU1550
>  #define UART0_ADDR             0xB1100000
> +#define UART1_ADDR             0xB1200000
> +#define UART3_ADDR             0xB1400000

Please don't add those back, I'm trying to get rid of them.  Use something
like "KSEG1ADDR(UART1_PHYS_ADDR)" in the init code where you enable
uarts 1 and 3.

Thanks!
        Manuel Lauss
