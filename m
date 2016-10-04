Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 12:09:34 +0200 (CEST)
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35630 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992168AbcJDKJ0UxHmq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 12:09:26 +0200
Received: by mail-vk0-f66.google.com with SMTP id 192so7211899vkl.2;
        Tue, 04 Oct 2016 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UUhqba/n7Kee5OZ4d7uIgLrqZQUSmL+j71sCg5nZcrU=;
        b=N0NSdCvW9w0sPxxdc1MpS+19/cLDmbN7wtS8yf+jgOF8iV+IdooKTFXNedDDUC7/In
         kiL1vVSoBqpZxJeVzyflKlI6UK0gVT0YScP8/MJ6aY3yRKEpxHLvfBHNac5VX5CT090V
         81E8t8ffJXiyK8txaEdCS8e8vkzru/Ce6AJ1jcHTxsY0ll+btt7bAVbRzvutJUkVzf55
         EUIHSsdwYdUug8VBzCVBNvjE5Qhy6tg4LPB+TkjeTKKKaK/oAQITbHoeoumExX/YlKHe
         pXJci/V3W/bib4v39I/xpg9MlJExWoeqipClUGtfoX+eZYO+atuGy2r1+vCmuPaWWWJX
         bgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UUhqba/n7Kee5OZ4d7uIgLrqZQUSmL+j71sCg5nZcrU=;
        b=Kf0TSwnsw9Xt8F/tIQAHiFkMnK+i0W2fEiY68phoZqNBoN9a3ddGVn60lTdCPIUnRB
         gH+Z7hGSpl5S5CqvHa4mBCJUsz6CC/3AdyhQyV9HmGnWbrLh2AO/HJe9PGXPjbjPU7aw
         j8wEiNB00d1Lxa3wTBD8tS95zLs8haFvJlSsPfYzPMoQS6p5CsRa5Dbx+AxZe5yTEWS3
         O2Yj1o21vUocJ20oXwFGk0w84cAU9loMRQs/O3e2YqeC1HJNNylHG/Y0oHoqWbTMxnen
         jD6CTJ5xp/7GhCb/dlnx+WWktlALNaPUNXu7Pix+zeo2S5rel5dIR7rUskmf8YCNjxSD
         j17w==
X-Gm-Message-State: AA6/9RnkK0rDnKwQ37vd13SEYv+8Sb9fpTg5xLfh1SEod9z83ZvwUBSaU+Kd2du6aD3jaaGuksx2pMZQxjVaBA==
X-Received: by 10.31.153.17 with SMTP id b17mr1517211vke.84.1475575760493;
 Tue, 04 Oct 2016 03:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.180.138 with HTTP; Tue, 4 Oct 2016 03:09:00 -0700 (PDT)
In-Reply-To: <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock> <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Tue, 4 Oct 2016 12:09:00 +0200
Message-ID: <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
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
X-archive-position: 55317
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

On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 10/04/2016 11:09 AM, Alban wrote:
>> On Mon,  3 Oct 2016 17:35:31 +0200
>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>>
>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Please use device tree instead of adding another board file.
>>
>> Alban
>>
>
> Hi Alban,
>
> I'm quite surprised since it seems no device tree support is available for ath79,
> I would really like to have device tree for this board, but this is only a copy/paste of
> the mach-ap121 with button/leds gpio differences.
>
> Could it be possible to merge it ? I would be happy to support this board once device tree
> support is landed on the mips tree !

Take a look at these DTS files from the current Linux tree:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts

etc.

Regards,
Yegor
