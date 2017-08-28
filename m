Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 20:31:47 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993921AbdH1SbgJREYr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Aug 2017 20:31:36 +0200
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5470521A95;
        Mon, 28 Aug 2017 18:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5470521A95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qt0-f174.google.com with SMTP id x36so5918866qtx.2;
        Mon, 28 Aug 2017 11:31:34 -0700 (PDT)
X-Gm-Message-State: AHYfb5j7AhYlknLp3ceh1ZYhgscwyID/9teNG5Wtgw77e/bl62UOvVxm
        1oltUhFNRbv5WLLst7TPyjkLy7rvVA==
X-Received: by 10.237.62.237 with SMTP id o42mr2255238qtf.87.1503945093459;
 Mon, 28 Aug 2017 11:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.153.1 with HTTP; Mon, 28 Aug 2017 11:31:12 -0700 (PDT)
In-Reply-To: <CANc+2y7pD7EkSS-9ky4YDxGjk3wGW1PVZje2UXMRuOQJA=S+HA@mail.gmail.com>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-2-prasannatsmkumar@gmail.com> <20170825215734.f5rc7fzxpl3ynnwl@rob-hp-laptop>
 <CANc+2y7pD7EkSS-9ky4YDxGjk3wGW1PVZje2UXMRuOQJA=S+HA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Aug 2017 13:31:12 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YO2DRVqudNuigefikkKZiv066wW6cM8qbn5Y31t-WTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+YO2DRVqudNuigefikkKZiv066wW6cM8qbn5Y31t-WTQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] crypto: jz4780-rng: Add JZ4780 PRNG devicetree
 binding documentation
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-crypto@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Mathieu Malaterre <malat@debian.org>, noloader@gmail.com
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Aug 25, 2017 at 10:20 PM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> Hi Rob,
>
> On 26 August 2017 at 03:27, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Aug 23, 2017 at 08:27:04AM +0530, PrasannaKumar Muralidharan wrote:
>>> Add devicetree bindings for hardware pseudo random number generator
>>> present in Ingenic JZ4780 SoC.
>>>
>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>> ---
>>> Changes in v2:
>>> * Add "syscon" in CGU node's compatible section
>>> * Make RNG child node of CGU.
>>>
>>>  .../bindings/crypto/ingenic,jz4780-rng.txt           | 20 ++++++++++++++++++++
>>
>> bindings/rng/ for RNG h/w.
>
> There are two subsystem for dealing with RNG hw. Hw_random subsystem
> for true RNG (driver/char/hw_random) and crypto framework for pseudo
> RNG (crypto/ and drviers/crypto). This HW is pseudo RNG so I have
> placed the dt bindings in bindings/crypto as the driver itself is in
> drivers/crypto folder. I am wondering if there is any relation between
> driver folder and bindings folder. Can you please explain the folder
> relation? Should this be put in bindings/rng or bindings/crypto?

There's not a 1-1 relationship though obviously there's a lot of
overlap. I'd still say this should go in bindings/rng.

>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>>> new file mode 100644
>>> index 0000000..a0c18e5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>>> @@ -0,0 +1,20 @@
>>> +Ingenic jz4780 RNG driver
>>> +
>>> +Required properties:
>>> +- compatible : Should be "ingenic,jz4780-rng"
>>> +
>>> +Example:
>>> +
>>> +cgu: jz4780-cgu@10000000 {
>>> +     compatible = "ingenic,jz4780-cgu", "syscon";
>>> +     reg = <0x10000000 0x100>;
>>> +
>>> +     clocks = <&ext>, <&rtc>;
>>> +     clock-names = "ext", "rtc";
>>> +
>>> +     #clock-cells = <1>;
>>> +
>>> +     rng: rng@d8 {
>>
>> unit-address requires reg property.
>
> The driver uses regmap to access the registers. In this case reg
> property is not useful. Is reg property still needed? If not, how
> should the node be declared?

What the driver (currently) does is irrelevant to the binding. Your
choice is either add the reg property or name the node just "rng".
Either is fine, but better to have more information than less IMO.

Rob
