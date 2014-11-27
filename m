Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2014 23:37:01 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:39615 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007442AbaK0WhADM0gd convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Nov 2014 23:37:00 +0100
Received: by mail-ie0-f182.google.com with SMTP id x19so5135081ier.41
        for <multiple recipients>; Thu, 27 Nov 2014 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dIMC6y53qoh6+a3cM5CwjcSVlsUQ/UNDxfZno7DP+r0=;
        b=zmfvzFMS6gUKlb+YEXqGBoeXLbMzVX1VeujXlak+yXokY+KmEJyb7oCN5+Y21rWWrW
         1f49Lp5JrTqiDFmlJqNb139LokUk0jSSjIPqdmkRTce672BfU1RnTgIg9rwvhIwDPrZn
         roFY9cL1HJzlb5eurqgENRD4a8Z0k+/loCTl3jC5WasbEsuUS8pNOEcY2EAt0svPCKGb
         /RNUDYiUe5CiokDqoUam2SC7jEoV330v0LnYdjF5Q91HU/5Pu+3mA1xux0Dy3o+C4KcI
         yulC3kzVKhJrS20cEPlxe0KAb/1it6gMy/Ba5QN90ZGjyPsmuLDIvkTvH+M4C7AWH0nR
         +KaA==
MIME-Version: 1.0
X-Received: by 10.107.170.98 with SMTP id t95mr36361806ioe.7.1417127813638;
 Thu, 27 Nov 2014 14:36:53 -0800 (PST)
Received: by 10.107.14.9 with HTTP; Thu, 27 Nov 2014 14:36:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
References: <1416736241-12723-1-git-send-email-zajec5@gmail.com>
        <1416778509-31502-1-git-send-email-zajec5@gmail.com>
        <alpine.DEB.2.02.1411240910100.16047@utopia.booyaka.com>
        <CACna6rxwwn5_e86278TAiOFZ3sVu_Exfm2x94vN2KiTJfsFujQ@mail.gmail.com>
        <alpine.DEB.2.02.1411251407290.16047@utopia.booyaka.com>
        <CACna6rxj8=V8me1_L8SxhV3=kgYRyKeBHkxShSMZa4kbcHimLg@mail.gmail.com>
        <alpine.DEB.2.02.1411271926560.1406@utopia.booyaka.com>
Date:   Thu, 27 Nov 2014 23:36:53 +0100
Message-ID: <CACna6rwMjOfmnA-926udNx7jQHQ2JMnmiutQZkTxtJ85qmUw8A@mail.gmail.com>
Subject: Re: [PATCH V3] MIPS: BCM47XX: Move NVRAM driver to the drivers/soc/
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Paul Walmsley <paul@pwsan.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kumar Gala <galak@codeaurora.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sandeep Nair <sandeep_n@ti.com>, linux-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 27 November 2014 at 20:56, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 25 Nov 2014, Rafał Miłecki wrote:
>> I understand your arguments against drivers/soc/, but on the other hand
>> I have no idea where else this driver could go.
>
> After looking around the tree to find out where similar code is located,
> it looks like drivers/firmware is the right place.  These days,
> drivers/firmware is mainly used for drivers that parse EFI bootloader
> data, DMI data, that sort of thing.  Quite similar to the CFE-provided
> data that the bcm47xx-nvram code deals with.  So, by functional analogy,
> drivers/firmware appears to be the right place to stash this device
> data-probing code.
>
>> I guess DT is older than CFE, but Broadcom decided to invent own
>> solution called NVRAM anyway. This is a bit messy, because it actually
>> stores hardware details (CPU, RAM, switch) as well as user settings
>> (e.g. LEDs behavior). I can't say why Broadcom decided to implement it
>> this way.
>
> Yep, based on what the other drivers in drivers/firmware are used for, I
> think drivers/firmware is the right place for the CFE parsing code.

The problem is I can't find MAINTAINER of the drivers/firmware/. Is
there someone responsible for that? Some mailing list maybe? Who could
give us an ACK to move bcm47xx_nvram there?


>> > It sounds to me like this code is a combination of three
>> > pieces:
>> >
>> > 1. code that autoprobes the size of the "nvram" partition in the Broadcom
>> > platform flash, by reading various locations in the MMIO flash aperture,
>> > configured by some other system entity
>>
>> That's right, on MIPS we simply detect flash type (drivers/ssb &
>> driver/bcma) and using that we init NVRAM passing memory offset where
>> the flash is mapped.
>
> OK.
>
> So (as a side issue), I would suggest that when you move this code out of
> arch/mips, the MIPS-isms in it should be removed, like KSEG1ADDR(), etc.,
> and replaced by the standard ioremap()-type approach.  After all, Broadcom
> could build CFE for ARM, and then we'd want to use this same code to parse
> the CFE-provided data.
>
> Also I would suggest getting rid of the #ifdefs for the flash type, and
> probing it dynamically instead.  The flash setup code under drivers/ssb/
> and drivers/bcma/ sets up platform_devices for the flash, right?  If so
> then it would be best if this code could run after the bus setup code,
> query the Linux device model for the type of platform flash in use, and
> then extract the appropriate address space to probe from that data.

I'm pretty sure you look at some old version of arch/bcm47xx/nvram.c.
I wouldn't dare to move such a MIPS-focused driver to some common
place ;)

Please check for the version of nvram.c in Ralf's upstream-sfr tree. I
think you'll like it much more. Hopefully you will even consider it
ready for moving to the drivers/firmware/ or whatever :)

-- 
Rafał
