Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 14:59:03 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:35908 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903756Ab1KUN64 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Nov 2011 14:58:56 +0100
Received: by vcbfo13 with SMTP id fo13so4071321vcb.36
        for <multiple recipients>; Mon, 21 Nov 2011 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sPU8gg3AOPFrS4DHhcQTFfqNllt8bLqjdErHiothjVI=;
        b=kgGbU9C6fSKvD4UcbMp3MzaxL5Q8Z1NCW9OlhOf+UYtOmTdGrUOUOhXgNxBfvUVOhz
         zgcESV0n2a9+RWOe/MM/U1r3mQJwe9vB5Rzfz8qiNOGk5ItOmOgbAoxExRTvBdZHXsEn
         3oy4PwIEHrCTwB/jW9K0+lQWx4gUjhcCUL1+Y=
MIME-Version: 1.0
Received: by 10.182.37.8 with SMTP id u8mr1828759obj.15.1321883930514; Mon, 21
 Nov 2011 05:58:50 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Mon, 21 Nov 2011 05:58:50 -0800 (PST)
In-Reply-To: <4ECA3BCD.3050407@openwrt.org>
References: <1321825151-16053-1-git-send-email-juhosg@openwrt.org>
        <1321825151-16053-4-git-send-email-juhosg@openwrt.org>
        <4ECA25CD.3050902@mvista.com>
        <4ECA3BCD.3050407@openwrt.org>
Date:   Mon, 21 Nov 2011 14:58:50 +0100
Message-ID: <CAEWqx5_Zep8QwS2t32BpygbqXx0exE4kTsH07J=vW2zr7rVO_w@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] MIPS: ath79: make ath724x_pcibios_init visible for
 external code
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17321

The sob tag is only for persons that are involved in the development
of the patch.

Acked-by: Rene Bolldorf <xsecute@googlemail.com>

On Mon, Nov 21, 2011 at 12:53 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
> Hi Sergei,
>
>>> --- /dev/null
>>> +++ b/arch/mips/include/asm/mach-ath79/pci.h
>>> @@ -0,0 +1,20 @@
>>> +/*
>>> + *  Atheros 724x PCI support
>>> + *
>>> + *  Copyright (C) 2011 René Bolldorf<xsecute@googlemail.com>
>>
>>    No signoff from him? He seems to be the original author...
>
> I have added him to CC, so he can ACK/NACK the patch. However I'm not aware of
> any rule which states that each patch must be signed off by the original authors
> of the modified code.
>
> I have missed something?
>
> -Gabor
>
