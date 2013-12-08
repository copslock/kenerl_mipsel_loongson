Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Dec 2013 19:24:11 +0100 (CET)
Received: from mail-lb0-f170.google.com ([209.85.217.170]:62908 "EHLO
        mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817179Ab3LHSYJpaTsG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Dec 2013 19:24:09 +0100
Received: by mail-lb0-f170.google.com with SMTP id w7so1029631lbi.29
        for <linux-mips@linux-mips.org>; Sun, 08 Dec 2013 10:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=XEVylZKweanCJjMIG6lT5sTJ7eCnGQFcYOt1BoCOqB4=;
        b=ZdOiYHK6qDO0nmvnTOSLXRljOpMcRQe5MaEfXBo+ncA8L46z3C64cyxKGLxzI2ozaS
         ciJm/XqORveoLNZ0p9n1h1v+0sGquSP8lHcD/pyee8CILOlmbkh0XkTdErG+STHvOsZx
         fF6iETLKA1iGrQFtlW7agbURy/uoLWRs97s7IegxLndihyq9JZEaKmwE14WDzpUh6F9E
         kBeWl174xYLio2N/2O1EEZ1BrNagwET5uUjTEgBLkKOb6c1pyYe9P0U2EnojFoOIuwx1
         R7cBd8qV1nWEnc3W8vExJ6g+pgD+4luidLaYxvKQEVFjIjAxIT1lkYbl6TwMYRNqNvhq
         IXQw==
X-Gm-Message-State: ALoCoQn/IJlP2PwvUocNx2rm/uBGe6SbyYur1bIo+e+M5Y24HU0xnn6oerxZDPnJtq3YqheUZkVN
X-Received: by 10.112.128.226 with SMTP id nr2mr3437313lbb.17.1386527044018;
        Sun, 08 Dec 2013 10:24:04 -0800 (PST)
Received: from wasted.dev.rtsoft.ru (ppp83-237-60-130.pppoe.mtu-net.ru. [83.237.60.130])
        by mx.google.com with ESMTPSA id i8sm6364223lbh.2.2013.12.08.10.24.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Dec 2013 10:24:03 -0800 (PST)
Message-ID: <52A4C752.9030700@cogentembedded.com>
Date:   Sun, 08 Dec 2013 22:24:02 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     Hauke Mehrtens <hauke@hauke-m.de>, John Crispin <john@phrozen.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V4 1/2] bcma: gpio: add own IRQ domain
References: <1385747290-22575-1-git-send-email-zajec5@gmail.com>        <1385752379-19540-1-git-send-email-zajec5@gmail.com>        <5298FAED.7020408@phrozen.org> <CACna6rwb4fcfEE8AtwHUWfyeT00jh4ug-WfQyarkbiQr1jdGkg@mail.gmail.com> <52990421.3000002@phrozen.org> <52A4B609.20805@hauke-m.de>
In-Reply-To: <52A4B609.20805@hauke-m.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12/08/2013 09:10 PM, Hauke Mehrtens wrote:

>>>>> +#ifdef CONFIG_BCMA_HOST_SOC
>>>>>           chip->to_irq            = bcma_gpio_to_irq;
>>>>> +#endif
>>>>>           chip->ngpio             = 16;

>>>> Hi,

>>>> Should this not be

>>>> if (IS_ENABLED(CONFIG_BCMA_HOST_SOC))
>>>>           chip->to_irq = bcma_gpio_to_irq;

>>> I can't find a proper documentation about that. It's definitely nicer
>>> to use
>>> #if IS_ENABLED(FOO)
>>> instead of
>>> #if defined(FOO) || defined(FOO_MODULE)

>>> But are we supposed to use it also for a simple
>>> #if defined(FOO)
>>> ?

>>> I tried to Google about this but found only some minor flame-wars ;)

>>> Is that documented anywhere?


>> The commit message has the relevant info ...

>> http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=2a11c8ea20bf850b3a2c60db8c2e7497d28aba99

> I read this and as far as I understand that when CONFIG_BCMA_HOST_SOC is
> bool and not tristate "#ifdef CONFIG_BCMA_HOST_SOC" and  "#if
> IS_ENABLED(CONFIG_BCMA_HOST_SOC)" will have the same effect?

    You can also use IS_BUILTIN(CONFIG_BCMA_HOST_SOC) to avoid unneeded test 
for the modular case.

> Hauke

WBR, Sergei
