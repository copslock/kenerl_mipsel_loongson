Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jan 2018 09:11:31 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:35640
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeATILYFc1Jt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jan 2018 09:11:24 +0100
Received: by mail-it0-x244.google.com with SMTP id e1so4679946ita.0;
        Sat, 20 Jan 2018 00:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CX/nd72GXTZrX0yoCQkB7DTwF5iATzDyEFASk15qBtI=;
        b=EqU0jSTQW5j8ZleRW1kY7/ee8qg+lmb5PACLJqCrPAk3kxeIQyzBc0NcrCyJYZKHnC
         7YgsPIxTWx72/opMZPezL43S2LYCJeBZJN1KrIQcuq6XZT/QK8X7aq7h4J0qK1mqtjGV
         YQJsiz9+IXo9C7LBZHFje94l2vmXbnfOCEgBT2iiOKYnt421yr/JrKuShZ9ARrbAGPU9
         DEzyeFYSyn3mnDjANO092ncUyxr8o/TD3WR7pUXciWLsnCBhveaesjngos0PJhxuMaFM
         lpf3ebLgwHVmmrYfbs5dOaX00Cr3bCzqrKoenON0q83tyZao2SvKONgPzXeXqC2Iet1h
         g4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CX/nd72GXTZrX0yoCQkB7DTwF5iATzDyEFASk15qBtI=;
        b=qYdwPuqxjQCSv03se83MAqJjjs0PEH3CmYvY3lTz47DScl+E2N/Jz415uT4qZHm9vs
         NaUND2r4xWtDTx7791FeyEj5aRtgMK4aW1J0Rct/SE17F5B6keqvYptoLp4qCP7sy3g+
         DlimntTKGLrqyprRhFB17qFwAuNLvARwRmZRYFLrWvGjSgMhUJkQZCYkx/dQ68XrbGRg
         OmbBguvDWBLwR+7KVSNVGdXlf74Dl6bnE3Miav/2wZ5C6Fdi2BT3SJQWRAkginVNZU/T
         LqVg8HgzC4EPNW8rocoo5K3eBEX7reZHIz8gVUnw/sRniLUPgDHpMgXyRkKbkRD8Z5iN
         PgmA==
X-Gm-Message-State: AKwxytfJdi6yQ6AWnPZEx3j8x0bnlJXrwTIKX6DuaDx8JGAYkcTS/Plb
        wctSd9g9SJ047EVv7N7zQ6FOGeW/yl0YXvUwVr8=
X-Google-Smtp-Source: AH8x227HFOHUCForWdLC+JrqyyEzT6HGAo/ECwoxke18kqb1W5Tg6tDNwD9WSlhjA3nGfEmEXtc1XVfgZVpwZv01Kn4=
X-Received: by 10.36.93.136 with SMTP id w130mr916562ita.106.1516435877643;
 Sat, 20 Jan 2018 00:11:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.9 with HTTP; Sat, 20 Jan 2018 00:11:17 -0800 (PST)
In-Reply-To: <CAL_JsqJHHPJY0Yg+kmMbjZVsq=VVC0dPgtvXoN+sxL9gjBtMLA@mail.gmail.com>
References: <20171228212954.2922-1-malat@debian.org> <20171228212954.2922-2-malat@debian.org>
 <20180103200211.u56tqesyumsofoff@rob-hp-laptop> <CANc+2y5Y9fYh5V5OG_o+-92-uLYew7yNObLGTYPhGyx2eExywA@mail.gmail.com>
 <CAL_JsqJHHPJY0Yg+kmMbjZVsq=VVC0dPgtvXoN+sxL9gjBtMLA@mail.gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 20 Jan 2018 13:41:17 +0530
Message-ID: <CANc+2y4xTo7GyPw0bP=qJ6UqG4Z9u2xYbN2-jSB+z1XQs52w8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
To:     Rob Herring <robh@kernel.org>
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
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62259
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

On 11 January 2018 at 20:38, Rob Herring <robh@kernel.org> wrote:
> On Sat, Jan 6, 2018 at 6:43 AM, PrasannaKumar Muralidharan
> <prasannatsmkumar@gmail.com> wrote:
>> Hi Rob,
>>
>> On 4 January 2018 at 01:32, Rob Herring <robh@kernel.org> wrote:
>>> On Thu, Dec 28, 2017 at 10:29:52PM +0100, Mathieu Malaterre wrote:
>>>> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>>>
>>>> This patch brings support for the JZ4780 efuse. Currently it only expose
>>>> a read only access to the entire 8K bits efuse memory.
>>>>
>>>> Tested-by: Mathieu Malaterre <malat@debian.org>
>>>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>>> ---
>>>>  .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
>>>>  .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
>>>
>>> Please split bindings to separate patch.
>>>
>>>>  MAINTAINERS                                        |   5 +
>>>>  arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
>>>
>>> dts files should also be separate.
>>>
>>>>  drivers/nvmem/Kconfig                              |  10 +
>>>>  drivers/nvmem/Makefile                             |   2 +
>>>>  drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
>>>>  7 files changed, 383 insertions(+), 12 deletions(-)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>>>  create mode 100644 Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.txt
>>>>  create mode 100644 drivers/nvmem/jz4780-efuse.c
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-driver-jz4780-efuse b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>>> new file mode 100644
>>>> index 000000000000..bb6f5d6ceea0
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-driver-jz4780-efuse
>>>> @@ -0,0 +1,16 @@
>>>> +What:                /sys/devices/*/<our-device>/nvmem
>>>> +Date:                December 2017
>>>> +Contact:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>>> +Description: read-only access to the efuse on the Ingenic JZ4780 SoC
>>>> +             The SoC has a one time programmable 8K efuse that is
>>>> +             split into segments. The driver supports read only.
>>>> +             The segments are
>>>> +             0x000   64 bit Random Number
>>>> +             0x008  128 bit Ingenic Chip ID
>>>> +             0x018  128 bit Customer ID
>>>> +             0x028 3520 bit Reserved
>>>> +             0x1E0    8 bit Protect Segment
>>>> +             0x1E1 2296 bit HDMI Key
>>>> +             0x300 2048 bit Security boot key
>>>
>>> Why do these need to be exposed to userspace?
>>>
>>> sysfs is 1 value per file and this is lots of different things.
>>>
>>> We already have ways to feed random data (entropy) to the system. And we
>>> have a way to expose SoC ID info to userspace (socdev).
>>
>> Currently ingenic chip id is not used anywhere. The vendor BSP exposed
>> only chip id and customer id. Should we do the same? Please provide
>> your suggestion.
>
> No. Don't create an ABI if you don't really need it.

Rob,
MAC address of the ethernet device is stored in customer id segment of
efuse. So only customer id is needed. Do you think exposing customer
id would suffice?

Srini,
Only user would be dm900 ethernet driver (need to make changes to it
once the efuse driver goes in). There is no need to expose it to user
space. I am planning to modify nvmem core to not expose efuse if the
efuse driver chooses so. Do you think it makes sense? The need to
maintain ABI for user space disappears if such a change is introduced.

Thanks,
PrasannaKumar
