Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2009 12:10:45 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:42718 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492470AbZH1KKj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Aug 2009 12:10:39 +0200
Received: by bwz4 with SMTP id 4so1745849bwz.0
        for <multiple recipients>; Fri, 28 Aug 2009 03:10:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eqi9cU7fq8cOXqag19LMDUtZK0ehtDf3c4FpVSbzpPI=;
        b=mMIzKN0ATLLF9ErSGtXdmeQQggV2WLk/CcXP0pwys8IpCHK4Ld5L+rLL+WjjKjUE/D
         2CUeqxjfATOaNxGtSN9siSdGMWpbRaYnwBHniY7J6AI+VMBT1yRUbmy0MfEjbzqTIafO
         tDC7FYJt+DO5oBv24OMbGDrcySYEe6ThR11Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eH3ao+2Vpr9ENqG2ypuzlwqtIdfvA5KOwopuh0tqOgLPR56erhHMw28mLgXyQWSD8P
         /QEvRbs1bb5xhZZi/q6RjDioHbASxZxBrSxRPTOeuH7jX28GkD9BrE/GxH1G9orOR2Hb
         yWoM/l018myUenrfts7WBcE7h62cuOHiUXwuM=
MIME-Version: 1.0
Received: by 10.223.1.6 with SMTP id 6mr387405fad.103.1251454232119; Fri, 28 
	Aug 2009 03:10:32 -0700 (PDT)
In-Reply-To: <200908281157.47387.florian@openwrt.org>
References: <20090828074709.GA11637@linux-mips.org> <4A979B0E.106@gmail.com>
	 <4A97A2E2.2090108@gmail.com> <200908281157.47387.florian@openwrt.org>
Date:	Fri, 28 Aug 2009 12:10:32 +0200
Message-ID: <f861ec6f0908280310v491c0364hf4bb1e960c152831@mail.gmail.com>
Subject: Re: MTX build failure
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23957
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, Aug 28, 2009 at 11:57 AM, Florian Fainelli<florian@openwrt.org> wrote:
> Le Friday 28 August 2009 11:26:58 Manuel Lauss, vous avez écrit :
>> I wrote:
>> > Ralf Baechle wrote:
>> >>   CC      drivers/input/keyboard/gpio_keys.o
>> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c: In
>> >> function ‘gpio_keys_probe’:
>> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:123:
>> >> error: implicit declaration of function ‘gpio_request’
>> >> /home/ralf/src/linux/linux-mips/drivers/input/keyboard/gpio_keys.c:135:
>> >> error: implicit declaration of function ‘gpio_free’ make[5]: ***
>> >> [drivers/input/keyboard/gpio_keys.o] Error 1
>> >> make[4]: *** [drivers/input/keyboard] Error 2
>> >> make[3]: *** [drivers/input] Error 2
>> >> make[2]: *** [drivers] Error 2
>> >> make[1]: *** [sub-make] Error 2
>> >
>> > Either something like the patch below, or adding stubs for
>> > gpio_request/gpio_free to asm/mach-au1x00/gpio-au1000.h in the
>> > CONFIG_GPIOLIB=n case should fix it.
>>
>> Florian, Ralf, I prefer the latter approach;  saves everyone from
>> having to add #ifdef CONFIG_GPIOLIB around gpio_request() calls.
>>
>> Here's an untested patch.  What do you think?  If it works for you, please
>> add it to your patchqueue!
>>
>> Thanks!
>>
>> ---
>>
>> From: Manuel Lauss <manuel.lauss@gmail.com>
>> Subject: [PATCH] Alchemy: add gpio_request/gpio_free stubs for
>> CONFIG_GPIOLIB=n
>>
>> Some drivers use gpio_request/gpio_free regardless of whether
>> gpiolib is actually built;  add stubs to work around the ensuing
>> compile failures.
>
> This is better, though fixing the gpio keyboard driver might probably be a good approach.

As I wrote above, I don't think adding "#ifdef CONFIG_GPIOLIB" to all
in-kernel users
of gpio_request() is an acceptable solution; one would be to
unconditionally enable GPIOLIB
on Alchemy (but I like speedy gpio calls to bitbang busses...),
another this patch.

Thanks for testing!
      Manuel Lauss
