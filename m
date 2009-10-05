Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Oct 2009 11:44:16 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:65193 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493142AbZJEJoK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Oct 2009 11:44:10 +0200
Received: by bwz4 with SMTP id 4so2381910bwz.0
        for <multiple recipients>; Mon, 05 Oct 2009 02:44:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d/6TZstbmcQRfxHEQTZNOtP9jmSaVJabB10uzNQH3mw=;
        b=FPq+uM5zqvAsJDb0TBPmUmv0IbRClyCYJ+J7A3zOmB05O/ezUiPlgkVqpWFJSKeWBH
         kx1wysFL/jsBWk/2QS1SWJ7H2endonnyzi0JHs+uOvle9hdWiQCvTGJCqqr1h+VeCf10
         lRqmc5K1KlhjtXHWl7vWqhCu2yFUNatZYxTAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NVq4X0Vb8J4lz3tKOOni6/CyS/lIuDGQrZA+1u2Y+ca25fpu15PljWIYG1D4cZuECk
         CS9b7mdETZU1GmN1JWW6BgeXlwdxSSaslvU1lt9EZ3BNT2j4Jq0PbLaMV4xQnC2EsImX
         JC+eqriqAFkHwQA+EXLD+FMhwdp2Poe2vrC8E=
MIME-Version: 1.0
Received: by 10.102.197.11 with SMTP id u11mr1619967muf.97.1254735844252; Mon, 
	05 Oct 2009 02:44:04 -0700 (PDT)
In-Reply-To: <f861ec6f0908302331p7f44a584pdae29cafce7ef950@mail.gmail.com>
References: <200908170028.27210.florian@openwrt.org>
	 <f861ec6f0908302331p7f44a584pdae29cafce7ef950@mail.gmail.com>
Date:	Mon, 5 Oct 2009 11:44:04 +0200
Message-ID: <f861ec6f0910050244l32173c9ar4662d467cc4f9ee8@mail.gmail.com>
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
X-archive-position: 24146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Ping?

On Mon, Aug 31, 2009 at 8:31 AM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> Hi Ralf,
>
> Please add Florian's patch below to your patchqueue!
>
> On Mon, Aug 17, 2009 at 12:28 AM, Florian Fainelli<florian@openwrt.org> wrote:
>> Hi Ralf,
>>
>> This patch should apply to both -master and -queue. Thanks !
>> --
>> From: Florian Fainelli <florian@openwrt.org>
>> Subject: [PATCH 1/2] au1000: fix build failure for db1x00 configured for Au1100 SoC
>>
>> This patch fixes the following warning, which becomes an error due to
>> -Werror to be turned on:
>>  CC      arch/mips/alchemy/common/gpiolib-au1000.o
>> cc1: warnings being treated as errors
>> arch/mips/alchemy/common/gpiolib-au1000.c: In function 'au1100_gpio2_to_irq':
>> /home/florian/dev/kernel/linux-queue/arch/mips/include/asm/mach-au1x00/gpio-au1000.h:107: warning: control reaches end of non-void function
>>
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
>> diff --git a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
>> index 127d4ed..4d54d40 100644
>> --- a/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
>> +++ b/arch/mips/include/asm/mach-au1x00/gpio-au1000.h
>> @@ -104,6 +104,8 @@ static inline int au1100_gpio2_to_irq(int gpio)
>>
>>        if ((gpio >= 8) && (gpio <= 15))
>>                return MAKE_IRQ(0, 29);         /* shared GPIO208_215 */
>> +
>> +       return -ENXIO;
>>  }
>>
>>  #ifdef CONFIG_SOC_AU1100
