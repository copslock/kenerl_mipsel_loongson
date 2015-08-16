Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Aug 2015 23:10:54 +0200 (CEST)
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33562 "EHLO
        mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012016AbbHPVKwcw7Om convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Aug 2015 23:10:52 +0200
Received: by ykll84 with SMTP id l84so46860626ykl.0
        for <linux-mips@linux-mips.org>; Sun, 16 Aug 2015 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2WT5CW223/Sv/jf9wZyACzoF1kxtE6LoDjfPejjAyME=;
        b=gh1FYe9182EezcI8AlnONJ1AK7cYyKn+5rpCikiXySpem4EbzHII75opY1hGGqXkKZ
         WBGKCpzaKdfwTe0W4rQihhfRGfEMsJ39/vADngPpPDp3U8ibVWlqfHIB0rvBpUlYmu/C
         P/dOu4s/wDqgOWLyNIilnQjKCOY5c/+l30pbdisnGU9vC09VP0O9LFaD2zRXLXRQ3TGE
         1PhLxaImoyCx6C2fg5sqxQxzto7S+FNFYqEMzJOE82ZEfjoMn2Q7B7P2MzdAgL/uOfsE
         4fgdygzria8qNPZmBljgDbIeShZqALLJA990KjxOHtlHfVT5vq+vPZKlW7MwAisB2L8l
         BOxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=2WT5CW223/Sv/jf9wZyACzoF1kxtE6LoDjfPejjAyME=;
        b=JydQodlWYG9k2Wl4Btlgv6EXH5O9ceZPlakEY6tbrdKeTa7NZUVenQSv48dJgdPI1l
         vmw99Ix2IZ7efR8ikzI7fk1xfH7i6trodIxrI4x9mJCFSPRtwxJjLXvgLzuIApqq5xOz
         1prb3FdOFCDXduL96i8X/tb6MMUaJLzhCM06A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2WT5CW223/Sv/jf9wZyACzoF1kxtE6LoDjfPejjAyME=;
        b=jZ2CAovB/XMT1lRGumXSQlMAOo6Fx4ZYbcz/sHPzBB9OhuL5UDKNwdMfgIxcIy9Deq
         5ESMAiOeYbU9FW6sB5C3SbEc+T8Mii/g6U+Bx9B11b8rOrec929E2/1HJfn/lgA8VkUE
         zr94omM9BtOeCYKnxJijOTlv5tYoN7HLYqyWLrVc0M2O9dtkzyHKKIOooYGSzFIsSXcC
         8WqmaktcCDaNo6e67btVW6OBtO5e1wu2Z0UtnNlrUCWrq+FGE2DwZ3ti4KGuTV3/1UaA
         0AV2RRD4hWwKJ/K9Ex3Hv6HWDiYOaeRR2jtFxAEj7ujHXWwc6S0Nxbegc+xt76IGDUl0
         J5JA==
X-Gm-Message-State: ALoCoQlmZPUNiAkwpqFu3rGBzYfdzKy8dGsCPV8LcciRTVeutBEoDyF/aVJQgYyYZdcenIXx/d64
MIME-Version: 1.0
X-Received: by 10.13.229.197 with SMTP id o188mr2950384ywe.30.1439759446540;
 Sun, 16 Aug 2015 14:10:46 -0700 (PDT)
Received: by 10.37.209.129 with HTTP; Sun, 16 Aug 2015 14:10:46 -0700 (PDT)
In-Reply-To: <1522710.BT6Gc0L6oH@diego>
References: <1439541232-30100-1-git-send-email-shawn.lin@rock-chips.com>
        <1439541275-30146-1-git-send-email-shawn.lin@rock-chips.com>
        <1522710.BT6Gc0L6oH@diego>
Date:   Sun, 16 Aug 2015 14:10:46 -0700
X-Google-Sender-Auth: _T2fWDI0HfknlA6gcqusr3Xp8DM
Message-ID: <CAD=FV=W1dzqoJuJtJsD5TPKmSBpUbBcifGz654o9x8J1rX6-GQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/9] mmc: dw_mmc: Add external dma interface support
From:   Doug Anderson <dianders@chromium.org>
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Russell King <linux@arm.linux.org.uk>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jun Nie <jun.nie@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <dianders@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Heiko,

On Fri, Aug 14, 2015 at 3:13 PM, Heiko Stübner <heiko@sntech.de> wrote:
> Hi Shawn,
>
> Am Freitag, 14. August 2015, 16:34:35 schrieb Shawn Lin:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> judging by your "from", I guess you're running this on some older Rockchip soc
> without the idma? Because I tried testing this on a Radxa Rock, but only got
> failures, from the start (failed to read card status register). In PIO mode
> everything works again.
>
>
> I guess I overlooked just some tiny detail, but to me the dma channel ids seem
> correct after all. Maybe you have any hints what I'm doing wrong?

If I were a guessing man (which I'm not), I'd guess that perhaps
you're running into troubles with our friend the PL330.

There appear to be strange issues with the PL330 on Rockchip SoCs.  I
was only peripherally involved with them, but I know at least about
some of the patches in our tree, like:

https://chromium-review.googlesource.com/237607
FROMLIST: DMA: pl330: support burst mode for dev-to-mem and mem-to-dev transmit

https://chromium-review.googlesource.com/237393
CHROMIUM: dmaengine: pl330: support quirks for some broken

https://chromium-review.googlesource.com/237396
CHROMIUM: dmaengine: pl330: add quirk for broken no flushp

https://chromium-review.googlesource.com/237394
CHROMIUM: ARM: dts: rockchip: Add broken-no-flushp into rk3288.dtsi

https://chromium-review.googlesource.com/242063
CHROMIUM: ASoC: rockchip_i2s: modify DMA max burst to 1
