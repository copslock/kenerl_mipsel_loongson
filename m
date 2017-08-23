Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 16:50:30 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:35076
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992974AbdHWOuOPOtwl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 16:50:14 +0200
Received: by mail-it0-x242.google.com with SMTP id 8so222164ity.2;
        Wed, 23 Aug 2017 07:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sHXa74kaKcYk2fr57h0HtPC57wP7E1j6lXElSMO7fBY=;
        b=RCJ0gCoKPkoZRJPBEQZQDoMQErdEO0ov1gNKqk5OYAzftkMJbGFPgRF8SCPlSWsbUu
         r9KxzG5J41Bi9CDcwAe8ByA8vwlMjiBIqxl0qaQEaozOC/7tVwmgy84qgi4BV2eKHFlL
         IyHfcYwCpSY8yt6pDCAZQKoo4p8mKLiSdk2DD2qxju08jwve+v4m3sJsVhlsD7p6J8cW
         8G0BN3TCqmL2mk7gGA9ic3hWnBtmdhwjUPo0dibBcbwFKykS6f1Ue9a5Mra8DIUfkf9i
         ezl/3DBMaJoLzP9g39DJTmTVG2YOZu9ktFpEWUPqKiKGLTLcP5sCce/oYfuVHpwfiMAM
         /vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sHXa74kaKcYk2fr57h0HtPC57wP7E1j6lXElSMO7fBY=;
        b=SbF9mQPSuYrLJL8BowJBcxP16qP+6boCg4g6vs8kh3nNylrqBIDXzEi85D+IJna6ma
         +srNm/sFJNriOvEjx0DAxc5QhMWU2lDHS6dwC/pPoI6W+0LKxDPrx0yQTZCBkqtgaUYu
         uktkp+sPdbwrgPxw7LimuXqUnjXljTwoMsvErwGqNDLs+j2JEAppmeLcKDVRX+JhbF+S
         ugQFn74wNUPWSnfxYwxpt41LqwomuRj+K5uIhn96y7uLiqrDDqHm6hyAcu/aZXtwqfmL
         vpIVZuS8+su6c6tUZnIuFYUWbjk/uMDc9iTiH0B4sf0hoBPqhLg62Hvw4Qd7DmGS1exg
         WcYw==
X-Gm-Message-State: AHYfb5guhKOkwPoIZSsfdn6qtDGtE36gdPdM2Jk59vyQyt9UEJajBC4p
        YpVvZJRBt0YpuFxS8SAsvO3u0Sb9pg==
X-Received: by 10.36.82.67 with SMTP id d64mr3158693itb.119.1503499808394;
 Wed, 23 Aug 2017 07:50:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.14.197 with HTTP; Wed, 23 Aug 2017 07:50:07 -0700 (PDT)
In-Reply-To: <9da7ab8b-aa81-e012-596c-54355758da83@imgtec.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-5-prasannatsmkumar@gmail.com> <9da7ab8b-aa81-e012-596c-54355758da83@imgtec.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 23 Aug 2017 20:20:07 +0530
Message-ID: <CANc+2y6LPFf6a-oJJ8=Sf59mCOH0q2s6Na5zCAMhnBAiOMjDcQ@mail.gmail.com>
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
X-archive-position: 59771
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

On 23 August 2017 at 14:39, Harvey Hunt <Harvey.Hunt@imgtec.com> wrote:
> Hi PrasannaKumar,
>
> On 23/08/17 03:57, PrasannaKumar Muralidharan wrote:
>>
>> Enable PRNG driver support in MIPS Creator CI20 default config.
>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> ---
>> No changes in v2
>>
>>   arch/mips/configs/ci20_defconfig | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/mips/configs/ci20_defconfig
>> b/arch/mips/configs/ci20_defconfig
>> index b42cfa7..9f48f2c 100644
>> --- a/arch/mips/configs/ci20_defconfig
>> +++ b/arch/mips/configs/ci20_defconfig
>> @@ -88,6 +88,11 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=5
>>   CONFIG_SERIAL_8250_INGENIC=y
>>   CONFIG_SERIAL_OF_PLATFORM=y
>>   # CONFIG_HW_RANDOM is not set
>> +CONFIG_CRYPTO_USER=y
>> +CONFIG_CRYPTO_USER_API=y
>> +CONFIG_CRYPTO_USER_API_RNG=y
>> +CONFIG_CRYPTO_HW=y
>> +CONFIG_CRYPTO_DEV_JZ4780_RNG=y
>>   CONFIG_I2C=y
>>   CONFIG_I2C_JZ4780=y
>>   CONFIG_GPIO_SYSFS=y
>>
>
> You need to regenerate your defconfig as it is missing CONFIG_MFD_SYSCON.
>
> Thanks,
>
> Harvey

CONFIG_MFD_SYSCON gets selected when CONFIG_CRYPTO_DEV_JZ4780_RNG is
selected. Please see the Kconfig changes. Given that should I add it
in ci20_defconfig? If it is required I will add and send a new
version.

Thanks,
PrasannaKumar
