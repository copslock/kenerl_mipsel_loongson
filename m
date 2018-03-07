Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 15:51:17 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:37809
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994721AbeCGOvKoxt5t convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 15:51:10 +0100
Received: by mail-it0-x244.google.com with SMTP id k79so3702976ita.2;
        Wed, 07 Mar 2018 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCR0DgGaxpCxrCi4t8ladQtdydum9A4BrZxxWh80bE0=;
        b=QDKvzrj8OJPirXGIaOsp0LaJjh7EqBc/+nbuv77ubUl4d2jVvQZwsHK/rOCXFM0xkw
         H6U2gdBe6CPIRMbvLcO8D7pNcV+pn0EIoFiHHh+JYcfAp58CfKuiFfTLQPWaSsx7G2TE
         oq/Tdv/QmujIj9WL9XyKYCT9+6W7XqA8iwISov2IRbDSAybCphYhcQIPLNpnTLXn4x2O
         aOLvvQhlIugOHCuyUs+wKxup3dg39Hzmx6BS/STrbPEV8Zlepqw9p+kY0E9voFcDeEjK
         WuE/ZbdqrqTNS0nBvzBwVH9ZmswR8wYK/eqF5sLNYqvHnjVgVLdkubrw9cT0RvcH/5CQ
         A0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCR0DgGaxpCxrCi4t8ladQtdydum9A4BrZxxWh80bE0=;
        b=kN00acpumTFwOLbPh8aRWUVVsSwt6iTTT/4v9yFtL6XN2CRYZXhEdD5O+v5lT+G4eS
         bG7KiX69Rn0Ss5oJjOakAVfbpQiVYwmyX1bxvqgXJNhcOZFgZdVsBu8/t1n6tyQNP7C6
         IbLURZ0wod27u10vylZOsZKbeXXvAS0OuwznDMMqetJcB/rhu7p101pNrIcqa3HYo+Oa
         aNzcNMr6Y6qpueBo/leNeQf88/WfzK/s2K7vFwP22iCdrGvwSGKADKbyG+M6iW7q/jmw
         s6fnRUUkotWC9T8MQJnerZvith55SjIZjORr+gF5/6e9KyNBERz68EYbEljZ7vUoby0N
         tqiQ==
X-Gm-Message-State: AElRT7GGC7Cxz964basOMZHDbwyBp8c9FE/ck8HkMWaWYTjqmyp9Rcwf
        D9227AWrvFy7kjQdzeYyyIrqjlT8k7lhb35YJ4E=
X-Google-Smtp-Source: AG47ELumVjb9Pft2k54b6Vg3Pta0wOslQkEO++onXcDlcP1BQByClCNG86166nrUzFoGyUokIJNDE9+cLeiEEF1UsCc=
X-Received: by 10.36.84.3 with SMTP id t3mr24738837ita.136.1520434264212; Wed,
 07 Mar 2018 06:51:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 06:51:03 -0800 (PST)
In-Reply-To: <788bf0bf0d0aaa97f59bc908ebf34ebf@crapouillou.net>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20170918140241.24003-4-prasannatsmkumar@gmail.com> <20180306091932.GM4197@saruman>
 <788bf0bf0d0aaa97f59bc908ebf34ebf@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 20:21:03 +0530
Message-ID: <CANc+2y7m0Z0Nnwv31gGd_PFAyKpSxfi2YY7Ngk_K86Qnr_tvyQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] crypto: jz4780-rng: Add RNG node to jz4780.dtsi
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     James Hogan <jhogan@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S . Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62832
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

Hi Paul,

On 7 March 2018 at 04:31, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2018-03-06 10:32, James Hogan a écrit :
>>
>> On Mon, Sep 18, 2017 at 07:32:40PM +0530, PrasannaKumar Muralidharan
>> wrote:
>>>
>>> Add RNG node to jz4780 dtsi. This driver uses registers that are part of
>>> the register set used by Ingenic CGU driver. Use regmap in RNG driver to
>>> access its register. Create 'simple-bus' node, make CGU and RNG node as
>>> child of it so that both the nodes are visible without changing CGU
>>> driver code.
>>>
>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>
>>
>> Better late than never:
>> Acked-by: James Hogan <jhogan@kernel.org>
>>
>> (I presume its okay for the reg ranges to overlap, ISTR that being an
>> issue a few years ago, but maybe thats fixed now).
>>
>> Cheers
>> James
>
>
> What bothers me is that the CGU code has not been modified to use regmap, so
> the
> registers area is actually mapped twice (once in the CGU driver, once with
> regmap).

One of my previous versions changed CGU code to use regmap. I got a
review comment saying that is not required
(https://patchwork.kernel.org/patch/9906889/). The points in the
comment were valid so I reverted the change. Please have a look at the
discussion.

> Besides, regmap would be useful if the RNG registers were actually located
> in the
> middle of the register area used by the CGU driver, which is not the case
> here.
> The CGU block does have some registers after the RNG ones on the X1000 SoC,
> but
> I don't think they will ever be used (and if they are it won't be by the CGU
> driver).
>
> Regards,
> -Paul

Ingenic M200 SoC's CGU has clock and power related registers after the
RNG registers. Paul Burton suggested using regmap to expose registers
to CGU and RNG drivers
(https://patchwork.linux-mips.org/patch/14094/).

Regards,
PrasannaKumar
