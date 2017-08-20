Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Aug 2017 18:12:31 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:36451
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993179AbdHTQMTXFytG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 20 Aug 2017 18:12:19 +0200
Received: by mail-it0-x241.google.com with SMTP id 190so279322itx.3;
        Sun, 20 Aug 2017 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=siiGZRMTAyA+LNy94epWLBK6cjYEjeIAF3lTjBy4JEg=;
        b=dem7x/AWxqO02xzIHGsB5YgHhsD408HiuvBXeEYZzo9I+JRmK3IZjYs5R7lq+w8K6a
         TOf0vhuVR5/ZBAyMfN3wbHGKEZR/UI5n70eE2kH7dstkT2HYhP0lFQvoiZ1gNmHTm5mx
         597IUT6sy9Un/mON3DPBRJzQJtsiAQbeaMH/pOAhFvPN/LGmDCNqVBfVJidujs0qaltl
         acAADR0qqByyw0+y56rGiC/il8A8HPm6lK5hNpNoXA1iRddUvLlCJBuLhgsvQHt+6V8j
         euPlZja5YVihs6zkfO5M/EzICsKuRE0p6V03l5F5yY/2mFPDjVROsdSxlI5aRBaVjhn9
         RGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=siiGZRMTAyA+LNy94epWLBK6cjYEjeIAF3lTjBy4JEg=;
        b=tSd+p45lBS9LcY88zVT9RT1hGLXcZGh2VHe4l7dvk/9PyGDNu9bmg69/P4dvix9I/h
         4Yf00fYLsPDfzB6JMHenoASu8ERI8aMped0OPdpPg9NFmxSFLKG5Lv9lOsEH0fZX8q6t
         OVYAJTWZORS0TI3r2KhhGjRgnJnuGqvehvhlf3tgF2eCY3tpG4rSRXD3gBx5wvWKZUxT
         9cXe5eBuJknfQSaqmMiepksLA1iDNULj3wqNMjuysAWfqviDqk8mhIZ0vdap8gVedhL6
         PenSPG8tNoZTfMfc5Joh/fUig4UEKbfM7Z1aHoL9SvurIeELW2F1hs0X0l4RocoOOwE4
         FLfw==
X-Gm-Message-State: AHYfb5hKJa4M0QfEMBOavmP3JSTDtpwEZqhPIZrTeCEpWI4jmiRVCkNF
        u6hhmkSaM5k4TKQwoP9kAmdgbr2OAA==
X-Received: by 10.36.10.66 with SMTP id 63mr3546738itw.61.1503245533471; Sun,
 20 Aug 2017 09:12:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.14.197 with HTTP; Sun, 20 Aug 2017 09:12:12 -0700 (PDT)
In-Reply-To: <3563032.h0vdzx9HfC@np-p-burton>
References: <20170817182520.20102-1-prasannatsmkumar@gmail.com>
 <20170817182520.20102-3-prasannatsmkumar@gmail.com> <3563032.h0vdzx9HfC@np-p-burton>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sun, 20 Aug 2017 21:42:12 +0530
Message-ID: <CANc+2y6tRe_kkWyGX+-BT-ugb5JiZhKpPoHWkAn=2ZC6cb6uKA@mail.gmail.com>
Subject: Re: [PATCH 2/6] crypto: jz4780-rng: Make ingenic CGU driver use syscon
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org, "David S . Miller" <davem@davemloft.net>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59716
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

Thanks for your review.

On 19 August 2017 at 02:18, Paul Burton <paul.burton@imgtec.com> wrote:
> Hi PrasannaKumar,
>
> On Thursday, 17 August 2017 11:25:16 PDT PrasannaKumar Muralidharan wrote:
>> Ingenic PRNG registers are a part of the same hardware block as clock
>> and power stuff. It is handled by CGU driver. Ingenic M200 SoC has power
>> related registers that are after the PRNG registers. So instead of
>> shortening the register range use syscon interface to expose regmap.
>> This regmap is used by the PRNG driver.
>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> ---
>>  arch/mips/boot/dts/ingenic/jz4740.dtsi | 14 +++++++----
>>  arch/mips/boot/dts/ingenic/jz4780.dtsi | 14 +++++++----
>>  drivers/clk/ingenic/cgu.c              | 46
>> +++++++++++++++++++++------------- drivers/clk/ingenic/cgu.h              |
>>  9 +++++--
>>  drivers/clk/ingenic/jz4740-cgu.c       | 30 +++++++++++-----------
>>  drivers/clk/ingenic/jz4780-cgu.c       | 10 ++++----
>>  6 files changed, 73 insertions(+), 50 deletions(-)
>>
>> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> b/arch/mips/boot/dts/ingenic/jz4740.dtsi index 2ca7ce7..ada5e67 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
>> @@ -34,14 +34,18 @@
>>               clock-frequency = <32768>;
>>       };
>>
>> -     cgu: jz4740-cgu@10000000 {
>> -             compatible = "ingenic,jz4740-cgu";
>> +     cgu_registers {
>> +             compatible = "simple-mfd", "syscon";
>>               reg = <0x10000000 0x100>;
>>
>> -             clocks = <&ext>, <&rtc>;
>> -             clock-names = "ext", "rtc";
>> +             cgu: jz4780-cgu@10000000 {
>> +                     compatible = "ingenic,jz4740-cgu";
>>
>> -             #clock-cells = <1>;
>> +                     clocks = <&ext>, <&rtc>;
>> +                     clock-names = "ext", "rtc";
>> +
>> +                     #clock-cells = <1>;
>> +             };
>>       };
>>
>>       rtc_dev: rtc@10003000 {
>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> b/arch/mips/boot/dts/ingenic/jz4780.dtsi index 4853ef6..1301694 100644
>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>> @@ -34,14 +34,18 @@
>>               clock-frequency = <32768>;
>>       };
>>
>> -     cgu: jz4780-cgu@10000000 {
>> -             compatible = "ingenic,jz4780-cgu";
>> +     cgu_registers {
>> +             compatible = "simple-mfd", "syscon";
>>               reg = <0x10000000 0x100>;
>>
>> -             clocks = <&ext>, <&rtc>;
>> -             clock-names = "ext", "rtc";
>> +             cgu: jz4780-cgu@10000000 {
>> +                     compatible = "ingenic,jz4780-cgu";
>>
>> -             #clock-cells = <1>;
>> +                     clocks = <&ext>, <&rtc>;
>> +                     clock-names = "ext", "rtc";
>> +
>> +                     #clock-cells = <1>;
>> +             };
>>       };
>>
>>       pinctrl: pin-controller@10010000 {
>> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
>> index e8248f9..2f12c7c 100644
>> --- a/drivers/clk/ingenic/cgu.c
>> +++ b/drivers/clk/ingenic/cgu.c
>> @@ -29,6 +29,18 @@
>>
>>  #define MHZ (1000 * 1000)
>>
>> +unsigned int cgu_readl(struct ingenic_cgu *cgu, unsigned int reg)
>> +{
>> +     unsigned int val = 0;
>> +     regmap_read(cgu->regmap, reg, &val);
>> +     return val;
>> +}
>> +
>> +int cgu_writel(struct ingenic_cgu *cgu, unsigned int val, unsigned int reg)
>> +{
>> +     return regmap_write(cgu->regmap, reg, val);
>> +}
>
> This is going to introduce a lot of overhead to the CGU driver - each
> regmap_read() or regmap_write() call will not only add overhead from the
> indirection but also acquire a lock which we really don't need.
>

Indeed.

> Could you instead perhaps:
>
>  - Just add "syscon" as a second compatible string to the CGU node in the
>    device tree, but otherwise leave it as-is without the extra cgu_registers
>    node.
>
>  - Have your RNG device node as a child of the CGU node, which should let it
>    pick up the regmap via syscon_node_to_regmap() as it already does.
>
>  - Leave the CGU driver as-is, so it can continue accessing memory directly
>    rather than via regmap.
>

As per my understanding, CGU driver and syscon will map the same
register set. Is that fine?

Thanks,
PrasannaKumar
