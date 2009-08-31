Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 08:32:03 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:47372 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492097AbZHaGb5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Aug 2009 08:31:57 +0200
Received: by fxm20 with SMTP id 20so2886836fxm.0
        for <multiple recipients>; Sun, 30 Aug 2009 23:31:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M7CwZi5dIDli3IxTef/LkapomLp4M81vjulAo9lt1xw=;
        b=eoPGJ22A4HUbetl9jdwxSHGEnd3lyXNfULUXdr061SHOf2GnjZ7TLzmAgkYTgOeRVO
         CGw4oM5eyyTWej999fpLbwRWRklJlrArR8PsQEgV/MlnnsZKO9h8TfsHpQ/2NjeWtVnd
         a+RAi86tAqD6nmpKCT1Ytz23PsYBxG31PTvpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LRE+DLcOrNtvpMCpZSOusA9d54p4wkCoEuTYX+iO2jA/WZ4ryoln81Jdu6OgBO6Vug
         hPBMvW31yi8fdSAMpmVPulhCMFl2fwqCRbcaZs69GVDNqiZmboHGIBLMQaEd/11AxVOo
         wRkwbCTPSve8YEz3t7zKrglwKxksHAoTynWF8=
MIME-Version: 1.0
Received: by 10.223.3.137 with SMTP id 9mr1434740fan.45.1251700308665; Sun, 30 
	Aug 2009 23:31:48 -0700 (PDT)
In-Reply-To: <200908170028.27210.florian@openwrt.org>
References: <200908170028.27210.florian@openwrt.org>
Date:	Mon, 31 Aug 2009 08:31:48 +0200
Message-ID: <f861ec6f0908302331p7f44a584pdae29cafce7ef950@mail.gmail.com>
Subject: Re: [PATCH 1/2] au1000: fix build failure for db1x00 configured for 
	Au1100 SoC
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

Please add Florian's patch below to your patchqueue!

On Mon, Aug 17, 2009 at 12:28 AM, Florian Fainelli<florian@openwrt.org> wrote:
> Hi Ralf,
>
> This patch should apply to both -master and -queue. Thanks !
> --
> From: Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH 1/2] au1000: fix build failure for db1x00 configured for Au1100 SoC
>
> This patch fixes the following warning, which becomes an error due to
> -Werror to be turned on:
>  CC      arch/mips/alchemy/common/gpiolib-au1000.o
> cc1: warnings being treated as errors
> arch/mips/alchemy/common/gpiolib-au1000.c: In function 'au1100_gpio2_to_irq':
> /home/florian/dev/kernel/linux-queue/arch/mips/include/asm/mach-au1x00/gpio-au1000.h:107: warning: control reaches end of non-void function
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> index 127d4ed..4d54d40 100644
> --- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
> @@ -104,6 +104,8 @@ static inline int au1100_gpio2_to_irq(int gpio)
>
>        if ((gpio >= 8) && (gpio <= 15))
>                return MAKE_IRQ(0, 29);         /* shared GPIO208_215 */
> +
> +       return -ENXIO;
>  }
>
>  #ifdef CONFIG_SOC_AU1100


Thanks!

     Manuel Lauss
