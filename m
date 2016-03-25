Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2016 16:24:50 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33195 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27024885AbcCYPYtItg4z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2016 16:24:49 +0100
Received: by mail-pa0-f42.google.com with SMTP id fl4so48289907pad.0
        for <linux-mips@linux-mips.org>; Fri, 25 Mar 2016 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cHn+/VDgwar7tkdEvGMz0FdESQMTSNpGCS31vPoEBtY=;
        b=JI/mi0XMIX+rZlC4eY2opAdoq/J2hGWMQjcRi8waPEppyjINTfW/ebyVAPo6TvwZD/
         H9bnM0XAyM0FGJlSqEfexZjXm8a6fiGkpfxfFrLeILO3TFI4uf7vOK6rCXckzTMrHUWc
         rXZl15geoG1Sz+cKMrgxJWLN+QAREng2dakNnXyNpGLOzhk+cI/ybzvWTIwwiB5wDYBE
         SymEnkXXPry51bWWsfzspCp8myooVeB5QdVmtPqk8IEwcfEL1illwtzSsb1yweGLXZdA
         HD/A/3ZYyvTTIppDBWmZDrgJaW8wQ8+4ZWEErw/UKodOR14OAREEmKDZusT2BAFrSugi
         YAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cHn+/VDgwar7tkdEvGMz0FdESQMTSNpGCS31vPoEBtY=;
        b=ggVjOKtBZra0tqt3yFq0QY5ue4UlZcFKqDjEPKbgNexWjxZD60hK/R/sBHUEeB/Zlk
         8iezIgucFvTa0e/kAgNisOikzZ3RNUU4kb19hKKpykzKzvAXFBFzQ1cekCcKQ9p4SdF0
         BKVkp3zWe4qB6vAhcbj+1gBLi17HWvDA42NpYUnXTLUshKz9D/ULiz4ZP530w+u2FOEO
         AXVcC57YEd81/lETrzBMviQnednpIv8AXg2G/xnW2mvz6QC91nNvkFBoIsjp2VtpHSP4
         INJFaVZfKt/S6hKMv54jh4+fPtzCwCKvahJfL/sgGva9KGtupwvXoXxwoBc1jp1uK8rX
         JcLw==
X-Gm-Message-State: AD7BkJKYohEaVDlfAO50VM0khRdAGtvx2KeBKvblyFULhCrDdWJIzB/U55J3Js1nwxwLpg==
X-Received: by 10.67.21.167 with SMTP id hl7mr21754642pad.16.1458919482419;
        Fri, 25 Mar 2016 08:24:42 -0700 (PDT)
Received: from [192.168.1.20] (50-0-163-49.dsl.dynamic.fusionbroadband.com. [50.0.163.49])
        by smtp.gmail.com with ESMTPSA id qh8sm17223320pac.40.2016.03.25.08.24.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 08:24:41 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Gabor Juhos <juhosg@openwrt.org>,
        Matthias Schiffer <mschiffer@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com> <56F34C61.50505@universe-factory.net>
 <56F35C33.7030608@hurleysoftware.com> <56F53626.1040507@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F55838.40001@hurleysoftware.com>
Date:   Fri, 25 Mar 2016 08:24:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F53626.1040507@openwrt.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52701
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

Hi Gabor,

On 03/25/2016 05:59 AM, Gabor Juhos wrote:
> 2016.03.24. 4:17 keltezéssel, Peter Hurley írta:
>> On 03/23/2016 07:09 PM, Matthias Schiffer wrote:
>>>>> autoconfig_16550a() is doing all kinds of weird checks to detect different
>>>>> hardware by writing a lot of register values which are documented as
>>>>> reserved in the AR7242 datasheet (there's a leaked version going around
>>>>> that can be easily googled...), no idea if any of those are problematic.
>>>>> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
>>>>> altogether.
>>>>
>>>> That's just a debugging patch and not appropriate for permanent use,
>>>> the reason being that this uart is _not_ 16550 compatible (or even 16450
>>>> compatible).
>>>>
>>>> The three options for 8250 driver support for this part are:
>>>> 1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type
>>>>    to PORT_8250 instead. This will lose FIFO support so 115K won't be
>>>>    possible and likely neither will 38400.
>>>>
>>>> 2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for
>>>>    this PORT_* value to uart_config array, uapi headers, and anywhere
>>>>    the scratch register is used.
>>>>
>>>> 3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe function
>>>>    that detects ports of this type to autoconfig(). I don't recommend this
>>>>    method.
>>>>
>>>> This requirement is independent of fixing prom_putchar_ar71xx().
>>>>
>>>
>>> I can send patches for all of this, and I think that 2. would be the nicest
>>> solution. I've noticed though that include/uapi/linux/serial_core.h is
>>> experiencing a little "overflow": PORT_MAX_8250 has grown just below the
>>> first non-8250 entry.
>>
>> Ugh. Thanks for noting this.
>>
>>> Should I just add the new entry at the bottom (and
>>> thus grow the uart_config array by ~85 unused entries)? What about
>>> PORT_MAX_8250 (used at least in drivers/tty/serial/8250/8250_of.c)?
>>
>> None of the above, unfortunately. Ok, plan B.
>>
>> I need to clean off a dusty series that adds probe steering and
>> bugs pass-thru for 8250 sub-drivers and platform data. Then add a
>> UART_BUG_NOSCR to indicate a uart does not have a scratch register
>> (like this one). Then for this uart, set UPF_FIXED_TYPE and type to
>> PORT_16550A, with UART_BUG_NOSCR flag.
> 
> Introducing the UART_BUG_NOSCR flag for this UART is pointless in my opinion,
> because it does have a scratch register in fact. Even if it is not listed in the
> datasheet of the SoCs, it exists.

Ok, then the part(s) should be compatible enough with the 8250 driver as it is.
If boot hang problem persists on these parts, then the autoconfig() probes may
still be a problem, and my debugging patch from earlier can be used to skirt
autoconfig().


> I have tested that from the bootloader on the Netgear WNDR3700 board which uses
> the AR7161 SoC:

Thanks for testing.

Regards,
Peter Hurley
