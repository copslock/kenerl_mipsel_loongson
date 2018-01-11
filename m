Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jan 2018 16:09:17 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992002AbeAKPJI49BCN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Jan 2018 16:09:08 +0100
Received: from mail-qk0-f169.google.com (mail-qk0-f169.google.com [209.85.220.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB8521104;
        Thu, 11 Jan 2018 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB8521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qk0-f169.google.com with SMTP id r8so4639118qke.6;
        Thu, 11 Jan 2018 07:08:59 -0800 (PST)
X-Gm-Message-State: AKwxytdwbp74sy3rXqiC3FoVRWYc2rR2sc+jy4D57UIKjPcrFuy9AePX
        qgywVPl1p3oMnlT1PdZDMvDtceQrtLxR6CcTVQ==
X-Google-Smtp-Source: ACJfBovot1X9Hwq4kRit8ahFahAw5ysBlZBpdePacH3eK3HfqgRQnJRSdEmum5yJb3j9tlQULcd8ua7slB08IiwyWJA=
X-Received: by 10.55.76.84 with SMTP id z81mr514711qka.296.1515683338431; Thu,
 11 Jan 2018 07:08:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.149.88 with HTTP; Thu, 11 Jan 2018 07:08:37 -0800 (PST)
In-Reply-To: <CANc+2y5Y9fYh5V5OG_o+-92-uLYew7yNObLGTYPhGyx2eExywA@mail.gmail.com>
References: <20171228212954.2922-1-malat@debian.org> <20171228212954.2922-2-malat@debian.org>
 <20180103200211.u56tqesyumsofoff@rob-hp-laptop> <CANc+2y5Y9fYh5V5OG_o+-92-uLYew7yNObLGTYPhGyx2eExywA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Jan 2018 09:08:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHHPJY0Yg+kmMbjZVsq=VVC0dPgtvXoN+sxL9gjBtMLA@mail.gmail.com>
Message-ID: <CAL_JsqJHHPJY0Yg+kmMbjZVsq=VVC0dPgtvXoN+sxL9gjBtMLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62060
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

On Sat, Jan 6, 2018 at 6:43 AM, PrasannaKumar Muralidharan
<prasannatsmkumar@gmail.com> wrote:
> Hi Rob,
>
> On 4 January 2018 at 01:32, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Dec 28, 2017 at 10:29:52PM +0100, Mathieu Malaterre wrote:
>>> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>>
>>> This patch brings support for the JZ4780 efuse. Currently it only expose
>>> a read only access to the entire 8K bits efuse memory.
>>>
>>> Tested-by: Mathieu Malaterre <malat@debian.org>
>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>>  .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
>>>  .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
>>
>> Please split bindings to separate patch.
>>
>>>  MAINTAINERS                                        |   5 +
>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
>>
>> dts files should also be separate.
>>
>>>  drivers/nvmem/Kconfig                              |  10 +
>>>  drivers/nvmem/Makefile                             |   2 +
>>>  drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
>>>  7 files changed, 383 insertions(+), 12 deletions(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>>  create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>>>  create mode 100644 drivers/nvmem/jz4780-efuse.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-driver-jz4780-efuse b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>> new file mode 100644
>>> index 000000000000..bb6f5d6ceea0
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>> @@ -0,0 +1,16 @@
>>> +What:                /sys/devices/*/<our-device>/nvmem
>>> +Date:                December 2017
>>> +Contact:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>> +Description: read-only access to the efuse on the Ingenic JZ4780 SoC
>>> +             The SoC has a one time programmable 8K efuse that is
>>> +             split into segments. The driver supports read only.
>>> +             The segments are
>>> +             0x000   64 bit Random Number
>>> +             0x008  128 bit Ingenic Chip ID
>>> +             0x018  128 bit Customer ID
>>> +             0x028 3520 bit Reserved
>>> +             0x1E0    8 bit Protect Segment
>>> +             0x1E1 2296 bit HDMI Key
>>> +             0x300 2048 bit Security boot key
>>
>> Why do these need to be exposed to userspace?
>>
>> sysfs is 1 value per file and this is lots of different things.
>>
>> We already have ways to feed random data (entropy) to the system. And we
>> have a way to expose SoC ID info to userspace (socdev).
>
> Currently ingenic chip id is not used anywhere. The vendor BSP exposed
> only chip id and customer id. Should we do the same? Please provide
> your suggestion.

No. Don't create an ABI if you don't really need it.

>
>>> +Users:               any user space application which wants to read the Chip
>>> +             and Customer ID
>>> diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>>> new file mode 100644
>>> index 000000000000..cd6d67ec22fc
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>>> @@ -0,0 +1,17 @@
>>> +Ingenic JZ EFUSE driver bindings
>>> +
>>> +Required properties:
>>> +- "compatible"               Must be set to "ingenic,jz4780-efuse"
>>> +- "reg"                      Register location and length
>>> +- "clocks"           Handle for the ahb clock for the efuse.
>>> +- "clock-names"              Must be "bus_clk"
>>> +
>>> +Example:
>>> +
>>> +efuse: efuse@134100d0 {
>>> +     compatible = "ingenic,jz4780-efuse";
>>> +     reg = <0x134100D0 0xFF>;
>>> +
>>> +     clocks = <&cgu JZ4780_CLK_AHB2>;
>>> +     clock-names = "bus_clk";
>>> +};
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a6e86e20761e..7a050c20c533 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -6902,6 +6902,11 @@ M:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>>  S:   Maintained
>>>  F:   drivers/dma/dma-jz4780.c
>>>
>>> +INGENIC JZ4780 EFUSE Driver
>>> +M:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>> +S:   Maintained
>>> +F:   drivers/nvmem/jz4780-efuse.c
>>
>> Binding file?
>
> Sorry, missed it. Will add it.
>
>>> +
>>>  INGENIC JZ4780 NAND DRIVER
>>>  M:   Harvey Hunt <harveyhuntnexus@gmail.com>
>>>  L:   linux-mtd@lists.infradead.org
>>> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> index 9b5794667aee..3fb9d916a2ea 100644
>>> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
>>> @@ -224,21 +224,37 @@
>>>               reg = <0x10002000 0x100>;
>>>       };
>>>
>>> -     nemc: nemc@13410000 {
>>> -             compatible = "ingenic,jz4780-nemc";
>>> -             reg = <0x13410000 0x10000>;
>>> -             #address-cells = <2>;
>>> +
>>> +     ahb2: ahb2 {
>>> +             compatible = "simple-bus";
>>
>> This is an unrelated change and should be its own patch.
>
> The efuse register address range is a subset of address range of nemc.
> So decided to make nemc and efuse as nodes with parent node ahb2. This
> is required for efuse driver to work. I am not able to understand what
> you mean by unrelated change. Can you please explain it?
>
>>> +             #address-cells = <1>;
>>>               #size-cells = <1>;
>>> -             ranges = <1 0 0x1b000000 0x1000000
>>> -                       2 0 0x1a000000 0x1000000
>>> -                       3 0 0x19000000 0x1000000
>>> -                       4 0 0x18000000 0x1000000
>>> -                       5 0 0x17000000 0x1000000
>>> -                       6 0 0x16000000 0x1000000>;
>>> +             ranges = <>;
>>> +
>>> +             nemc: nemc@13410000 {
>>> +                     compatible = "ingenic,jz4780-nemc";
>>> +                     reg = <0x13410000 0x10000>;
>>> +                     #address-cells = <2>;
>>> +                     #size-cells = <1>;
>>> +                     ranges = <1 0 0x1b000000 0x1000000
>>> +                               2 0 0x1a000000 0x1000000
>>> +                               3 0 0x19000000 0x1000000
>>> +                               4 0 0x18000000 0x1000000
>>> +                               5 0 0x17000000 0x1000000
>>> +                               6 0 0x16000000 0x1000000>;
>>> +
>>> +                     clocks = <&cgu JZ4780_CLK_NEMC>;
>>> +
>>> +                     status = "disabled";
>>> +             };
>>>
>>> -             clocks = <&cgu JZ4780_CLK_NEMC>;
>>> +             efuse: efuse@134100d0 {
>>> +                     compatible = "ingenic,jz4780-efuse";
>>> +                     reg = <0x134100d0 0xff>;
>>
>> You are creating an overlapping region here with nemc above. Don't do
>> that.
>
> Should "reg = <0x13410000 0x10000>;" be used instead?

No, that still overlaps with nemc. What's in registers 0x00-0xcf and
0x1d0-0xffff? Either get rid of this node altogether and make the
driver for nemc also instantiate the efuse driver (DT is not the only
way to instantiate drivers), or create sub-nodes under nemc for each
distinct h/w block in the 13410000-13420000 address space.

Or a third option is make nemc reg:

reg = <0x13410000 0xd0>, <0x134101d0 0xfe30>;

But I suspect that is wrong and you probably have some other function in there.

Rob
