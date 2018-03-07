Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:54:58 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:37848
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994726AbeCGOyvJMhvt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 15:54:51 +0100
Received: by mail-it0-x242.google.com with SMTP id k79so3718703ita.2;
        Wed, 07 Mar 2018 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MQ4IOgzk/r1eddcvz8OpLRnh/vJ+4kBIhrdVW3DObNU=;
        b=WvmnYy304lSymaqp3l5U7E/zneM4McKOlHIGVmOOYkC0Itx2rAILUAmAsH0cFpgwTZ
         ObMS9IIrz956mRWPFv36Xjo9IBQKz6U6F4aAj8XAnfw601ebdsQ4v0fM/5iHdYngCdp2
         aCYxbTuHIojNXB5Ozw5wQEGoegV/Vc3e0AV0sZyB7aGd7ZyBzPo7bAqxcryrykbMLGBq
         13Yc+94YRgez++cBj1+srLqbuiuHiEVFJap6ARqF5ckBm5gywvXCQuYvYGsHisO70QuI
         este1Kv3G+RZ+R/z/ww4i8h4M8VBqpJuc3+UxTjQ6ww1EhcpnsGUX7VkcchfHkotTRQB
         DbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MQ4IOgzk/r1eddcvz8OpLRnh/vJ+4kBIhrdVW3DObNU=;
        b=KA+rpg8/5lldgRoHpz/WLCpjvt1g1gYFDdvwmAurrwsev+fHA/7ycKJm6c3Ga6M3Km
         KL0cvMCkGe9MHwI0SFC9htSuxFbaib4Uxg5W87/fnfCRvYdixsqwYnHC5RVqtFPY58ru
         DxVzFAXBXpGjCxeEEhw9l8BR6scSj9N6dIxT9xonGckVTGIOjSg4USrf7vYQ975+VlIe
         uw6A30/fF/pgVlB2w7ucRj5C45HpjhdtgCTfBSgaz/fMsrJEuGTD/K07MPorsf329GPm
         D9BS0qykP7v3VZS2ngJTDJvALyXW3CnpqI+HXwKd4esR+qHzKK+NjIoHqr1AresE8hXc
         yKDA==
X-Gm-Message-State: AElRT7GY/pogKImV9i5cgwgiFVxRgW1+d3m/H3BxVGnt050eeYVC1neo
        p/GlTBBUuN3FMHqm5KnK8DySLMCLrk7yEsHJHA0=
X-Google-Smtp-Source: AG47ELuyOG+1/0H7xRpgBR3GRrwz4oiHAYe/SNOSJ2Omqoa++ghAp456DESGfiwJj3rBIXglt2hR5QMjBA+3fn60LIQ=
X-Received: by 10.36.225.72 with SMTP id n69mr24656429ith.82.1520434483938;
 Wed, 07 Mar 2018 06:54:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 06:54:43 -0800 (PST)
In-Reply-To: <CAL_JsqJiNpnVC7X=viKZRjEJBe8ZEp0mJLDKhPYKugoxpiQJNQ@mail.gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com> <20180306091932.GM4197@saruman>
 <CAL_JsqJiNpnVC7X=viKZRjEJBe8ZEp0mJLDKhPYKugoxpiQJNQ@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 20:24:43 +0530
Message-ID: <CANc+2y63OnEkgXC43zDq3Fw34QxxTY3yz3Dag8fAE3muX7cpEw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
To:     Rob Herring <robh+dt@kernel.org>
Cc:     James Hogan <jhogan@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Miller <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Rob,

On 6 March 2018 at 19:25, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 6, 2018 at 3:32 AM, James Hogan <jhogan@kernel.org> wrote:
>> On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan wrote:
>>> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
>>> the register set used by Ingenic CGU driver. Use regmap in RNG driver to
>>> access its register. Create 'simple-bus' node, make CGU and RNG node as
>>> child of it so that both the nodes are visible without changing CGU
>>> driver code.
>
> The goal should be to avoid changing the DT (because the h/w hasn't
> changed), not avoid changing a driver.

Please have a look at the discussion happened at
https://patchwork.linux-mips.org/patch/14094/. Looks like there is a
difference in though process between you and mips folks. I am not an
expert in DT so please suggest me the correct way to go about this.

>>>
>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>
>> Better late than never:
>> Acked-by: James Hogan <jhogan@kernel.org>
>>
>> (I presume its okay for the reg ranges to overlap, ISTR that being an
>> issue a few years ago, but maybe thats fixed now).
>
> No, that should be avoided. It does work because we have existing
> cases that have to be supported.

I am sorry but I require guidance here. Do you have any suggestion on
how this should be.

>>
>> Cheers
>> James

Thanks and regards,
PrasannaKumar
