Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 22:18:07 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:48126 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6867274Ab3K2VSGENldK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Nov 2013 22:18:06 +0100
Message-ID: <52990421.3000002@phrozen.org>
Date:   Fri, 29 Nov 2013 22:16:17 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V4 1/2] bcma: gpio: add own IRQ domain
References: <1385747290-22575-1-git-send-email-zajec5@gmail.com>        <1385752379-19540-1-git-send-email-zajec5@gmail.com>        <5298FAED.7020408@phrozen.org> <CACna6rwb4fcfEE8AtwHUWfyeT00jh4ug-WfQyarkbiQr1jdGkg@mail.gmail.com>
In-Reply-To: <CACna6rwb4fcfEE8AtwHUWfyeT00jh4ug-WfQyarkbiQr1jdGkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 29/11/13 21:53, Rafał Miłecki wrote:
> 2013/11/29 John Crispin<john@phrozen.org>:
>> On 29/11/13 20:12, Rafał Miłecki wrote:
>>>
>>> +#ifdef CONFIG_BCMA_HOST_SOC
>>>          chip->to_irq            = bcma_gpio_to_irq;
>>> +#endif
>>>          chip->ngpio             = 16;
>>
>>
>>
>> Hi,
>>
>> Should this not be
>>
>> if (IS_ENABLED(CONFIG_BCMA_HOST_SOC))
>>          chip->to_irq = bcma_gpio_to_irq;
>
> I can't find a proper documentation about that. It's definitely nicer to use
> #if IS_ENABLED(FOO)
> instead of
> #if defined(FOO) || defined(FOO_MODULE)
>
> But are we supposed to use it also for a simple
> #if defined(FOO)
> ?
>
> I tried to Google about this but found only some minor flame-wars ;)
>
> Is that documented anywhere?
>


The commit message has the relevant info ...

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=2a11c8ea20bf850b3a2c60db8c2e7497d28aba99

	John
