Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 21:20:38 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:40258 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490959Ab0H0TUe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Aug 2010 21:20:34 +0200
Received: by qyk35 with SMTP id 35so1070049qyk.15
        for <linux-mips@linux-mips.org>; Fri, 27 Aug 2010 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=mGEqaPd5P8DGUhhuSzUq5+nWZAVKeFRj9mSW5gFh+Lk=;
        b=hueMrJ5AOS8UgSiq0meZVIwIc1UErCMcHAGG2yzL7txUADkkglg2Xmcb5pf8BwF8yr
         dPqNtsvvZygBcJ0NXZAeVaPvBrhMdUGWdZthzwCUdJFlct9CwW62Z7ejKoSNXtVSzsyS
         v3ZZq+7OoEOakbOGTRsOP8jOM2vRjzqYy9uls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ihEj3wfB48K9cmP4NAIV6gRJt5nnEp4EZWfBkltfKJdqVKzNGEnNjqaBjH/rjFx4Mr
         GWYhFvBD/MB5wYBgOjcSyaWxYEjRFfBeFvV1d9xOeRSp+p9W7FOYYZAI2ne/9vCk3lgA
         oRSMqkkEKW6xc0AG5T859BiTCFcoIU/5fqfiQ=
MIME-Version: 1.0
Received: by 10.229.250.2 with SMTP id mm2mr7464qcb.177.1282936828623; Fri, 27
 Aug 2010 12:20:28 -0700 (PDT)
Received: by 10.229.221.5 with HTTP; Fri, 27 Aug 2010 12:20:28 -0700 (PDT)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601005C14@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D07601005801@CORPEXCH1.na.ads.idt.com>
        <AANLkTin5_3PPUoRocZFZuWhF9kFvmThUHgz3jp5ZaXMU@mail.gmail.com>
        <AEA634773855ED4CAD999FBB1A66D07601005C14@CORPEXCH1.na.ads.idt.com>
Date:   Fri, 27 Aug 2010 21:20:28 +0200
X-Google-Sender-Auth: pX2ToFfFaPp4ssHtAW-IDDGrYG8
Message-ID: <AANLkTik8S+kW96OZWuyPWqUKpoY4r2aYyZf25nwN_bvd@mail.gmail.com>
Subject: Re: Does Linux Mips support compressed Kernel?
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     wu zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 27, 2010 at 21:07, Ardelean, Andrei <Andrei.Ardelean@idt.com> wrote:
> I am using MALTA board with 74K.
> From your email I understand that the bootloader must uncompress the
> Kernel before launching it, so the compressed Kernel cannot run and
> decompress itself? Could you confirm? I am asking that because in some
> book I have read that Linux can boot a compressed image and the Kernel
> was able to uncompress itself, but maybe it was my misunderstanding.

Linux itself indeed cannot decompress itself.
It's decompressed either by the bootloader, or by the (pre-Linux)
early startup code which
is wrapped around the kernel.

> -----Original Message-----
> From: wu zhangjin [mailto:wuzhangjin@gmail.com]
> Sent: Friday, August 27, 2010 1:09 PM
> To: Ardelean, Andrei
> Cc: linux-mips@linux-mips.org
> Subject: Re: Does Linux Mips support compressed Kernel?
>
> Hi,
>
> On 8/27/10, Ardelean, Andrei <Andrei.Ardelean@idt.com> wrote:
>> Hi,
>>
>> Does Linux Mips support compressed Kernel?
>
> The answer maybe yes for we have added the basic compressed kernel
> support from 2.6.33:
>
> arch/mips/boot/compressed/
>
> but which board are you using? I just checked the arch/mips/Kconfig of
> 2.6.35 and only found the following boards enabled it:
>
> config MACH_ALCHEMY
>        bool "Alchemy processor based machines"
>        select SYS_SUPPORTS_ZBOOT
>
> config AR7
>        bool "Texas Instruments AR7"
>        [snip]
>        select SYS_SUPPORTS_ZBOOT_UART16550
>
> config MACH_LOONGSON
>        bool "Loongson family of machines"
>        select SYS_SUPPORTS_ZBOOT_UART16550
>
> config MIPS_MALTA
>        bool "MIPS Malta board"
>        [snip]
>        select SYS_SUPPORTS_ZBOOT
>
>> How can I obtain it?
>>
>
> If your board are not related to any of the ones above, then, you may
> need to select SYS_SUPPORTS_ZBOOT for your board and try it.
>
> If it doesn't work, you may need to debug it with serial port or the
> other methods. If your board have a 16550 compatible serial port, you
> may be possible to select SYS_SUPPORTS_ZBOOT_UART16550 instead of
> SYS_SUPPORTS_ZBOOT to enable the serial port debugging support, and at
> last, to enable the serial port debugging output, you need to enable
> CONFIG_DEBUG_ZBOOT.
>
> You can get more help from arch/mips/boot/compressed/
>
> BTW, to enable the zboot support, the bootloader of your board may
> need the capability to parse the elf file.
>
> Regards,
> Wu Zhangjin
>
>



-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
