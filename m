Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Mar 2016 04:17:17 +0100 (CET)
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33277 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006623AbcCXDRPtoj2z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Mar 2016 04:17:15 +0100
Received: by mail-pf0-f182.google.com with SMTP id 4so46348277pfd.0
        for <linux-mips@linux-mips.org>; Wed, 23 Mar 2016 20:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hurleysoftware-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=IcAn9FRCrW7Giulepf8d/6L/jvrn7oz8oL/97x+dtNM=;
        b=uaPsnPxAxLg0gbvtVrz+ZcMawwSjXSStXnGO8tc/mnoBOoBT3FYaFTaECBLxWCe/PU
         nEW3BfCKYqMnTYjkJaBl3eoFrCK6KX4/SWCJx2mIdqoWCUjt7F4oO4OH5FKErB3nAO0C
         hDqJ+RTGxUSwnI/6ceWzf9HOBhwBs+LAxcc0sK+LFebcosr9hdHSDFnVg6F+gm1PEhlh
         mAeGqL8BJYtcWoGCOyw1qSdJh5TLfTg16RhPSOlDfdjfyRB4ETNuODWd7j+oD5teJp8t
         Nuo/gs8AyjV7AH5LJJorRs5FVhS9z0apW2COOI9Y7dlQnNFZ0Mvd2ZdpJFgfkzdkM4GJ
         2esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=IcAn9FRCrW7Giulepf8d/6L/jvrn7oz8oL/97x+dtNM=;
        b=D4YJ8VkPLiNN3diM8l/mCenOTI0BE9iPbjGqcJ23yV0GHmd10WCb4ApDZ4z8SLew+l
         IzQoAPxdW72y3t4csFLXTDpcutJsEdDMufMd33rMw1Xo86w2R2w92bF59xTY5Qr2cv+k
         oi0JE4iZicIvGx7Wk3kCHFAd/oeOHyHt7SpOW+bIhSCMOMIaFapZWlGsKCAgmW9lauq7
         z1/oBgqxV/IGgNX9vTiTo8bJmkoaAOxDb5YkQXUdTGf1LzUa57HZDagVoS3NW9wKAVwI
         UyNQLTUKytX7ry2WSORLXGpvyoT10xrMlEAWOKxawxr8e2hKPBT0Cu9UEnUSgEo92s5v
         rYZg==
X-Gm-Message-State: AD7BkJJhrLKN2+72BDJexSsdzdrG23RpGvmx+e2tnRbyS/WHCo9HvmyMuaXXxu6d4+MLJg==
X-Received: by 10.98.44.73 with SMTP id s70mr9346966pfs.2.1458789429791;
        Wed, 23 Mar 2016 20:17:09 -0700 (PDT)
Received: from [192.168.1.20] (50-0-163-49.dsl.dynamic.fusionbroadband.com. [50.0.163.49])
        by smtp.gmail.com with ESMTPSA id q85sm7163881pfq.81.2016.03.23.20.17.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Mar 2016 20:17:08 -0700 (PDT)
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
To:     Matthias Schiffer <mschiffer@universe-factory.net>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
 <56F16708.4020109@hurleysoftware.com> <56F2D523.6000405@universe-factory.net>
 <56F3386A.5040100@hurleysoftware.com> <56F34C61.50505@universe-factory.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F35C33.7030608@hurleysoftware.com>
Date:   Wed, 23 Mar 2016 20:17:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56F34C61.50505@universe-factory.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52693
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

On 03/23/2016 07:09 PM, Matthias Schiffer wrote:
>>> autoconfig_16550a() is doing all kinds of weird checks to detect different
>>> hardware by writing a lot of register values which are documented as
>>> reserved in the AR7242 datasheet (there's a leaked version going around
>>> that can be easily googled...), no idea if any of those are problematic.
>>> Just setting UPF_FIXED_TYPE as suggested by Peter would avoid that code
>>> altogether.
>>
>> That's just a debugging patch and not appropriate for permanent use,
>> the reason being that this uart is _not_ 16550 compatible (or even 16450
>> compatible).
>>
>> The three options for 8250 driver support for this part are:
>> 1. Similar to the debugging patch, set UPF_FIXED_TYPE but set port type
>>    to PORT_8250 instead. This will lose FIFO support so 115K won't be
>>    possible and likely neither will 38400.
>>
>> 2. Set UPF_FIXED_TYPE but define a new PORT_* value and add support for
>>    this PORT_* value to uart_config array, uapi headers, and anywhere
>>    the scratch register is used.
>>
>> 3. As with 2. above but don't set UPF_FIXED_TYPE and add a probe function
>>    that detects ports of this type to autoconfig(). I don't recommend this
>>    method.
>>
>> This requirement is independent of fixing prom_putchar_ar71xx().
>>
> 
> I can send patches for all of this, and I think that 2. would be the nicest
> solution. I've noticed though that include/uapi/linux/serial_core.h is
> experiencing a little "overflow": PORT_MAX_8250 has grown just below the
> first non-8250 entry.

Ugh. Thanks for noting this.

> Should I just add the new entry at the bottom (and
> thus grow the uart_config array by ~85 unused entries)? What about
> PORT_MAX_8250 (used at least in drivers/tty/serial/8250/8250_of.c)?

None of the above, unfortunately. Ok, plan B.

I need to clean off a dusty series that adds probe steering and
bugs pass-thru for 8250 sub-drivers and platform data. Then add a
UART_BUG_NOSCR to indicate a uart does not have a scratch register
(like this one). Then for this uart, set UPF_FIXED_TYPE and type to
PORT_16550A, with UART_BUG_NOSCR flag.

Couple of days because I'm in the middle of something else, ok?

Regards,
Peter Hurley
