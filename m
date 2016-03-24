Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2016 01:44:35 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33473 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008164AbcCXAodw7Zku (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2016 01:44:33 +0100
Received: by mail-pa0-f54.google.com with SMTP id fl4so8105553pad.0
        for <linux-mips@linux-mips.org>; Wed, 23 Mar 2016 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xpiX2dI4QrKoywGqyPS6SFfsSAV0DJNZaNY5P7b5NM4=;
        b=D5jpExQ6TqVc2klxluz1LZZdqkb7zx1DyiK3ma7y5DxsHM7XfamvdV6dhM99/kfM7N
         q1Bb5Jb0aO8cXGsIBa8ZJnk+2sajA29eZDLxRIj9OufyYj69lD5mMj9Xc6E52OIC+Imc
         SKF9aNTGMfuxXLcbpMGiSKv/+bo057fwex+j+Q3tvEoymBD/lYxT2vUpe6G+ht4Xv0pT
         oo1GTbG6QI7zs8wqPXKkDXY+bCXHVMKoKtIqlM1ghmfZxfDapnlAY6jhrfNu7B7xrHvX
         bssuw1dGiOBX7ByZmHuHoKjMCQyxHwFcsMTFVFprAtVfLxPLemJiivleyaGDIaUMtcTN
         vxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xpiX2dI4QrKoywGqyPS6SFfsSAV0DJNZaNY5P7b5NM4=;
        b=Vi8pSc3667yOKD5dlqeMHfgarvSojWQZp3pWcgL/D/w9wE9SKx2DlGMm6F1Pb4xXm7
         0C+eu6fnqW1Wp0blQmbTv+y0vLSMeRNZsadaJi7gurQHsEnCqcM5k46qbVG/f2+XPQ6J
         BRMzciYXoHkHNZ28RwkMAyhtlI9i2GgJYnxa+i7VKsQq1VGDV7qYv/g9bLJOhm+Kd4No
         kLJrIec3bsFczhjX8rkC0imaM6hqVKujZpGTYuwqXVj1dls02Fngi52aIyc1qNKzeltc
         87F6GF+M0dL5QX/JPtYAPywnGSSgGVfffu7fxl37zw8lxupNoA3ozVUGpIDQkYceNLih
         2S1A==
X-Gm-Message-State: AD7BkJKapHUXZrZ29miHflfr7Uv0C4v/WKEP22smAViVjLPXhfjPUxzZcqTNJGcl6icgRg==
X-Received: by 10.66.102.37 with SMTP id fl5mr8491541pab.32.1458780268064;
        Wed, 23 Mar 2016 17:44:28 -0700 (PDT)
Received: from [192.168.1.20] (50-0-163-49.dsl.dynamic.fusionbroadband.com. [50.0.163.49])
        by smtp.gmail.com with ESMTPSA id 62sm6728974pfk.83.2016.03.23.17.44.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2016 17:44:27 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Matthias Schiffer <mschiffer@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F3386A.5040100@hurleysoftware.com>
Date:   Wed, 23 Mar 2016 17:44:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F2D523.6000405@universe-factory.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

Hi Matthias,

On 03/23/2016 10:40 AM, Matthias Schiffer wrote:
> On 03/22/2016 04:38 PM, Peter Hurley wrote:
>> On 03/22/2016 06:07 AM, Matthias Schiffer wrote:
>>> I've tried your patch and I can't reproduce the issue anymore with it; I
>>> have no idea if this actually has to do something with the issue, or the
>>> change of the code path just hid the bug again.
>>>
>>> Regarding your other mail: with "small change", I was not talking about
>>> adding an additional printk; as mentioned, even changing the numbers in
>>> UTS_VERSION can hide the issue. I diffed a working and a broken kernel
>>> image, and the UTS_VERSION is really the only difference. I have no idea
>>> how to explain this.
>>
>> If _any_ change may hide the problem, that will make it impossible
>> to determine if any attempted fix actually works, regardless of what
>> debugging method you use.
>>
>> FWIW, you could still use the boot console to debug the problem by
>> disabling the regular command-line console.
>>
>> Regards,
>> Peter Hurley
> 
> Hi,
> it seems Peter was on the right track. With some help from Ralf, I was able
> to narrow down the issue a bit, and I'm fairly sure the hang happens
> somewhere in autoconfig().
> 
> autoconfig_16550a() is doing all kinds of weird checks to detect different
> hardware by writing a lot of register values which are documented as
> reserved in the AR7242 datasheet (there's a leaked version going around
> that can be easily googled...), no idea if any of those are problematic.
> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
> altogether.

That's just a debugging patch and not appropriate for permanent use,
the reason being that this uart is _not_ 16550 compatible (or even 16450
compatible).

The three options for 8250 driver support for this part are:
1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type
   to PORT_8250 instead. This will lose FIFO support so 115K won't be
   possible and likely neither will 38400.

2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for
   this PORT_* value to uart_config array, uapi headers, and anywhere
   the scratch register is used.

3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe function
   that detects ports of this type to autoconfig(). I don't recommend this
   method.

This requirement is independent of fixing prom_putchar_ar71xx().


> That being said, I found another minimal change that seems to fix the
> issue: prom_putchar_ar71xx() in arch/mips/ath79/early_printk.c only waits
> for UART_LSR_THRE, while serial_putc() in
> drivers/tty/serial/8250/8250_early.c waits for (UART_LSR_TEMT |
> UART_LSR_THRE). Adjusting arch/mips/ath79/early_printk.c in the same way
> makes the hangs go away.

Go ahead and do this as well.


> Maybe the AR7242 doesn't like its serial config
> registers being poked while there's still something in the FIFO? Waiting
> for UART_LSR_TEMT seems like a good idea anyways to ensure that all
> characters have been printed before autoconfig() starts taking things
> apart.

I agree.


> (Why do these two versions of essentially the same code exist anyways?)

earlyprintk command-line parameter is arch-specific and predates
the arch-independent earlycon support.

earlycon requires the arch to either supply a fixmap for the uart i/o address
or ioremap() must work by parse_early_param(); note how the mmio in
arch/mips/ath79/early_printk.c accesses the mmio space @ KSEG1ADDR(uart base addr)?

Can't do that in arch-independent earlycon code.

Regards,
Peter Hurley
