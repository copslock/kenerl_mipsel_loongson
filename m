Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Dec 2010 15:01:58 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:33076 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491128Ab0LEOBy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Dec 2010 15:01:54 +0100
Received: by eyd9 with SMTP id 9so5791747eyd.36
        for <multiple recipients>; Sun, 05 Dec 2010 06:01:51 -0800 (PST)
Received: by 10.213.8.70 with SMTP id g6mr545338ebg.44.1291557711373;
        Sun, 05 Dec 2010 06:01:51 -0800 (PST)
Received: from [192.168.2.2] ([91.79.97.62])
        by mx.google.com with ESMTPS id w20sm3621468eeh.6.2010.12.05.06.01.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 06:01:49 -0800 (PST)
Message-ID: <4CFB9B15.9050308@mvista.com>
Date:   Sun, 05 Dec 2010 17:00:53 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     anoop pa <anoop.pa@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        mcdonald.shane@gmail.com
Subject: Re: [RFC 1/3] VSMP support for msp71xx family of platforms.
References: <1291220307.31413.14.camel@paanoop1-desktop>        <4CF78755.2070109@mvista.com> <AANLkTinkF8_2hO7Ko=S6w2NPPX8oGTcdbRyd=7N0mUbM@mail.gmail.com>
In-Reply-To: <AANLkTinkF8_2hO7Ko=S6w2NPPX8oGTcdbRyd=7N0mUbM@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 02-12-2010 20:27, anoop pa wrote:

>>> -obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o
>>> +obj-$(CONFIG_IRQ_MSP_CIC) += msp_irq_cic.o msp_irq_per.o

>>    What does this change have to do with the rest of the patch?

> This change is required for next patch in this. series.Is this
> potentially wrong .

    It's not wrong -- it's just that one patch needs to address one issue. Or 
at least you should describe all your changed in the changelog.

>   Do I want to move this to next patch?

    I don't know what you want. :-)

>>> +       set_vi_handler (MIPS_CPU_IPI_CALL_IRQ, ipi_call_dispatch);

>>    Spaces between the function name and ( are not allowed -- run your patch
>> thru scripts/checkpatch.pl.

> Not sure what went wrong. I had checked it before sending .

> linux.git$ ./scripts/checkpatch.pl
> 0001-VSMP-support-for-msp71xx-family-of-platforms.patch
> total: 0 errors, 0 warnings, 84 lines checked

> 0001-VSMP-support-for-msp71xx-family-of-platforms.patch has no obvious
> style problems and is ready for submission.

    I'm not sure -- perhaps checkpatch.pl has stopped complaing about those 
spaces... but it ceratainly did in the past.

> Regards,
> Anoop

WBR, Sergei
