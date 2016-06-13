Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 08:08:26 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34838 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27039636AbcFMGIYUvw-E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 08:08:24 +0200
Received: by mail-wm0-f65.google.com with SMTP id k184so12105329wme.2;
        Sun, 12 Jun 2016 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GHSMNL7Iq1b1o8ZH1ii+T2bgr4tvQggiLvJKvq10Wg8=;
        b=ZB7FNK+BPB92nVmWQoAhMKMmzxDbpztzp+3EWhSUhJ6hD7UcGLfqEwOOzDIc+mTbFR
         KOohNygCGvsphlne7Oq2aebcdGiqw88GxUAO3x6gF1zECinC1HOL2/sC6AFqzBraVDbo
         dkj6RgAkVH9MaDkrOR/gS1nUu8rQxcdZ70exJFLggGkjIw+CMetUI4+MvbwL0TaJNtzJ
         fAS8o9cqFb86aC5qrsu1EmoDDKMF8ZcIAzbH37nYkCPwgL1XqPv5CjsDF48XAbf1In7a
         ySHJqBMKnniX2mbkaIJ61Lm5ZWQByzCEyP4IG6eiyaFpk7dAHFjpTwEf0FeRFRymhJuE
         PCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GHSMNL7Iq1b1o8ZH1ii+T2bgr4tvQggiLvJKvq10Wg8=;
        b=TchxTIqknwU8+WXedQVtr9FajCyL2dpIve4LEzQBQNtanaEmM2FFf96N39amEB8K1K
         MCwbR1AaCrhgcosx1Zd8pe+PLMJsHtAmwuEnBRGCF/7XJbXKERlY/y4NEuBwgaHh3fNm
         GR1nxziuGAlrqGKS1/MT8LdnyAywS9fhB2npCj67bIlcAtc//HcmdjwgiDVHnvfWxqV+
         mu4OKlDD+y7UHs7tKBonwsIuay/V/wRPPmOHv9LAadCRb3Je+kQ8GI8wfPNSSE/qD9DX
         gliifgjYiDRFeiH1Yo3nIqQWla9SlyQqBz5qfeshp1O1VbEs94dKEfFvC2AGxz6nR3Eq
         OTyA==
X-Gm-Message-State: ALyK8tKF92V2QED+xRXfX3x8lNHFOm1aVysRpMzWR4DF61yXNAEpVZmJ3KOGK77v9PsIXA==
X-Received: by 10.28.38.198 with SMTP id m189mr9955019wmm.34.1465798098989;
        Sun, 12 Jun 2016 23:08:18 -0700 (PDT)
Received: from MacBook-Pro-de-Alvaro.local ([46.222.221.91])
        by smtp.gmail.com with ESMTPSA id ue1sm4832717wjc.44.2016.06.12.23.08.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 12 Jun 2016 23:08:18 -0700 (PDT)
Subject: Re: [PATCH 2/3] MIPS: BMIPS: Add BCM6345 support
To:     Jonas Gorski <jogo@openwrt.org>
References: <1464941524-3992-1-git-send-email-noltari@gmail.com>
 <1464941524-3992-2-git-send-email-noltari@gmail.com>
 <CAOiHx=nu-5_CeHn8dki+v9nrP8uN2QH13gcNsejYKpt7dsmX2w@mail.gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh@kernel.org>, Simon Arlott <simon@fire.lp0.eu>
From:   =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>
Message-ID: <575E4DD7.7020204@gmail.com>
Date:   Mon, 13 Jun 2016 08:08:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <CAOiHx=nu-5_CeHn8dki+v9nrP8uN2QH13gcNsejYKpt7dsmX2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <noltari@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noltari@gmail.com
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

On a second thought I think I'll postpone adding support for BMIPS3300 SoCs since I failed booting latest kernel on a BCM6348.
I'll resend only patch 1/3 on a new patch series.

Álvaro.

El 3/6/16 a las 13:46, Jonas Gorski escribió:
> Hi,
> 
> On 3 June 2016 at 10:12, Álvaro Fernández Rojas <noltari@gmail.com> wrote:
>> BCM6345 has only one CPU, so SMP support must be disabled.
>>
>> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>>  arch/mips/bmips/setup.c                             | 9 +++++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> index 4a7e030..1936e8a 100644
>> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
>> @@ -4,7 +4,7 @@ Required properties:
>>
>>  - compatible: "brcm,bcm3384", "brcm,bcm33843"
>>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
>> -              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
>> +              "brcm,bcm6328", "brcm,bcm6345", "brcm,bcm6358", "brcm,bcm6368",
>>                "brcm,bcm63168", "brcm,bcm63268",
>>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
> 
> This is reasonable.
> 
>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>> index f146d12..b0d339d 100644
>> --- a/arch/mips/bmips/setup.c
>> +++ b/arch/mips/bmips/setup.c
>> @@ -95,6 +95,14 @@ static void bcm6328_quirks(void)
>>                 bcm63xx_fixup_cpu1();
>>  }
>>
>> +static void bcm6345_quirks(void)
>> +{
>> +       /*
>> +        * BCM6345 has only one CPU and no SMP support
>> +        */
>> +       bmips_smp_enabled = 0;
>> +}
>> +
>>  static void bcm6358_quirks(void)
>>  {
>>         /*
>> @@ -113,6 +121,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
>>         { "brcm,bcm3384-viper",         &bcm3384_viper_quirks           },
>>         { "brcm,bcm33843-viper",        &bcm3384_viper_quirks           },
>>         { "brcm,bcm6328",               &bcm6328_quirks                 },
>> +       { "brcm,bcm6345",               &bcm6345_quirks                 },
>>         { "brcm,bcm6358",               &bcm6358_quirks                 },
>>         { "brcm,bcm6368",               &bcm6368_quirks                 },
>>         { "brcm,bcm63168",              &bcm6368_quirks                 },
> 
> This part is unnecessary, as cpu-bmips will only try to enable smp for
> bmips4350 and higher. but not for bmips32/bmips3300.
> 
> 
> Jonas
> 
