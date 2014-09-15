Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 11:42:45 +0200 (CEST)
Received: from mail-yk0-f172.google.com ([209.85.160.172]:56049 "EHLO
        mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008920AbaIOJmnRJ465 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 11:42:43 +0200
Received: by mail-yk0-f172.google.com with SMTP id q9so1931959ykb.31
        for <multiple recipients>; Mon, 15 Sep 2014 02:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l9IcSYOBO8h0GOEg3y2PcH58JG5djO9y8sGaN3Ha7HQ=;
        b=iloNHKe1DV+5QN9NEll1t2B6GB0wE/h4uBsWaojagxovI6rBWTR5i06MyzkGmjf6R3
         tCzCK21VuG/tW5xvKnouAcJ/UgsRwL0aCRHEN2V53OcHhxeV67Lbx3/RMa1VNw7BtQmk
         gh7oBKi5GUwQAJYg6AkqVu1CBXMksQaXJZivKDJRp9wYKEH+Wyt8Zzvxa0Ifb+MDv9Of
         1KOqfWvMwn7I8prFKR3/jyBHya4AIqImvuP4sHdEUDDCILOyjz+jePLH0mJtgzyRuZqB
         91jeQxhMA/48blUEFrOUyTfOaJVEg6+bg8wiG+X0uvXU3yf5KE2grFKlAmnANqbWXdng
         EJNg==
MIME-Version: 1.0
X-Received: by 10.236.129.3 with SMTP id g3mr2125555yhi.67.1410774156389; Mon,
 15 Sep 2014 02:42:36 -0700 (PDT)
Received: by 10.170.147.4 with HTTP; Mon, 15 Sep 2014 02:42:36 -0700 (PDT)
In-Reply-To: <541656A3.8030906@roeck-us.net>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
        <1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>
        <541656A3.8030906@roeck-us.net>
Date:   Mon, 15 Sep 2014 13:42:36 +0400
Message-ID: <CAHNKnsT5AHT9xaaY44yTo7uMiOGL9fekGkEzjQuYvdUyJs-WQA@mail.gmail.com>
Subject: Re: [RFC 13/18] watchdog: add Atheros AR2315 watchdog driver
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2014-09-15 7:01 GMT+04:00, Guenter Roeck <linux@roeck-us.net>:
> On 09/14/2014 12:33 PM, Sergey Ryazanov wrote:
>> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: linux-watchdog@vger.kernel.org
>> ---
>>   arch/mips/ar231x/ar2315.c     |  26 +++++-
>>   drivers/watchdog/Kconfig      |   7 ++
>>   drivers/watchdog/Makefile     |   1 +
>>   drivers/watchdog/ar2315-wtd.c | 202
>> ++++++++++++++++++++++++++++++++++++++++++
>
> This should be two patches: One to instantiate the watchdog,
> the second the watchdog driver itself. The weatchdog driver
> should use the watchdog infrastructure.
>
Ok. Will do in v2.

[skipped]

>> + *
>> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
>> + * Based on EP93xx and ifxmips wdt driver
>
> 2008 ?
>
Yes. This driver is pretty old.

[skipped]

>> +
>> +#define CLOCK_RATE 40000000
>> +#define HEARTBEAT(x) (x < 1 || x > 90 ? 20 : x)
>> +
> Whatever the logic is here, it does not make much sense to me.
>
90 second is maximal value which we could write to register, and value
below 1 second is senseless. So this macros always return a value
which make sense: specified by user or default.

-- 
BR,
Sergey
