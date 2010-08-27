Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 19:09:05 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:40423 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491809Ab0H0RJC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 19:09:02 +0200
Received: by wwb31 with SMTP id 31so3332049wwb.24
        for <linux-mips@linux-mips.org>; Fri, 27 Aug 2010 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IkzR1g3GJQH2W5VUflNaY7sfDl5G3/JKO9GyPuC92cc=;
        b=GuuqJ3XWANlZwFxTEBI51GJQ7RqRV2/eg8UcPZIYw8aTbmv+L80BX+BjH3lQgcbKzN
         MePTTXgJ9HTBpiaA48X8SCgzNHhrdFVMvac3B/OL7xWc98p9l/xvLvJImFz48htuvsRu
         gqqslGVIcy0RwfhfcCm7BBhsd7hLmd9X7o+Zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YVdqx65YyZOrFa3WYIsBkFPWB1Da8RH7mNT+q2l0OAMBdSR5kSDac4PR+2+GNf5yxM
         grFxlFKTG4v+ZHLjTFyrEUEyoHuOB81EVLguzWhPbz8MGR7vjYeqoDvQRs8fzEV6Ve/q
         N4n+fzRfdbohWCb++h4mgTFUEKRVJjIVr55OE=
MIME-Version: 1.0
Received: by 10.227.37.8 with SMTP id v8mr905826wbd.37.1282928936658; Fri, 27
 Aug 2010 10:08:56 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Fri, 27 Aug 2010 10:08:56 -0700 (PDT)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601005801@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D07601005801@CORPEXCH1.na.ads.idt.com>
Date:   Sat, 28 Aug 2010 01:08:56 +0800
Message-ID: <AANLkTin5_3PPUoRocZFZuWhF9kFvmThUHgz3jp5ZaXMU@mail.gmail.com>
Subject: Re: Does Linux Mips support compressed Kernel?
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 8/27/10, Ardelean, Andrei <Andrei.Ardelean@idt.com> wrote:
> Hi,
>
> Does Linux Mips support compressed Kernel?

The answer maybe yes for we have added the basic compressed kernel
support from 2.6.33:

arch/mips/boot/compressed/

but which board are you using? I just checked the arch/mips/Kconfig of
2.6.35 and only found the following boards enabled it:

config MACH_ALCHEMY
        bool "Alchemy processor based machines"
        select SYS_SUPPORTS_ZBOOT

config AR7
        bool "Texas Instruments AR7"
        [snip]
        select SYS_SUPPORTS_ZBOOT_UART16550

config MACH_LOONGSON
        bool "Loongson family of machines"
        select SYS_SUPPORTS_ZBOOT_UART16550

config MIPS_MALTA
        bool "MIPS Malta board"
        [snip]
        select SYS_SUPPORTS_ZBOOT

> How can I obtain it?
>

If your board are not related to any of the ones above, then, you may
need to select SYS_SUPPORTS_ZBOOT for your board and try it.

If it doesn't work, you may need to debug it with serial port or the
other methods. If your board have a 16550 compatible serial port, you
may be possible to select SYS_SUPPORTS_ZBOOT_UART16550 instead of
SYS_SUPPORTS_ZBOOT to enable the serial port debugging support, and at
last, to enable the serial port debugging output, you need to enable
CONFIG_DEBUG_ZBOOT.

You can get more help from arch/mips/boot/compressed/

BTW, to enable the zboot support, the bootloader of your board may
need the capability to parse the elf file.

Regards,
Wu Zhangjin
