Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2013 21:53:38 +0100 (CET)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58612 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823005Ab3K2UxgQWSHX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Nov 2013 21:53:36 +0100
Received: by mail-ob0-f178.google.com with SMTP id uz6so10614599obc.9
        for <multiple recipients>; Fri, 29 Nov 2013 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Bn7cBoXiv23hWnfKNP6u1sn6QsAc+b2foLtzncV32Zw=;
        b=lYwB9Dx5Dqhx51pi9yif1C9mFTHqyCnaqvOLei8NGnPLc2kl0bsYAqyJIsJpBI0mcR
         faui/1n5LlPJMB1UlgUYZFE4E59f8zz6ZaaZHLrapdIWmLC8qg7J6PTtWid/RCy8DMX8
         dt0W4wLXhfrA38scz3ZCL8cVXbbawL43bgC1uoLkYIzPEGRcCWJxmUM1u33bXs6NlwW+
         5yHabix4X0dq7WOyFOtLCCx2Q9GlpVn4ACQcU9mxly4vj/gVE7scCYw6Wfq9hHYcQCSd
         /sBFLZu+Lrt//hqTeU3Fl9KVjYdM9LAAYQ1CCweYRbobIJd1c5wwjxBV2rMjcHC0kfzy
         sRwg==
MIME-Version: 1.0
X-Received: by 10.182.40.201 with SMTP id z9mr24669124obk.45.1385758409663;
 Fri, 29 Nov 2013 12:53:29 -0800 (PST)
Received: by 10.76.73.8 with HTTP; Fri, 29 Nov 2013 12:53:29 -0800 (PST)
In-Reply-To: <5298FAED.7020408@phrozen.org>
References: <1385747290-22575-1-git-send-email-zajec5@gmail.com>
        <1385752379-19540-1-git-send-email-zajec5@gmail.com>
        <5298FAED.7020408@phrozen.org>
Date:   Fri, 29 Nov 2013 21:53:29 +0100
Message-ID: <CACna6rwb4fcfEE8AtwHUWfyeT00jh4ug-WfQyarkbiQr1jdGkg@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] bcma: gpio: add own IRQ domain
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     John Crispin <john@phrozen.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2013/11/29 John Crispin <john@phrozen.org>:
> On 29/11/13 20:12, Rafał Miłecki wrote:
>>
>> +#ifdef CONFIG_BCMA_HOST_SOC
>>         chip->to_irq            = bcma_gpio_to_irq;
>> +#endif
>>         chip->ngpio             = 16;
>
>
>
> Hi,
>
> Should this not be
>
> if (IS_ENABLED(CONFIG_BCMA_HOST_SOC))
>         chip->to_irq = bcma_gpio_to_irq;

I can't find a proper documentation about that. It's definitely nicer to use
#if IS_ENABLED(FOO)
instead of
#if defined(FOO) || defined(FOO_MODULE)

But are we supposed to use it also for a simple
#if defined(FOO)
?

I tried to Google about this but found only some minor flame-wars ;)

Is that documented anywhere?

-- 
Rafał
