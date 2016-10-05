Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2016 08:59:35 +0200 (CEST)
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32923 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbcJEG72goleu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Oct 2016 08:59:28 +0200
Received: by mail-vk0-f68.google.com with SMTP id z126so8346517vkd.0;
        Tue, 04 Oct 2016 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UGdoXYx+0lSklI6VQsXVIjkHXSi/rQA74r52KfDEris=;
        b=AR/OT7YV3X3sodlA8b8LawYaZ9yTZhoMb11oV1HHVzuHrDsBSpN467+ilavVlfEHzr
         wC/2X6I4C8+h1R69Fxda3KTN1kYlB3C+b0qUCT7MMwnCQmddpxhzd0+hUNosAZbMGgzp
         T4Og3UdFROdJyfPG2Ts7Aezj8Ruo+LFlNzfunRaSUp86gCsQsmRKdyrr5MD6KrjImRMw
         YCXxxvItVnBxU8pi0epLJV+PqybCsNzEAajM2JYsk9BrpEiCi5af/Y6tBRIu5cqwE2Nj
         86Wd3FDBZAKpH6Act80ak26x4+nPl1/IIwDaJpdrNhZ4YFwMiwgYKLPhzPUy59f4hF01
         qHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UGdoXYx+0lSklI6VQsXVIjkHXSi/rQA74r52KfDEris=;
        b=PTpRY/Sa6v4+AxK7zqLl165OviG7m2ozCA11BznrvUwyLfCxqml6hoGeYAys443v+T
         AO8eonDK5dUyqJlFKM0lWurPMYTOoA24zM+0jKXoXBTtDSBFZwoJJ1W2M0HpP3nE/KXt
         7O9bRs5902Llzb/m5YGBkvw8zQ5lRGRoINygnRu7MXsasKqvvTsNuou4WWOpXxbHy3+G
         ZPCkgPUsa7j5sVUoAEn2H5a9Xc9JuwIhRjjgyZMY8XrnMRxFjDNmXYlkZCIGq4OJ8IVt
         3jcw/A2EfMWtwJrTpy8okPKo2sfakV6A91Z7eBb3K1n/w0+US2lqNMXDWdWuiCqNsXW7
         F4EA==
X-Gm-Message-State: AA6/9Rkx/yNp4a9636L+HjXJeu9l43SMPQyUWYoxuepfRJzNmlti19DFJ1Kjdhq7DiM0rxtfCmIXeFzTTvf2Lw==
X-Received: by 10.31.221.65 with SMTP id u62mr5313301vkg.71.1475650762739;
 Tue, 04 Oct 2016 23:59:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.180.138 with HTTP; Tue, 4 Oct 2016 23:59:02 -0700 (PDT)
In-Reply-To: <332f9438-ef25-b972-77f0-d46be3ec349d@baylibre.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock> <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
 <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
 <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com> <CAGm1_kvAtXf1GPF93U3VMBoHO_Fmc2rANxoNHwcF2-VuerA7pQ@mail.gmail.com>
 <332f9438-ef25-b972-77f0-d46be3ec349d@baylibre.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Wed, 5 Oct 2016 08:59:02 +0200
Message-ID: <CAGm1_kvacdG_28k3e2X0EDK3YG4RD08-ShPXWjSvD0JZZr4z1A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Alban <albeu@free.fr>, ralf@linux-mips.org,
        linux-mips <linux-mips@linux-mips.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yegorslists@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegorslists@googlemail.com
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

Hi Neil,

On Tue, Oct 4, 2016 at 12:21 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 10/04/2016 12:14 PM, Yegor Yefremov wrote:
>> On Tue, Oct 4, 2016 at 12:11 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> On 10/04/2016 12:09 PM, Yegor Yefremov wrote:
>>>> Hi Neil,
>>>>
>>>> On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>> On 10/04/2016 11:09 AM, Alban wrote:
>>>>>> On Mon,  3 Oct 2016 17:35:31 +0200
>>>>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>>
>>>>>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
>>>>>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>>>>>>
>>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>>
>>>>>> Please use device tree instead of adding another board file.
>>>>>>
>>>>>> Alban
>>>>>>
>>>>>
>>>>> Hi Alban,
>>>>>
>>>>> I'm quite surprised since it seems no device tree support is available for ath79,
>>>>> I would really like to have device tree for this board, but this is only a copy/paste of
>>>>> the mach-ap121 with button/leds gpio differences.
>>>>>
>>>>> Could it be possible to merge it ? I would be happy to support this board once device tree
>>>>> support is landed on the mips tree !
>>>>
>>>> Take a look at these DTS files from the current Linux tree:
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
>>>>
>>>> etc.
>>>>
>>>> Regards,
>>>> Yegor
>>>>
>>>
>>> My bad, the qca naming is really disturbing.
>>>
>>> I will push a dts instead.
>>
>> Are you also going to submit driver for the network controller? This
>> is almost the last missing component for this SoC.
>>
>> Yegor
>>
>
> Hi Yegor,
>
> I'm not sure I have the right knowledge to push this, but what is the status of the OpenWrt driver ?

AFAIK LEDE project is using Linux 4.4. So that ath79 based devices are
only available in the form of board files. But converting them to DTS
is on LEDE's agenda. So perhaps then the networking driver will be
converted too. See https://www.lede-project.org/todo.html

Yegor
