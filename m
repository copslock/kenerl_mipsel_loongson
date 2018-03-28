Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 18:29:22 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992368AbeC1Q3Ml61qf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 18:29:12 +0200
Received: from mail-qt0-f173.google.com (mail-qt0-f173.google.com [209.85.216.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A117F217D2;
        Wed, 28 Mar 2018 16:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A117F217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qt0-f173.google.com with SMTP id f8so3153038qtg.12;
        Wed, 28 Mar 2018 09:29:05 -0700 (PDT)
X-Gm-Message-State: AElRT7Ew13cHhVlWa8fiWwMrjuiQiA979kHsFTOSAod6BcaD1MaGGB1B
        yaLhWjYf6jtqwk6VRwqGl5i8qsELt4vT+SFjrA==
X-Google-Smtp-Source: AIpwx4+kI9gNJgrInC85Z1zvn31uilY5yxb6BsWvhXOKJ8xGHYQHcNMn2iILlYKfW1D8hliMvxOnSBnIeQob6E0HYfc=
X-Received: by 10.200.58.167 with SMTP id x36mr6231605qte.11.1522254544797;
 Wed, 28 Mar 2018 09:29:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.213.166 with HTTP; Wed, 28 Mar 2018 09:28:44 -0700 (PDT)
In-Reply-To: <3765e5a86b80b2a1888cabee623e5d0c@crapouillou.net>
References: <20180110224838.16711-2-paul@crapouillou.net> <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-5-paul@crapouillou.net> <20180327144631.j2bugsjxulkv57ws@rob-hp-laptop>
 <3765e5a86b80b2a1888cabee623e5d0c@crapouillou.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Mar 2018 11:28:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLA8WbYZ49_oVb-uVgwUixVqDw2wtLy2tkyQwBM3ow5ew@mail.gmail.com>
Message-ID: <CAL_JsqLA8WbYZ49_oVb-uVgwUixVqDw2wtLy2tkyQwBM3ow5ew@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] dt-bindings: Add doc for the Ingenic TCU drivers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63293
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

On Wed, Mar 28, 2018 at 10:33 AM, Paul Cercueil <paul@crapouillou.net> wrote:
> Le 2018-03-27 16:46, Rob Herring a écrit :
>>
>> On Sun, Mar 18, 2018 at 12:28:57AM +0100, Paul Cercueil wrote:
>>>
>>> Add documentation about how to properly use the Ingenic TCU
>>> (Timer/Counter Unit) drivers from devicetree.
>>>
>>> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>> ---
>>>  .../bindings/clock/ingenic,tcu-clocks.txt          | 42 ++++++++++++++++
>>>  .../bindings/interrupt-controller/ingenic,tcu.txt  | 39 +++++++++++++++
>>>  .../devicetree/bindings/mfd/ingenic,tcu.txt        | 56
>>> ++++++++++++++++++++++
>>>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 41 ++++++++++++++++
>>>  4 files changed, 178 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/clock/ingenic,tcu-clocks.txt
>>>  create mode 100644
>>> Documentation/devicetree/bindings/interrupt-controller/ingenic,tcu.txt
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/ingenic,tcu.txt
>>>  create mode 100644
>>> Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>>>
>>>  v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>>>  added content.
>>> +/ {
>>> +       tcu: mfd@10002000 {
>>> +               compatible = "ingenic,tcu", "simple-mfd", "syscon";
>>> +               reg = <0x10002000 0x1000>;
>>> +               #address-cells = <1>;
>>> +               #size-cells = <1>;
>>> +               ranges = <0x0 0x10002000 0x1000>;
>>> +
>>> +               tcu_timer: timer@10 {
>>> +                       compatible = "ingenic,jz4740-tcu";
>>> +                       reg = <0x10 0xff0>;
>>> +
>>> +                       clocks = <&tcu_clk 0>, <&tcu_clk 1>, <&tcu_clk
>>> 2>, <&tcu_clk 3>,
>>> +                                        <&tcu_clk 4>, <&tcu_clk 5>,
>>> <&tcu_clk 6>, <&tcu_clk 7>;
>>> +                       clock-names = "timer0", "timer1", "timer2",
>>> "timer3",
>>> +                                                 "timer4", "timer5",
>>> "timer6", "timer7";
>>> +
>>> +                       interrupt-parent = <&tcu_irq>;
>>> +                       interrupts = <0 1 2 3 4 5 6 7>;
>>
>>
>> Thinking about this some more... You simply have 8 timers (and no other
>> functions?) with some internal clock and irq controls for each timer. I
>> don't think it really makes sense to create separate clock and irq
>> drivers in that case. That would be like creating clock drivers for
>> every clock divider in timers, pwms, uarts, etc. Unless the clocks get
>> exposed to other parts of the system, then there is no point.
>
>
> I have 8 timers with some internal clock and IRQ controls, that can be used
> as PWM.

Please include how you plan to do the PWM support too. I need a
complete picture of the h/w, not piecemeal, evolving bindings.

> But the TCU also controls the IRQ of the OS Timer (which is
> separate),
> as well as masking of the clocks for the OS timer and the watchdog.

The OS timer and watchdog are different blocks outside the TCU? This
doesn't seem to be the case based on the register definitions.

> I thought having clean drivers for different frameworks working on the same
> regmap was cleaner than having one big-ass driver handling everything.

DT is not the only way to instantiate drivers and how one OS splits
drivers should not define your DT binding. An MFD driver can create
child devices and a single DT node can be a provider of multiple
things. It is appropriate for an MFD to have child nodes primarily
when the sub devices need their own resources defined as properties in
DT or when the sub device is an IP block reused in multiple devices.
Just to have a node per driver/provider is not what should drive the
decision.

Rob
