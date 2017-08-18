Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 16:05:14 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:36882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994915AbdHROE56RrmK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Aug 2017 16:04:57 +0200
Received: from mail-qt0-f180.google.com (mail-qt0-f180.google.com [209.85.216.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428FC22CB4;
        Fri, 18 Aug 2017 14:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428FC22CB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qt0-f180.google.com with SMTP id b4so6340297qta.1;
        Fri, 18 Aug 2017 07:04:56 -0700 (PDT)
X-Gm-Message-State: AHYfb5guBYOtMNZLtEHL8HTY6Yd1FuuM/wphKFF73AV/KZM5MfunBfx3
        Dvc0UThHahjJPsHhn3LgmAtXg+6e3w==
X-Received: by 10.200.34.100 with SMTP id p33mr13157536qtp.87.1503065095450;
 Fri, 18 Aug 2017 07:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.153.1 with HTTP; Fri, 18 Aug 2017 07:04:34 -0700 (PDT)
In-Reply-To: <97c83648-3710-cb9a-a065-9fbe8dd1b734@imgtec.com>
References: <1502814530-40604-1-git-send-email-harvey.hunt@imgtec.com>
 <20170817213426.34shgxwnjowcg4sk@rob-hp-laptop> <97c83648-3710-cb9a-a065-9fbe8dd1b734@imgtec.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2017 09:04:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+NZWkvibcL+CFWD8curFDKF2=bBzyCVsRyyiFOFwNBbg@mail.gmail.com>
Message-ID: <CAL_Jsq+NZWkvibcL+CFWD8curFDKF2=bBzyCVsRyyiFOFwNBbg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: dts: ralink: Add Mediatek MT7628A SoC
To:     Harvey Hunt <Harvey.Hunt@imgtec.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59665
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

On Fri, Aug 18, 2017 at 4:42 AM, Harvey Hunt <Harvey.Hunt@imgtec.com> wrote:
> Hi Rob,
>
> Thanks for the review.
>
>
> On 17/08/17 22:34, Rob Herring wrote:
>>
>> On Tue, Aug 15, 2017 at 05:28:50PM +0100, Harvey Hunt wrote:
>>>
>>> The MT7628A is the successor to the MT7620 and pin compatible with the
>>> MT7688A, although the latter supports only a 1T1R antenna rather than
>>> a 2T2R antenna.

[...]

>>> +               uartlite@c00 {
>>
>>
>> serial@c00
>>
>> And so on. IOW, use standard, generic node names as defined in the DT
>> spec.
>
>
>
> The clocks for the UARTs are using the device names "uartlite", "uart1" and
> "uart2" (as defined in arch/mips/ralink/mt7620.c).

You can't add clocks to the DT? Looks like mt76x8 at least should be
pretty easy with some fixed clocks.

Depending if backwards compatibility (old dtb working on new kernel)
is a concern on these platforms, you could just change all the names
both in the kernel and dts.

> Changing the name of the DT nodes causes the serial driver to bail as it
> can't find the clock for the device.
>
> arch/mips/boot/dts/ralink/mt7620a.dtsi is already using the uartlite name,
> although it hasn't been documented...

Generally the kernel shouldn't care what the names are (though you can
match by name, it's not widely used).

In any case, I guess fixing this can be done later.

Rob
