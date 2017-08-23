Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 17:15:18 +0200 (CEST)
Received: from mail-io0-x243.google.com ([IPv6:2607:f8b0:4001:c06::243]:34171
        "EHLO mail-io0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993892AbdHWPPIt67ml (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 17:15:08 +0200
Received: by mail-io0-x243.google.com with SMTP id p141so254299iop.1;
        Wed, 23 Aug 2017 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HspPv1xwZ/qdR09G0xfKC1G1q7W6G5IiyJFaILJyYxM=;
        b=SGSIADy1fMtcZ0oGgeMNRH42O/ghA2Oel6V84ODky0xkiZ3PE/Rd4i6oYhwPCMUDal
         QvO0adTFihX513oSpiiwQinJTMyZbunw8SLPBNt9N0/S/xl+08xmXWpq/sXhZr/NvUov
         kHXYvTYc/MSGUpbnxTcWWSXdlcC0pzU2o6sQ5A1qPDBAq1ToB471gWS6h179QuXPeSsQ
         nDtczgbN5FS/z5DEhlJ4CUTwutNlSX2SqauJnbCxgWGo1gZNHIlImv3lBEeBnY8DAILz
         2Yb5tuy9wA5YSfRV9zyiOaDaBeRtpDhTHh7vQPwoyL/u3Xw/N+CLMKvOO8vdpCYP7PVk
         GQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HspPv1xwZ/qdR09G0xfKC1G1q7W6G5IiyJFaILJyYxM=;
        b=DAO7pDP3wdudMCd/5QeGu4uOIxY1RkKrIx0dt4Ucrq6+LnRHGymJOuyIm4gdwcJFQi
         8uf0vPLMYeNQmFgiiSRnIXpiJS8JUaVtLnhgPMhMTda5Kb/GrlcJnu27y/t0WYlNzWTp
         QNI/JnSSmh4XRvh3c7UxXGkzQv/J6zH1cJr2jSlaMuvc7BzPxkUfCjw9HQ9yK+SrBp8j
         5egShbeT0Lm240oz/NdYAkK8GPvUAaaq720Io6FHX95xcZYPwID9MEmkgONqS3pv6D9A
         XJCUJbiva5PVEUxKx1QQn39DfzJzzU1tG/hYFuddvErdj0WqnbBnIWRYViK6dnlbvK4h
         zs1g==
X-Gm-Message-State: AHYfb5gCaL7kbnMmkUUm6P0BuAxAnotakPnT6uL0cI8rKubugdvRE6Di
        VR46AG9deh+47ZYNyZOtpN3hOC6fOQ==
X-Received: by 10.107.130.151 with SMTP id m23mr2604658ioi.339.1503501300894;
 Wed, 23 Aug 2017 08:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.14.197 with HTTP; Wed, 23 Aug 2017 08:15:00 -0700 (PDT)
In-Reply-To: <02fb41c2-c740-ec2c-d82f-aabecfa798ea@imgtec.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-5-prasannatsmkumar@gmail.com> <9da7ab8b-aa81-e012-596c-54355758da83@imgtec.com>
 <CANc+2y6LPFf6a-oJJ8=Sf59mCOH0q2s6Na5zCAMhnBAiOMjDcQ@mail.gmail.com> <02fb41c2-c740-ec2c-d82f-aabecfa798ea@imgtec.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 23 Aug 2017 20:45:00 +0530
Message-ID: <CANc+2y5qkx0mk4P1y-sEgYGAxBAAz_d7WtOcHa0Wh2h9AGe33Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] crypto: jz4780-rng: Enable PRNG support in CI20 defconfig
To:     Harvey Hunt <Harvey.Hunt@imgtec.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, Mathieu Malaterre <malat@debian.org>,
        noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59774
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

Hi Harvey,

On 23 August 2017 at 20:21, Harvey Hunt <Harvey.Hunt@imgtec.com> wrote:
> Hi PrasannaKumar,
>
>
> On 23/08/17 15:50, PrasannaKumar Muralidharan wrote:
>>
>> Hi Harvey,
>>
>> On 23 August 2017 at 14:39, Harvey Hunt <Harvey.Hunt@imgtec.com> wrote:
>>>
>>> Hi PrasannaKumar,
>>>
>>> On 23/08/17 03:57, PrasannaKumar Muralidharan wrote:
>>>>
>>>>
>>>> Enable PRNG driver support in MIPS Creator CI20 default config.
>>>>
>>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>>> ---
>>>> No changes in v2
>>>>
>>>>    arch/mips/configs/ci20_defconfig | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/arch/mips/configs/ci20_defconfig
>>>> b/arch/mips/configs/ci20_defconfig
>>>> index b42cfa7..9f48f2c 100644
>>>> --- a/arch/mips/configs/ci20_defconfig
>>>> +++ b/arch/mips/configs/ci20_defconfig
>>>> @@ -88,6 +88,11 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=5
>>>>    CONFIG_SERIAL_8250_INGENIC=y
>>>>    CONFIG_SERIAL_OF_PLATFORM=y
>>>>    # CONFIG_HW_RANDOM is not set
>>>> +CONFIG_CRYPTO_USER=y
>>>> +CONFIG_CRYPTO_USER_API=y
>>>> +CONFIG_CRYPTO_USER_API_RNG=y
>>>> +CONFIG_CRYPTO_HW=y
>>>> +CONFIG_CRYPTO_DEV_JZ4780_RNG=y
>>>>    CONFIG_I2C=y
>>>>    CONFIG_I2C_JZ4780=y
>>>>    CONFIG_GPIO_SYSFS=y
>>>>
>>>
>>> You need to regenerate your defconfig as it is missing CONFIG_MFD_SYSCON.
>>>
>>> Thanks,
>>>
>>> Harvey
>>
>>
>> CONFIG_MFD_SYSCON gets selected when CONFIG_CRYPTO_DEV_JZ4780_RNG is
>> selected. Please see the Kconfig changes. Given that should I add it
>> in ci20_defconfig? If it is required I will add and send a new
>> version.
>
>
> Oops, I hadn't noticed that - just skimmed the patches before my morning
> coffee. :-)
>
> It's fine as is, excuse the noise.

No issues.

>
>>
>> Thanks,
>> PrasannaKumar
>>
>
> Thanks,
>
> Harvey
>

Regards,
PrasannaKumar
