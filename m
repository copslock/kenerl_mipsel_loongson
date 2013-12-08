Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Dec 2013 19:10:28 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:41584 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822444Ab3LHSKZSlJEu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Dec 2013 19:10:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 31D988F67;
        Sun,  8 Dec 2013 19:10:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KKein9SjRAcv; Sun,  8 Dec 2013 19:10:19 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9] (unknown [IPv6:2001:470:1f0b:447:609b:6857:e4ae:c4e9])
        by hauke-m.de (Postfix) with ESMTPSA id E0BD38F66;
        Sun,  8 Dec 2013 19:10:18 +0100 (CET)
Message-ID: <52A4B609.20805@hauke-m.de>
Date:   Sun, 08 Dec 2013 19:10:17 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V4 1/2] bcma: gpio: add own IRQ domain
References: <1385747290-22575-1-git-send-email-zajec5@gmail.com>        <1385752379-19540-1-git-send-email-zajec5@gmail.com>        <5298FAED.7020408@phrozen.org> <CACna6rwb4fcfEE8AtwHUWfyeT00jh4ug-WfQyarkbiQr1jdGkg@mail.gmail.com> <52990421.3000002@phrozen.org>
In-Reply-To: <52990421.3000002@phrozen.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 11/29/2013 10:16 PM, John Crispin wrote:
> On 29/11/13 21:53, Rafał Miłecki wrote:
>> 2013/11/29 John Crispin<john@phrozen.org>:
>>> On 29/11/13 20:12, Rafał Miłecki wrote:
>>>>
>>>> +#ifdef CONFIG_BCMA_HOST_SOC
>>>>          chip->to_irq            = bcma_gpio_to_irq;
>>>> +#endif
>>>>          chip->ngpio             = 16;
>>>
>>>
>>>
>>> Hi,
>>>
>>> Should this not be
>>>
>>> if (IS_ENABLED(CONFIG_BCMA_HOST_SOC))
>>>          chip->to_irq = bcma_gpio_to_irq;
>>
>> I can't find a proper documentation about that. It's definitely nicer
>> to use
>> #if IS_ENABLED(FOO)
>> instead of
>> #if defined(FOO) || defined(FOO_MODULE)
>>
>> But are we supposed to use it also for a simple
>> #if defined(FOO)
>> ?
>>
>> I tried to Google about this but found only some minor flame-wars ;)
>>
>> Is that documented anywhere?
>>
> 
> 
> The commit message has the relevant info ...
> 
> http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=2a11c8ea20bf850b3a2c60db8c2e7497d28aba99

I read this and as far as I understand that when CONFIG_BCMA_HOST_SOC is
bool and not tristate "#ifdef CONFIG_BCMA_HOST_SOC" and  "#if
IS_ENABLED(CONFIG_BCMA_HOST_SOC)" will have the same effect?

@Rafał
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
for the "bcma: gpio: add own IRQ domain" patch.

Hauke
