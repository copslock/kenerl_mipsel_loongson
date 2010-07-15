Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jul 2010 11:04:35 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.10]:53839 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492174Ab0GOJE3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jul 2010 11:04:29 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3BCB31C00233;
        Thu, 15 Jul 2010 11:04:28 +0200 (CEST)
X-Auth-Info: EDmiIOdv0sE+80dVzqnMlUSaduXvHHmURZRLu6Nfsxw=
Received: from lancy.mylan.de (p4FF05C95.dip.t-dialin.net [79.240.92.149])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 1C1AD1C0021E;
        Thu, 15 Jul 2010 11:04:28 +0200 (CEST)
Message-ID: <4C3ECF27.4040306@grandegger.com>
Date:   Thu, 15 Jul 2010 11:04:39 +0200
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Subject: Re: [PATCH v2] mips/alchemy: add basic support for the GPR board
References: <1279115243-11586-1-git-send-email-wg@grandegger.com> <AANLkTindpsjxnTgpchvuqkxBqYg3NtsP39wXq61QRR-3@mail.gmail.com>
In-Reply-To: <AANLkTindpsjxnTgpchvuqkxBqYg3NtsP39wXq61QRR-3@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 07/14/2010 08:40 PM, Florian Fainelli wrote:
> Hi Wolfgang,
> 
> 2010/7/14 Wolfgang Grandegger <wg@grandegger.com>:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> This patch adds basic support for the General Purpose Router (GPR)
>> board from Trapeze ITS.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> [snip]
> 
>> +
>> +/*
>> + * LEDs
>> + */
>> +static struct gpio_led gpr_gpio_leds[] = {
>> +       {       /* green */
>> +               .name                   = "green",
>> +               .gpio                   = 4,
>> +               .active_low             = 1,
>> +               .default_trigger        = "none",
>> +       },
>> +       {       /* red */
>> +               .name                   = "red",
>> +               .gpio                   = 5,
>> +               .active_low             = 1,
>> +               .default_trigger        = "none",
>> +       }
>> +};
> 
> Should be "gpr:green" and "gpr:red" respectively to follow the Linux
> LEDs class naming conventions. The default trigger is superfluous,

Will be fixed.

> however it would make sense to have the green led be associated with
> the "default-on" trigger. Otherwise, it looks very good.

I just played with various default triggers. None of them is needed and
I will remove it. In the board setup code, the LEDs are toggled and
therefore I do not want to define a "default-on".

Thanks,

Wolfgang.
