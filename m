Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Nov 2017 15:46:20 +0100 (CET)
Received: from mail-io0-x22d.google.com ([IPv6:2607:f8b0:4001:c06::22d]:39785
        "EHLO mail-io0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990487AbdKYOqKCD000 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Nov 2017 15:46:10 +0100
Received: by mail-io0-x22d.google.com with SMTP id x63so31999666ioe.6;
        Sat, 25 Nov 2017 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xIxNngNtXB1K5R+zuN1xZd1Q62J4uPGS88vHns69gPs=;
        b=I2Hf3M2F/6EVL3n7CHQKa4duEWe6i8YKoBOxq/30qvtVJ5qU5TBBj3ZRKeFweQgWx4
         yjtimkMEi6tvOu6aRybGCqDh5Tkb/ywcbovMApjWM55+N7GdEZaP2/VIaKxSqELWsR7T
         h53KDi+xJoq+uY2BknOgke1wOWsOweh1EmjCN2ws/jXVY1qkpK/FjiJBAqToXZ++mvYr
         dLJWSzsFgrC3IPcF52WV38oHC/KHeHsaJAi5M1n5yhtoL+E1rrVEx/dmxeJLaU/Mnkn8
         e1gm6JMesSP5QbTVwYwPg0Sg2xlMSo3EbJD0uQvOhPl6PlUsXsNtueRUAtcbu7wxc6I0
         at4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xIxNngNtXB1K5R+zuN1xZd1Q62J4uPGS88vHns69gPs=;
        b=qBEZJ+qroJup1UKkdCXHc/aBsRIVAulHaz/9YwUT/yQXluiLEawYKNC1IUOxmQOSpZ
         aQstgJ/IGn1WFN7j4gMowoS5tNNxtS6wcPzCxNuYdKsvgmkicI1/GEf7DUMUApxo3Dmd
         Gotj6nkkdKXqgMX6WIE6Piijax+QYq8haW5VABjTzvStG6WlXhTtEuH38NXgcDNmLeou
         z5k8UmsrzzfxHk2CySpZ5/1lJ3aRB14l48uGHQ+CBh6zoN+Nmj42FZbsR7JyA+BxFIRw
         jBYkSwjfiJ5NxWZ8cCQQCaCKhUu3NLoiOpNjEqGjlktHskkN7ELu7kE2jXhBZE7+1yo7
         lnsg==
X-Gm-Message-State: AJaThX6sGIAzpKgjx/RyJuymyBCgnLqsgYE6OZp5tbwxeq0y+H9kgiqp
        +nmO+/k1aT+NEGTXyfhgNDCFAi7Jzdb/lYeEBMk=
X-Google-Smtp-Source: AGs4zMYCZjXu5LQwgmgn0+LBQiLiSBuAoIoJl5eQ+UXuR8sof+LSWkaLlNx5tisxPUB+CFnn0ra0vDH1ER3J0vg2hRo=
X-Received: by 10.107.97.16 with SMTP id v16mr33387362iob.263.1511621163561;
 Sat, 25 Nov 2017 06:46:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.169.20 with HTTP; Sat, 25 Nov 2017 06:46:03 -0800 (PST)
In-Reply-To: <CANc+2y5VzWx+kLBO+=aWHLE5OGAGvuB_eVAzJ52ZVy79ad9Nxg@mail.gmail.com>
References: <20170918140241.24003-1-prasannatsmkumar@gmail.com>
 <20171012143011.GA30173@gondor.apana.org.au> <CANc+2y5VzWx+kLBO+=aWHLE5OGAGvuB_eVAzJ52ZVy79ad9Nxg@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 25 Nov 2017 20:16:03 +0530
Message-ID: <CANc+2y6DSjrsQj9kSz1go4-v+WVG2YcxeDc6Ehgm-bbf4qG+=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] crypto: Add driver for JZ4780 PRNG
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S . Miller" <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, linux-mips@linux-mips.org,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61076
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

Hi Ralf,

On 12 October 2017 at 22:59, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> Hi Herbert,
>
> On 12 October 2017 at 20:00, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Mon, Sep 18, 2017 at 07:32:37PM +0530, PrasannaKumar Muralidharan wrote:
>>> This patch series adds support of pseudo random number generator found
>>> in Ingenic's JZ4780 and X1000 SoC.
>>>
>>> Create cgublock node which has CGU and RNG node as its children. The
>>> cgublock node uses "simple-bus" compatible which helps in exposing CGU
>>> and RNG nodes without changing CGU driver. Add 'syscon' compatible in
>>> CGU node in jz4780.dtsi. The jz4780-rng driver uses regmap exposed via
>>> syscon interface to access the RNG registers. CGU driver is not
>>> modified in this patch set as registers used by CGU driver and this
>>> driver are different.
>>>
>>> PrasannaKumar Muralidharan (4):
>>>   crypto: jz4780-rng: Add JZ4780 PRNG devicetree binding documentation
>>>   crypto: jz4780-rng: Add Ingenic JZ4780 hardware PRNG driver
>>>   crypto: jz4780-rng: Add RNG node to jz4780.dtsi
>>>   crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
>>
>> Please indicate which patches are intended to go through the crypto
>> trees.
>
> From https://patchwork.linux-mips.org/patch/17162/ I expect the same.
> Either all patches go via crypto tree or via mips tree.
> The dtsi changes is not yet acked by MIPS / JZ4780 maintainer. Let's
> wait for it.
>
> Thanks,
> PrasannaKumar

Should I do anything more for this series?

Thanks,
PrasannaKumar
