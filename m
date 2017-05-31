Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 23:04:48 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:41048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992213AbdEaVEkkOT4O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 31 May 2017 23:04:40 +0200
Received: from mail-yb0-f171.google.com (mail-yb0-f171.google.com [209.85.213.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C824623A15;
        Wed, 31 May 2017 21:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C824623A15
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-yb0-f171.google.com with SMTP id 130so6662907ybl.3;
        Wed, 31 May 2017 14:04:38 -0700 (PDT)
X-Gm-Message-State: AODbwcAzYLR+MJ+WFOzLokd0RaxWB4JS7vUcSQwOGcFtFGoC53Bt48up
        ehSaOXmsfegRKJNIqo1xM61Ip+6eCA==
X-Received: by 10.37.172.82 with SMTP id r18mr10020595ybd.109.1496264677873;
 Wed, 31 May 2017 14:04:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.215.145 with HTTP; Wed, 31 May 2017 14:04:17 -0700 (PDT)
In-Reply-To: <6b8bb1cd-c090-435d-d150-d53edf04d2df@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de> <20170528184006.31668-8-hauke@hauke-m.de>
 <20170531200540.joludfqpy35yc5yy@rob-hp-laptop> <6b8bb1cd-c090-435d-d150-d53edf04d2df@hauke-m.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 May 2017 16:04:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL=iapYifAhDcYSLRGyevx7RxGiUtji72NJD-uYCQnCdw@mail.gmail.com>
Message-ID: <CAL_JsqL=iapYifAhDcYSLRGyevx7RxGiUtji72NJD-uYCQnCdw@mail.gmail.com>
Subject: Re: [PATCH v3 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        John Crispin <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        hauke.mehrtens@intel.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58111
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

On Wed, May 31, 2017 at 3:13 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 05/31/2017 10:05 PM, Rob Herring wrote:
>> On Sun, May 28, 2017 at 08:39:57PM +0200, Hauke Mehrtens wrote:
>>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>
>>> This adds the initial documentation for the RCU module (a MFD device
>>> which provides USB PHYs, reset controllers and more).
>>>
>>> The RCU register range is used for multiple purposes. Mostly one device
>>> uses one or multiple register exclusively, but for some registers some
>>> bits are for one driver and some other bits are for a different driver.
>>> With this patch all accesses to the RCU registers will go through
>>> syscon.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 97 ++++++++++++++++++++++
>>>  1 file changed, 97 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>> new file mode 100644
>>> index 000000000000..3e2461262218
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
>>> @@ -0,0 +1,97 @@
>>> +Lantiq XWAY SoC RCU binding
>>> +===========================
>>> +
>>> +This binding describes the RCU (reset controller unit) multifunction device,
>>> +where each sub-device has it's own set of registers.
>>> +
>>> +The RCU register range is used for multiple purposes. Mostly one device
>>> +uses one or multiple register exclusively, but for some registers some
>>> +bits are for one driver and some other bits are for a different driver.
>>> +With this patch all accesses to the RCU registers will go through
>>> +syscon.
>>> +
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Required properties:
>>> +- compatible        : The first and second values must be: "simple-mfd", "syscon"
>>> +- reg               : The address and length of the system control registers
>>> +
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Example of the RCU bindings on a xRX200 SoC:
>>> +    rcu0: rcu@203000 {
>>> +            compatible = "lantiq,rcu-xrx200", "simple-mfd", "syscon";
>>> +            reg = <0x203000 0x100>;
>>> +            big-endian;
>>> +
>>> +            gphy0: gphy@0 {
>>
>> Unit address without reg address is not valid.
>>
>>> +                    compatible = "lantiq,xrx200a2x-rcu-gphy";
>>> +
>>> +                    regmap = <&rcu0>;
>>> +                    offset = <0x20>;
>>
>> Does reg not work instead?
>
> Is it ok to access some registers in this range with a reg = <0x20 0x04>
> setting and some others through syscon? This specific register is only
> used by this gphy, but the reset controller shares the register with
> some other drivers like the watchdog driver.

Yes. The main thing is you need to use reg where you have unit addresses.

For the syscon-reboot, you could also just not describe in DT and have
the reset ctrlr driver register reboot driver. DT is not the only way
to instantiate drivers.

Rob
