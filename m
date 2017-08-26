Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 05:20:59 +0200 (CEST)
Received: from mail-io0-x241.google.com ([IPv6:2607:f8b0:4001:c06::241]:38148
        "EHLO mail-io0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990451AbdHZDUvzEtpY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Aug 2017 05:20:51 +0200
Received: by mail-io0-x241.google.com with SMTP id m40so892776ioi.5;
        Fri, 25 Aug 2017 20:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hPbgbE/HervI07ymlzRX6Fo2mr9IsfNyfrMlghtPDkU=;
        b=f0MHsoTidX9+OGwtPzvpNgJdKijSZR+j3iP9ktDj2HZdLCwTadoJbUo60m2NiF19v3
         jQUHdsZrgWpPKWpu/cMdYAYQU3zkSXIBqIDOnRrV9FtBNReYVTNp2d57+iEVbPB27Q33
         uin64IKY/3bpefQGI0Z7RwZFyHyG1ihPGaHcWk01O1Bc1kJ+UkIMNCWUlQAS33Zm+Cwk
         Q8n37YI4aBxsuCykgLj1Blno+2fxyGkHjqazaJ/9u7mxXpZxV+x5/QBl1WF/9qBQpPvi
         3eivBd8iTpmR5MD3Z4aoDMGbj1obTF47lAUMTumEzlHmvmaucZcF0yQQDHRs2YQNXTFc
         ah6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hPbgbE/HervI07ymlzRX6Fo2mr9IsfNyfrMlghtPDkU=;
        b=CHlIZdQ6j7Wzr9yg4WGfaMyU7Cw+EZL1sanBAxYmcfMFSkt6q+Adiq0IqnC4dTKjeY
         XrI292NMSBEYPyBSNuxZNoctcT53Nsb3Mgl4w+Xc+TGtSI0FZpk4OwkWYm7xcCMS8e7C
         wRpZMSuT7gHr06LCmIo+G923KvCB599tNlkGc2ehL5ZxZPAiAKatw6hfFqEWcG201zF/
         jX8bS33OOy7/13Wi2u2XqcnfEa9YFh6MrGN6TGjJrRM0jgNaa4POE5C6xvCki2IO5/K6
         Tbe4TTzgGo5iq9HFv18zwfYLSPC/+ZPCn3mQTsGUNVAkfqSpdYeCJhmZ0F/TE4VqQ6sF
         MjkA==
X-Gm-Message-State: AHYfb5j8c/8OZWHFTKUrlL/bAnqeWVH7vh9+7J2bCivLVfkWss8hPmR7
        td/O7yY0LKsELQBdDpgJkGSEZn+1BQ==
X-Received: by 10.107.201.207 with SMTP id z198mr390668iof.132.1503717645947;
 Fri, 25 Aug 2017 20:20:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.2.22.72 with HTTP; Fri, 25 Aug 2017 20:20:45 -0700 (PDT)
In-Reply-To: <20170825215734.f5rc7fzxpl3ynnwl@rob-hp-laptop>
References: <20170823025707.27888-1-prasannatsmkumar@gmail.com>
 <20170823025707.27888-2-prasannatsmkumar@gmail.com> <20170825215734.f5rc7fzxpl3ynnwl@rob-hp-laptop>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 26 Aug 2017 08:50:45 +0530
Message-ID: <CANc+2y7pD7EkSS-9ky4YDxGjk3wGW1PVZje2UXMRuOQJA=S+HA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] crypto: jz4780-rng: Add JZ4780 PRNG devicetree
 binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
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
X-archive-position: 59808
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

On 26 August 2017 at 03:27, Rob Herring <robh@kernel.org> wrote:
> On Wed, Aug 23, 2017 at 08:27:04AM +0530, PrasannaKumar Muralidharan wrote:
>> Add devicetree bindings for hardware pseudo random number generator
>> present in Ingenic JZ4780 SoC.
>>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> ---
>> Changes in v2:
>> * Add "syscon" in CGU node's compatible section
>> * Make RNG child node of CGU.
>>
>>  .../bindings/crypto/ingenic,jz4780-rng.txt           | 20 ++++++++++++++++++++
>
> bindings/rng/ for RNG h/w.

There are two subsystem for dealing with RNG hw. Hw_random subsystem
for true RNG (driver/char/hw_random) and crypto framework for pseudo
RNG (crypto/ and drviers/crypto). This HW is pseudo RNG so I have
placed the dt bindings in bindings/crypto as the driver itself is in
drivers/crypto folder. I am wondering if there is any relation between
driver folder and bindings folder. Can you please explain the folder
relation? Should this be put in bindings/rng or bindings/crypto?

>
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>> new file mode 100644
>> index 0000000..a0c18e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/crypto/ingenic,jz4780-rng.txt
>> @@ -0,0 +1,20 @@
>> +Ingenic jz4780 RNG driver
>> +
>> +Required properties:
>> +- compatible : Should be "ingenic,jz4780-rng"
>> +
>> +Example:
>> +
>> +cgu: jz4780-cgu@10000000 {
>> +     compatible = "ingenic,jz4780-cgu", "syscon";
>> +     reg = <0x10000000 0x100>;
>> +
>> +     clocks = <&ext>, <&rtc>;
>> +     clock-names = "ext", "rtc";
>> +
>> +     #clock-cells = <1>;
>> +
>> +     rng: rng@d8 {
>
> unit-address requires reg property.

The driver uses regmap to access the registers. In this case reg
property is not useful. Is reg property still needed? If not, how
should the node be declared?

>
>> +             compatible = "ingenic,jz480-rng";
>> +     };
>> +};
>> --
>> 2.10.0
>>

Thanks,
PrasannaKumar
