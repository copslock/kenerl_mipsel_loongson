Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 19:59:13 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:55156 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904136Ab1KRS7E convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Nov 2011 19:59:04 +0100
Received: by faar25 with SMTP id r25so5903605faa.36
        for <multiple recipients>; Fri, 18 Nov 2011 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iViyLXEmOT0bZ0vX7SiYow+FtA8MBOxkN83r57rGAzM=;
        b=L63UnFItWIkw2fabsynDeQJteC8MpCpX6JS6IrIDYq7PGU1fQhMnDrx3kG8PZSdJK+
         YplyAjFEXxzMROcLkIlVeBhzV1uZZL5k+T28yr1mMVpnvgx6coV0+hF+F3gTuQeKeUM5
         mR7Wavejh4KVHA4JJWtIvJdO7AGclgzByCwWU=
MIME-Version: 1.0
Received: by 10.182.179.104 with SMTP id df8mr981796obc.75.1321642738854; Fri,
 18 Nov 2011 10:58:58 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Fri, 18 Nov 2011 10:58:58 -0800 (PST)
In-Reply-To: <4EC6AA03.2010805@openwrt.org>
References: <1321629720-29035-1-git-send-email-juhosg@openwrt.org>
        <1321629720-29035-4-git-send-email-juhosg@openwrt.org>
        <CAEWqx59XzDyGWi7q-PYjiXx7t1Jinoz8ygypbk65CmD+zcyW2g@mail.gmail.com>
        <4EC6A6E3.8040806@openwrt.org>
        <CAEWqx5_kuqeoHz=iNq5vDUX92zboBVksZ4JsyyEwk4tTaND77A@mail.gmail.com>
        <4EC6AA03.2010805@openwrt.org>
Date:   Fri, 18 Nov 2011 19:58:58 +0100
Message-ID: <CAEWqx5_rEP8oc-hz=VamVzA8eL4ojuRQq9c6sy95TsYratT_nw@mail.gmail.com>
Subject: Re: [PATCH 4/7] MIPS: ath79: add a common PCI registration function
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15807

2011/11/18 Gabor Juhos <juhosg@openwrt.org>:
> 2011.11.18. 19:44 keltezéssel, René Bolldorf írta:
>> 2011/11/18 Gabor Juhos <juhosg@openwrt.org>:
>>> 2011.11.18. 19:32 keltezéssel, René Bolldorf írta:
>>>> On Fri, Nov 18, 2011 at 4:21 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
>>>>> The current code unconditionally registers the AR724X
>>>>> specific PCI controller, even if the kernel is running
>>>>> on a different SoC.
>>>>>
>>>> This is not true, take a look in the ath79 Kconfig file...
>>>
>>> Well, it is true. If you have the Ubiquiti board selected, that will allow you
>>> to select the PCI code to be built. If you select the PCI code as well, then
>>> pci-ath724x.c will be compiled into the kernel. Due to the nature of the
>>> 'arch_initcall' macro the PCI controller always gets registered. If you have
>>> another board selected along with the Ubiquiti, and you are trying to run the
>>> kernel on the other board, the PCI controller will be registered on that as well.
>>>
>>> -Gabor
>>>
>>
>> Apologies again, got a thinko :)
>
> No problem. BTW, you forgot to reply to all again. ;)
>
> -Gabor
>

Well, I should change my settings....
