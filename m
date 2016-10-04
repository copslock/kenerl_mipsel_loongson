Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 12:14:52 +0200 (CEST)
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35139 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992168AbcJDKOonp9mq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 12:14:44 +0200
Received: by mail-vk0-f66.google.com with SMTP id 192so7216440vkl.2;
        Tue, 04 Oct 2016 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+j5nWWECG0VNBLASUrUqo1GqCdT0hh+3q+YXBIsx28c=;
        b=DDZjbMtPmiK4MYKW2cQsMbC1neiwgKRZQtTKZcLr9fLtrrb8wHT71oRRGkphGytW4D
         Bvp/38NCZ0T3HAQTlDRthgh2Jl2m2hgQpDhQAKHnuNn8QuW2Jps9Iv/3nA4uNrhnQ318
         TB8PjT2hD/5ghjqZ+n/P8eiQkTtVUg0tlxzaT+CaBctaV+g4L+BNdCXM7NGyXMAug8cP
         SSi3HnGAi2yqEwLuivnC3hn3sObWXMsnSqvjEEZxe+LRGt3/wzJEn4RdGEwoyBEug1+0
         yYQ044E4zlEw3rv9c9qAxX6YrTSBMu7VD5d+UTYKn9WaBYrjWa6DJqk39fvIaoSbzAaf
         j9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+j5nWWECG0VNBLASUrUqo1GqCdT0hh+3q+YXBIsx28c=;
        b=JskmtZUTDIgKs7RuiDFdUj71rYdBbmyidqlgHy8+XZ0CLRfq8VxpHniWtOtY0BVUwo
         W4i49H7BjTHWnM9nw1oMNNJ9TiIowNyVB1kdZr9qw2w/Gw8gsHqnQ5sAl7gNgBPRv5Oo
         lTX3mCRQ+auRGVnXpvS/uKGPlPCvbfKlghbVf7U4HTdY6XSYYxYModavDrGIvQU7drZc
         rW4D4+KWwqdNkGymv4p+fRWTkTYWWsO5FmSRG/jhFuFAIKC14MGQpg5WznmbwyRRZ4Ec
         MKA4Zk3j78IMgp9Sg0ALQ0QqfBsqwbCVds2qzftpkHNlzlo3y53/FWxSevf6OcEGf3s1
         tuNw==
X-Gm-Message-State: AA6/9RmVlwgi5MAuNjBKgXlpbm9kPbwQhIIuPoqHMnOAwMUp3+jfMkd66huDo+e16JqOGwWY4nOrcdBAICjzsg==
X-Received: by 10.31.242.130 with SMTP id q124mr1252549vkh.134.1475576079164;
 Tue, 04 Oct 2016 03:14:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.180.138 with HTTP; Tue, 4 Oct 2016 03:14:18 -0700 (PDT)
In-Reply-To: <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock> <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
 <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com> <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 4 Oct 2016 12:14:18 +0200
Message-ID: <CAGm1_kvAtXf1GPF93U3VMBoHO_Fmc2rANxoNHwcF2-VuerA7pQ@mail.gmail.com>
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
X-archive-position: 55319
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

On Tue, Oct 4, 2016 at 12:11 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 10/04/2016 12:09 PM, Yegor Yefremov wrote:
>> Hi Neil,
>>
>> On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> On 10/04/2016 11:09 AM, Alban wrote:
>>>> On Mon,  3 Oct 2016 17:35:31 +0200
>>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
>>>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>
>>>> Please use device tree instead of adding another board file.
>>>>
>>>> Alban
>>>>
>>>
>>> Hi Alban,
>>>
>>> I'm quite surprised since it seems no device tree support is available for ath79,
>>> I would really like to have device tree for this board, but this is only a copy/paste of
>>> the mach-ap121 with button/leds gpio differences.
>>>
>>> Could it be possible to merge it ? I would be happy to support this board once device tree
>>> support is landed on the mips tree !
>>
>> Take a look at these DTS files from the current Linux tree:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
>>
>> etc.
>>
>> Regards,
>> Yegor
>>
>
> My bad, the qca naming is really disturbing.
>
> I will push a dts instead.

Are you also going to submit driver for the network controller? This
is almost the last missing component for this SoC.

Yegor
