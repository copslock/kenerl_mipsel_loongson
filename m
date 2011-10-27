Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 15:30:11 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:50579 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903600Ab1J0NaH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Oct 2011 15:30:07 +0200
Received: by wwf10 with SMTP id 10so3506827wwf.24
        for <multiple recipients>; Thu, 27 Oct 2011 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EBWTbPkXDW5tzjAIMSgvfM2XVEZTMnDWEK7MrKIGGjk=;
        b=oV1sc8w+4gGyYUhcAq2E/NLxjOr/o0I7IsCUkh8OMkBQMTDhRhBEe3nOlZvm80J7mo
         rmPrTgWs4HWYeBAaZ2V9Dt33BiDUJqhbzRecJ8aFnyYymX1dhLSdPeK/o6HxvC8f/IbZ
         Ll0ioycwXCIb/XH059JCtceWso0RGG3OPklxc=
Received: by 10.227.197.81 with SMTP id ej17mr16026501wbb.13.1319722200101;
 Thu, 27 Oct 2011 06:30:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.227.205.146 with HTTP; Thu, 27 Oct 2011 06:29:40 -0700 (PDT)
In-Reply-To: <20111027131124.GK19187@n2100.arm.linux.org.uk>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1319720503-3183-1-git-send-email-vapier@gentoo.org> <20111027131124.GK19187@n2100.arm.linux.org.uk>
From:   Mike Frysinger <vapier@gentoo.org>
Date:   Thu, 27 Oct 2011 15:29:40 +0200
X-Google-Sender-Auth: FGrx4JyCprjO8C5zoBoNcp2GfF4
Message-ID: <CAJaTeTp_jv-b1GUEswfFzn=joj=jkMHE91zK1wnDksH60GT6Dg@mail.gmail.com>
Subject: Re: [PATCH] asm-generic/gpio.h: merge basic gpiolib wrappers
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Jonas Bonn <jonas@southpole.se>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        linux@lists.openrisc.net, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 31310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19733

On Thu, Oct 27, 2011 at 15:11, Russell King - ARM Linux wrote:
> On Thu, Oct 27, 2011 at 09:01:43AM -0400, Mike Frysinger wrote:
>> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
>> index d494001..622851c 100644
>> --- a/include/asm-generic/gpio.h
>> +++ b/include/asm-generic/gpio.h
>> @@ -170,6 +170,29 @@ extern int __gpio_cansleep(unsigned gpio);
>>
>>  extern int __gpio_to_irq(unsigned gpio);
>>
>> +#ifndef gpio_get_value
>> +#define gpio_get_value(gpio) __gpio_get_value(gpio)
>> +#endif
>> +
>> +#ifndef gpio_set_value
>> +#define gpio_set_value(gpio, value) __gpio_set_value(gpio, value)
>> +#endif
>> +
>> +#ifndef gpio_cansleep
>> +#define gpio_cansleep(gpio) __gpio_cansleep(gpio)
>> +#endif
>> +
>> +#ifndef gpio_to_irq
>> +#define gpio_to_irq(gpio) __gpio_to_irq(gpio)
>> +#endif
>> +
>> +#ifndef irq_to_gpio
>> +static inline int irq_to_gpio(unsigned int irq)
>> +{
>> +     return -EINVAL;
>> +}
>> +#endif
>> +
>
> This is extremely dangerous.  Consider for example this code
> (see ARM mach-davinci's gpio.h):
> ...
> This is why I didn't solve this using the preprocessor method in ARM, but
> instead used __ARM_GPIOLIB_COMPLEX to control whether these definitions
> are required.

i thought the arm mach were defining things already, but i guess i
missed some in my review

easy enough to glue the arm-specific world to the asm-generic world
... a bit ugly, but should work i think:
#ifndef __ARM_GPIOLIB_COMPLEX
/* assume the mach has defined this */
#ifndef gpio_get_value
#define gpio_get_value gpio_get_value
#endif
#ifndef gpio_set_value
#define gpio_set_value gpio_set_value
#endif
#ifndef gpio_cansleep
#define gpio_cansleep gpio_cansleep
#endif
#ifndef gpio_to_irq
#define gpio_to_irq gpio_to_irq
#endif
#ifndef irq_to_gpio
#define irq_to_gpio irq_to_gpio
#endif
...

the next step might be to drill down into the arm mach's and sprinkle
the defines into the parts that need it ...
-mike
